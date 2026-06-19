REMOTE := barrett@192.168.68.84
PLUGIN_LOCAL  := foundry-mcp-plugin/
PLUGIN_REMOTE := /home/barrett/foundry/data/Data/modules/foundry-mcp-plugin/
SERVER_LOCAL  := mcp-server/
SERVER_REMOTE := /home/barrett/FoundryVTT-mcp-server-Plugin/mcp-server/

.PHONY: sync sync-plugin sync-server watch

sync: sync-plugin sync-server

sync-plugin:
	rsync -av --delete $(PLUGIN_LOCAL) $(REMOTE):$(PLUGIN_REMOTE)

sync-server:
	rsync -av --exclude='node_modules' $(SERVER_LOCAL) $(REMOTE):$(SERVER_REMOTE)
	ssh $(REMOTE) "docker restart foundry-mcp"

watch:
	fswatch -o $(PLUGIN_LOCAL) $(SERVER_LOCAL) | xargs -n1 -I{} $(MAKE) sync

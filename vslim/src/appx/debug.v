module appx

import logger

pub fn (app &VSlimApp) sync_cli_debug_config() {
	if app == unsafe { nil } || app.config_ref == unsafe { nil } {
		return
	}
	logger.cli_debug_sync_from_config(app.config_ref)
}

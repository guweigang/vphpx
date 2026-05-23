module appx

import loggerx

pub fn (app &VSlimApp) sync_cli_debug_config() {
	if app == unsafe { nil } || app.config_ref == unsafe { nil } {
		return
	}
	loggerx.cli_debug_sync_from_config(app.config_ref)
}

module appx

import loggerx
import routex
import supportx

pub fn (mut app VSlimApp) cleanup() {
	supportx.release_bootstrap_progress(mut app.bootstrap_progress)
	app.release_bootstrap_inputs()
	loggerx.cli_debug_log('app.cleanup automatic entry app=${usize(app)}')
	// Direct bridge-owned fields on VSlimApp are automatically released by
	// generic_free_raw() later in the destruction pipeline. We only manually
	// release bridge refs that are nested inside custom V structs, because the
	// current reflection pass does not recurse into those containers.
	unsafe {
		routex.release_owned_routes(mut app.routes)
		routex.release_owned_routes(mut app.websocket_routes)
		app.group_before_middle.release_owned_refs()
		app.group_middle.release_owned_refs()
		app.group_after_middle.release_owned_refs()

		$if nongc ? {
			app.base_path.free()
			app.routes.free()
			app.route_index.release()
			app.websocket_routes.free()
			app.websocket_conn_route.free()
			app.group_before_middle.prefixes.free()
			app.group_before_middle.handlers.free()
			app.group_middle.prefixes.free()
			app.group_middle.handlers.free()
			app.group_after_middle.prefixes.free()
			app.group_after_middle.handlers.free()
			app.provider_classes.free()
			app.module_classes.free()
			app.bootstrap_boot_stages.free()
		}
	}
	loggerx.cli_debug_log('app.cleanup native collections done')
}

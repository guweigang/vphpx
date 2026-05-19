module main

fn (mut route VSlimRoute) release_owned_refs() {
	if route.handler_ref.is_valid() {
		mut handler := route.handler_ref
		handler.release()
	}
	if route.resource_missing_handler.is_valid() {
		mut handler := route.resource_missing_handler
		handler.release()
	}
}

fn (mut table HookTable) release_owned_refs() {
	for mut handler in table.handlers {
		if handler.is_valid() {
			handler.release()
		}
	}
}

pub fn (mut app VSlimApp) cleanup() {
	cli_debug_log('app.cleanup automatic entry app=${usize(app)}')
	// Direct bridge-owned fields on VSlimApp are automatically released by
	// generic_free_raw() later in the destruction pipeline. We only manually
	// release bridge refs that are nested inside custom V structs, because the
	// current reflection pass does not recurse into those containers.
	unsafe {
		for mut route in app.routes {
			route.release_owned_refs()
		}
		for mut route in app.websocket_routes {
			route.release_owned_refs()
		}
		app.group_before_middle.release_owned_refs()
		app.group_middle.release_owned_refs()
		app.group_after_middle.release_owned_refs()

		$if nongc ? {
			app.base_path.free()
			app.routes.free()
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
		}
	}
	cli_debug_log('app.cleanup native collections done')
}

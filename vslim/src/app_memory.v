module main

fn release_route_owned_refs(mut route VSlimRoute) {
	if route.php_handler.is_valid() {
		mut handler := route.php_handler
		handler.release()
	}
	if route.resource_missing_handler.is_valid() {
		mut handler := route.resource_missing_handler
		handler.release()
	}
}

fn release_hook_table_owned_refs(mut table HookTable) {
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
			release_route_owned_refs(mut route)
		}
		for mut route in app.websocket_routes {
			release_route_owned_refs(mut route)
		}
		release_hook_table_owned_refs(mut app.php_group_before_middle)
		release_hook_table_owned_refs(mut app.php_group_middle)
		release_hook_table_owned_refs(mut app.php_group_after_middle)

		app.base_path.free()
		app.routes.free()
		app.websocket_routes.free()
		app.websocket_conn_route.free()
		app.php_group_before_middle.prefixes.free()
		app.php_group_middle.prefixes.free()
		app.php_group_after_middle.prefixes.free()
		app.provider_classes.free()
		app.module_classes.free()
	}
	cli_debug_log('app.cleanup native collections done')
}

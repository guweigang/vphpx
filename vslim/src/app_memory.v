module main

fn (app &VSlimApp) free() {
	cli_debug_log('app.free enter app=${usize(app)} routes=${app.routes.len} ws_routes=${app.websocket_routes.len} providers=${app.providers.len} modules=${app.modules.len} helpers=${app.view_helpers.len}')
	cli_debug_log('app.free release terminal handlers begin app=${usize(app)}')
	mut nf := app.not_found_handler
	nf.release()
	mut eh := app.error_handler
	eh.release()
	mut clock := app.clock_ref
	clock.release()
	cli_debug_log('app.free release terminal handlers done app=${usize(app)}')
	unsafe {
		app.base_path.free()
		app.routes.free()
		app.websocket_routes.free()
		app.websocket_conn_route.free()
		app.php_before_middlewares.free()
		app.php_middlewares.free()
		app.php_after_middlewares.free()
		app.php_group_before_middle.prefixes.free()
		app.php_group_before_middle.handlers.free()
		app.php_group_middle.prefixes.free()
		app.php_group_middle.handlers.free()
		app.php_group_after_middle.prefixes.free()
		app.php_group_after_middle.handlers.free()
		app.view_helpers.free()
		app.providers.free()
		app.provider_classes.free()
		app.modules.free()
		app.module_classes.free()
	}
	cli_debug_log('app.free release collections done app=${usize(app)}')
	cli_debug_log('app.free exit app=${usize(app)}')
}

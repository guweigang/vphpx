module main

fn (app &VSlimApp) free() {
	cli_debug_log('app.free enter app=${usize(app)} routes=${app.routes.len} ws_routes=${app.websocket_routes.len} providers=${app.providers.len} modules=${app.modules.len} helpers=${app.view_helpers.len}')
	for i in 0 .. app.php_middlewares.len {
		mut z := app.php_middlewares[i]
		z.release()
	}
	for i in 0 .. app.php_before_middlewares.len {
		mut z := app.php_before_middlewares[i]
		z.release()
	}
	for i in 0 .. app.php_after_middlewares.len {
		mut z := app.php_after_middlewares[i]
		z.release()
	}
	for i in 0 .. app.php_group_middle.prefixes.len {
		if i < app.php_group_middle.handlers.len {
			mut z := app.php_group_middle.handlers[i]
			z.release()
		}
	}
	for i in 0 .. app.php_group_before_middle.prefixes.len {
		if i < app.php_group_before_middle.handlers.len {
			mut z := app.php_group_before_middle.handlers[i]
			z.release()
		}
	}
	for i in 0 .. app.php_group_after_middle.prefixes.len {
		if i < app.php_group_after_middle.handlers.len {
			mut z := app.php_group_after_middle.handlers[i]
			z.release()
		}
	}
	for i in 0 .. app.routes.len {
		unsafe {
			app.routes[i].method.free()
			app.routes[i].name.free()
			app.routes[i].pattern.free()
		}
		mut z := app.routes[i].php_handler
		z.release()
	}
	for i in 0 .. app.websocket_routes.len {
		unsafe {
			app.websocket_routes[i].method.free()
			app.websocket_routes[i].name.free()
			app.websocket_routes[i].pattern.free()
		}
		mut z := app.websocket_routes[i].php_handler
		z.release()
	}
	mut nf := app.not_found_handler
	nf.release()
	mut eh := app.error_handler
	eh.release()
	mut clock := app.clock_ref
	clock.release()
	for provider in app.providers {
		mut owned := provider
		owned.release()
	}
	for mod_ref in app.modules {
		mut owned := mod_ref
		owned.release()
	}
	for key, _ in app.view_helpers {
		mut handler := app.view_helpers[key] or { continue }
		release_view_helper(mut handler)
	}
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
	cli_debug_log('app.free exit app=${usize(app)}')
}

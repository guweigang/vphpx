module appx

import registrationx
import configx as cfgx
import containerx
import routex
import viewx
import vphp

fn (mut app VSlimApp) track_container_replacement() {
	mut scope := registrationx.current_registration_scope() or { return }
	if !scope.needs_snapshot(usize(&app.container_ref)) {
		return
	}
	receiver := &app
	saved := app.container_ref
	mut pin := vphp.PhpValue.invalid()
	if saved != unsafe { nil } {
		mut value := vphp.bind_borrowed_object_value[containerx.VSlimContainer](saved)
		pin = value.retain()
		value.release()
	}
	scope.add_change(fn [receiver, saved, mut pin] (commit bool) {
		if !commit {
			mut target := receiver
			target.restore_container(saved)
		}
		pin.release()
	})
}

fn (mut app VSlimApp) restore_container(container &containerx.VSlimContainer) {
	// Service registrations are restored by their own changes in the scope.
	app.container_ref = container
}

fn (mut app VSlimApp) track_config_binding() {
	mut scope := registrationx.current_registration_scope() or { return }
	if !scope.needs_snapshot(usize(&app.config_ref)) {
		return
	}
	receiver := &app
	saved := app.config_ref
	redirect := app.auth_redirect_path.clone()
	mut pin := vphp.PhpValue.invalid()
	if saved != unsafe { nil } {
		mut value := vphp.bind_borrowed_object_value[cfgx.VSlimConfig](saved)
		pin = value.retain()
		value.release()
	}
	scope.add_change(fn [receiver, saved, redirect, mut pin] (commit bool) {
		if !commit {
			mut target := receiver
			target.restore_config_binding(saved, redirect)
		}
		pin.release()
	})
}

fn (mut app VSlimApp) restore_config_binding(config &cfgx.VSlimConfig, redirect string) {
	app.config_ref = config
	app.auth_redirect_path = redirect
}

struct AppViewSettings {
	base_path string
	view_base_path string
	assets_prefix string
	cache_enabled bool
	cache_configured bool
}

fn (mut app VSlimApp) track_view_settings() {
	mut scope := registrationx.current_registration_scope() or { return }
	if !scope.needs_snapshot(usize(&app.view_base_path)) {
		return
	}
	receiver := &app
	saved := AppViewSettings{
		base_path: app.base_path.clone()
		view_base_path: app.view_base_path.clone()
		assets_prefix: app.assets_prefix.clone()
		cache_enabled: app.view_cache_enabled
		cache_configured: app.view_cache_configured
	}
	scope.add_change(fn [receiver, saved] (commit bool) {
		if !commit {
			mut target := receiver
			target.restore_view_settings(saved)
		}
	})
}

fn (mut app VSlimApp) restore_view_settings(saved AppViewSettings) {
	app.base_path = saved.base_path
	app.view_base_path = saved.view_base_path
	app.assets_prefix = saved.assets_prefix
	app.view_cache_enabled = saved.cache_enabled
	app.view_cache_configured = saved.cache_configured
}

fn (mut app VSlimApp) track_view_helper(key string) {
	mut scope := registrationx.current_registration_scope() or { return }
	receiver := &app
	name := key.clone()
	mut saved := if existing := app.view_helpers[key] { existing.retain() } else { vphp.PhpCallable.invalid() }
	scope.add_change(fn [receiver, name, mut saved] (commit bool) {
		if !commit {
			mut target := receiver
			target.restore_view_helper(name, saved)
		}
		saved.release()
	})
}

fn (mut app VSlimApp) restore_view_helper(name string, saved vphp.PhpCallable) {
	if saved.is_valid() {
		viewx.register_view_helper(mut app.view_helpers, name, saved)
	} else if mut current := app.view_helpers[name] {
		app.view_helpers.delete(name)
		current.release()
	}
}

struct AppRegistrationLengths {
	routes       int
	websockets   int
	before       int
	middleware   int
	after        int
	group_before int
	group_middle int
	group_after  int
}

fn (mut app VSlimApp) track_registration() {
	mut scope := registrationx.current_registration_scope() or { return }
	if !scope.needs_snapshot(usize(&app)) {
		return
	}
	receiver := &app
	lengths := AppRegistrationLengths{
		routes:       app.routes.len
		websockets:   app.websocket_routes.len
		before:       app.before_middlewares.len
		middleware:   app.middlewares.len
		after:        app.after_middlewares.len
		group_before: app.group_before_middle.handlers.len
		group_middle: app.group_middle.handlers.len
		group_after:  app.group_after_middle.handlers.len
	}
	scope.add_change(fn [receiver, lengths] (commit bool) {
		if !commit {
			mut target := receiver
			target.rollback_registration(lengths)
		}
	})
}

fn (mut app VSlimApp) rollback_registration(lengths AppRegistrationLengths) {
	app.route_index.trim(lengths.routes)
	trim_registered_routes(mut app.routes, lengths.routes)
	if app.websocket_routes.len > lengths.websockets {
		trim_registered_routes(mut app.websocket_routes, lengths.websockets)
		for id in app.websocket_conn_route.keys() {
			if app.websocket_conn_route[id] >= lengths.websockets {
				app.websocket_conn_route.delete(id)
			}
		}
	}
	trim_registered_hooks(mut app.before_middlewares, lengths.before)
	trim_registered_hooks(mut app.middlewares, lengths.middleware)
	trim_registered_hooks(mut app.after_middlewares, lengths.after)
	trim_registered_group(mut app.group_before_middle, lengths.group_before)
	trim_registered_group(mut app.group_middle, lengths.group_middle)
	trim_registered_group(mut app.group_after_middle, lengths.group_after)
}

fn trim_registered_routes(mut routes []routex.VSlimRoute, length int) {
	for i := routes.len - 1; i >= length; i-- {
		mut route := routes[i]
		routes.trim(i)
		route.release_owned_refs()
	}
}

fn trim_registered_hooks(mut hooks []vphp.PhpValue, length int) {
	for i := hooks.len - 1; i >= length; i-- {
		mut handler := hooks[i]
		hooks.trim(i)
		handler.release()
	}
}

fn trim_registered_group(mut table routex.HookTable, length int) {
	table.prefixes.trim(length)
	trim_registered_hooks(mut table.handlers, length)
}

fn (mut app VSlimApp) track_component_registration() {
	mut scope := registrationx.current_registration_scope() or { return }
	if !scope.needs_snapshot(usize(&app.provider_classes)) {
		return
	}
	receiver := &app
	providers := app.providers.len
	modules := app.modules.len
	mut provider_classes := app.provider_classes.clone()
	mut module_classes := app.module_classes.clone()
	scope.add_change(fn [receiver, providers, modules, mut provider_classes, mut module_classes] (commit bool) {
		mut target := receiver
		if !commit {
			target.restore_component_registration(providers, modules, mut provider_classes, mut module_classes)
		}
		unsafe {
			provider_classes.free()
			module_classes.free()
		}
	})
}

fn (mut app VSlimApp) restore_component_registration(providers int, modules int, mut provider_classes map[string]bool, mut module_classes map[string]bool) {
	trim_registered_components(mut app.providers, providers)
	trim_registered_components(mut app.modules, modules)
	unsafe {
		provider_classes, app.provider_classes = app.provider_classes, provider_classes
		module_classes, app.module_classes = app.module_classes, module_classes
	}
}

fn trim_registered_components(mut components []vphp.PhpObject, length int) {
	for i := components.len - 1; i >= length; i-- {
		mut component := components[i]
		components.trim(i)
		component.release()
	}
}

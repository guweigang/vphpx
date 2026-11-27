module appx

import loggerx
import middlewarex
import routex
import supportx
import vphp

fn (mut app VSlimApp) register_middleware_kind(handler vphp.PhpValue, kind middlewarex.MiddlewareRegistrationKind) {
	if !middlewarex.supports_registration(kind, handler) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			middlewarex.registration_error(kind), 0)
		return
	}
	if handler.is_object() {
		(&app).bind_cached_target_if_supported(handler)
	}
	if vphp.has_exception() {
		return
	}
	app.track_registration()
	if kind == .standard && app.middlewares.len == 0 {
		loggerx.cli_debug_log('middleware.register kind=${handler.kind_name()} valid=${handler.is_valid()} null=${handler.is_null()} undef=${handler.is_undef()} handler_type=${handler.type_name()} handler_class=${handler.class_name()}')
	}
	match kind {
		.standard {
			app.middlewares << app.store_registration_value(.middleware, app.middlewares.len, handler)
		}
		.before {
			app.before_middlewares << app.store_registration_value(.before, app.before_middlewares.len, handler)
		}
		.after {
			app.after_middlewares << app.store_registration_value(.after, app.after_middlewares.len, handler)
		}
	}
}

fn (mut app VSlimApp) register_group_middleware_kind(prefix string, handler vphp.PhpValue, kind middlewarex.MiddlewareRegistrationKind) {
	if !middlewarex.supports_registration(kind, handler) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			middlewarex.registration_error(kind), 0)
		return
	}
	clean_prefix := routex.normalize_group_prefix(prefix)
	if handler.is_object() {
		app.bind_cached_target_if_supported(handler)
	}
	if vphp.has_exception() {
		return
	}
	app.track_registration()
	match kind {
		.standard {
			app.group_middle.prefixes << clean_prefix
			app.group_middle.handlers << app.store_registration_value(.group_middle,
				app.group_middle.handlers.len, handler)
		}
		.before {
			app.group_before_middle.prefixes << clean_prefix
			app.group_before_middle.handlers << app.store_registration_value(.group_before,
				app.group_before_middle.handlers.len, handler)
		}
		.after {
			app.group_after_middle.prefixes << clean_prefix
			app.group_after_middle.handlers << app.store_registration_value(.group_after,
				app.group_after_middle.handlers.len, handler)
		}
	}
}

pub fn (mut app VSlimApp) group_middleware(prefix string, handler vphp.PhpValue) &VSlimApp {
	return app.group_middleware_at_phase(prefix, handler, .standard)
}

@[params]
pub struct GroupMiddlewareOptions {
pub:
	phase middlewarex.MiddlewareRegistrationKind = .standard
}

@[vphp.PhpExportMethod(name: 'groupMiddleware')]
pub fn (mut app VSlimApp) export_group_middleware(prefix string, handler vphp.PhpValue, options GroupMiddlewareOptions) &VSlimApp {
	return app.group_middleware_at_phase(prefix, handler, options.phase)
}

pub fn (mut app VSlimApp) group_middleware_at_phase(prefix string, handler vphp.PhpValue, phase middlewarex.MiddlewareRegistrationKind) &VSlimApp {
	app.register_group_middleware_kind(prefix, handler, phase)
	return app
}

@[vphp.PhpExportMethod(name: 'groupBefore')]
pub fn (mut app VSlimApp) group_before(prefix string, handler vphp.PhpValue) &VSlimApp {
	return app.group_middleware_at_phase(prefix, handler, .before)
}

@[vphp.PhpExportMethod(name: 'groupAfter')]
pub fn (mut app VSlimApp) group_after(prefix string, handler vphp.PhpValue) &VSlimApp {
	return app.group_middleware_at_phase(prefix, handler, .after)
}

fn (app &VSlimApp) bind_cached_target_if_supported(target vphp.PhpValue) {
	if !target.is_valid() || !target.is_object() {
		return
	}
	mut app_value := app.self_value()
	defer {
		app_value.release()
	}
	supportx.bind_to_app(target, app_value)
}

fn release_collected_middlewares(mut hooks []vphp.PhpValue) {
	middlewarex.release_hooks(mut hooks)
}

fn (app &VSlimApp) collect_standard_middlewares(group_hooks []vphp.PhpValue) []vphp.PhpValue {
	return app.collect_registered_middlewares(.middleware, app.middlewares, group_hooks)
}

fn (app &VSlimApp) collect_before_middlewares(group_hooks []vphp.PhpValue) []vphp.PhpValue {
	return app.collect_registered_middlewares(.before, app.before_middlewares, group_hooks)
}

fn (app &VSlimApp) collect_after_middlewares(group_hooks []vphp.PhpValue) []vphp.PhpValue {
	return app.collect_registered_middlewares(.after, app.after_middlewares, group_hooks)
}

fn (app &VSlimApp) collect_registered_middlewares(bucket RegistrationValues, registered []vphp.PhpValue, group_hooks []vphp.PhpValue) []vphp.PhpValue {
	// Resolve the PHP-backed slots before the request snapshots the hooks.
	mut handlers := []vphp.PhpValue{cap: registered.len}
	for index, fallback in registered {
		handlers << app.registration_value(bucket, index, fallback)
	}
	defer {
		unsafe { handlers.free() }
	}
	if bucket == .middleware {
		return middlewarex.clone_standard_hooks(handlers, group_hooks)
	}
	return middlewarex.clone_combined_hooks(handlers, group_hooks)
}

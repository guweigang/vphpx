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
	entry := handler.retain()
	if kind == .standard && app.middlewares.len == 0 {
		loggerx.cli_debug_log('middleware.register kind=${entry.kind_name()} valid=${entry.is_valid()} null=${entry.is_null()} undef=${entry.is_undef()} handler_type=${handler.type_name()} handler_class=${handler.class_name()}')
	}
	match kind {
		.standard { app.middlewares << entry }
		.before { app.before_middlewares << entry }
		.after { app.after_middlewares << entry }
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
	match kind {
		.standard {
			app.group_middle.prefixes << clean_prefix
			app.group_middle.handlers << handler.retain()
		}
		.before {
			app.group_before_middle.prefixes << clean_prefix
			app.group_before_middle.handlers << handler.retain()
		}
		.after {
			app.group_after_middle.prefixes << clean_prefix
			app.group_after_middle.handlers << handler.retain()
		}
	}
}

@[php_method: 'groupMiddleware']
pub fn (mut app VSlimApp) group_middleware(prefix string, handler vphp.PhpValue) &VSlimApp {
	app.register_group_middleware_kind(prefix, handler, .standard)
	return app
}

@[php_method: 'groupBefore']
pub fn (mut app VSlimApp) group_before(prefix string, handler vphp.PhpValue) &VSlimApp {
	app.register_group_middleware_kind(prefix, handler, .before)
	return app
}

@[php_method: 'groupAfter']
pub fn (mut app VSlimApp) group_after(prefix string, handler vphp.PhpValue) &VSlimApp {
	app.register_group_middleware_kind(prefix, handler, .after)
	return app
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
	return middlewarex.clone_standard_hooks(app.middlewares, group_hooks)
}

fn (app &VSlimApp) collect_before_middlewares(group_hooks []vphp.PhpValue) []vphp.PhpValue {
	return middlewarex.clone_combined_hooks(app.before_middlewares, group_hooks)
}

fn (app &VSlimApp) collect_after_middlewares(group_hooks []vphp.PhpValue) []vphp.PhpValue {
	return middlewarex.clone_combined_hooks(app.after_middlewares, group_hooks)
}

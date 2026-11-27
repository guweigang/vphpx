module appx

import registrationx
import supportx
import vphp

fn (mut app VSlimApp) ensure_module_registry() {
	if app.module_classes.len == 0 {
		app.module_classes = map[string]bool{}
	}
}

enum AppComponentKind {
	provider
	module_
}

fn (kind AppComponentKind) label() string {
	return if kind == .module_ { 'module' } else { 'provider' }
}

fn (mut app VSlimApp) register_component_class(class_name string, kind AppComponentKind) ! {
	mut value := supportx.class_instance_value(class_name, kind.label())!
	defer {
		value.release()
	}
	app.register_component(value, kind)!
}

fn (mut app VSlimApp) register_components(values vphp.PhpIterable, kind AppComponentKind) ! {
	mut progress := supportx.BootstrapProgress{}
	app.register_bootstrap_components(values, kind, '', mut progress)!
}

fn (mut app VSlimApp) register_bootstrap_components(values vphp.PhpIterable, kind AppComponentKind, step string, mut progress supportx.BootstrapProgress) ! {
	mut normalized := progress.normalize_values(step + ':list', values)!
	defer {
		normalized.release()
	}
	if vphp.has_exception() {
		return error('${kind.label()} list evaluation failed')
	}
	for index, item in normalized.value_items() {
		item_step := '${step}:item:${index}'
		if progress.done(item_step) {
			continue
		}
		mut value := supportx.input_value(item, kind.label())!
		defer {
			value.release()
		}
		app.register_component(value, kind)!
		progress.complete(item_step)
	}
}

fn (mut app VSlimApp) register_component_batch(values vphp.PhpIterable, kind AppComponentKind) {
	app.register_components(values, kind) or {
		if !vphp.has_exception() {
			vphp.PhpException.raise_class('InvalidArgumentException', '${kind.label()}s must be iterable', 0)
		}
	}
}

fn (mut app VSlimApp) register_module_providers(obj vphp.PhpObject, app_value vphp.PhpValue) ! {
	mut result := supportx.module_provider_input(obj, app_value)!
	if !result.is_valid() {
		return
	}
	defer {
		result.release()
	}
	providers := result.borrowed().as_iterable() or {
		return error('failed to resolve module providers')
	}
	app.register_components(providers, .provider)!
}

enum ComponentBootStep {
	bind
	middleware
	routes
	boot
}

struct ComponentBootProgress {
mut:
	index int
	step  ComponentBootStep
}

fn boot_component(obj vphp.PhpObject, kind AppComponentKind, app_value vphp.PhpValue, mut progress ComponentBootProgress) ! {
	if progress.step == .bind {
		supportx.bind_lifecycle_object(obj, app_value)!
		progress.step = if kind == .module_ { .middleware } else { .boot }
	}
	if progress.step == .middleware {
		has_middleware := supportx.call_lifecycle_if_present(obj, 'middleware', app_value)!
		if !has_middleware {
			supportx.call_lifecycle_if_present(obj, 'middlewares', app_value)!
		}
		progress.step = .routes
	}
	if progress.step == .routes {
		supportx.call_lifecycle_if_present(obj, 'routes', app_value)!
		progress.step = .boot
	}
	supportx.call_lifecycle_if_present(obj, 'boot', app_value)!
}

fn (mut app VSlimApp) register_component(value vphp.PhpValue, kind AppComponentKind) ! {
	obj := value.require_object() or {
		return error('${kind.label()} class name must not be empty')
	}
	class_key := obj.class_name().trim_space()
	if class_key == '' {
		return error('${kind.label()} class name must not be empty')
	}
	match kind {
		.provider {
			app.ensure_provider_registry()
			if class_key in app.provider_classes {
				return
			}
		}
		.module_ {
			app.ensure_module_registry()
			if class_key in app.module_classes {
				return
			}
		}
	}

	state := app.watch_service_state()
	defer {
		state.close()
	}
	mut app_value := (&app).self_value()
	defer {
		app_value.release()
	}
	supportx.bind_lifecycle_object(obj, app_value)!
	supportx.call_lifecycle_if_present(obj, 'register', app_value)!
	match kind {
		.provider {
			app.track_component_registration()
			index := app.providers.len
			app.providers << obj.retain()
			app.provider_classes[class_key] = true
			if app.booted {
				supportx.call_lifecycle_if_present(obj, 'boot', app_value) or {
					mut failed := app.providers[index]
					app.providers.delete(index)
					app.provider_classes.delete(class_key)
					failed.release()
					return err
				}
			}
		}
		.module_ {
			app.register_module_providers(obj, app_value)!
			app.track_component_registration()
			index := app.modules.len
			app.modules << obj.retain()
			app.module_classes[class_key] = true
			if app.booted {
				mut progress := ComponentBootProgress{}
				boot_component(obj, kind, app_value, mut progress) or {
					mut failed := app.modules[index]
					app.modules.delete(index)
					app.module_classes.delete(class_key)
					failed.release()
					return err
				}
			}
		}
	}
}

@[vphp.PhpArgName(v_name: 'mod_input', php_name: 'modInput')]
@[vphp.PhpExportMethod(name: 'module')]
pub fn (mut app VSlimApp) mount_module(mod_input vphp.PhpValue) &VSlimApp {
	mut module_value := supportx.input_value(mod_input, 'module') or {
		raise_app_error('InvalidArgumentException', err)
		return &app
	}
	defer {
		module_value.release()
	}
	app.register_component(module_value, .module_) or {
		raise_app_error('RuntimeException', err)
		return &app
	}
	return &app
}

@[vphp.PhpExportMethod(name: 'moduleMany')]
pub fn (mut app VSlimApp) module_many(modules vphp.PhpIterable) &VSlimApp {
	app.register_component_batch(modules, .module_)
	return &app
}

@[vphp.PhpExportMethod(name: 'moduleCount')]
pub fn (app &VSlimApp) module_count() int {
	return app.modules.len
}

@[vphp.PhpArgName(v_name: 'class_name', php_name: 'className')]
@[vphp.PhpExportMethod(name: 'hasModule')]
pub fn (app &VSlimApp) has_module(class_name string) bool {
	return class_name.trim_space() in app.module_classes
}

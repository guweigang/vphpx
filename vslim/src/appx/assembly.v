module appx

import registrationx
import os
import configx as cfgx
import loggerx
import mcpx as mcp
import cachex
import containerx
import controllerx
import eventx
import httpx
import middlewarex
import supportx
import vphp

fn (mut app VSlimApp) bootstrap_file_apply(path string) ! {
	file := supportx.resolve_bootstrap_file(path, 'bootstrap')!
	app.apply_bootstrap_file(file)!
}

pub fn (mut app VSlimApp) apply_bootstrap_file(file supportx.BootstrapFile) ! {
	state := app.watch_service_state()
	defer {
		state.close()
	}
	source := 'file:' + os.real_path(file.resolved_path)
	mut progress := supportx.start_bootstrap_progress(mut app.bootstrap_progress, source)!
	defer {
		progress.stop()
	}
	if app.resume_bootstrap_boot(source)! {
		supportx.finish_bootstrap_progress(mut app.bootstrap_progress, source)
		return
	}
	if app.configure_bootstrap_file(file, mut progress)! {
		app.finish_bootstrap_boot(source)!
	} else {
		app.defer_bootstrap_boot(source)
	}
	supportx.finish_bootstrap_progress(mut app.bootstrap_progress, source)
}

pub fn (mut app VSlimApp) configure_bootstrap_file(file supportx.BootstrapFile, mut progress supportx.BootstrapProgress) !bool {
	mut result := progress.load_file(file)!
	defer {
		result.release()
	}
	receiver := &app
	mut spec := progress.evaluate_file_spec(result, 'VSlim\\App',
		supportx.bootstrap_file_return_error(file.path), fn [receiver] () vphp.PhpValue {
			return receiver.self_value()
		})!
	defer {
		spec.release()
	}
	if spec.is_valid() {
		return app.configure_bootstrap_spec_with_progress(spec, file.project_root, 'file', mut progress)
	}
	return false
}

fn (mut app VSlimApp) apply_bootstrap_container(spec vphp.PhpArray) ! {
	value := supportx.app_bootstrap_spec(spec).lookup(['container']) or { return }
	container := supportx.require_native_bootstrap_object[containerx.VSlimContainer](value,
		'VSlim\\Container', 'container')!
	app.set_container(container)
}

fn (mut app VSlimApp) apply_bootstrap_config(spec vphp.PhpArray) ! {
	if value := supportx.app_bootstrap_spec(spec).lookup(['config']) {
		config := supportx.require_native_bootstrap_object[cfgx.VSlimConfig](value,
			'VSlim\\Config', 'config')!
		app.set_config(config)
	}
	if config_path := supportx.app_bootstrap_spec(spec).string(['config_path', 'configPath',
		'config_file', 'configFile'])
	{
		app.load_config(config_path)
	}
	if config_text := supportx.app_bootstrap_spec(spec).string(['config_text', 'configText']) {
		app.load_config_text(config_text)
	}
}

fn (mut app VSlimApp) apply_bootstrap_runtime_flags(spec vphp.PhpArray) {
	if base_path := supportx.app_bootstrap_spec(spec).string(['base_path', 'basePath']) {
		app.set_base_path(base_path)
	}
	if view_base_path := supportx.app_bootstrap_spec(spec).string(['view_base_path', 'viewBasePath']) {
		app.set_view_base_path(view_base_path)
	}
	if assets_prefix := supportx.app_bootstrap_spec(spec).string(['assets_prefix', 'assetsPrefix']) {
		app.set_assets_prefix(assets_prefix)
	}
	if enabled := supportx.app_bootstrap_spec(spec).bool(['view_cache', 'viewCache']) {
		app.set_view_cache(enabled)
	}
	if enabled := supportx.app_bootstrap_spec(spec).bool(['error_response_json', 'errorResponseJson']) {
		app.set_error_response_json(enabled)
	}
}

fn (mut app VSlimApp) apply_bootstrap_services(spec vphp.PhpArray) ! {
	if value := supportx.app_bootstrap_spec(spec).lookup(['clock']) {
		if !supportx.psr20_is_clock(value) {
			return error('bootstrap clock must implement Psr\\Clock\\ClockInterface')
		}
		clock := value.as_object() or { return error('bootstrap clock must be an object') }
		app.set_clock(clock)
	}
	if value := supportx.app_bootstrap_spec(spec).lookup(['logger']) {
		log_writer := supportx.require_native_bootstrap_object[loggerx.VSlimLogger](value,
			'VSlim\\Log\\Logger', 'logger')!
		app.set_logger(log_writer)
	}
	if value := supportx.app_bootstrap_spec(spec).lookup(['listener_provider', 'listenerProvider']) {
		provider := supportx.require_native_bootstrap_object[eventx.VSlimPsr14ListenerProvider](value,
			'VSlim\\Psr14\\ListenerProvider', 'listener_provider')!
		app.set_listener_provider(provider)
	}
	if value := supportx.app_bootstrap_spec(spec).lookup(['dispatcher']) {
		dispatcher := supportx.require_native_bootstrap_object[eventx.VSlimPsr14EventDispatcher](value,
			'VSlim\\Psr14\\EventDispatcher', 'dispatcher')!
		app.set_dispatcher(dispatcher)
	}
	if value := supportx.app_bootstrap_spec(spec).lookup(['cache']) {
		cache := supportx.require_native_bootstrap_object[cachex.VSlimPsr16Cache](value,
			'VSlim\\Psr16\\Cache', 'cache')!
		app.set_cache(cache)
	}
	if value := supportx.app_bootstrap_spec(spec).lookup(['cache_pool', 'cachePool']) {
		pool := supportx.require_native_bootstrap_object[cachex.VSlimPsr6CacheItemPool](value,
			'VSlim\\Psr6\\CacheItemPool', 'cache_pool')!
		app.set_cache_pool(pool)
	}
	if value := supportx.app_bootstrap_spec(spec).lookup(['http_client', 'httpClient']) {
		client := supportx.require_native_bootstrap_object[httpx.VSlimPsr18Client](value,
			'VSlim\\Psr18\\Client', 'http_client')!
		app.set_http_client(client)
	}
	if value := supportx.app_bootstrap_spec(spec).lookup(['mcp']) {
		if value.is_callable() {
			mut app_value := (&app).self_value()
			defer {
				app_value.release()
			}
			app_value.with_object[bool](fn [value] (app_obj vphp.PhpObject) bool {
				return app_obj.with_method_result[vphp.PhpValue, bool]('mcp', fn [value] (mcp_value vphp.PhpValue) bool {
					callable := vphp.PhpCallable.from_value(value) or { return false }
					mut scope := registrationx.begin_registration_scope()
					defer {
						scope.finish()
					}
					callable.with_result[vphp.PhpValue, bool](fn (result vphp.PhpValue) bool {
						return result.is_valid()
					}, mcp_value) or { false }
					return true
				}) or { false }
			}) or { false }
		} else {
			server := supportx.require_native_bootstrap_object[mcp.VSlimMcpApp](value,
				'VSlim\\Mcp\\App', 'mcp')!
			app.set_mcp(server)
		}
	}
}

fn (mut app VSlimApp) apply_bootstrap_handlers(spec vphp.PhpArray) ! {
	if value := supportx.app_bootstrap_spec(spec).lookup(['not_found', 'notFound']) {
		callable := vphp.PhpCallable.from_value(value) or {
			return error('bootstrap not_found must be callable')
		}
		app.set_not_found_handler(callable)
	}
	if value := supportx.app_bootstrap_spec(spec).lookup(['error', 'error_handler', 'errorHandler']) {
		callable := vphp.PhpCallable.from_value(value) or {
			return error('bootstrap error handler must be callable')
		}
		app.set_error_handler(callable)
	}
}

fn (mut app VSlimApp) apply_bootstrap_helpers(spec vphp.PhpArray, step string, mut progress supportx.BootstrapProgress) ! {
	helpers := supportx.app_bootstrap_spec(spec).lookup(['helpers', 'view_helpers', 'viewHelpers']) or {
		return
	}
	iter := helpers.as_iterable() or { return error('bootstrap helpers must be iterable') }
	mut normalized := progress.normalize(step + ':list', iter)!
	defer {
		normalized.release()
	}
	for key in normalized.assoc_keys() {
		item_step := '${step}:item:${key}'
		if progress.done(item_step) {
			continue
		}
		handler := normalized.value_at(key)
		callable := vphp.PhpCallable.from_value(handler) or {
			return error('bootstrap helper "${key}" must be callable')
		}
		app.helper(key, callable)
		if vphp.has_exception() {
			return error('bootstrap helper registration failed')
		}
		progress.complete(item_step)
	}
}

fn (mut app VSlimApp) apply_bootstrap_middleware_stack(spec vphp.PhpArray, keys []string, kind middlewarex.MiddlewareRegistrationKind, label string, step string, mut progress supportx.BootstrapProgress) ! {
	value := supportx.app_bootstrap_spec(spec).lookup(keys) or { return }
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return error('bootstrap ${label} must not be null')
	}
	if value.is_string() || httpx.is_psr15_middleware_handler(value)
		|| supportx.is_bootstrap_callable_pair(value) {
		app.apply_bootstrap_middleware_item(kind, label, value)!
		return
	}
	iter := value.as_iterable() or {
		return error('bootstrap ${label} must be a middleware registration or list')
	}
	mut normalized := progress.normalize(step + ':list', iter)!
	defer {
		normalized.release()
	}
	for index, item in normalized.value_items() {
		item_step := '${step}:item:${index}'
		if progress.done(item_step) {
			continue
		}
		if !middlewarex.supports_registration(kind, item) {
			return error('bootstrap ${label} entries must be middleware registrations')
		}
		app.apply_bootstrap_middleware_item(kind, label, item)!
		progress.complete(item_step)
	}
}

fn (mut app VSlimApp) apply_bootstrap_middleware_item(kind middlewarex.MiddlewareRegistrationKind, label string, handler vphp.PhpValue) ! {
	if !middlewarex.supports_registration(kind, handler) {
		return error('bootstrap ${label} must contain valid middleware registrations')
	}
	match kind {
		.standard { app.middleware(handler) }
		.before { app.before(handler) }
		.after { app.after(handler) }
	}
	if vphp.has_exception() {
		return error('bootstrap ${label} registration failed')
	}
}

fn (mut app VSlimApp) apply_bootstrap_component_conventions(project_root string, kind AppComponentKind, files []string, mut progress supportx.BootstrapProgress) !bool {
	label := kind.label()
	plural := label + 's'
	config_path := supportx.join_path(project_root, 'bootstrap/${plural}.php')
	mut applied := false
	config_step := 'components:' + config_path
	if progress.done(config_step) {
		applied = true
	} else if supportx.is_file(config_path) {
		mut raw := progress.load(config_path)!
		defer {
			raw.release()
		}
		if vphp.has_exception() {
			return error('bootstrap ${plural} file evaluation failed')
		}
		values := raw.borrowed().as_iterable() or {
			return error('bootstrap ${plural} file "${config_path}" must return iterable ${plural}')
		}
		app.register_bootstrap_components(values, kind, config_step, mut progress)!
		progress.complete(config_step)
		applied = true
	}
	namespace := plural.capitalize()
	for file in files {
		step := 'component:' + file
		if progress.done(step) {
			applied = true
			continue
		}
		class_name := 'App\\${namespace}\\' + supportx.file_stem(file)
		if !supportx.class_exists(class_name) {
			return error('${label} convention file "${file}" must declare class ${class_name}')
		}
		app.register_component_class(class_name, kind)!
		progress.complete(step)
		applied = true
	}
	return applied
}

fn (mut app VSlimApp) apply_bootstrap_convention_http_classes(files supportx.BootstrapProjectFiles, mut progress supportx.BootstrapProgress) !bool {
	mut applied := false
	mut container := app.container()
	mut app_value := (&app).self_value()
	defer {
		app_value.release()
	}
	for file in files.controllers {
		step := 'controller:' + file
		if progress.done(step) {
			applied = true
			continue
		}
		class_name := 'App\\Http\\Controllers\\' + supportx.file_stem(file)
		if !supportx.class_exists(class_name) {
			return error('controller convention file "${file}" must declare class ${class_name}')
		}
		controllerx.register_convention_controller(mut container, class_name, app_value)!
		if vphp.has_exception() {
			return error('bootstrap controller registration failed')
		}
		progress.complete(step)
		applied = true
	}
	for file in files.middleware {
		class_name := 'App\\Http\\Middleware\\' + supportx.file_stem(file)
		if !supportx.class_exists(class_name) {
			return error('middleware convention file "${file}" must declare class ${class_name}')
		}
		applied = true
	}
	return applied
}

struct ProjectBootstrap {
	root   string
	source string
	resume BootstrapBootStage
}

fn (mut app VSlimApp) apply_bootstrap_convention_spec(project ProjectBootstrap, relative string, label string, stage BootstrapBootStage, mut progress supportx.BootstrapProgress) !bool {
	if int(project.resume) > int(stage) {
		return false
	}
	if project.resume == stage {
		app.apply_boot()!
		return true
	}
	step := 'convention:' + relative
	if progress.done(step) {
		return true
	}
	path := supportx.join_path(project.root, relative)
	if !supportx.is_file(path) {
		return false
	}
	mut raw := progress.load(path)!
	defer {
		raw.release()
	}
	if vphp.has_exception() {
		return error('bootstrap ${label} file evaluation failed')
	}
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap ${label} file "${path}" must return iterable spec or callable')
	}
	if raw.is_callable() {
		mut callback_scope := registrationx.begin_registration_scope()
		defer {
			callback_scope.finish()
		}
		callable := raw.as_callable() or {
			return error('bootstrap ${label} file "${path}" must return callable')
		}
		mut app_value := (&app).self_value()
		defer {
			app_value.release()
		}
		callable.with_result[vphp.PhpValue, bool](fn (result vphp.PhpValue) bool {
			return result.is_valid()
		}, app_value) or { false }
		if vphp.has_exception() {
			return error('bootstrap ${label} callback failed')
		}
		progress.complete(step)
		return true
	}
	if app.configure_bootstrap_spec_with_progress(raw, '', step, mut progress)! && !app.booted {
		app.boot_bootstrap_stage(project.source, stage)!
	}
	progress.complete(step)
	return true
}

fn (mut app VSlimApp) apply_preloaded_bootstrap_conventions(project ProjectBootstrap, components supportx.BootstrapComponentFiles, mut progress supportx.BootstrapProgress) !bool {
	project_root := project.root
	mut applied := project.resume != .configure
	if project.resume == .configure && !progress.done('project:config') {
		config_candidates := [supportx.join_path(project_root, 'config'),
			supportx.join_path(project_root, 'config/app.toml'),
			supportx.join_path(project_root, 'app.toml')]
		for candidate in config_candidates {
			if supportx.is_file(candidate) || supportx.is_dir(candidate) {
				app.load_config(candidate)
				if vphp.has_exception() {
					return error('bootstrap project config failed')
				}
				progress.complete('project:config')
				applied = true
				break
			}
		}
	}
	applied = applied || progress.done('project:config')
	if app.apply_bootstrap_convention_spec(project, 'bootstrap/runtime.php', 'runtime', .runtime, mut progress)! {
		applied = true
	}
	if app.apply_bootstrap_convention_spec(project, 'bootstrap/services.php', 'services', .services, mut progress)! {
		applied = true
	}
	if app.apply_bootstrap_convention_spec(project, 'bootstrap/errors.php', 'errors', .shared_errors, mut progress)! {
		applied = true
	}
	if app.view_base_path() == '' {
		view_candidates := [supportx.join_path(project_root, 'views'),
			supportx.join_path(project_root, 'resources/views')]
		for view_dir in view_candidates {
			if !supportx.is_dir(view_dir) {
				continue
			}
			app.set_view_base_path(view_dir)
			applied = true
			break
		}
	}
	providers_applied := app.apply_bootstrap_component_conventions(project_root, .provider,
		components.providers, mut progress)!
	modules_applied := app.apply_bootstrap_component_conventions(project_root, .module_,
		components.modules, mut progress)!
	applied = applied || providers_applied || modules_applied
	return applied
}

fn (mut app VSlimApp) apply_bootstrap_http_conventions(project ProjectBootstrap, files supportx.BootstrapProjectFiles, mut progress supportx.BootstrapProgress) !bool {
	project_root := project.root
	mut applied := false
	if project.resume != .http_errors {
		applied = app.apply_bootstrap_convention_http_classes(files, mut progress)!
	}
	mut app_value := (&app).self_value()
	defer {
		app_value.release()
	}
	if app.apply_bootstrap_convention_spec(project, 'app/Http/errors.php', 'errors', .http_errors, mut progress)! {
		applied = true
	}
	if supportx.bootstrap_convention_hook_file(supportx.join_path(project_root,
		'app/Http/controllers.php')).apply(app_value, 'controllers', mut progress)!
	{
		applied = true
	}
	if supportx.bootstrap_convention_hook_file(supportx.join_path(project_root,
		'bootstrap/middleware.php')).apply(app_value, 'middleware', mut progress)!
	{
		applied = true
	}
	if supportx.bootstrap_convention_hook_file(supportx.join_path(project_root,
		'app/Http/middleware.php')).apply(app_value, 'middleware', mut progress)!
	{
		applied = true
	}
	for route_file in progress.glob_files(supportx.join_path(project_root, 'routes/*.php'))! {
		_ = supportx.bootstrap_convention_hook_file(route_file).apply(app_value, 'routes', mut progress)!
		applied = true
	}
	for route_file in progress.glob_files(supportx.join_path(project_root, 'app/Http/routes/*.php'))! {
		_ = supportx.bootstrap_convention_hook_file(route_file).apply(app_value, 'routes', mut progress)!
		applied = true
	}
	return applied
}

pub enum ProjectBootstrapMode {
	web
	cli
}

fn project_bootstrap_source(project_root string, mode ProjectBootstrapMode) string {
	return 'project:${mode}:' + os.real_path(project_root)
}

fn (mut app VSlimApp) apply_project_bootstrap_conventions(project ProjectBootstrap, mode ProjectBootstrapMode, mut progress supportx.BootstrapProgress) !bool {
	if mode == .cli {
		components := supportx.preload_bootstrap_components(project.root, mut progress)!
		return app.apply_preloaded_bootstrap_conventions(project, components, mut progress)
	}
	if project.resume == .http_errors {
		return app.apply_bootstrap_http_conventions(project, supportx.BootstrapProjectFiles{}, mut progress)
	}
	files := supportx.preload_bootstrap_project_classes(project.root, mut progress)!
	shared_applied := app.apply_preloaded_bootstrap_conventions(project, files.components, mut progress)!
	http_applied := app.apply_bootstrap_http_conventions(project, files, mut progress)!
	return shared_applied || http_applied
}

pub fn (mut app VSlimApp) apply_project_bootstrap(project_root string, mode ProjectBootstrapMode) !bool {
	state := app.watch_service_state()
	defer {
		state.close()
	}
	source := project_bootstrap_source(project_root, mode)
	mut progress := supportx.start_bootstrap_progress(mut app.bootstrap_progress, source)!
	defer {
		progress.stop()
	}
	if app.resume_bootstrap_boot(source)! {
		supportx.finish_bootstrap_progress(mut app.bootstrap_progress, source)
		return true
	}
	saved := app.bootstrap_boot_stages[source]
	resume := if saved == .deferred { BootstrapBootStage.configure } else { saved }
	entry := if resume == .configure { progress.project_entry(project_root)! } else { '' }
	if entry != '' {
		boot := app.configure_bootstrap_file(supportx.BootstrapFile{
			path:          entry
			resolved_path: entry
			project_root:  project_root
		}, mut progress)!
		// Web entry files control boot themselves or defer it until dispatch.
		if boot || mode == .cli {
			app.finish_bootstrap_boot(source)!
		} else {
			app.defer_bootstrap_boot(source)
		}
		supportx.finish_bootstrap_progress(mut app.bootstrap_progress, source)
		return true
	}
	applied := app.apply_project_bootstrap_conventions(ProjectBootstrap{
		root:   project_root
		source: source
		resume: resume
	}, mode, mut progress)!
	if applied {
		app.finish_bootstrap_boot(source)!
	}
	supportx.finish_bootstrap_progress(mut app.bootstrap_progress, source)
	return applied
}

fn (mut app VSlimApp) configure_bootstrap_spec_with_progress(spec vphp.PhpValue, project_root string, scope string, mut progress supportx.BootstrapProgress) !bool {
	iterable := spec.as_iterable() or { return error('bootstrap spec must be iterable') }
	mut normalized := progress.normalize(scope + ':spec', iterable)!
	defer {
		normalized.release()
	}
	if project_root != '' && !progress.done(scope + ':preload') {
		supportx.preload_bootstrap_spec_classes(project_root, supportx.app_bootstrap_spec(normalized))!
		progress.complete(scope + ':preload')
	}
	return app.configure_bootstrap_array_with_progress(normalized, scope, mut progress)
}

enum BootstrapConfigStep {
	container
	config
	runtime
	services
	handlers
	helpers
	before
	middleware
	after
	providers
	modules
	middleware_setup
	routes
}

fn (mut app VSlimApp) configure_bootstrap_array_with_progress(normalized vphp.PhpArray, scope string, mut progress supportx.BootstrapProgress) !bool {
	if vphp.has_exception() {
		return error('bootstrap spec evaluation failed')
	}
	spec := supportx.app_bootstrap_spec(normalized)
	for stage in [BootstrapConfigStep.container, .config, .runtime, .services, .handlers, .helpers,
		.before, .middleware, .after, .providers, .modules, .middleware_setup, .routes] {
		step := '${scope}:${stage}'
		if progress.done(step) {
			continue
		}
		match stage {
			.container { app.apply_bootstrap_container(normalized)! }
			.config { app.apply_bootstrap_config(normalized)! }
			.runtime { app.apply_bootstrap_runtime_flags(normalized) }
			.services { app.apply_bootstrap_services(normalized)! }
			.handlers { app.apply_bootstrap_handlers(normalized)! }
			.helpers { app.apply_bootstrap_helpers(normalized, step, mut progress)! }
			.before {
				app.apply_bootstrap_middleware_stack(normalized, ['before'], .before, 'before', step, mut progress)!
			}
			.middleware {
				app.apply_bootstrap_middleware_stack(normalized, ['middleware', 'middlewares'], .standard, 'middleware', step, mut progress)!
			}
			.after {
				app.apply_bootstrap_middleware_stack(normalized, ['after'], .after, 'after', step, mut progress)!
			}
			.providers { app.apply_bootstrap_component_list(spec, .provider, step, mut progress)! }
			.modules { app.apply_bootstrap_component_list(spec, .module_, step, mut progress)! }
			.middleware_setup, .routes {
				mut app_value := (&app).self_value()
				defer {
					app_value.release()
				}
				if stage == .routes {
					spec.call_hooks(['routes'], app_value, 'routes', step, mut progress)!
				} else {
					spec.call_hooks(['middleware_setup', 'middlewareSetup'], app_value, 'middleware_setup', step, mut progress)!
				}
			}
		}
		if vphp.has_exception() {
			return error('bootstrap ${stage} configuration failed')
		}
		progress.complete(step)
	}
	boot := spec.boot_option().enabled()
	if vphp.has_exception() {
		return error('bootstrap boot option evaluation failed')
	}
	return boot
}

fn (mut app VSlimApp) apply_bootstrap_component_list(spec supportx.AppBootstrapSpec, kind AppComponentKind, step string, mut progress supportx.BootstrapProgress) ! {
	label := kind.label() + 's'
	value := spec.lookup([label]) or { return }
	iterable := value.as_iterable() or { return error('bootstrap ${label} must be iterable') }
	app.register_bootstrap_components(iterable, kind, step, mut progress)!
}

@[php_method]
pub fn (mut app VSlimApp) bootstrap(spec vphp.PhpIterable) &VSlimApp {
	app.apply_bootstrap_iterable(spec) or {
		raise_app_error('InvalidArgumentException', err)
		return &app
	}
	return &app
}

@[php_method: 'bootstrapFile']
pub fn (mut app VSlimApp) bootstrap_file(path string) &VSlimApp {
	app.bootstrap_file_apply(path) or {
		raise_app_error('InvalidArgumentException', err)
		return &app
	}
	return &app
}

@[php_method: 'bootstrapDir']
pub fn (mut app VSlimApp) bootstrap_dir(path string) &VSlimApp {
	directory := supportx.resolve_bootstrap_directory(path, 'bootstrap directory') or {
		raise_app_error('InvalidArgumentException', err)
		return &app
	}
	if directory.explicit_file {
		return app.bootstrap_file(directory.path)
	}
	applied := app.apply_project_bootstrap(directory.project_root, .web) or {
		raise_app_error('InvalidArgumentException', err)
		return &app
	}
	if !applied {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'bootstrap directory "${directory.path}" must contain bootstrap/app.php, app.php, or convention files', 0)
	}
	return &app
}

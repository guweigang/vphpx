module appx

import configx as cfgx
import loggerx
import mcpx as mcp
import cachex
import clockx
import containerx
import controllerx
import eventx

import httpx
import middlewarex
import supportx
import vphp

pub fn (mut app VSlimApp) apply_bootstrap_file_result(path string, value vphp.PhpValue) ! {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return error(supportx.bootstrap_file_return_error(path))
	}
	if value.is_callable() {
		mut app_value := (&app).self_value()
		defer {
			app_value.release()
		}
		callable := value.as_callable() or {
			return error(supportx.bootstrap_file_return_error(path))
		}
		mut result := callable.invoke(app_value)
		defer {
			result.release()
		}
		if !result.is_valid() || result.is_null() || result.is_undef() {
			return
		}
		if result.is_object() && result.is_instance_of('VSlim\\App') {
			return
		}
		app.apply_bootstrap_spec(result)!
		return
	}
	if value.is_object() && value.is_instance_of('VSlim\\App') {
		return
	}
	app.apply_bootstrap_spec(value)!
}

fn (mut app VSlimApp) bootstrap_file_apply(path string) ! {
	clean := path.trim_space()
	if clean == '' {
		return error('bootstrap path must not be empty')
	}
	mut result := vphp.PhpIncludeFile.at(clean).load()
	defer {
		result.release()
	}
	lower := clean.to_lower()
	should_preload := lower.ends_with('/bootstrap/app.php')
		|| lower.ends_with('\\bootstrap\\app.php') || lower.ends_with('/app.php')
		|| lower.ends_with('\\app.php')
	file_exists := supportx.is_file(clean)
	loggerx.cli_debug_log('bootstrap_file clean="${clean}" lower="${lower}" should_preload=${should_preload} is_file=${file_exists}')
	if should_preload && file_exists {
		project_root := if supportx.is_bootstrap_dir_path(supportx.dirname(clean)) {
			supportx.dirname(supportx.dirname(clean))
		} else {
			supportx.dirname(clean)
		}
		if project_root != '' {
			loggerx.cli_debug_log('bootstrap_file preload project_root="${project_root}"')
			supportx.preload_bootstrap_spec_classes(project_root, result)
		}
	}
	app.apply_bootstrap_file_result(clean, result)!
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
		if !clockx.psr20_is_clock(value) {
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

fn (mut app VSlimApp) apply_bootstrap_helpers(spec vphp.PhpArray) ! {
	helpers := supportx.app_bootstrap_spec(spec).lookup(['helpers', 'view_helpers', 'viewHelpers']) or {
		return
	}
	iter := helpers.as_iterable() or { return error('bootstrap helpers must be iterable') }
	mut normalized := iter.to_array()!
	defer {
		normalized.release()
	}
	for key in normalized.assoc_keys() {
		handler := normalized.value_at(key)
		callable := vphp.PhpCallable.from_value(handler) or {
			return error('bootstrap helper "${key}" must be callable')
		}
		app.helper(key, callable)
	}
}

fn (mut app VSlimApp) apply_bootstrap_middleware_stack(spec vphp.PhpArray, keys []string, kind middlewarex.MiddlewareRegistrationKind, label string) ! {
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
	mut normalized := iter.to_array()!
	defer {
		normalized.release()
	}
	for item in normalized.value_items() {
		if !middlewarex.supports_registration(kind, item) {
			return error('bootstrap ${label} entries must be middleware registrations')
		}
		app.apply_bootstrap_middleware_item(kind, label, item)!
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
}

fn (mut app VSlimApp) apply_bootstrap_convention_providers(path string) !bool {
	if !supportx.is_file(path) {
		return false
	}
	mut raw := vphp.PhpIncludeFile.at(path).load()
	defer {
		raw.release()
	}
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap providers file "${path}" must return iterable providers')
	}
	providers := raw.as_iterable() or {
		return error('bootstrap providers file "${path}" must return iterable providers')
	}
	app.register_many(providers)
	return true
}

fn (mut app VSlimApp) apply_bootstrap_convention_modules(path string) !bool {
	if !supportx.is_file(path) {
		return false
	}
	mut raw := vphp.PhpIncludeFile.at(path).load()
	defer {
		raw.release()
	}
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap modules file "${path}" must return iterable modules')
	}
	modules := raw.as_iterable() or {
		return error('bootstrap modules file "${path}" must return iterable modules')
	}
	app.module_many(modules)
	return true
}

fn (mut app VSlimApp) apply_bootstrap_convention_provider_classes(project_root string) !bool {
	mut applied := false
	for file in supportx.glob_paths(supportx.join_path(project_root, 'app/Providers/*.php')) {
		_ = supportx.include_once_file(file)
		class_name := 'App\\Providers\\' + supportx.file_stem(file)
		if !supportx.class_exists(class_name) {
			return error('provider convention file "${file}" must declare class ${class_name}')
		}
		app.register_service_provider_class(class_name)!
		applied = true
	}
	return applied
}

fn (mut app VSlimApp) apply_bootstrap_convention_module_classes(project_root string) !bool {
	mut applied := false
	for file in supportx.glob_paths(supportx.join_path(project_root, 'app/Modules/*.php')) {
		_ = supportx.include_once_file(file)
		class_name := 'App\\Modules\\' + supportx.file_stem(file)
		if !supportx.class_exists(class_name) {
			return error('module convention file "${file}" must declare class ${class_name}')
		}
		app.register_module_class(class_name)!
		applied = true
	}
	return applied
}

fn (mut app VSlimApp) apply_bootstrap_convention_http_classes(project_root string) !bool {
	mut applied := false
	mut container := app.container()
	mut app_value := (&app).self_value()
	defer {
		app_value.release()
	}
	for file in supportx.glob_paths(supportx.join_path(project_root, 'app/Http/Controllers/*.php')) {
		_ = supportx.include_once_file(file)
		class_name := 'App\\Http\\Controllers\\' + supportx.file_stem(file)
		if !supportx.class_exists(class_name) {
			return error('controller convention file "${file}" must declare class ${class_name}')
		}
		controllerx.register_convention_controller(mut container, class_name, app_value)!
		applied = true
	}
	for file in supportx.glob_paths(supportx.join_path(project_root, 'app/Http/Middleware/*.php')) {
		_ = supportx.include_once_file(file)
		class_name := 'App\\Http\\Middleware\\' + supportx.file_stem(file)
		if !supportx.class_exists(class_name) {
			return error('middleware convention file "${file}" must declare class ${class_name}')
		}
		applied = true
	}
	return applied
}

fn (mut app VSlimApp) apply_bootstrap_convention_spec(path string, label string) !bool {
	if !supportx.is_file(path) {
		return false
	}
	mut raw := vphp.PhpIncludeFile.at(path).load()
	defer {
		raw.release()
	}
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap ${label} file "${path}" must return iterable spec or callable')
	}
	if raw.is_callable() {
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
		return true
	}
	app.apply_bootstrap_spec(raw)!
	return true
}

pub fn (mut app VSlimApp) apply_bootstrap_shared_conventions(project_root string) !bool {
	mut applied := false
	config_candidates := [supportx.join_path(project_root, 'config'),
		supportx.join_path(project_root, 'config/app.toml'), supportx.join_path(project_root, 'app.toml')]
	for candidate in config_candidates {
		if supportx.is_file(candidate) || supportx.is_dir(candidate) {
			app.load_config(candidate)
			applied = true
			break
		}
	}
	if app.apply_bootstrap_convention_spec(supportx.join_path(project_root, 'bootstrap/runtime.php'),
		'runtime')!
	{
		applied = true
	}
	if app.apply_bootstrap_convention_spec(supportx.join_path(project_root, 'bootstrap/services.php'),
		'services')!
	{
		applied = true
	}
	if app.apply_bootstrap_convention_spec(supportx.join_path(project_root, 'bootstrap/errors.php'),
		'errors')!
	{
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
	if app.apply_bootstrap_convention_providers(supportx.join_path(project_root,
		'bootstrap/providers.php'))!
	{
		applied = true
	}
	if app.apply_bootstrap_convention_provider_classes(project_root)! {
		applied = true
	}
	if app.apply_bootstrap_convention_modules(supportx.join_path(project_root, 'bootstrap/modules.php'))! {
		applied = true
	}
	if app.apply_bootstrap_convention_module_classes(project_root)! {
		applied = true
	}
	return applied
}

fn (mut app VSlimApp) apply_bootstrap_http_conventions(project_root string) !bool {
	mut applied := false
	if app.apply_bootstrap_convention_http_classes(project_root)! {
		applied = true
	}
	mut app_value := (&app).self_value()
	defer {
		app_value.release()
	}
	if app.apply_bootstrap_convention_spec(supportx.join_path(project_root, 'app/Http/errors.php'),
		'errors')!
	{
		applied = true
	}
	if supportx.bootstrap_convention_hook_file(supportx.join_path(project_root,
		'app/Http/controllers.php')).apply(app_value, 'controllers')!
	{
		applied = true
	}
	if supportx.bootstrap_convention_hook_file(supportx.join_path(project_root,
		'bootstrap/middleware.php')).apply(app_value, 'middleware')!
	{
		applied = true
	}
	if supportx.bootstrap_convention_hook_file(supportx.join_path(project_root,
		'app/Http/middleware.php')).apply(app_value, 'middleware')!
	{
		applied = true
	}
	for route_file in supportx.glob_paths(supportx.join_path(project_root, 'routes/*.php')) {
		_ = supportx.bootstrap_convention_hook_file(route_file).apply(app_value, 'routes')!
		applied = true
	}
	for route_file in supportx.glob_paths(supportx.join_path(project_root, 'app/Http/routes/*.php')) {
		_ = supportx.bootstrap_convention_hook_file(route_file).apply(app_value, 'routes')!
		applied = true
	}
	return applied
}

fn (mut app VSlimApp) apply_bootstrap_conventions(path string) ! {
	project_root := if supportx.is_bootstrap_dir_path(path) { supportx.dirname(path) } else { path }
	if project_root == '' {
		return error('bootstrap directory "${path}" has no project root')
	}
	shared_applied := app.apply_bootstrap_shared_conventions(project_root)!
	http_applied := app.apply_bootstrap_http_conventions(project_root)!
	applied := shared_applied || http_applied
	if !applied {
		return error('bootstrap directory "${path}" must contain bootstrap/app.php, app.php, or convention files')
	}
	app.boot()
}

fn (mut app VSlimApp) apply_bootstrap_spec(spec vphp.PhpValue) ! {
	normalized := supportx.normalize_app_bootstrap_spec(spec)!
	defer {
		normalized.release()
	}
	app.apply_bootstrap_array(normalized)!
}

fn (mut app VSlimApp) apply_bootstrap_iterable(spec vphp.PhpIterable) ! {
	normalized := supportx.normalize_app_bootstrap_iterable(spec)!
	defer {
		normalized.release()
	}
	app.apply_bootstrap_array(normalized)!
}

fn (mut app VSlimApp) apply_bootstrap_array(normalized vphp.PhpArray) ! {
	app.apply_bootstrap_container(normalized)!
	app.apply_bootstrap_config(normalized)!
	app.apply_bootstrap_runtime_flags(normalized)
	app.apply_bootstrap_services(normalized)!
	app.apply_bootstrap_handlers(normalized)!
	app.apply_bootstrap_helpers(normalized)!
	app.apply_bootstrap_middleware_stack(normalized, ['before'], .before, 'before')!
	app.apply_bootstrap_middleware_stack(normalized, ['middleware', 'middlewares'], .standard,
		'middleware')!
	app.apply_bootstrap_middleware_stack(normalized, ['after'], .after, 'after')!
	if providers := supportx.app_bootstrap_spec(normalized).lookup(['providers']) {
		provider_iter := providers.as_iterable() or {
			return error('bootstrap providers must be iterable')
		}
		app.register_many(provider_iter)
	}
	if modules := supportx.app_bootstrap_spec(normalized).lookup(['modules']) {
		module_iter := modules.as_iterable() or {
			return error('bootstrap modules must be iterable')
		}
		app.module_many(module_iter)
	}
	mut app_value := (&app).self_value()
	defer {
		app_value.release()
	}
	supportx.app_bootstrap_spec(normalized).call_hooks(['middleware_setup', 'middlewareSetup'],
		app_value, 'middleware_setup')!
	supportx.app_bootstrap_spec(normalized).call_hooks(['routes'], app_value, 'routes')!
	if should_boot := supportx.app_bootstrap_spec(normalized).bool(['boot']) {
		if should_boot {
			app.boot()
		}
	}
}

@[php_method]
pub fn (mut app VSlimApp) bootstrap(spec vphp.PhpIterable) &VSlimApp {
	app.apply_bootstrap_iterable(spec) or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	return &app
}

@[php_method: 'bootstrapFile']
pub fn (mut app VSlimApp) bootstrap_file(path string) &VSlimApp {
	app.bootstrap_file_apply(path) or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	return &app
}

@[php_method: 'bootstrapDir']
pub fn (mut app VSlimApp) bootstrap_dir(path string) &VSlimApp {
	clean := supportx.normalize_dir_path(path)
	if clean == '' {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'bootstrap directory must not be empty', 0)
		return &app
	}
	if !clean.ends_with('.php') {
		supportx.preload_bootstrap_project_classes(clean)
	}
	if clean.ends_with('.php') && supportx.is_file(clean) {
		mut result := vphp.PhpIncludeFile.at(clean).load()
		defer {
			result.release()
		}
		lower := clean.to_lower()
		should_preload := lower.ends_with('/bootstrap/app.php')
			|| lower.ends_with('\\bootstrap\\app.php') || lower.ends_with('/app.php')
			|| lower.ends_with('\\app.php')
		if should_preload {
			project_root := if supportx.is_bootstrap_dir_path(supportx.dirname(clean)) {
				supportx.dirname(supportx.dirname(clean))
			} else {
				supportx.dirname(clean)
			}
			if project_root != '' {
				supportx.preload_bootstrap_spec_classes(project_root, result)
			}
		}
		app.apply_bootstrap_file_result(clean, result) or {
			vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
			return &app
		}
		return &app
	}
	bootstrap_candidate := clean + '/bootstrap/app.php'
	if supportx.is_file(bootstrap_candidate) {
		mut result := vphp.PhpIncludeFile.at(bootstrap_candidate).load()
		defer {
			result.release()
		}
		project_root := if supportx.is_bootstrap_dir_path(supportx.dirname(bootstrap_candidate)) {
			supportx.dirname(supportx.dirname(bootstrap_candidate))
		} else {
			supportx.dirname(bootstrap_candidate)
		}
		if project_root != '' {
			supportx.preload_bootstrap_spec_classes(project_root, result)
		}
		app.apply_bootstrap_file_result(bootstrap_candidate, result) or {
			vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
			return &app
		}
		return &app
	}
	app_candidate := clean + '/app.php'
	if supportx.is_file(app_candidate) {
		mut result := vphp.PhpIncludeFile.at(app_candidate).load()
		defer {
			result.release()
		}
		project_root := if supportx.is_bootstrap_dir_path(supportx.dirname(app_candidate)) {
			supportx.dirname(supportx.dirname(app_candidate))
		} else {
			supportx.dirname(app_candidate)
		}
		if project_root != '' {
			supportx.preload_bootstrap_spec_classes(project_root, result)
		}
		app.apply_bootstrap_file_result(app_candidate, result) or {
			vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
			return &app
		}
		return &app
	}
	app.apply_bootstrap_conventions(clean) or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	return &app
}

module main

import vphp

fn bootstrap_file_return_error(path string) string {
	return 'bootstrap file "${path}" must return iterable spec, callable, or VSlim\\App'
}

fn php_is_file(path string) bool {
	exists := vphp.call_php('is_file', [vphp.RequestOwnedZVal.new_string(path).to_zval()])
	return exists.is_valid() && exists.to_bool()
}

fn php_is_dir(path string) bool {
	exists := vphp.call_php('is_dir', [vphp.RequestOwnedZVal.new_string(path).to_zval()])
	return exists.is_valid() && exists.to_bool()
}

fn php_glob_paths(pattern string) []string {
	result := vphp.call_php('glob', [vphp.RequestOwnedZVal.new_string(pattern).to_zval()])
	if !result.is_valid() || result.is_null() || result.is_undef() || !result.is_array() {
		return []string{}
	}
	mut out := []string{}
	for idx := 0; idx < result.array_count(); idx++ {
		item := result.array_get(idx)
		if !item.is_valid() || item.is_null() || item.is_undef() {
			continue
		}
		path := item.to_string().trim_space()
		if path != '' {
			out << path
		}
	}
	out.sort()
	return out
}

fn php_include_once(path string) vphp.ZVal {
	return vphp.include_once(path)
}

fn php_class_exists(class_name string) bool {
	if class_name.trim_space() == '' {
		return false
	}
	exists := vphp.call_php('class_exists', [
		vphp.RequestOwnedZVal.new_string(class_name).to_zval(),
		vphp.RequestOwnedZVal.new_bool(true).to_zval(),
	])
	return exists.is_valid() && exists.to_bool()
}

fn normalize_bootstrap_dir_path(path string) string {
	mut clean := path.trim_space()
	for clean.len > 1 && (clean.ends_with('/') || clean.ends_with('\\')) {
		clean = clean[..clean.len - 1]
	}
	return clean
}

fn path_join(base string, child string) string {
	root := normalize_bootstrap_dir_path(base)
	if root == '' {
		return child
	}
	return root + '/' + child
}

fn path_dirname(path string) string {
	clean := normalize_bootstrap_dir_path(path)
	last_forward := clean.last_index('/') or { -1 }
	last_back := clean.last_index('\\') or { -1 }
	last_sep := if last_forward > last_back { last_forward } else { last_back }
	if last_sep <= 0 {
		return ''
	}
	return clean[..last_sep]
}

fn path_file_stem(path string) string {
	clean := normalize_bootstrap_dir_path(path)
	last_forward := clean.last_index('/') or { -1 }
	last_back := clean.last_index('\\') or { -1 }
	last_sep := if last_forward > last_back { last_forward } else { last_back }
	mut base := if last_sep >= 0 { clean[last_sep + 1..] } else { clean }
	if base.ends_with('.php') && base.len > 4 {
		base = base[..base.len - 4]
	}
	return base
}

fn is_bootstrap_dir_path(path string) bool {
	clean := normalize_bootstrap_dir_path(path).to_lower()
	return clean.ends_with('/bootstrap') || clean.ends_with('\\bootstrap')
}

fn normalize_app_bootstrap_spec(raw vphp.ZVal) !vphp.ZVal {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap spec must be iterable')
	}
	return psr16_iterable_to_array(raw)!
}

fn app_bootstrap_lookup(spec vphp.ZVal, keys []string) ?vphp.ZVal {
	for key in keys {
		if key.trim_space() == '' {
			continue
		}
		value := spec.get(key) or { continue }
		if !value.is_valid() || value.is_undef() {
			continue
		}
		return value
	}
	return none
}

fn app_bootstrap_string(spec vphp.ZVal, keys []string) ?string {
	value := app_bootstrap_lookup(spec, keys) or { return none }
	if value.is_null() || value.is_undef() {
		return none
	}
	text := value.to_string().trim_space()
	if text == '' {
		return none
	}
	return text
}

fn app_bootstrap_bool(spec vphp.ZVal, keys []string) ?bool {
	value := app_bootstrap_lookup(spec, keys) or { return none }
	if value.is_null() || value.is_undef() {
		return none
	}
	if value.is_bool() {
		return value.to_bool()
	}
	if value.is_long() {
		return value.to_i64() != 0
	}
	raw := value.to_string().trim_space().to_lower()
	if raw == '' {
		return none
	}
	return raw in ['1', 'true', 'yes', 'on']
}

fn apply_bootstrap_file_result(mut app VSlimApp, path string, value vphp.ZVal) ! {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return error(bootstrap_file_return_error(path))
	}
	if value.is_callable() {
		result := value.call_owned_request([app_self_zval(&app)])
		if !result.is_valid() || result.is_null() || result.is_undef() {
			return
		}
		if result.is_object() && result.is_instance_of('VSlim\\App') {
			return
		}
		apply_app_bootstrap_spec(mut app, result)!
		return
	}
	if value.is_object() && value.is_instance_of('VSlim\\App') {
		return
	}
	apply_app_bootstrap_spec(mut app, value)!
}

fn normalize_app_bootstrap_hook_items(raw vphp.ZVal) ![]vphp.ZVal {
	if raw.is_valid() && raw.is_callable() {
		return [raw]
	}
	normalized := psr16_iterable_to_array(raw)!
	return normalized.fold[[]vphp.ZVal]([]vphp.ZVal{}, fn (_ vphp.ZVal, item vphp.ZVal, mut acc []vphp.ZVal) {
		acc << item
	})
}

fn normalize_app_bootstrap_middleware_items(raw vphp.ZVal, kind MiddlewareRegistrationKind, label string) ![]vphp.ZVal {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap ${label} must not be null')
	}
	borrowed := vphp.BorrowedZVal.from_zval(raw)
	if raw.is_string() || is_supported_php_middleware_handler(borrowed) {
		if !is_supported_registration_kind(kind, borrowed) {
			return error('bootstrap ${label} must contain valid middleware registrations')
		}
		return [raw]
	}
	if raw.is_array() {
		if raw.is_list() && raw.array_count() == 2 && raw.array_get(0).is_string()
			&& raw.array_get(1).is_string() {
			if !is_supported_registration_kind(kind, borrowed) {
				return error('bootstrap ${label} must contain valid middleware registrations')
			}
			return [raw]
		}
		mut items := []vphp.ZVal{}
		for idx := 0; idx < raw.array_count(); idx++ {
			item := raw.array_get(idx)
			if !is_supported_registration_kind(kind, vphp.BorrowedZVal.from_zval(item)) {
				return error('bootstrap ${label} entries must be middleware registrations')
			}
			items << item
		}
		return items
	}
	return error('bootstrap ${label} must be a middleware registration or list')
}

fn require_native_bootstrap_object[T](value vphp.ZVal, class_name string, label string) !&T {
	if !value.is_valid() || !value.is_object() || !value.is_instance_of(class_name) {
		return error('bootstrap ${label} must be ${class_name}')
	}
	obj := value.to_object[T]() or {
		return error('bootstrap ${label} must be a native ${class_name} object')
	}
	return obj
}

fn apply_app_bootstrap_container(mut app VSlimApp, spec vphp.ZVal) ! {
	value := app_bootstrap_lookup(spec, ['container']) or { return }
	container := require_native_bootstrap_object[VSlimContainer](value, 'VSlim\\Container',
		'container')!
	app.set_container(container)
}

fn apply_app_bootstrap_config(mut app VSlimApp, spec vphp.ZVal) ! {
	if value := app_bootstrap_lookup(spec, ['config']) {
		config := require_native_bootstrap_object[VSlimConfig](value, 'VSlim\\Config',
			'config')!
		app.set_config(config)
	}
	if config_path := app_bootstrap_string(spec, ['config_path', 'configPath', 'config_file',
		'configFile'])
	{
		app.load_config(config_path)
	}
	if config_text := app_bootstrap_string(spec, ['config_text', 'configText']) {
		app.load_config_text(config_text)
	}
}

fn apply_app_bootstrap_runtime_flags(mut app VSlimApp, spec vphp.ZVal) {
	if base_path := app_bootstrap_string(spec, ['base_path', 'basePath']) {
		app.set_base_path(base_path)
	}
	if view_base_path := app_bootstrap_string(spec, ['view_base_path', 'viewBasePath']) {
		app.set_view_base_path(view_base_path)
	}
	if assets_prefix := app_bootstrap_string(spec, ['assets_prefix', 'assetsPrefix']) {
		app.set_assets_prefix(assets_prefix)
	}
	if enabled := app_bootstrap_bool(spec, ['view_cache', 'viewCache']) {
		app.set_view_cache(enabled)
	}
	if enabled := app_bootstrap_bool(spec, ['error_response_json', 'errorResponseJson']) {
		app.set_error_response_json(enabled)
	}
}

fn apply_app_bootstrap_services(mut app VSlimApp, spec vphp.ZVal) ! {
	if value := app_bootstrap_lookup(spec, ['clock']) {
		if !psr20_is_clock(value) {
			return error('bootstrap clock must implement Psr\\Clock\\ClockInterface')
		}
		app.set_clock(vphp.BorrowedValue.from_zval(value))
	}
	if value := app_bootstrap_lookup(spec, ['logger']) {
		logger := require_native_bootstrap_object[VSlimLogger](value, 'VSlim\\Log\\Logger',
			'logger')!
		app.set_logger(logger)
	}
	if value := app_bootstrap_lookup(spec, ['listener_provider', 'listenerProvider']) {
		provider := require_native_bootstrap_object[VSlimPsr14ListenerProvider](value,
			'VSlim\\Psr14\\ListenerProvider', 'listener_provider')!
		app.set_listener_provider(provider)
	}
	if value := app_bootstrap_lookup(spec, ['dispatcher']) {
		dispatcher := require_native_bootstrap_object[VSlimPsr14EventDispatcher](value,
			'VSlim\\Psr14\\EventDispatcher', 'dispatcher')!
		app.set_dispatcher(dispatcher)
	}
	if value := app_bootstrap_lookup(spec, ['cache']) {
		cache := require_native_bootstrap_object[VSlimPsr16Cache](value, 'VSlim\\Psr16\\Cache',
			'cache')!
		app.set_cache(cache)
	}
	if value := app_bootstrap_lookup(spec, ['cache_pool', 'cachePool']) {
		pool := require_native_bootstrap_object[VSlimPsr6CacheItemPool](value, 'VSlim\\Psr6\\CacheItemPool',
			'cache_pool')!
		app.set_cache_pool(pool)
	}
	if value := app_bootstrap_lookup(spec, ['http_client', 'httpClient']) {
		client := require_native_bootstrap_object[VSlimPsr18Client](value, 'VSlim\\Psr18\\Client',
			'http_client')!
		app.set_http_client(client)
	}
	if value := app_bootstrap_lookup(spec, ['mcp']) {
		if value.is_callable() {
			_ = value.call_owned_request([app_self_zval(&app).method_owned_request('mcp',
				[])])
		} else {
			mcp := require_native_bootstrap_object[VSlimMcpApp](value, 'VSlim\\Mcp\\App',
				'mcp')!
			app.set_mcp(mcp)
		}
	}
}

fn apply_app_bootstrap_handlers(mut app VSlimApp, spec vphp.ZVal) ! {
	if value := app_bootstrap_lookup(spec, ['not_found', 'notFound']) {
		if !value.is_valid() || !value.is_callable() {
			return error('bootstrap not_found must be callable')
		}
		app.set_not_found_handler(vphp.BorrowedValue.from_zval(value))
	}
	if value := app_bootstrap_lookup(spec, ['error', 'error_handler', 'errorHandler']) {
		if !value.is_valid() || !value.is_callable() {
			return error('bootstrap error handler must be callable')
		}
		app.set_error_handler(vphp.BorrowedValue.from_zval(value))
	}
}

fn apply_app_bootstrap_helpers(mut app VSlimApp, spec vphp.ZVal) ! {
	helpers := app_bootstrap_lookup(spec, ['helpers', 'view_helpers', 'viewHelpers']) or { return }
	normalized := psr16_iterable_to_array(helpers)!
	for key in normalized.assoc_keys() {
		handler := normalized.get(key) or { continue }
		if !handler.is_valid() || !handler.is_callable() {
			return error('bootstrap helper "${key}" must be callable')
		}
		app.helper(key, vphp.BorrowedValue.from_zval(handler))
	}
}

fn apply_app_bootstrap_middleware_stack(mut app VSlimApp, spec vphp.ZVal, keys []string, kind MiddlewareRegistrationKind, label string) ! {
	value := app_bootstrap_lookup(spec, keys) or { return }
	items := normalize_app_bootstrap_middleware_items(value, kind, label)!
	for item in items {
		match kind {
			.standard { app.middleware(vphp.BorrowedValue.from_zval(item)) }
			.before { app.before(vphp.BorrowedValue.from_zval(item)) }
			.after { app.after(vphp.BorrowedValue.from_zval(item)) }
		}
	}
}

fn call_app_bootstrap_hooks(spec vphp.ZVal, keys []string, app_z vphp.ZVal, label string) ! {
	raw := app_bootstrap_lookup(spec, keys) or { return }
	items := normalize_app_bootstrap_hook_items(raw)!
	for item in items {
		if !item.is_valid() || !item.is_callable() {
			return error('bootstrap ${label} entries must be callable')
		}
		_ = item.call_owned_request([app_z])
	}
}

fn call_app_bootstrap_hook_result(raw vphp.ZVal, app_z vphp.ZVal, label string) ! {
	items := normalize_app_bootstrap_hook_items(raw)!
	for item in items {
		if !item.is_valid() || !item.is_callable() {
			return error('bootstrap ${label} entries must be callable')
		}
		_ = item.call_owned_request([app_z])
	}
}

fn apply_bootstrap_convention_providers(mut app VSlimApp, path string) !bool {
	if !php_is_file(path) {
		return false
	}
	raw := vphp.include(path)
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap providers file "${path}" must return iterable providers')
	}
	app.register_many(vphp.BorrowedValue.from_zval(raw))
	return true
}

fn apply_bootstrap_convention_modules(mut app VSlimApp, path string) !bool {
	if !php_is_file(path) {
		return false
	}
	raw := vphp.include(path)
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap modules file "${path}" must return iterable modules')
	}
	app.module_many(vphp.BorrowedValue.from_zval(raw))
	return true
}

fn apply_bootstrap_convention_hooks(path string, app_z vphp.ZVal, label string) !bool {
	if !php_is_file(path) {
		return false
	}
	raw := vphp.include(path)
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap ${label} file "${path}" must return callable or callable list')
	}
	call_app_bootstrap_hook_result(raw, app_z, label)!
	return true
}

fn apply_bootstrap_convention_provider_classes(mut app VSlimApp, project_root string) !bool {
	mut applied := false
	for file in php_glob_paths(path_join(project_root, 'app/Providers/*.php')) {
		_ = php_include_once(file)
		class_name := 'App\\Providers\\' + path_file_stem(file)
		if !php_class_exists(class_name) {
			return error('provider convention file "${file}" must declare class ${class_name}')
		}
		app.register(vphp.BorrowedValue.from_zval(vphp.RequestOwnedZVal.new_string(class_name).to_zval()))
		applied = true
	}
	return applied
}

fn apply_bootstrap_convention_module_classes(mut app VSlimApp, project_root string) !bool {
	mut applied := false
	for file in php_glob_paths(path_join(project_root, 'app/Modules/*.php')) {
		_ = php_include_once(file)
		class_name := 'App\\Modules\\' + path_file_stem(file)
		if !php_class_exists(class_name) {
			return error('module convention file "${file}" must declare class ${class_name}')
		}
		app.mount_module(vphp.BorrowedValue.from_zval(vphp.RequestOwnedZVal.new_string(class_name).to_zval()))
		applied = true
	}
	return applied
}

fn apply_bootstrap_convention_http_classes(mut app VSlimApp, project_root string) !bool {
	mut applied := false
	mut container := app.container()
	app_z := app_self_zval(&app)
	for file in php_glob_paths(path_join(project_root, 'app/Http/Controllers/*.php')) {
		_ = php_include_once(file)
		class_name := 'App\\Http\\Controllers\\' + path_file_stem(file)
		if !php_class_exists(class_name) {
			return error('controller convention file "${file}" must declare class ${class_name}')
		}
		if !container.has(class_name)
			&& vphp.php_class(class_name).is_subclass_of('VSlim\\Controller') {
			controller := vphp.php_class(class_name).construct([app_z])
			if !controller.is_valid() || !controller.is_object() {
				return error('controller class "${class_name}" could not be instantiated')
			}
			container.set(class_name, vphp.BorrowedValue.from_zval(controller))
		}
		applied = true
	}
	for file in php_glob_paths(path_join(project_root, 'app/Http/Middleware/*.php')) {
		_ = php_include_once(file)
		class_name := 'App\\Http\\Middleware\\' + path_file_stem(file)
		if !php_class_exists(class_name) {
			return error('middleware convention file "${file}" must declare class ${class_name}')
		}
		applied = true
	}
	return applied
}

fn apply_bootstrap_convention_spec(mut app VSlimApp, path string, label string) !bool {
	if !php_is_file(path) {
		return false
	}
	raw := vphp.include(path)
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap ${label} file "${path}" must return iterable spec or callable')
	}
	if raw.is_callable() {
		_ = raw.call_owned_request([app_self_zval(&app)])
		return true
	}
	apply_app_bootstrap_spec(mut app, raw)!
	return true
}

fn apply_bootstrap_shared_conventions(mut app VSlimApp, project_root string) !bool {
	mut applied := false
	config_candidates := [path_join(project_root, 'config/app.toml'),
		path_join(project_root, 'app.toml')]
	for candidate in config_candidates {
		if php_is_file(candidate) {
			app.load_config(candidate)
			applied = true
			break
		}
	}
	if apply_bootstrap_convention_spec(mut app, path_join(project_root, 'bootstrap/runtime.php'),
		'runtime')!
	{
		applied = true
	}
	if apply_bootstrap_convention_spec(mut app, path_join(project_root, 'bootstrap/services.php'),
		'services')!
	{
		applied = true
	}
	if apply_bootstrap_convention_spec(mut app, path_join(project_root, 'bootstrap/errors.php'),
		'errors')!
	{
		applied = true
	}
	if app.view_base_path() == '' {
		view_candidates := [path_join(project_root, 'views'),
			path_join(project_root, 'resources/views')]
		for view_dir in view_candidates {
			if !php_is_dir(view_dir) {
				continue
			}
			app.set_view_base_path(view_dir)
			applied = true
			break
		}
	}
	if apply_bootstrap_convention_providers(mut app, path_join(project_root, 'bootstrap/providers.php'))! {
		applied = true
	}
	if apply_bootstrap_convention_provider_classes(mut app, project_root)! {
		applied = true
	}
	if apply_bootstrap_convention_modules(mut app, path_join(project_root, 'bootstrap/modules.php'))! {
		applied = true
	}
	if apply_bootstrap_convention_module_classes(mut app, project_root)! {
		applied = true
	}
	return applied
}

fn apply_bootstrap_http_conventions(mut app VSlimApp, project_root string) !bool {
	mut applied := false
	if apply_bootstrap_convention_http_classes(mut app, project_root)! {
		applied = true
	}
	app_z := app_self_zval(&app)
	if apply_bootstrap_convention_spec(mut app, path_join(project_root, 'app/Http/errors.php'),
		'errors')!
	{
		applied = true
	}
	if apply_bootstrap_convention_hooks(path_join(project_root, 'app/Http/controllers.php'),
		app_z, 'controllers')!
	{
		applied = true
	}
	if apply_bootstrap_convention_hooks(path_join(project_root, 'bootstrap/middleware.php'),
		app_z, 'middleware')!
	{
		applied = true
	}
	if apply_bootstrap_convention_hooks(path_join(project_root, 'app/Http/middleware.php'),
		app_z, 'middleware')!
	{
		applied = true
	}
	for route_file in php_glob_paths(path_join(project_root, 'routes/*.php')) {
		_ = apply_bootstrap_convention_hooks(route_file, app_z, 'routes')!
		applied = true
	}
	for route_file in php_glob_paths(path_join(project_root, 'app/Http/routes/*.php')) {
		_ = apply_bootstrap_convention_hooks(route_file, app_z, 'routes')!
		applied = true
	}
	return applied
}

fn apply_bootstrap_conventions(mut app VSlimApp, path string) ! {
	project_root := if is_bootstrap_dir_path(path) { path_dirname(path) } else { path }
	if project_root == '' {
		return error('bootstrap directory "${path}" has no project root')
	}
	shared_applied := apply_bootstrap_shared_conventions(mut app, project_root)!
	http_applied := apply_bootstrap_http_conventions(mut app, project_root)!
	applied := shared_applied || http_applied
	if !applied {
		return error('bootstrap directory "${path}" must contain bootstrap/app.php, app.php, or convention files')
	}
	app.boot()
}

fn apply_app_bootstrap_spec(mut app VSlimApp, spec vphp.ZVal) ! {
	normalized := normalize_app_bootstrap_spec(spec)!
	apply_app_bootstrap_container(mut app, normalized)!
	apply_app_bootstrap_config(mut app, normalized)!
	apply_app_bootstrap_runtime_flags(mut app, normalized)
	apply_app_bootstrap_services(mut app, normalized)!
	apply_app_bootstrap_handlers(mut app, normalized)!
	apply_app_bootstrap_helpers(mut app, normalized)!
	apply_app_bootstrap_middleware_stack(mut app, normalized, ['before'], .before, 'before')!
	apply_app_bootstrap_middleware_stack(mut app, normalized, ['middleware', 'middlewares'],
		.standard, 'middleware')!
	apply_app_bootstrap_middleware_stack(mut app, normalized, ['after'], .after, 'after')!
	if providers := app_bootstrap_lookup(normalized, ['providers']) {
		app.register_many(vphp.BorrowedValue.from_zval(providers))
	}
	if modules := app_bootstrap_lookup(normalized, ['modules']) {
		app.module_many(vphp.BorrowedValue.from_zval(modules))
	}
	app_z := app_self_zval(&app)
	call_app_bootstrap_hooks(normalized, ['middleware_setup', 'middlewareSetup'], app_z,
		'middleware_setup')!
	call_app_bootstrap_hooks(normalized, ['routes'], app_z, 'routes')!
	if should_boot := app_bootstrap_bool(normalized, ['boot']) {
		if should_boot {
			app.boot()
		}
	}
}

@[php_arg_type: 'spec=iterable']
@[php_method]
pub fn (mut app VSlimApp) bootstrap(spec vphp.BorrowedValue) &VSlimApp {
	apply_app_bootstrap_spec(mut app, spec.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	return &app
}

@[php_method: 'bootstrapFile']
pub fn (mut app VSlimApp) bootstrap_file(path string) &VSlimApp {
	clean := path.trim_space()
	if clean == '' {
		vphp.throw_exception_class('InvalidArgumentException', 'bootstrap path must not be empty',
			0)
		return &app
	}
	result := vphp.include(clean)
	apply_bootstrap_file_result(mut app, clean, result) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	return &app
}

@[php_method: 'bootstrapDir']
pub fn (mut app VSlimApp) bootstrap_dir(path string) &VSlimApp {
	clean := normalize_bootstrap_dir_path(path)
	if clean == '' {
		vphp.throw_exception_class('InvalidArgumentException', 'bootstrap directory must not be empty',
			0)
		return &app
	}
	if clean.ends_with('.php') && php_is_file(clean) {
		return app.bootstrap_file(clean)
	}
	candidates := [clean + '/bootstrap/app.php', clean + '/app.php']
	for candidate in candidates {
		if php_is_file(candidate) {
			return app.bootstrap_file(candidate)
		}
	}
	apply_bootstrap_conventions(mut app, clean) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	return &app
}

module main

import pathutil
import vphp

fn bootstrap_file_return_error(path string) string {
	return 'bootstrap file "${path}" must return iterable spec, callable, or VSlim\\App'
}

fn php_is_file(path string) bool {
	return vphp.php_call_result_bool('is_file', [vphp.RequestOwnedZBox.new_string(path).to_zval()])
}

fn php_is_dir(path string) bool {
	return vphp.php_call_result_bool('is_dir', [vphp.RequestOwnedZBox.new_string(path).to_zval()])
}

fn php_join_path(base string, child string) string {
	trimmed := vphp.php_call_result_string('rtrim', [
		vphp.RequestOwnedZBox.new_string(base).to_zval(),
		vphp.RequestOwnedZBox.new_string('/\\').to_zval(),
	])
	return vphp.php_call_result_string('sprintf', [
		vphp.RequestOwnedZBox.new_string('%s/%s').to_zval(),
		vphp.RequestOwnedZBox.new_string(trimmed).to_zval(),
		vphp.RequestOwnedZBox.new_string(child).to_zval(),
	])
}

fn php_glob_paths(pattern string) []string {
	return vphp.with_php_call_result_zval('glob', [
		vphp.RequestOwnedZBox.new_string(pattern).to_zval(),
	], fn (result vphp.ZVal) []string {
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
	})
}

fn php_scandir_names(path string) []string {
	return vphp.with_php_call_result_zval('scandir', [
		vphp.RequestOwnedZBox.new_string(path).to_zval(),
	], fn (result vphp.ZVal) []string {
		if !result.is_valid() || result.is_null() || result.is_undef() || !result.is_array() {
			return []string{}
		}
		mut out := []string{}
		for idx := 0; idx < result.array_count(); idx++ {
			item := result.array_get(idx)
			if !item.is_valid() || item.is_null() || item.is_undef() {
				continue
			}
			name := item.to_string().trim_space()
			if name == '' || name == '.' || name == '..' {
				continue
			}
			out << name
		}
		out.sort()
		return out
	})
}

fn php_include_once(path string) vphp.ZVal {
	return vphp.include_once(path)
}

fn php_class_exists(class_name string) bool {
	if class_name.trim_space() == '' {
		return false
	}
	return vphp.php_call_result_bool('class_exists', [
		vphp.RequestOwnedZBox.new_string(class_name).to_zval(),
		vphp.RequestOwnedZBox.new_bool(true).to_zval(),
	])
}

fn is_windows_drive_root_path(path string) bool {
	return pathutil.is_windows_drive_root_path(path)
}

fn normalize_bootstrap_dir_path(path string) string {
	return pathutil.normalize_bootstrap_dir_path(path)
}

fn path_join(base string, child string) string {
	return pathutil.path_join(base, child)
}

fn path_dirname(path string) string {
	return pathutil.path_dirname(path)
}

fn path_file_stem(path string) string {
	return pathutil.path_file_stem(path)
}

fn is_bootstrap_dir_path(path string) bool {
	return pathutil.is_bootstrap_dir_path(path)
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
		mut result := vphp.call_request_owned_box(value, [app_self_zval(&app)])
		defer {
			result.release()
		}
		result_z := result.to_zval()
		if !result_z.is_valid() || result_z.is_null() || result_z.is_undef() {
			return
		}
		if result_z.is_object() && result_z.is_instance_of('VSlim\\App') {
			return
		}
		apply_app_bootstrap_spec(mut app, result_z)!
		return
	}
	if value.is_object() && value.is_instance_of('VSlim\\App') {
		return
	}
	apply_app_bootstrap_spec(mut app, value)!
}

fn app_bootstrap_file_apply(mut app VSlimApp, path string) ! {
	clean := path.trim_space()
	if clean == '' {
		return error('bootstrap path must not be empty')
	}
	result := vphp.include(clean)
	lower := clean.to_lower()
	should_preload := lower.ends_with('/bootstrap/app.php')
		|| lower.ends_with('\\bootstrap\\app.php') || lower.ends_with('/app.php')
		|| lower.ends_with('\\app.php')
	file_exists := php_is_file(clean)
	cli_debug_log('bootstrap_file clean="${clean}" lower="${lower}" should_preload=${should_preload} is_file=${file_exists}')
	if should_preload && file_exists {
		project_root := if is_bootstrap_dir_path(path_dirname(clean)) {
			path_dirname(path_dirname(clean))
		} else {
			path_dirname(clean)
		}
		if project_root != '' {
			cli_debug_log('bootstrap_file preload project_root="${project_root}"')
			preload_bootstrap_spec_classes(project_root, result)
		}
	}
	apply_bootstrap_file_result(mut app, clean, result)!
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
	borrowed := vphp.RequestBorrowedZBox.from_zval(raw)
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
			if !is_supported_registration_kind(kind, vphp.RequestBorrowedZBox.from_zval(item)) {
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
		app.set_clock(vphp.borrow_zbox(value))
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
			mut app_z := app_self_zval(&app)
			defer {
				app_z.release()
			}
			vphp.with_method_result_zval(app_z, 'mcp', []vphp.ZVal{}, fn [value] (mcp vphp.ZVal) bool {
				vphp.with_call_result_zval(value, [mcp], fn (result vphp.ZVal) bool {
					return result.is_valid()
				})
				return true
			})
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
		app.set_not_found_handler(vphp.borrow_zbox(value))
	}
	if value := app_bootstrap_lookup(spec, ['error', 'error_handler', 'errorHandler']) {
		if !value.is_valid() || !value.is_callable() {
			return error('bootstrap error handler must be callable')
		}
		app.set_error_handler(vphp.borrow_zbox(value))
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
		app.helper(key, vphp.borrow_zbox(handler))
	}
}

fn apply_app_bootstrap_middleware_stack(mut app VSlimApp, spec vphp.ZVal, keys []string, kind MiddlewareRegistrationKind, label string) ! {
	value := app_bootstrap_lookup(spec, keys) or { return }
	items := normalize_app_bootstrap_middleware_items(value, kind, label)!
	for item in items {
		match kind {
			.standard { app.middleware(vphp.borrow_zbox(item)) }
			.before { app.before(vphp.borrow_zbox(item)) }
			.after { app.after(vphp.borrow_zbox(item)) }
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
		vphp.with_call_result_zval(item, [app_z], fn (result vphp.ZVal) bool {
			return result.is_valid()
		})
	}
}

fn call_app_bootstrap_hook_result(raw vphp.ZVal, app_z vphp.ZVal, label string) ! {
	items := normalize_app_bootstrap_hook_items(raw)!
	for item in items {
		if !item.is_valid() || !item.is_callable() {
			return error('bootstrap ${label} entries must be callable')
		}
		vphp.with_call_result_zval(item, [app_z], fn (result vphp.ZVal) bool {
			return result.is_valid()
		})
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
	providers := vphp.PhpIterable.from_zval(raw) or {
		return error('bootstrap providers file "${path}" must return iterable providers')
	}
	app.register_many(providers)
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
	modules := vphp.PhpIterable.from_zval(raw) or {
		return error('bootstrap modules file "${path}" must return iterable modules')
	}
	app.module_many(modules)
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

fn bootstrap_project_class_file(project_root string, class_name string) string {
	clean := class_name.trim_space()
	if !clean.starts_with('App\\') {
		return ''
	}
	relative := clean[4..].replace('\\', '/')
	if relative == '' {
		return ''
	}
	return path_join(project_root, 'app/' + relative + '.php')
}

fn preload_bootstrap_spec_class_items(project_root string, raw vphp.ZVal) {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return
	}
	if raw.is_string() {
		class_name := raw.to_string()
		file := bootstrap_project_class_file(project_root, class_name)
		cli_debug_log('bootstrap_spec_class class="${class_name}" file="${file}" is_file=${if file == '' {
			false
		} else {
			php_is_file(file)
		}}')
		if file != '' && php_is_file(file) {
			loaded := php_include_once(file)
			cli_debug_log('bootstrap_spec_class include class="${class_name}" file="${file}" loaded_valid=${loaded.is_valid()} loaded_type=${loaded.type_name()} exists=${php_class_exists(class_name)}')
		}
		return
	}
	if !raw.is_array() {
		return
	}
	for idx := 0; idx < raw.array_count(); idx++ {
		preload_bootstrap_spec_class_items(project_root, raw.array_get(idx))
	}
}

fn preload_bootstrap_spec_classes(project_root string, raw vphp.ZVal) {
	normalized := normalize_app_bootstrap_spec(raw) or { return }
	if providers := app_bootstrap_lookup(normalized, ['providers']) {
		preload_bootstrap_spec_class_items(project_root, providers)
	}
	if modules := app_bootstrap_lookup(normalized, ['modules']) {
		preload_bootstrap_spec_class_items(project_root, modules)
	}
	for file in php_glob_paths(path_join(project_root, 'app/Http/Controllers/*.php')) {
		_ = php_include_once(file)
	}
	for file in php_glob_paths(path_join(project_root, 'app/Http/Middleware/*.php')) {
		_ = php_include_once(file)
	}
}

fn preload_bootstrap_project_classes(project_root string) {
	if project_root.trim_space() == '' {
		return
	}
	support_file := path_join(project_root, 'support.php')
	if php_is_file(support_file) {
		_ = php_include_once(support_file)
	}
	patterns := [
		path_join(project_root, 'app/Providers/*.php'),
		path_join(project_root, 'app/Modules/*.php'),
		path_join(project_root, 'app/Http/Controllers/*.php'),
		path_join(project_root, 'app/Http/Middleware/*.php'),
	]
	for pattern in patterns {
		for file in php_glob_paths(pattern) {
			_ = php_include_once(file)
		}
	}
}

fn apply_bootstrap_convention_provider_classes(mut app VSlimApp, project_root string) !bool {
	mut applied := false
	for file in php_glob_paths(path_join(project_root, 'app/Providers/*.php')) {
		_ = php_include_once(file)
		class_name := 'App\\Providers\\' + path_file_stem(file)
		if !php_class_exists(class_name) {
			return error('provider convention file "${file}" must declare class ${class_name}')
		}
		app.register(vphp.borrow_zbox(vphp.RequestOwnedZBox.new_string(class_name).to_zval()))
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
		app.mount_module(vphp.borrow_zbox(vphp.RequestOwnedZBox.new_string(class_name).to_zval()))
		applied = true
	}
	return applied
}

fn bootstrap_controller_declares_own_constructor(class_name string) bool {
	if class_name.trim_space() == '' || !php_class_exists(class_name) {
		return false
	}
	ref := vphp.php_class('ReflectionClass').construct([
		vphp.RequestOwnedZBox.new_string(class_name).to_zval(),
	])
	if !ref.is_valid() || !ref.is_object() {
		return false
	}
	ctor := ref.method('getConstructor', []vphp.ZVal{})
	if !ctor.is_valid() || ctor.is_null() || !ctor.is_object() {
		return false
	}
	declaring := ctor.method('getDeclaringClass', []vphp.ZVal{})
	if !declaring.is_valid() || !declaring.is_object() {
		return false
	}
	return declaring.method('getName', []vphp.ZVal{}).to_string().trim_space() == class_name
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
			&& vphp.php_class(class_name).is_subclass_of('VSlim\\Controller')
			&& !bootstrap_controller_declares_own_constructor(class_name) {
			controller := vphp.php_class(class_name).construct([app_z])
			if !controller.is_valid() || !controller.is_object() {
				return error('controller class "${class_name}" could not be instantiated')
			}
			container.set(class_name, vphp.borrow_zbox(controller))
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
		vphp.with_call_result_zval(raw, [app_self_zval(&app)], fn (result vphp.ZVal) bool {
			return result.is_valid()
		})
		return true
	}
	apply_app_bootstrap_spec(mut app, raw)!
	return true
}

fn apply_bootstrap_shared_conventions(mut app VSlimApp, project_root string) !bool {
	mut applied := false
	config_candidates := [path_join(project_root, 'config'),
		path_join(project_root, 'config/app.toml'), path_join(project_root, 'app.toml')]
	for candidate in config_candidates {
		if php_is_file(candidate) || php_is_dir(candidate) {
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
		provider_iter := vphp.PhpIterable.from_zval(providers) or {
			return error('bootstrap providers must be iterable')
		}
		app.register_many(provider_iter)
	}
	if modules := app_bootstrap_lookup(normalized, ['modules']) {
		module_iter := vphp.PhpIterable.from_zval(modules) or {
			return error('bootstrap modules must be iterable')
		}
		app.module_many(module_iter)
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

@[php_method]
pub fn (mut app VSlimApp) bootstrap(spec vphp.PhpIterable) &VSlimApp {
	apply_app_bootstrap_spec(mut app, spec.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	return &app
}

@[php_method: 'bootstrapFile']
pub fn (mut app VSlimApp) bootstrap_file(path string) &VSlimApp {
	app_bootstrap_file_apply(mut app, path) or {
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
	if !clean.ends_with('.php') {
		preload_bootstrap_project_classes(clean)
	}
	if clean.ends_with('.php') && php_is_file(clean) {
		result := vphp.include(clean)
		lower := clean.to_lower()
		should_preload := lower.ends_with('/bootstrap/app.php')
			|| lower.ends_with('\\bootstrap\\app.php') || lower.ends_with('/app.php')
			|| lower.ends_with('\\app.php')
		if should_preload {
			project_root := if is_bootstrap_dir_path(path_dirname(clean)) {
				path_dirname(path_dirname(clean))
			} else {
				path_dirname(clean)
			}
			if project_root != '' {
				preload_bootstrap_spec_classes(project_root, result)
			}
		}
		apply_bootstrap_file_result(mut app, clean, result) or {
			vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
			return &app
		}
		return &app
	}
	bootstrap_candidate := clean + '/bootstrap/app.php'
	if php_is_file(bootstrap_candidate) {
		result := vphp.include(bootstrap_candidate)
		project_root := if is_bootstrap_dir_path(path_dirname(bootstrap_candidate)) {
			path_dirname(path_dirname(bootstrap_candidate))
		} else {
			path_dirname(bootstrap_candidate)
		}
		if project_root != '' {
			preload_bootstrap_spec_classes(project_root, result)
		}
		apply_bootstrap_file_result(mut app, bootstrap_candidate, result) or {
			vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
			return &app
		}
		return &app
	}
	app_candidate := clean + '/app.php'
	if php_is_file(app_candidate) {
		result := vphp.include(app_candidate)
		project_root := if is_bootstrap_dir_path(path_dirname(app_candidate)) {
			path_dirname(path_dirname(app_candidate))
		} else {
			path_dirname(app_candidate)
		}
		if project_root != '' {
			preload_bootstrap_spec_classes(project_root, result)
		}
		apply_bootstrap_file_result(mut app, app_candidate, result) or {
			vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
			return &app
		}
		return &app
	}
	apply_bootstrap_conventions(mut app, clean) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	return &app
}

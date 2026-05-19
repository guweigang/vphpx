module main

import pathutil
import vphp

fn bootstrap_file_return_error(path string) string {
	return 'bootstrap file "${path}" must return iterable spec, callable, or VSlim\\App'
}

fn path_is_file(path string) bool {
	mut path_arg := vphp.PhpString.of(path)
	defer {
		path_arg.release()
	}
	return vphp.PhpFunction.named('is_file').result_bool(path_arg)
}

fn path_is_dir(path string) bool {
	mut path_arg := vphp.PhpString.of(path)
	defer {
		path_arg.release()
	}
	return vphp.PhpFunction.named('is_dir').result_bool(path_arg)
}

fn join_path(base string, child string) string {
	mut frame := vphp.PhpScope.frame()
	defer {
		frame.release()
	}
	trimmed := vphp.PhpFunction.named('rtrim').result_string(frame.string(base),
		frame.string('/\\'))
	return vphp.PhpFunction.named('sprintf').result_string(frame.string('%s/%s'),
		frame.string(trimmed), frame.string(child))
}

fn glob_paths(pattern string) []string {
	mut frame := vphp.PhpScope.frame()
	defer {
		frame.release()
	}
	return vphp.PhpFunction.named('glob').with_result[vphp.PhpArray, []string](fn (result vphp.PhpArray) []string {
		mut out := []string{}
		for item in result.to_string_list() {
			path := item.trim_space()
			if path != '' {
				out << path
			}
		}
		out.sort()
		return out
	}, frame.string(pattern)) or { []string{} }
}

fn scandir_names(path string) []string {
	mut path_arg := vphp.PhpString.of(path)
	defer {
		path_arg.release()
	}
	return vphp.PhpFunction.named('scandir').with_result[vphp.PhpArray, []string](fn (result vphp.PhpArray) []string {
		mut out := []string{}
		for item in result.to_string_list() {
			name := item.trim_space()
			if name == '' || name == '.' || name == '..' {
				continue
			}
			out << name
		}
		out.sort()
		return out
	}, path_arg) or { []string{} }
}

fn include_once_file(path string) vphp.PhpValue {
	return vphp.PhpIncludeFile.at(path).load_once()
}

fn class_exists_name(class_name string) bool {
	if class_name.trim_space() == '' {
		return false
	}
	mut class_arg := vphp.PhpString.of(class_name)
	mut autoload_arg := vphp.PhpBool.of(true)
	defer {
		class_arg.release()
		autoload_arg.release()
	}
	return vphp.PhpFunction.named('class_exists').result_bool(class_arg, autoload_arg)
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

fn iterable_array(raw vphp.PhpValue) !vphp.PhpArray {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('value must be iterable')
	}
	iter := raw.as_iterable() or { return error('value must be iterable') }
	return iter.to_array()!
}

fn normalize_app_bootstrap_spec(raw vphp.PhpValue) !vphp.PhpArray {
	return iterable_array(raw) or { return error('bootstrap spec must be iterable') }
}

fn normalize_app_bootstrap_iterable(raw vphp.PhpIterable) !vphp.PhpArray {
	return raw.to_array() or { return error('bootstrap spec must be iterable') }
}

struct AppBootstrapSpec {
	spec vphp.PhpArray
}

fn app_bootstrap_spec(spec vphp.PhpArray) AppBootstrapSpec {
	return AppBootstrapSpec{
		spec: spec
	}
}

fn (subject AppBootstrapSpec) lookup(keys []string) ?vphp.PhpValue {
	for key in keys {
		if key.trim_space() == '' {
			continue
		}
		value := subject.spec.value(key) or { continue }
		if !value.is_valid() || value.is_undef() {
			continue
		}
		return value
	}
	return none
}

fn (subject AppBootstrapSpec) string(keys []string) ?string {
	value := subject.lookup(keys) or { return none }
	if value.is_null() || value.is_undef() {
		return none
	}
	text := value.to_string().trim_space()
	if text == '' {
		return none
	}
	return text
}

fn (subject AppBootstrapSpec) bool(keys []string) ?bool {
	value := subject.lookup(keys) or { return none }
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

fn (mut app VSlimApp) apply_bootstrap_file_result(path string, value vphp.PhpValue) ! {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return error(bootstrap_file_return_error(path))
	}
	if value.is_callable() {
		mut app_value := (&app).self_value()
		defer {
			app_value.release()
		}
		callable := value.as_callable() or { return error(bootstrap_file_return_error(path)) }
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
	file_exists := path_is_file(clean)
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
	app.apply_bootstrap_file_result(clean, result)!
}

fn (subject PhpValueSubject) call_bootstrap_callable_item(app_value vphp.PhpValue, label string) ! {
	callable := vphp.PhpCallable.from_value(subject.value) or {
		return error('bootstrap ${label} entries must be callable')
	}
	callable.with_result[vphp.PhpValue, bool](fn (result vphp.PhpValue) bool {
		return result.is_valid()
	}, app_value) or { false }
}

fn (subject PhpValueSubject) call_bootstrap_callable_items(app_value vphp.PhpValue, label string) ! {
	raw := subject.value
	if raw.is_valid() && raw.is_callable() {
		subject.call_bootstrap_callable_item(app_value, label)!
		return
	}
	iter := raw.as_iterable() or {
		return error('bootstrap ${label} must be callable or callable list')
	}
	mut normalized := iter.to_array()!
	defer {
		normalized.release()
	}
	for item in normalized.value_items() {
		value_subject(item).call_bootstrap_callable_item(app_value, label)!
	}
}

fn require_native_bootstrap_object[T](value vphp.PhpValue, class_name string, label string) !&T {
	if !value.is_valid() || !value.is_object() || !value.is_instance_of(class_name) {
		return error('bootstrap ${label} must be ${class_name}')
	}
	obj := value.to_v_object[T]() or {
		return error('bootstrap ${label} must be a native ${class_name} object')
	}
	return obj
}

fn (mut app VSlimApp) apply_bootstrap_container(spec vphp.PhpArray) ! {
	value := app_bootstrap_spec(spec).lookup(['container']) or { return }
	container := require_native_bootstrap_object[VSlimContainer](value, 'VSlim\\Container',
		'container')!
	app.set_container(container)
}

fn (mut app VSlimApp) apply_bootstrap_config(spec vphp.PhpArray) ! {
	if value := app_bootstrap_spec(spec).lookup(['config']) {
		config := require_native_bootstrap_object[VSlimConfig](value, 'VSlim\\Config', 'config')!
		app.set_config(config)
	}
	if config_path := app_bootstrap_spec(spec).string(['config_path', 'configPath', 'config_file',
		'configFile'])
	{
		app.load_config(config_path)
	}
	if config_text := app_bootstrap_spec(spec).string(['config_text', 'configText']) {
		app.load_config_text(config_text)
	}
}

fn (mut app VSlimApp) apply_bootstrap_runtime_flags(spec vphp.PhpArray) {
	if base_path := app_bootstrap_spec(spec).string(['base_path', 'basePath']) {
		app.set_base_path(base_path)
	}
	if view_base_path := app_bootstrap_spec(spec).string(['view_base_path', 'viewBasePath']) {
		app.set_view_base_path(view_base_path)
	}
	if assets_prefix := app_bootstrap_spec(spec).string(['assets_prefix', 'assetsPrefix']) {
		app.set_assets_prefix(assets_prefix)
	}
	if enabled := app_bootstrap_spec(spec).bool(['view_cache', 'viewCache']) {
		app.set_view_cache(enabled)
	}
	if enabled := app_bootstrap_spec(spec).bool(['error_response_json', 'errorResponseJson']) {
		app.set_error_response_json(enabled)
	}
}

fn (mut app VSlimApp) apply_bootstrap_services(spec vphp.PhpArray) ! {
	if value := app_bootstrap_spec(spec).lookup(['clock']) {
		if !psr20_is_clock(value) {
			return error('bootstrap clock must implement Psr\\Clock\\ClockInterface')
		}
		clock := value.as_object() or { return error('bootstrap clock must be an object') }
		app.set_clock(clock)
	}
	if value := app_bootstrap_spec(spec).lookup(['logger']) {
		logger := require_native_bootstrap_object[VSlimLogger](value, 'VSlim\\Log\\Logger',
			'logger')!
		app.set_logger(logger)
	}
	if value := app_bootstrap_spec(spec).lookup(['listener_provider', 'listenerProvider']) {
		provider := require_native_bootstrap_object[VSlimPsr14ListenerProvider](value,
			'VSlim\\Psr14\\ListenerProvider', 'listener_provider')!
		app.set_listener_provider(provider)
	}
	if value := app_bootstrap_spec(spec).lookup(['dispatcher']) {
		dispatcher := require_native_bootstrap_object[VSlimPsr14EventDispatcher](value,
			'VSlim\\Psr14\\EventDispatcher', 'dispatcher')!
		app.set_dispatcher(dispatcher)
	}
	if value := app_bootstrap_spec(spec).lookup(['cache']) {
		cache := require_native_bootstrap_object[VSlimPsr16Cache](value, 'VSlim\\Psr16\\Cache',
			'cache')!
		app.set_cache(cache)
	}
	if value := app_bootstrap_spec(spec).lookup(['cache_pool', 'cachePool']) {
		pool := require_native_bootstrap_object[VSlimPsr6CacheItemPool](value,
			'VSlim\\Psr6\\CacheItemPool', 'cache_pool')!
		app.set_cache_pool(pool)
	}
	if value := app_bootstrap_spec(spec).lookup(['http_client', 'httpClient']) {
		client := require_native_bootstrap_object[VSlimPsr18Client](value, 'VSlim\\Psr18\\Client',
			'http_client')!
		app.set_http_client(client)
	}
	if value := app_bootstrap_spec(spec).lookup(['mcp']) {
		if value.is_callable() {
			mut app_value := (&app).self_value()
			defer {
				app_value.release()
			}
			app_value.with_object[bool](fn [value] (app_obj vphp.PhpObject) bool {
				return app_obj.with_method_result[vphp.PhpValue, bool]('mcp', fn [value] (mcp vphp.PhpValue) bool {
				callable := vphp.PhpCallable.from_value(value) or { return false }
				callable.with_result[vphp.PhpValue, bool](fn (result vphp.PhpValue) bool {
					return result.is_valid()
				}, mcp) or { false }
				return true
				}) or { false }
			}) or { false }
		} else {
			mcp := require_native_bootstrap_object[VSlimMcpApp](value, 'VSlim\\Mcp\\App', 'mcp')!
			app.set_mcp(mcp)
		}
	}
}

fn (mut app VSlimApp) apply_bootstrap_handlers(spec vphp.PhpArray) ! {
	if value := app_bootstrap_spec(spec).lookup(['not_found', 'notFound']) {
		callable := vphp.PhpCallable.from_value(value) or {
			return error('bootstrap not_found must be callable')
		}
		app.set_not_found_handler(callable)
	}
	if value := app_bootstrap_spec(spec).lookup(['error', 'error_handler', 'errorHandler']) {
		callable := vphp.PhpCallable.from_value(value) or {
			return error('bootstrap error handler must be callable')
		}
		app.set_error_handler(callable)
	}
}

fn (mut app VSlimApp) apply_bootstrap_helpers(spec vphp.PhpArray) ! {
	helpers := app_bootstrap_spec(spec).lookup(['helpers', 'view_helpers', 'viewHelpers']) or { return }
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

fn (mut app VSlimApp) apply_bootstrap_middleware_stack(spec vphp.PhpArray, keys []string, kind MiddlewareRegistrationKind, label string) ! {
	value := app_bootstrap_spec(spec).lookup(keys) or { return }
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return error('bootstrap ${label} must not be null')
	}
	if value.is_string() || value_subject(value).is_supported_middleware_handler()
		|| is_bootstrap_callable_pair(value) {
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
		if !kind.supports_registration(item) {
			return error('bootstrap ${label} entries must be middleware registrations')
		}
		app.apply_bootstrap_middleware_item(kind, label, item)!
	}
}

fn is_bootstrap_callable_pair(value vphp.PhpValue) bool {
	arr := value.as_array() or { return false }
	return arr.is_list() && arr.count() == 2 && arr.index_value(0).is_string()
		&& arr.index_value(1).is_string()
}

fn (mut app VSlimApp) apply_bootstrap_middleware_item(kind MiddlewareRegistrationKind, label string, handler vphp.PhpValue) ! {
	if !kind.supports_registration(handler) {
		return error('bootstrap ${label} must contain valid middleware registrations')
	}
	match kind {
		.standard { app.middleware(handler) }
		.before { app.before(handler) }
		.after { app.after(handler) }
	}
}

fn (subject AppBootstrapSpec) call_hooks(keys []string, app_value vphp.PhpValue, label string) ! {
	raw := subject.lookup(keys) or { return }
	value_subject(raw).call_bootstrap_callable_items(app_value, label)!
}

fn (subject PhpValueSubject) call_bootstrap_hook_result(app_value vphp.PhpValue, label string) ! {
	subject.call_bootstrap_callable_items(app_value, label)!
}

fn (mut app VSlimApp) apply_bootstrap_convention_providers(path string) !bool {
	if !path_is_file(path) {
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
	if !path_is_file(path) {
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

struct BootstrapConventionHookFile {
	path string
}

fn bootstrap_convention_hook_file(path string) BootstrapConventionHookFile {
	return BootstrapConventionHookFile{
		path: path
	}
}

fn (file BootstrapConventionHookFile) apply(app_value vphp.PhpValue, label string) !bool {
	if !path_is_file(file.path) {
		return false
	}
	mut raw := vphp.PhpIncludeFile.at(file.path).load()
	defer {
		raw.release()
	}
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap ${label} file "${file.path}" must return callable or callable list')
	}
	value_subject(raw).call_bootstrap_hook_result(app_value, label)!
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

fn preload_bootstrap_spec_class_items(project_root string, raw vphp.PhpValue) {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return
	}
	if raw.is_string() {
		class_name := raw.to_string()
		file := bootstrap_project_class_file(project_root, class_name)
		cli_debug_log('bootstrap_spec_class class="${class_name}" file="${file}" is_file=${if file == '' {
			false
		} else {
			path_is_file(file)
		}}')
		if file != '' && path_is_file(file) {
			loaded := include_once_file(file)
			cli_debug_log('bootstrap_spec_class include class="${class_name}" file="${file}" loaded_valid=${loaded.is_valid()} loaded_type=${loaded.kind_name()} exists=${class_exists_name(class_name)}')
		}
		return
	}
	arr := raw.as_array() or {
		return
	}
	for idx := 0; idx < arr.count(); idx++ {
		preload_bootstrap_spec_class_items(project_root, arr.index_value(idx))
	}
}

fn preload_bootstrap_spec_classes(project_root string, raw vphp.PhpValue) {
	normalized := normalize_app_bootstrap_spec(raw) or { return }
	if providers := app_bootstrap_spec(normalized).lookup(['providers']) {
		preload_bootstrap_spec_class_items(project_root, providers)
	}
	if modules := app_bootstrap_spec(normalized).lookup(['modules']) {
		preload_bootstrap_spec_class_items(project_root, modules)
	}
	for file in glob_paths(path_join(project_root, 'app/Http/Controllers/*.php')) {
		_ = include_once_file(file)
	}
	for file in glob_paths(path_join(project_root, 'app/Http/Middleware/*.php')) {
		_ = include_once_file(file)
	}
}

fn preload_bootstrap_project_classes(project_root string) {
	if project_root.trim_space() == '' {
		return
	}
	support_file := path_join(project_root, 'support.php')
	if path_is_file(support_file) {
		_ = include_once_file(support_file)
	}
	patterns := [
		path_join(project_root, 'app/Providers/*.php'),
		path_join(project_root, 'app/Modules/*.php'),
		path_join(project_root, 'app/Http/Controllers/*.php'),
		path_join(project_root, 'app/Http/Middleware/*.php'),
	]
	for pattern in patterns {
		for file in glob_paths(pattern) {
			_ = include_once_file(file)
		}
	}
}

fn (mut app VSlimApp) apply_bootstrap_convention_provider_classes(project_root string) !bool {
	mut applied := false
	for file in glob_paths(path_join(project_root, 'app/Providers/*.php')) {
		_ = include_once_file(file)
		class_name := 'App\\Providers\\' + path_file_stem(file)
		if !class_exists_name(class_name) {
			return error('provider convention file "${file}" must declare class ${class_name}')
		}
		app.register_service_provider_class(class_name)!
		applied = true
	}
	return applied
}

fn (mut app VSlimApp) apply_bootstrap_convention_module_classes(project_root string) !bool {
	mut applied := false
	for file in glob_paths(path_join(project_root, 'app/Modules/*.php')) {
		_ = include_once_file(file)
		class_name := 'App\\Modules\\' + path_file_stem(file)
		if !class_exists_name(class_name) {
			return error('module convention file "${file}" must declare class ${class_name}')
		}
		app.register_module_class(class_name)!
		applied = true
	}
	return applied
}

fn bootstrap_controller_declares_own_constructor(class_name string) bool {
	if class_name.trim_space() == '' || !class_exists_name(class_name) {
		return false
	}
	mut class_arg := vphp.PhpString.of(class_name)
	defer {
		class_arg.release()
	}
	ref := vphp.PhpClass.named('ReflectionClass').construct(class_arg) or { return false }
	mut ctor_box := ref.call_method('getConstructor')
	defer {
		ctor_box.release()
	}
	if !ctor_box.is_valid() || ctor_box.is_null() || !ctor_box.is_object() {
		return false
	}
	mut declaring_box := ctor_box.call_method('getDeclaringClass')
	defer {
		declaring_box.release()
	}
	declaring := declaring_box.as_object() or {
		return false
	}
	return declaring.method[string]('getName') or { '' }.trim_space() == class_name
}

fn (mut app VSlimApp) apply_bootstrap_convention_http_classes(project_root string) !bool {
	mut applied := false
	mut container := app.container()
	mut app_value := (&app).self_value()
	defer {
		app_value.release()
	}
	for file in glob_paths(path_join(project_root, 'app/Http/Controllers/*.php')) {
		_ = include_once_file(file)
		class_name := 'App\\Http\\Controllers\\' + path_file_stem(file)
		if !class_exists_name(class_name) {
			return error('controller convention file "${file}" must declare class ${class_name}')
		}
		if !container.has(class_name)
			&& vphp.PhpClass.named(class_name).is_subclass_of('VSlim\\Controller')
			&& !bootstrap_controller_declares_own_constructor(class_name) {
			controller_obj := vphp.PhpClass.named(class_name).construct(app_value) or {
				return error('controller class "${class_name}" could not be instantiated')
			}
			container.set_object(class_name, controller_obj)
		}
		applied = true
	}
	for file in glob_paths(path_join(project_root, 'app/Http/Middleware/*.php')) {
		_ = include_once_file(file)
		class_name := 'App\\Http\\Middleware\\' + path_file_stem(file)
		if !class_exists_name(class_name) {
			return error('middleware convention file "${file}" must declare class ${class_name}')
		}
		applied = true
	}
	return applied
}

fn (mut app VSlimApp) apply_bootstrap_convention_spec(path string, label string) !bool {
	if !path_is_file(path) {
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

fn (mut app VSlimApp) apply_bootstrap_shared_conventions(project_root string) !bool {
	mut applied := false
	config_candidates := [path_join(project_root, 'config'),
		path_join(project_root, 'config/app.toml'), path_join(project_root, 'app.toml')]
	for candidate in config_candidates {
		if path_is_file(candidate) || path_is_dir(candidate) {
			app.load_config(candidate)
			applied = true
			break
		}
	}
	if app.apply_bootstrap_convention_spec(path_join(project_root, 'bootstrap/runtime.php'),
		'runtime')!
	{
		applied = true
	}
	if app.apply_bootstrap_convention_spec(path_join(project_root, 'bootstrap/services.php'),
		'services')!
	{
		applied = true
	}
	if app.apply_bootstrap_convention_spec(path_join(project_root, 'bootstrap/errors.php'),
		'errors')!
	{
		applied = true
	}
	if app.view_base_path() == '' {
		view_candidates := [path_join(project_root, 'views'),
			path_join(project_root, 'resources/views')]
		for view_dir in view_candidates {
			if !path_is_dir(view_dir) {
				continue
			}
			app.set_view_base_path(view_dir)
			applied = true
			break
		}
	}
	if app.apply_bootstrap_convention_providers(path_join(project_root,
		'bootstrap/providers.php'))!
	{
		applied = true
	}
	if app.apply_bootstrap_convention_provider_classes(project_root)! {
		applied = true
	}
	if app.apply_bootstrap_convention_modules(path_join(project_root, 'bootstrap/modules.php'))! {
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
	if app.apply_bootstrap_convention_spec(path_join(project_root, 'app/Http/errors.php'),
		'errors')!
	{
		applied = true
	}
	if bootstrap_convention_hook_file(path_join(project_root, 'app/Http/controllers.php')).apply(app_value,
		'controllers')!
	{
		applied = true
	}
	if bootstrap_convention_hook_file(path_join(project_root, 'bootstrap/middleware.php')).apply(app_value,
		'middleware')!
	{
		applied = true
	}
	if bootstrap_convention_hook_file(path_join(project_root, 'app/Http/middleware.php')).apply(app_value,
		'middleware')!
	{
		applied = true
	}
	for route_file in glob_paths(path_join(project_root, 'routes/*.php')) {
		_ = bootstrap_convention_hook_file(route_file).apply(app_value, 'routes')!
		applied = true
	}
	for route_file in glob_paths(path_join(project_root, 'app/Http/routes/*.php')) {
		_ = bootstrap_convention_hook_file(route_file).apply(app_value, 'routes')!
		applied = true
	}
	return applied
}

fn (mut app VSlimApp) apply_bootstrap_conventions(path string) ! {
	project_root := if is_bootstrap_dir_path(path) { path_dirname(path) } else { path }
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
	normalized := normalize_app_bootstrap_spec(spec)!
	defer {
		normalized.release()
	}
	app.apply_bootstrap_array(normalized)!
}

fn (mut app VSlimApp) apply_bootstrap_iterable(spec vphp.PhpIterable) ! {
	normalized := normalize_app_bootstrap_iterable(spec)!
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
	app.apply_bootstrap_middleware_stack(normalized, ['middleware', 'middlewares'],
		.standard, 'middleware')!
	app.apply_bootstrap_middleware_stack(normalized, ['after'], .after, 'after')!
	if providers := app_bootstrap_spec(normalized).lookup(['providers']) {
		provider_iter := providers.as_iterable() or { return error('bootstrap providers must be iterable') }
		app.register_many(provider_iter)
	}
	if modules := app_bootstrap_spec(normalized).lookup(['modules']) {
		module_iter := modules.as_iterable() or { return error('bootstrap modules must be iterable') }
		app.module_many(module_iter)
	}
	mut app_value := (&app).self_value()
	defer {
		app_value.release()
	}
	app_bootstrap_spec(normalized).call_hooks(['middleware_setup', 'middlewareSetup'], app_value,
		'middleware_setup')!
	app_bootstrap_spec(normalized).call_hooks(['routes'], app_value, 'routes')!
	if should_boot := app_bootstrap_spec(normalized).bool(['boot']) {
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
	clean := normalize_bootstrap_dir_path(path)
	if clean == '' {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'bootstrap directory must not be empty', 0)
		return &app
	}
	if !clean.ends_with('.php') {
		preload_bootstrap_project_classes(clean)
	}
	if clean.ends_with('.php') && path_is_file(clean) {
		mut result := vphp.PhpIncludeFile.at(clean).load()
		defer {
			result.release()
		}
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
		app.apply_bootstrap_file_result(clean, result) or {
			vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
			return &app
		}
		return &app
	}
	bootstrap_candidate := clean + '/bootstrap/app.php'
	if path_is_file(bootstrap_candidate) {
		mut result := vphp.PhpIncludeFile.at(bootstrap_candidate).load()
		defer {
			result.release()
		}
		project_root := if is_bootstrap_dir_path(path_dirname(bootstrap_candidate)) {
			path_dirname(path_dirname(bootstrap_candidate))
		} else {
			path_dirname(bootstrap_candidate)
		}
		if project_root != '' {
			preload_bootstrap_spec_classes(project_root, result)
		}
		app.apply_bootstrap_file_result(bootstrap_candidate, result) or {
			vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
			return &app
		}
		return &app
	}
	app_candidate := clean + '/app.php'
	if path_is_file(app_candidate) {
		mut result := vphp.PhpIncludeFile.at(app_candidate).load()
		defer {
			result.release()
		}
		project_root := if is_bootstrap_dir_path(path_dirname(app_candidate)) {
			path_dirname(path_dirname(app_candidate))
		} else {
			path_dirname(app_candidate)
		}
		if project_root != '' {
			preload_bootstrap_spec_classes(project_root, result)
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

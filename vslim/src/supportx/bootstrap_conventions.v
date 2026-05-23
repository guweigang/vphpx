module supportx

import vphp

pub struct BootstrapConventionHookFile {
	path string
}

pub fn bootstrap_convention_hook_file(path string) BootstrapConventionHookFile {
	return BootstrapConventionHookFile{
		path: path
	}
}

pub fn is_bootstrap_callable_pair(value vphp.PhpValue) bool {
	arr := value.as_array() or { return false }
	return arr.is_list() && arr.count() == 2 && arr.index_value(0).is_string()
		&& arr.index_value(1).is_string()
}

pub fn (file BootstrapConventionHookFile) apply(app_value vphp.PhpValue, label string) !bool {
	if !is_file(file.path) {
		return false
	}
	mut raw := vphp.PhpIncludeFile.at(file.path).load()
	defer {
		raw.release()
	}
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap ${label} file "${file.path}" must return callable or callable list')
	}
	call_bootstrap_callable_items(raw, app_value, label)!
	return true
}

pub fn bootstrap_project_class_file(project_root string, class_name string) string {
	clean := class_name.trim_space()
	if !clean.starts_with('App\\') {
		return ''
	}
	relative := clean[4..].replace('\\', '/')
	if relative == '' {
		return ''
	}
	return join_path(project_root, 'app/' + relative + '.php')
}

pub fn preload_bootstrap_spec_class_items(project_root string, raw vphp.PhpValue) {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return
	}
	if raw.is_string() {
		class_name := raw.to_string()
		file := bootstrap_project_class_file(project_root, class_name)
		if file != '' && is_file(file) {
			_ = include_once_file(file)
		}
		return
	}
	arr := raw.as_array() or { return }
	for idx := 0; idx < arr.count(); idx++ {
		preload_bootstrap_spec_class_items(project_root, arr.index_value(idx))
	}
}

pub fn preload_bootstrap_spec_classes(project_root string, raw vphp.PhpValue) {
	normalized := normalize_app_bootstrap_spec(raw) or { return }
	defer {
		normalized.release()
	}
	if providers := app_bootstrap_spec(normalized).lookup(['providers']) {
		preload_bootstrap_spec_class_items(project_root, providers)
	}
	if modules := app_bootstrap_spec(normalized).lookup(['modules']) {
		preload_bootstrap_spec_class_items(project_root, modules)
	}
	for file in glob_paths(join_path(project_root, 'app/Http/Controllers/*.php')) {
		_ = include_once_file(file)
	}
	for file in glob_paths(join_path(project_root, 'app/Http/Middleware/*.php')) {
		_ = include_once_file(file)
	}
}

pub fn preload_bootstrap_project_classes(project_root string) {
	if project_root.trim_space() == '' {
		return
	}
	support_file := join_path(project_root, 'support.php')
	if is_file(support_file) {
		_ = include_once_file(support_file)
	}
	patterns := [
		join_path(project_root, 'app/Providers/*.php'),
		join_path(project_root, 'app/Modules/*.php'),
		join_path(project_root, 'app/Http/Controllers/*.php'),
		join_path(project_root, 'app/Http/Middleware/*.php'),
	]
	for pattern in patterns {
		for file in glob_paths(pattern) {
			_ = include_once_file(file)
		}
	}
}

pub fn bootstrap_controller_declares_own_constructor(class_name string) bool {
	if class_name.trim_space() == '' || !class_exists(class_name) {
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
	declaring := declaring_box.as_object() or { return false }
	return declaring.method[string]('getName') or { '' }.trim_space() == class_name
}

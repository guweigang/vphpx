module supportx

import os
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

pub fn (file BootstrapConventionHookFile) apply(app_value vphp.PhpValue, label string, mut progress BootstrapProgress) !bool {
	step := 'hook:' + file.path
	if progress.done(step) {
		return true
	}
	if !is_file(file.path) {
		return false
	}
	mut raw := progress.load(file.path)!
	defer {
		raw.release()
	}
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('bootstrap ${label} file "${file.path}" must return callable or callable list')
	}
	call_bootstrap_callable_items(raw, app_value, label, step, mut progress)!
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

fn preload_bootstrap_spec_class_items(project_root string, raw vphp.PhpValue) ! {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return
	}
	if raw.is_string() {
		class_name := raw.to_string()
		file := bootstrap_project_class_file(project_root, class_name)
		if file != '' && is_file(file) {
			preload_bootstrap_class_file(file)!
		}
		return
	}
	arr := raw.as_array() or { return }
	for idx := 0; idx < arr.count(); idx++ {
		preload_bootstrap_spec_class_items(project_root, arr.index_value(idx))!
	}
}

pub fn preload_bootstrap_spec_classes(project_root string, spec AppBootstrapSpec) ! {
	if providers := spec.lookup(['providers']) {
		preload_bootstrap_spec_class_items(project_root, providers)!
	}
	if modules := spec.lookup(['modules']) {
		preload_bootstrap_spec_class_items(project_root, modules)!
	}
}

pub struct BootstrapComponentFiles {
pub:
	providers []string
	modules   []string
}

pub struct BootstrapProjectFiles {
pub:
	components  BootstrapComponentFiles
	controllers []string
	middleware  []string
}

fn preload_bootstrap_class_file(file string) ! {
	mut included := include_once_file(file)
	included.release()
	if vphp.has_exception() {
		return error('bootstrap class file "${file}" evaluation failed')
	}
}

fn preload_bootstrap_class_files(project_root string, relative string, mut progress BootstrapProgress) ![]string {
	pattern := join_path(project_root, relative)
	files := progress.glob_files(pattern)!
	step := 'preload-glob:' + pattern
	if !progress.done(step) {
		for file in files {
			preload_bootstrap_class_file(file)!
		}
		progress.complete(step)
	}
	return files
}

pub fn preload_bootstrap_components(project_root string, mut progress BootstrapProgress) !BootstrapComponentFiles {
	if project_root.trim_space() == '' {
		return BootstrapComponentFiles{}
	}
	support_file := join_path(project_root, 'support.php')
	step := 'preload:' + support_file
	if !progress.done(step) {
		if is_file(support_file) {
			preload_bootstrap_class_file(support_file)!
		}
		progress.complete(step)
	}
	providers := preload_bootstrap_class_files(project_root, 'app/Providers/*.php', mut progress)!
	modules := preload_bootstrap_class_files(project_root, 'app/Modules/*.php', mut progress)!
	return BootstrapComponentFiles{
		providers: providers
		modules:   modules
	}
}

pub fn preload_bootstrap_project_classes(project_root string, mut progress BootstrapProgress) !BootstrapProjectFiles {
	if project_root.trim_space() == '' {
		return BootstrapProjectFiles{}
	}
	components := preload_bootstrap_components(project_root, mut progress)!
	controllers := preload_bootstrap_class_files(project_root, 'app/Http/Controllers/*.php', mut progress)!
	middleware := preload_bootstrap_class_files(project_root, 'app/Http/Middleware/*.php', mut progress)!
	return BootstrapProjectFiles{
		components:  components
		controllers: controllers
		middleware:  middleware
	}
}

pub struct BootstrapDirectory {
pub:
	path          string
	project_root  string
	explicit_file bool
}

pub fn resolve_bootstrap_directory(path string, label string) !BootstrapDirectory {
	clean := normalize_dir_path(path)
	if clean == '' {
		return error('${label} must not be empty')
	}
	if clean.to_lower().ends_with('.php') && !is_dir(clean) {
		return BootstrapDirectory{
			path:          clean
			explicit_file: true
		}
	}
	root := bootstrap_project_root(clean)
	if root == '' {
		return error('${label} has no project root')
	}
	return BootstrapDirectory{
		path:         clean
		project_root: root
	}
}

pub fn (mut progress BootstrapProgress) project_entry(project_root string) !string {
	step := 'project:entry'
	if mut saved := progress.value(step) {
		defer {
			saved.release()
		}
		return saved.to_string()
	}
	entry := find_bootstrap_app_file(project_root)
	if vphp.has_exception() {
		return error('bootstrap project entry lookup failed')
	}
	mut value := vphp.PhpValue.string(entry)
	progress.remember(step, value)
	value.release()
	return entry
}

fn find_bootstrap_app_file(project_root string) string {
	for relative in ['bootstrap/app.php', 'app.php'] {
		candidate := join_path(project_root, relative)
		if is_file(candidate) {
			return os.abs_path(candidate)
		}
	}
	return ''
}

fn bootstrap_project_root(dir string) string {
	return if is_bootstrap_dir_path(dir) { dirname(dir) } else { dir }
}

pub struct BootstrapFile {
pub:
	path          string
	resolved_path string
	project_root  string
}

pub fn resolve_bootstrap_file(path string, label string) !BootstrapFile {
	clean := normalize_dir_path(path)
	if clean == '' {
		return error('${label} path must not be empty')
	}
	mut path_arg := vphp.PhpString.of(clean)
	defer {
		path_arg.release()
	}
	resolved := vphp.PhpFunction.named('stream_resolve_include_path').result_string(path_arg)
	resolved_path := if resolved == '' { clean } else { normalize_dir_path(resolved) }
	if !is_file(resolved_path) {
		return error('${label} file "${clean}" does not exist or is not a file')
	}
	return BootstrapFile{
		path:          clean
		resolved_path: resolved_path
		project_root:  bootstrap_app_project_root(resolved_path)
	}
}

pub fn (file BootstrapFile) load(mut progress BootstrapProgress) !vphp.PhpValue {
	if file.project_root != '' {
		preload_bootstrap_project_classes(file.project_root, mut progress)!
	}
	mut result := load_bootstrap_php_file(file.resolved_path)
	if vphp.has_exception() {
		result.release()
		return error('bootstrap file "${file.path}" evaluation failed')
	}
	return result
}

fn bootstrap_app_project_root(file string) string {
	lower := file.to_lower()
	if lower == 'app.php' {
		return '.'
	}
	if !lower.ends_with('/app.php') {
		return ''
	}
	dir := dirname(file)
	if dir.to_lower() == 'bootstrap' {
		return '.'
	}
	return bootstrap_project_root(dir)
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

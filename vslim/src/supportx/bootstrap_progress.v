module supportx

import registrationx
import vphp

@[heap]
pub struct BootstrapProgress {
	enabled bool
mut:
	active     bool
	completed  map[string]bool
	values     map[string]vphp.PhpValue
	file_lists map[string][]string
}

pub fn BootstrapProgress.tracked() &BootstrapProgress {
	return &BootstrapProgress{ enabled: true }
}

pub fn start_bootstrap_progress(mut runs map[string]&BootstrapProgress, source string) !&BootstrapProgress {
	if mut existing := runs[source] {
		existing.start()!
		return existing
	}
	mut progress := BootstrapProgress.tracked()
	progress.start()!
	runs[source.clone()] = progress
	if mut scope := registrationx.current_registration_scope() {
		owner := &runs
		key := source.clone()
		scope.add_change(fn [owner, key, mut progress] (commit bool) {
			if !commit {
				unsafe {
					owner.delete(key)
				}
				progress.release()
			}
		})
	}
	return progress
}

pub fn (mut p BootstrapProgress) start() ! {
	if p.active {
		return error('bootstrap is already in progress for this input')
	}
	p.active = true
}

pub fn (mut p BootstrapProgress) stop() {
	p.active = false
}

pub fn finish_bootstrap_progress(mut runs map[string]&BootstrapProgress, source string) {
	if mut progress := runs[source] {
		runs.delete(source)
		if mut scope := registrationx.current_registration_scope() {
			owner := &runs
			key := source.clone()
			scope.add_change(fn [owner, key, mut progress] (commit bool) {
				if commit {
					progress.release()
				} else {
					unsafe {
						(*owner)[key] = progress
					}
				}
			})
		} else {
			progress.release()
		}
	}
}

pub fn release_bootstrap_progress(mut runs map[string]&BootstrapProgress) {
	for _, mut progress in runs {
		progress.release()
	}
	unsafe {
		runs.free()
	}
}

pub fn (p &BootstrapProgress) done(step string) bool {
	return step in p.completed
}

pub fn (mut p BootstrapProgress) complete(step string) {
	if !p.enabled || p.done(step) {
		return
	}
	p.completed[step.clone()] = true
	if mut scope := registrationx.current_registration_scope() {
		mut progress := &p
		key := step.clone()
		scope.add_change(fn [mut progress, key] (commit bool) {
			if !commit {
				progress.completed.delete(key)
			}
		})
	}
}

pub fn (p &BootstrapProgress) value(step string) ?vphp.PhpValue {
	saved := p.values[step] or { return none }
	return saved.owned()
}

pub fn (mut p BootstrapProgress) remember(step string, value vphp.PhpValue) {
	if p.enabled && step !in p.values {
		p.values[step.clone()] = value.retain()
		if mut scope := registrationx.current_registration_scope() {
			mut progress := &p
			key := step.clone()
			scope.add_change(fn [mut progress, key] (commit bool) {
				if !commit {
					mut saved := progress.values[key]
					progress.values.delete(key)
					saved.release()
				}
			})
		}
	}
}

pub fn (mut p BootstrapProgress) glob_files(pattern string) ![]string {
	return p.scan_files('glob:' + pattern, pattern, glob_paths)
}

pub fn (mut p BootstrapProgress) directory_entries(directory string) ![]string {
	return p.scan_files('directory:' + directory, directory, fn (path string) []string {
		return if is_dir(path) { scandir_names(path) } else { []string{} }
	})
}

fn (mut p BootstrapProgress) scan_files(step string, path string, scan fn (string) []string) ![]string {
	if files := p.file_lists[step] {
		return files
	}
	files := scan(path)
	if vphp.has_exception() {
		return error('bootstrap file scan failed for "${path}"')
	}
	p.file_lists[step.clone()] = files
	if mut scope := registrationx.current_registration_scope() {
		mut progress := &p
		key := step.clone()
		scope.add_change(fn [mut progress, key] (commit bool) {
			if !commit {
				progress.release_file_list(key)
			}
		})
	}
	return files
}

fn (mut p BootstrapProgress) release_file_list(key string) {
	if mut files := p.file_lists[key] {
		p.file_lists.delete(key)
		unsafe {
			files.free()
		}
	}
}

pub fn (mut p BootstrapProgress) load(path string) !vphp.PhpValue {
	step := 'include:' + path
	if value := p.value(step) {
		return value
	}
	mut value := load_bootstrap_php_file(path)
	if vphp.has_exception() {
		value.release()
		return error('bootstrap file "${path}" evaluation failed')
	}
	p.remember(step, value)
	return value
}

pub fn (mut p BootstrapProgress) load_file(file BootstrapFile) !vphp.PhpValue {
	step := 'include:' + file.resolved_path
	if value := p.value(step) {
		return value
	}
	value := file.load(mut p)!
	p.remember(step, value)
	return value
}

pub fn (mut p BootstrapProgress) normalize(step string, iterable vphp.PhpIterable) !vphp.PhpArray {
	normalized, _ := p.normalize_for_retry(step, iterable)!
	return normalized
}

pub fn (mut p BootstrapProgress) normalize_for_retry(step string, iterable vphp.PhpIterable) !(vphp.PhpArray, bool) {
	return p.normalize_iterable(step, iterable, .keyed)
}

pub fn (mut p BootstrapProgress) normalize_entries(step string, iterable vphp.PhpIterable) !vphp.PhpArray {
	normalized, _ := p.normalize_iterable(step, iterable, .entries)!
	return normalized
}

pub fn (mut p BootstrapProgress) normalize_values(step string, iterable vphp.PhpIterable) !vphp.PhpArray {
	normalized, _ := p.normalize_iterable(step, iterable, .values)!
	return normalized
}

fn (mut p BootstrapProgress) normalize_iterable(step string, iterable vphp.PhpIterable, shape BootstrapIterableShape) !(vphp.PhpArray, bool) {
	if mut value := p.value(step) {
		defer {
			value.release()
		}
		normalized := value.as_array() or { return error('bootstrap list must be iterable') }
		return normalized, false
	}
	mut normalized, unchanged := evaluate_bootstrap_iterable(iterable, shape) or {
		return error('bootstrap spec must be iterable')
	}
	if vphp.has_exception() {
		normalized.release()
		return error('bootstrap list evaluation failed')
	}
	if p.enabled {
		mut value := normalized.to_value()
		p.remember(step, value)
		value.release()
	}
	return normalized, unchanged
}

pub fn (mut p BootstrapProgress) release() {
	for _, value in p.values {
		mut saved := value
		saved.release()
	}
	for key in p.file_lists.keys() {
		p.release_file_list(key)
	}
	unsafe {
		p.values.free()
		p.completed.free()
		p.file_lists.free()
	}
}

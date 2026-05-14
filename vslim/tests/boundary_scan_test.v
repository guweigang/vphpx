module boundary_scan_test

import os

fn vslim_root() string {
	return os.real_path(os.join_path(os.dir(@FILE), '..'))
}

fn vslim_src_files() []string {
	mut files := os.walk_ext(os.join_path(vslim_root(), 'src'), '.v')
	files.sort()
	return files.filter(!it.ends_with('/bridge.v'))
}

fn test_vslim_handwritten_sources_do_not_use_stale_vphp_raw_entries() {
	banned := [
		'Context.from_entry(',
		'Context.from_raw(',
		'ZExData.new(',
		'.raw_ex()',
		'.raw_zval()',
		'ZVal.from_raw(',
		'ZendObject.from_raw(',
		'ZendClassEntry.from_raw(',
		'C.vphp_',
		'C.ZVAL_',
		'C.zval{}',
		'call_owned_request_zval(',
		'method_owned_request(',
	]
	for file in vslim_src_files() {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned {
			assert !source.contains(pattern), '${file} should not contain ${pattern}'
		}
	}
}

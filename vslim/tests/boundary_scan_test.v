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
		'args_from_zvals(',
		'call_owned_request_zval(',
		'method_owned_request(',
	]
	for file in vslim_src_files() {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned {
			assert !source.contains(pattern), '${file} should not contain ${pattern}'
		}
		for line in source.split_into_lines() {
			trimmed := line.trim_space()
			assert !(trimmed.contains('PhpValue.from_zval(') && trimmed.contains('.to_zval())')),
				'${file} should not roundtrip semantic values through ${trimmed}'
			assert !(trimmed.contains('RequestBorrowedZBox.from_zval(')
				&& trimmed.contains('.to_zval())')),
				'${file} should not roundtrip borrowed boxes through ${trimmed}'
			assert !(trimmed.contains('PhpObject.borrowed(') && trimmed.contains('.to_zval())')),
				'${file} should use PhpObject.borrowed_zbox(...) for ${trimmed}'
			assert !(trimmed.contains('PhpCallable.borrowed(') && trimmed.contains('.to_zval())')),
				'${file} should use PhpCallable.borrowed_zbox(...) for ${trimmed}'
		}
	}
}

fn test_vslim_domain_identifiers_do_not_reintroduce_php_prefixes() {
	banned := [
		'php_before_middlewares',
		'php_middlewares',
		'php_after_middlewares',
		'php_group_before_middle',
		'php_group_middle',
		'php_group_after_middle',
		'php_handler',
		'dispatch_php_',
		'resolve_php_',
		'apply_php_',
		'finalize_php_',
		'build_php_',
		'add_php_route',
		'to_php_value',
		'from_php_value',
	]
	for file in vslim_src_files() {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned {
			assert !source.contains(pattern), '${file} should not contain VSlim domain identifier ${pattern}'
		}
	}
}

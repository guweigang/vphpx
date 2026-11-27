module main

fn test_gc_flags_select_musl_shared_collector() {
	assert gc_build_flags('linux', '3.22.1\n', 'boehm') == ['-d', 'dynamic_boehm']
	assert gc_build_flags('linux', '', 'boehm') == ['-d', 'use_bundled_libgc']
	assert gc_build_flags('linux', '3.22.1', 'none') == []string{}
	assert gc_build_flags('macos', '', 'boehm') == []string{}
}

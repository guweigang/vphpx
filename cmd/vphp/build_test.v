module main

fn test_gc_flags_select_musl_shared_collector() {
	assert gc_build_flags('linux', '3.22.1\n', 'boehm') == ['-d', 'dynamic_boehm']
	assert gc_build_flags('linux', '', 'boehm') == ['-d', 'use_bundled_libgc']
	assert gc_build_flags('linux', '3.22.1', 'none') == []string{}
	assert gc_build_flags('macos', '', 'boehm') == []string{}
}

fn test_windows_config_escapes_paths_and_keeps_runtime_sources() {
	config := windows_config('demo', 'C:\\Program Files\\vphp', 'C:\\V')
	assert config.contains('EXTENSION("demo", "php_bridge.c demo_generated.c"')
	assert config.contains('C:\\\\Program Files\\\\vphp')
	assert config.contains('v_bridge.c')
	assert config.contains('core_windows.c')
}

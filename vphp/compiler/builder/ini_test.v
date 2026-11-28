module builder

fn test_ini_render_escapes_c_strings_and_uses_access_modes() {
	mut module_builder := new_module_builder('demo', '1', '')
	module_builder.add_ini_entry('demo.old', '1')
	module_builder.add_ini_entry_with_access('demo.text', '"\\\n雪', 'system')
	code := module_builder.render_ini_entries()
	assert code.contains('PHP_INI_ENTRY("demo.old", "1", PHP_INI_ALL, NULL)')
	assert code.contains('PHP_INI_ENTRY("demo.text", "\\"\\\\\\012\\351\\233\\252", PHP_INI_SYSTEM, NULL)')
}

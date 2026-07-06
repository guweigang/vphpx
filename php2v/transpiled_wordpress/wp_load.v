module main

import rt

pub fn run_transpiled_wp_load() string {
	println('PHP2V - Executing transpiled wp_load.v')
	
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		_ = rt.call_function('define', [rt.new_string('ABSPATH'),
			rt.new_string('/Users/guweigang/wwwroot/wordpress/')])
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('error_reporting')])) {
		_ = rt.call_function('error_reporting', [
			rt.new_int(4437),
		])
	}
	
	// 在 V 侧直接静态调用转译后的 wp_config 引导
	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-config.php'),
	]))
	{
		return run_transpiled_wp_config()
	} else if
		rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('dirname', [rt.get_constant('ABSPATH')])).str() + '/wp-config.php')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('dirname', [rt.get_constant('ABSPATH')])).str() + '/wp-settings.php')]))))) {
		return run_transpiled_wp_config()
	} else {
		_ = rt.call_function('define', [rt.new_string('WPINC'),
			rt.new_string('wp-includes')])
		_ = rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '4')
		_ = rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/compat.php', '4')
		_ = rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/load.php', '4')
		_ = rt.call_function('wp_check_php_mysql_versions', []rt.PhpVal{})
		_ = rt.call_function('wp_fix_server_vars', []rt.PhpVal{})
		_ = rt.call_function('define', [rt.new_string('WP_CONTENT_DIR'),
			rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-content')])
		_ = rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.php', '4')
	}
	return ''
}

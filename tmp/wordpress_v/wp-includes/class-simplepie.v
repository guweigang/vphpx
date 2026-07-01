import rt

fn wp_simplepie_autoload(var_class rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.7.0'), rt.new_string('SimplePie_Autoloader')])
}

pub fn init_wp_includes_class_simplepie_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('SimplePie'),
		rt.new_bool(false)]))
	{
		return rt.new_null()
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/SimplePie/autoloader.php',
		'3')
}

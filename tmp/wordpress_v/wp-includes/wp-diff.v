import rt

pub fn init_wp_includes_wp_diff_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('Text_Diff'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/Text/Diff.php',
			'3')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/Text/Diff/Renderer.php',
			'3')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/Text/Diff/Renderer/inline.php',
			'3')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/Text/Exception.php',
			'3')
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-text-diff-renderer-table.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-text-diff-renderer-inline.php',
		'3')
}

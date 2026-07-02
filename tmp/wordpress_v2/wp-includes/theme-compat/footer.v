import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('_deprecated_file', [
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Theme without %s')]),
			rt.call_function('basename', [rt.new_string(@FILE)]),
		]),
		rt.new_string('3.0.0'),
		rt.new_null(),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Please include a %s template in your theme.')]),
			rt.call_function('basename', [rt.new_string(@FILE)]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('%1$s is proudly powered by %2$s')]),
		rt.call_function('get_bloginfo', [rt.new_string('name')]),
		rt.new_string('<a href="https://wordpress.org/">WordPress</a>'),
	])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_footer', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}

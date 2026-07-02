import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_class := rt.new_null()
	mut var_availability := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_availability.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

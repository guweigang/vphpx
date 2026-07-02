import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_context := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_context.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

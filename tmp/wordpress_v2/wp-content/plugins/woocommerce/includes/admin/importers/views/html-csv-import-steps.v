import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := rt.get_property(rt.new_object('', []string{}, &this), 'steps').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_step := item_1.val
		mut var_step_key := item_1.key
		// unsupported statement: Stmt_InlineHTML
		mut var_step_class := ''
		if rt.is_true(rt.identical(var_step_key, rt.get_property(rt.new_object('', []string{},
			&this), 'step')))
		{
			var_step_class = 'active'
		} else if rt.is_true(rt.greater(rt.call_function('array_search', [
			rt.get_property(rt.new_object('', []string{}, &this), 'step'),
			rt.func_array_keys(rt.get_property(rt.new_object('', []string{}, &this), 'steps')),
			rt.new_bool(true),
		]), rt.call_function('array_search', [var_step_key.clone(),
			rt.func_array_keys(rt.get_property(rt.new_object('', []string{}, &this), 'steps')),
			rt.new_bool(true)])))
		{
			var_step_class = 'done'
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_step_class.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_step.array_get(rt.new_string('name'))]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_sections := rt.new_null()
	mut var_current_section := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Browse categories'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_sections.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_section := item_1.val
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(var_current_section, rt.get_property(var_section, 'slug')))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('_featured'), rt.get_property(var_section, 'slug'))))) {
			mut var_current_section_name := rt.get_property(var_section, 'label')
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(var_current_section, rt.get_property(var_section, 'slug'))) {
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-addons&section=' +
					(rt.call_function('esc_attr', [rt.get_property(var_section, 'slug')])).str()),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_section, 'label')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_current_section_name.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_fluid_columns := rt.new_null()
	mut var_columns := rt.new_null()
	mut var_brands := rt.new_null()
	mut var_wrapper_class := rt.new_string('fluid-columns')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fluid_columns))))
		&& rt.is_true(rt.call_function('in_array', [var_columns.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 1
	}, rt.ArrayItem{ key: none, val: 2 }, rt.ArrayItem{ key: none, val: 3 }, rt.ArrayItem{
		key: none
		val: 4
	}, rt.ArrayItem{ key: none, val: 5 }, rt.ArrayItem{ key: none, val: 6 }]), rt.new_bool(true)])) {
		var_wrapper_class = rt.new_string('columns-' + var_columns.str())
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_wrapper_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := rt.call_function('array_values', [var_brands.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_brand := item_1.val
		mut var_index := item_1.key
		mut var_class := ''
		if rt.is_true(rt.identical(rt.new_int(0), var_index))
			|| rt.is_true(rt.identical(rt.new_int(0), rt.mod_(var_index, var_columns))) {
			var_class = 'first'
		} else if rt.is_true(rt.identical(rt.new_int(0), rt.mod_(rt.add(var_index, rt.new_int(1)),
			var_columns)))
		{
			var_class = 'last'
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_class.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('get_term_link', [rt.get_property(var_brand, 'slug'),
				rt.new_string('product_brand')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_brand, 'name')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_get_brand_thumbnail_image', [
			var_brand.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

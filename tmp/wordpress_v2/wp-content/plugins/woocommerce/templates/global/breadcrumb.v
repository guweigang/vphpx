import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_breadcrumb := rt.new_null()
	mut var_wrap_before := rt.new_null()
	mut var_before := rt.new_null()
	mut var_after := rt.new_null()
	mut var_delimiter := rt.new_null()
	mut var_wrap_after := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if !(!rt.is_true(var_breadcrumb)) {
		rt.echo_val(var_wrap_before)
		mut iter_1 := var_breadcrumb.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_crumb := item_1.val
			mut var_key := item_1.key
			rt.echo_val(var_before)
			if !(!rt.is_true(var_crumb.array_get(rt.new_int(1))))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(var_breadcrumb.clone().array_count()), rt.add(var_key, rt.new_int(1)))))) {
				print('<a href="' +
					(rt.call_function('esc_url', [var_crumb.array_get(rt.new_int(1))])).str() +
					'">' +
					(rt.call_function('esc_html', [var_crumb.array_get(rt.new_int(0))])).str() +
					'</a>')
			} else {
				rt.echo_val(rt.call_function('esc_html', [var_crumb.array_get(rt.new_int(0))]))
			}
			rt.echo_val(var_after)
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(var_breadcrumb.clone().array_count()), rt.add(var_key,
				rt.new_int(1))))))
			{
				rt.echo_val(var_delimiter)
			}
		}
		rt.echo_val(var_wrap_after)
	}
}

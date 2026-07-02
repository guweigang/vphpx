import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_current_range := rt.new_null()
	mut var_ranges := rt.new_null()
	mut var_hide_sidebar := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('custom'), var_current_range))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('start_date'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('end_date')) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('From %1$s to %2$s'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [
				rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_GET').array_get(rt.new_string('start_date')),
					]),
				]),
			]),
			rt.call_function('esc_html', [
				rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_GET').array_get(rt.new_string('end_date')),
					]),
				]),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_ranges.array_get(var_current_range)]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(rt.new_object('', []string{}, &this), 'get_export_button', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_ranges.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_name := item_1.val
		mut var_range := item_1.key
		print('<li class="' +
			if rt.is_true(rt.equal(var_current_range, var_range)) { 'active' } else { '' } +
			'"><a href="' +
			(rt.call_function('esc_url', [rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{
			key: none
			val: 'start_date'
		}, rt.ArrayItem{ key: none, val: 'end_date' }]), rt.call_function('add_query_arg', [rt.new_string('range'), var_range.clone()])])])).str() +
			'">' + (rt.call_function('esc_html', [var_name.clone()])).str() + '</a></li>')
	}
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('custom'), var_current_range)) {
		'active'
	} else {
		''
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Custom:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_2 := rt.get_superglobal('_GET').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			mut iter_3 := var_value.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_v := item_3.val
				print('<input type="hidden" name="' +
					(rt.call_function('esc_attr', [rt.call_function('sanitize_text_field', [var_key.clone()])])).str() +
					'[]" value="' +
					(rt.call_function('esc_attr', [rt.call_function('sanitize_text_field', [var_v.clone()])])).str() +
					'" />')
			}
		} else {
			print('<input type="hidden" name="' +
				(rt.call_function('esc_attr', [rt.call_function('sanitize_text_field', [var_key.clone()])])).str() +
				'" value="' +
				(rt.call_function('esc_attr', [rt.call_function('sanitize_text_field', [var_value.clone()])])).str() +
				'" />')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('start_date')))) { rt.call_function('esc_attr', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('start_date'))]),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('end_date')))) { rt.call_function('esc_attr', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('end_date'))]),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Go'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Go'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('custom_range'),
		rt.new_string('wc_reports_nonce'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	if !rt.is_true(var_hide_sidebar) {
		// unsupported statement: Stmt_InlineHTML
		mut var_legends := rt.call_method(rt.new_object('', []string{}, &this), 'get_chart_legend',
			[]rt.PhpVal{})
		if rt.is_true(var_legends) {
			// unsupported statement: Stmt_InlineHTML
			mut iter_4 := var_legends.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_legend := item_4.val
				// unsupported statement: Stmt_InlineHTML
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_legend.array_get(rt.new_string('color')))
				// unsupported statement: Stmt_InlineHTML
				if var_legend.array_isset(rt.new_string('highlight_series')) {
					print('class="highlight_series ' +
						if var_legend.array_isset(rt.new_string('placeholder')) { 'tips' } else { '' } +
						'" data-series="' +
						(rt.call_function('esc_attr', [var_legend.array_get(rt.new_string('highlight_series'))])).str() +
						'"')
				}
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(if var_legend.array_isset(rt.new_string('placeholder')) {
					var_legend.array_get(rt.new_string('placeholder'))
				} else {
					rt.new_string('')
				})
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_legend.array_get(rt.new_string('title')))
				// unsupported statement: Stmt_InlineHTML
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut iter_5 := rt.call_method(rt.new_object('', []string{}, &this), 'get_chart_widgets',
			[]rt.PhpVal{}).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_widget := item_5.val
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_widget.array_get(rt.new_string('title'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					var_widget.array_get(rt.new_string('title')),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('call_user_func', [var_widget.array_get(rt.new_string('callback'))])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_method(rt.new_object('', []string{}, &this), 'get_main_chart', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_method(rt.new_object('', []string{}, &this), 'get_main_chart', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

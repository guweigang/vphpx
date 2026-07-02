import rt

fn woocommerce_wp_text_input(var_field rt.PhpVal, var_data rt.PhpVal) {
	mut var_post := rt.new_null()
	mut var_data_type := rt.new_null()
	mut var_custom_attributes := []rt.PhpVal{}
	mut var_value := rt.new_null()
	mut var_attribute := rt.new_null()
	mut var_help_tip := rt.new_null()
	mut var_description := rt.new_null()
	mut var_hidden_class := ''
	var_field.array_set('placeholder', if var_field.array_isset(rt.new_string('placeholder')) {
		var_field.array_get(rt.new_string('placeholder'))
	} else {
		rt.new_string('')
	})
	var_field.array_set('class', if var_field.array_isset(rt.new_string('class')) {
		var_field.array_get(rt.new_string('class'))
	} else {
		rt.new_string('short')
	})
	var_field.array_set('style', if var_field.array_isset(rt.new_string('style')) {
		var_field.array_get(rt.new_string('style'))
	} else {
		rt.new_string('')
	})
	var_field.array_set('wrapper_class', if var_field.array_isset(rt.new_string('wrapper_class')) {
		var_field.array_get(rt.new_string('wrapper_class'))
	} else {
		rt.new_string('')
	})
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.get_post_or_object_meta(var_post.clone(), var_data.clone(),
		var_field.array_get(rt.new_string('id')), rt.new_bool(true))
	var_field.array_set('value', if !(var_field.array_get(rt.new_string('value'))).is_null() {
		var_field.array_get(rt.new_string('value'))
	} else {
		iife_result_0
	})
	var_field.array_set('name', if var_field.array_isset(rt.new_string('name')) {
		var_field.array_get(rt.new_string('name'))
	} else {
		var_field.array_get(rt.new_string('id'))
	})
	var_field.array_set('type', if var_field.array_isset(rt.new_string('type')) {
		var_field.array_get(rt.new_string('type'))
	} else {
		rt.new_string('text')
	})
	var_field.array_set('desc_tip', if var_field.array_isset(rt.new_string('desc_tip')) {
		var_field.array_get(rt.new_string('desc_tip'))
	} else {
		rt.new_bool(false)
	})
	var_data_type = if !rt.is_true(var_field.array_get(rt.new_string('data_type'))) {
		rt.new_string('')
	} else {
		var_field.array_get(rt.new_string('data_type'))
	}
	mut switch_val_1 := var_data_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('price'))) {
		var_field.array_get(rt.new_string('class')) = rt.concat(var_field.array_get(rt.new_string('class')),
			rt.new_string(' wc_input_price'))
		var_field.array_set('value', rt.call_function('wc_format_localized_price', [
			var_field.array_get(rt.new_string('value')),
		]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('decimal'))) {
		var_field.array_get(rt.new_string('class')) = rt.concat(var_field.array_get(rt.new_string('class')),
			rt.new_string(' wc_input_decimal'))
		var_field.array_set('value', rt.call_function('wc_format_localized_decimal', [
			var_field.array_get(rt.new_string('value')),
		]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stock'))) {
		var_field.array_get(rt.new_string('class')) = rt.concat(var_field.array_get(rt.new_string('class')),
			rt.new_string(' wc_input_stock'))
		var_field.array_set('value', rt.call_function('wc_stock_amount', [
			var_field.array_get(rt.new_string('value')),
		]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('url'))) {
		var_field.array_get(rt.new_string('class')) = rt.concat(var_field.array_get(rt.new_string('class')),
			rt.new_string(' wc_input_url'))
		var_field.array_set('value', rt.call_function('esc_url', [
			var_field.array_get(rt.new_string('value')),
		]))
	} else {
	}
	var_custom_attributes = []rt.PhpVal{}
	if !(!rt.is_true(var_field.array_get(rt.new_string('custom_attributes'))))
		&& var_field.array_get(rt.new_string('custom_attributes')).is_array() {
		mut iter_1 := var_field.array_get(rt.new_string('custom_attributes')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value_shadow := item_1.val
			mut var_attribute_shadow := item_1.key
			var_custom_attributes <<
				(rt.call_function('esc_attr', [var_attribute_shadow.clone()])).str() + '="' +
				(rt.call_function('esc_attr', [var_value_shadow.clone()])).str() + '"'
		}
	}
	print('<p class="form-field ' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() +
		'_field ' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('wrapper_class'))])).str() +
		'">\n\t\t<label for="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() + '">' +
		(rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('label'))])).str() +
		'</label>')
	var_help_tip = rt.new_null()
	var_description = rt.new_null()
	if !(!rt.is_true(var_field.array_get(rt.new_string('description')))) {
		if rt.is_true(rt.new_bool(var_field.array_get(rt.new_string('description')).is_array())) {
			var_help_tip = rt.call_function('reset', [
				var_field.array_get(rt.new_string('description')),
			])
			var_description = rt.call_function('end', [
				var_field.array_get(rt.new_string('description')),
			])
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
			var_field.array_get(rt.new_string('desc_tip'))))))
		{
			var_help_tip = var_field.array_get(rt.new_string('description'))
		} else {
			var_description = var_field.array_get(rt.new_string('description'))
		}
	}
	if !(var_help_tip.clone().is_null()) {
		rt.echo_val(rt.call_function('wc_help_tip', [var_help_tip.clone()]))
	}
	print('<input type="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('type'))])).str() +
		'" class="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('class'))])).str() +
		'" style="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('style'))])).str() +
		'" name="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('name'))])).str() +
		'" id="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() +
		'" value="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('value'))])).str() +
		'" placeholder="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('placeholder'))])).str() +
		'" ' +
		(rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() +
		' /> ')
	if !(var_description.clone().is_null()) {
		var_hidden_class = if rt.is_true(rt.identical(rt.new_bool(true), if !(var_field.array_get(rt.new_string('description_hidden'))).is_null() {
			var_field.array_get(rt.new_string('description_hidden'))
		} else {
			rt.new_bool(false)
		}))
		{ ' hidden'
		 } else { ''
		 }
		print('<span class="description' + var_hidden_class + '">' +
			(rt.call_function('wp_kses_post', [var_description.clone()])).str() + '</span>')
	}
	print('</p>')
}

fn woocommerce_wp_hidden_input(var_field rt.PhpVal, var_data rt.PhpVal) {
	mut var_post := rt.new_null()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.get_post_or_object_meta(var_post.clone(), var_data.clone(),
		var_field.array_get(rt.new_string('id')), rt.new_bool(true))
	var_field.array_set('value', if var_field.array_isset(rt.new_string('value')) {
		var_field.array_get(rt.new_string('value'))
	} else {
		iife_result_1
	})
	var_field.array_set('class', if var_field.array_isset(rt.new_string('class')) {
		var_field.array_get(rt.new_string('class'))
	} else {
		rt.new_string('')
	})
	print('<input type="hidden" class="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('class'))])).str() +
		'" name="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() +
		'" id="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() +
		'" value="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('value'))])).str() +
		'" /> ')
}

fn woocommerce_wp_textarea_input(var_field rt.PhpVal, var_data rt.PhpVal) {
	mut var_post := rt.new_null()
	mut var_custom_attributes := []rt.PhpVal{}
	mut var_value := rt.new_null()
	mut var_attribute := rt.new_null()
	var_field.array_set('placeholder', if var_field.array_isset(rt.new_string('placeholder')) {
		var_field.array_get(rt.new_string('placeholder'))
	} else {
		rt.new_string('')
	})
	var_field.array_set('class', if var_field.array_isset(rt.new_string('class')) {
		var_field.array_get(rt.new_string('class'))
	} else {
		rt.new_string('short')
	})
	var_field.array_set('style', if var_field.array_isset(rt.new_string('style')) {
		var_field.array_get(rt.new_string('style'))
	} else {
		rt.new_string('')
	})
	var_field.array_set('wrapper_class', if var_field.array_isset(rt.new_string('wrapper_class')) {
		var_field.array_get(rt.new_string('wrapper_class'))
	} else {
		rt.new_string('')
	})
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_2 := iife_temp_2.get_post_or_object_meta(var_post.clone(), var_data.clone(),
		var_field.array_get(rt.new_string('id')), rt.new_bool(true))
	var_field.array_set('value', if !(var_field.array_get(rt.new_string('value'))).is_null() {
		var_field.array_get(rt.new_string('value'))
	} else {
		iife_result_2
	})
	var_field.array_set('desc_tip', if var_field.array_isset(rt.new_string('desc_tip')) {
		var_field.array_get(rt.new_string('desc_tip'))
	} else {
		rt.new_bool(false)
	})
	var_field.array_set('name', if var_field.array_isset(rt.new_string('name')) {
		var_field.array_get(rt.new_string('name'))
	} else {
		var_field.array_get(rt.new_string('id'))
	})
	var_field.array_set('rows', if var_field.array_isset(rt.new_string('rows')) {
		var_field.array_get(rt.new_string('rows'))
	} else {
		rt.new_int(2)
	})
	var_field.array_set('cols', if var_field.array_isset(rt.new_string('cols')) {
		var_field.array_get(rt.new_string('cols'))
	} else {
		rt.new_int(20)
	})
	var_custom_attributes = []rt.PhpVal{}
	if !(!rt.is_true(var_field.array_get(rt.new_string('custom_attributes'))))
		&& var_field.array_get(rt.new_string('custom_attributes')).is_array() {
		mut iter_2 := var_field.array_get(rt.new_string('custom_attributes')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value_shadow := item_2.val
			mut var_attribute_shadow := item_2.key
			var_custom_attributes <<
				(rt.call_function('esc_attr', [var_attribute_shadow.clone()])).str() + '="' +
				(rt.call_function('esc_attr', [var_value_shadow.clone()])).str() + '"'
		}
	}
	print('<p class="form-field ' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() +
		'_field ' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('wrapper_class'))])).str() +
		'">\n\t\t<label for="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() + '">' +
		(rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('label'))])).str() +
		'</label>')
	if !(!rt.is_true(var_field.array_get(rt.new_string('description'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get(rt.new_string('desc_tip')))))) {
		rt.echo_val(rt.call_function('wc_help_tip', [
			var_field.array_get(rt.new_string('description')),
		]))
	}
	print('<textarea class="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('class'))])).str() +
		'" style="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('style'))])).str() +
		'"  name="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('name'))])).str() +
		'" id="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() +
		'" placeholder="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('placeholder'))])).str() +
		'" rows="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('rows'))])).str() +
		'" cols="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('cols'))])).str() + '" ' +
		(rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() +
		'>' +
		(rt.call_function('esc_textarea', [var_field.array_get(rt.new_string('value'))])).str() +
		'</textarea> ')
	if !(!rt.is_true(var_field.array_get(rt.new_string('description'))))
		&& rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get(rt.new_string('desc_tip')))) {
		print('<span class="description">' +
			(rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('description'))])).str() +
			'</span>')
	}
	print('</p>')
}

fn woocommerce_wp_checkbox(var_field rt.PhpVal, var_data rt.PhpVal) {
	mut var_post := rt.new_null()
	mut var_custom_attributes := []rt.PhpVal{}
	mut var_value := rt.new_null()
	mut var_attribute := rt.new_null()
	var_field.array_set('class', if var_field.array_isset(rt.new_string('class')) {
		var_field.array_get(rt.new_string('class'))
	} else {
		rt.new_string('checkbox')
	})
	var_field.array_set('style', if var_field.array_isset(rt.new_string('style')) {
		var_field.array_get(rt.new_string('style'))
	} else {
		rt.new_string('')
	})
	var_field.array_set('wrapper_class', if var_field.array_isset(rt.new_string('wrapper_class')) {
		var_field.array_get(rt.new_string('wrapper_class'))
	} else {
		rt.new_string('')
	})
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_3 := iife_temp_3.get_post_or_object_meta(var_post.clone(), var_data.clone(),
		var_field.array_get(rt.new_string('id')), rt.new_bool(true))
	var_field.array_set('value', if !(var_field.array_get(rt.new_string('value'))).is_null() {
		var_field.array_get(rt.new_string('value'))
	} else {
		iife_result_3
	})
	var_field.array_set('cbvalue', if var_field.array_isset(rt.new_string('cbvalue')) {
		var_field.array_get(rt.new_string('cbvalue'))
	} else {
		rt.new_string('yes')
	})
	var_field.array_set('name', if var_field.array_isset(rt.new_string('name')) {
		var_field.array_get(rt.new_string('name'))
	} else {
		var_field.array_get(rt.new_string('id'))
	})
	var_field.array_set('desc_tip', if var_field.array_isset(rt.new_string('desc_tip')) {
		var_field.array_get(rt.new_string('desc_tip'))
	} else {
		rt.new_bool(false)
	})
	var_field.array_set('checked_value', if var_field.array_isset(rt.new_string('checked_value')) {
		var_field.array_get(rt.new_string('checked_value'))
	} else {
		var_field.array_get(rt.new_string('cbvalue'))
	})
	var_field.array_set('unchecked_value', if var_field.array_isset(rt.new_string('unchecked_value')) {
		var_field.array_get(rt.new_string('unchecked_value'))
	} else {
		rt.new_null()
	})
	var_custom_attributes = []rt.PhpVal{}
	if !(!rt.is_true(var_field.array_get(rt.new_string('custom_attributes'))))
		&& var_field.array_get(rt.new_string('custom_attributes')).is_array() {
		mut iter_3 := var_field.array_get(rt.new_string('custom_attributes')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value_shadow := item_3.val
			mut var_attribute_shadow := item_3.key
			var_custom_attributes <<
				(rt.call_function('esc_attr', [var_attribute_shadow.clone()])).str() + '="' +
				(rt.call_function('esc_attr', [var_value_shadow.clone()])).str() + '"'
		}
	}
	if !(!rt.is_true(var_field.array_get(rt.new_string('style')))) {
		var_custom_attributes << 'style="' +
			(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('style'))])).str() +
			'"'
	}
	if !(!rt.is_true(var_field.array_get(rt.new_string('class')))) {
		var_custom_attributes << 'class="' +
			(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('class'))])).str() +
			'"'
	}
	print('<p class="form-field ' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() +
		'_field ' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('wrapper_class'))])).str() +
		'">\n\t\t<label for="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() + '">' +
		(rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('label'))])).str() +
		'</label>')
	if !(!rt.is_true(var_field.array_get(rt.new_string('description'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get(rt.new_string('desc_tip')))))) {
		rt.echo_val(rt.call_function('wc_help_tip', [
			var_field.array_get(rt.new_string('description')),
		]))
	}
	if !(var_field.array_get(rt.new_string('unchecked_value')).is_null()) {
		rt.call_function('printf', [
			rt.new_string('<input type="hidden" name="%1$s" value="%2$s" />'),
			rt.call_function('esc_attr', [var_field.array_get(rt.new_string('name'))]),
			rt.call_function('esc_attr', [var_field.array_get(rt.new_string('unchecked_value'))]),
		])
	}
	rt.call_function('printf', [
		rt.new_string('<input type="checkbox" name="%1$s" id="%2$s" value="%3$s" %4$s %5$s />'),
		rt.call_function('esc_attr', [var_field.array_get(rt.new_string('name'))]),
		rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))]),
		rt.call_function('esc_attr', [var_field.array_get(rt.new_string('checked_value'))]),
		rt.call_function('checked', [var_field.array_get(rt.new_string('value')),
			var_field.array_get(rt.new_string('checked_value')),
			rt.new_bool(false)]),
		rt.call_function('implode', [rt.new_string(' '),
			rt.create_array_from_list(var_custom_attributes)]),
	])
	if !(!rt.is_true(var_field.array_get(rt.new_string('description'))))
		&& rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get(rt.new_string('desc_tip')))) {
		print('<span class="description">' +
			(rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('description'))])).str() +
			'</span>')
	}
	print('</p>')
}

fn woocommerce_wp_select(var_field_arg rt.PhpVal, var_data rt.PhpVal) {
	mut var_field := var_field_arg
	mut var_post := rt.new_null()
	mut var_wrapper_attributes := map[string]rt.PhpVal{}
	mut var_label_attributes := map[string]rt.PhpVal{}
	mut var_field_attributes := rt.new_null()
	mut var_tooltip := rt.new_null()
	mut var_description := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_4 := iife_temp_4.get_post_or_object_meta(var_post.clone(), var_data.clone(),
		var_field.array_get(rt.new_string('id')), rt.new_bool(true))
	var_field = rt.call_function('wp_parse_args', [var_field.clone(),
		rt.create_array([rt.ArrayItem{ key: 'class', val: 'select short' },
			rt.ArrayItem{ key: 'style', val: '' }, rt.ArrayItem{ key: 'wrapper_class', val: '' },
			rt.ArrayItem{ key: 'value', val: iife_result_4 },
			rt.ArrayItem{ key: 'name', val: var_field.array_get(rt.new_string('id')) },
			rt.ArrayItem{ key: 'desc_tip', val: false }, rt.ArrayItem{
				key: 'custom_attributes'
				val: []rt.PhpVal{}
			}])])
	var_wrapper_attributes = {
		'class': (var_field.array_get(rt.new_string('wrapper_class'))).str() +
			rt.concat(rt.concat(rt.new_string(' form-field '), var_field.array_get(rt.new_string('id'))), rt.new_string('_field'))
	}
	var_label_attributes = {
		'for': var_field.array_get(rt.new_string('id'))
	}
	var_field_attributes = rt.cast_array(var_field.array_get(rt.new_string('custom_attributes')))
	var_field_attributes.array_set('style', var_field.array_get(rt.new_string('style')))
	var_field_attributes.array_set('id', var_field.array_get(rt.new_string('id')))
	var_field_attributes.array_set('name', var_field.array_get(rt.new_string('name')))
	var_field_attributes.array_set('class', var_field.array_get(rt.new_string('class')))
	var_tooltip = if !(!rt.is_true(var_field.array_get(rt.new_string('description'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get(rt.new_string('desc_tip')))))) {
		var_field.array_get(rt.new_string('description'))
	} else {
		rt.new_string('')
	}
	var_description = if !(!rt.is_true(var_field.array_get(rt.new_string('description'))))
		&& rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get(rt.new_string('desc_tip')))) {
		var_field.array_get(rt.new_string('description'))
	} else {
		rt.new_string('')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_implode_html_attributes', [
		rt.create_array_from_native_map(var_wrapper_attributes),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_implode_html_attributes', [
		rt.create_array_from_native_map(var_label_attributes),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('label'))]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_tooltip) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [var_tooltip.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_implode_html_attributes', [
		var_field_attributes.clone()]))
	// unsupported statement: Stmt_InlineHTML
	mut iter_4 := var_field.array_get(rt.new_string('options')).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value_shadow := item_4.val
		mut var_key_shadow := item_4.key
		print('<option value="' + (rt.call_function('esc_attr', [var_key_shadow.clone()])).str() +
			'"' +
			(rt.call_function('wc_selected', [var_key_shadow.clone(), var_field.array_get(rt.new_string('value'))])).str() +
			'>' + (rt.call_function('esc_html', [var_value_shadow.clone()])).str() + '</option>')
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_description) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [var_description.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn woocommerce_wp_radio(var_field rt.PhpVal, var_data rt.PhpVal) {
	mut var_post := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	var_field.array_set('class', if var_field.array_isset(rt.new_string('class')) {
		var_field.array_get(rt.new_string('class'))
	} else {
		rt.new_string('select short')
	})
	var_field.array_set('style', if var_field.array_isset(rt.new_string('style')) {
		var_field.array_get(rt.new_string('style'))
	} else {
		rt.new_string('')
	})
	var_field.array_set('wrapper_class', if var_field.array_isset(rt.new_string('wrapper_class')) {
		var_field.array_get(rt.new_string('wrapper_class'))
	} else {
		rt.new_string('')
	})
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_5 := iife_temp_5.get_post_or_object_meta(var_post.clone(), var_data.clone(),
		var_field.array_get(rt.new_string('id')), rt.new_bool(true))
	var_field.array_set('value', if !(var_field.array_get(rt.new_string('value'))).is_null() {
		var_field.array_get(rt.new_string('value'))
	} else {
		iife_result_5
	})
	var_field.array_set('name', if var_field.array_isset(rt.new_string('name')) {
		var_field.array_get(rt.new_string('name'))
	} else {
		var_field.array_get(rt.new_string('id'))
	})
	var_field.array_set('desc_tip', if var_field.array_isset(rt.new_string('desc_tip')) {
		var_field.array_get(rt.new_string('desc_tip'))
	} else {
		rt.new_bool(false)
	})
	print('<fieldset class="form-field ' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() +
		'_field ' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('wrapper_class'))])).str() +
		'"><legend>' +
		(rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('label'))])).str() +
		'</legend>')
	if !(!rt.is_true(var_field.array_get(rt.new_string('description'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get(rt.new_string('desc_tip')))))) {
		rt.echo_val(rt.call_function('wc_help_tip', [
			var_field.array_get(rt.new_string('description')),
		]))
	}
	print('<ul class="wc-radios">')
	mut iter_5 := var_field.array_get(rt.new_string('options')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_value_shadow := item_5.val
		mut var_key_shadow := item_5.key
		print('<li><label><input\n\t\t\t\tname="' +
			(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('name'))])).str() +
			'"\n\t\t\t\tvalue="' + (rt.call_function('esc_attr', [var_key_shadow.clone()])).str() +
			'"\n\t\t\t\ttype="radio"\n\t\t\t\tclass="' +
			(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('class'))])).str() +
			'"\n\t\t\t\tstyle="' +
			(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('style'))])).str() +
			'"\n\t\t\t\t' +
			(rt.call_function('checked', [rt.call_function('esc_attr', [var_field.array_get(rt.new_string('value'))]), rt.call_function('esc_attr', [var_key_shadow.clone()]), rt.new_bool(false)])).str() +
			'\n\t\t\t\t/> ' + (rt.call_function('esc_html', [var_value_shadow.clone()])).str() +
			'</label>\n\t\t</li>')
	}
	print('</ul>')
	if !(!rt.is_true(var_field.array_get(rt.new_string('description'))))
		&& rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get(rt.new_string('desc_tip')))) {
		print('<span class="description">' +
			(rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('description'))])).str() +
			'</span>')
	}
	print('</fieldset>')
}

fn woocommerce_wp_note(var_field rt.PhpVal) {
	var_field.array_set('wrapper_class', if var_field.array_isset(rt.new_string('wrapper_class')) {
		var_field.array_get(rt.new_string('wrapper_class'))
	} else {
		rt.new_string('')
	})
	print('<p class="form-field ' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('wrapper_class'))])).str() +
		'">')
	print('<label for="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() + '" ')
	if !(!rt.is_true(var_field.array_get(rt.new_string('label-aria-label')))) {
		print('aria-label="' +
			(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('label-aria-label'))])).str() +
			'"')
	}
	print('>' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('label'))])).str() +
		'</label>')
	print('<output name="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() +
		'" id="' +
		(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('id'))])).str() +
		'" aria-live="off">' +
		(rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('message'))])).str() +
		'</output>')
	print('</p>')
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

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
}

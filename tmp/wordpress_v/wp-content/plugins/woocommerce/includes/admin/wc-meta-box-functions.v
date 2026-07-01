import rt

fn woocommerce_wp_text_input(var_field rt.PhpVal, var_data rt.PhpVal) {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	var_field.array_set('placeholder', if var_field.array_isset(rt.new_string('placeholder')) { var_field.array_get('placeholder') } else { rt.new_string('') })
	var_field.array_set('class', if var_field.array_isset(rt.new_string('class')) { var_field.array_get('class') } else { rt.new_string('short') })
	var_field.array_set('style', if var_field.array_isset(rt.new_string('style')) { var_field.array_get('style') } else { rt.new_string('') })
	var_field.array_set('wrapper_class', if var_field.array_isset(rt.new_string('wrapper_class')) { var_field.array_get('wrapper_class') } else { rt.new_string('') })
	var_field.array_set('value', if !(var_field.array_get('value')).is_null() { var_field.array_get('value') } else { fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.get_post_or_object_meta(arg_0, arg_1, arg_2, arg_3) }(var_post.dup(), var_data.dup(), var_field.array_get('id'), rt.new_bool(true)) })
	var_field.array_set('name', if var_field.array_isset(rt.new_string('name')) { var_field.array_get('name') } else { var_field.array_get('id') })
	var_field.array_set('type', if var_field.array_isset(rt.new_string('type')) { var_field.array_get('type') } else { rt.new_string('text') })
	var_field.array_set('desc_tip', if var_field.array_isset(rt.new_string('desc_tip')) { var_field.array_get('desc_tip') } else { rt.new_bool(false) })
	mut var_data_type := if !rt.is_true(var_field.array_get('data_type')) { rt.new_string('') } else { var_field.array_get('data_type') }
	mut switch_val_1 := var_data_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('price'))) {
		// unsupported expression: Expr_AssignOp_Concat
		var_field.array_set('value', rt.call_function('wc_format_localized_price', [var_field.array_get('value')]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('decimal'))) {
		// unsupported expression: Expr_AssignOp_Concat
		var_field.array_set('value', rt.call_function('wc_format_localized_decimal', [var_field.array_get('value')]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stock'))) {
		// unsupported expression: Expr_AssignOp_Concat
		var_field.array_set('value', rt.call_function('wc_stock_amount', [var_field.array_get('value')]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('url'))) {
		// unsupported expression: Expr_AssignOp_Concat
		var_field.array_set('value', rt.call_function('esc_url', [var_field.array_get('value')]))
	} else {
	}
	mut var_custom_attributes := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_field.array_get('custom_attributes'))) && rt.is_true(rt.new_bool(var_field.array_get('custom_attributes').is_array())))) {
		{
			mut iter_1 := var_field.array_get('custom_attributes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_attribute := item_1.key
				var_custom_attributes << (rt.call_function('esc_attr', [var_attribute.dup()])).str() + '="' + (rt.call_function('esc_attr', [var_value.dup()])).str() + '"'
			}
		}
	}
	print('<p class="form-field ' + (rt.call_function('esc_attr', [var_field.array_get('id')])).str() + '_field ' + (rt.call_function('esc_attr', [var_field.array_get('wrapper_class')])).str() + '">\n\t\t<label for="' + (rt.call_function('esc_attr', [var_field.array_get('id')])).str() + '">' + (rt.call_function('wp_kses_post', [var_field.array_get('label')])).str() + '</label>')
	mut var_help_tip := rt.new_null()
	mut var_description := rt.new_null()
	if !(!rt.is_true(var_field.array_get('description'))) {
		if rt.is_true(rt.new_bool(var_field.array_get('description').is_array())) {
			var_help_tip = rt.call_function('reset', [var_field.array_get('description')])
			var_description = rt.call_function('end', [var_field.array_get('description')])
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_help_tip = var_field.array_get('description')
		} else {
			var_description = var_field.array_get('description')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_help_tip.dup().is_null()))))) {
		rt.echo_val(rt.call_function('wc_help_tip', [var_help_tip.dup()]))
	}
	print('<input type="' + (rt.call_function('esc_attr', [var_field.array_get('type')])).str() + '" class="' + (rt.call_function('esc_attr', [var_field.array_get('class')])).str() + '" style="' + (rt.call_function('esc_attr', [var_field.array_get('style')])).str() + '" name="' + (rt.call_function('esc_attr', [var_field.array_get('name')])).str() + '" id="' + (rt.call_function('esc_attr', [var_field.array_get('id')])).str() + '" value="' + (rt.call_function('esc_attr', [var_field.array_get('value')])).str() + '" placeholder="' + (rt.call_function('esc_attr', [var_field.array_get('placeholder')])).str() + '" ' + (rt.call_function('implode', [rt.new_string(' '), var_custom_attributes.dup()])).str() + ' /> ')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_description.dup().is_null()))))) {
		mut var_hidden_class := if rt.is_true(rt.identical(rt.new_bool(true), if !(var_field.array_get('description_hidden')).is_null() { var_field.array_get('description_hidden') } else { rt.new_bool(false) })) { ' hidden' } else { '' }
		print('<span class="description' + var_hidden_class + '">' + (rt.call_function('wp_kses_post', [var_description.dup()])).str() + '</span>')
	}
	print('</p>')
}

fn woocommerce_wp_hidden_input(var_field rt.PhpVal, var_data rt.PhpVal) {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	var_field.array_set('value', if var_field.array_isset(rt.new_string('value')) { var_field.array_get('value') } else { fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.get_post_or_object_meta(arg_0, arg_1, arg_2, arg_3) }(var_post.dup(), var_data.dup(), var_field.array_get('id'), rt.new_bool(true)) })
	var_field.array_set('class', if var_field.array_isset(rt.new_string('class')) { var_field.array_get('class') } else { rt.new_string('') })
	print('<input type="hidden" class="' + (rt.call_function('esc_attr', [var_field.array_get('class')])).str() + '" name="' + (rt.call_function('esc_attr', [var_field.array_get('id')])).str() + '" id="' + (rt.call_function('esc_attr', [var_field.array_get('id')])).str() + '" value="' + (rt.call_function('esc_attr', [var_field.array_get('value')])).str() + '" /> ')
}

fn woocommerce_wp_textarea_input(var_field rt.PhpVal, var_data rt.PhpVal) {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	var_field.array_set('placeholder', if var_field.array_isset(rt.new_string('placeholder')) { var_field.array_get('placeholder') } else { rt.new_string('') })
	var_field.array_set('class', if var_field.array_isset(rt.new_string('class')) { var_field.array_get('class') } else { rt.new_string('short') })
	var_field.array_set('style', if var_field.array_isset(rt.new_string('style')) { var_field.array_get('style') } else { rt.new_string('') })
	var_field.array_set('wrapper_class', if var_field.array_isset(rt.new_string('wrapper_class')) { var_field.array_get('wrapper_class') } else { rt.new_string('') })
	var_field.array_set('value', if !(var_field.array_get('value')).is_null() { var_field.array_get('value') } else { fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.get_post_or_object_meta(arg_0, arg_1, arg_2, arg_3) }(var_post.dup(), var_data.dup(), var_field.array_get('id'), rt.new_bool(true)) })
	var_field.array_set('desc_tip', if var_field.array_isset(rt.new_string('desc_tip')) { var_field.array_get('desc_tip') } else { rt.new_bool(false) })
	var_field.array_set('name', if var_field.array_isset(rt.new_string('name')) { var_field.array_get('name') } else { var_field.array_get('id') })
	var_field.array_set('rows', if var_field.array_isset(rt.new_string('rows')) { var_field.array_get('rows') } else { rt.new_int(2) })
	var_field.array_set('cols', if var_field.array_isset(rt.new_string('cols')) { var_field.array_get('cols') } else { rt.new_int(20) })
	mut var_custom_attributes := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_field.array_get('custom_attributes'))) && rt.is_true(rt.new_bool(var_field.array_get('custom_attributes').is_array())))) {
		{
			mut iter_1 := var_field.array_get('custom_attributes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_attribute := item_1.key
				var_custom_attributes << (rt.call_function('esc_attr', [var_attribute.dup()])).str() + '="' + (rt.call_function('esc_attr', [var_value.dup()])).str() + '"'
			}
		}
	}
	print('<p class="form-field ' + (rt.call_function('esc_attr', [var_field.array_get('id')])).str() + '_field ' + (rt.call_function('esc_attr', [var_field.array_get('wrapper_class')])).str() + '">\n\t\t<label for="' + (rt.call_function('esc_attr', [var_field.array_get('id')])).str() + '">' + (rt.call_function('wp_kses_post', [var_field.array_get('label')])).str() + '</label>')
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_field.array_get('description'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.echo_val(rt.call_function('wc_help_tip', [var_field.array_get('description')]))
	}
	print('<textarea class="' + (rt.call_function('esc_attr', [var_field.array_get('class')])).str() + '" style="' + (rt.call_function('esc_attr', [var_field.array_get('style')])).str() + '"  name="' + (rt.call_function('esc_attr', [var_field.array_get('name')])).str() + '" id="' + (rt.call_function('esc_attr', [var_field.array_get('id')])).str() + '" placeholder="' + (rt.call_function('esc_attr', [var_field.array_get('placeholder')])).str() + '" rows="' + (rt.call_function('esc_attr', [var_field.array_get('rows')])).str() + '" cols="' + (rt.call_function('esc_attr', [var_field.array_get('cols')])).str() + '" ' + (rt.call_function('implode', [rt.new_string(' '), var_custom_attributes.dup()])).str() + '>' + (rt.call_function('esc_textarea', [var_field.array_get('value')])).str() + '</textarea> ')
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_field.array_get('description'))) && rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get('desc_tip'))))) {
		print('<span class="description">' + (rt.call_function('wp_kses_post', [var_field.array_get('description')])).str() + '</span>')
	}
	print('</p>')
}

fn woocommerce_wp_checkbox(var_field rt.PhpVal, var_data rt.PhpVal) {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	var_field.array_set('class', if var_field.array_isset(rt.new_string('class')) { var_field.array_get('class') } else { rt.new_string('checkbox') })
	var_field.array_set('style', if var_field.array_isset(rt.new_string('style')) { var_field.array_get('style') } else { rt.new_string('') })
	var_field.array_set('wrapper_class', if var_field.array_isset(rt.new_string('wrapper_class')) { var_field.array_get('wrapper_class') } else { rt.new_string('') })
	var_field.array_set('value', if !(var_field.array_get('value')).is_null() { var_field.array_get('value') } else { fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.get_post_or_object_meta(arg_0, arg_1, arg_2, arg_3) }(var_post.dup(), var_data.dup(), var_field.array_get('id'), rt.new_bool(true)) })
	var_field.array_set('cbvalue', if var_field.array_isset(rt.new_string('cbvalue')) { var_field.array_get('cbvalue') } else { rt.new_string('yes') })
	var_field.array_set('name', if var_field.array_isset(rt.new_string('name')) { var_field.array_get('name') } else { var_field.array_get('id') })
	var_field.array_set('desc_tip', if var_field.array_isset(rt.new_string('desc_tip')) { var_field.array_get('desc_tip') } else { rt.new_bool(false) })
	var_field.array_set('checked_value', if var_field.array_isset(rt.new_string('checked_value')) { var_field.array_get('checked_value') } else { var_field.array_get('cbvalue') })
	var_field.array_set('unchecked_value', if var_field.array_isset(rt.new_string('unchecked_value')) { var_field.array_get('unchecked_value') } else { rt.new_null() })
	mut var_custom_attributes := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_field.array_get('custom_attributes'))) && rt.is_true(rt.new_bool(var_field.array_get('custom_attributes').is_array())))) {
		{
			mut iter_1 := var_field.array_get('custom_attributes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_attribute := item_1.key
				var_custom_attributes << (rt.call_function('esc_attr', [var_attribute.dup()])).str() + '="' + (rt.call_function('esc_attr', [var_value.dup()])).str() + '"'
			}
		}
	}
	if !(!rt.is_true(var_field.array_get('style'))) {
		var_custom_attributes << 'style="' + (rt.call_function('esc_attr', [var_field.array_get('style')])).str() + '"'
	}
	if !(!rt.is_true(var_field.array_get('class'))) {
		var_custom_attributes << 'class="' + (rt.call_function('esc_attr', [var_field.array_get('class')])).str() + '"'
	}
	print('<p class="form-field ' + (rt.call_function('esc_attr', [var_field.array_get('id')])).str() + '_field ' + (rt.call_function('esc_attr', [var_field.array_get('wrapper_class')])).str() + '">\n\t\t<label for="' + (rt.call_function('esc_attr', [var_field.array_get('id')])).str() + '">' + (rt.call_function('wp_kses_post', [var_field.array_get('label')])).str() + '</label>')
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_field.array_get('description'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.echo_val(rt.call_function('wc_help_tip', [var_field.array_get('description')]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_field.array_get('unchecked_value').is_null()))))) {
		rt.call_function('printf', [rt.new_string('<input type="hidden" name="%1$s" value="%2$s" />'), rt.call_function('esc_attr', [var_field.array_get('name')]), rt.call_function('esc_attr', [var_field.array_get('unchecked_value')])])
	}
	rt.call_function('printf', [rt.new_string('<input type="checkbox" name="%1$s" id="%2$s" value="%3$s" %4$s %5$s />'), rt.call_function('esc_attr', [var_field.array_get('name')]), rt.call_function('esc_attr', [var_field.array_get('id')]), rt.call_function('esc_attr', [var_field.array_get('checked_value')]), rt.call_function('checked', [var_field.array_get('value'), var_field.array_get('checked_value'), rt.new_bool(false)]), rt.call_function('implode', [rt.new_string(' '), var_custom_attributes.dup()])])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_field.array_get('description'))) && rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get('desc_tip'))))) {
		print('<span class="description">' + (rt.call_function('wp_kses_post', [var_field.array_get('description')])).str() + '</span>')
	}
	print('</p>')
}

fn woocommerce_wp_select(var_field rt.PhpVal, var_data rt.PhpVal) {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	var_field = rt.call_function('wp_parse_args', [var_field.dup(), rt.create_array([rt.ArrayItem{ key: 'class', val: 'select short' }, rt.ArrayItem{ key: 'style', val: '' }, rt.ArrayItem{ key: 'wrapper_class', val: '' }, rt.ArrayItem{ key: 'value', val: fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.get_post_or_object_meta(arg_0, arg_1, arg_2, arg_3) }(var_post.dup(), var_data.dup(), var_field.array_get('id'), rt.new_bool(true)) }, rt.ArrayItem{ key: 'name', val: var_field.array_get('id') }, rt.ArrayItem{ key: 'desc_tip', val: false }, rt.ArrayItem{ key: 'custom_attributes', val: []rt.PhpVal{} }])])
	mut var_wrapper_attributes := { 'class': (var_field.array_get('wrapper_class')).str() + rt.concat(rt.concat(rt.new_string(' form-field '), var_field.array_get('id')), rt.new_string('_field')) }
	mut var_label_attributes := { 'for': var_field.array_get('id') }
	mut var_field_attributes := rt.cast_array(var_field.array_get('custom_attributes'))
	var_field_attributes.array_set('style', var_field.array_get('style'))
	var_field_attributes.array_set('id', var_field.array_get('id'))
	var_field_attributes.array_set('name', var_field.array_get('name'))
	var_field_attributes.array_set('class', var_field.array_get('class'))
	mut var_tooltip := if rt.is_true(rt.new_bool(!(!rt.is_true(var_field.array_get('description'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) { var_field.array_get('description') } else { rt.new_string('') }
	mut var_description := if rt.is_true(rt.new_bool(!(!rt.is_true(.array_get())) && rt.is_true(rt.identical(, )))) { var_field.array_get('description') } else { rt.new_string('') }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_implode_html_attributes', [var_wrapper_attributes.dup()]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_wc_meta_box_functions_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}

import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.default_table_attrs() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'border', val: '0' },
		rt.ArrayItem{ key: 'cellpadding', val: '0' }, rt.ArrayItem{ key: 'cellspacing', val: '0' },
		rt.ArrayItem{ key: 'role', val: 'presentation' }])
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.render_table_cell(content string, mut var_cell_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array) string {
	mut content_mutated := content
	mut var_cell_attr_string :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.build_attributes_string(mut var_cell_attrs)
	return (rt.call_function('sprintf', [rt.new_string('<td%1$s>%2$s</td>'),
		rt.new_string((if rt.is_true(var_cell_attr_string) {
			' ' + var_cell_attr_string.str()
		} else {
			''
		}).str()),
		rt.new_string(content_mutated).clone()])).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.render_outlook_table_cell(content string, mut var_cell_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array) string {
	mut content_mutated := content
	mut var_content_with_outlook_conditional := rt.new_string('<![endif]-->' + content_mutated +
		'<!--[if mso | IE]>')
	return '<!--[if mso | IE]>' +
		(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.render_table_cell(var_content_with_outlook_conditional.str(), mut var_cell_attrs)).str() +
		'<![endif]-->'
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.render_table_wrapper(content string, mut var_table_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array, mut var_cell_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array, mut var_row_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array, render_cell bool) string {
	mut content_mutated := content
	mut var_merged_table_attrs := rt.call_function('array_merge', [
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.default_table_attrs(),
		var_table_attrs,
	])
	mut var_table_attr_string :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.build_attributes_string(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](var_merged_table_attrs))
	mut var_row_attr_string :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.build_attributes_string(mut var_row_attrs)
	if var_render_cell {
		content_mutated = (Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.render_table_cell(content_mutated, mut
			var_cell_attrs)).str()
	}
	return (rt.call_function('sprintf', [
		rt.new_string('<table%2$s>\n\t\t<tbody>\n\t\t\t<tr%3$s>\n\t\t\t\t%1$s\n\t\t\t</tr>\n\t\t</tbody>\n\t</table>'),
		rt.new_string(content_mutated).clone(),
		rt.new_string((if rt.is_true(var_table_attr_string) {
			' ' + var_table_attr_string.str()
		} else {
			''
		}).str()),
		rt.new_string((if rt.is_true(var_row_attr_string) {
			' ' + var_row_attr_string.str()
		} else {
			''
		}).str()),
	])).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.render_outlook_table_wrapper(content string, mut var_table_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array, mut var_cell_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array, mut var_row_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array, render_cell bool) string {
	mut content_mutated := content
	mut var_content_with_outlook_conditional := rt.new_string('<![endif]-->' + content_mutated +
		'<!--[if mso | IE]>')
	return '<!--[if mso | IE]>' +
		(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.render_table_wrapper(var_content_with_outlook_conditional.str(), mut var_table_attrs, mut var_cell_attrs, mut var_row_attrs, render_cell)).str() +
		'<![endif]-->'
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.build_attributes_string(mut var_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array) string {
	mut var_attr_parts := rt.new_array()
	mut iter_1 := var_attributes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value)))) {
			var_attr_parts.array_push(rt.call_function('sprintf', [
				rt.new_string('%s="%s"'),
				var_key.clone(),
				rt.call_function('esc_attr', [var_value.clone()]),
			]))
		}
	}
	return (rt.call_function('implode', [rt.new_string(' '), var_attr_parts.clone()])).str()
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_table_wrapper_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_table_cell' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.render_table_cell(dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'render_outlook_table_cell' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.render_outlook_table_cell(dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'render_table_wrapper' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.render_table_wrapper(dispatch_arg_0, mut
				dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4))
		}
		'render_outlook_table_wrapper' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.render_outlook_table_wrapper(dispatch_arg_0, mut
				dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4))
		}
		'build_attributes_string' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper.build_attributes_string(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

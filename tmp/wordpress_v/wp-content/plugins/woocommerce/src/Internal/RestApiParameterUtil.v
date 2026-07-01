import rt

struct Class_Automattic_WooCommerce_Internal_RestApiParameterUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.adjust_create_refund_request_parameters(mut var_request Class_Automattic_WooCommerce_Internal_WP_REST_Request)  {
	mut var_request_mutated := var_request
	if !rt.is_true(var_request_mutated.array_get('reason')) {
		var_request_mutated.array_set('reason', rt.new_null())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_request_mutated.array_get('api_refund').is_bool()))))) {
		var_request_mutated.array_set('api_refund', true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_request_mutated.array_get('api_restock').is_bool()))))) {
		var_request_mutated.array_set('api_restock', true)
	}
	if !rt.is_true(var_request_mutated.array_get('line_items')) {
		var_request_mutated.array_set('line_items', rt.new_array())
	} else {
		var_request_mutated.array_set('line_items', Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.adjust_line_items_for_create_refund_request(var_request_mutated.array_get('line_items')))
	}
	if !(var_request_mutated.array_isset(rt.new_string('amount'))) {
		mut var_amount := Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.calculate_refund_amount_from_line_items(rt.new_object('Automattic_WooCommerce_Internal_WP_REST_Request', []string{}, var_request_mutated))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_request_mutated.array_set('amount', var_amount.dup().to_string())
		}
	}
}

fn Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.calculate_refund_amount_from_line_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_line_items := var_request_mutated.array_get('line_items')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_line_items.dup().is_array()))))) || !rt.is_true(var_line_items))) {
		return rt.new_null()
	}
	mut var_amount := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := var_line_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.new_bool(!(var_item.array_isset(rt.new_string('refund_total'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_item.array_get('refund_total').is_long() || var_item.array_get('refund_total').is_double()))))))) {
				return rt.new_null()
			}
			// unsupported expression: Expr_AssignOp_Plus
			if !(var_item.array_isset(rt.new_string('refund_tax'))) {
				continue
			}
			{
				mut iter_2 := var_item.array_get('refund_tax').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_tax := item_2.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_tax.dup().is_long() || var_tax.dup().is_double()))))) {
						return rt.new_null()
					}
					// unsupported expression: Expr_AssignOp_Plus
				}
			}
		}
	}
	return var_amount.dup()
}

fn Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.adjust_line_items_for_create_refund_request(var_line_items rt.PhpVal) rt.PhpVal {
	mut var_line_items_mutated := var_line_items
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_line_items_mutated.dup().is_array()))))) || !rt.is_true(var_line_items_mutated))) || rt.is_true(Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.is_associative(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_array](var_line_items_mutated))))) {
		return var_line_items_mutated.dup()
	}
	mut var_new_array := rt.new_array()
	{
		mut iter_1 := var_line_items_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if !(var_item.array_isset(rt.new_string('id'))) {
				return var_line_items_mutated.dup()
			}
			if var_item.array_isset(rt.new_string('quantity')) && !(var_item.array_isset(rt.new_string('qty'))) {
				var_item.array_set('qty', var_item.array_get('quantity'))
			}
			var_item.array_unset(rt.new_string('quantity'))
			if var_item.array_isset(rt.new_string('refund_tax')) {
				var_item.array_set('refund_tax', Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.adjust_taxes_for_create_refund_request_line_item(var_item.array_get('refund_tax')))
			}
			mut var_id := var_item.array_get('id')
			var_new_array.array_set(var_id, var_item.dup())
			var_new_array.array_get(var_id).array_unset(rt.new_string('id'))
		}
	}
	return var_new_array.dup()
}

fn Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.adjust_taxes_for_create_refund_request_line_item(var_taxes_array rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_taxes_array.dup().is_array()))))) || !rt.is_true(var_taxes_array))) || rt.is_true(Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.is_associative(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_array](var_taxes_array))))) {
		return var_taxes_array.dup()
	}
	mut var_new_array := rt.new_array()
	{
		mut iter_1 := var_taxes_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if !(var_item.array_isset(rt.new_string('id'))) || !(var_item.array_isset(rt.new_string('refund_total'))) {
				return var_taxes_array.dup()
			}
			mut var_id := var_item.array_get('id')
			mut var_refund_total := var_item.array_get('refund_total')
			var_new_array.array_set(var_id, var_refund_total.dup())
		}
	}
	return var_new_array.dup()
}

fn Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.is_associative(mut var_the_array Class_Automattic_WooCommerce_Internal_array) rt.PhpVal {
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn create_automattic_woocommerce_internal_restapiparameterutil() &Class_Automattic_WooCommerce_Internal_RestApiParameterUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiParameterUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiParameterUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'adjust_create_refund_request_parameters' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.adjust_create_refund_request_parameters(mut dispatch_arg_0)
			return rt.new_null()
		}
		'calculate_refund_amount_from_line_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.calculate_refund_amount_from_line_items(dispatch_arg_0)
		}
		'adjust_line_items_for_create_refund_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.adjust_line_items_for_create_refund_request(dispatch_arg_0)
		}
		'adjust_taxes_for_create_refund_request_line_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.adjust_taxes_for_create_refund_request_line_item(dispatch_arg_0)
		}
		'is_associative' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_RestApiParameterUtil.is_associative(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApiParameterUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiParameterUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapiparameterutil_php() {
}

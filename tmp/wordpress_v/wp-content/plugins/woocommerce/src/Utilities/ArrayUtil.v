import rt

pub fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_auto() i64 {
	return 0
}
pub fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_method() i64 {
	return 1
}
pub fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_property() i64 {
	return 2
}
pub fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_array_key() i64 {
	return 3
}
struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.get_nested_value(mut var_items Class_Automattic_WooCommerce_Utilities_array, key string, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_items_mutated := var_items
	mut key_mutated := key
	mut var_key_stack := rt.call_function('explode', [rt.new_string('::'), rt.new_string(key_mutated).dup()])
	mut var_subkey := rt.call_function('array_shift', [var_key_stack.dup()])
	if var_items_mutated.array_isset(var_subkey) {
		mut var_value := var_items_mutated.array_get(var_subkey)
		if rt.is_true(rt.new_int(var_key_stack.dup().array_count())) {
			{
				mut iter_1 := var_key_stack.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_subkey_shadow := item_1.val
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_array())) && var_value.array_isset(var_subkey_shadow))) {
						var_value = var_value.array_get(var_subkey_shadow)
					} else {
						var_value = var_default_value
						break
					}
				}
			}
		}
	} else {
		var_value = var_default_value
	}
	return var_value.dup()
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.is_truthy(mut var_items Class_Automattic_WooCommerce_Utilities_array, key string) bool {
	mut var_items_mutated := var_items
	mut key_mutated := key
	return var_items_mutated.array_isset(rt.new_string(key_mutated)) && rt.is_true(var_items_mutated.array_get(key_mutated))
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.get_value_or_default(mut var_items Class_Automattic_WooCommerce_Utilities_array, key string, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_items_mutated := var_items
	mut key_mutated := key
	return if rt.is_true(rt.new_bool(var_items_mutated.dup().array_isset(rt.new_string(key_mutated).dup()))) { var_items_mutated.array_get(key_mutated) } else { var_default_value }
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.to_ranges_string(mut var_items Class_Automattic_WooCommerce_Utilities_array, item_separator string, range_separator string, sort bool) string {
	mut var_items_mutated := var_items
	if var_sort {
		rt.call_function('sort', [var_items_mutated.dup()])
	}
	mut var_point := rt.new_null()
	mut var_range := rt.new_bool(rt.new_bool(false))
	mut var_str := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_items_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_i := item_1.val
			if rt.is_true(rt.identical(rt.new_null(), var_point)) {
				// unsupported expression: Expr_AssignOp_Concat
			} else if rt.is_true(rt.identical(rt.add(var_point, rt.new_int(1)), var_i)) {
				var_range = rt.new_bool(rt.new_bool(true))
			} else {
				if rt.is_true(var_range) {
					// unsupported expression: Expr_AssignOp_Concat
					var_range = rt.new_bool(rt.new_bool(false))
				}
				// unsupported expression: Expr_AssignOp_Concat
			}
			var_point = var_i
		}
	}
	if rt.is_true(var_range) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return (var_str).str()
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.get_selector_callback(selector_name string, selector_type i64) rt.PhpVal {
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Utilities_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_method(), rt.new_int(selector_type))) {
		closure_1_fn := fn [var_selector_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_item, rt.new_string(var_selector_name), []rt.PhpVal{})
	}
		mut var_callback := rt.new_closure(closure_1_fn)
	} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Utilities_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_property(), rt.new_int(selector_type))) {
		closure_2_fn := fn [var_selector_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_item, '{"nodeType":"Expr_Variable","line":158,"name":"selector_name"}')
	}
		var_callback = rt.new_closure(closure_2_fn)
	} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Utilities_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_array_key(), rt.new_int(selector_type))) {
		closure_3_fn := fn [var_selector_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_item.array_get(rt.new_string(var_selector_name))
	}
		var_callback = rt.new_closure(closure_3_fn)
	} else {
		closure_4_fn := fn [var_selector_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(var_item.dup().is_array())) {
		return var_item.array_get(rt.new_string(var_selector_name))
	} else if rt.is_true(rt.call_function('method_exists', [var_item.dup(), rt.new_string(selector_name)])) {
		return rt.call_method(var_item, rt.new_string(var_selector_name), []rt.PhpVal{})
	} else {
		return rt.get_property(var_item, '{"nodeType":"Expr_Variable","line":171,"name":"selector_name"}')
	}
	return rt.new_null()
	}
		var_callback = rt.new_closure(closure_4_fn)
	}
	return var_callback.dup()
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.select(mut var_items Class_Automattic_WooCommerce_Utilities_array, selector_name string, selector_type i64) rt.PhpVal {
	mut var_items_mutated := var_items
	mut var_callback := Class_Automattic_WooCommerce_Utilities_ArrayUtil.get_selector_callback(selector_name, selector_type)
	return rt.call_function('array_map', [var_callback.dup(), var_items_mutated.dup()])
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_as_assoc(mut var_items Class_Automattic_WooCommerce_Utilities_array, selector_name string, selector_type i64) rt.PhpVal {
	mut var_items_mutated := var_items
	mut var_selector_callback := Class_Automattic_WooCommerce_Utilities_ArrayUtil.get_selector_callback(selector_name, selector_type)
	mut var_result := rt.new_array()
	{
		mut iter_1 := var_items_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := rt.call_callable(var_selector_callback, [var_item.dup()])
			Class_Automattic_WooCommerce_Utilities_ArrayUtil.ensure_key_is_array(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](var_result), (var_key).str())
			var_result.array_get_mut(var_key).array_push(var_item.dup())
		}
	}
	return var_result.dup()
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.deep_compare_array_diff(mut var_array1 Class_Automattic_WooCommerce_Utilities_array, mut var_array2 Class_Automattic_WooCommerce_Utilities_array, strict bool) rt.PhpVal {
	return Class_Automattic_WooCommerce_Utilities_ArrayUtil.deep_compute_or_compare_array_diff(mut var_array1, mut var_array2, true, strict)
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.deep_assoc_array_diff(mut var_array1 Class_Automattic_WooCommerce_Utilities_array, mut var_array2 Class_Automattic_WooCommerce_Utilities_array, strict bool) rt.PhpVal {
	return Class_Automattic_WooCommerce_Utilities_ArrayUtil.deep_compute_or_compare_array_diff(mut var_array1, mut var_array2, false, strict)
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.deep_compute_or_compare_array_diff(mut var_array1 Class_Automattic_WooCommerce_Utilities_array, mut var_array2 Class_Automattic_WooCommerce_Utilities_array, compare bool, strict bool) bool {
	mut var_diff := rt.new_array()
	{
		mut iter_1 := var_array1.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_array2.array_isset(var_key.dup())))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_array2.array_get(var_key).is_array()))))))) {
					if var_compare {
						return true
					}
					var_diff.array_set(var_key, var_value.dup())
					continue
				}
				mut var_new_diff := Class_Automattic_WooCommerce_Utilities_ArrayUtil.deep_assoc_array_diff(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](var_value), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](var_array2.array_get(var_key)), strict)
				if !(!rt.is_true(var_new_diff)) {
					if var_compare {
						return true
					}
					var_diff.array_set(var_key, var_new_diff.dup())
				}
			} else if var_strict {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_array2.array_isset(var_key.dup())))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					if var_compare {
						return true
					}
					var_diff.array_set(var_key, var_value.dup())
				}
				// unsupported statement: Stmt_Nop
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_array2.array_isset(var_key.dup())))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
				if var_compare {
					return true
				}
				var_diff.array_set(var_key, var_value.dup())
			}
		}
	}
	return (if var_compare { rt.new_bool(false) } else { var_diff }).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.push_once(mut var_items Class_Automattic_WooCommerce_Utilities_array, var_value rt.PhpVal) bool {
	mut var_items_mutated := var_items
	mut var_value_mutated := var_value
	if rt.is_true(rt.call_function('in_array', [var_value_mutated.dup(), var_items_mutated.dup(), rt.new_bool(true)])) {
		return false
	}
	var_items_mutated.array_push(var_value_mutated.dup())
	return true
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.ensure_key_is_array(mut var_items Class_Automattic_WooCommerce_Utilities_array, key string, throw_if_existing_is_not_array bool) bool {
	mut var_items_mutated := var_items
	mut key_mutated := key
	if !(var_items_mutated.array_isset(rt.new_string(key_mutated))) {
		var_items_mutated.array_set(key_mutated, rt.new_array())
		return true
	}
	if rt.is_true(rt.new_bool(var_throw_if_existing_is_not_array && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_items_mutated.array_get(key_mutated).is_array()))))))) {
		mut var_type := if rt.is_true(rt.new_bool(var_items_mutated.array_get(key_mutated).is_object())) { rt.call_function('get_class', [var_items_mutated.array_get(key_mutated)]) } else { rt.call_function('gettype', [var_items_mutated.array_get(key_mutated)]) }
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Utilities_Exception', []string{}, create_automattic_woocommerce_utilities_exception(rt.new_string("Array key exists but it's not an array, it's a ${var_type.to_string()}"))))
	}
	return false
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.group_by_column(mut var_items Class_Automattic_WooCommerce_Utilities_array, column string, single_values bool) rt.PhpVal {
	mut var_items_mutated := var_items
	if var_single_values {
		return rt.call_function('array_combine', [rt.call_function('array_column', [var_items_mutated.dup(), rt.new_string(column)]), rt.call_function('array_values', [var_items_mutated.dup()])])
	}
	mut var_distinct_column_values := rt.call_function('array_unique', [rt.call_function('array_column', [var_items_mutated.dup(), rt.new_string(column)]), rt.get_constant('SORT_REGULAR')])
	mut var_result := rt.call_function('array_fill_keys', [var_distinct_column_values.dup(), rt.new_array()])
	{
		mut iter_1 := var_items_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			var_result.array_get_mut(var_value.array_get(column)).array_push(var_value.dup())
		}
	}
	return var_result.dup()
}

fn Class_Automattic_WooCommerce_Utilities_ArrayUtil.array_all(mut var_items Class_Automattic_WooCommerce_Utilities_array, mut var_callback Class_Automattic_WooCommerce_Utilities_callable) bool {
	mut var_items_mutated := var_items
	mut var_callback_mutated := var_callback
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('array_all')])) {
		return (rt.call_function('array_all', [var_items_mutated.dup(), var_callback_mutated.dup()])).to_bool()
	}
	{
		mut iter_1 := var_items_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_callable(var_callback_mutated, [var_item.dup()]))))) {
				return false
			}
		}
	}
	return true
}

struct Class_Automattic_WooCommerce_Utilities_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_arrayutil() &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_exception() &Class_Automattic_WooCommerce_Utilities_Exception {
	mut obj := &Class_Automattic_WooCommerce_Utilities_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_nested_value' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Utilities_ArrayUtil.get_nested_value(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'is_truthy' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_ArrayUtil.is_truthy(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_value_or_default' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Utilities_ArrayUtil.get_value_or_default(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'to_ranges_string' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_ArrayUtil.to_ranges_string(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'get_selector_callback' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Utilities_ArrayUtil.get_selector_callback(dispatch_arg_0, dispatch_arg_1)
		}
		'select' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Utilities_ArrayUtil.select(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'select_as_assoc' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_as_assoc(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'deep_compare_array_diff' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Utilities_ArrayUtil.deep_compare_array_diff(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'deep_assoc_array_diff' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Utilities_ArrayUtil.deep_assoc_array_diff(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'deep_compute_or_compare_array_diff' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_ArrayUtil.deep_compute_or_compare_array_diff(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'push_once' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_ArrayUtil.push_once(mut dispatch_arg_0, dispatch_arg_1))
		}
		'ensure_key_is_array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_ArrayUtil.ensure_key_is_array(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'group_by_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Utilities_ArrayUtil.group_by_column(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'array_all' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_callable](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_ArrayUtil.array_all(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_utilities_arrayutil_php() {
	// unsupported statement: Stmt_Declare
}

import rt

struct Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil.array_is_list(mut var_arr Class_Automattic_WooCommerce_Internal_Utilities_array) bool {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('array_is_list')])) {
		return (rt.call_function('array_is_list', [var_arr])).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_array(), var_arr)) || rt.is_true(rt.identical(rt.call_function('array_values', [var_arr]), var_arr)) {
		return true
	}
	mut var_next_key := rt.new_int(-1)
	mut iter_1 := var_arr.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_v := item_1.val
		mut var_k := item_1.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.pre_inc(var_next_key), var_k)))) {
			return false
		}
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil.merge_by_key(mut var_arr1 Class_Automattic_WooCommerce_Internal_Utilities_array, mut var_arr2 Class_Automattic_WooCommerce_Internal_Utilities_array, key string) rt.PhpVal {
	mut var_merged := rt.new_array()
	mut iter_2 := var_arr1.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_item1 := item_2.val
		mut var_found := rt.new_bool(false)
		mut iter_3 := var_arr2.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_item2 := item_3.val
			if rt.is_true(rt.identical(var_item1.array_get(rt.new_string(key)), var_item2.array_get(rt.new_string(key)))) {
				var_merged.array_push(rt.call_function('array_merge', [var_item1.clone(), var_item2.clone()]))
				var_found = rt.new_bool(true)
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
			var_merged.array_push(var_item1.clone())
		}
	}
	mut iter_4 := var_arr2.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_item2 := item_4.val
		mut var_found := rt.new_bool(false)
		mut iter_5 := var_arr1.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_item1 := item_5.val
			if rt.is_true(rt.identical(var_item1.array_get(rt.new_string(key)), var_item2.array_get(rt.new_string(key)))) {
				var_found = rt.new_bool(true)
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
			var_merged.array_push(var_item2.clone())
		}
	}
	closure_1_fn := fn [var_key] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_null()
		}
	rt.call_function('usort', [var_merged.clone(), rt.new_closure(closure_1_fn)])
	return rt.call_function('array_values', [var_merged.clone()])
}

fn Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil.filter_null_values_recursive(mut var_arr Class_Automattic_WooCommerce_Internal_Utilities_array) rt.PhpVal {
	mut var_is_list := Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil.array_is_list(mut var_arr)
	mut var_filtered := rt.new_array()
	mut iter_6 := var_arr.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value := item_6.val
		mut var_key := item_6.key
		if rt.is_true(rt.new_bool(var_value.clone().is_null())) {
			continue
		}
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			var_filtered.array_set(var_key, Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil.filter_null_values_recursive(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](var_value)))
		} else {
			var_filtered.array_set(var_key, var_value.clone())
		}
	}
	return if rt.is_true(var_is_list) { rt.call_function('array_values', [var_filtered.clone()]) } else { var_filtered }
}

fn create_automattic_woocommerce_internal_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'array_is_list' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil.array_is_list(mut dispatch_arg_0))
		}
		'merge_by_key' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil.merge_by_key(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'filter_null_values_recursive' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil.filter_null_values_recursive(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

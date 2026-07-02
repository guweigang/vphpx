import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils.natural_language_join(var_array rt.PhpVal, enclose_items_with_quotes bool) rt.PhpVal {
	mut var_array_mutated := var_array
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(enclose_items_with_quotes))) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_string('"' + var_item.str() + '"')
		}
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_string('"' + var_item.str() + '"')
		}
		var_array_mutated = rt.call_function('array_map', [rt.new_closure(closure_1_fn),
			var_array_mutated.clone()])
	}
	mut var_last := rt.call_function('array_pop', [var_array_mutated.clone()])
	if rt.is_true(var_array_mutated) {
		return rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%1$s and %2$s'),
				rt.new_string('woocommerce')]),
			rt.call_function('implode', [rt.new_string(', '),
				var_array_mutated.clone()]),
			var_last.clone(),
		])
	}
	return var_last.clone()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils.string_contains_array(var_needle rt.PhpVal, var_haystack rt.PhpVal) bool {
	mut iter_1 := var_haystack.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
			var_needle.clone(),
			var_item.clone(),
		])))))
		{
			return true
		}
	}
	return false
}

fn create_automattic_woocommerce_storeapi_utilities_arrayutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'natural_language_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils.natural_language_join(dispatch_arg_0,
				dispatch_arg_1)
		}
		'string_contains_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils.string_contains_array(dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

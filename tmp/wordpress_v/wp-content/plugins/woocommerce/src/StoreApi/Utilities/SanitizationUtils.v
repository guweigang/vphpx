import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils) wp_kses_array(mut var_array Class_Automattic_WooCommerce_StoreApi_Utilities_array) rt.PhpVal {
	mut var_array_mutated := var_array
	{
		mut iter_1 := var_array_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if !rt.is_true(var_value) {
				var_array_mutated.array_set(var_key, var_value.dup())
				continue
			}
			if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
				var_array_mutated.array_set(var_key,
					this.wp_kses_array(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](var_value)))
			}
			if rt.is_true(rt.new_bool(var_value.dup().is_string())) {
				var_array_mutated.array_set(var_key, rt.call_function('wp_kses', [
					var_value.dup(),
					rt.new_array(),
				]))
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_array', []string{},
		var_array_mutated)
}

fn create_automattic_woocommerce_storeapi_utilities_sanitizationutils() &Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'wp_kses_array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.wp_kses_array(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_utilities_sanitizationutils_php() {
}

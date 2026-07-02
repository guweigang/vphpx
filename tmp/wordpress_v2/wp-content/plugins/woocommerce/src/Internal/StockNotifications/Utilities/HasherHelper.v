import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper.wp_fast_hash(key string) string {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_fast_hash')])) {
		return (rt.call_function('wp_fast_hash', [rt.new_string(key)])).str()
	}
	mut var_hashed := rt.call_function('sodium_crypto_generichash', [
		rt.new_string(key), rt.new_string('wp_fast_hash_6.8+'),
		rt.new_int(30)])
	return '$generic$' +(rt.call_function('sodium_bin2base64', [var_hashed.clone(), rt.get_constant('SODIUM_BASE64_VARIANT_URLSAFE_NO_PADDING')])).str()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper.wp_verify_fast_hash(key string, hash string) bool {
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_verify_fast_hash'),
	]))
	{
		return (rt.call_function('wp_verify_fast_hash', [rt.new_string(key),
			rt.new_string(hash)])).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
		rt.new_string(hash),
		rt.new_string('$generic$'),
	])))))
	{
		return false
	}
	return (rt.call_function('hash_equals', [rt.new_string(hash),
		Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper.wp_fast_hash(key)])).to_bool()
}

fn create_automattic_woocommerce_internal_stocknotifications_utilities_hasherhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'wp_fast_hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper.wp_fast_hash(dispatch_arg_0))
		}
		'wp_verify_fast_hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper.wp_verify_fast_hash(dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

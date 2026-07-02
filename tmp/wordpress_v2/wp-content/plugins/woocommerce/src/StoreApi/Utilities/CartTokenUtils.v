import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.get_cart_token(customer_id string) string {
	mut iife_temp_0 := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}
	mut iife_result_0 := iife_temp_0.create(rt.create_array([
		rt.ArrayItem{ key: 'user_id', val: customer_id },
		rt.ArrayItem{
			key: 'exp'
			val: Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.get_cart_token_expiration()
		},
		rt.ArrayItem{ key: 'iss', val: 'store-api' },
	]), Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.get_cart_token_secret())
	return iife_result_0.str()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.validate_cart_token(cart_token string) bool {
	mut iife_temp_1 := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}
	mut iife_result_1 := iife_temp_1.validate(rt.new_string(cart_token),
		Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.get_cart_token_secret())
	return iife_result_1.to_bool()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.get_cart_token_payload(cart_token string) rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}
	mut iife_result_2 := iife_temp_2.get_parts(rt.new_string(cart_token))
	mut var_parts := rt.get_property(iife_result_2, 'payload')
	return rt.create_array([
		rt.ArrayItem{
			key: 'user_id'
			val: if !(rt.get_property(var_parts, 'user_id')).is_null() {
				rt.get_property(var_parts, 'user_id')
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{
			key: 'exp'
			val: if !(rt.get_property(var_parts, 'exp')).is_null() {
				rt.get_property(var_parts, 'exp')
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{
			key: 'iss'
			val: if !(rt.get_property(var_parts, 'iss')).is_null() {
				rt.get_property(var_parts, 'iss')
			} else {
				rt.new_string('')
			}
		},
	])
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.get_cart_token_secret() string {
	return '@' + (rt.call_function('wp_salt', []rt.PhpVal{})).str()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.get_cart_token_expiration() i64 {
	return (rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(rt.call_function('apply_filters', [
		rt.new_string('wc_session_expiration'),
		rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(2)),
	]).to_i64()))).to_i64()
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_utilities_carttokenutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_jsonwebtoken(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_cart_token' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.get_cart_token(dispatch_arg_0))
		}
		'validate_cart_token' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.validate_cart_token(dispatch_arg_0))
		}
		'get_cart_token_payload' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.get_cart_token_payload(dispatch_arg_0)
		}
		'get_cart_token_secret' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.get_cart_token_secret())
		}
		'get_cart_token_expiration' {
			return rt.new_int(Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils.get_cart_token_expiration())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

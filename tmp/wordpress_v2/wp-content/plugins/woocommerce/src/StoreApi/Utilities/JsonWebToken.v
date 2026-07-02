import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_storeapi_utilities_jsonwebtoken() {
	rt.init_static_prop('Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken', 'type',
		rt.new_string('JWT'))
	rt.init_static_prop('Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken', 'algorithm',
		rt.new_string('HS256'))
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.create(mut var_payload Class_Automattic_WooCommerce_StoreApi_Utilities_array, secret string) string {
	mut var_payload_mutated := var_payload
	mut var_header :=
		Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.to_base_64_url((Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.generate_header()).str())
	var_payload_mutated =
		Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.to_base_64_url((Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.generate_payload(mut var_payload_mutated)).str())
	mut var_signature := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.to_base_64_url((Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.generate_signature(
		var_header.str() + '.' + var_payload_mutated.str(), secret)).str())
	return var_header.str() + '.' + var_payload_mutated.str() + '.' + var_signature.str()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.validate(token string, secret string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.shallow_validate(token))))) {
		return false
	}
	mut var_parts := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.get_parts(token)
	mut var_encoded_regenerated_signature := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.to_base_64_url((Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.generate_signature(
		(rt.get_property(var_parts, 'header_encoded')).str() + '.' +
		(rt.get_property(var_parts, 'payload_encoded')).str(), secret)).str())
	return (rt.call_function('hash_equals', [var_encoded_regenerated_signature.clone(),
		rt.get_property(var_parts, 'signature_encoded')])).to_bool()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.shallow_validate(token string) bool {
	if !(var_token.len > 0 && var_token != '0') {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('preg_match', [
		rt.new_string('/^[a-zA-Z\\d\\-_=]+\\.[a-zA-Z\\d\\-_=]+\\.[a-zA-Z\\d\\-_=]+$/'),
		rt.new_string(token),
	]), rt.new_int(1)))))
	{
		return false
	}
	mut var_parts := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.get_parts(token)
	if !(rt.get_property(var_parts, 'header').is_object())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [rt.get_property(var_parts, 'header'), rt.new_string('typ')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [rt.get_property(var_parts, 'header'), rt.new_string('alg')])))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken', 'type'), rt.get_property(rt.get_property(var_parts, 'header'), 'typ')))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken', 'algorithm'), rt.get_property(rt.get_property(var_parts, 'header'), 'alg'))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [rt.get_property(var_parts, 'payload'), rt.new_string('exp')])))))
		|| rt.is_true(rt.greater(rt.call_function('time', []rt.PhpVal{}), rt.new_int((rt.get_property(rt.get_property(var_parts, 'payload'), 'exp')).to_i64()))) {
		return false
	}
	return true
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.get_parts(token string) rt.PhpVal {
	mut var_parts := rt.call_function('explode', [rt.new_string('.'),
		rt.new_string(token)])
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'header', val: rt.call_function('json_decode', [
			Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.from_base_64_url((var_parts.array_get(rt.new_int(0))).str()),
		]) },
		rt.ArrayItem{ key: 'header_encoded', val: var_parts.array_get(rt.new_int(0)) },
		rt.ArrayItem{ key: 'payload', val: rt.call_function('json_decode', [
			Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.from_base_64_url((var_parts.array_get(rt.new_int(1))).str()),
		]) },
		rt.ArrayItem{ key: 'payload_encoded', val: var_parts.array_get(rt.new_int(1)) },
		rt.ArrayItem{
			key: 'signature'
			val: Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.from_base_64_url((var_parts.array_get(rt.new_int(2))).str())
		},
		rt.ArrayItem{ key: 'signature_encoded', val: var_parts.array_get(rt.new_int(2)) },
	]))
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.generate_header() rt.PhpVal {
	return rt.call_function('wp_json_encode', [
		rt.create_array([
			rt.ArrayItem{ key: 'alg', val: rt.get_static_prop('Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken',
				'algorithm') },
			rt.ArrayItem{ key: 'typ', val: rt.get_static_prop('Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken',
				'type') },
		]),
	])
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.generate_signature(string string, secret string) rt.PhpVal {
	return rt.call_function('hash_hmac', [rt.new_string('sha256'),
		rt.new_string(string), rt.new_string(secret), rt.new_bool(true)])
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.generate_payload(mut var_payload Class_Automattic_WooCommerce_StoreApi_Utilities_array) rt.PhpVal {
	mut var_payload_mutated := var_payload
	return rt.call_function('wp_json_encode', [
		rt.call_function('array_merge', [var_payload_mutated,
			rt.create_array([
				rt.ArrayItem{ key: 'iat', val: rt.call_function('time', []rt.PhpVal{}) },
			])]),
	])
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.to_base_64_url(string string) rt.PhpVal {
	return rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '+' },
			rt.ArrayItem{ key: none, val: '/' }, rt.ArrayItem{ key: none, val: '=' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '-' },
			rt.ArrayItem{ key: none, val: '_' }, rt.ArrayItem{ key: none, val: '' }]),
		rt.call_function('base64_encode', [rt.new_string(string)]),
	])
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.from_base_64_url(string string) rt.PhpVal {
	if rt.is_true(rt.new_bool(string.len % 4 != 0)) {
		return Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.from_base_64_url(
			string + '=')
	}
	return rt.call_function('base64_decode', [
		rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: '-' },
				rt.ArrayItem{ key: none, val: '_' }]),
			rt.create_array([rt.ArrayItem{ key: none, val: '+' },
				rt.ArrayItem{ key: none, val: '/' }]),
			rt.new_string(string),
		]),
	])
}

fn create_automattic_woocommerce_storeapi_utilities_jsonwebtoken(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.create(mut dispatch_arg_0,
				dispatch_arg_1))
		}
		'validate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.validate(dispatch_arg_0,
				dispatch_arg_1))
		}
		'shallow_validate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.shallow_validate(dispatch_arg_0))
		}
		'get_parts' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.get_parts(dispatch_arg_0)
		}
		'generate_header' {
			return Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.generate_header()
		}
		'generate_signature' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.generate_signature(dispatch_arg_0,
				dispatch_arg_1)
		}
		'generate_payload' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.generate_payload(mut dispatch_arg_0)
		}
		'to_base_64_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.to_base_64_url(dispatch_arg_0)
		}
		'from_base_64_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken.from_base_64_url(dispatch_arg_0)
		}
		else {
			return none
		}
	}
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

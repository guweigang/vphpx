import rt

pub fn Class_Automattic_WooCommerce_Internal_Api_QueryCache.cache_group() string {
	return 'wc-graphql'
}
pub fn Class_Automattic_WooCommerce_Internal_Api_QueryCache.cache_key_prefix() string {
	return 'graphql_ast_v15_'
}
pub fn Class_Automattic_WooCommerce_Internal_Api_QueryCache.cache_ttl() rt.PhpVal {
	return rt.get_constant('DAY_IN_SECONDS')
}
struct Class_Automattic_WooCommerce_Internal_Api_QueryCache {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Api_QueryCache.get_cache_ttl() i64 {
	return (Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Internal_Api_QueryCache.cache_ttl()).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_QueryCache) resolve(mut var_query Class_Automattic_WooCommerce_Internal_Api_?string, mut var_extensions Class_Automattic_WooCommerce_Internal_Api_array) rt.PhpVal {
	mut var_apq := if !(var_extensions.array_get(rt.new_string('persistedQuery'))).is_null() { var_extensions.array_get(rt.new_string('persistedQuery')) } else { rt.new_null() }
	if var_apq.clone().is_array() && rt.is_true(rt.identical(rt.new_int(1), if !(var_apq.array_get(rt.new_string('version'))).is_null() { var_apq.array_get(rt.new_string('version')) } else { rt.new_null() })) && !(!rt.is_true(var_apq.array_get(rt.new_string('sha256Hash')))) {
		return this.resolve_apq(mut var_query, (var_apq.array_get(rt.new_string('sha256Hash'))).str())
	}
	if !rt.is_true(var_query) {
		return this.error_response('No query provided.', 'BAD_REQUEST')
	}
	mut var_hash := rt.call_function('hash', [rt.new_string('sha256'), var_query])
	mut var_doc := rt.new_bool(this.get_cached_document((var_hash).str()))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_doc)))) {
		return var_doc.clone()
	}
	return this.parse_and_cache(var_query, (var_hash).str())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_QueryCache) resolve_apq(mut var_query Class_Automattic_WooCommerce_Internal_Api_?string, apq_hash string) rt.PhpVal {
	if !(!rt.is_true(var_query)) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('hash', [rt.new_string('sha256'), var_query]), rt.new_string(apq_hash))))) {
			return this.error_response('provided sha does not match query', 'PERSISTED_QUERY_HASH_MISMATCH')
		}
		mut var_doc := rt.new_bool(this.get_cached_document(apq_hash))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_doc)))) {
			return var_doc.clone()
		}
		return this.parse_and_cache(var_query, apq_hash)
	}
	var_doc = rt.new_bool(this.get_cached_document(apq_hash))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_doc)))) {
		return var_doc.clone()
	}
	return this.error_response('PersistedQueryNotFound', 'PERSISTED_QUERY_NOT_FOUND')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_QueryCache) get_cached_document(hash string) bool {
	mut hash_mutated := hash
	mut var_cached := rt.call_function('wp_cache_get', [rt.new_string(this.build_cache_key(hash_mutated)), Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Internal_Api_QueryCache.cache_group()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_cached)) || !(var_cached.clone().is_array()) {
		return false
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
	mut iife_result_0 := iife_temp_0.fromarray(var_cached.clone())
	return (iife_result_0).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_QueryCache) parse_and_cache(query string, hash string) rt.PhpVal {
	mut hash_mutated := hash
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{}
	mut iife_result_1 := iife_temp_1.parse(rt.new_string(query), rt.create_array([rt.ArrayItem{ key: 'noLocation', val: true }]))
	mut var_document := iife_result_1
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError') {
		mut var_e := var_e_1.clone()
		return this.error_response('GraphQL syntax error: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), 'GRAPHQL_PARSE_ERROR')
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	rt.call_function('wp_cache_set', [rt.new_string(this.build_cache_key(hash_mutated)), rt.call_method(var_document, 'toArray', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Internal_Api_QueryCache.cache_group(), Class_Automattic_WooCommerce_Internal_Api_QueryCache.get_cache_ttl()])
	return var_document.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_QueryCache) build_cache_key(hash string) string {
	mut hash_mutated := hash
	return (Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Internal_Api_QueryCache.cache_key_prefix()).str() + hash_mutated
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_QueryCache) error_response(message string, code string) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'errors', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'message', val: message }, rt.ArrayItem{ key: 'extensions', val: rt.create_array([rt.ArrayItem{ key: 'code', val: code }]) }]) }]) }])
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_api_querycache(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_QueryCache {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_QueryCache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_ast(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_parser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_QueryCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_cache_ttl' {
			return rt.new_int(Class_Automattic_WooCommerce_Internal_Api_QueryCache.get_cache_ttl())
		}
		'resolve' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.resolve(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'resolve_apq' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.resolve_apq(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_cached_document' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.get_cached_document(dispatch_arg_0))
		}
		'parse_and_cache' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.parse_and_cache(dispatch_arg_0, dispatch_arg_1)
		}
		'build_cache_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.build_cache_key(dispatch_arg_0))
		}
		'error_response' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.error_response(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_QueryCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_QueryCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

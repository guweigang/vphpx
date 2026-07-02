import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute.schema_type() string {
	return 'term'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) get_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params.array_set('context', this.get_context_param())
	var_params.array_get_mut('context').array_set('default', 'view')
	var_params.array_set('page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Current page of the collection.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 1 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'minimum', val: 1 },
	]))
	var_params.array_set('per_page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Maximum number of items to be returned in result set. Defaults to no limit if left blank.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'minimum', val: 0 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('search', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit results to those matching a string.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('exclude', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Ensure result set excludes specific IDs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	]))
	var_params.array_set('include', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to specific ids.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	]))
	var_params.array_set('order', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort ascending or descending.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'asc' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('orderby', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort by term property.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'name' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: 'slug' },
			rt.ArrayItem{ key: none, val: 'count' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('hide_empty', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('If true, empty terms will not be returned.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
		rt.ArrayItem{ key: 'default', val: true },
	]))
	var_params.array_set('parent', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit results to terms with a specific parent (hierarchical taxonomies only).'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) get_terms_response(var_taxonomy rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_page := rt.new_int((var_request.array_get(rt.new_string('page'))).to_i64())
	mut var_per_page := rt.new_int(if rt.is_true(var_request.array_get(rt.new_string('per_page'))) {
		rt.new_int((var_request.array_get(rt.new_string('per_page'))).to_i64())
	} else {
		0
	})
	mut var_prepared_args := rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
		rt.ArrayItem{ key: 'exclude', val: var_request.array_get(rt.new_string('exclude')) },
		rt.ArrayItem{ key: 'include', val: var_request.array_get(rt.new_string('include')) },
		rt.ArrayItem{ key: 'order', val: var_request.array_get(rt.new_string('order')) },
		rt.ArrayItem{ key: 'orderby', val: var_request.array_get(rt.new_string('orderby')) },
		rt.ArrayItem{
			key: 'hide_empty'
			val: (var_request.array_get(rt.new_string('hide_empty'))).to_bool()
		},
		rt.ArrayItem{ key: 'number', val: var_per_page },
		rt.ArrayItem{
			key: 'offset'
			val: if rt.is_true(rt.greater(var_per_page, rt.new_int(0))) {
				rt.mul(rt.sub(var_page, rt.new_int(1)), var_per_page)
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{ key: 'search', val: var_request.array_get(rt.new_string('search')) },
	])
	if var_request.array_isset(rt.new_string('parent'))
		&& rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.clone()])) {
		var_prepared_args.array_set('parent',
			rt.new_int((var_request.array_get(rt.new_string('parent'))).to_i64()))
	}
	mut var_term_query := create_wp_term_query()
	mut var_objects := var_term_query.query(var_prepared_args.clone())
	mut var_return := rt.new_array()
	mut iter_1 := var_objects.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_object := item_1.val
		mut var_data := this.prepare_item_for_response(var_object.clone(), var_request.clone())
		var_return.array_push(this.prepare_response_for_collection(var_data.clone()))
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		var_return.clone()])
	if rt.is_true(rt.greater(var_per_page, rt.new_int(0)))
		&& rt.is_true(rt.identical(rt.new_int(var_objects.clone().array_count()), var_per_page))
		|| rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_term_count := rt.new_int(this.get_term_count(var_taxonomy.clone(),
			var_prepared_args.clone()))
		var_response = rt.call_method(create_automattic_woocommerce_storeapi_utilities_pagination(),
			'add_headers', [var_response.clone(), var_request.clone(),
			var_term_count.clone(), rt.call_function('ceil', [
				rt.div(var_term_count, var_per_page),
			])])
	}
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) get_term_count(var_taxonomy rt.PhpVal, var_args rt.PhpVal) i64 {
	mut var_count_args := var_args
	var_count_args.array_unset(rt.new_string('number'))
	var_count_args.array_unset(rt.new_string('offset'))
	return rt.new_int((rt.call_function('wp_count_terms', [var_taxonomy.clone(),
		var_count_args.clone()])).to_i64())
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
}

struct Class_WP_Term_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstracttermsroute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractroute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_term_query(_args ...rt.PhpVal) &Class_WP_Term_Query {
	mut obj := &Class_WP_Term_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_pagination(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_terms_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_terms_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_term_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.get_term_count(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Term_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Term_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Term_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

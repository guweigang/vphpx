import rt

struct Class_WC_REST_Product_Custom_Fields_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
	rest_base rt.PhpVal = rt.new_string('products/custom-fields')
	post_type rt.PhpVal = rt.new_string('product')
}

fn (mut this Class_WC_REST_Product_Custom_Fields_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/names'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Custom_Fields_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_names' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Custom_Fields_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Custom_Fields_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Product_Custom_Fields_Controller) get_item_names(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_search :=
		rt.new_string(var_request.array_get(rt.new_string('search')).to_string().trim_space())
	mut var_order := rt.new_string((if rt.is_true(rt.identical(rt.new_string(var_request.array_get(rt.new_string('order')).to_string().to_upper()),
		rt.new_string('DESC')))
	{
		'DESC'
	} else {
		'ASC'
	}).str())
	mut var_page := rt.new_int((var_request.array_get(rt.new_string('page'))).to_i64())
	mut var_limit := rt.new_int((var_request.array_get(rt.new_string('per_page'))).to_i64())
	mut var_offset := rt.mul(rt.sub(var_page, rt.new_int(1)), var_limit)
	mut var_base_query := rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT post_metas.meta_key\n\t\t\tFROM '), rt.get_property(var_wpdb,
			'postmeta')), rt.new_string(' post_metas LEFT JOIN ')), rt.get_property(var_wpdb,
			'posts')),
			rt.new_string(' posts ON post_metas.post_id = posts.id\n\t\t\tWHERE posts.post_type = %s AND post_metas.meta_key NOT LIKE %s AND post_metas.meta_key LIKE %s')),
		this.post_type,
		rt.new_string((rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_')])).str() + '%'),
		rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [var_search.clone()])).str() + '%'),
	])
	mut var_query := var_base_query.clone()
	var_query = rt.concat(var_query, rt.call_method(var_wpdb, 'prepare', [
		rt.new_string(' ORDER BY post_metas.meta_key ${var_order.to_string()} LIMIT %d, %d'),
		var_offset.clone(),
		var_limit.clone(),
	]))
	mut var_total_query :=
		rt.new_string('SELECT COUNT(1) FROM (${var_base_query.to_string()}) AS total')
	mut var_query_result := rt.call_method(var_wpdb, 'get_results', [
		var_query.clone()])
	mut var_total_items := rt.call_method(var_wpdb, 'get_var', [
		var_total_query.clone()])
	mut var_custom_field_names := []rt.PhpVal{}
	mut iter_1 := var_query_result.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_custom_field_name := item_1.val
		var_custom_field_names << rt.get_property(var_custom_field_name, 'meta_key')
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		rt.create_array_from_list(var_custom_field_names),
	])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_total_items.to_i64())])
	mut var_max_pages := rt.call_function('ceil', [rt.div(var_total_items, var_limit)])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(var_max_pages.to_i64())])
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}),
		rt.call_function('rest_url', [
			rt.new_string('/' + (this.namespace).str() + '/' + (this.rest_base).str() + '/names'),
		]),
	])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.clone()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_prev_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'),
			var_prev_link.clone()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_next_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'),
			var_next_link.clone()])
	}
	return var_response.clone()
}

fn (mut this Class_WC_REST_Product_Custom_Fields_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
		this.post_type,
		rt.new_string('read'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Custom_Fields_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Controller.get_collection_params()
	var_params.array_set('order', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order sort items ascending or descending.'),
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
	return var_params.clone()
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_product_custom_fields_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Custom_Fields_Controller {
	mut obj := &Class_WC_REST_Product_Custom_Fields_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
		rest_base:     rt.new_string('products/custom-fields')
		post_type:     rt.new_string('product')
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Product_Custom_Fields_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_names(dispatch_arg_0)
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Product_Custom_Fields_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Product_Custom_Fields_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		'post_type' {
			this.post_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

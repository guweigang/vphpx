import rt

struct Class_Automattic_WooCommerce_Admin_API_ProductVariations {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-analytics')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductVariations) register_routes() {
	this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller.register_routes()
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/variations'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductVariations', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductVariations', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductVariations', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductVariations) get_collection_params() rt.PhpVal {
	mut var_params :=
		this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller.get_collection_params()
	var_params.array_set('search', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Search by similar product name, sku, or attribute value.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_ProductVariations.add_wp_query_filter(var_where rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_search := rt.call_method(var_wp_query, 'get', [rt.new_string('search')])
	if rt.is_true(var_search) {
		mut var_like := rt.new_string('%' +
			(rt.call_method(var_wpdb, 'esc_like', [var_search.clone()])).str() + '%')
		mut var_conditions := rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_title LIKE %s')),
				var_like.clone(),
			]) },
			rt.ArrayItem{ key: none, val: rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('attr_search_meta.meta_value LIKE %s'),
				var_like.clone(),
			]) },
		])
		if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})) {
			var_conditions.array_push(rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('wc_product_meta_lookup.sku LIKE %s'),
				var_like.clone(),
			]))
		}
		var_where = rt.concat(var_where, rt.new_string(
			' AND (' + (rt.call_function('implode', [rt.new_string(' OR '), var_conditions.clone()])).str() +
			')'))
	}
	return var_where.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_ProductVariations.add_wp_query_join(var_join rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_search := rt.call_method(var_wp_query, 'get', [rt.new_string('search')])
	if rt.is_true(var_search) {
		var_join = rt.concat(var_join, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb,
			'postmeta')), rt.new_string(' AS attr_search_meta\n\t\t\t\t\t\tON ')), rt.get_property(var_wpdb,
			'posts')),
			rt.new_string(".ID = attr_search_meta.post_id\n\t\t\t\t\t\tAND attr_search_meta.meta_key LIKE 'attribute_%' ")))
	}
	if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_join.clone(), rt.new_string('wc_product_meta_lookup')]))))) {
		var_join = rt.concat(var_join, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')), rt.new_string(' wc_product_meta_lookup\n\t\t\t\t\t\tON ')), rt.get_property(var_wpdb,
			'posts')), rt.new_string('.ID = wc_product_meta_lookup.product_id ')))
	}
	return var_join.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductVariations) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args :=
		this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller.prepare_objects_query(var_request.clone())
	if !(!rt.is_true(var_request.array_get(rt.new_string('search')))) {
		var_args.array_set('search', var_request.array_get(rt.new_string('search')))
		var_args.array_unset(rt.new_string('s'))
	}
	if rt.is_true(rt.identical(rt.concat(rt.concat(rt.new_string('/'), this.namespace),
		rt.new_string('/variations')), rt.call_method(var_request, 'get_route', []rt.PhpVal{})))
	{
		var_args.array_unset(rt.new_string('post_parent'))
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductVariations) get_items(var_request rt.PhpVal) rt.PhpVal {
	rt.call_function('add_filter', [rt.new_string('posts_where'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_wp_query_filter' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_join'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_wp_query_join' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_groupby'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Products' },
			rt.ArrayItem{ key: none, val: 'add_wp_query_group_by' },
		]),
		rt.new_int(10), rt.new_int(2)])
	mut var_response :=
		this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller.get_items(var_request.clone())
	rt.call_function('remove_filter', [rt.new_string('posts_where'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_wp_query_filter' }]),
		rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_join'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_wp_query_join' }]),
		rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_groupby'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Products' },
			rt.ArrayItem{ key: none, val: 'add_wp_query_group_by' },
		]),
		rt.new_int(10)])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductVariations) get_item_schema() rt.PhpVal {
	mut var_schema :=
		this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller.get_item_schema()
	var_schema.array_get_mut('properties').array_set('name', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Product parent name.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('type', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Product type.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{
			key: 'default'
			val: Class_Automattic_WooCommerce_Enums_ProductType.variation()
		},
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.variation() },
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('parent_id', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Product parent ID.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductVariations) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_context := if !rt.is_true(var_request.array_get(rt.new_string('context'))) {
		rt.new_string('view')
	} else {
		var_request.array_get(rt.new_string('context'))
	}
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller.prepare_object_for_response(var_object.clone(),
		var_request.clone())
	mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	var_data.array_set('name', rt.call_method(var_object, 'get_name', [
		var_context.clone()]))
	var_data.array_set('type', rt.call_method(var_object, 'get_type', []rt.PhpVal{}))
	var_data.array_set('parent_id', rt.call_method(var_object, 'get_parent_id', [
		var_context.clone(),
	]))
	rt.call_method(var_response, 'set_data', [var_data.clone()])
	return var_response.clone()
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_productvariations(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_ProductVariations {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_ProductVariations{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_product_variations_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductVariations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'add_wp_query_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_ProductVariations.add_wp_query_filter(dispatch_arg_0,
				dispatch_arg_1)
		}
		'add_wp_query_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_ProductVariations.add_wp_query_join(dispatch_arg_0,
				dispatch_arg_1)
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'prepare_object_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_object_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_ProductVariations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductVariations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Variations_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

import rt

struct Class_Automattic_WooCommerce_Admin_API_ProductAttributes {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-analytics')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributes) register_routes() {
	this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller.register_routes()
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('products/attributes/(?P<slug>[a-z0-9_\\-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'slug', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Slug identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductAttributes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_by_slug' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductAttributes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductAttributes', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributes) get_collection_params() rt.PhpVal {
	mut var_params :=
		this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller.get_collection_params()
	var_params.array_set('search', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Search by similar attribute name.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributes) get_item_schema() rt.PhpVal {
	mut var_schema :=
		this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller.get_item_schema()
	var_schema.array_get_mut('properties').array_get_mut('id').array_set('type', rt.create_array([
		rt.ArrayItem{ key: none, val: 'integer' },
		rt.ArrayItem{ key: none, val: 'string' },
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributes) get_item_by_slug(var_request rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_request.array_get(rt.new_string('slug'))) {
		return rt.new_array()
	}
	mut var_attributes :=
		this.get_custom_attribute_by_slug(var_request.array_get(rt.new_string('slug')))
	if rt.is_true(rt.call_function('is_wp_error', [var_attributes.clone()])) {
		return var_attributes.clone()
	}
	mut var_response_items :=
		this.format_custom_attribute_items_for_response(var_attributes.clone())
	return rt.call_function('reset', [var_response_items.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributes) format_custom_attribute_items_for_response(var_custom_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_attributes_mutated := var_custom_attributes
	mut var_response := rt.new_array()
	mut iter_1 := var_custom_attributes_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_attribute_value := item_1.val
		mut var_attribute_key := item_1.key
		mut var_data := rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_attribute_key },
			rt.ArrayItem{ key: 'name', val: var_attribute_value.array_get(rt.new_string('name')) },
			rt.ArrayItem{ key: 'slug', val: var_attribute_key },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'order_by', val: 'menu_order' },
			rt.ArrayItem{ key: 'has_archives', val: false },
		])
		mut var_item_response := rt.call_function('rest_ensure_response', [
			var_data.clone()])
		rt.call_method(var_item_response, 'add_links', [
			this.prepare_links(rt.new_object('stdClass', []string{}, rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'attribute_id', val: var_attribute_key },
			])))),
		])
		var_item_response = this.prepare_response_for_collection(var_item_response.clone())
		var_response.array_push(var_item_response.clone())
	}
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributes) get_items(var_request rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_request.array_get(rt.new_string('search'))) {
		return this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller.get_items(var_request.clone())
	}
	mut var_search_string := var_request.array_get(rt.new_string('search'))
	mut var_custom_attributes := this.get_custom_attributes(rt.create_array([
		rt.ArrayItem{ key: 'name', val: var_search_string },
	]))
	mut var_matching_attributes :=
		this.format_custom_attribute_items_for_response(var_custom_attributes.clone())
	mut var_taxonomy_attributes := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	mut iter_2 := var_taxonomy_attributes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_attribute_obj := item_2.val
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
			rt.get_property(var_attribute_obj, 'attribute_label'),
			var_search_string.clone(),
		])))
		{
			continue
		}
		mut var_attribute := this.prepare_item_for_response(var_attribute_obj.clone(),
			var_request.clone())
		var_matching_attributes.array_push(this.prepare_response_for_collection(var_attribute.clone()))
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		var_matching_attributes.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_matching_attributes.clone().array_count())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(1)])
	return var_response.clone()
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_productattributes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_ProductAttributes {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_ProductAttributes{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_product_attributes_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_item_by_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_by_slug(dispatch_arg_0)
		}
		'format_custom_attribute_items_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_custom_attribute_items_for_response(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_ProductAttributes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attributes_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

import rt

struct Class_Automattic_WooCommerce_Admin_API_ProductAttributeTerms {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-analytics')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributeTerms) register_routes()  {
	this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attribute_Terms_Controller.register_routes()
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('products/attributes/(?P<slug>[a-z0-9_\\-]+)/terms'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Slug identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductAttributeTerms', ['Automattic_WooCommerce_Admin_API_WC_REST_Product_Attribute_Terms_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_by_slug' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductAttributeTerms', ['Automattic_WooCommerce_Admin_API_WC_REST_Product_Attribute_Terms_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_custom_attribute_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductAttributeTerms', ['Automattic_WooCommerce_Admin_API_WC_REST_Product_Attribute_Terms_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributeTerms) get_custom_attribute_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('attributes'), rt.new_string('read')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributeTerms) get_item_schema() rt.PhpVal {
	mut var_schema := this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attribute_Terms_Controller.get_item_schema()
	var_schema.array_get_mut('properties').array_get_mut('id').array_set('type', rt.create_array([rt.ArrayItem{ key: none, val: 'integer' }, rt.ArrayItem{ key: none, val: 'string' }]))
	return var_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributeTerms) get_custom_attribute_values(var_slug rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_slug) {
		return rt.new_array()
	}
	mut var_attribute_values := rt.new_array()
	mut var_attribute := this.get_custom_attribute_by_slug(var_slug.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_attribute.dup()])) {
		return var_attribute.dup()
	}
	mut var_query_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT meta_value, COUNT(meta_id) AS product_count\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\tWHERE meta_key = %s\n\t\t\t\tAND meta_value != \'\'\n\t\t\t\tGROUP BY meta_value')), 'attribute_' + (rt.call_function('esc_sql', [var_slug.dup()])).str()]), rt.get_constant('OBJECT_K')])
	mut var_defined_values := rt.call_function('wc_get_text_attributes', [var_attribute.array_get(var_slug).array_get('value')])
	{
		mut iter_1 := var_defined_values.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_defined_value := item_1.val
			if rt.is_true(rt.new_bool(var_query_results.dup().array_isset(var_defined_value.dup()))) {
				continue
			}
			var_query_results.array_set(var_defined_value, // unsupported expression: Expr_Cast_Object)
		}
	}
	{
		mut iter_1 := var_query_results.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			mut var_term_value := item_1.key
			mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: var_term_value }, rt.ArrayItem{ key: 'name', val: var_term_value }, rt.ArrayItem{ key: 'slug', val: var_term_value }, rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'menu_order', val: 0 }, rt.ArrayItem{ key: 'count', val: // unsupported expression: Expr_Cast_Int }])
			mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
			rt.call_method(var_response, 'add_links', [rt.create_array([rt.ArrayItem{ key: 'collection', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [(this.namespace).str() + '/products/attributes/' + (var_slug).str() + '/terms']) }]) }])])
			var_response = this.prepare_response_for_collection(var_response.dup())
			var_attribute_values.array_set(var_term_value, var_response.dup())
		}
	}
	return rt.call_function('array_values', [var_attribute_values.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributeTerms) get_item_by_slug(var_request rt.PhpVal) rt.PhpVal {
	return this.get_custom_attribute_values(var_request.array_get('slug'))
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attribute_Terms_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_productattributeterms() &Class_Automattic_WooCommerce_Admin_API_ProductAttributeTerms {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_ProductAttributeTerms{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_product_attribute_terms_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attribute_Terms_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attribute_Terms_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error() &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributeTerms) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_custom_attribute_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_custom_attribute_permissions_check(dispatch_arg_0))
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_custom_attribute_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_custom_attribute_values(dispatch_arg_0)
		}
		'get_item_by_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_by_slug(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_ProductAttributeTerms) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductAttributeTerms) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attribute_Terms_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attribute_Terms_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Attribute_Terms_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_productattributeterms_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

import rt

struct Class_WC_REST_Product_Categories_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
}

fn (mut this Class_WC_REST_Product_Categories_V2_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_display_type := rt.call_function('get_term_meta', [rt.get_property(var_item, 'term_id'), rt.new_string('display_type'), rt.new_bool(true)])
	mut var_menu_order := rt.call_function('get_term_meta', [rt.get_property(var_item, 'term_id'), rt.new_string('order'), rt.new_bool(true)])
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_item, 'name') }, rt.ArrayItem{ key: 'slug', val: rt.get_property(var_item, 'slug') }, rt.ArrayItem{ key: 'parent', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_item, 'description') }, rt.ArrayItem{ key: 'display', val: if rt.is_true(var_display_type) { var_display_type } else { rt.new_string('default') } }, rt.ArrayItem{ key: 'image', val: rt.new_null() }, rt.ArrayItem{ key: 'menu_order', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'count', val: // unsupported expression: Expr_Cast_Int }])
	mut var_image_id := rt.call_function('get_term_meta', [rt.get_property(var_item, 'term_id'), rt.new_string('thumbnail_id'), rt.new_bool(true)])
	if rt.is_true(var_image_id) {
		mut var_attachment := rt.call_function('get_post', [var_image_id.dup()])
		var_data.array_set('image', rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment, 'post_date')]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment, 'post_date_gmt')]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment, 'post_modified')]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment, 'post_modified_gmt')]) }, rt.ArrayItem{ key: 'src', val: rt.call_function('wp_get_attachment_url', [var_image_id.dup()]) }, rt.ArrayItem{ key: 'title', val: rt.call_function('get_the_title', [var_attachment.dup()]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('get_post_meta', [var_image_id.dup(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)]) }]))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_item.dup(), var_request.dup())])
	return rt.call_function('apply_filters', [rt.concat(rt.new_string('woocommerce_rest_prepare_'), rt.get_property(rt.new_object('WC_REST_Product_Categories_V2_Controller', ['WC_REST_Product_Categories_V1_Controller'], &this), 'taxonomy')), var_response.dup(), var_item.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Product_Categories_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.get_property(rt.new_object('WC_REST_Product_Categories_V2_Controller', ['WC_REST_Product_Categories_V1_Controller'], &this), 'taxonomy'), 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'description': rt.call_function('__', [rt.new_string('Category name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': rt.new_string('sanitize_text_field') } }, 'slug': { 'description': rt.call_function('__', [rt.new_string('An alphanumeric identifier for the resource unique to its type.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': map[string]rt.PhpVal{} } }, 'parent': { 'description': rt.call_function('__', [rt.new_string('The ID for the parent of the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'description': { 'description': rt.call_function('__', [rt.new_string('HTML description of the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': rt.new_string('wp_filter_post_kses') } }, 'display': { 'description': rt.call_function('__', [rt.new_string('Category archive display type.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'default': rt.new_string('default'), 'enum': map[string]rt.PhpVal{}, 'context': map[string]rt.PhpVal{} }, 'image': { 'description': rt.call_function('__', [rt.new_string('Image data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Image ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'date_created': { 'description': rt.call_function('__', [rt.new_string('The date the image was created, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the image was created, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified': { 'description': rt.call_function('__', [rt.new_string('The date the image was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the image was last modified, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'src': { 'description': rt.call_function('__', [rt.new_string('Image URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{} }, 'title': { 'description': rt.call_function('__', [rt.new_string('Image name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'alt': { 'description': rt.call_function('__', [rt.new_string('Image alternative text.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} } } }, 'menu_order': { 'description': rt.call_function('__', [rt.new_string('Menu order, used to custom sort the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'count': { 'description': rt.call_function('__', [rt.new_string('Number of published products for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

struct Class_WC_REST_Product_Categories_V1_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_product_categories_v2_controller() &Class_WC_REST_Product_Categories_V2_Controller {
	mut obj := &Class_WC_REST_Product_Categories_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
	}
	return obj
}

fn create_wc_rest_product_categories_v1_controller() &Class_WC_REST_Product_Categories_V1_Controller {
	mut obj := &Class_WC_REST_Product_Categories_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Product_Categories_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Product_Categories_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Product_Categories_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Product_Categories_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Product_Categories_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Product_Categories_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_product_categories_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

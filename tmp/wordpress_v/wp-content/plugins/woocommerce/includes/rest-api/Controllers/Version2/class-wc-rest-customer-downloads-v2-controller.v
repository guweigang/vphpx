import rt

struct Class_WC_REST_Customer_Downloads_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
}

fn (mut this Class_WC_REST_Customer_Downloads_V2_Controller) prepare_item_for_response(var_download rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'download_id', val: rt.get_property(var_download, 'download_id') }, rt.ArrayItem{ key: 'download_url', val: rt.get_property(var_download, 'download_url') }, rt.ArrayItem{ key: 'product_id', val: rt.get_property(var_download, 'product_id') }, rt.ArrayItem{ key: 'product_name', val: rt.get_property(var_download, 'product_name') }, rt.ArrayItem{ key: 'download_name', val: rt.get_property(var_download, 'download_name') }, rt.ArrayItem{ key: 'order_id', val: rt.get_property(var_download, 'order_id') }, rt.ArrayItem{ key: 'order_key', val: rt.get_property(var_download, 'order_key') }, rt.ArrayItem{ key: 'downloads_remaining', val: if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_download, 'downloads_remaining'))) { rt.new_string('unlimited') } else { rt.get_property(var_download, 'downloads_remaining') } }, rt.ArrayItem{ key: 'access_expires', val: if rt.is_true(rt.get_property(var_download, 'access_expires')) { rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_download, 'access_expires')]) } else { rt.new_string('never') } }, rt.ArrayItem{ key: 'access_expires_gmt', val: if rt.is_true(rt.get_property(var_download, 'access_expires')) { rt.call_function('wc_rest_prepare_date_response', [rt.call_function('get_gmt_from_date', [rt.get_property(var_download, 'access_expires')])]) } else { rt.new_string('never') } }, rt.ArrayItem{ key: 'file', val: rt.get_property(var_download, 'file') }])
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_download.dup(), var_request.dup())])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_customer_download'), var_response.dup(), var_download.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Customer_Downloads_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('customer_download'), 'type': rt.new_string('object'), 'properties': { 'download_id': { 'description': rt.call_function('__', [rt.new_string('Download ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'download_url': { 'description': rt.call_function('__', [rt.new_string('Download file URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'product_id': { 'description': rt.call_function('__', [rt.new_string('Downloadable product ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'product_name': { 'description': rt.call_function('__', [rt.new_string('Product name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'download_name': { 'description': rt.call_function('__', [rt.new_string('Downloadable file name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'order_id': { 'description': rt.call_function('__', [rt.new_string('Order ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'order_key': { 'description': rt.call_function('__', [rt.new_string('Order key.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'downloads_remaining': { 'description': rt.call_function('__', [rt.new_string('Number of downloads remaining.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'access_expires': { 'description': rt.call_function('__', [rt.new_string('The date when download access expires, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'access_expires_gmt': { 'description': rt.call_function('__', [rt.new_string('The date when download access expires, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'file': { 'description': rt.call_function('__', [rt.new_string('File details.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'properties': { 'name': { 'description': rt.call_function('__', [rt.new_string('File name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'file': { 'description': rt.call_function('__', [rt.new_string('File URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

struct Class_WC_REST_Customer_Downloads_V1_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_customer_downloads_v2_controller() &Class_WC_REST_Customer_Downloads_V2_Controller {
	mut obj := &Class_WC_REST_Customer_Downloads_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
	}
	return obj
}

fn create_wc_rest_customer_downloads_v1_controller() &Class_WC_REST_Customer_Downloads_V1_Controller {
	mut obj := &Class_WC_REST_Customer_Downloads_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Customer_Downloads_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WC_REST_Customer_Downloads_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Customer_Downloads_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Customer_Downloads_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Customer_Downloads_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Customer_Downloads_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_customer_downloads_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

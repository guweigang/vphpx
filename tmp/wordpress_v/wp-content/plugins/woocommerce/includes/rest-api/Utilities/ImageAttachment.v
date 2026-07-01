import rt

struct Class_Automattic_WooCommerce_RestApi_Utilities_ImageAttachment {
	rt.PhpObjectBase
pub mut:
		id rt.PhpVal = rt.new_int(0)
		object_id rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Utilities_ImageAttachment) construct(id i64, object_id i64)  {
	this.id = // unsupported expression: Expr_Cast_Int
	this.object_id = // unsupported expression: Expr_Cast_Int
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Utilities_ImageAttachment) upload_image_from_src(var_src rt.PhpVal)  {
	mut var_images := rt.new_null()
	mut var_upload := rt.call_function('wc_rest_upload_image_from_url', [rt.call_function('esc_url_raw', [var_src.dup()])])
	if rt.is_true(rt.call_function('is_wp_error', [var_upload.dup()])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_suppress_image_upload_error'), rt.new_bool(false), var_upload.dup(), this.object_id, var_images.dup()]))))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_RestApi_Utilities_WC_REST_Exception', []string{}, create_automattic_woocommerce_restapi_utilities_wc_rest_exception(rt.new_string('woocommerce_product_image_upload_error'), rt.call_method(var_upload, 'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
		} else {
			return rt.new_null()
		}
	}
	this.id = rt.call_function('wc_rest_set_uploaded_image_as_attachment', [var_upload.dup(), this.object_id])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_attachment_is_image', [this.id]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_RestApi_Utilities_WC_REST_Exception', []string{}, create_automattic_woocommerce_restapi_utilities_wc_rest_exception(rt.new_string('woocommerce_product_invalid_image_id'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%s is an invalid image ID.'), rt.new_string('woocommerce')]), this.id]), rt.new_int(400))))
	}
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Utilities_ImageAttachment) update_alt_text(var_text rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.id)))) {
		return rt.new_null()
	}
	rt.call_function('update_post_meta', [this.id, rt.new_string('_wp_attachment_image_alt'), rt.call_function('wc_clean', [var_text.dup()])])
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Utilities_ImageAttachment) update_name(var_text rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.id)))) {
		return rt.new_null()
	}
	rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: this.id }, rt.ArrayItem{ key: 'post_title', val: var_text }])])
}

struct Class_Automattic_WooCommerce_RestApi_Utilities_WC_REST_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_restapi_utilities_imageattachment(id i64, object_id i64) &Class_Automattic_WooCommerce_RestApi_Utilities_ImageAttachment {
	mut obj := &Class_Automattic_WooCommerce_RestApi_Utilities_ImageAttachment{
		PhpObjectBase: rt.PhpObjectBase{}
		id: rt.new_int(0)
		object_id: rt.new_int(0)
	}
	obj.construct(id, object_id)
	return obj
}

fn create_automattic_woocommerce_restapi_utilities_wc_rest_exception() &Class_Automattic_WooCommerce_RestApi_Utilities_WC_REST_Exception {
	mut obj := &Class_Automattic_WooCommerce_RestApi_Utilities_WC_REST_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Utilities_ImageAttachment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'upload_image_from_src' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.upload_image_from_src(dispatch_arg_0)
			return rt.new_null()
		}
		'update_alt_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_alt_text(dispatch_arg_0)
			return rt.new_null()
		}
		'update_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_name(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_RestApi_Utilities_ImageAttachment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'object_id' { return this.object_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Utilities_ImageAttachment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' { this.id = val; return true }
		'object_id' { this.object_id = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_RestApi_Utilities_WC_REST_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_RestApi_Utilities_WC_REST_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Utilities_WC_REST_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_utilities_imageattachment_php() {
}

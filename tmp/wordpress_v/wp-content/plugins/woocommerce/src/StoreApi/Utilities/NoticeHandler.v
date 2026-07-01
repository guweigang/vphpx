import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler.convert_notices_to_exceptions(error_code string) {
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('wc_notice_count', [
		rt.new_string('error'),
	])))
	{
		rt.call_function('wc_clear_notices', []rt.PhpVal{})
		return rt.new_null()
	}
	mut var_error_notices := rt.call_function('wc_get_notices', [
		rt.new_string('error')])
	rt.call_function('wc_clear_notices', []rt.PhpVal{})
	{
		mut iter_1 := var_error_notices.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_error_notice := item_1.val
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
				[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string(error_code).dup(), rt.call_function('wp_strip_all_tags', [
				var_error_notice.array_get('notice'),
			]), rt.new_int(400))))
		}
	}
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler.convert_notices_to_wp_errors(error_code string) rt.PhpVal {
	mut var_errors := create_wp_error()
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('wc_notice_count', [
		rt.new_string('error'),
	])))
	{
		return mut var_errors
	}
	mut var_error_notices := rt.call_function('wc_get_notices', [
		rt.new_string('error')])
	{
		mut iter_1 := var_error_notices.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_error_notice := item_1.val
			var_errors.add(rt.new_string(error_code), rt.call_function('wp_strip_all_tags', [
				var_error_notice.array_get('notice'),
			]))
		}
	}
	return mut var_errors
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_utilities_noticehandler() &Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_routeexception() &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'convert_notices_to_exceptions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler.convert_notices_to_exceptions(dispatch_arg_0)
			return rt.new_null()
		}
		'convert_notices_to_wp_errors' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler.convert_notices_to_wp_errors(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_storeapi_utilities_noticehandler_php() {
}

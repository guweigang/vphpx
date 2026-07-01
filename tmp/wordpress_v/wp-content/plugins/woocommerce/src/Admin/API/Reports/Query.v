import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Query {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Query) construct(var_args rt.PhpVal)  {
	rt.call_function('wc_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('9.3.0'), rt.new_string('`GenericQuery`, `\\WC_Object_Query`, or direct `DataStore` use')])
	this.Class_Automattic_WooCommerce_Admin_API_Reports_WC_Object_Query.construct(var_args.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Query) get_data() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('9.3.0'), rt.new_string('`GenericQuery`, `\\WC_Object_Query`, or direct `DataStore` use')])
	return create_automattic_woocommerce_admin_api_reports_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.'), rt.new_string('woocommerce')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }]))
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WC_Object_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_query(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_wc_object_query() &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Object_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Object_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_wp_error() &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_data' {
			return this.get_data()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_Object_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Object_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_Object_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_query_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

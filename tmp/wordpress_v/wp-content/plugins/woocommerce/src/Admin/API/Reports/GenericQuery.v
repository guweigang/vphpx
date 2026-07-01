import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) construct(var_args rt.PhpVal, var_name rt.PhpVal)  {
	mut var_args_mutated := var_args
	this.name = if !(var_name).is_null() { var_name } else { this.name }
	return
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) get_default_query_vars() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) get_data() rt.PhpVal {
	mut var_snake_name := rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), this.name])
	mut var_args := rt.call_function('apply_filters', [rt.new_string("woocommerce_analytics_${var_snake_name.to_string()}_query_args"), this.get_query_vars()])
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string(rt.concat(rt.new_string('report-'), this.name)))
	mut var_results := rt.call_method(var_data_store, 'get_data', [var_args.dup()])
	return rt.call_function('apply_filters', [rt.new_string("woocommerce_analytics_${var_snake_name.to_string()}_select_query"), var_results.dup(), var_args.dup()])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WC_Object_Query {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_genericquery(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_wc_object_query() &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Object_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Object_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_data' {
			return this.get_data()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_genericquery_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

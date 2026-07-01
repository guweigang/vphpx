import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor) process(var_rule rt.PhpVal, var_stored_state rt.PhpVal) bool {
	mut var_dates := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}; return temp.get_timeframe_dates(arg_0) }(rt.get_property(var_rule, 'timeframe'))
	mut var_reports_revenue := this.get_reports_query(rt.create_array([rt.ArrayItem{ key: 'before', val: var_dates.array_get('end') }, rt.ArrayItem{ key: 'after', val: var_dates.array_get('start') }, rt.ArrayItem{ key: 'interval', val: 'year' }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: none, val: 'total_sales' }]) }]))
	mut var_report_data := rt.call_method(var_reports_revenue, 'get_data', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_report_data)))) || !(!(rt.get_property(rt.get_property(var_report_data, 'totals'), 'total_sales')).is_null()))) {
		return false
	}
	mut var_value := rt.get_property(rt.get_property(var_report_data, 'totals'), 'total_sales')
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation{}; return temp.compare(arg_0, arg_1, arg_2) }(var_value.dup(), rt.get_property(var_rule, 'value'), rt.get_property(var_rule, 'operation'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor) validate(var_rule rt.PhpVal) bool {
	mut var_allowed_timeframes := rt.create_array([rt.ArrayItem{ key: none, val: 'last_week' }, rt.ArrayItem{ key: none, val: 'last_month' }, rt.ArrayItem{ key: none, val: 'last_quarter' }, rt.ArrayItem{ key: none, val: 'last_6_months' }, rt.ArrayItem{ key: none, val: 'last_year' }])
	if rt.is_true(rt.new_bool(!(!(rt.get_property(var_rule, 'timeframe')).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_rule, 'timeframe'), var_allowed_timeframes.dup(), rt.new_bool(true)]))))))) {
		return false
	}
	if !(!(rt.get_property(var_rule, 'value')).is_null()) {
		return false
	}
	if !(!(rt.get_property(var_rule, 'operation')).is_null()) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('range'), rt.get_property(var_rule, 'operation'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_rule, 'value').is_array()))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return false
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_rule, 'value').array_get(0).is_long() || rt.get_property(var_rule, 'value').array_get(0).is_double()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_rule, 'value').array_get(1).is_long() || rt.get_property(var_rule, 'value').array_get(1).is_double()))))))) {
			return false
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_rule, 'value').is_long() || rt.get_property(var_rule, 'value').is_double()))))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor) get_reports_query(var_args rt.PhpVal) rt.PhpVal {
	return create_automattic_woocommerce_admin_api_reports_revenue_query(var_args.dup())
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_totalpaymentsvolumeprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_timeinterval() &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_comparisonoperation() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_revenue_query() &Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.process(dispatch_arg_0, dispatch_arg_1))
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate(dispatch_arg_0))
		}
		'get_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_reports_query(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_totalpaymentsvolumeprocessor_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

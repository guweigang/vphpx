import rt

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcRuleValueList {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcRuleValueList) construct(iLineNo i64) {
	this.Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList.construct(rt.new_string(','),
		rt.new_int(iLineNo))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcRuleValueList) render(var_oOutputFormat rt.PhpVal) rt.PhpVal {
	return rt.call_method(var_oOutputFormat, 'implode', [rt.new_string(' '),
		rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcRuleValueList', [
			'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList',
		], &this), 'aComponents')])
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_calcrulevaluelist(iLineNo i64) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcRuleValueList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcRuleValueList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(iLineNo)
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_rulevaluelist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcRuleValueList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcRuleValueList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcRuleValueList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

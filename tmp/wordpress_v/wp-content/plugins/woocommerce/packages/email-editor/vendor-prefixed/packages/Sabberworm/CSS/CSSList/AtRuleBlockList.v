import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList {
	rt.PhpObjectBase
pub mut:
	sType rt.PhpVal = rt.new_null()
	sArgs rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) construct(var_sType rt.PhpVal, sArgs string, iLineNo i64) {
	mut sArgs_mutated := sArgs
	this.Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList.construct(rt.new_int(iLineNo))
	this.sType = var_sType.dup()
	this.sArgs = rt.new_string(sArgs_mutated).dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) atrulename() rt.PhpVal {
	return this.sType
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) atruleargs() rt.PhpVal {
	return this.sArgs
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) magic_tostring() rt.PhpVal {
	return this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) render(var_oOutputFormat rt.PhpVal) rt.PhpVal {
	mut var_sResult := rt.call_method(var_oOutputFormat, 'comments', [
		rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList', [
			'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList',
			'AtRule',
		], &this),
	])
	// unsupported expression: Expr_AssignOp_Concat
	mut var_sArgs := this.sArgs
	if rt.is_true(var_sArgs) {
		var_sArgs = rt.new_string(' ' + var_sArgs.str())
	}
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	return var_sResult.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) isrootlist() bool {
	return false
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_atruleblocklist(sArgs string, iLineNo i64, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList{
		PhpObjectBase: rt.PhpObjectBase{}
		sType:         rt.new_null()
		sArgs:         rt.new_null()
	}
	obj.construct(sArgs, iLineNo, arg_2)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_cssblocklist() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'atRuleName' {
			return this.atrulename()
		}
		'atRuleArgs' {
			return this.atruleargs()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render(dispatch_arg_0)
		}
		'isRootList' {
			return rt.new_bool(this.isrootlist())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sType' { return this.sType }
		'sArgs' { return this.sArgs }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sType' {
			this.sType = val
			return true
		}
		'sArgs' {
			this.sArgs = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_csslist_atruleblocklist_php() {
}

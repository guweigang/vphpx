import rt

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule {
	rt.PhpObjectBase
pub mut:
	declarationBlock rt.PhpVal = rt.new_null()
	containingAtRule string
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule) construct(mut var_declarationBlock Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock, containingAtRule string) {
	this.declarationBlock = var_declarationBlock
	this.containingAtRule = containingAtRule.trim_space()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule) getselectors() rt.PhpVal {
	mut var_selectors := rt.call_method(this.declarationBlock, 'getSelectors', []rt.PhpVal{})
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_selector := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_string(var_selector.str())
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_selector := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_string(var_selector.str())
	}
	return rt.call_function('array_map', [rt.new_closure(closure_1_fn),
		var_selectors.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule) getdeclarationastext() string {
	return (rt.call_function('implode', [rt.new_string(' '),
		rt.call_method(this.declarationBlock, 'getRules', []rt.PhpVal{})])).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule) hasatleastonedeclaration() bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.call_method(this.declarationBlock, 'getRules',
		[]rt.PhpVal{}), rt.new_array())))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule) getcontainingatrule() string {
	return this.containingAtRule
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule) hascontainingatrule() bool {
	return rt.new_bool(this.getcontainingatrule() != '')
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_css_stylerule(arg_0 rt.PhpVal, containingAtRule string) &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule{
		PhpObjectBase:    rt.PhpObjectBase{}
		declarationBlock: rt.new_null()
		containingAtRule: ''
	}
	obj.construct(arg_0, containingAtRule)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getSelectors' {
			return this.getselectors()
		}
		'getDeclarationAsText' {
			return rt.new_string(this.getdeclarationastext())
		}
		'hasAtLeastOneDeclaration' {
			return rt.new_bool(this.hasatleastonedeclaration())
		}
		'getContainingAtRule' {
			return rt.new_string(this.getcontainingatrule())
		}
		'hasContainingAtRule' {
			return rt.new_bool(this.hascontainingatrule())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'declarationBlock' { return this.declarationBlock }
		'containingAtRule' { return rt.new_string(this.containingAtRule) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Css_StyleRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'declarationBlock' {
			this.declarationBlock = val
			return true
		}
		'containingAtRule' {
			this.containingAtRule = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

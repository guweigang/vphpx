import rt

pub fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector.non_id_attributes_and_pseudo_classes_rx() string {
	return '/\n        (\\.[\\w]+)                   # classes\n        |\n        \\[(\\w+)                     # attributes\n        |\n        (\\:(                        # pseudo classes\n            link|visited|active\n            |hover|focus\n            |lang\n            |target\n            |enabled|disabled|checked|indeterminate\n            |root\n            |nth-child|nth-last-child|nth-of-type|nth-last-of-type\n            |first-child|last-child|first-of-type|last-of-type\n            |only-child|only-of-type\n            |empty|contains\n        ))\n        /ix'
}

pub fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector.elements_and_pseudo_elements_rx() string {
	return '/\n        ((^|[\\s\\+\\>\\~]+)[\\w]+   # elements\n        |\n        \\:{1,2}(                # pseudo-elements\n            after|before|first-letter|first-line|selection\n        ))\n        /ix'
}

pub fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector.selector_validation_rx() string {
	return '/\n        ^(\n            (?:\n                [a-zA-Z0-9\\x{00A0}-\\x{FFFF}_^$|*="\'~\\[\\]()\\-\\s\\.:#+>]* # any sequence of valid unescaped characters\n                (?:\\\\.)?                                              # a single escaped character\n                (?:([\'"]).*?(?<!\\\\)\\2)?                              # a quoted text like [id="example"]\n            )*\n        )$\n        /ux'
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector {
	rt.PhpObjectBase
pub mut:
	sSelector    string
	iSpecificity rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector.isvalid(var_sSelector rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_match', [
		Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_static.selector_validation_rx(),
		var_sSelector.dup(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector) construct(var_sSelector rt.PhpVal, bCalculateSpecificity bool) {
	this.setselector(var_sSelector.dup())
	if var_bCalculateSpecificity {
		this.getspecificity()
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector) getselector() string {
	return this.sSelector
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector) setselector(var_sSelector rt.PhpVal) {
	this.sSelector = var_sSelector.dup().to_string().trim_space()
	this.iSpecificity = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector) magic_tostring() rt.PhpVal {
	return rt.new_string(this.getselector())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector) getspecificity() rt.PhpVal {
	if rt.is_true(rt.identical(this.iSpecificity, rt.new_null())) {
		mut var_a := rt.new_int(rt.new_int(0))
		mut var_aMatches := rt.new_null()
		mut var_b := rt.call_function('substr_count', [this.sSelector, rt.new_string('#')])
		mut var_c := rt.call_function('preg_match_all', [
			Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector.non_id_attributes_and_pseudo_classes_rx(),
			this.sSelector,
			var_aMatches.dup(),
		])
		mut var_d := rt.call_function('preg_match_all', [
			Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector.elements_and_pseudo_elements_rx(),
			this.sSelector,
			var_aMatches.dup(),
		])
		this.iSpecificity = rt.add(rt.add(rt.add(rt.mul(var_a, rt.new_int(1000)), rt.mul(var_b,
			rt.new_int(100))), rt.mul(var_c, rt.new_int(10))), var_d)
	}
	return this.iSpecificity
}

fn create_automattic_woocommerce_vendor_sabberworm_css_property_selector(bCalculateSpecificity bool, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector{
		PhpObjectBase: rt.PhpObjectBase{}
		sSelector:     ''
		iSpecificity:  rt.new_null()
	}
	obj.construct(bCalculateSpecificity, arg_1)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'isValid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector.isvalid(dispatch_arg_0)
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getSelector' {
			return rt.new_string(this.getselector())
		}
		'setSelector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setselector(dispatch_arg_0)
			return rt.new_null()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'getSpecificity' {
			return this.getspecificity()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sSelector' { return rt.new_string(this.sSelector) }
		'iSpecificity' { return this.iSpecificity }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sSelector' {
			this.sSelector = val.str()
			return true
		}
		'iSpecificity' {
			this.iSpecificity = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_sabberworm_css_property_selector_php() {
}

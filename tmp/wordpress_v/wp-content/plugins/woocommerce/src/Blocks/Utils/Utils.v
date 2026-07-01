import rt

struct Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_Utils_Utils.wp_version_compare(var_version rt.PhpVal, var_operator rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_version_mutated := var_version
	mut var_current_wp_version := rt.call_function('get_bloginfo', [rt.new_string('version')])
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^([0-9]+\\.[0-9]+)/'), var_current_wp_version.dup(), var_matches.dup()])) {
		var_current_wp_version = // unsupported expression: Expr_Cast_Double
	}
	var_current_wp_version = rt.call_function('preg_replace', [rt.new_string('/[^0-9a-zA-Z\\.]+/i'), rt.new_string('.'), var_current_wp_version.dup()])
	var_version_mutated = rt.call_function('preg_replace', [rt.new_string('/[^0-9a-zA-Z\\.]+/i'), rt.new_string('.'), var_version_mutated.dup()])
	return rt.call_function('version_compare', [var_current_wp_version.dup(), var_version_mutated.dup(), var_operator.dup()])
}

fn create_automattic_woocommerce_blocks_utils_utils() &Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'wp_version_compare' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_Utils.wp_version_compare(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_utils_utils_php() {
}

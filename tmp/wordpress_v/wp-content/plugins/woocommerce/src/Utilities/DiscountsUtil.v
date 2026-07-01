import rt

struct Class_Automattic_WooCommerce_Utilities_DiscountsUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Utilities_DiscountsUtil.is_coupon_emails_allowed(var_check_emails rt.PhpVal, var_restrictions rt.PhpVal) bool {
	mut var_match := rt.new_null()
	{
		mut iter_1 := var_check_emails.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_check_email := item_1.val
			if rt.is_true(rt.call_function('in_array', [var_check_email.dup(),
				var_restrictions.dup(), rt.new_bool(true)]))
			{
				return true
			}
			{
				mut iter_2 := var_restrictions.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_restriction := item_2.val
					mut var_regex := rt.new_string('/^' +
						(rt.call_function('str_replace', [rt.new_string('*'), rt.new_string('(.+)?'), var_restriction.dup()])).str() +
						'$/')
					rt.call_function('preg_match', [var_regex.dup(),
						var_check_email.dup(), var_match.dup()])
					if !(!rt.is_true(var_match)) {
						return true
					}
				}
			}
		}
	}
	return false
}

fn create_automattic_woocommerce_utilities_discountsutil() &Class_Automattic_WooCommerce_Utilities_DiscountsUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_DiscountsUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_DiscountsUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_coupon_emails_allowed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_DiscountsUtil.is_coupon_emails_allowed(dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_DiscountsUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_DiscountsUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_utilities_discountsutil_php() {
}

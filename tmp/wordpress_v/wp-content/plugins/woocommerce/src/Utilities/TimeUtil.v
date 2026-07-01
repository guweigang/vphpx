import rt

struct Class_Automattic_WooCommerce_Utilities_TimeUtil {
	rt.PhpObjectBase
pub mut:
	utc_date_time_zone rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Utilities_TimeUtil) construct() {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Utilities_TimeUtil.get_utc_date_time_zone() rt.PhpVal {
	return
}

fn Class_Automattic_WooCommerce_Utilities_TimeUtil.is_valid_date(date string, format string) bool {
	mut var_d := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_DateTime{}
		return temp.createfromformat(arg_0, arg_1)
	}(rt.new_string(format), rt.new_string(date))
	return rt.is_true(var_d)
		&& rt.is_true(rt.identical(rt.call_method(var_d, 'format', [rt.new_string(format)]), rt.new_string(date)))
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_timeutil() &Class_Automattic_WooCommerce_Utilities_TimeUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_TimeUtil{
		PhpObjectBase:      rt.PhpObjectBase{}
		utc_date_time_zone: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_datetime() &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_TimeUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_utc_date_time_zone' {
			return Class_Automattic_WooCommerce_Utilities_TimeUtil.get_utc_date_time_zone()
		}
		'is_valid_date' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_TimeUtil.is_valid_date(dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_TimeUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'utc_date_time_zone' { return this.utc_date_time_zone }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Utilities_TimeUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'utc_date_time_zone' {
			this.utc_date_time_zone = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_utilities_timeutil_php() {
}

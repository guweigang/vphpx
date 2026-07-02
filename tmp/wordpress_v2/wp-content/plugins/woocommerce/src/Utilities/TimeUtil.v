import rt

struct Class_Automattic_WooCommerce_Utilities_TimeUtil {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_utilities_timeutil() {
	rt.init_static_prop('Automattic_WooCommerce_Utilities_TimeUtil', 'utc_date_time_zone',
		rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_Utilities_TimeUtil) construct() {
	rt.set_static_prop('Automattic_WooCommerce_Utilities_TimeUtil', 'utc_date_time_zone', rt.new_object('DateTimeZone',
		[]string{}, create_datetimezone(rt.new_string('UTC'))))
}

fn Class_Automattic_WooCommerce_Utilities_TimeUtil.get_utc_date_time_zone() rt.PhpVal {
	return rt.get_static_prop('Automattic_WooCommerce_Utilities_TimeUtil', 'utc_date_time_zone')
}

fn Class_Automattic_WooCommerce_Utilities_TimeUtil.is_valid_date(date string, format string) bool {
	mut iife_temp_0 := Class_DateTime{}
	mut iife_result_0 := iife_temp_0.createfromformat(rt.new_string(format), rt.new_string(date))
	mut var_d := iife_result_0
	return rt.is_true(var_d)
		&& rt.is_true(rt.identical(rt.call_method(var_d, 'format', [rt.new_string(format)]), rt.new_string(date)))
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_timeutil() &Class_Automattic_WooCommerce_Utilities_TimeUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_TimeUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
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
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_TimeUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}
}

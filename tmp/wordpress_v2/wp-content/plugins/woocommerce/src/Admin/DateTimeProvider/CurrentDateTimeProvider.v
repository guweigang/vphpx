import rt

struct Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider) get_now() rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Admin_DateTimeProvider_DateTime', []string{},
		create_automattic_woocommerce_admin_datetimeprovider_datetime())
}

struct Class_Automattic_WooCommerce_Admin_DateTimeProvider_DateTime {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_datetimeprovider_currentdatetimeprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_datetimeprovider_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_DateTimeProvider_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_DateTimeProvider_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_now' {
			return this.get_now()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DateTimeProvider_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_DateTimeProvider_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DateTimeProvider_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

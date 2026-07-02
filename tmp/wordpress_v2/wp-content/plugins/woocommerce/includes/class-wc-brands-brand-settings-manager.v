import rt

struct Class_WC_Brands_Brand_Settings_Manager {
	rt.PhpObjectBase
}

fn init_static_wc_brands_brand_settings_manager() {
	rt.init_static_prop('WC_Brands_Brand_Settings_Manager', 'brand_settings', rt.new_array())
}

fn Class_WC_Brands_Brand_Settings_Manager.set_brand_settings_on_coupon(var_coupon rt.PhpVal) {
	mut var_coupon_id := rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})
	if rt.get_static_prop('WC_Brands_Brand_Settings_Manager', 'brand_settings').array_isset(var_coupon_id) {
		return
	}
	mut var_included_brands := rt.call_function('get_post_meta', [
		var_coupon_id.clone(), rt.new_string('product_brands'),
		rt.new_bool(true)])
	var_included_brands = if !(!rt.is_true(var_included_brands)) {
		var_included_brands
	} else {
		rt.new_array()
	}
	mut var_excluded_brands := rt.call_function('get_post_meta', [
		var_coupon_id.clone(), rt.new_string('exclude_product_brands'),
		rt.new_bool(true)])
	var_excluded_brands = if !(!rt.is_true(var_excluded_brands)) {
		var_excluded_brands
	} else {
		rt.new_array()
	}
	rt.get_static_prop('WC_Brands_Brand_Settings_Manager', 'brand_settings').array_set(var_coupon_id, rt.create_array([
		rt.ArrayItem{ key: 'included_brands', val: var_included_brands },
		rt.ArrayItem{ key: 'excluded_brands', val: var_excluded_brands },
	]))
}

fn Class_WC_Brands_Brand_Settings_Manager.get_brand_settings_on_coupon(var_coupon rt.PhpVal) rt.PhpVal {
	mut var_coupon_id := rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})
	if rt.get_static_prop('WC_Brands_Brand_Settings_Manager', 'brand_settings').array_isset(var_coupon_id) {
		return rt.get_static_prop('WC_Brands_Brand_Settings_Manager', 'brand_settings').array_get(var_coupon_id)
	}
	return rt.create_array([rt.ArrayItem{ key: 'included_brands', val: rt.new_array() },
		rt.ArrayItem{ key: 'excluded_brands', val: rt.new_array() }])
}

fn create_wc_brands_brand_settings_manager(_args ...rt.PhpVal) &Class_WC_Brands_Brand_Settings_Manager {
	mut obj := &Class_WC_Brands_Brand_Settings_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Brands_Brand_Settings_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_brand_settings_on_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Brands_Brand_Settings_Manager.set_brand_settings_on_coupon(dispatch_arg_0)
			return rt.new_null()
		}
		'get_brand_settings_on_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Brands_Brand_Settings_Manager.get_brand_settings_on_coupon(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Brands_Brand_Settings_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Brands_Brand_Settings_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

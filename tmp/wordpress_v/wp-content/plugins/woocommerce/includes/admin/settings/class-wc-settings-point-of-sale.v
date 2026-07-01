import rt

struct Class_WC_Settings_Point_Of_Sale {
	rt.PhpObjectBase
pub mut:
		icon rt.PhpVal = rt.new_string('store')
}

fn (mut this Class_WC_Settings_Point_Of_Sale) construct()  {
	this.dispatch_set_prop('id', rt.new_string('point-of-sale'))
	this.dispatch_set_prop('label', rt.call_function('__', [rt.new_string('Point of Sale'), rt.new_string('woocommerce')]))
	this.Class_WC_Settings_Page.construct()
	rt.call_function('add_filter', [rt.new_string('woocommerce_settings_tabs_array'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Point_Of_Sale', ['WC_Settings_Page'], &this) }, rt.ArrayItem{ key: none, val: 'add_settings_page' }]), rt.new_int(20)])
}

fn (mut this Class_WC_Settings_Point_Of_Sale) add_settings_page(var_pages rt.PhpVal) rt.PhpVal {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('point_of_sale'))) {
		return this.Class_WC_Settings_Page.add_settings_page(var_pages.dup())
	} else {
		return var_pages.dup()
	}
	return rt.new_null()
}

fn (mut this Class_WC_Settings_Point_Of_Sale) get_settings_for_default_section() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Store details'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Details about the store that are shown in email receipts.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'store_details' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Store name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('The name of your physical store.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_pos_store_name' }, rt.ArrayItem{ key: 'default', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}; return temp.get_default_store_name() }() }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'css', val: 'min-width:300px;' }, rt.ArrayItem{ key: 'skip_initial_save', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Physical address'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_pos_store_address' }, rt.ArrayItem{ key: 'default', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}; return temp.get_default_store_address() }() }, rt.ArrayItem{ key: 'type', val: 'textarea' }, rt.ArrayItem{ key: 'css', val: 'min-width:300px; height: 100px;' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Phone number'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_pos_store_phone' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'css', val: 'min-width:300px;' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Email'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Your store contact email.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_pos_store_email' }, rt.ArrayItem{ key: 'default', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}; return temp.get_default_store_email() }() }, rt.ArrayItem{ key: 'type', val: 'email' }, rt.ArrayItem{ key: 'css', val: 'min-width:300px;' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Refund & Returns Policy'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Brief statement that will appear on the receipts.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_pos_refund_returns_policy' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'type', val: 'textarea' }, rt.ArrayItem{ key: 'css', val: 'min-width:300px; height: 100px;' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'store_details' }]) }])
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings {
	rt.PhpObjectBase
}

fn create_wc_settings_point_of_sale() &Class_WC_Settings_Point_Of_Sale {
	mut obj := &Class_WC_Settings_Point_Of_Sale{
		PhpObjectBase: rt.PhpObjectBase{}
		icon: rt.new_string('store')
	}
	obj.construct()
	return obj
}

fn create_wc_settings_page() &Class_WC_Settings_Page {
	mut obj := &Class_WC_Settings_Page{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_settings_pointofsaledefaultsettings() &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Settings_Point_Of_Sale) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_settings_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_settings_page(dispatch_arg_0)
		}
		'get_settings_for_default_section' {
			return this.get_settings_for_default_section()
		}
		else { return none }
	}
}

fn (this &Class_WC_Settings_Point_Of_Sale) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'icon' { return this.icon }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_Point_Of_Sale) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'icon' { this.icon = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Settings_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_settings_class_wc_settings_point_of_sale_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Settings_Point_Of_Sale'), rt.new_bool(false)])) {
		return create_wc_settings_point_of_sale()
	}
	return create_wc_settings_point_of_sale()
}

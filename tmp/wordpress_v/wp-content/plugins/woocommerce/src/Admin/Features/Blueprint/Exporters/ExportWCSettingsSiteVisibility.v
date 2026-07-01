import rt

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility) export() rt.PhpVal {
	return create_automattic_woocommerce_blueprint_steps_setsiteoptions(rt.create_array([
		rt.ArrayItem{
			key: 'woocommerce_coming_soon'
			val: this.wp_get_option(rt.new_string('woocommerce_coming_soon'))
		},
		rt.ArrayItem{
			key: 'woocommerce_store_pages_only'
			val: this.wp_get_option(rt.new_string('woocommerce_store_pages_only'))
		},
	]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility) get_alias() string {
	return 'setWCSettingsSiteVisibility'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility) get_label() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Site Visibility'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility) get_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Includes all settings in WooCommerce | Settings | Visibility.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility) get_step_name() string {
	return 'setSiteOptions'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility) check_step_capabilities() bool {
	return (rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])).to_bool()
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwcsettingssitevisibility() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_setsiteoptions() &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'export' {
			return this.export()
		}
		'get_alias' {
			return rt.new_string(this.get_alias())
		}
		'get_label' {
			return this.get_label()
		}
		'get_description' {
			return this.get_description()
		}
		'get_step_name' {
			return rt.new_string(this.get_step_name())
		}
		'check_step_capabilities' {
			return rt.new_bool(this.check_step_capabilities())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_blueprint_exporters_exportwcsettingssitevisibility_php() {
	// unsupported statement: Stmt_Declare
}

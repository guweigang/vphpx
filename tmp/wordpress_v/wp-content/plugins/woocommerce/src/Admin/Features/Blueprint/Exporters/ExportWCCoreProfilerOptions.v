import rt

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions) export() rt.PhpVal {
	return create_automattic_woocommerce_blueprint_steps_setsiteoptions(rt.create_array([
		rt.ArrayItem{ key: 'blogname', val: this.wp_get_option(rt.new_string('blogname')) },
		rt.ArrayItem{
			key: 'woocommerce_allow_tracking'
			val: this.wp_get_option(rt.new_string('woocommerce_allow_tracking'))
		},
		rt.ArrayItem{ key: 'woocommerce_onboarding_profile', val: this.wp_get_option(rt.new_string('woocommerce_onboarding_profile'),
			rt.new_array()) },
		rt.ArrayItem{
			key: 'woocommerce_default_country'
			val: this.wp_get_option(rt.new_string('woocommerce_default_country'))
		},
	]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions) get_step_name() string {
	return 'setSiteOptions'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions) get_alias() string {
	return 'setWCCoreProfilerOptions'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions) get_label() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Onboarding Configuration'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions) get_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Includes onboarding configuration options'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions) check_step_capabilities() bool {
	return (rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])).to_bool()
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwccoreprofileroptions() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions{
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'export' {
			return this.export()
		}
		'get_step_name' {
			return rt.new_string(this.get_step_name())
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
		'check_step_capabilities' {
			return rt.new_bool(this.check_step_capabilities())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCCoreProfilerOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_admin_features_blueprint_exporters_exportwccoreprofileroptions_php() {
	// unsupported statement: Stmt_Declare
}

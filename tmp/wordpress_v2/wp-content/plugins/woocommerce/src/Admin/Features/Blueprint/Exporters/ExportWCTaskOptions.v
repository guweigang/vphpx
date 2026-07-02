import rt

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions) export() rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions', []string{}, create_automattic_woocommerce_blueprint_steps_setsiteoptions(rt.create_array([
		rt.ArrayItem{ key: 'woocommerce_admin_customize_store_completed', val: this.wp_get_option(rt.new_string('woocommerce_admin_customize_store_completed'),
			rt.new_string('no')) },
		rt.ArrayItem{ key: 'woocommerce_task_list_tracked_completed_actions', val: this.wp_get_option(rt.new_string('woocommerce_task_list_tracked_completed_actions'),
			rt.new_array()) },
	])))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions) get_step_name() string {
	return 'setOptions'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions) get_alias() string {
	return 'setWCTaskOptions'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions) get_label() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Task Configurations'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions) get_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Includes the task configurations for WooCommerce.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions) check_step_capabilities() bool {
	return (rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])).to_bool()
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwctaskoptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_setsiteoptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCTaskOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}

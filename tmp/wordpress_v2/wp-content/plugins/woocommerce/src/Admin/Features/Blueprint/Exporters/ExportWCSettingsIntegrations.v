import rt

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations) get_alias() string {
	return 'setWCSettingsIntegrations'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations) get_label() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Integrations'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations) export() rt.PhpVal {
	if !(!(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'integrations')).is_null()) {
		return rt.new_object('Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions', []string{},
			create_automattic_woocommerce_blueprint_steps_setsiteoptions(rt.new_array()))
	}
	mut var_integrations := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'integrations'), 'get_integrations', []rt.PhpVal{})
	mut var_settings := rt.new_array()
	mut iter_1 := var_integrations.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_integration := item_1.val
		mut var_option_key := rt.call_method(var_integration, 'get_option_key', []rt.PhpVal{})
		var_settings.array_set(var_option_key, rt.call_function('get_option', [
			var_option_key.clone(),
			rt.new_null(),
		]))
	}
	return rt.new_object('Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions', []string{},
		create_automattic_woocommerce_blueprint_steps_setsiteoptions(var_settings.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations) get_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Includes all settings in WooCommerce | Settings | Integrations.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations) get_page_id() string {
	return 'integration'
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwcsettingsintegrations(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwcsettings(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings{
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_alias' {
			return rt.new_string(this.get_alias())
		}
		'get_label' {
			return this.get_label()
		}
		'export' {
			return this.export()
		}
		'get_description' {
			return this.get_description()
		}
		'get_page_id' {
			return rt.new_string(this.get_page_id())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

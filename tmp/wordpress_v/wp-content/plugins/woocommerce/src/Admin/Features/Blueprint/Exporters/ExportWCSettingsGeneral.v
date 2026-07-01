import rt

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsGeneral {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsGeneral) get_alias() string {
	return 'setWCSettingsGeneral'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsGeneral) get_label() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('General'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsGeneral) get_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Includes all settings in WooCommerce | Settings | General.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsGeneral) get_page_id() string {
	return 'general'
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwcsettingsgeneral() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsGeneral {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsGeneral{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwcsettings() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsGeneral) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_alias' {
			return rt.new_string(this.get_alias())
		}
		'get_label' {
			return this.get_label()
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

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsGeneral) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsGeneral) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_admin_features_blueprint_exporters_exportwcsettingsgeneral_php() {
	// unsupported statement: Stmt_Declare
}

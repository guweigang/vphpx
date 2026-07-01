import rt

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails) get_alias() string {
	return 'setWCSettingsEmails'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails) export() rt.PhpVal {
	mut var_emails := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Emails{}
		return temp.instance()
	}()
	mut var_setting_options :=
		create_automattic_woocommerce_admin_features_blueprint_settingoptions()
	mut var_email_settings :=
		var_setting_options.get_page_options(rt.new_string(this.get_page_id()))
	{
		mut iter_1 := rt.call_method(var_emails, 'get_emails', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_email := item_1.val
			var_email_settings = rt.call_function('array_merge', [
				var_email_settings.dup(),
				var_setting_options.get_page_options(rt.new_string(
					'email_' + (rt.get_property(var_email, 'id')).str()))])
		}
	}
	return create_automattic_woocommerce_blueprint_steps_setsiteoptions(var_email_settings.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails) get_label() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Emails'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails) get_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Includes all settings in WooCommerce | Settings | Emails.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails) get_page_id() string {
	return 'email'
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Emails {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwcsettingsemails() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails{
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

fn create_automattic_woocommerce_admin_features_blueprint_exporters_wc_emails() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Emails {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_blueprint_settingoptions() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions{
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_alias' {
			return rt.new_string(this.get_alias())
		}
		'export' {
			return this.export()
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

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_admin_features_blueprint_exporters_exportwcsettingsemails_php() {
	// unsupported statement: Stmt_Declare
}

import rt

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax) construct(mut var_setting_options Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_?SettingOptions) {
	this.Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings.construct(rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_?SettingOptions', []string{}, var_setting_options))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax) get_alias() string {
	return 'setWCSettingsTax'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax) export() rt.PhpVal {
	mut var_basic_tax_settings := this.Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings.export()
	return rt.create_array([rt.ArrayItem{ key: none, val: var_basic_tax_settings }, rt.ArrayItem{ key: none, val: this.generatetaxratesteps('wc_tax_rate_classes') }, rt.ArrayItem{ key: none, val: this.generatetaxratesteps('woocommerce_tax_rates') }, rt.ArrayItem{ key: none, val: this.generatetaxratesteps('woocommerce_tax_rate_locations') }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax) get_label() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Tax'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax) get_description() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Includes all settings in WooCommerce | Settings | Tax.'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax) get_page_id() string {
	return 'tax'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax) generatetaxratesteps(table string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_record := rt.new_null()
	mut table_mutated := table
	table_mutated = (rt.get_property(var_wpdb, 'prefix')).str() + table_mutated
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_record := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_1 := Class_Automattic_WooCommerce_Blueprint_Util{}
		mut iife_result_1 := iife_temp_1.array_to_insert_sql(var_record.clone(), rt.new_string(table_mutated), rt.new_string('replace into'))
		return create_automattic_woocommerce_blueprint_steps_runsql(iife_result_1)
		}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_record := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_3 := Class_Automattic_WooCommerce_Blueprint_Util{}
		mut iife_result_3 := iife_temp_3.array_to_insert_sql(var_record.clone(), rt.new_string(table_mutated), rt.new_string('replace into'))
		return create_automattic_woocommerce_blueprint_steps_runsql(iife_result_3)
		}
	return rt.call_function('array_map', [rt.new_closure(closure_2_fn), rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('SELECT * FROM %i'), rt.new_string(table_mutated).clone()]), rt.get_constant('ARRAY_A')])])
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_RunSql {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Util {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwcsettingstax(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwcsettings(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_runsql(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_util(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Util {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_?SettingOptions](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
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
		'generateTaxRateSteps' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.generatetaxratesteps(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

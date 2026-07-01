import rt

pub fn Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions.restricted_options() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'siteurl' }, rt.ArrayItem{ key: none, val: 'home' }, rt.ArrayItem{ key: none, val: 'active_plugins' }, rt.ArrayItem{ key: none, val: 'template' }, rt.ArrayItem{ key: none, val: 'stylesheet' }, rt.ArrayItem{ key: none, val: 'admin_email' }, rt.ArrayItem{ key: none, val: 'unfiltered_html' }, rt.ArrayItem{ key: none, val: 'users_can_register' }, rt.ArrayItem{ key: none, val: 'default_role' }, rt.ArrayItem{ key: none, val: 'db_version' }, rt.ArrayItem{ key: none, val: 'cron' }, rt.ArrayItem{ key: none, val: 'rewrite_rules' }, rt.ArrayItem{ key: none, val: 'wp_user_roles' }])
}
struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions) process(var_schema rt.PhpVal) rt.PhpVal {
	mut var_result := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{}; return temp.success(arg_0) }(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions{}; return temp.get_step_name() }())
	{
		mut iter_1 := rt.get_property(var_schema, 'options').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_function('in_array', [var_key.dup(), Class_Automattic_WooCommerce_Blueprint_Importers_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions.restricted_options(), rt.new_bool(true)])) {
				rt.call_method(var_result, 'add_warn', [rt.new_string("Cannot modify '${var_key.to_string()}' option: Modifying is restricted for this key.")])
				continue
			}
			var_value = rt.call_function('json_decode', [rt.call_function('wp_json_encode', [var_value.dup()]), rt.new_bool(true)])
			mut var_updated := this.wp_update_option(var_key.dup(), var_value.dup())
			mut var_current_value := this.wp_get_option(var_key.dup())
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.call_method(var_result, 'add_warn', [rt.new_string("${var_key.to_string()} was intended to be set, but the stored value may have been overridden by a hook.")])
				continue
			}
			if rt.is_true(var_updated) {
				rt.call_method(var_result, 'add_info', [rt.new_string("${var_key.to_string()} has been updated.")])
				continue
			}
			if rt.is_true(rt.identical(var_current_value, var_value)) {
				rt.call_method(var_result, 'add_info', [rt.new_string("${var_key.to_string()} has not been updated because the current value is already up to date.")])
			}
		}
	}
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions) get_step_class() string {
	return (Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions.class()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions) check_step_capabilities(var_schema rt.PhpVal) bool {
	return (rt.call_function('current_user_can', [rt.new_string('manage_options')])).to_bool()
}

struct Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_importers_importsetsiteoptions() &Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_stepprocessorresult() &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{
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

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process(dispatch_arg_0)
		}
		'get_step_class' {
			return rt.new_string(this.get_step_class())
		}
		'check_step_capabilities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_step_capabilities(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_importers_importsetsiteoptions_php() {
}

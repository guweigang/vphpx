import rt

struct Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli {
	rt.PhpObjectBase
pub mut:
	save_to rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli) construct(var_save_to rt.PhpVal) {
	this.save_to = var_save_to.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli) run(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	if !(var_args_mutated.array_isset(rt.new_string('steps'))) {
		var_args_mutated.array_set('steps', rt.new_array())
	}
	mut var_exporter := create_automattic_woocommerce_blueprint_exportschema()
	mut var_result := var_exporter.export(var_args_mutated.array_get(rt.new_string('steps')))
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI{}
		mut iife_result_0 := iife_temp_0.error(rt.call_method(var_result, 'get_error_message',
			[]rt.PhpVal{}))
		return
	}
	mut var_is_saved := this.wp_filesystem_put_contents(this.save_to, rt.call_function('wp_json_encode', [
		var_result.clone(),
		rt.get_constant('JSON_PRETTY_PRINT'),
	]))
	if rt.is_true(rt.identical(rt.new_bool(false), var_is_saved)) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI{}
		mut iife_result_1 := iife_temp_1.error(rt.new_string((rt.concat(rt.new_string('Failed to save to '),
			this.save_to)).str()))
	} else {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI{}
		mut iife_result_2 := iife_temp_2.success(rt.new_string((rt.concat(rt.new_string('Exported JSON to '),
			this.save_to)).str()))
	}
}

struct Class_Automattic_WooCommerce_Blueprint_ExportSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_cli_exportcli(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli{
		PhpObjectBase: rt.PhpObjectBase{}
		save_to:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blueprint_exportschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ExportSchema {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ExportSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_cli_wp_cli(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'run' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.run(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'save_to' { return this.save_to }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'save_to' {
			this.save_to = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ExportSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ExportSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ExportSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

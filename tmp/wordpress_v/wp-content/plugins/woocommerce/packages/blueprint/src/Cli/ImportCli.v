import rt

struct Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli {
	rt.PhpObjectBase
pub mut:
	schema_path rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli) construct(var_schema_path rt.PhpVal) {
	this.schema_path = var_schema_path.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli) run(var_optional_args rt.PhpVal) {
	mut var_blueprint := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blueprint_ImportSchema{}
		return temp.create_from_file(arg_0)
	}(this.schema_path)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Blueprint_Cli_Exception') {
		mut var_e := var_e_1.dup()
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI{}
			return temp.error(arg_0)
		}(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		return rt.new_null()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	mut var_results := rt.call_method(var_blueprint, 'import', []rt.PhpVal{})
	mut var_result_formatter :=
		create_automattic_woocommerce_blueprint_resultformatters_cliresultformatter(var_results.dup())
	mut var_is_success := var_result_formatter.is_success()
	if var_optional_args.array_isset(rt.new_string('show-messages')) {
		var_result_formatter.format(var_optional_args.array_get('show-messages'))
	}
	if rt.is_true(var_is_success) {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI{}
			return temp.success(arg_0)
		}(rt.new_string(rt.concat(this.schema_path, rt.new_string(' imported successfully'))))
	} else {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI{}
			return temp.error(arg_0)
		}(rt.new_string(rt.concat(rt.concat(rt.new_string('Failed to import '), this.schema_path),
			rt.new_string('. Run with --show-messages=all to debug'))))
	}
}

struct Class_Automattic_WooCommerce_Blueprint_ImportSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_cli_importcli(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli{
		PhpObjectBase: rt.PhpObjectBase{}
		schema_path:   rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blueprint_importschema() &Class_Automattic_WooCommerce_Blueprint_ImportSchema {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ImportSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_cli_wp_cli() &Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Cli_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_resultformatters_cliresultformatter() &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema_path' { return this.schema_path }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema_path' {
			this.schema_path = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ImportSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_cli_importcli_php() {
}

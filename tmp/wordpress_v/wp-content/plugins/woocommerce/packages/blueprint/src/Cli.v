import rt

struct Class_Automattic_WooCommerce_Blueprint_Cli {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blueprint_Cli.register_commands() {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_args := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_assoc_args := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		mut var_import :=
			create_automattic_woocommerce_blueprint_cli_importcli(var_args.array_get(0))
		rt.call_method(var_import, 'run', [var_assoc_args.dup()])
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blueprint_WP_CLI{}
		return temp.add_command(arg_0, arg_1, arg_2)
	}(rt.new_string('wc blueprint import'), rt.new_closure(closure_1_fn), rt.create_array([
		rt.ArrayItem{ key: 'synopsis', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'positional' },
				rt.ArrayItem{ key: 'name', val: 'schema-path' },
				rt.ArrayItem{ key: 'optional', val: false },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'assoc' },
				rt.ArrayItem{ key: 'name', val: 'show-messages' },
				rt.ArrayItem{ key: 'optional', val: true },
				rt.ArrayItem{ key: 'options', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'all' },
					rt.ArrayItem{ key: none, val: 'error' },
					rt.ArrayItem{ key: none, val: 'info' },
					rt.ArrayItem{ key: none, val: 'debug' },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'when', val: 'after_wp_load' },
	]))
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_args := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_assoc_args := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		mut var_export :=
			create_automattic_woocommerce_blueprint_cli_exportcli(var_args.array_get(0))
		mut var_steps := rt.new_array()
		if var_assoc_args.array_isset(rt.new_string('steps')) {
			closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_step := if args.len > 0 { args[0].dup() } else { rt.new_null() }
					return rt.new_string(var_step.dup().to_string().trim_space())
				}
				mut var_step := if args.len > 0 { args[0].dup() } else { rt.new_null() }
				return rt.new_string(var_step.dup().to_string().trim_space())
			}
			var_steps = rt.call_function('array_map', [rt.new_closure(closure_3_fn),
				rt.call_function('explode', [rt.new_string(','),
					var_assoc_args.array_get('steps')])])
		}
		rt.call_method(var_export, 'run', [
			rt.create_array([rt.ArrayItem{ key: 'steps', val: var_steps },
				rt.ArrayItem{ key: 'format', val: 'json' }]),
		])
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blueprint_WP_CLI{}
		return temp.add_command(arg_0, arg_1, arg_2)
	}(rt.new_string('wc blueprint export'), rt.new_closure(closure_4_fn), rt.create_array([
		rt.ArrayItem{ key: 'synopsis', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'positional' },
				rt.ArrayItem{ key: 'name', val: 'save-to' },
				rt.ArrayItem{ key: 'optional', val: false },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'assoc' },
				rt.ArrayItem{ key: 'name', val: 'steps' },
				rt.ArrayItem{ key: 'optional', val: true },
			]) },
		]) },
		rt.ArrayItem{ key: 'when', val: 'after_wp_load' },
	]))
}

struct Class_Automattic_WooCommerce_Blueprint_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_cli() &Class_Automattic_WooCommerce_Blueprint_Cli {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Cli{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_wp_cli() &Class_Automattic_WooCommerce_Blueprint_WP_CLI {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_cli_importcli() &Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_cli_exportcli() &Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_commands' {
			Class_Automattic_WooCommerce_Blueprint_Cli.register_commands()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Cli) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ImportCli) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Cli_ExportCli) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_cli_php() {
	mut var_autoload_path := rt.new_string(@DIR + '/../vendor/autoload.php')
	if rt.is_true(rt.call_function('file_exists', [var_autoload_path.dup()])) {
		rt.include_file(var_autoload_path.to_string(), '4')
	}
}

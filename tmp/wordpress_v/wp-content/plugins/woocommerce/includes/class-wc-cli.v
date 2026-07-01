import rt

struct Class_WC_CLI {
	rt.PhpObjectBase
}

fn (mut this Class_WC_CLI) construct()  {
	this.includes()
	this.hooks()
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_CLI', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_blueprint_cli_hook' }])])
	mut var_wp_posts_importer := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Integrations_WPPostsImporter.class()])
	rt.call_method(var_wp_posts_importer, 'register', []rt.PhpVal{})
}

fn (mut this Class_WC_CLI) includes()  {
	rt.include_file(@DIR + '/cli/class-wc-cli-runner.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-rest-command.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-tool-command.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-update-command.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-tracker-command.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-com-command.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-com-extension-command.php', '4')
}

fn (mut this Class_WC_CLI) hooks()  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_hook(arg_0, arg_1) }(rt.new_string('after_wp_load'), rt.new_string('WC_CLI_Runner::after_wp_load'))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_hook(arg_0, arg_1) }(rt.new_string('after_wp_load'), rt.new_string('WC_CLI_Tool_Command::register_commands'))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_hook(arg_0, arg_1) }(rt.new_string('after_wp_load'), rt.new_string('WC_CLI_Update_Command::register_commands'))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_hook(arg_0, arg_1) }(rt.new_string('after_wp_load'), rt.new_string('WC_CLI_Tracker_Command::register_commands'))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_hook(arg_0, arg_1) }(rt.new_string('after_wp_load'), rt.new_string('WC_CLI_COM_Command::register_commands'))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_hook(arg_0, arg_1) }(rt.new_string('after_wp_load'), rt.new_string('WC_CLI_COM_Extension_Command::register_commands'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WOOCOMMERCE_MIGRATOR_ENABLED')])) && rt.is_true(rt.get_constant('WOOCOMMERCE_MIGRATOR_ENABLED')))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_hook(arg_0, arg_1) }(rt.new_string('after_wp_load'), rt.new_string('Automattic\\WooCommerce\\Internal\\CLI\\Migrator\\Runner::register_commands'))
	}
	mut var_cli_runner := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner.class()])
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_hook(arg_0, arg_1) }(rt.new_string('after_wp_load'), rt.create_array([rt.ArrayItem{ key: none, val: var_cli_runner }, rt.ArrayItem{ key: none, val: 'register_commands' }]))
	var_cli_runner = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner.class()])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc palt'), var_cli_runner.dup())
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_hook(arg_0, arg_1) }(rt.new_string('after_wp_load'), rt.new_closure(closure_1_fn))
}

fn (mut this Class_WC_CLI) add_blueprint_cli_hook()  {
	if rt.is_true(rt.new_bool(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('blueprint'))) && rt.is_true(rt.call_function('class_exists', [Class_Automattic_WooCommerce_Blueprint_Cli.class()])))) {
		rt.include_file((rt.call_function('dirname', [rt.get_constant('WC_PLUGIN_FILE')])).str() + '/packages/blueprint/src/Cli.php', '4')
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_hook(arg_0, arg_1) }(rt.new_string('after_wp_load'), rt.new_string('Automattic\\WooCommerce\\Blueprint\\Cli::register_commands'))
	}
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_wc_cli() &Class_WC_CLI {
	mut obj := &Class_WC_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'includes' {
			this.includes()
			return rt.new_null()
		}
		'hooks' {
			this.hooks()
			return rt.new_null()
		}
		'add_blueprint_cli_hook' {
			this.add_blueprint_cli_hook()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_cli_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	create_wc_cli()
}

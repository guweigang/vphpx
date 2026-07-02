import rt

struct Class_WC_CLI {
	rt.PhpObjectBase
}

fn (mut this Class_WC_CLI) construct() {
	this.includes()
	this.hooks()
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_CLI', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_blueprint_cli_hook' },
		])])
	mut var_wp_posts_importer := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Integrations_WPPostsImporter.class(),
	])
	rt.call_method(var_wp_posts_importer, 'register', []rt.PhpVal{})
}

fn (mut this Class_WC_CLI) includes() {
	rt.include_file(@DIR + '/cli/class-wc-cli-runner.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-rest-command.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-tool-command.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-update-command.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-tracker-command.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-com-command.php', '4')
	rt.include_file(@DIR + '/cli/class-wc-cli-com-extension-command.php', '4')
}

fn (mut this Class_WC_CLI) hooks() {
	mut iife_temp_0 := Class_WP_CLI{}
	mut iife_result_0 := iife_temp_0.add_hook(rt.new_string('after_wp_load'),
		rt.new_string('WC_CLI_Runner::after_wp_load'))
	mut iife_temp_1 := Class_WP_CLI{}
	mut iife_result_1 := iife_temp_1.add_hook(rt.new_string('after_wp_load'),
		rt.new_string('WC_CLI_Tool_Command::register_commands'))
	mut iife_temp_2 := Class_WP_CLI{}
	mut iife_result_2 := iife_temp_2.add_hook(rt.new_string('after_wp_load'),
		rt.new_string('WC_CLI_Update_Command::register_commands'))
	mut iife_temp_3 := Class_WP_CLI{}
	mut iife_result_3 := iife_temp_3.add_hook(rt.new_string('after_wp_load'),
		rt.new_string('WC_CLI_Tracker_Command::register_commands'))
	mut iife_temp_4 := Class_WP_CLI{}
	mut iife_result_4 := iife_temp_4.add_hook(rt.new_string('after_wp_load'),
		rt.new_string('WC_CLI_COM_Command::register_commands'))
	mut iife_temp_5 := Class_WP_CLI{}
	mut iife_result_5 := iife_temp_5.add_hook(rt.new_string('after_wp_load'),
		rt.new_string('WC_CLI_COM_Extension_Command::register_commands'))
	if rt.is_true(rt.call_function('defined', [rt.new_string('WOOCOMMERCE_MIGRATOR_ENABLED')]))
		&& rt.is_true(rt.get_constant('WOOCOMMERCE_MIGRATOR_ENABLED')) {
		mut iife_temp_6 := Class_WP_CLI{}
		mut iife_result_6 := iife_temp_6.add_hook(rt.new_string('after_wp_load'),
			rt.new_string('Automattic\\WooCommerce\\Internal\\CLI\\Migrator\\Runner::register_commands'))
	}
	mut var_cli_runner := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner.class(),
	])
	mut iife_temp_7 := Class_WP_CLI{}
	mut iife_result_7 := iife_temp_7.add_hook(rt.new_string('after_wp_load'), rt.create_array([
		rt.ArrayItem{ key: none, val: var_cli_runner },
		rt.ArrayItem{ key: none, val: 'register_commands' },
	]))
	var_cli_runner = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner.class(),
	])
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_9 := Class_WP_CLI{}
		mut iife_result_9 := iife_temp_9.add_command(rt.new_string('wc palt'),
			var_cli_runner.clone())
		return iife_result_9
	}
	mut iife_temp_10 := Class_WP_CLI{}
	mut iife_result_10 := iife_temp_10.add_hook(rt.new_string('after_wp_load'),
		rt.new_closure(closure_10_fn))
}

fn (mut this Class_WC_CLI) add_blueprint_cli_hook() {
	mut iife_temp_11 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_11 := iife_temp_11.feature_is_enabled(rt.new_string('blueprint'))
	if rt.is_true(iife_result_11)
		&& rt.is_true(rt.call_function('class_exists', [Class_Automattic_WooCommerce_Blueprint_Cli.class()])) {
		rt.include_file((rt.call_function('dirname', [rt.get_constant('WC_PLUGIN_FILE')])).str() +
			'/packages/blueprint/src/Cli.php', '4')
		mut iife_temp_12 := Class_WP_CLI{}
		mut iife_result_12 := iife_temp_12.add_hook(rt.new_string('after_wp_load'),
			rt.new_string('Automattic\\WooCommerce\\Blueprint\\Cli::register_commands'))
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

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
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
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	create_wc_cli()
}

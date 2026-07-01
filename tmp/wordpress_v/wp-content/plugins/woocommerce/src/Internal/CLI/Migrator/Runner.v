import rt

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Runner {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Runner.register_commands() {
	Class_Automattic_WooCommerce_Internal_CLI_Migrator_Runner.init_platforms()
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_CLI{}
		return temp.add_command(arg_0, arg_1, arg_2)
	}(rt.new_string('wc migrate products'), rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ProductsCommand.class(),
	]), rt.create_array([
		rt.ArrayItem{
			key: 'shortdesc'
			val: 'Migrate products from a source platform to WooCommerce.'
		},
		rt.ArrayItem{
			key: 'longdesc'
			val: 'Migrate products from a source platform to WooCommerce. The migrator will fetch products from the source platform, map them to the WooCommerce product schema, and then import them into WooCommerce.'
		},
	]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_CLI{}
		return temp.add_command(arg_0, arg_1, arg_2)
	}(rt.new_string('wc migrate reset'), rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ResetCommand.class(),
	]), rt.create_array([
		rt.ArrayItem{
			key: 'shortdesc'
			val: 'Resets (deletes) the credentials for a given platform.'
		},
	]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_CLI{}
		return temp.add_command(arg_0, arg_1, arg_2)
	}(rt.new_string('wc migrate setup'), rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_SetupCommand.class(),
	]), rt.create_array([
		rt.ArrayItem{
			key: 'shortdesc'
			val: 'Interactively sets up the credentials for a given platform.'
		},
	]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_CLI{}
		return temp.add_command(arg_0, arg_1, arg_2)
	}(rt.new_string('wc migrate list'), rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ListCommand.class(),
	]), rt.create_array([
		rt.ArrayItem{ key: 'shortdesc', val: 'Lists all registered migration platforms.' },
	]))
}

fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Runner.init_platforms() {
	fn () rt.PhpVal {
		mut temp :=
			Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform{}
		return temp.init()
	}()
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_runner() &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Runner {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Runner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_shopifyplatform() &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Runner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_commands' {
			Class_Automattic_WooCommerce_Internal_CLI_Migrator_Runner.register_commands()
			return rt.new_null()
		}
		'init_platforms' {
			Class_Automattic_WooCommerce_Internal_CLI_Migrator_Runner.init_platforms()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Runner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Runner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_cli_migrator_runner_php() {
	// unsupported statement: Stmt_Declare
}

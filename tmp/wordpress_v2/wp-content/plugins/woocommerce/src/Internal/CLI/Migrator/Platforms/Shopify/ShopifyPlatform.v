import rt

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform.init() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_migrator_platforms'),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform.class()
			},
			rt.ArrayItem{ key: none, val: 'register_platform' },
		])])
}

fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform.register_platform(mut var_platforms Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) rt.PhpVal {
	mut var_platforms_mutated := var_platforms
	var_platforms_mutated.array_set('shopify', rt.create_array([
		rt.ArrayItem{ key: 'name', val: 'Shopify' },
		rt.ArrayItem{ key: 'description', val: 'Import products and data from Shopify stores' },
		rt.ArrayItem{
			key: 'fetcher'
			val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher.class()
		},
		rt.ArrayItem{
			key: 'mapper'
			val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper.class()
		},
		rt.ArrayItem{ key: 'credentials', val: rt.create_array([
			rt.ArrayItem{ key: 'shop_url', val: 'Enter shop URL (e.g., mystore.myshopify.com):' },
			rt.ArrayItem{ key: 'access_token', val: 'Enter access token:' },
		]) },
	]))
	return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array',
		[]string{}, var_platforms_mutated)
}

fn create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_shopifyplatform(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform.init()
			return rt.new_null()
		}
		'register_platform' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform.register_platform(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyPlatform) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

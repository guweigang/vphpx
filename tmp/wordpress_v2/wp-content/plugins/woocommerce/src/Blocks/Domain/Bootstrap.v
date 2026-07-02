import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap {
	rt.PhpObjectBase
pub mut:
	container rt.PhpVal = rt.new_null()
	package   rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) construct(mut var_container Class_Automattic_WooCommerce_Blocks_Registry_Container) {
	this.container = var_container
	this.package = var_container.get(Class_Automattic_WooCommerce_Blocks_Domain_Package.class())
	this.init()
	rt.call_function('do_action', [rt.new_string('woocommerce_blocks_loaded')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) init() {
	this.register_dependencies()
	this.register_payment_methods()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_InboxNotifications{}
		mut iife_result_1 := iife_temp_1.delete_surface_cart_checkout_blocks_notification()
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_closure(closure_2_fn), rt.new_int(10), rt.new_int(0)])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_is_store_api_request := rt.call_method(rt.call_function('wc', []rt.PhpVal{}),
			'is_store_api_request', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_store_api_request))))
			&& rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-template-parts')])) {
			rt.call_method(rt.call_method(this.container, 'get', [
				Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry.class(),
			]), 'init', []rt.PhpVal{})
			rt.call_method(rt.call_method(this.container, 'get', [
				Class_Automattic_WooCommerce_Blocks_BlockTemplatesController.class(),
			]), 'init', []rt.PhpVal{})
		}
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('after_setup_theme'),
		rt.new_closure(closure_3_fn), rt.new_int(999)])
	mut var_is_rest := rt.call_method(rt.call_function('wc', []rt.PhpVal{}), 'is_rest_api_request',
		[]rt.PhpVal{})
	mut var_is_store_api_request := rt.call_method(rt.call_function('wc', []rt.PhpVal{}),
		'is_store_api_request', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.call_method(rt.call_method(this.container, 'get', [
			Class_Automattic_WooCommerce_StoreApi_StoreApi.class(),
		]), 'init', []rt.PhpVal{})
	}
	rt.call_method(rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Blocks_Payments_Api.class(),
	]), 'init', []rt.PhpVal{})
	rt.call_method(rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.class(),
	]), 'init', []rt.PhpVal{})
	rt.call_method(rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController.class(),
	]), 'init', []rt.PhpVal{})
	rt.call_method(rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
	]), 'init', []rt.PhpVal{})
	rt.call_method(rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink.class(),
	]), 'init', []rt.PhpVal{})
	rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry.class(),
	])
	rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Blocks_AssetsController.class(),
	])
	rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Blocks_DependencyDetection.class(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_rest)))) {
		this.add_build_notice()
		rt.call_method(rt.call_method(this.container, 'get', [
			Class_Automattic_WooCommerce_Blocks_Installer.class(),
		]), 'init', []rt.PhpVal{})
		rt.call_method(rt.call_method(this.container, 'get', [
			Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics.class(),
		]), 'init', []rt.PhpVal{})
		rt.call_method(rt.call_method(this.container, 'get', [if rt.is_true(rt.call_function('is_admin',
			[]rt.PhpVal{}))
		{
			Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin.class()
		} else {
			Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend.class()
		}]), 'init', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_store_api_request)))) {
		rt.call_method(this.container, 'get', [
			Class_Automattic_WooCommerce_Blocks_BlockPatterns.class(),
		])
		rt.call_method(this.container, 'get', [
			Class_Automattic_WooCommerce_Blocks_BlockTypesController.class(),
		])
		rt.call_method(this.container, 'get', [
			Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility.class(),
		])
		rt.call_method(rt.call_method(this.container, 'get', [
			Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices.class(),
		]), 'init', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(var_is_rest) {
			rt.call_method(this.container, 'get', [
				Class_Automattic_WooCommerce_Blocks_Patterns_AIPatterns.class(),
			])
			rt.call_method(this.container, 'get', [
				Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.class(),
			])
		}
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			rt.call_method(rt.call_method(this.container, 'get', [
				Class_Automattic_WooCommerce_Blocks_TemplateOptions.class(),
			]), 'init', []rt.PhpVal{})
		}
	}
	rt.call_method(rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Blocks_QueryFilters.class(),
	]), 'init', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) is_built() rt.PhpVal {
	return rt.call_function('file_exists', [
		rt.call_method(this.package, 'get_path', [
			rt.new_string('assets/client/blocks/featured-product.js'),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) add_build_notice() {
	if rt.is_true(this.is_built()) {
		return
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		print('<div class="error"><p>')
		rt.call_function('printf', [
			rt.call_function('esc_html__', [
				rt.new_string('WooCommerce Blocks development mode requires files to be built. From the root directory, run %1$s to ensure your node version is aligned, run %2$s to install dependencies, %3$s to build the files or %4$s to build the files and watch for changes.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<code>nvm use</code>'),
			rt.new_string('<code>pnpm install</code>'),
			rt.new_string('<code>pnpm --filter="@woocommerce/plugin-woocommerce" build</code>'),
			rt.new_string('<code>pnpm --filter="@woocommerce/plugin-woocommerce" watch:build</code>'),
		])
		print('</p></div>')
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.new_closure(closure_4_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) register_dependencies() {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Assets_Api.class(),
		rt.new_closure(closure_5_fn),
	])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry.class(),
		rt.new_closure(closure_6_fn),
	])
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_AssetsController.class(),
		rt.new_closure(closure_7_fn),
	])
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_DependencyDetection.class(),
		rt.new_closure(closure_8_fn),
	])
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry.class(),
		rt.new_closure(closure_9_fn),
	])
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Installer.class(),
		rt.new_closure(closure_10_fn),
	])
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_asset_api :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_Api.class())
		mut var_asset_data_registry :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry.class())
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_BlockTypesController.class(),
		rt.new_closure(closure_11_fn),
	])
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_asset_data_registry :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry.class())
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility.class(),
		rt.new_closure(closure_12_fn),
	])
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.class(),
		rt.new_closure(closure_13_fn),
	])
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_asset_api :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_Api.class())
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics.class(),
		rt.new_closure(closure_14_fn),
	])
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices.class(),
		rt.new_closure(closure_15_fn),
	])
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration.class(),
		rt.new_closure(closure_16_fn),
	])
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
		rt.new_closure(closure_17_fn),
	])
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_checkout_fields_controller :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class())
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin.class(),
		rt.new_closure(closure_18_fn),
	])
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_checkout_fields_controller :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class())
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend.class(),
		rt.new_closure(closure_19_fn),
	])
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_payment_method_registry :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry.class())
		mut var_asset_data_registry :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry.class())
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Payments_Api.class(),
		rt.new_closure(closure_20_fn),
	])
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink.class(),
		rt.new_closure(closure_21_fn),
	])
	closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_StoreApi_StoreApi.class(),
		rt.new_closure(closure_22_fn),
	])
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_TemplateOptions.class(),
		rt.new_closure(closure_23_fn),
	])
	closure_24_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.deprecated_dependency(rt.new_string('Automattic\\WooCommerce\\Blocks\\StoreApi\\Formatters'),
			rt.new_string('6.4.0'), 'Automattic\\WooCommerce\\StoreApi\\Formatters', '6.5.0')
		return
	}
	rt.call_method(this.container, 'register', [
		rt.new_string('Automattic\\WooCommerce\\Blocks\\StoreApi\\Formatters'),
		rt.new_closure(closure_24_fn),
	])
	closure_25_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.deprecated_dependency(rt.new_string('Automattic\\WooCommerce\\Blocks\\Domain\\Services\\ExtendRestApi'),
			rt.new_string('6.4.0'), 'Automattic\\WooCommerce\\StoreApi\\Schemas\\ExtendSchema',
			'6.5.0')
		return
	}
	rt.call_method(this.container, 'register', [
		rt.new_string('Automattic\\WooCommerce\\Blocks\\Domain\\Services\\ExtendRestApi'),
		rt.new_closure(closure_25_fn),
	])
	closure_26_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.deprecated_dependency(rt.new_string('Automattic\\WooCommerce\\Blocks\\StoreApi\\SchemaController'),
			rt.new_string('6.4.0'), 'Automattic\\WooCommerce\\StoreApi\\SchemaController', '6.5.0')
		return
	}
	rt.call_method(this.container, 'register', [
		rt.new_string('Automattic\\WooCommerce\\Blocks\\StoreApi\\SchemaController'),
		rt.new_closure(closure_26_fn),
	])
	closure_27_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.deprecated_dependency(rt.new_string('Automattic\\WooCommerce\\Blocks\\StoreApi\\RoutesController'),
			rt.new_string('6.4.0'), 'Automattic\\WooCommerce\\StoreApi\\RoutesController', '6.5.0')
		return
	}
	rt.call_method(this.container, 'register', [
		rt.new_string('Automattic\\WooCommerce\\Blocks\\StoreApi\\RoutesController'),
		rt.new_closure(closure_27_fn),
	])
	closure_28_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient.class(),
		rt.new_closure(closure_28_fn),
	])
	closure_29_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.class(),
		rt.new_closure(closure_29_fn),
	])
	closure_30_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_BlockPatterns.class(),
		rt.new_closure(closure_30_fn),
	])
	closure_31_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Patterns_AIPatterns.class(),
		rt.new_closure(closure_31_fn),
	])
	closure_32_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_asset_api :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_Api.class())
		mut var_asset_data_registry :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry.class())
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController.class(),
		rt.new_closure(closure_32_fn),
	])
	closure_33_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_QueryFilters.class(),
		rt.new_closure(closure_33_fn),
	])
	closure_34_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry.class(),
		rt.new_closure(closure_34_fn),
	])
	closure_35_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_BlockTemplatesController.class(),
		rt.new_closure(closure_35_fn),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) deprecated_dependency(var_function rt.PhpVal, var_version rt.PhpVal, replacement string, trigger_error_version string) {
	mut trigger_error_version_mutated := trigger_error_version
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) {
		return
	}
	trigger_error_version_mutated = (if rt.is_true(rt.new_string(trigger_error_version_mutated)) {
		rt.new_string(trigger_error_version_mutated)
	} else {
		var_version
	}).str()
	mut var_error_message := if var_replacement.len > 0 && var_replacement != '0' { rt.call_function('sprintf', [
			rt.new_string('%1$s is <strong>deprecated</strong> since version %2$s! Use %3$s instead.'),
			var_function.clone(),
			var_version.clone(),
			rt.new_string(replacement),
		]) } else { rt.call_function('sprintf', [
			rt.new_string('%1$s is <strong>deprecated</strong> since version %2$s with no alternative available.'),
			var_function.clone(),
			var_version.clone(),
		]) }
	rt.call_function('do_action', [rt.new_string('deprecated_function_run'),
		var_function.clone(), rt.new_string(replacement), var_version.clone()])
	mut var_log_error := rt.new_bool(false)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		var_log_error = rt.new_bool(true)
	}
	mut iife_temp_35 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_35 := iife_temp_35.get_constant(rt.new_string('WC_VERSION'))
	mut iife_temp_36 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_36 := iife_temp_36.get_constant(rt.new_string('WC_VERSION'))
	if rt.is_true(rt.call_function('version_compare', [iife_result_35, rt.new_string(trigger_error_version_mutated).clone(),
		rt.new_string('<')]))
	{
		var_log_error = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('deprecated_function_trigger_error'),
		rt.new_bool(true),
	])))))
	{
		var_log_error = rt.new_bool(true)
	}
	if rt.is_true(var_log_error) {
		rt.call_function('error_log', [var_error_message.clone()])
	} else {
		rt.call_function('trigger_error', [var_error_message.clone(),
			rt.get_constant('E_USER_DEPRECATED')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) register_payment_methods() {
	closure_38_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_asset_api :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_Api.class())
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque.class(),
		rt.new_closure(closure_38_fn),
	])
	closure_39_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_asset_api :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_Api.class())
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal.class(),
		rt.new_closure(closure_39_fn),
	])
	closure_40_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_asset_api :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_Api.class())
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Payments_Integrations_BankTransfer.class(),
		rt.new_closure(closure_40_fn),
	])
	closure_41_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_asset_api :=
			var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_Api.class())
		return
	}
	rt.call_method(this.container, 'register', [
		Class_Automattic_WooCommerce_Blocks_Payments_Integrations_CashOnDelivery.class(),
		rt.new_closure(closure_41_fn),
	])
}

struct Class_Automattic_WooCommerce_Blocks_InboxNotifications {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Assets_Api {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_AssetsController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_DependencyDetection {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Installer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypesController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Payments_Api {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_StoreApi {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_TemplateOptions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockPatterns {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Patterns_AIPatterns {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_QueryFilters {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTemplatesController {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Payments_Integrations_BankTransfer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Payments_Integrations_CashOnDelivery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_domain_bootstrap(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap{
		PhpObjectBase: rt.PhpObjectBase{}
		container:     rt.new_null()
		package:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blocks_inboxnotifications(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_InboxNotifications {
	mut obj := &Class_Automattic_WooCommerce_Blocks_InboxNotifications{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_assets_api(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Assets_Api {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Assets_Api{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_assets_assetdataregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_assetscontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_AssetsController {
	mut obj := &Class_Automattic_WooCommerce_Blocks_AssetsController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_dependencydetection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_DependencyDetection {
	mut obj := &Class_Automattic_WooCommerce_Blocks_DependencyDetection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_payments_paymentmethodregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_installer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Installer {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Installer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypescontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypesController {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypesController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_classictemplatescompatibility(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_draftorders(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_googleanalytics(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_notices(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_hydration(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfields(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfieldsadmin(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfieldsfrontend(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_payments_api(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Payments_Api {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_Api{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutlink(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_storeapi(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_StoreApi {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_StoreApi{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templateoptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_TemplateOptions {
	mut obj := &Class_Automattic_WooCommerce_Blocks_TemplateOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_patterns_ptkclient(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_patterns_ptkpatternsstore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blockpatterns(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockPatterns {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockPatterns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_patterns_patternregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_patterns_aipatterns(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Patterns_AIPatterns {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Patterns_AIPatterns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_shipping_shippingcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_queryfilters(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_QueryFilters {
	mut obj := &Class_Automattic_WooCommerce_Blocks_QueryFilters{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktemplatesregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktemplatescontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTemplatesController {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTemplatesController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_payments_integrations_cheque(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_payments_integrations_paypal(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_payments_integrations_banktransfer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_BankTransfer {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_BankTransfer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_payments_integrations_cashondelivery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_CashOnDelivery {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_CashOnDelivery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Registry_Container](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'is_built' {
			return this.is_built()
		}
		'add_build_notice' {
			this.add_build_notice()
			return rt.new_null()
		}
		'register_dependencies' {
			this.register_dependencies()
			return rt.new_null()
		}
		'deprecated_dependency' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.deprecated_dependency(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
			return rt.new_null()
		}
		'register_payment_methods' {
			this.register_payment_methods()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'container' { return this.container }
		'package' { return this.package }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'container' {
			this.container = val
			return true
		}
		'package' {
			this.package = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_InboxNotifications) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_InboxNotifications) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_InboxNotifications) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Assets_Api) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_AssetsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_DependencyDetection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Installer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Installer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Installer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypesController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Api) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_Api) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Api) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_TemplateOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_TemplateOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_TemplateOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockPatterns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_AIPatterns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Patterns_AIPatterns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_AIPatterns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_QueryFilters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_BankTransfer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_BankTransfer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_BankTransfer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_CashOnDelivery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_CashOnDelivery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_CashOnDelivery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap {
	rt.PhpObjectBase
pub mut:
		container rt.PhpVal = rt.new_null()
		package rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) construct(mut var_container Class_Automattic_WooCommerce_Blocks_Registry_Container)  {
	this.container = var_container.dup()
	this.package = var_container.get(Class_Automattic_WooCommerce_Blocks_Domain_Package.class())
	this.init()
	rt.call_function('do_action', [rt.new_string('woocommerce_blocks_loaded')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) init()  {
	this.register_dependencies()
	this.register_payment_methods()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_InboxNotifications{}; return temp.delete_surface_cart_checkout_blocks_notification() }()
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.new_closure(closure_1_fn), rt.new_int(10), rt.new_int(0)])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_is_store_api_request := rt.call_method(rt.call_function('wc', []rt.PhpVal{}), 'is_store_api_request', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_store_api_request)))) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-template-parts')])))))) {
		rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry.class()]), 'init', []rt.PhpVal{})
		rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_BlockTemplatesController.class()]), 'init', []rt.PhpVal{})
	}
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('after_setup_theme'), rt.new_closure(closure_2_fn), rt.new_int(999)])
	mut var_is_rest := rt.call_method(rt.call_function('wc', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})
	mut var_is_store_api_request := rt.call_method(rt.call_function('wc', []rt.PhpVal{}), 'is_store_api_request', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_StoreApi_StoreApi.class()]), 'init', []rt.PhpVal{})
	}
	rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Payments_Api.class()]), 'init', []rt.PhpVal{})
	rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.class()]), 'init', []rt.PhpVal{})
	rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController.class()]), 'init', []rt.PhpVal{})
	rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class()]), 'init', []rt.PhpVal{})
	rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink.class()]), 'init', []rt.PhpVal{})
	rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry.class()])
	rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_AssetsController.class()])
	rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_DependencyDetection.class()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_rest)))) {
		this.add_build_notice()
		rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Installer.class()]), 'init', []rt.PhpVal{})
		rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics.class()]), 'init', []rt.PhpVal{})
		rt.call_method(rt.call_method(this.container, 'get', [if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) { Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin.class() } else { Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend.class() }]), 'init', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_store_api_request)))) {
		rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_BlockPatterns.class()])
		rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_BlockTypesController.class()])
		rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility.class()])
		rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices.class()]), 'init', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(var_is_rest))) {
			rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Patterns_AIPatterns.class()])
			rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.class()])
		}
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_TemplateOptions.class()]), 'init', []rt.PhpVal{})
		}
	}
	rt.call_method(rt.call_method(this.container, 'get', [Class_Automattic_WooCommerce_Blocks_QueryFilters.class()]), 'init', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) is_built() rt.PhpVal {
	return rt.call_function('file_exists', [rt.call_method(this.package, 'get_path', [rt.new_string('assets/client/blocks/featured-product.js')])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) add_build_notice()  {
	if rt.is_true(this.is_built()) {
		return rt.new_null()
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	print('<div class="error"><p>')
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('WooCommerce Blocks development mode requires files to be built. From the root directory, run %1$s to ensure your node version is aligned, run %2$s to install dependencies, %3$s to build the files or %4$s to build the files and watch for changes.'), rt.new_string('woocommerce')]), rt.new_string('<code>nvm use</code>'), rt.new_string('<code>pnpm install</code>'), rt.new_string('<code>pnpm --filter="@woocommerce/plugin-woocommerce" build</code>'), rt.new_string('<code>pnpm --filter="@woocommerce/plugin-woocommerce" watch:build</code>')])
	print('</p></div>')
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.new_closure(closure_3_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) register_dependencies()  {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_container := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return create_automattic_woocommerce_blocks_assets_api(var_container.get(Class_Automattic_WooCommerce_Blocks_Domain_Package.class()))
	}
	rt.call_method(this.container, 'register', [Class_Automattic_WooCommerce_Blocks_Assets_Api.class(), rt.new_closure(closure_4_fn)])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_container := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return create_automattic_woocommerce_blocks_assets_assetdataregistry(var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_Api.class()))
	}
	rt.call_method(this.container, 'register', [Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry.class(), rt.new_closure(closure_5_fn)])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_container := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return create_automattic_woocommerce_blocks_assetscontroller(var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_Api.class()))
	}
	rt.call_method(this.container, 'register', [Class_Automattic_WooCommerce_Blocks_AssetsController.class(), rt.new_closure(closure_6_fn)])
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return create_automattic_woocommerce_blocks_dependencydetection()
	}
	rt.call_method(this.container, 'register', [Class_Automattic_WooCommerce_Blocks_DependencyDetection.class(), rt.new_closure(closure_7_fn)])
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return create_automattic_woocommerce_blocks_payments_paymentmethodregistry()
	}
	rt.call_method(this.container, 'register', [Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry.class(), rt.new_closure(closure_8_fn)])
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return create_automattic_woocommerce_blocks_installer()
	}
	rt.call_method(this.container, 'register', [Class_Automattic_WooCommerce_Blocks_Installer.class(), rt.new_closure(closure_9_fn)])
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_container := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_asset_api := var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_Api.class())
	mut var_asset_data_registry := var_container.get(Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry.class())
	return create_automattic_woocommerce_blocks_blocktypescontroller(var_asset_api.dup(), var_asset_data_registry.dup())
	}
	rt.call_method(this.container, 'register', [Class_Automattic_WooCommerce_Blocks_BlockTypesController.class(), rt.new_closure(closure_10_fn)])
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_container := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	
	}
	rt.call_method(this.container, 'register', [Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility.class(), rt.new_closure(closure_11_fn)])
	rt.call_method(, 'register', [, ])
	
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) deprecated_dependency(var_function rt.PhpVal, var_version rt.PhpVal, replacement string, trigger_error_version string)  {
	mut trigger_error_version_mutated := trigger_error_version
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) register_payment_methods()  {
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

fn create_automattic_woocommerce_blocks_domain_bootstrap(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap{
		PhpObjectBase: rt.PhpObjectBase{}
		container: rt.new_null()
		package: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blocks_inboxnotifications() &Class_Automattic_WooCommerce_Blocks_InboxNotifications {
	mut obj := &Class_Automattic_WooCommerce_Blocks_InboxNotifications{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_assets_api() &Class_Automattic_WooCommerce_Blocks_Assets_Api {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Assets_Api{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_assets_assetdataregistry() &Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_assetscontroller() &Class_Automattic_WooCommerce_Blocks_AssetsController {
	mut obj := &Class_Automattic_WooCommerce_Blocks_AssetsController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_dependencydetection() &Class_Automattic_WooCommerce_Blocks_DependencyDetection {
	mut obj := &Class_Automattic_WooCommerce_Blocks_DependencyDetection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_payments_paymentmethodregistry() &Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_installer() &Class_Automattic_WooCommerce_Blocks_Installer {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Installer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypescontroller() &Class_Automattic_WooCommerce_Blocks_BlockTypesController {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypesController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Registry_Container](if args.len > 0 { args[0] } else { rt.new_null() })
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
			this.deprecated_dependency(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'register_payment_methods' {
			this.register_payment_methods()
			return rt.new_null()
		}
		else { return none }
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
		'container' { this.container = val; return true }
		'package' { this.package = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_domain_bootstrap_php() {
}

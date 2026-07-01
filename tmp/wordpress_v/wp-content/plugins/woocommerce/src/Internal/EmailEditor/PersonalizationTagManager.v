import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTagManager {
	rt.PhpObjectBase
pub mut:
		customer_tags_provider rt.PhpVal = rt.new_null()
		order_tags_provider rt.PhpVal = rt.new_null()
		site_tags_provider rt.PhpVal = rt.new_null()
		store_tags_provider rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTagManager) construct()  {
	this.customer_tags_provider = create_automattic_woocommerce_internal_emaileditor_personalizationtags_customertagsprovider()
	this.order_tags_provider = create_automattic_woocommerce_internal_emaileditor_personalizationtags_ordertagsprovider()
	this.site_tags_provider = create_automattic_woocommerce_internal_emaileditor_personalizationtags_sitetagsprovider()
	this.store_tags_provider = create_automattic_woocommerce_internal_emaileditor_personalizationtags_storetagsprovider()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTagManager) init()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_editor_register_personalization_tags'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTagManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_personalization_tags' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTagManager) register_personalization_tags(mut var_registry Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) rt.PhpVal {
	rt.call_method(this.customer_tags_provider, 'register_tags', [var_registry])
	rt.call_method(this.order_tags_provider, 'register_tags', [var_registry])
	rt.call_method(this.site_tags_provider, 'register_tags', [var_registry])
	rt.call_method(this.store_tags_provider, 'register_tags', [var_registry])
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry', []string{}, var_registry)
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_personalizationtagmanager() &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTagManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTagManager{
		PhpObjectBase: rt.PhpObjectBase{}
		customer_tags_provider: rt.new_null()
		order_tags_provider: rt.new_null()
		site_tags_provider: rt.new_null()
		store_tags_provider: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_personalizationtags_customertagsprovider() &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_personalizationtags_ordertagsprovider() &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_personalizationtags_sitetagsprovider() &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_personalizationtags_storetagsprovider() &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTagManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'register_personalization_tags' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.register_personalization_tags(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTagManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'customer_tags_provider' { return this.customer_tags_provider }
		'order_tags_provider' { return this.order_tags_provider }
		'site_tags_provider' { return this.site_tags_provider }
		'store_tags_provider' { return this.store_tags_provider }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTagManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'customer_tags_provider' { this.customer_tags_provider = val; return true }
		'order_tags_provider' { this.order_tags_provider = val; return true }
		'site_tags_provider' { this.site_tags_provider = val; return true }
		'store_tags_provider' { this.store_tags_provider = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_personalizationtagmanager_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

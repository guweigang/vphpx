import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider) register_tags(mut var_registry Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_wc_email := if !(var_context.array_get('wc_email')).is_null() {
			var_context.array_get('wc_email')
		} else {
			rt.new_null()
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_wc_email,
			'Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_WC_Email')))
		{
			return rt.call_method(var_wc_email, 'get_from_address', []rt.PhpVal{})
		}
		return rt.call_function('get_option', [rt.new_string('admin_email')])
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Store Email'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/store-email'), rt.call_function('__', [
		rt.new_string('Store'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_1_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.call_function('esc_attr', [
			rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
		])
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Store URL'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/store-url'), rt.call_function('__', [
		rt.new_string('Store'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_2_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		if var_context.array_isset(rt.new_string('wc_email'))
			&& !(!rt.is_true(rt.call_method(var_context.array_get('wc_email'), 'get_from_name', []rt.PhpVal{}))) {
			return rt.call_method(var_context.array_get('wc_email'), 'get_from_name', []rt.PhpVal{})
		}
		return rt.call_function('wp_specialchars_decode', [
			rt.call_function('get_bloginfo', [rt.new_string('name')]),
			rt.get_constant('ENT_QUOTES'),
		])
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Store Name'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/store-name'), rt.call_function('__', [
		rt.new_string('Store'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_3_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if !(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'mailer'),
			'get_store_address', []rt.PhpVal{})).is_null() {
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'mailer'),
				'get_store_address', []rt.PhpVal{})
		} else {
			rt.new_string('')
		}
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Store Address'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/store-address'), rt.call_function('__', [
		rt.new_string('Store'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_4_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.call_function('esc_attr', [
			rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')]),
		])
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('My Account URL'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/my-account-url'), rt.call_function('__', [
		rt.new_string('Store'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_5_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		if var_context.array_isset(rt.new_string('wc_email'))
			&& !(rt.get_property(var_context.array_get('wc_email'), 'customer_note')).is_null() {
			return rt.call_function('nl2br', [
				rt.call_function('wptexturize', [
					rt.get_property(var_context.array_get('wc_email'), 'customer_note'),
				]),
			])
		}
		return rt.new_string('')
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Admin Order Note'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/admin-order-note'), rt.call_function('__', [
		rt.new_string('Store'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_6_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_personalizationtags_storetagsprovider() &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_personalizationtags_abstracttagprovider() &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag() &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_tags' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register_tags(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_StoreTagsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_personalizationtags_storetagsprovider_php() {
	// unsupported statement: Stmt_Declare
}

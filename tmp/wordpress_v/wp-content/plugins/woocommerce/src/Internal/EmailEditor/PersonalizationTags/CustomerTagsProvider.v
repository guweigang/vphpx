import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider) register_tags(mut var_registry Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		if var_context.array_isset(rt.new_string('order')) {
			return if !(rt.call_method(var_context.array_get('order'), 'get_billing_email',
				[]rt.PhpVal{})).is_null() {
				rt.call_method(var_context.array_get('order'), 'get_billing_email', []rt.PhpVal{})
			} else {
				rt.new_string('')
			}
		}
		return if !(var_context.array_get('recipient_email')).is_null() {
			var_context.array_get('recipient_email')
		} else {
			rt.new_string('')
		}
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Customer Email'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/customer-email'), rt.call_function('__', [
		rt.new_string('Customer'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_1_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		if var_context.array_isset(rt.new_string('order')) {
			return if !(rt.call_method(var_context.array_get('order'), 'get_billing_first_name',
				[]rt.PhpVal{})).is_null() {
				rt.call_method(var_context.array_get('order'), 'get_billing_first_name',
					[]rt.PhpVal{})
			} else {
				rt.new_string('')
			}
		} else if var_context.array_isset(rt.new_string('wp_user')) {
			return if !(rt.get_property(var_context.array_get('wp_user'), 'first_name')).is_null() {
				rt.get_property(var_context.array_get('wp_user'), 'first_name')
			} else {
				rt.new_string('')
			}
		}
		return rt.new_string('')
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Customer First Name'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/customer-first-name'), rt.call_function('__', [
		rt.new_string('Customer'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_2_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		if var_context.array_isset(rt.new_string('order')) {
			return if !(rt.call_method(var_context.array_get('order'), 'get_billing_last_name',
				[]rt.PhpVal{})).is_null() {
				rt.call_method(var_context.array_get('order'), 'get_billing_last_name',
					[]rt.PhpVal{})
			} else {
				rt.new_string('')
			}
		} else if var_context.array_isset(rt.new_string('wp_user')) {
			return if !(rt.get_property(var_context.array_get('wp_user'), 'last_name')).is_null() {
				rt.get_property(var_context.array_get('wp_user'), 'last_name')
			} else {
				rt.new_string('')
			}
		}
		return rt.new_string('')
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Customer Last Name'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/customer-last-name'), rt.call_function('__', [
		rt.new_string('Customer'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_3_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		if var_context.array_isset(rt.new_string('order')) {
			return if !(rt.call_method(var_context.array_get('order'),
				'get_formatted_billing_full_name', []rt.PhpVal{})).is_null() {
				rt.call_method(var_context.array_get('order'), 'get_formatted_billing_full_name',
					[]rt.PhpVal{})
			} else {
				rt.new_string('')
			}
		} else if var_context.array_isset(rt.new_string('wp_user')) {
			mut var_first_name := if !(rt.get_property(var_context.array_get('wp_user'),
				'first_name')).is_null() {
				rt.get_property(var_context.array_get('wp_user'), 'first_name')
			} else {
				rt.new_string('')
			}
			mut var_last_name := if !(rt.get_property(var_context.array_get('wp_user'), 'last_name')).is_null() {
				rt.get_property(var_context.array_get('wp_user'), 'last_name')
			} else {
				rt.new_string('')
			}
			return rt.new_string('${var_first_name.to_string()} ${var_last_name.to_string()}'.trim_space())
		}
		return rt.new_string('')
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Customer Full Name'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/customer-full-name'), rt.call_function('__', [
		rt.new_string('Customer'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_4_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		if var_context.array_isset(rt.new_string('wp_user')) {
			return rt.call_function('stripslashes', [if !(rt.get_property(var_context.array_get('wp_user'),
				'user_login')).is_null() {
				rt.get_property(var_context.array_get('wp_user'), 'user_login')
			} else {
				rt.new_string('')
			}])
		}
		return rt.new_string('')
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Customer Username'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/customer-username'), rt.call_function('__', [
		rt.new_string('Customer'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_5_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		if var_context.array_isset(rt.new_string('order')) {
			mut var_country_code := rt.call_method(var_context.array_get('order'),
				'get_billing_country', []rt.PhpVal{})
			return if !(rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'countries'), 'countries').array_get(var_country_code)).is_null() {
				rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
					'countries').array_get(var_country_code)
			} else {
				if !var_country_code.is_null() {
					var_country_code
				} else {
					rt.new_string('')
				}
			}
		}
		return rt.new_string('')
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Customer Country'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/customer-country'), rt.call_function('__', [
		rt.new_string('Customer'),
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

fn create_automattic_woocommerce_internal_emaileditor_personalizationtags_customertagsprovider() &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider{
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

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_CustomerTagsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_personalizationtags_customertagsprovider_php() {
	// unsupported statement: Stmt_Declare
}

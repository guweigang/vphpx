import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_TransactionalEmailPersonalizer {
	rt.PhpObjectBase
pub mut:
	personalizer rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_TransactionalEmailPersonalizer) construct() {
	mut var_editor_container := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{}
		return temp.container()
	}()
	this.personalizer = rt.call_method(var_editor_container, 'get', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer.class(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_TransactionalEmailPersonalizer) personalize_transactional_content(content string, mut var_email Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email) string {
	this.configure_context_by_email(mut var_email)
	return (rt.call_method(this.personalizer, 'personalize_content', [
		rt.new_string(content),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_TransactionalEmailPersonalizer) configure_context_by_email(mut var_email Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email) {
	mut var_prepared_context := this.prepare_context_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](rt.call_method(this.personalizer,
		'get_context', []rt.PhpVal{})), mut var_email)
	rt.call_method(this.personalizer, 'set_context', [var_prepared_context.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_TransactionalEmailPersonalizer) prepare_context_data(mut var_previous_context Class_Automattic_WooCommerce_Internal_EmailEditor_array, mut var_email Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email) rt.PhpVal {
	mut var_context := var_previous_context
	var_context.array_set('recipient_email', var_email.get_recipient())
	var_context.array_set('order', if rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_email,
		'object'), 'Automattic_WooCommerce_Internal_EmailEditor_WC_Order')))
	{
		rt.get_property(var_email, 'object')
	} else {
		rt.new_null()
	})
	if rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_email, 'object'),
		'Automattic_WooCommerce_Internal_EmailEditor_WP_User')))
	{
		var_context.array_set('wp_user', rt.get_property(var_email, 'object'))
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_email, 'object'),
		'Automattic_WooCommerce_Internal_EmailEditor_WC_Order')))
	{
		var_context.array_set('wp_user', rt.call_method(rt.get_property(var_email, 'object'),
			'get_user', []rt.PhpVal{}))
	} else {
		var_context.array_set('wp_user', rt.new_null())
	}
	var_context.array_set('wc_email', var_email.dup())
	mut var_core_context := var_context.dup()
	var_context = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_integration_personalizer_context_data'),
		var_context.dup(),
		var_email,
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_context.dup().is_array()))))) {
		var_context = var_core_context.dup()
	}
	return var_context.dup()
}

struct Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_transactionalemailpersonalizer() &Class_Automattic_WooCommerce_Internal_EmailEditor_TransactionalEmailPersonalizer {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_TransactionalEmailPersonalizer{
		PhpObjectBase: rt.PhpObjectBase{}
		personalizer:  rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_emaileditor_email_editor_container() &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_TransactionalEmailPersonalizer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'personalize_transactional_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.personalize_transactional_content(dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'configure_context_by_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.configure_context_by_email(mut dispatch_arg_0)
			return rt.new_null()
		}
		'prepare_context_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.prepare_context_data(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_TransactionalEmailPersonalizer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'personalizer' { return this.personalizer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_TransactionalEmailPersonalizer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'personalizer' {
			this.personalizer = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_transactionalemailpersonalizer_php() {
	// unsupported statement: Stmt_Declare
}

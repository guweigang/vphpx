import rt

struct Class_Automattic_WooCommerce_EmailEditor_Bootstrap {
	rt.PhpObjectBase
pub mut:
	email_editor                         rt.PhpVal = rt.new_null()
	core_email_editor_integration        rt.PhpVal = rt.new_null()
	woocommerce_email_editor_integration rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Bootstrap) construct(mut var_email_editor Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor, mut var_core_email_editor_integration Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer, mut var_woocommerce_email_editor_integration Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Initializer) {
	this.email_editor = var_email_editor
	this.core_email_editor_integration = var_core_email_editor_integration
	this.woocommerce_email_editor_integration = var_woocommerce_email_editor_integration
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Bootstrap) init() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Bootstrap',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'initialize' },
		])])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_email_editor_initialized'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Bootstrap',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'setup_email_editor_integrations' },
		]),
	])
	rt.call_function('add_filter', [rt.new_string('block_type_metadata_settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: this.core_email_editor_integration },
			rt.ArrayItem{ key: none, val: 'update_block_settings' },
		]),
		rt.new_int(10), rt.new_int(1)])
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WooCommerce')])) {
		rt.call_function('add_filter', [rt.new_string('block_type_metadata_settings'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: this.woocommerce_email_editor_integration },
				rt.ArrayItem{ key: none, val: 'update_block_settings' },
			]),
			rt.new_int(10), rt.new_int(1)])
		mut var_coupon_generator :=
			create_automattic_woocommerce_emaileditor_integrations_woocommerce_coupon_code_generator()
		var_coupon_generator.init()
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Bootstrap) initialize() {
	rt.call_method(this.email_editor, 'initialize', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Bootstrap) setup_email_editor_integrations() bool {
	rt.call_method(this.core_email_editor_integration, 'initialize', []rt.PhpVal{})
	return true
	return false
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_bootstrap(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Bootstrap {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Bootstrap{
		PhpObjectBase:                        rt.PhpObjectBase{}
		email_editor:                         rt.new_null()
		core_email_editor_integration:        rt.new_null()
		woocommerce_email_editor_integration: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_coupon_code_generator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Bootstrap) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Initializer](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'setup_email_editor_integrations' {
			return rt.new_bool(this.setup_email_editor_integrations())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Bootstrap) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'email_editor' { return this.email_editor }
		'core_email_editor_integration' { return this.core_email_editor_integration }
		'woocommerce_email_editor_integration' { return this.woocommerce_email_editor_integration }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Bootstrap) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'email_editor' {
			this.email_editor = val
			return true
		}
		'core_email_editor_integration' {
			this.core_email_editor_integration = val
			return true
		}
		'woocommerce_email_editor_integration' {
			this.woocommerce_email_editor_integration = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

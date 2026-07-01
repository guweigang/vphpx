import rt

pub fn Class_Automattic_WooCommerce_Internal_Api_Settings.section_id() string {
	return 'graphql'
}
struct Class_Automattic_WooCommerce_Internal_Api_Settings {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Settings) register()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_sections_advanced'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Api_Settings', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_section' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_settings_advanced'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Api_Settings', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_settings' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Settings) add_section(mut var_sections Class_Automattic_WooCommerce_Internal_Api_array) rt.PhpVal {
	mut var_sections_mutated := var_sections
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Api_Main{}; return temp.is_enabled() }()) {
		var_sections_mutated.array_set(Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Internal_Api_Settings.section_id(), rt.call_function('__', [rt.new_string('GraphQL'), rt.new_string('woocommerce')]))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Api_array', []string{}, var_sections_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Settings) add_settings(mut var_settings Class_Automattic_WooCommerce_Internal_Api_array, section_id string) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Api_Main{}; return temp.is_enabled() }())))))) {
		return rt.new_object('Automattic_WooCommerce_Internal_Api_array', []string{}, var_settings)
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('GraphQL'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Configure the WooCommerce GraphQL API.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'id', val: 'woocommerce_graphql_options' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Enable GET endpoint'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Allow GraphQL queries over GET in addition to POST'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Api_Main.option_get_endpoint_enabled() }, rt.ArrayItem{ key: 'default', val: 'yes' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'woocommerce_graphql_options' }]) }])
}

struct Class_Automattic_WooCommerce_Internal_Api_Main {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_api_settings() &Class_Automattic_WooCommerce_Internal_Api_Settings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_main() &Class_Automattic_WooCommerce_Internal_Api_Main {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Main{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'add_section' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.add_section(mut dispatch_arg_0)
		}
		'add_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.add_settings(mut dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_api_settings_php() {
	// unsupported statement: Stmt_Declare
}

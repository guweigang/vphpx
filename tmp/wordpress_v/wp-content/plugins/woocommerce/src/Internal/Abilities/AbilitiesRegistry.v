import rt

struct Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRegistry {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRegistry) construct()  {
	this.init_abilities()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRegistry) init_abilities()  {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories{}; return temp.init() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge{}; return temp.init() }()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRegistry) get_abilities_ids() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_abilities')]))))) {
		return rt.new_array()
	}
	mut var_all_abilities := rt.call_function('wp_get_abilities', []rt.PhpVal{})
	return rt.func_array_keys(var_all_abilities.dup())
}

struct Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_abilities_abilitiesregistry() &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRegistry {
	mut obj := &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_abilities_abilitiescategories() &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories {
	mut obj := &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_abilities_abilitiesrestbridge() &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge {
	mut obj := &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init_abilities' {
			this.init_abilities()
			return rt.new_null()
		}
		'get_abilities_ids' {
			return this.get_abilities_ids()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_abilities_abilitiesregistry_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

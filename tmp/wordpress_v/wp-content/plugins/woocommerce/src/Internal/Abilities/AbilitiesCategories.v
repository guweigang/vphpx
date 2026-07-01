import rt

struct Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories.init()  {
	rt.call_function('add_action', [rt.new_string('abilities_api_categories_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'register_categories' }])])
	rt.call_function('add_action', [rt.new_string('wp_abilities_api_categories_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'register_categories' }])])
}

fn Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories.register_categories()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_register_ability_category')]))))) {
		return rt.new_null()
	}
	rt.call_function('wp_register_ability_category', [rt.new_string('woocommerce-rest'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('WooCommerce REST API'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('REST API operations for WooCommerce resources including products, orders, and other store data.'), rt.new_string('woocommerce')]) }])])
}

fn create_automattic_woocommerce_internal_abilities_abilitiescategories() &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories {
	mut obj := &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories.init()
			return rt.new_null()
		}
		'register_categories' {
			Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories.register_categories()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesCategories) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_abilities_abilitiescategories_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

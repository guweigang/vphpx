import rt

struct Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbility {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbility) validate_output(var_output rt.PhpVal) bool {
	return true
}

struct Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_Ability {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_abilities_rest_restability() &Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbility {
	mut obj := &Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_abilities_rest_wp_ability() &Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_Ability {
	mut obj := &Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_Ability{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'validate_output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_output(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_Ability) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_Ability) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_Ability) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_abilities_rest_restability_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

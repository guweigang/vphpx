import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		value rt.PhpVal = rt.new_null()
		deprecationReason rt.PhpVal = rt.new_null()
		description rt.PhpVal = rt.new_null()
		astNode rt.PhpVal = rt.new_null()
		config rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition) construct(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array)  {
	this.name = var_config.array_get('name')
	this.value = if !(var_config.array_get('value')).is_null() { var_config.array_get('value') } else { rt.new_null() }
	this.deprecationReason = if !(var_config.array_get('deprecationReason')).is_null() { var_config.array_get('deprecationReason') } else { rt.new_null() }
	this.description = if !(var_config.array_get('description')).is_null() { var_config.array_get('description') } else { rt.new_null() }
	this.astNode = if !(var_config.array_get('astNode')).is_null() { var_config.array_get('astNode') } else { rt.new_null() }
	this.config = var_config.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition) isdeprecated() bool {
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_enumvaluedefinition(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		value: rt.new_null()
		deprecationReason: rt.new_null()
		description: rt.new_null()
		astNode: rt.new_null()
		config: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'isDeprecated' {
			return rt.new_bool(this.isdeprecated())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'value' { return this.value }
		'deprecationReason' { return this.deprecationReason }
		'description' { return this.description }
		'astNode' { return this.astNode }
		'config' { return this.config }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		'value' { this.value = val; return true }
		'deprecationReason' { this.deprecationReason = val; return true }
		'description' { this.description = val; return true }
		'astNode' { this.astNode = val; return true }
		'config' { this.config = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_enumvaluedefinition_php() {
	// unsupported statement: Stmt_Declare
}

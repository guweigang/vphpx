import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition {
	rt.PhpObjectBase
pub mut:
	name               string
	definitionResolver rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition) construct(name string, mut var_definitionResolver Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_callable) {
	this.name = name
	this.definitionResolver = var_definitionResolver.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition) getname() string {
	return this.name
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition) resolve() rt.PhpVal {
	mut var_field := rt.call_callable(this.definitionResolver, []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.instance_of(var_field,
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition')))
	{
		return var_field.dup()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_field,
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type')))
	{
		return create_automattic_woocommerce_vendor_graphql_type_definition_fielddefinition(rt.create_array([
			rt.ArrayItem{ key: 'name', val: this.name },
			rt.ArrayItem{ key: 'type', val: var_field },
		]))
	}
	return create_automattic_woocommerce_vendor_graphql_type_definition_fielddefinition(rt.add(var_field, rt.create_array([
		rt.ArrayItem{ key: 'name', val: this.name },
	])))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_unresolvedfielddefinition(name string, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition{
		PhpObjectBase:      rt.PhpObjectBase{}
		name:               ''
		definitionResolver: rt.new_null()
	}
	obj.construct(name, arg_1)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_fielddefinition() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_callable](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		'resolve' {
			return this.resolve()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return rt.new_string(this.name) }
		'definitionResolver' { return this.definitionResolver }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val.str()
			return true
		}
		'definitionResolver' {
			this.definitionResolver = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_unresolvedfielddefinition_php() {
	// unsupported statement: Stmt_Declare
}

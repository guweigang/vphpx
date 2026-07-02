import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	rt.PhpObjectBase
pub mut:
		description rt.PhpVal = rt.new_null()
		query rt.PhpVal = rt.new_null()
		mutation rt.PhpVal = rt.new_null()
		subscription rt.PhpVal = rt.new_null()
		types rt.PhpVal = rt.new_array()
		directives rt.PhpVal = rt.new_null()
		typeLoader rt.PhpVal = rt.new_null()
		assumeValid rt.PhpVal = rt.new_bool(false)
		astNode rt.PhpVal = rt.new_null()
		extensionASTNodes rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig.create(mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Type_array) rt.PhpVal {
	mut var_config := create_automattic_woocommerce_vendor_graphql_type_static()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_options, rt.new_array())))) {
		if var_options.array_isset(rt.new_string('description')) {
			var_config.setdescription(var_options.array_get(rt.new_string('description')))
		}
		if var_options.array_isset(rt.new_string('query')) {
			var_config.setquery(var_options.array_get(rt.new_string('query')))
		}
		if var_options.array_isset(rt.new_string('mutation')) {
			var_config.setmutation(var_options.array_get(rt.new_string('mutation')))
		}
		if var_options.array_isset(rt.new_string('subscription')) {
			var_config.setsubscription(var_options.array_get(rt.new_string('subscription')))
		}
		if var_options.array_isset(rt.new_string('types')) {
			var_config.settypes(var_options.array_get(rt.new_string('types')))
		}
		if var_options.array_isset(rt.new_string('directives')) {
			var_config.setdirectives(var_options.array_get(rt.new_string('directives')))
		}
		if var_options.array_isset(rt.new_string('typeLoader')) {
			var_config.settypeloader(var_options.array_get(rt.new_string('typeLoader')))
		}
		if var_options.array_isset(rt.new_string('assumeValid')) {
			var_config.setassumevalid(var_options.array_get(rt.new_string('assumeValid')))
		}
		if var_options.array_isset(rt.new_string('astNode')) {
			var_config.setastnode(var_options.array_get(rt.new_string('astNode')))
		}
		if var_options.array_isset(rt.new_string('extensionASTNodes')) {
			var_config.setextensionastnodes(var_options.array_get(rt.new_string('extensionASTNodes')))
		}
	}
	return mut var_config
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) getdescription() string {
	return (this.description).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) setdescription(mut var_description Class_Automattic_WooCommerce_Vendor_GraphQL_Type_?string) rt.PhpVal {
	this.description = var_description
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) getquery() rt.PhpVal {
	return this.query
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) setquery(var_query rt.PhpVal) rt.PhpVal {
	this.assertmaybelazyobjecttype(var_query.clone())
	this.query = var_query.clone()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) getmutation() rt.PhpVal {
	return this.mutation
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) setmutation(var_mutation rt.PhpVal) rt.PhpVal {
	this.assertmaybelazyobjecttype(var_mutation.clone())
	this.mutation = var_mutation.clone()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) getsubscription() rt.PhpVal {
	return this.subscription
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) setsubscription(var_subscription rt.PhpVal) rt.PhpVal {
	this.assertmaybelazyobjecttype(var_subscription.clone())
	this.subscription = var_subscription.clone()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) gettypes() rt.PhpVal {
	return this.types
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) settypes(var_types rt.PhpVal) rt.PhpVal {
	this.types = var_types.clone()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) getdirectives() rt.PhpVal {
	return this.directives
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) setdirectives(mut var_directives Class_Automattic_WooCommerce_Vendor_GraphQL_Type_?array) rt.PhpVal {
	this.directives = var_directives
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) gettypeloader() rt.PhpVal {
	return this.typeLoader
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) settypeloader(mut var_typeLoader Class_Automattic_WooCommerce_Vendor_GraphQL_Type_?callable) rt.PhpVal {
	this.typeLoader = var_typeLoader
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) getassumevalid() bool {
	return (this.assumeValid).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) setassumevalid(assumeValid bool) rt.PhpVal {
	this.assumeValid = rt.new_bool(assumeValid)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) getastnode() rt.PhpVal {
	return this.astNode
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) setastnode(mut var_astNode Class_Automattic_WooCommerce_Vendor_GraphQL_Type_?SchemaDefinitionNode) rt.PhpVal {
	this.astNode = var_astNode
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) getextensionastnodes() rt.PhpVal {
	return this.extensionASTNodes
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) setextensionastnodes(mut var_extensionASTNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Type_array) rt.PhpVal {
	this.extensionASTNodes = var_extensionASTNodes
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) assertmaybelazyobjecttype(var_maybeLazyObjectType rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.instance_of(var_maybeLazyObjectType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))) || rt.call_function('is_callable', [var_maybeLazyObjectType.clone()]) || var_maybeLazyObjectType.clone().is_null() {
		return
	}
	mut var_notMaybeLazyObjectType := if var_maybeLazyObjectType.clone().is_object() { rt.call_function('get_class', [var_maybeLazyObjectType.clone()]) } else { rt.call_function('gettype', [var_maybeLazyObjectType.clone()]) }
	mut var_objectTypeClass := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType.class()
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Expected instanceof ${var_objectTypeClass.to_string()}, a callable that returns such an instance, or null, got: ${var_notMaybeLazyObjectType.to_string()}."))))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_schemaconfig(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig{
		PhpObjectBase: rt.PhpObjectBase{}
		description: rt.new_null()
		query: rt.new_null()
		mutation: rt.new_null()
		subscription: rt.new_null()
		types: rt.new_array()
		directives: rt.new_null()
		typeLoader: rt.new_null()
		assumeValid: rt.new_bool(false)
		astNode: rt.new_null()
		extensionASTNodes: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig.create(mut dispatch_arg_0)
		}
		'getDescription' {
			return rt.new_string(this.getdescription())
		}
		'setDescription' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.setdescription(mut dispatch_arg_0)
		}
		'getQuery' {
			return this.getquery()
		}
		'setQuery' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.setquery(dispatch_arg_0)
		}
		'getMutation' {
			return this.getmutation()
		}
		'setMutation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.setmutation(dispatch_arg_0)
		}
		'getSubscription' {
			return this.getsubscription()
		}
		'setSubscription' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.setsubscription(dispatch_arg_0)
		}
		'getTypes' {
			return this.gettypes()
		}
		'setTypes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.settypes(dispatch_arg_0)
		}
		'getDirectives' {
			return this.getdirectives()
		}
		'setDirectives' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.setdirectives(mut dispatch_arg_0)
		}
		'getTypeLoader' {
			return this.gettypeloader()
		}
		'setTypeLoader' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_?callable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.settypeloader(mut dispatch_arg_0)
		}
		'getAssumeValid' {
			return rt.new_bool(this.getassumevalid())
		}
		'setAssumeValid' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.setassumevalid(dispatch_arg_0)
		}
		'getAstNode' {
			return this.getastnode()
		}
		'setAstNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_?SchemaDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.setastnode(mut dispatch_arg_0)
		}
		'getExtensionASTNodes' {
			return this.getextensionastnodes()
		}
		'setExtensionASTNodes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.setextensionastnodes(mut dispatch_arg_0)
		}
		'assertMaybeLazyObjectType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.assertmaybelazyobjecttype(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'description' { return this.description }
		'query' { return this.query }
		'mutation' { return this.mutation }
		'subscription' { return this.subscription }
		'types' { return this.types }
		'directives' { return this.directives }
		'typeLoader' { return this.typeLoader }
		'assumeValid' { return this.assumeValid }
		'astNode' { return this.astNode }
		'extensionASTNodes' { return this.extensionASTNodes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'description' { this.description = val; return true }
		'query' { this.query = val; return true }
		'mutation' { this.mutation = val; return true }
		'subscription' { this.subscription = val; return true }
		'types' { this.types = val; return true }
		'directives' { this.directives = val; return true }
		'typeLoader' { this.typeLoader = val; return true }
		'assumeValid' { this.assumeValid = val; return true }
		'astNode' { this.astNode = val; return true }
		'extensionASTNodes' { this.extensionASTNodes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

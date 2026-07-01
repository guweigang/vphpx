import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	rt.PhpObjectBase
pub mut:
		config rt.PhpVal = rt.new_null()
		resolvedTypes rt.PhpVal = rt.new_array()
		implementationsMap rt.PhpVal = rt.new_null()
		fullyLoaded bool
		scalarOverrides rt.PhpVal = rt.new_null()
		validationErrors rt.PhpVal = rt.new_null()
		description rt.PhpVal = rt.new_null()
		astNode rt.PhpVal = rt.new_null()
		extensionASTNodes rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) construct(var_config rt.PhpVal)  {
	mut var_config_mutated := var_config
	if rt.is_true(rt.new_bool(var_config_mutated.dup().is_array())) {
		var_config_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig{}; return temp.create(arg_0) }(var_config_mutated.dup())
	}
	if rt.is_true(rt.call_method(var_config_mutated, 'getAssumeValid', []rt.PhpVal{})) {
		this.validationErrors = rt.new_array()
	}
	this.description = rt.get_property(var_config_mutated, 'description')
	this.astNode = rt.get_property(var_config_mutated, 'astNode')
	this.extensionASTNodes = rt.get_property(var_config_mutated, 'extensionASTNodes')
	this.config = var_config_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) gettypemap() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.fullyLoaded)))) {
		this.resolvedTypes = rt.new_array()
		mut var_scalarOverrides := this.getscalaroverrides()
		{
			mut iter_1 := this.materializetypes().iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_typeOrLazyType := item_1.val
				mut var_type := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.resolvetype(var_typeOrLazyType.dup())
				rt.call_function('assert', [rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))])
				mut var_typeName := rt.get_property(var_type, 'name')
				if var_scalarOverrides.array_isset(var_typeName) {
					continue
				}
				rt.call_function('assert', [rt.new_bool(!(this.resolvedTypes.array_isset(var_typeName)) || rt.is_true(rt.identical(var_type, this.resolvedTypes.array_get(var_typeName)))), rt.new_string("Schema must contain unique named types but contains multiple types named \"${var_type.to_string()}\" (see https://webonyx.github.io/graphql-php/type-definitions/#type-registry).")])
				this.resolvedTypes.array_set(var_typeName, var_type.dup())
			}
		}
		mut var_allReferencedTypes := rt.new_array()
		{
			mut iter_1 := this.resolvedTypes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_type := item_1.val
				var_allReferencedTypes.array_unset(rt.get_property(var_type, 'name'))
				fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo{}; return temp.extracttypes(arg_0, arg_1) }(var_type.dup(), var_allReferencedTypes.dup())
			}
		}
		{
			mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: this.getquerytype() }, rt.ArrayItem{ key: none, val: this.getmutationtype() }, rt.ArrayItem{ key: none, val: this.getsubscriptiontype() }]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_rootType := item_1.val
				if rt.is_true(rt.new_bool(rt.instance_of(var_rootType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))) {
					fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo{}; return temp.extracttypes(arg_0, arg_1) }(var_rootType.dup(), var_allReferencedTypes.dup())
				}
			}
		}
		{
			mut iter_1 := this.getdirectives().iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_directive := item_1.val
				if rt.is_true(rt.new_bool(rt.instance_of(var_directive, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive'))) {
					fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo{}; return temp.extracttypesfromdirectives(arg_0, arg_1) }(var_directive.dup(), var_allReferencedTypes.dup())
				}
			}
		}
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo{}; return temp.extracttypes(arg_0, arg_1) }(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}; return temp._schema() }(), var_allReferencedTypes.dup())
		{
			mut iter_1 := var_scalarOverrides.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_override := item_1.val
				mut var_name := item_1.key
				var_allReferencedTypes.array_set(var_name, var_override.dup())
			}
		}
		this.resolvedTypes = var_allReferencedTypes.dup()
		this.fullyLoaded = true
	}
	return this.resolvedTypes
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getdirectives() rt.PhpVal {
	return if !(rt.get_property(this.config, 'directives')).is_null() { rt.get_property(this.config, 'directives') } else { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{}; return temp.getstandarddirectives() }() }
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloadernottype(var_typeLoaderReturn rt.PhpVal) string {
	mut var_typeClass := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.class()
	mut var_notType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_typeLoaderReturn.dup())
	return "Type loader is expected to return an instanceof ${var_typeClass.to_string()}, but it returned ${var_notType.to_string()}"
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloaderwrongtypename(expectedTypeName string, actualTypeName string) string {
	return "Type loader is expected to return type ${var_expectedTypeName}, but it returned type ${var_actualTypeName}."
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getoperationtype(operation string)  {
	mut switch_val_1 := rt.new_string(operation)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('query'))) {
		return this.getquerytype()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('mutation'))) {
		return this.getmutationtype()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('subscription'))) {
		return this.getsubscriptiontype()
	} else {
		return rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getquerytype() rt.PhpVal {
	mut var_query := rt.get_property(this.config, 'query')
	if rt.is_true(rt.identical(var_query, rt.new_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_callable', [var_query.dup()])) {
		return rt.set_property(this.config, 'query', rt.call_callable(var_query, []rt.PhpVal{}))
	}
	return var_query.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getmutationtype() rt.PhpVal {
	mut var_mutation := rt.get_property(this.config, 'mutation')
	if rt.is_true(rt.identical(var_mutation, rt.new_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_callable', [var_mutation.dup()])) {
		return rt.set_property(this.config, 'mutation', rt.call_callable(var_mutation, []rt.PhpVal{}))
	}
	return var_mutation.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getsubscriptiontype() rt.PhpVal {
	mut var_subscription := rt.get_property(this.config, 'subscription')
	if rt.is_true(rt.identical(var_subscription, rt.new_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_callable', [var_subscription.dup()])) {
		return rt.set_property(this.config, 'subscription', rt.call_callable(var_subscription, []rt.PhpVal{}))
	}
	return var_subscription.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getconfig() rt.PhpVal {
	return this.config
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) gettype(name string) rt.PhpVal {
	if this.resolvedTypes.array_isset(rt.new_string(name)) {
		return this.resolvedTypes.array_get(name)
	}
	mut var_introspectionTypes := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}; return temp.gettypes() }()
	if var_introspectionTypes.array_isset(rt.new_string(name)) {
		return var_introspectionTypes.array_get(name)
	}
	mut var_type := this.loadtype(name)
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.resolvedTypes.array_set(name, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.resolvetype(var_type.dup()))
	}
	mut var_scalarOverrides := this.getscalaroverrides()
	if var_scalarOverrides.array_isset(rt.new_string(name)) {
		return this.resolvedTypes.array_set(name, var_scalarOverrides.array_get(name))
	}
	mut var_builtInScalars := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.builtinscalars() }()
	if var_builtInScalars.array_isset(rt.new_string(name)) {
		return this.resolvedTypes.array_set(name, var_builtInScalars.array_get(name))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) hastype(name string) bool {
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) loadtype(typeName string) rt.PhpVal {
	mut typeName_mutated := typeName
	mut var_typeLoader := rt.get_property(this.config, 'typeLoader')
	if !(!(var_typeLoader).is_null()) {
		return if !(this.gettypemap().array_get(typeName_mutated)).is_null() { this.gettypemap().array_get(typeName_mutated) } else { rt.new_null() }
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.isbuiltinscalarname(arg_0) }(rt.new_string(typeName_mutated))) {
		return rt.new_null()
	}
	mut var_type := rt.call_callable(var_typeLoader, [rt.new_string(typeName_mutated).dup()])
	if rt.is_true(rt.identical(var_type, rt.new_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type')))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloadernottype(var_type.dup()))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloaderwrongtypename(typeName_mutated, (rt.get_property(var_type, 'name')).str()))))
	}
	return var_type.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getscalaroverrides() rt.PhpVal {
	if rt.is_true(rt.identical(this.scalarOverrides, rt.new_null())) {
		this.scalarOverrides = rt.new_array()
		mut var_builtInScalars := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.builtinscalars() }()
		{
			mut iter_1 := this.materializetypes().iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_typeOrLazyType := item_1.val
				mut var_type := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.resolvetype(var_typeOrLazyType.dup())
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true() && .array_isset())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					.array_set(, .dup())
				}
			}
		}
	}
	return this.scalarOverrides
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) materializetypes() rt.PhpVal {
	mut var_types := 
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	return .dup()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.resolvetype(var_type rt.PhpVal) rt.PhpVal {
	mut var_type_mutated := var_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getpossibletypes(mut var_abstractType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getimplementations(mut var_abstractType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) collectimplementations() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) issubtype(mut var_abstractType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType, mut var_maybeSubType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType) bool {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getdirective(name string) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) assertvalid()  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) validate() rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_schema(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
		config: rt.new_null()
		resolvedTypes: rt.new_array()
		implementationsMap: rt.new_null()
		fullyLoaded: false
		scalarOverrides: rt.new_null()
		validationErrors: rt.new_null()
		description: rt.new_null()
		astNode: rt.new_null()
		extensionASTNodes: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schemaconfig() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_typeinfo() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_introspection() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_graphql() &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getTypeMap' {
			return this.gettypemap()
		}
		'getDirectives' {
			return this.getdirectives()
		}
		'typeLoaderNotType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloadernottype(dispatch_arg_0))
		}
		'typeLoaderWrongTypeName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloaderwrongtypename(dispatch_arg_0, dispatch_arg_1))
		}
		'getOperationType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.getoperationtype(dispatch_arg_0)
			return rt.new_null()
		}
		'getQueryType' {
			return this.getquerytype()
		}
		'getMutationType' {
			return this.getmutationtype()
		}
		'getSubscriptionType' {
			return this.getsubscriptiontype()
		}
		'getConfig' {
			return this.getconfig()
		}
		'getType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.gettype(dispatch_arg_0)
		}
		'hasType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hastype(dispatch_arg_0))
		}
		'loadType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.loadtype(dispatch_arg_0)
		}
		'getScalarOverrides' {
			return this.getscalaroverrides()
		}
		'materializeTypes' {
			return this.materializetypes()
		}
		'resolveType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.resolvetype(dispatch_arg_0)
		}
		'getPossibleTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getpossibletypes(mut dispatch_arg_0)
		}
		'getImplementations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getimplementations(mut dispatch_arg_0)
		}
		'collectImplementations' {
			return this.collectimplementations()
		}
		'isSubType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.issubtype(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'getDirective' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getdirective(dispatch_arg_0)
		}
		'assertValid' {
			this.assertvalid()
			return rt.new_null()
		}
		'validate' {
			return this.validate()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'config' { return this.config }
		'resolvedTypes' { return this.resolvedTypes }
		'implementationsMap' { return this.implementationsMap }
		'fullyLoaded' { return rt.new_bool(this.fullyLoaded) }
		'scalarOverrides' { return this.scalarOverrides }
		'validationErrors' { return this.validationErrors }
		'description' { return this.description }
		'astNode' { return this.astNode }
		'extensionASTNodes' { return this.extensionASTNodes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'config' { this.config = val; return true }
		'resolvedTypes' { this.resolvedTypes = val; return true }
		'implementationsMap' { this.implementationsMap = val; return true }
		'fullyLoaded' { this.fullyLoaded = (val).to_bool(); return true }
		'scalarOverrides' { this.scalarOverrides = val; return true }
		'validationErrors' { this.validationErrors = val; return true }
		'description' { this.description = val; return true }
		'astNode' { this.astNode = val; return true }
		'extensionASTNodes' { this.extensionASTNodes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_schema_php() {
	// unsupported statement: Stmt_Declare
}

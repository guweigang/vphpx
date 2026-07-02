import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema {
	rt.PhpObjectBase
pub mut:
		ast rt.PhpVal = rt.new_null()
		typeConfigDecorator rt.PhpVal = rt.new_null()
		fieldConfigDecorator rt.PhpVal = rt.new_null()
		options rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema) construct(mut var_ast Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_typeConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_fieldConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable) {
	this.ast = var_ast
	this.typeConfigDecorator = var_typeConfigDecorator
	this.options = var_options
	this.fieldConfigDecorator = var_fieldConfigDecorator
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema.build(var_source rt.PhpVal, mut var_typeConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_fieldConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{}
	mut iife_result_0 := iife_temp_0.parse(var_source.clone())
	mut var_doc := if rt.is_true(rt.new_bool(rt.instance_of(var_source, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode'))) { var_source } else { iife_result_0 }
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema.buildast(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](var_doc), mut var_typeConfigDecorator, mut var_options, mut var_fieldConfigDecorator)
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema.buildast(mut var_ast Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_typeConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_fieldConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable) rt.PhpVal {
	return rt.call_method(create_automattic_woocommerce_vendor_graphql_utils_self(var_ast, var_typeConfigDecorator, var_options, var_fieldConfigDecorator), 'buildSchema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema) buildschema() rt.PhpVal {
	mut var_def := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(if !(this.options.array_get(rt.new_string('assumeValid'))).is_null() { this.options.array_get(rt.new_string('assumeValid')) } else { rt.new_bool(false) })))) && rt.is_true(rt.new_bool(!(rt.is_true(if !(this.options.array_get(rt.new_string('assumeValidSDL'))).is_null() { this.options.array_get(rt.new_string('assumeValidSDL')) } else { rt.new_bool(false) })))) {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{}
	mut iife_result_1 := iife_temp_1.assertvalidsdl(this.ast)
	}
	mut var_schemaDef := rt.new_null()
	mut var_typeDefinitionsMap := rt.new_array()
	mut var_typeExtensionsMap := rt.new_array()
	mut var_directiveDefs := rt.new_array()
	mut iter_1 := rt.get_property(this.ast, 'definitions').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_definition := item_1.val
		mut switch_val_1 := rt.new_bool(true)
		if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode')))) {
		var_schemaDef = var_definition
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeDefinitionNode')))) {
			mut var_name := rt.get_property(rt.call_method(var_definition, 'getName', []rt.PhpVal{}), 'value')
			var_typeDefinitionsMap.array_set(var_name, var_definition.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeExtensionNode')))) {
			var_name = rt.get_property(rt.call_method(var_definition, 'getName', []rt.PhpVal{}), 'value')
			var_typeExtensionsMap.array_get_mut(var_name).array_push(var_definition.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode')))) {
			var_directiveDefs.array_push(var_definition.clone())
		}
	}
	mut var_operationTypes := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_schemaDef, rt.new_null())))) { this.getoperationtypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode](var_schemaDef)) } else { rt.create_array([rt.ArrayItem{ key: 'query', val: 'Query' }, rt.ArrayItem{ key: 'mutation', val: 'Mutation' }, rt.ArrayItem{ key: 'subscription', val: 'Subscription' }]) }
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_typeName := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		rt.throw_exception(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema.unknowntype((var_typeName).str()))
		return rt.new_null()
		}
	mut var_definitionBuilder := create_automattic_woocommerce_vendor_graphql_utils_astdefinitionbuilder(var_typeDefinitionsMap.clone(), var_typeExtensionsMap.clone(), rt.new_closure(closure_3_fn), this.typeConfigDecorator, this.fieldConfigDecorator)
	mut var_directives := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: var_definitionBuilder }, rt.ArrayItem{ key: none, val: 'buildDirective' }]), var_directiveDefs.clone()])
	mut var_directivesByName := rt.new_array()
	mut iter_2 := var_directives.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_directive := item_2.val
		var_directivesByName.array_get_mut(rt.get_property(var_directive, 'name')).array_push(var_directive.clone())
	}
	if !(var_directivesByName.array_isset(rt.new_string('include'))) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
		mut iife_result_3 := iife_temp_3.includedirective()
		var_directives.array_push(iife_result_3)
	}
	if !(var_directivesByName.array_isset(rt.new_string('skip'))) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
		mut iife_result_4 := iife_temp_4.skipdirective()
		var_directives.array_push(iife_result_4)
	}
	if !(var_directivesByName.array_isset(rt.new_string('deprecated'))) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
		mut iife_result_5 := iife_temp_5.deprecateddirective()
		var_directives.array_push(iife_result_5)
	}
	if !(var_directivesByName.array_isset(rt.new_string('oneOf'))) {
		mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
		mut iife_result_6 := iife_temp_6.oneofdirective()
		var_directives.array_push(iife_result_6)
	}
	closure_8_fn := fn [var_definitionBuilder] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_definitionBuilder.maybebuildtype(var_name.clone())
		}
	closure_11_fn := fn [var_definitionBuilder, var_def, var_typeDefinitionsMap] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_10_fn := fn [var_definitionBuilder] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_def := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return var_definitionBuilder.buildtype(rt.get_property(rt.call_method(var_def, 'getName', []rt.PhpVal{}), 'value'))
			}
		closure_11_fn := fn [var_definitionBuilder] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_def := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return var_definitionBuilder.buildtype(rt.get_property(rt.call_method(var_def, 'getName', []rt.PhpVal{}), 'value'))
			}
		return rt.call_function('array_map', [rt.new_closure(closure_10_fn), var_typeDefinitionsMap.clone()])
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, create_automattic_woocommerce_vendor_graphql_type_schema(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(create_automattic_woocommerce_vendor_graphql_type_schemaconfig(), 'setDescription', [if !(rt.get_property(rt.get_property(var_schemaDef, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_schemaDef, 'description'), 'value') } else { rt.new_null() }]), 'setQuery', [if var_operationTypes.array_isset(rt.new_string('query')) { var_definitionBuilder.maybebuildtype(var_operationTypes.array_get(rt.new_string('query'))) } else { rt.new_null() }]), 'setMutation', [if var_operationTypes.array_isset(rt.new_string('mutation')) { var_definitionBuilder.maybebuildtype(var_operationTypes.array_get(rt.new_string('mutation'))) } else { rt.new_null() }]), 'setSubscription', [if var_operationTypes.array_isset(rt.new_string('subscription')) { var_definitionBuilder.maybebuildtype(var_operationTypes.array_get(rt.new_string('subscription'))) } else { rt.new_null() }]), 'setTypeLoader', [rt.new_closure(closure_8_fn)]), 'setDirectives', [var_directives.clone()]), 'setAstNode', [var_schemaDef.clone()]), 'setTypes', [rt.new_closure(closure_11_fn)])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema) getoperationtypes(mut var_schemaDef Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode) rt.PhpVal {
	mut var_schemaDef_mutated := var_schemaDef
	mut var_operationTypes := rt.new_array()
	mut iter_3 := rt.get_property(var_schemaDef_mutated, 'operationTypes').iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_operationType := item_3.val
		var_operationTypes.array_set(rt.get_property(var_operationType, 'operation'), rt.get_property(rt.get_property(rt.get_property(var_operationType, 'type'), 'name'), 'value'))
	}
	return var_operationTypes.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema.unknowntype(typeName string) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Unknown type: \"${var_typeName}\".")))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_buildschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		ast: rt.new_null()
		typeConfigDecorator: rt.new_null()
		fieldConfigDecorator: rt.new_null()
		options: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_parser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_documentvalidator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_astdefinitionbuilder(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_directive(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schemaconfig(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 3 { args[3] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'build' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema.build(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'buildAST' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema.buildast(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'buildSchema' {
			return this.buildschema()
		}
		'getOperationTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getoperationtypes(mut dispatch_arg_0)
		}
		'unknownType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema.unknowntype(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'ast' { return this.ast }
		'typeConfigDecorator' { return this.typeConfigDecorator }
		'fieldConfigDecorator' { return this.fieldConfigDecorator }
		'options' { return this.options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'ast' { this.ast = val; return true }
		'typeConfigDecorator' { this.typeConfigDecorator = val; return true }
		'fieldConfigDecorator' { this.fieldConfigDecorator = val; return true }
		'options' { this.options = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

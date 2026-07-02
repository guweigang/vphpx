import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity {
	rt.PhpObjectBase
pub mut:
		maxQueryComplexity i64
		queryComplexity i64
		rawVariableValues rt.PhpVal = rt.new_array()
		variableDefs rt.PhpVal = rt.new_null()
		fieldNodeAndDefs rt.PhpVal = rt.new_null()
		context rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) construct(maxQueryComplexity i64) {
	this.setmaxquerycomplexity(maxQueryComplexity)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	this.queryComplexity = 0
	this.context = var_context
	this.variableDefs = create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array())
	this.fieldNodeAndDefs = create_automattic_woocommerce_vendor_graphql_validator_rules_arrayobject()
	closure_1_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_selectionSet := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.fieldNodeAndDefs = this.collectfieldastsanddefs(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), var_context.getparenttype(), var_selectionSet.clone(), rt.new_null(), this.fieldNodeAndDefs)
		return rt.new_null()
		}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_def := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.variableDefs.array_push(var_def.clone())
		mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
		mut iife_result_2 := iife_temp_2.skipnode()
		return iife_result_2
		}
	closure_4_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_document := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_errors := var_context.geterrors()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_errors, rt.new_array())))) {
			return rt.new_null()
		}
		if rt.is_true(rt.identical(this.maxQueryComplexity, Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity.disabled())) {
			return rt.new_null()
		}
		mut iter_1 := rt.get_property(var_document, 'definitions').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_definition := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode')))))) {
				continue
			}
			this.queryComplexity = this.fieldcomplexity(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_definition, 'selectionSet')))
			if this.queryComplexity > this.maxQueryComplexity {
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity.maxquerycomplexityerrormessage(this.maxQueryComplexity, this.queryComplexity)))
				return rt.new_null()
			}
		}
		return rt.new_null()
		}
	return this.invokeifneeded(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.selection_set(), val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.variable_definition(), val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.document(), val: rt.create_array([rt.ArrayItem{ key: 'leave', val: rt.new_closure(closure_4_fn) }]) }]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) fieldcomplexity(mut var_selectionSet Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode) i64 {
	mut var_complexity := rt.new_int(0)
	mut iter_2 := rt.get_property(var_selectionSet, 'selections').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_selection := item_2.val
		var_complexity = rt.add(var_complexity, this.nodecomplexity(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode](var_selection)))
	}
	return (var_complexity).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) nodecomplexity(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode) i64 {
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')))) {
		if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_node, 'name'), 'value'), Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.schema_field_name())) {
			return 0
		}
		if this.directiveexcludesfield(mut var_node) {
			return 0
		}
		mut var_childrenComplexity := rt.new_int(if !(rt.get_property(var_node, 'selectionSet')).is_null() { this.fieldcomplexity(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_node, 'selectionSet'))) } else { 0 })
		mut var_fieldDef := this.fielddefinition(mut var_node)
		if rt.is_true(rt.new_bool(rt.instance_of(var_fieldDef, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_fieldDef, 'complexityFn'), rt.new_null())))) {
			mut var_fieldArguments := this.buildfieldarguments(mut var_node)
			return (rt.call_callable(rt.get_property(var_fieldDef, 'complexityFn'), [var_childrenComplexity.clone(), var_fieldArguments.clone()])).to_i64()
		}
		return (rt.add(var_childrenComplexity, rt.new_int(1))).to_i64()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode')))) {
		return this.fieldcomplexity(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_node, 'selectionSet')))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode')))) {
		mut var_fragment := this.getfragment(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode', []string{}, var_node))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_fragment, rt.new_null())))) {
			return this.fieldcomplexity(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_fragment, 'selectionSet')))
		}
	}
	return 0
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) fielddefinition(mut var_field Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) rt.PhpVal {
	mut var_node := rt.new_null()
	mut var_def := rt.new_null()
	mut iter_3 := if !(this.fieldNodeAndDefs.array_get(this.getfieldname(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode', []string{}, var_field)))).is_null() { this.fieldNodeAndDefs.array_get(this.getfieldname(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode', []string{}, var_field))) } else { rt.new_array() }.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_ := item_3.val
		if rt.is_true(rt.identical(var_node, var_field)) {
			return var_def.clone()
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) directiveexcludesfield(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) bool {
	mut var_errors := rt.new_null()
	mut var_variableValues := rt.new_null()
	mut var_error := rt.new_null()
	mut iter_4 := rt.get_property(var_node, 'directives').iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_directiveNode := item_4.val
		if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_directiveNode, 'name'), 'value'), Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.deprecated_name())) {
			return false
		}
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
		mut iife_result_4 := iife_temp_4.getvariablevalues(rt.call_method(this.context, 'getSchema', []rt.PhpVal{}), this.variableDefs, this.getrawvariablevalues())
		mut list_tmp_1 := iife_result_4
		var_errors = (list_tmp_1).array_get(0)
		var_variableValues = (list_tmp_1).array_get(1)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_errors, rt.new_null())))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_errors, rt.new_array())))) {
			closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_error := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.call_method(var_error, 'getMessage', []rt.PhpVal{})
				}
			closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_error := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.call_method(var_error, 'getMessage', []rt.PhpVal{})
				}
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.call_function('implode', [rt.new_string('\n\n'), rt.call_function('array_map', [rt.new_closure(closure_6_fn), var_errors.clone()])]))))
		}
		if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_directiveNode, 'name'), 'value'), Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.include_name())) {
			mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
			mut iife_result_7 := iife_temp_7.includedirective()
			mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
			mut iife_result_8 := iife_temp_8.getargumentvalues(iife_result_7, var_directiveNode.clone(), var_variableValues.clone())
			mut var_includeArguments := iife_result_8
			rt.call_function('assert', [rt.new_bool(var_includeArguments.array_get(rt.new_string('if')).is_bool()), rt.new_string('ensured by query validation')])
			return !(rt.is_true(var_includeArguments.array_get(rt.new_string('if'))))
		}
		if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_directiveNode, 'name'), 'value'), Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.skip_name())) {
			mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
			mut iife_result_9 := iife_temp_9.skipdirective()
			mut iife_temp_10 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
			mut iife_result_10 := iife_temp_10.getargumentvalues(iife_result_9, var_directiveNode.clone(), var_variableValues.clone())
			mut var_skipArguments := iife_result_10
			rt.call_function('assert', [rt.new_bool(var_skipArguments.array_get(rt.new_string('if')).is_bool()), rt.new_string('ensured by query validation')])
			return (var_skipArguments.array_get(rt.new_string('if'))).to_bool()
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) getrawvariablevalues() rt.PhpVal {
	return this.rawVariableValues
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) setrawvariablevalues(mut var_rawVariableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?array) {
	mut var_rawVariableValues_mutated := var_rawVariableValues
	this.rawVariableValues = if !(var_rawVariableValues_mutated).is_null() { var_rawVariableValues_mutated } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) buildfieldarguments(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) rt.PhpVal {
	mut var_errors := rt.new_null()
	mut var_variableValues := rt.new_null()
	mut var_error := rt.new_null()
	mut var_rawVariableValues := this.getrawvariablevalues()
	mut var_fieldDef := this.fielddefinition(mut var_node)
	mut var_args := rt.new_array()
	if rt.is_true(rt.new_bool(rt.instance_of(var_fieldDef, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition'))) {
		mut iife_temp_11 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
		mut iife_result_11 := iife_temp_11.getvariablevalues(rt.call_method(this.context, 'getSchema', []rt.PhpVal{}), this.variableDefs, var_rawVariableValues.clone())
		mut list_tmp_2 := iife_result_11
		var_errors = (list_tmp_2).array_get(0)
		var_variableValues = (list_tmp_2).array_get(1)
		if var_errors.clone().is_array() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_errors, rt.new_array())))) {
			closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_error := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.call_method(var_error, 'getMessage', []rt.PhpVal{})
				}
			closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_error := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.call_method(var_error, 'getMessage', []rt.PhpVal{})
				}
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.call_function('implode', [rt.new_string('\n\n'), rt.call_function('array_map', [rt.new_closure(closure_13_fn), var_errors.clone()])]))))
		}
	mut iife_temp_14 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
	mut iife_result_14 := iife_temp_14.getargumentvalues(var_fieldDef.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode', []string{}, var_node), var_variableValues.clone())
	var_args = iife_result_14
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) getmaxquerycomplexity() i64 {
	return this.maxQueryComplexity
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) getquerycomplexity() i64 {
	return this.queryComplexity
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) setmaxquerycomplexity(maxQueryComplexity i64) {
	this.checkifgreaterorequaltozero(rt.new_string('maxQueryComplexity'), rt.new_int(maxQueryComplexity))
	this.maxQueryComplexity = maxQueryComplexity
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity.maxquerycomplexityerrormessage(max i64, count i64) string {
	return "Max query complexity should be ${var_max.str()} but got ${var_count.str()}."
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) isenabled() bool {
	return rt.new_bool(!rt.is_true(rt.identical(this.maxQueryComplexity, Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity.disabled())))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ArrayObject {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_querycomplexity(maxQueryComplexity i64) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity{
		PhpObjectBase: rt.PhpObjectBase{}
		maxQueryComplexity: i64(0)
		queryComplexity: i64(0)
		rawVariableValues: rt.new_array()
		variableDefs: rt.new_null()
		fieldNodeAndDefs: rt.new_null()
		context: rt.new_null()
	}
	obj.construct(maxQueryComplexity)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_querysecurityrule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_arrayobject(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ArrayObject {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ArrayObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_visitor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{
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

fn create_automattic_woocommerce_vendor_graphql_executor_values(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'fieldComplexity' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.fieldcomplexity(mut dispatch_arg_0))
		}
		'nodeComplexity' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.nodecomplexity(mut dispatch_arg_0))
		}
		'fieldDefinition' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.fielddefinition(mut dispatch_arg_0)
		}
		'directiveExcludesField' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.directiveexcludesfield(mut dispatch_arg_0))
		}
		'getRawVariableValues' {
			return this.getrawvariablevalues()
		}
		'setRawVariableValues' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setrawvariablevalues(mut dispatch_arg_0)
			return rt.new_null()
		}
		'buildFieldArguments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildfieldarguments(mut dispatch_arg_0)
		}
		'getMaxQueryComplexity' {
			return rt.new_int(this.getmaxquerycomplexity())
		}
		'getQueryComplexity' {
			return rt.new_int(this.getquerycomplexity())
		}
		'setMaxQueryComplexity' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.setmaxquerycomplexity(dispatch_arg_0)
			return rt.new_null()
		}
		'maxQueryComplexityErrorMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity.maxquerycomplexityerrormessage(dispatch_arg_0, dispatch_arg_1))
		}
		'isEnabled' {
			return rt.new_bool(this.isenabled())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'maxQueryComplexity' { return rt.new_int(this.maxQueryComplexity) }
		'queryComplexity' { return rt.new_int(this.queryComplexity) }
		'rawVariableValues' { return this.rawVariableValues }
		'variableDefs' { return this.variableDefs }
		'fieldNodeAndDefs' { return this.fieldNodeAndDefs }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'maxQueryComplexity' { this.maxQueryComplexity = (val).to_i64(); return true }
		'queryComplexity' { this.queryComplexity = (val).to_i64(); return true }
		'rawVariableValues' { this.rawVariableValues = val; return true }
		'variableDefs' { this.variableDefs = val; return true }
		'fieldNodeAndDefs' { this.fieldNodeAndDefs = val; return true }
		'context' { this.context = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ArrayObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ArrayObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ArrayObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}

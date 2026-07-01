import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext {
	rt.PhpObjectBase
pub mut:
		schema rt.PhpVal = rt.new_null()
		ast rt.PhpVal = rt.new_null()
		errors rt.PhpVal = rt.new_array()
		typeInfo rt.PhpVal = rt.new_null()
		fragments rt.PhpVal = rt.new_null()
		fragmentSpreads rt.PhpVal = rt.new_null()
		recursivelyReferencedFragments rt.PhpVal = rt.new_null()
		variableUsages rt.PhpVal = rt.new_null()
		recursiveVariableUsages rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) construct(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_ast Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_typeInfo Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo)  {
	mut var_typeInfo_mutated := var_typeInfo
	this.schema = var_schema.dup()
	this.ast = var_ast.dup()
	this.typeInfo = var_typeInfo_mutated.dup()
	this.fragmentSpreads = create_automattic_woocommerce_vendor_graphql_validator_splobjectstorage()
	this.recursivelyReferencedFragments = create_automattic_woocommerce_vendor_graphql_validator_splobjectstorage()
	this.variableUsages = create_automattic_woocommerce_vendor_graphql_validator_splobjectstorage()
	this.recursiveVariableUsages = create_automattic_woocommerce_vendor_graphql_validator_splobjectstorage()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) reporterror(mut var_error Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error)  {
	this.errors.array_push(var_error.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) geterrors() rt.PhpVal {
	return this.errors
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getdocument() rt.PhpVal {
	return this.ast
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getschema() rt.PhpVal {
	return this.schema
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getrecursivevariableusages(mut var_operation Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode) rt.PhpVal {
	mut var_usages := if !(this.recursiveVariableUsages.array_get(var_operation)).is_null() { this.recursiveVariableUsages.array_get(var_operation) } else { rt.new_null() }
	if rt.is_true(rt.identical(var_usages, rt.new_null())) {
		var_usages = this.getvariableusages(mut var_operation)
		mut var_fragments := this.getrecursivelyreferencedfragments(mut var_operation)
		mut var_allUsages := rt.create_array([rt.ArrayItem{ key: none, val: var_usages }])
		{
			mut iter_1 := var_fragments.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_fragment := item_1.val
				var_allUsages.array_push(this.getvariableusages(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_HasSelectionSet](var_fragment)))
			}
		}
		var_usages = rt.call_function('array_merge', [var_allUsages.dup()])
		this.recursiveVariableUsages.array_set(var_operation, var_usages.dup())
	}
	return var_usages.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getvariableusages(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_HasSelectionSet) rt.PhpVal {
	mut var_node_mutated := var_node
	if !(this.variableUsages.array_isset(var_node_mutated)) {
		mut var_usages := rt.new_array()
		mut var_typeInfo := create_automattic_woocommerce_vendor_graphql_utils_typeinfo(this.schema)
		closure_2_fn := fn [mut var_usages, var_typeInfo] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.skipnode() }()
	}
	mut var_variable := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_usages.array_push(rt.create_array([rt.ArrayItem{ key: 'node', val: var_variable }, rt.ArrayItem{ key: 'type', val: var_typeInfo.getinputtype() }, rt.ArrayItem{ key: 'defaultValue', val: var_typeInfo.getdefaultvalue() }]))
	return rt.new_null()
	}
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.visit(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_HasSelectionSet', []string{}, var_node_mutated), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.visitwithtypeinfo(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo', []string{}, var_typeInfo), rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.variable_definition(), val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.variable(), val: rt.new_closure(closure_2_fn) }])))
		return this.variableUsages.array_set(var_node_mutated, var_usages.dup())
	}
	return this.variableUsages.array_get(var_node_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getrecursivelyreferencedfragments(mut var_operation Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode) rt.PhpVal {
	mut var_fragments := if !(this.recursivelyReferencedFragments.array_get(var_operation)).is_null() { this.recursivelyReferencedFragments.array_get(var_operation) } else { rt.new_null() }
	if rt.is_true(rt.identical(var_fragments, rt.new_null())) {
		var_fragments = rt.new_array()
		mut var_collectedNames := rt.new_array()
		mut var_nodesToVisit := rt.create_array([rt.ArrayItem{ key: none, val: var_operation }])
		for rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_node := rt.call_function('array_pop', [var_nodesToVisit.dup()])
			mut var_spreads := this.getfragmentspreads(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_HasSelectionSet](var_node))
			{
				mut iter_1 := var_spreads.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_spread := item_1.val
					mut var_fragName := rt.get_property(rt.get_property(var_spread, 'name'), 'value')
					if rt.is_true(if !(var_collectedNames.array_get(var_fragName)).is_null() { var_collectedNames.array_get(var_fragName) } else { rt.new_bool(false) }) {
						continue
					}
					var_collectedNames.array_set(var_fragName, true)
					mut var_fragment := this.getfragment((var_fragName).str())
					if rt.is_true(rt.identical(var_fragment, rt.new_null())) {
						continue
					}
					var_fragments.array_push(var_fragment.dup())
					var_nodesToVisit.array_push(var_fragment.dup())
				}
			}
		}
		this.recursivelyReferencedFragments.array_set(var_operation, var_fragments.dup())
	}
	return var_fragments.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getfragmentspreads(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_HasSelectionSet) rt.PhpVal {
	mut var_node_mutated := var_node
	mut var_spreads := if !(this.fragmentSpreads.array_get(var_node_mutated)).is_null() { this.fragmentSpreads.array_get(var_node_mutated) } else { rt.new_null() }
	if rt.is_true(rt.identical(var_spreads, rt.new_null())) {
		var_spreads = rt.new_array()
		mut var_setsToVisit := rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_node_mutated, 'getSelectionSet', []rt.PhpVal{}) }])
		for rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_set := rt.call_function('array_pop', [var_setsToVisit.dup()])
			{
				mut iter_1 := rt.get_property(var_set, 'selections').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_selection := item_1.val
					if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode'))) {
						var_spreads.array_push(var_selection.dup())
					} else {
						rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode'))) || rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode'))))])
						mut var_selectionSet := rt.get_property(var_selection, 'selectionSet')
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							var_setsToVisit.array_push(var_selectionSet.dup())
						}
					}
				}
			}
		}
		this.fragmentSpreads.array_set(var_node_mutated, var_spreads.dup())
	}
	return var_spreads.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getfragment(name string) rt.PhpVal {
	if !(!(this.fragments).is_null()) {
		mut var_fragments := rt.new_array()
		{
			mut iter_1 := rt.get_property(this.getdocument(), 'definitions').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_statement := item_1.val
				if rt.is_true(rt.new_bool(rt.instance_of(var_statement, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode'))) {
					var_fragments.array_set(rt.get_property(rt.get_property(var_statement, 'name'), 'value'), var_statement.dup())
				}
			}
		}
		this.fragments = var_fragments.dup()
	}
	return if !(this.fragments.array_get(name)).is_null() { this.fragments.array_get(name) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) gettype() rt.PhpVal {
	return rt.call_method(this.typeInfo, 'getType', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getparenttype() rt.PhpVal {
	return rt.call_method(this.typeInfo, 'getParentType', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getinputtype() rt.PhpVal {
	return rt.call_method(this.typeInfo, 'getInputType', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getparentinputtype() rt.PhpVal {
	return rt.call_method(this.typeInfo, 'getParentInputType', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getfielddef() rt.PhpVal {
	return rt.call_method(this.typeInfo, 'getFieldDef', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getdirective() rt.PhpVal {
	return rt.call_method(this.typeInfo, 'getDirective', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) getargument() rt.PhpVal {
	return rt.call_method(this.typeInfo, 'getArgument', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SplObjectStorage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_queryvalidationcontext(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext{
		PhpObjectBase: rt.PhpObjectBase{}
		schema: rt.new_null()
		ast: rt.new_null()
		errors: rt.new_array()
		typeInfo: rt.new_null()
		fragments: rt.new_null()
		fragmentSpreads: rt.new_null()
		recursivelyReferencedFragments: rt.new_null()
		variableUsages: rt.new_null()
		recursiveVariableUsages: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_splobjectstorage() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SplObjectStorage {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SplObjectStorage{
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

fn create_automattic_woocommerce_vendor_graphql_language_visitor() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'reportError' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error](if args.len > 0 { args[0] } else { rt.new_null() })
			this.reporterror(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getErrors' {
			return this.geterrors()
		}
		'getDocument' {
			return this.getdocument()
		}
		'getSchema' {
			return this.getschema()
		}
		'getRecursiveVariableUsages' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getrecursivevariableusages(mut dispatch_arg_0)
		}
		'getVariableUsages' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_HasSelectionSet](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvariableusages(mut dispatch_arg_0)
		}
		'getRecursivelyReferencedFragments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getrecursivelyreferencedfragments(mut dispatch_arg_0)
		}
		'getFragmentSpreads' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_HasSelectionSet](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getfragmentspreads(mut dispatch_arg_0)
		}
		'getFragment' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getfragment(dispatch_arg_0)
		}
		'getType' {
			return this.gettype()
		}
		'getParentType' {
			return this.getparenttype()
		}
		'getInputType' {
			return this.getinputtype()
		}
		'getParentInputType' {
			return this.getparentinputtype()
		}
		'getFieldDef' {
			return this.getfielddef()
		}
		'getDirective' {
			return this.getdirective()
		}
		'getArgument' {
			return this.getargument()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		'ast' { return this.ast }
		'errors' { return this.errors }
		'typeInfo' { return this.typeInfo }
		'fragments' { return this.fragments }
		'fragmentSpreads' { return this.fragmentSpreads }
		'recursivelyReferencedFragments' { return this.recursivelyReferencedFragments }
		'variableUsages' { return this.variableUsages }
		'recursiveVariableUsages' { return this.recursiveVariableUsages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' { this.schema = val; return true }
		'ast' { this.ast = val; return true }
		'errors' { this.errors = val; return true }
		'typeInfo' { this.typeInfo = val; return true }
		'fragments' { this.fragments = val; return true }
		'fragmentSpreads' { this.fragmentSpreads = val; return true }
		'recursivelyReferencedFragments' { this.recursivelyReferencedFragments = val; return true }
		'variableUsages' { this.variableUsages = val; return true }
		'recursiveVariableUsages' { this.recursiveVariableUsages = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SplObjectStorage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SplObjectStorage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SplObjectStorage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_queryvalidationcontext_php() {
	// unsupported statement: Stmt_Declare
}

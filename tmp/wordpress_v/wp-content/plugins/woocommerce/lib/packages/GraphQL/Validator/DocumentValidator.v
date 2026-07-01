import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	rt.PhpObjectBase
pub mut:
		rules rt.PhpVal = rt.new_array()
		defaultRules rt.PhpVal = rt.new_null()
		securityRules rt.PhpVal = rt.new_null()
		sdlRules rt.PhpVal = rt.new_null()
		initRules rt.PhpVal = rt.new_bool(false)
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.validate(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_ast Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_rules Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?array, mut var_typeInfo Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?TypeInfo) rt.PhpVal {
	// unsupported expression: Expr_AssignOp_Coalesce
	if rt.is_true(rt.identical(var_rules, rt.new_array())) {
		return rt.new_array()
	}
	// unsupported expression: Expr_AssignOp_Coalesce
	mut var_context := create_automattic_woocommerce_vendor_graphql_validator_queryvalidationcontext(var_schema.dup(), var_ast.dup(), var_typeInfo.dup())
	mut var_visitors := rt.new_array()
	{
		mut iter_1 := var_rules.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_rule := item_1.val
			var_visitors.array_push(rt.call_method(var_rule, 'getVisitor', [var_context.dup()]))
		}
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.visit(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode', []string{}, var_ast), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.visitwithtypeinfo(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_?TypeInfo', []string{}, var_typeInfo), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.visitinparallel(arg_0) }(var_visitors.dup())))
	return rt.call_method(var_context, 'getErrors', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.allrules() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.defaultrules() rt.PhpVal {
	return // unsupported expression: Expr_AssignOp_Coalesce
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.securityrules() rt.PhpVal {
	return // unsupported expression: Expr_AssignOp_Coalesce
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.sdlrules() rt.PhpVal {
	return // unsupported expression: Expr_AssignOp_Coalesce
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.getrule(name string) rt.PhpVal {
	return if !(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.allrules().array_get(name)).is_null() { Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.allrules().array_get(name) } else { rt.new_null() }
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.addrule(mut var_rule Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule)  {
	// unsupported expression: Expr_StaticPropertyFetch.array_set(var_rule.getname(), var_rule.dup())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.removerule(mut var_rule Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule)  {
	// unsupported expression: Expr_StaticPropertyFetch.array_unset(var_rule.getname())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.validatesdl(mut var_documentAST Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_schemaToExtend Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?Schema, mut var_rules Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?array) rt.PhpVal {
	// unsupported expression: Expr_AssignOp_Coalesce
	if rt.is_true(rt.identical(var_rules, rt.new_array())) {
		return rt.new_array()
	}
	mut var_context := create_automattic_woocommerce_vendor_graphql_validator_sdlvalidationcontext(var_documentAST.dup(), var_schemaToExtend.dup())
	mut var_visitors := rt.new_array()
	{
		mut iter_1 := var_rules.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_rule := item_1.val
			var_visitors.array_push(rt.call_method(var_rule, 'getSDLVisitor', [var_context.dup()]))
		}
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.visit(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode', []string{}, var_documentAST), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.visitinparallel(arg_0) }(var_visitors.dup()))
	return rt.call_method(var_context, 'getErrors', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.assertvalidsdl(mut var_documentAST Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode)  {
	mut var_errors := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.validatesdl(mut var_documentAST)
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.combineerrormessages(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_array](var_errors)))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.assertvalidsdlextension(mut var_documentAST Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema)  {
	mut var_errors := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.validatesdl(mut var_documentAST, mut var_schema)
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.combineerrormessages(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_array](var_errors)))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.combineerrormessages(mut var_errors Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_array) string {
	mut var_errors_mutated := var_errors
	mut var_messages := rt.new_array()
	{
		mut iter_1 := var_errors_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_error := item_1.val
			var_messages.array_push(rt.call_method(var_error, 'getMessage', []rt.PhpVal{}))
		}
	}
	return (rt.call_function('implode', [rt.new_string('\n\n'), var_messages.dup()])).str()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_documentvalidator() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{
		PhpObjectBase: rt.PhpObjectBase{}
		rules: rt.new_array()
		defaultRules: rt.new_null()
		securityRules: rt.new_null()
		sdlRules: rt.new_null()
		initRules: rt.new_bool(false)
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_queryvalidationcontext() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext{
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

fn create_automattic_woocommerce_vendor_graphql_validator_sdlvalidationcontext() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'validate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?TypeInfo](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.validate(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'allRules' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.allrules()
		}
		'defaultRules' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.defaultrules()
		}
		'securityRules' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.securityrules()
		}
		'sdlRules' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.sdlrules()
		}
		'getRule' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.getrule(dispatch_arg_0)
		}
		'addRule' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.addrule(mut dispatch_arg_0)
			return rt.new_null()
		}
		'removeRule' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.removerule(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validateSDL' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.validatesdl(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'assertValidSDL' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.assertvalidsdl(mut dispatch_arg_0)
			return rt.new_null()
		}
		'assertValidSDLExtension' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.assertvalidsdlextension(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'combineErrorMessages' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.combineerrormessages(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rules' { return this.rules }
		'defaultRules' { return this.defaultRules }
		'securityRules' { return this.securityRules }
		'sdlRules' { return this.sdlRules }
		'initRules' { return this.initRules }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rules' { this.rules = val; return true }
		'defaultRules' { this.defaultRules = val; return true }
		'securityRules' { this.securityRules = val; return true }
		'sdlRules' { this.sdlRules = val; return true }
		'initRules' { this.initRules = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_documentvalidator_php() {
	// unsupported statement: Stmt_Declare
}

import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_vendor_graphql_validator_documentvalidator() {
		rt.init_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'rules', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'defaultRules', rt.new_null())
		rt.init_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'securityRules', rt.new_null())
		rt.init_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'sdlRules', rt.new_null())
		rt.init_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'initRules', rt.new_bool(false))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.validate(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_ast Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_rules Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?array, mut var_typeInfo Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?TypeInfo) rt.PhpVal {
	rt.new_null()
	if rt.is_true(rt.identical(var_rules, rt.new_array())) {
		return rt.new_array()
	}
	rt.new_null()
	mut var_context := create_automattic_woocommerce_vendor_graphql_validator_queryvalidationcontext(var_schema, var_ast, var_typeInfo)
	mut var_visitors := rt.new_array()
	mut iter_1 := var_rules.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_rule := item_1.val
		var_visitors.array_push(rt.call_method(var_rule, 'getVisitor', [var_context.clone()]))
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
	mut iife_result_0 := iife_temp_0.visitinparallel(var_visitors.clone())
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
	mut iife_result_1 := iife_temp_1.visitwithtypeinfo(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_?TypeInfo', []string{}, var_typeInfo), iife_result_0)
	mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
	mut iife_result_2 := iife_temp_2.visit(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode', []string{}, var_ast), iife_result_1)
	return rt.call_method(var_context, 'getErrors', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.allrules() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'initRules'))))) {
		rt.set_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'rules', rt.call_function('array_merge', [Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.defaultrules(), Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.securityrules(), rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'rules')]))
		rt.set_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'initRules', rt.new_bool(true))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'rules')
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.defaultrules() rt.PhpVal {
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.securityrules() rt.PhpVal {
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.sdlrules() rt.PhpVal {
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.getrule(name string) rt.PhpVal {
	return if !(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.allrules().array_get(rt.new_string(name))).is_null() { Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.allrules().array_get(rt.new_string(name)) } else { rt.new_null() }
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.addrule(mut var_rule Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) {
	rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'rules').array_set(var_rule.getname(), var_rule)
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.removerule(mut var_rule Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) {
	rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator', 'rules').array_unset(var_rule.getname())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.validatesdl(mut var_documentAST Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_schemaToExtend Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?Schema, mut var_rules Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?array) rt.PhpVal {
	rt.new_null()
	if rt.is_true(rt.identical(var_rules, rt.new_array())) {
		return rt.new_array()
	}
	mut var_context := create_automattic_woocommerce_vendor_graphql_validator_sdlvalidationcontext(var_documentAST, var_schemaToExtend)
	mut var_visitors := rt.new_array()
	mut iter_2 := var_rules.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_rule := item_2.val
		var_visitors.array_push(rt.call_method(var_rule, 'getSDLVisitor', [var_context.clone()]))
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
	mut iife_result_3 := iife_temp_3.visitinparallel(var_visitors.clone())
	mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
	mut iife_result_4 := iife_temp_4.visit(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode', []string{}, var_documentAST), iife_result_3)
	return rt.call_method(var_context, 'getErrors', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.assertvalidsdl(mut var_documentAST Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode) {
	mut var_errors := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.validatesdl(mut var_documentAST)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_errors, rt.new_array())))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.combineerrormessages(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_array](var_errors)))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.assertvalidsdlextension(mut var_documentAST Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) {
	mut var_errors := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.validatesdl(mut var_documentAST, mut var_schema)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_errors, rt.new_array())))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.combineerrormessages(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_array](var_errors)))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator.combineerrormessages(mut var_errors Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_array) string {
	mut var_errors_mutated := var_errors
	mut var_messages := rt.new_array()
	mut iter_3 := var_errors_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_error := item_3.val
		var_messages.array_push(rt.call_method(var_error, 'getMessage', []rt.PhpVal{}))
	}
	return (rt.call_function('implode', [rt.new_string('\n\n'), var_messages.clone()])).str()
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

fn create_automattic_woocommerce_vendor_graphql_validator_documentvalidator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_queryvalidationcontext(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext{
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

fn create_automattic_woocommerce_vendor_graphql_validator_sdlvalidationcontext(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext{
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
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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



fn main() {
	defer {
		rt.shutdown()
	}

}

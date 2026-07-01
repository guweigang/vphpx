import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType {
	rt.PhpObjectBase
pub mut:
		config rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) construct(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array)  {
	this.Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType.construct(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array', []string{}, var_config))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) serialize(var_value rt.PhpVal) rt.PhpVal {
	if this.config.array_isset(rt.new_string('serialize')) {
		return rt.call_callable(this.config.array_get('serialize'), [var_value.dup()])
	}
	return var_value.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) parsevalue(var_value rt.PhpVal) rt.PhpVal {
	if this.config.array_isset(rt.new_string('parseValue')) {
		return rt.call_callable(this.config.array_get('parseValue'), [var_value.dup()])
	}
	return var_value.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) parseliteral(mut var_valueNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_variables Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array) rt.PhpVal {
	if this.config.array_isset(rt.new_string('parseLiteral')) {
		return rt.call_callable(this.config.array_get('parseLiteral'), [var_valueNode, var_variables])
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.valuefromastuntyped(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array', []string{}, var_variables))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) assertvalid()  {
	this.Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType.assertvalid()
	mut var_serialize := if !(this.config.array_get('serialize')).is_null() { this.config.array_get('serialize') } else { rt.new_null() }
	mut var_parseValue := if !(this.config.array_get('parseValue')).is_null() { this.config.array_get('parseValue') } else { rt.new_null() }
	mut var_parseLiteral := if !(this.config.array_get('parseLiteral')).is_null() { this.config.array_get('parseLiteral') } else { rt.new_null() }
	mut var_hasSerialize := // unsupported expression: Expr_BinaryOp_NotIdentical
	mut var_hasParseValue := // unsupported expression: Expr_BinaryOp_NotIdentical
	mut var_hasParseLiteral := // unsupported expression: Expr_BinaryOp_NotIdentical
	mut var_hasParse := rt.new_bool(rt.new_bool(rt.is_true(var_hasParseValue) && rt.is_true(var_hasParseLiteral)))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType'], &this), 'name'), rt.new_string(' must provide both "parseValue" and "parseLiteral" functions to work as an input type.')))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_hasSerialize)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_hasParse)))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType'], &this), 'name'), rt.new_string(' must provide "parseValue" and "parseLiteral" functions, "serialize" function, or both.')))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_hasSerialize) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_serialize.dup()]))))))) {
		mut var_notCallable := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_serialize.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType'], &this), 'name'), rt.new_string(' must provide "serialize" as a callable if given, but got: ')), var_notCallable), rt.new_string('.')))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_hasParseValue) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_parseValue.dup()]))))))) {
		var_notCallable = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_parseValue.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType'], &this), 'name'), rt.new_string(' must provide "parseValue" as a callable if given, but got: ')), var_notCallable), rt.new_string('.')))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_hasParseLiteral) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_parseLiteral.dup()]))))))) {
		var_notCallable = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_parseLiteral.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType'], &this), 'name'), rt.new_string(' must provide "parseLiteral" as a callable if given, but got: ')), var_notCallable), rt.new_string('.')))))
	}
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_customscalartype(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType{
		PhpObjectBase: rt.PhpObjectBase{}
		config: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_scalartype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_ast() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
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

fn create_automattic_woocommerce_vendor_graphql_utils_utils() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'serialize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.serialize(dispatch_arg_0)
		}
		'parseValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parsevalue(dispatch_arg_0)
		}
		'parseLiteral' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.parseliteral(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'assertValid' {
			this.assertvalid()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'config' { return this.config }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'config' { this.config = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_customscalartype_php() {
	// unsupported statement: Stmt_Declare
}

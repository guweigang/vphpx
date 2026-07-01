import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.doprint(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	mut var_directive := rt.new_null()
	mut var_type := rt.new_null()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_directive := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}; return temp.isspecifieddirective(arg_0) }(var_directive.dup()))))
	}
	mut var_type := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(rt.is_true(rt.call_method(var_type, 'isBuiltInType', []rt.PhpVal{}))))
	}
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfilteredschema(mut var_schema, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](rt.new_closure(closure_1_fn)), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](rt.new_closure(closure_2_fn)), mut var_options)).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printintrospectionschema(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfilteredschema(mut var_schema, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.class() }, rt.ArrayItem{ key: none, val: 'isSpecifiedDirective' }])), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.class() }, rt.ArrayItem{ key: none, val: 'isIntrospectionType' }])), mut var_options)).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printtype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType'))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printscalar(mut var_type, mut var_options)).str()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printobject(mut var_type, mut var_options)).str()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinterface(mut var_type, mut var_options)).str()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType'))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printunion(mut var_type, mut var_options)).str()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType'))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printenum(mut var_type, mut var_options)).str()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType'))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputobject(mut var_type, mut var_options)).str()
	}
	mut var_unknownType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type))
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Unknown type: ${var_unknownType.to_string()}."))))
	return ''
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfilteredschema(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_directiveFilter Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable, mut var_typeFilter Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	mut var_directives := rt.call_function('array_filter', [var_schema.getdirectives(), var_directiveFilter])
	mut var_types := rt.call_function('array_filter', [var_schema.gettypemap(), var_typeFilter])
	if rt.is_true(rt.new_bool(var_options.array_isset(rt.new_string('sortTypes')) && rt.is_true(var_options.array_get('sortTypes')))) {
		rt.call_function('ksort', [var_types.dup()])
	}
	mut var_elements := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printschemadefinition(mut var_schema) }])
	{
		mut iter_1 := var_directives.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_directive := item_1.val
			var_elements.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdirective(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](var_directive), mut var_options))
		}
	}
	{
		mut iter_1 := var_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			var_elements.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type), mut var_options))
		}
	}
	return (rt.call_function('implode', [rt.new_string('\n\n'), rt.call_function('array_filter', [var_elements.dup()])])).str() + '\n'
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printschemadefinition(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) string {
	mut var_queryType := var_schema.getquerytype()
	mut var_mutationType := var_schema.getmutationtype()
	mut var_subscriptionType := var_schema.getsubscriptiontype()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_queryType, rt.new_null())) && rt.is_true(rt.identical(var_mutationType, rt.new_null())))) && rt.is_true(rt.identical(var_subscriptionType, rt.new_null())))) {
		return (rt.new_null()).str()
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.hasdefaultrootoperationtypes(mut var_schema))))))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.new_array()), var_schema)).str() + 'schema {\n' + if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.concat(rt.concat(rt.new_string('  query: '), rt.get_property(var_queryType, 'name')), rt.new_string('\n')) } else { '' } + if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.concat(rt.concat(rt.new_string('  mutation: '), rt.get_property(var_mutationType, 'name')), rt.new_string('\n')) } else { '' } + if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.concat(rt.concat(rt.new_string('  subscription: '), rt.get_property(var_subscriptionType, 'name')), rt.new_string('\n')) } else { '' } + '}'
	}
	return (rt.new_null()).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.hasdefaultrootoperationtypes(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) bool {
	return rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_schema.getquerytype(), var_schema.gettype(rt.new_string('Query')))) && rt.is_true(rt.identical(var_schema.getmutationtype(), var_schema.gettype(rt.new_string('Mutation')))))) && rt.is_true(rt.identical(var_schema.getsubscriptiontype(), var_schema.gettype(rt.new_string('Subscription'))))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdirective(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_directive)).str() + 'directive @' + (rt.get_property(var_directive, 'name')).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printargs(mut var_options, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.get_property(var_directive, 'args')))).str() + if rt.is_true(rt.get_property(var_directive, 'isRepeatable')) { ' repeatable' } else { '' } + ' on ' + (rt.call_function('implode', [rt.new_string(' | '), rt.get_property(var_directive, 'locations')])).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, var_def rt.PhpVal, indentation string, firstInBlock bool) string {
	mut firstInBlock_mutated := firstInBlock
	mut var_description := rt.get_property(var_def, 'description')
	if rt.is_true(rt.identical(var_description, rt.new_null())) {
		return ''
	}
	mut var_prefix := rt.new_string(if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(firstInBlock_mutated))))))) { rt.new_string("\n${var_indentation}") } else { rt.new_string(indentation) })
	if fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.splitlines(arg_0) }(var_description.dup()).array_count() == 1 {
		var_description = rt.new_string(rt.new_string(rt.json_encode(var_description.dup())))
	} else {
		var_description = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString{}; return temp.print(arg_0) }(var_description.dup())
		var_description = if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_function('str_replace', [rt.new_string('\n'), rt.new_string("\n${var_indentation}"), var_description.dup()]) } else { var_description }
	}
	return "${var_prefix.to_string()}${var_description.to_string()}\n"
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printargs(mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_args Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, indentation string) string {
	mut var_left := rt.new_null()
	mut var_right := rt.new_null()
	if rt.is_true(rt.identical(var_args, rt.new_array())) {
		return ''
	}
	if rt.is_true(rt.new_bool(var_options.array_isset(rt.new_string('sortArguments')) && rt.is_true(var_options.array_get('sortArguments')))) {
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_left := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_right := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_BinaryOp_Spaceship
	}
		rt.call_function('usort', [var_args, rt.new_closure(closure_3_fn)])
	}
	mut var_allArgsWithoutDescription := rt.new_bool(rt.new_bool(true))
	{
		mut iter_1 := var_args.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_arg := item_1.val
			mut var_description := rt.get_property(var_arg, 'description')
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_allArgsWithoutDescription = rt.new_bool(rt.new_bool(false))
				break
			}
		}
	}
	if rt.is_true(var_allArgsWithoutDescription) {
		return '(' + (rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static.class() }, rt.ArrayItem{ key: none, val: 'printInputValue' }]), var_args])])).str() + ')'
	}
	mut var_argsStrings := rt.new_array()
	mut var_firstInBlock := rt.new_bool(rt.new_bool(true))
	mut var_previousHasDescription := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_args.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_arg := item_1.val
			mut var_hasDescription := // unsupported expression: Expr_BinaryOp_NotIdentical
			if rt.is_true(rt.new_bool(rt.is_true(var_previousHasDescription) && rt.is_true(rt.new_bool(!(rt.is_true(var_hasDescription)))))) {
				var_argsStrings.array_push('')
			}
			var_argsStrings.array_push((Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, (var_arg).str(), '  ' + indentation, var_firstInBlock.dup())).str() + '  ' + indentation + (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputvalue(var_arg.dup())).str())
			var_firstInBlock = rt.new_bool(rt.new_bool(false))
			var_previousHasDescription = var_hasDescription.dup()
		}
	}
	return '(\n' + (rt.call_function('implode', [rt.new_string('\n'), var_argsStrings.dup()])).str() + '\n' + indentation + ')'
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputvalue(var_arg rt.PhpVal) string {
	mut var_argDecl := rt.new_string(rt.concat(rt.concat(rt.get_property(var_arg, 'name'), rt.new_string(': ')), rt.call_method(rt.call_method(var_arg, 'getType', []rt.PhpVal{}), 'toString', []rt.PhpVal{})))
	if rt.is_true(rt.call_method(var_arg, 'defaultValueExists', []rt.PhpVal{})) {
		mut var_defaultValueAST := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.astfromvalue(arg_0, arg_1) }(rt.get_property(var_arg, 'defaultValue'), rt.call_method(var_arg, 'getType', []rt.PhpVal{}))
		if rt.is_true(rt.identical(var_defaultValueAST, rt.new_null())) {
			mut var_inconvertibleDefaultValue := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(rt.get_property(var_arg, 'defaultValue'))
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Unable to convert defaultValue of argument '), rt.get_property(var_arg, 'name')), rt.new_string(' into AST: ')), var_inconvertibleDefaultValue), rt.new_string('.')))))
		}
		mut var_printedDefaultValue := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}; return temp.doprint(arg_0) }(var_defaultValueAST.dup())
		// unsupported expression: Expr_AssignOp_Concat
	}
	return (var_argDecl).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdeprecated(var_arg.dup())).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printscalar(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_type)).str() + rt.concat(rt.new_string('scalar '), rt.get_property(var_type, 'name'))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printobject(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_type)).str() + rt.concat(rt.new_string('type '), rt.get_property(var_type, 'name')) + (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printimplementedinterfaces(mut var_type)).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfields(mut var_options, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', []string{}, var_type))).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfields(mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, var_type rt.PhpVal) string {
	mut var_fields := rt.new_array()
	mut var_firstInBlock := rt.new_bool(rt.new_bool(true))
	mut var_previousHasDescription := rt.new_bool(rt.new_bool(false))
	mut var_fieldDefinitions := rt.call_method(var_type, 'getFields', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_options.array_isset(rt.new_string('sortFields')) && rt.is_true(var_options.array_get('sortFields')))) {
		rt.call_function('ksort', [var_fieldDefinitions.dup()])
	}
	{
		mut iter_1 := var_fieldDefinitions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_f := item_1.val
			mut var_hasDescription := // unsupported expression: Expr_BinaryOp_NotIdentical
			if rt.is_true(rt.new_bool(rt.is_true(var_previousHasDescription) && rt.is_true(rt.new_bool(!(rt.is_true(var_hasDescription)))))) {
				var_fields.array_push('')
			}
			var_fields.array_push( + ().str() + ': ' + (rt.call_method(rt.call_method(, 'getType', []rt.PhpVal{}), 'toString', []rt.PhpVal{})).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdeprecated(var_f.dup())).str())
			var_firstInBlock = rt.new_bool(rt.new_bool(false))
			var_previousHasDescription = var_hasDescription.dup()
		}
	}
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_fields))).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdeprecated(var_deprecation rt.PhpVal) string {
	mut var_reason := 
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printimplementedinterfaces(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType) string {
	mut var_interface := rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinterface(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printunion(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printenum(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	mut var_left := rt.new_null()
	mut var_right := rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputobject(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printblock(mut var_items Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_schemaprinter() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_directive() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{
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

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_blockstring() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString{
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

fn create_automattic_woocommerce_vendor_graphql_language_printer() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'doPrint' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.doprint(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'printIntrospectionSchema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printintrospectionschema(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'printType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printtype(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'printFilteredSchema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 3 { args[3] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfilteredschema(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3))
		}
		'printSchemaDefinition' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printschemadefinition(mut dispatch_arg_0))
		}
		'hasDefaultRootOperationTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.hasdefaultrootoperationtypes(mut dispatch_arg_0))
		}
		'printDirective' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdirective(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'printDescription' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'printArgs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printargs(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'printInputValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputvalue(dispatch_arg_0))
		}
		'printScalar' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printscalar(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'printObject' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printobject(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'printFields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfields(mut dispatch_arg_0, dispatch_arg_1))
		}
		'printDeprecated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdeprecated(dispatch_arg_0))
		}
		'printImplementedInterfaces' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printimplementedinterfaces(mut dispatch_arg_0))
		}
		'printInterface' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinterface(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'printUnion' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printunion(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'printEnum' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printenum(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'printInputObject' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputobject(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'printBlock' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printblock(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_utils_schemaprinter_php() {
	// unsupported statement: Stmt_Declare
}

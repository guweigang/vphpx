import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.doprint(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	mut var_directive := rt.new_null()
	mut var_type := rt.new_null()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_directive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
		mut iife_result_1 := iife_temp_1.isspecifieddirective(var_directive.clone())
		return rt.new_bool(!(rt.is_true(iife_result_1)))
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_type := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(rt.is_true(rt.call_method(var_type, 'isBuiltInType', []rt.PhpVal{}))))
	}
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfilteredschema(mut var_schema, mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](rt.new_closure(closure_2_fn)), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](rt.new_closure(closure_3_fn)), mut
		var_options)).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printintrospectionschema(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfilteredschema(mut var_schema, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.class()
		},
		rt.ArrayItem{ key: none, val: 'isSpecifiedDirective' },
	])), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.class()
		},
		rt.ArrayItem{ key: none, val: 'isIntrospectionType' },
	])), mut var_options)).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printtype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType')))
	{
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printscalar(mut var_type, mut
			var_options)).str()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))
	{
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printobject(mut var_type, mut
			var_options)).str()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_type),
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))
	{
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinterface(mut var_type, mut
			var_options)).str()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))
	{
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printunion(mut var_type, mut
			var_options)).str()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType')))
	{
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printenum(mut var_type, mut
			var_options)).str()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_type),
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))
	{
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputobject(mut var_type, mut
			var_options)).str()
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_3 := iife_temp_3.printsafe(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_type))
	mut var_unknownType := iife_result_3
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error',
		[]string{},
		create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('Unknown type: ${var_unknownType.to_string()}.'))))
	return ''
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfilteredschema(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_directiveFilter Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable, mut var_typeFilter Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	mut var_directives := rt.call_function('array_filter', [var_schema.getdirectives(),
		var_directiveFilter])
	mut var_types := rt.call_function('array_filter', [var_schema.gettypemap(), var_typeFilter])
	if var_options.array_isset(rt.new_string('sortTypes'))
		&& rt.is_true(var_options.array_get(rt.new_string('sortTypes'))) {
		rt.call_function('ksort', [var_types.clone()])
	}
	mut var_elements := rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printschemadefinition(mut var_schema)
		},
	])
	mut iter_1 := var_directives.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_directive := item_1.val
		var_elements.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdirective(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](var_directive), mut
			var_options))
	}
	mut iter_2 := var_types.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_type := item_2.val
		var_elements.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type), mut
			var_options))
	}
	return
		(rt.call_function('implode', [rt.new_string('\n\n'), rt.call_function('array_filter', [var_elements.clone()])])).str() +
		'\n'
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printschemadefinition(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) string {
	mut var_queryType := var_schema.getquerytype()
	mut var_mutationType := var_schema.getmutationtype()
	mut var_subscriptionType := var_schema.getsubscriptiontype()
	if rt.is_true(rt.identical(var_queryType, rt.new_null()))
		&& rt.is_true(rt.identical(var_mutationType, rt.new_null()))
		&& rt.is_true(rt.identical(var_subscriptionType, rt.new_null())) {
		return (rt.new_null()).str()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_schema, 'description'), rt.new_null()))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.hasdefaultrootoperationtypes(mut var_schema))))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.new_array()), var_schema)).str() + 'schema {\n' + if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_queryType, rt.new_null())))) {
			rt.concat(rt.concat(rt.new_string('  query: '), rt.get_property(var_queryType, 'name')), rt.new_string('\n'))
		} else {
			''
		} + if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_mutationType, rt.new_null())))) {
			rt.concat(rt.concat(rt.new_string('  mutation: '), rt.get_property(var_mutationType, 'name')), rt.new_string('\n'))
		} else {
			''
		} + if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_subscriptionType, rt.new_null())))) {
			rt.concat(rt.concat(rt.new_string('  subscription: '), rt.get_property(var_subscriptionType, 'name')), rt.new_string('\n'))
		} else {
			''
		} + '}'
	}
	return (rt.new_null()).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.hasdefaultrootoperationtypes(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) bool {
	return
		rt.is_true(rt.identical(var_schema.getquerytype(), var_schema.gettype(rt.new_string('Query'))))
		&& rt.is_true(rt.identical(var_schema.getmutationtype(), var_schema.gettype(rt.new_string('Mutation'))))
		&& rt.is_true(rt.identical(var_schema.getsubscriptiontype(), var_schema.gettype(rt.new_string('Subscription'))))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdirective(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	return
		(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_directive)).str() +
		'directive @' + (rt.get_property(var_directive, 'name')).str() +
		(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printargs(mut var_options, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.get_property(var_directive, 'args')))).str() +
		if rt.is_true(rt.get_property(var_directive, 'isRepeatable')) {
		' repeatable'
	} else {
		''
	} +
		' on ' +(rt.call_function('implode', [rt.new_string(' | '), rt.get_property(var_directive, 'locations')])).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, var_def rt.PhpVal, indentation string, firstInBlock bool) string {
	mut firstInBlock_mutated := firstInBlock
	mut var_description := rt.get_property(var_def, 'description')
	if rt.is_true(rt.identical(var_description, rt.new_null())) {
		return ''
	}
	mut var_prefix := rt.new_string((if rt.is_true(rt.new_bool(indentation != ''))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(firstInBlock_mutated))))) {
		'\n${var_indentation}'
	} else {
		indentation
	}).str())
	mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_4 := iife_temp_4.splitlines(var_description.clone())
	mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_5 := iife_temp_5.splitlines(var_description.clone())
	if iife_result_4.array_count() == 1 {
		var_description = rt.new_string(rt.json_encode(var_description.clone()))
	} else {
		mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString{}
		mut iife_result_6 := iife_temp_6.print(var_description.clone())
		var_description = iife_result_6
		var_description = if rt.is_true(rt.new_bool(indentation != '')) { rt.call_function('str_replace', [
				rt.new_string('\n'),
				rt.new_string('\n${var_indentation}'),
				var_description.clone(),
			]) } else { var_description }
	}
	return '${var_prefix.to_string()}${var_description.to_string()}\n'
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printargs(mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_args Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, indentation string) string {
	mut var_left := rt.new_null()
	mut var_right := rt.new_null()
	if rt.is_true(rt.identical(var_args, rt.new_array())) {
		return ''
	}
	if var_options.array_isset(rt.new_string('sortArguments'))
		&& rt.is_true(var_options.array_get(rt.new_string('sortArguments'))) {
		closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_left := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_right := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return rt.new_null()
		}
		rt.call_function('usort', [var_args, rt.new_closure(closure_8_fn)])
	}
	mut var_allArgsWithoutDescription := rt.new_bool(true)
	mut iter_3 := var_args.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_arg := item_3.val
		mut var_description := rt.get_property(var_arg, 'description')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_description, rt.new_null()))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_description, rt.new_string(''))))) {
			var_allArgsWithoutDescription = rt.new_bool(false)
			break
		}
	}
	if rt.is_true(var_allArgsWithoutDescription) {
		return '(' +
			(rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_map', [rt.create_array([rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static.class()
		}, rt.ArrayItem{ key: none, val: 'printInputValue' }]), var_args])])).str() +
			')'
	}
	mut var_argsStrings := rt.new_array()
	mut var_firstInBlock := rt.new_bool(true)
	mut var_previousHasDescription := rt.new_bool(false)
	mut iter_4 := var_args.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_arg := item_4.val
		mut var_hasDescription := rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_arg,
			'description'), rt.new_null())))
		if rt.is_true(var_previousHasDescription)
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_hasDescription)))) {
			var_argsStrings.array_push('')
		}
		var_argsStrings.array_push(
			(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_arg.str(), '  ' + indentation, var_firstInBlock.clone())).str() +
			'  ' + indentation +(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputvalue(var_arg.clone())).str())
		var_firstInBlock = rt.new_bool(false)
		var_previousHasDescription = var_hasDescription.clone()
	}
	return '(\n' +
		(rt.call_function('implode', [rt.new_string('\n'), var_argsStrings.clone()])).str() + '\n' +
		indentation + ')'
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputvalue(var_arg rt.PhpVal) string {
	mut var_argDecl := rt.new_string((rt.concat(rt.concat(rt.get_property(var_arg, 'name'),
		rt.new_string(': ')), rt.call_method(rt.call_method(var_arg, 'getType', []rt.PhpVal{}),
		'toString', []rt.PhpVal{}))).str())
	if rt.is_true(rt.call_method(var_arg, 'defaultValueExists', []rt.PhpVal{})) {
		mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
		mut iife_result_8 := iife_temp_8.astfromvalue(rt.get_property(var_arg, 'defaultValue'), rt.call_method(var_arg,
			'getType', []rt.PhpVal{}))
		mut var_defaultValueAST := iife_result_8
		if rt.is_true(rt.identical(var_defaultValueAST, rt.new_null())) {
			mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_9 := iife_temp_9.printsafe(rt.get_property(var_arg, 'defaultValue'))
			mut var_inconvertibleDefaultValue := iife_result_9
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
				[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Unable to convert defaultValue of argument '), rt.get_property(var_arg,
				'name')), rt.new_string(' into AST: ')), var_inconvertibleDefaultValue),
				rt.new_string('.')))))
		}
		mut iife_temp_10 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}
		mut iife_result_10 := iife_temp_10.doprint(var_defaultValueAST.clone())
		mut var_printedDefaultValue := iife_result_10
		var_argDecl = rt.concat(var_argDecl,
			rt.new_string(' = ${var_printedDefaultValue.to_string()}'))
	}
	return var_argDecl.str() +(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdeprecated(var_arg.clone())).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printscalar(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	return
		(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_type)).str() +
		rt.concat(rt.new_string('scalar '), rt.get_property(var_type, 'name'))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printobject(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	return
		(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_type)).str() +
		rt.concat(rt.new_string('type '), rt.get_property(var_type, 'name')) +
		(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printimplementedinterfaces(mut var_type)).str() +(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfields(mut var_options, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', []string{}, var_type))).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfields(mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, var_type rt.PhpVal) string {
	mut var_fields := rt.new_array()
	mut var_firstInBlock := rt.new_bool(true)
	mut var_previousHasDescription := rt.new_bool(false)
	mut var_fieldDefinitions := rt.call_method(var_type, 'getFields', []rt.PhpVal{})
	if var_options.array_isset(rt.new_string('sortFields'))
		&& rt.is_true(var_options.array_get(rt.new_string('sortFields'))) {
		rt.call_function('ksort', [var_fieldDefinitions.clone()])
	}
	mut iter_5 := var_fieldDefinitions.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_f := item_5.val
		mut var_hasDescription := rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_f,
			'description'), rt.new_null())))
		if rt.is_true(var_previousHasDescription)
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_hasDescription)))) {
			var_fields.array_push('')
		}
		var_fields.array_push(
			(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_f.str(), '  ', var_firstInBlock.clone())).str() +
			'  ' + (rt.get_property(var_f, 'name')).str() +
			(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printargs(mut var_options, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.get_property(var_f, 'args')), '  ')).str() +
			': ' +
			(rt.call_method(rt.call_method(var_f, 'getType', []rt.PhpVal{}), 'toString', []rt.PhpVal{})).str() +(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdeprecated(var_f.clone())).str())
		var_firstInBlock = rt.new_bool(false)
		var_previousHasDescription = var_hasDescription.clone()
	}
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_fields))).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdeprecated(var_deprecation rt.PhpVal) string {
	mut var_reason := rt.get_property(var_deprecation, 'deprecationReason')
	if rt.is_true(rt.identical(var_reason, rt.new_null())) {
		return ''
	}
	if rt.is_true(rt.identical(var_reason, rt.new_string('')))
		|| rt.is_true(rt.identical(var_reason, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.default_deprecation_reason())) {
		return ' @deprecated'
	}
	mut iife_temp_11 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_11 := iife_temp_11.string()
	mut iife_temp_12 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
	mut iife_result_12 := iife_temp_12.astfromvalue(var_reason.clone(), iife_result_11)
	mut var_reasonAST := iife_result_12
	rt.call_function('assert', [
		rt.new_bool(rt.instance_of(var_reasonAST,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode')),
	])
	mut iife_temp_13 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}
	mut iife_result_13 := iife_temp_13.doprint(var_reasonAST.clone())
	mut var_reasonASTString := iife_result_13
	return ' @deprecated(reason: ${var_reasonASTString.to_string()})'
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printimplementedinterfaces(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType) string {
	mut var_interface := rt.new_null()
	mut var_interfaces := var_type.getinterfaces()
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_interface := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_interface, 'name')
	}
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_interface := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_interface, 'name')
	}
	return if rt.is_true(rt.identical(var_interfaces, rt.new_array())) {
		''
	} else {
		' implements ' +(rt.call_function('implode', [rt.new_string(' & '), rt.call_function('array_map', [rt.new_closure(closure_15_fn), var_interfaces.clone()])])).str()
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinterface(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	return
		(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_type)).str() +
		rt.concat(rt.new_string('interface '), rt.get_property(var_type, 'name')) +
		(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printimplementedinterfaces(mut var_type)).str() +(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfields(mut var_options, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType', []string{}, var_type))).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printunion(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	mut var_types := var_type.gettypes()
	var_types = rt.new_string((if rt.is_true(rt.identical(var_types, rt.new_array())) {
		''
	} else {
		' = ' + (rt.call_function('implode', [rt.new_string(' | '), var_types.clone()])).str()
	}).str())
	return
		(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_type)).str() +
		'union ' + (rt.get_property(var_type, 'name')).str() + var_types.str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printenum(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	mut var_left := rt.new_null()
	mut var_right := rt.new_null()
	mut var_values := rt.new_array()
	mut var_firstInBlock := rt.new_bool(true)
	mut var_valueDefinitions := var_type.getvalues()
	if var_options.array_isset(rt.new_string('sortEnumValues'))
		&& rt.is_true(var_options.array_get(rt.new_string('sortEnumValues'))) {
		closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_left := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_right := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return rt.new_null()
		}
		rt.call_function('usort', [var_valueDefinitions.clone(),
			rt.new_closure(closure_17_fn)])
	}
	mut iter_6 := var_valueDefinitions.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value := item_6.val
		var_values.array_push(
			(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_value.str(), '  ', var_firstInBlock.clone())).str() +
			'  ' + (rt.get_property(var_value, 'name')).str() +(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdeprecated(var_value.clone())).str())
		var_firstInBlock = rt.new_bool(false)
	}
	return
		(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_type)).str() +
		rt.concat(rt.new_string('enum '), rt.get_property(var_type, 'name')) +(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_values))).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputobject(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	mut var_fields := rt.new_array()
	mut var_firstInBlock := rt.new_bool(true)
	mut var_fieldDefinitions := var_type.getfields()
	if var_options.array_isset(rt.new_string('sortInputFields'))
		&& rt.is_true(var_options.array_get(rt.new_string('sortInputFields'))) {
		rt.call_function('ksort', [var_fieldDefinitions.clone()])
	}
	mut iter_7 := var_fieldDefinitions.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_field := item_7.val
		var_fields.array_push(
			(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_field.str(), '  ', var_firstInBlock.clone())).str() +
			'  ' +(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputvalue(var_field.clone())).str())
		var_firstInBlock = rt.new_bool(false)
	}
	return
		(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut var_options, var_type)).str() +
		rt.concat(rt.new_string('input '), rt.get_property(var_type, 'name')) +
		if rt.is_true(var_type.isoneof()) {
		' @oneOf'
	} else {
		''
	} +(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_fields))).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printblock(mut var_items Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	return if rt.is_true(rt.identical(var_items, rt.new_array())) {
		''
	} else {
		' {\n' + (rt.call_function('implode', [rt.new_string('\n'), var_items])).str() + '\n}'
	}
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

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_schemaprinter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter{
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

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
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

fn create_automattic_woocommerce_vendor_graphql_language_blockstring(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_ast(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
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

fn create_automattic_woocommerce_vendor_graphql_language_printer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'doPrint' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.doprint(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'printIntrospectionSchema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printintrospectionschema(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'printType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printtype(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'printFilteredSchema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfilteredschema(mut dispatch_arg_0, mut
				dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3))
		}
		'printSchemaDefinition' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printschemadefinition(mut dispatch_arg_0))
		}
		'hasDefaultRootOperationTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.hasdefaultrootoperationtypes(mut dispatch_arg_0))
		}
		'printDirective' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdirective(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'printDescription' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdescription(mut dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'printArgs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printargs(mut dispatch_arg_0, mut
				dispatch_arg_1, dispatch_arg_2))
		}
		'printInputValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputvalue(dispatch_arg_0))
		}
		'printScalar' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printscalar(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'printObject' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printobject(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'printFields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printfields(mut dispatch_arg_0,
				dispatch_arg_1))
		}
		'printDeprecated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printdeprecated(dispatch_arg_0))
		}
		'printImplementedInterfaces' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printimplementedinterfaces(mut dispatch_arg_0))
		}
		'printInterface' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinterface(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'printUnion' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printunion(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'printEnum' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printenum(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'printInputObject' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printinputobject(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'printBlock' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaPrinter.printblock(mut dispatch_arg_0))
		}
		else {
			return none
		}
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

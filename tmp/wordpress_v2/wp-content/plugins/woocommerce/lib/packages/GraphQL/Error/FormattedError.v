import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_vendor_graphql_error_formattederror() {
		rt.init_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError', 'internalErrorMessage', rt.new_string('Internal server error'))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.setinternalerrormessage(msg string) {
	rt.set_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError', 'internalErrorMessage', rt.new_string(msg))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.printerror(mut var_error Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) string {
	mut var_printedLocations := rt.new_array()
	mut var_nodes := rt.get_property(var_error, 'nodes')
	if !(var_nodes).is_null() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_nodes, rt.new_array())))) {
		mut iter_1 := var_nodes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_node := item_1.val
			mut var_location := rt.get_property(var_node, 'loc')
			if !(var_location).is_null() {
				mut var_source := rt.get_property(var_location, 'source')
				if !(var_source).is_null() {
					var_printedLocations.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.highlightsourceatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source](var_source), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation](rt.call_method(var_source, 'getLocation', [rt.get_property(var_location, 'start')]))))
				}
			}
		}
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_error.getsource(), rt.new_null())))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_error.getlocations(), rt.new_array())))) {
		mut var_source := var_error.getsource()
		mut iter_2 := var_error.getlocations().iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_location := item_2.val
			var_printedLocations.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.highlightsourceatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source](var_source), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation](var_location)))
		}
	}
	return (if rt.is_true(rt.identical(var_printedLocations, rt.new_array())) { var_error.getmessage() } else { (rt.call_function('implode', [rt.new_string('\n\n'), rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: var_error.getmessage() }]), var_printedLocations.clone()])])).str() + '\n' }).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.highlightsourceatlocation(mut var_source Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source, mut var_location Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) string {
	mut var_source_mutated := var_source
	mut var_location_mutated := var_location
	mut var_line := rt.get_property(var_location_mutated, 'line')
	mut var_lineOffset := rt.sub(rt.get_property(rt.get_property(var_source_mutated, 'locationOffset'), 'line'), rt.new_int(1))
	mut var_columnOffset := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.getcolumnoffset(mut var_source_mutated, mut var_location_mutated)
	mut var_contextLine := rt.add(var_line, var_lineOffset)
	mut var_contextColumn := rt.add(rt.get_property(var_location_mutated, 'column'), var_columnOffset)
	mut var_prevLineNum := rt.new_string((rt.sub(var_contextLine, rt.new_int(1))).str())
	mut var_lineNum := rt.new_string((var_contextLine).str())
	mut var_nextLineNum := rt.new_string((rt.add(var_contextLine, rt.new_int(1))).str())
	mut var_padLen := rt.new_int(var_nextLineNum.clone().to_string().len)
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_0 := iife_temp_0.splitlines(rt.get_property(var_source_mutated, 'body'))
	mut var_lines := iife_result_0
	var_lines.array_set(0, (Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.spaces((rt.sub(rt.get_property(rt.get_property(var_source_mutated, 'locationOffset'), 'column'), rt.new_int(1))).to_i64())).str() + (var_lines.array_get(rt.new_int(0))).str())
	mut var_outputLines := rt.create_array([rt.ArrayItem{ key: none, val: rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.get_property(var_source_mutated, 'name'), rt.new_string(' (')), var_contextLine), rt.new_string(':')), var_contextColumn), rt.new_string(')')) }, rt.ArrayItem{ key: none, val: if rt.is_true(rt.greater_equal(var_line, rt.new_int(2))) { (Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.leftpad((var_padLen).to_i64(), (var_prevLineNum).str())).str() + ': ' + (var_lines.array_get(rt.sub(var_line, rt.new_int(2)))).str() } else { rt.new_null() } }, rt.ArrayItem{ key: none, val: (Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.leftpad((var_padLen).to_i64(), (var_lineNum).str())).str() + ': ' + (var_lines.array_get(rt.sub(var_line, rt.new_int(1)))).str() }, rt.ArrayItem{ key: none, val: (Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.spaces((rt.sub(rt.add(rt.add(rt.new_int(2), var_padLen), var_contextColumn), rt.new_int(1))).to_i64())).str() + '^' }, rt.ArrayItem{ key: none, val: if rt.is_true(rt.less(var_line, rt.new_int(var_lines.clone().array_count()))) { (Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.leftpad((var_padLen).to_i64(), (var_nextLineNum).str())).str() + ': ' + (var_lines.array_get(var_line)).str() } else { rt.new_null() } }])
	return (rt.call_function('implode', [rt.new_string('\n'), rt.call_function('array_filter', [var_outputLines.clone()])])).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.getcolumnoffset(mut var_source Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source, mut var_location Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) i64 {
	mut var_source_mutated := var_source
	mut var_location_mutated := var_location
	return (if rt.is_true(rt.identical(rt.get_property(var_location_mutated, 'line'), rt.new_int(1))) { rt.sub(rt.get_property(rt.get_property(var_source_mutated, 'locationOffset'), 'column'), rt.new_int(1)) } else { rt.new_int(0) }).to_i64()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.spaces(length i64) string {
	return (rt.call_function('str_repeat', [rt.new_string(' '), rt.new_int(length)])).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.leftpad(length i64, str string) string {
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.spaces((rt.sub(rt.new_int(length), rt.call_function('mb_strlen', [rt.new_string(str)]))).to_i64())).str() + str
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.createfromexception(mut var_exception Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable, debugFlag i64, mut var_internalErrorMessage Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?string) rt.PhpVal {
	mut var_loc := rt.new_null()
	rt.new_null()
	mut var_message := if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable', []string{}, var_exception), 'Automattic_WooCommerce_Vendor_GraphQL_Error_ClientAware'))) && rt.is_true(var_exception.isclientsafe()) { var_exception.getmessage() } else { var_internalErrorMessage }
	mut var_formattedError := rt.create_array([rt.ArrayItem{ key: 'message', val: var_message }])
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable', []string{}, var_exception), 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error'))) {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_loc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_loc, 'toSerializableArray', []rt.PhpVal{})
			}
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_loc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_loc, 'toSerializableArray', []rt.PhpVal{})
			}
		mut var_locations := rt.call_function('array_map', [rt.new_closure(closure_2_fn), var_exception.getlocations()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_locations, rt.new_array())))) {
			var_formattedError.array_set('locations', var_locations.clone())
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_exception, 'path'), rt.new_null())))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_exception, 'path'), rt.new_array())))) {
			var_formattedError.array_set('path', rt.get_property(var_exception, 'path'))
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable', []string{}, var_exception), 'Automattic_WooCommerce_Vendor_GraphQL_Error_ProvidesExtensions'))) {
		mut var_extensions := var_exception.getextensions()
		if var_extensions.clone().is_array() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_extensions, rt.new_array())))) {
			var_formattedError.array_set('extensions', var_extensions.clone())
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(debugFlag), Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.none())))) {
	var_formattedError = Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.adddebugentries(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_array](var_formattedError), mut var_exception, debugFlag)
	}
	return var_formattedError.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.adddebugentries(mut var_formattedError Class_Automattic_WooCommerce_Vendor_GraphQL_Error_array, mut var_e Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable, debugFlag i64) rt.PhpVal {
	mut var_formattedError_mutated := var_formattedError
	if rt.is_true(rt.identical(rt.new_int(debugFlag), Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.none())) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_array', []string{}, var_formattedError_mutated)
	}
	if rt.is_true(rt.new_bool(rt.bitwise_and(rt.new_int(debugFlag), Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.rethrow_internal_exceptions()) != 0)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable', []string{}, var_e), 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error')))))) {
			rt.throw_exception(var_e)
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_e.getprevious(), rt.new_null())))) {
			rt.throw_exception(var_e.getprevious())
		}
	}
	mut var_isUnsafe := rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable', []string{}, var_e), 'Automattic_WooCommerce_Vendor_GraphQL_Error_ClientAware')))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_e.isclientsafe())))))
	if rt.is_true(rt.new_bool(rt.bitwise_and(rt.new_int(debugFlag), Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.rethrow_unsafe_exceptions()) != 0)) && rt.is_true(var_isUnsafe) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_e.getprevious(), rt.new_null())))) {
		rt.throw_exception(var_e.getprevious())
	}
	if rt.is_true(rt.new_bool(rt.bitwise_and(rt.new_int(debugFlag), Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.include_debug_message()) != 0)) && rt.is_true(var_isUnsafe) {
		var_formattedError_mutated.array_get_mut('extensions').array_set('debugMessage', var_e.getmessage())
	}
	if rt.is_true(rt.new_bool(rt.bitwise_and(rt.new_int(debugFlag), Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.include_trace()) != 0)) {
		mut var_actualError := if !(var_e.getprevious()).is_null() { var_e.getprevious() } else { var_e }
		if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable', []string{}, var_e), 'Automattic_WooCommerce_Vendor_GraphQL_Error_ErrorException'))) || rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable', []string{}, var_e), 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error'))) {
			var_formattedError_mutated.array_get_mut('extensions').array_set('file', var_e.getfile())
			var_formattedError_mutated.array_get_mut('extensions').array_set('line', var_e.getline())
		} else {
			var_formattedError_mutated.array_get_mut('extensions').array_set('file', rt.call_method(var_actualError, 'getFile', []rt.PhpVal{}))
			var_formattedError_mutated.array_get_mut('extensions').array_set('line', rt.call_method(var_actualError, 'getLine', []rt.PhpVal{}))
		}
		mut var_isTrivial := rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable', []string{}, var_e), 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error'))) && rt.is_true(rt.identical(var_e.getprevious(), rt.new_null())))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_isTrivial)))) {
			var_formattedError_mutated.array_get_mut('extensions').array_set('trace', Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.tosafetrace(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable](var_actualError)))
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_array', []string{}, var_formattedError_mutated)
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.prepareformatter(mut var_formatter Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?callable, debug i64) rt.PhpVal {
	mut var_e := rt.new_null()
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_e := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.createfromexception(mut var_e, debug)
		}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_e := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.adddebugentries(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_array](rt.call_callable(var_formatter, [var_e])), mut var_e, debug)
		}
	return if rt.is_true(rt.identical(var_formatter, rt.new_null())) { rt.new_closure(closure_4_fn) } else { rt.new_closure(closure_5_fn) }
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.tosafetrace(mut var_error Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable) rt.PhpVal {
	mut var_trace := var_error.gettrace()
	if var_trace.array_get(rt.new_int(0)).array_isset(rt.new_string('function')) && var_trace.array_get(rt.new_int(0)).array_isset(rt.new_string('class')) && rt.is_true(rt.identical((var_trace.array_get(rt.new_int(0)).array_get(rt.new_string('class'))).str() + '::' + (var_trace.array_get(rt.new_int(0)).array_get(rt.new_string('function'))).str(), rt.new_string('Automattic\\WooCommerce\\Vendor\\GraphQL\\Utils\\Utils::invariant'))) {
		rt.call_function('array_shift', [var_trace.clone()])
	} else if !(var_trace.array_get(rt.new_int(0)).array_isset(rt.new_string('file'))) {
		rt.call_function('array_shift', [var_trace.clone()])
	}
	mut var_formatted := rt.new_array()
	mut iter_3 := var_trace.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_err := item_3.val
		mut var_safeErr := rt.new_array()
		if var_err.array_isset(rt.new_string('file')) {
			var_safeErr.array_set('file', var_err.array_get(rt.new_string('file')))
		}
		if var_err.array_isset(rt.new_string('line')) {
			var_safeErr.array_set('line', var_err.array_get(rt.new_string('line')))
		}
		mut var_func := var_err.array_get(rt.new_string('function'))
		mut var_args := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.class() }, rt.ArrayItem{ key: none, val: 'printVar' }]), if !(var_err.array_get(rt.new_string('args'))).is_null() { var_err.array_get(rt.new_string('args')) } else { rt.new_array() }])
		mut var_funcStr := rt.new_string((var_func).str() + '(' + (rt.call_function('implode', [rt.new_string(', '), var_args.clone()])).str() + ')')
		if var_err.array_isset(rt.new_string('class')) {
			var_safeErr.array_set('call', (var_err.array_get(rt.new_string('class'))).str() + '::' + (var_funcStr).str())
		} else {
			var_safeErr.array_set('function', var_funcStr.clone())
		}
		var_formatted.array_push(var_safeErr.clone())
	}
	return var_formatted.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.printvar(var_var rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.instance_of(var_var, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type'))) {
		return 'GraphQLType: ' + (rt.call_method(var_var, 'toString', []rt.PhpVal{})).str()
	}
	if rt.is_true(rt.new_bool(var_var.clone().is_object())) {
		mut var_count := rt.new_string((if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_var, 'PHPUnit_Framework_Test')))))) && rt.is_true(rt.new_bool(rt.instance_of(var_var, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Countable'))) { '(' + var_var.clone().array_count().str() + ')' } else { '' }).str())
		return 'instance of ' + (rt.call_function('get_class', [var_var.clone()])).str() + (var_count).str()
	}
	if rt.is_true(rt.new_bool(var_var.clone().is_array())) {
		return 'array(' + var_var.clone().array_count().str() + ')'
	}
	if rt.is_true(rt.identical(var_var, rt.new_string(''))) {
		return '(empty string)'
	}
	if rt.is_true(rt.new_bool(var_var.clone().is_string())) {
		return '\'' + (rt.call_function('addcslashes', [var_var.clone(), rt.new_string('\'')])).str() + '\''
	}
	if rt.is_true(rt.new_bool(var_var.clone().is_bool())) {
		return if rt.is_true(var_var) { 'true' } else { 'false' }
	}
	if rt.is_true(rt.call_function('is_scalar', [var_var.clone()])) {
		return (var_var).str()
	}
	if rt.is_true(rt.identical(var_var, rt.new_null())) {
		return 'null'
	}
	return (rt.call_function('gettype', [var_var.clone()])).str()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_error_formattederror(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'setInternalErrorMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.setinternalerrormessage(dispatch_arg_0)
			return rt.new_null()
		}
		'printError' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.printerror(mut dispatch_arg_0))
		}
		'highlightSourceAtLocation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.highlightsourceatlocation(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'getColumnOffset' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_int(Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.getcolumnoffset(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'spaces' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.spaces(dispatch_arg_0))
		}
		'leftPad' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.leftpad(dispatch_arg_0, dispatch_arg_1))
		}
		'createFromException' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.createfromexception(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'addDebugEntries' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.adddebugentries(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'prepareFormatter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?callable](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.prepareformatter(mut dispatch_arg_0, dispatch_arg_1)
		}
		'toSafeTrace' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.tosafetrace(mut dispatch_arg_0)
		}
		'printVar' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError.printvar(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn main() {
	defer {
		rt.shutdown()
	}

}

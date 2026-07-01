import rt

struct Class_IXR_Server {
	rt.PhpObjectBase
pub mut:
		data rt.PhpVal = rt.new_null()
		callbacks rt.PhpVal = rt.new_array()
		message rt.PhpVal = rt.new_null()
		capabilities rt.PhpVal = rt.new_null()
}

fn (mut this Class_IXR_Server) construct(callbacks bool, data bool, wait bool)  {
	mut data_mutated := data
	this.setcapabilities()
	if var_callbacks {
		this.callbacks = rt.new_bool(callbacks).dup()
	}
	this.setcallbacks()
	if !(var_wait) {
		this.serve(data_mutated)
	}
}

fn (mut this Class_IXR_Server) ixr_server(callbacks bool, data bool, wait bool)  {
	mut data_mutated := data
	fn (arg_0 bool, arg_1 bool, arg_2 bool) rt.PhpVal { mut temp := Class_IXR_Server{}; temp.construct(arg_0, arg_1, arg_2); return rt.new_null() }(callbacks, data_mutated, wait)
}

fn (mut this Class_IXR_Server) serve(data bool)  {
	mut data_mutated := data
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(data_mutated))))) {
		if rt.is_true(rt.new_bool(rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_METHOD')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			if rt.is_true(rt.call_function('function_exists', [rt.new_string('status_header')])) {
				rt.call_function('status_header', [rt.new_int(405)])
				rt.call_function('header', [rt.new_string('Allow: POST')])
			}
			rt.call_function('header', [rt.new_string('Content-Type: text/plain')])
			// unsupported expression: Expr_Exit
		}
		data_mutated = (rt.call_function('file_get_contents', [rt.new_string('php://input')])).to_bool()
	}
	this.message = create_ixr_message(rt.new_bool(data_mutated).dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.message, 'parse', []rt.PhpVal{}))))) {
		this.error(// unsupported expression: Expr_UnaryMinus, 'parse error. not well formed')
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		this.error(// unsupported expression: Expr_UnaryMinus, 'server error. invalid xml-rpc. not conforming to spec. Request must be a methodCall')
	}
	mut var_result := this.call(rt.get_property(this.message, 'methodName'), rt.get_property(this.message, 'params'))
	if rt.is_true(rt.call_function('is_a', [var_result.dup(), rt.new_string('IXR_Error')])) {
		this.error(var_result.dup(), false)
	}
	mut var_r := create_ixr_value(var_result.dup())
	mut var_resultxml := var_r.getxml()
	mut var_xml := rt.new_string(rt.new_string("<methodResponse>\n  <params>\n    <param>\n      <value>\n      ${var_resultxml.to_string()}\n      </value>\n    </param>\n  </params>\n</methodResponse>\n"))
	this.output(var_xml.dup())
}

fn (mut this Class_IXR_Server) call(var_methodname rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(this.hasmethod(var_methodname.dup()))))) {
		return create_ixr_error(// unsupported expression: Expr_UnaryMinus, 'server error. requested method ' + (var_methodname).str() + ' does not exist.')
	}
	mut var_method := this.callbacks.array_get(var_methodname)
	if var_args_mutated.dup().array_count() == 1 {
		var_args_mutated = var_args_mutated.array_get(0)
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_method.dup().is_string())) && rt.is_true(rt.equal(rt.call_function('substr', [var_method.dup(), rt.new_int(0), rt.new_int(5)]), rt.new_string('this:'))))) {
		var_method = rt.call_function('substr', [var_method.dup(), rt.new_int(5)])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [rt.new_object('IXR_Server', []string{}, &this), var_method.dup()]))))) {
			return create_ixr_error(// unsupported expression: Expr_UnaryMinus, 'server error. requested class method "' + (var_method).str() + '" does not exist.')
		}
		mut var_result := rt.call_method(rt.new_object('IXR_Server', []string{}, &this), var_method, [var_args_mutated.dup()])
	} else {
		if rt.is_true(rt.new_bool(var_method.dup().is_array())) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_method.array_get(0) }, rt.ArrayItem{ key: none, val: var_method.array_get(1) }])]))))) {
				return create_ixr_error(// unsupported expression: Expr_UnaryMinus, 'server error. requested object method "' + (var_method.array_get(1)).str() + '" does not exist.')
			}
		} else {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [var_method.dup()]))))) {
				return create_ixr_error(// unsupported expression: Expr_UnaryMinus, 'server error. requested function "' + (var_method).str() + '" does not exist.')
			}
		}
		var_result = rt.call_function('call_user_func', [var_method.dup(), var_args_mutated.dup()])
	}
	return var_result.dup()
}

fn (mut this Class_IXR_Server) error(var_error rt.PhpVal, message bool)  {
	mut var_error_mutated := var_error
	if rt.is_true(rt.new_bool(var_message && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_error_mutated.is_object()))))))) {
		var_error_mutated = create_ixr_error(var_error_mutated.dup(), rt.new_bool(message).dup())
	}
	this.output(var_error_mutated.getxml())
}

fn (mut this Class_IXR_Server) output(var_xml rt.PhpVal)  {
	mut var_xml_mutated := var_xml
	mut var_charset := if rt.is_true(rt.call_function('function_exists', [rt.new_string('get_option')])) { rt.call_function('get_option', [rt.new_string('blog_charset')]) } else { rt.new_string('') }
	if rt.is_true(var_charset) {
		var_xml_mutated = rt.new_string('<?xml version="1.0" encoding="' + (var_charset).str() + '"?>' + '\n' + (var_xml_mutated).str())
	} else {
		var_xml_mutated = rt.new_string('<?xml version="1.0"?>' + '\n' + (var_xml_mutated).str())
	}
	mut var_length := rt.new_int(rt.new_int(var_xml_mutated.dup().to_string().len))
	rt.call_function('header', [rt.new_string('Connection: close')])
	if rt.is_true(var_charset) {
		rt.call_function('header', ['Content-Type: text/xml; charset=' + (var_charset).str()])
	} else {
		rt.call_function('header', [rt.new_string('Content-Type: text/xml')])
	}
	rt.call_function('header', ['Date: ' + (rt.call_function('gmdate', [rt.new_string('r')])).str()])
	rt.echo_val(var_xml_mutated)
	// unsupported expression: Expr_Exit
}

fn (mut this Class_IXR_Server) hasmethod(var_method rt.PhpVal) rt.PhpVal {
	mut var_method_mutated := var_method
	return rt.call_function('in_array', [var_method_mutated.dup(), rt.func_array_keys(this.callbacks)])
}

fn (mut this Class_IXR_Server) setcapabilities()  {
	this.capabilities = rt.create_array([rt.ArrayItem{ key: 'xmlrpc', val: rt.create_array([rt.ArrayItem{ key: 'specUrl', val: 'https://xmlrpc.com/spec.md' }, rt.ArrayItem{ key: 'specVersion', val: 1 }]) }, rt.ArrayItem{ key: 'faults_interop', val: rt.create_array([rt.ArrayItem{ key: 'specUrl', val: 'https://web.archive.org/web/20240416231938/https://xmlrpc-epi.sourceforge.net/specs/rfc.fault_codes.php' }, rt.ArrayItem{ key: 'specVersion', val: 20010516 }]) }, rt.ArrayItem{ key: 'system.multicall', val: rt.create_array([rt.ArrayItem{ key: 'specUrl', val: 'https://web.archive.org/web/20060624230303/http://www.xmlrpc.com/discuss/msgReader$1208?mode=topic' }, rt.ArrayItem{ key: 'specVersion', val: 1 }]) }])
}

fn (mut this Class_IXR_Server) getcapabilities(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return this.capabilities
}

fn (mut this Class_IXR_Server) setcallbacks()  {
	this.callbacks.array_set('system.getCapabilities', 'this:getCapabilities')
	this.callbacks.array_set('system.listMethods', 'this:listMethods')
	this.callbacks.array_set('system.multicall', 'this:multiCall')
}

fn (mut this Class_IXR_Server) listmethods(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return rt.call_function('array_reverse', [rt.func_array_keys(this.callbacks)])
}

fn (mut this Class_IXR_Server) multicall(var_methodcalls rt.PhpVal) rt.PhpVal {
	mut var_return := []rt.PhpVal{}
	{
		mut iter_1 := var_methodcalls.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_call := item_1.val
			mut var_method := var_call.array_get('methodName')
			mut var_params := var_call.array_get('params')
			if rt.is_true(rt.equal(var_method, rt.new_string('system.multicall'))) {
				mut var_result := create_ixr_error(// unsupported expression: Expr_UnaryMinus, rt.new_string('Recursive calls to system.multicall are forbidden'))
			} else {
				var_result = this.call(var_method.dup(), var_params.dup())
			}
			if rt.is_true(rt.call_function('is_a', [var_result.dup(), rt.new_string('IXR_Error')])) {
				var_return << rt.create_array([rt.ArrayItem{ key: 'faultCode', val: rt.get_property(var_result, 'code') }, rt.ArrayItem{ key: 'faultString', val: rt.get_property(var_result, 'message') }])
			} else {
				var_return << rt.create_array([rt.ArrayItem{ key: none, val: var_result }])
			}
		}
	}
	return var_return.dup()
}

struct Class_IXR_Message {
	rt.PhpObjectBase
}

struct Class_IXR_Value {
	rt.PhpObjectBase
}

struct Class_IXR_Error {
	rt.PhpObjectBase
}

fn create_ixr_server(callbacks bool, data bool, wait bool) &Class_IXR_Server {
	mut obj := &Class_IXR_Server{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_null()
		callbacks: rt.new_array()
		message: rt.new_null()
		capabilities: rt.new_null()
	}
	obj.construct(callbacks, data, wait)
	return obj
}

fn create_ixr_message() &Class_IXR_Message {
	mut obj := &Class_IXR_Message{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ixr_value() &Class_IXR_Value {
	mut obj := &Class_IXR_Value{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ixr_error() &Class_IXR_Error {
	mut obj := &Class_IXR_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_IXR_Server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'IXR_Server' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.ixr_server(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'serve' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.serve(dispatch_arg_0)
			return rt.new_null()
		}
		'call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.call(dispatch_arg_0, dispatch_arg_1)
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.error(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.output(dispatch_arg_0)
			return rt.new_null()
		}
		'hasMethod' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.hasmethod(dispatch_arg_0)
		}
		'setCapabilities' {
			this.setcapabilities()
			return rt.new_null()
		}
		'getCapabilities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getcapabilities(dispatch_arg_0)
		}
		'setCallbacks' {
			this.setcallbacks()
			return rt.new_null()
		}
		'listMethods' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.listmethods(dispatch_arg_0)
		}
		'multiCall' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.multicall(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_IXR_Server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'callbacks' { return this.callbacks }
		'message' { return this.message }
		'capabilities' { return this.capabilities }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_IXR_Server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' { this.data = val; return true }
		'callbacks' { this.callbacks = val; return true }
		'message' { this.message = val; return true }
		'capabilities' { this.capabilities = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_IXR_Message) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Message) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Message) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_IXR_Value) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Value) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Value) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_IXR_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_ixr_class_ixr_server_php() {
}

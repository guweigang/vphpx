import rt

struct Class_IXR_Server {
	rt.PhpObjectBase
pub mut:
	data         rt.PhpVal = rt.new_null()
	callbacks    rt.PhpVal = rt.new_array()
	message      rt.PhpVal = rt.new_null()
	capabilities rt.PhpVal = rt.new_null()
}

fn (mut this Class_IXR_Server) construct(callbacks bool, data bool, wait bool) {
	mut data_mutated := data
	this.setcapabilities()
	if var_callbacks {
		this.callbacks = rt.new_bool(callbacks)
	}
	this.setcallbacks()
	if !var_wait {
		this.serve(data_mutated)
	}
}

fn (mut this Class_IXR_Server) ixr_server(callbacks bool, data bool, wait bool) {
	mut data_mutated := data
	mut iife_temp_0 := Class_IXR_Server{}
	iife_temp_0.construct(callbacks, data_mutated, wait)
	rt.new_null()
}

fn (mut this Class_IXR_Server) serve(data bool) {
	mut data_mutated := data
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(data_mutated))))) {
		if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_METHOD'))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')), rt.new_string('POST'))))) {
			if rt.is_true(rt.call_function('function_exists', [
				rt.new_string('status_header'),
			]))
			{
				rt.call_function('status_header', [rt.new_int(405)])
				rt.call_function('header', [rt.new_string('Allow: POST')])
			}
			rt.call_function('header', [rt.new_string('Content-Type: text/plain')])
			fn () {
				print((rt.new_string('XML-RPC server accepts POST requests only.')).str())
				exit(0)
			}()
		}
		data_mutated = (rt.call_function('file_get_contents', [
			rt.new_string('php://input'),
		])).to_bool()
	}
	this.message = create_ixr_message(rt.new_bool(data_mutated).clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.message, 'parse', []rt.PhpVal{}))))) {
		this.error(rt.new_int(-32700), 'parse error. not well formed')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.get_property(this.message, 'messageType'),
		rt.new_string('methodCall')))))
	{
		this.error(rt.new_int(-32600),
			'server error. invalid xml-rpc. not conforming to spec. Request must be a methodCall')
	}
	mut var_result := this.call(rt.get_property(this.message, 'methodName'), rt.get_property(this.message,
		'params'))
	if rt.is_true(rt.call_function('is_a', [var_result.clone(),
		rt.new_string('IXR_Error')]))
	{
		this.error(var_result.clone(), false)
	}
	mut var_r := create_ixr_value(var_result.clone())
	mut var_resultxml := var_r.getxml()
	mut var_xml :=
		rt.new_string('<methodResponse>\n  <params>\n    <param>\n      <value>\n      ${var_resultxml.to_string()}\n      </value>\n    </param>\n  </params>\n</methodResponse>\n')
	this.output(var_xml.clone())
}

fn (mut this Class_IXR_Server) call(var_methodname rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(this.hasmethod(var_methodname.clone()))))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(-32601,

			'server error. requested method ' + var_methodname.str() + ' does not exist.'))
	}
	mut var_method := this.callbacks.array_get(var_methodname)
	if var_args_mutated.clone().array_count() == 1 {
		var_args_mutated = var_args_mutated.array_get(rt.new_int(0))
	}
	if var_method.clone().is_string()
		&& rt.is_true(rt.equal(rt.call_function('substr', [var_method.clone(), rt.new_int(0), rt.new_int(5)]), rt.new_string('this:'))) {
		var_method = rt.call_function('substr', [var_method.clone(),
			rt.new_int(5)])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [
			rt.new_object('IXR_Server', []string{}, &this),
			var_method.clone(),
		])))))
		{
			return rt.new_object('IXR_Error', []string{}, create_ixr_error(-32601,

				'server error. requested class method "' + var_method.str() + '" does not exist.'))
		}
		mut var_result := rt.call_method(rt.new_object('IXR_Server', []string{}, &this),
			var_method, [var_args_mutated.clone()])
	} else {
		if rt.is_true(rt.new_bool(var_method.clone().is_array())) {
			if !(rt.call_function('is_callable', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: var_method.array_get(rt.new_int(0)) },
					rt.ArrayItem{ key: none, val: var_method.array_get(rt.new_int(1)) },
				]),
			])) {
				return rt.new_object('IXR_Error', []string{}, create_ixr_error(-32601,
					'server error. requested object method "' +
					(var_method.array_get(rt.new_int(1))).str() + '" does not exist.'))
			}
		} else {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
				var_method.clone(),
			])))))
			{
				return rt.new_object('IXR_Error', []string{}, create_ixr_error(-32601,

					'server error. requested function "' + var_method.str() + '" does not exist.'))
			}
		}
		var_result = rt.call_function('call_user_func', [var_method.clone(),
			var_args_mutated.clone()])
	}
	return var_result.clone()
}

fn (mut this Class_IXR_Server) error(var_error rt.PhpVal, message bool) {
	mut var_error_mutated := var_error
	if var_message && !(var_error_mutated.clone().is_object()) {
		var_error_mutated = create_ixr_error(var_error_mutated.clone(), rt.new_bool(message))
	}
	this.output(var_error_mutated.getxml())
}

fn (mut this Class_IXR_Server) output(var_xml rt.PhpVal) {
	mut var_xml_mutated := var_xml
	mut var_charset := if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_option'),
	]))
	{ rt.call_function('get_option', [rt.new_string('blog_charset')]) } else { rt.new_string('') }
	if rt.is_true(var_charset) {
		var_xml_mutated = rt.new_string('<?xml version="1.0" encoding="' + var_charset.str() +
			'"?>' + '\n' + var_xml_mutated.str())
	} else {
		var_xml_mutated = rt.new_string('<?xml version="1.0"?>' + '\n' + var_xml_mutated.str())
	}
	mut var_length := rt.new_int(var_xml_mutated.clone().to_string().len)
	rt.call_function('header', [rt.new_string('Connection: close')])
	if rt.is_true(var_charset) {
		rt.call_function('header', [
			rt.new_string('Content-Type: text/xml; charset=' + var_charset.str()),
		])
	} else {
		rt.call_function('header', [rt.new_string('Content-Type: text/xml')])
	}
	rt.call_function('header', [
		rt.new_string('Date: ' + (rt.call_function('gmdate', [rt.new_string('r')])).str()),
	])
	rt.echo_val(var_xml_mutated)
	exit(0)
}

fn (mut this Class_IXR_Server) hasmethod(var_method rt.PhpVal) rt.PhpVal {
	mut var_method_mutated := var_method
	return rt.call_function('in_array', [var_method_mutated.clone(),
		rt.func_array_keys(this.callbacks)])
}

fn (mut this Class_IXR_Server) setcapabilities() {
	this.capabilities = rt.create_array([
		rt.ArrayItem{ key: 'xmlrpc', val: rt.create_array([
			rt.ArrayItem{ key: 'specUrl', val: 'https://xmlrpc.com/spec.md' },
			rt.ArrayItem{ key: 'specVersion', val: 1 },
		]) },
		rt.ArrayItem{ key: 'faults_interop', val: rt.create_array([
			rt.ArrayItem{
				key: 'specUrl'
				val: 'https://web.archive.org/web/20240416231938/https://xmlrpc-epi.sourceforge.net/specs/rfc.fault_codes.php'
			},
			rt.ArrayItem{ key: 'specVersion', val: 20010516 },
		]) },
		rt.ArrayItem{ key: 'system.multicall', val: rt.create_array([
			rt.ArrayItem{
				key: 'specUrl'
				val: 'https://web.archive.org/web/20060624230303/http://www.xmlrpc.com/discuss/msgReader$1208?mode=topic'
			},
			rt.ArrayItem{ key: 'specVersion', val: 1 },
		]) },
	])
}

fn (mut this Class_IXR_Server) getcapabilities(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return this.capabilities
}

fn (mut this Class_IXR_Server) setcallbacks() {
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
	mut iter_1 := var_methodcalls.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_call := item_1.val
		mut var_method := var_call.array_get(rt.new_string('methodName'))
		mut var_params := var_call.array_get(rt.new_string('params'))
		if rt.is_true(rt.equal(var_method, rt.new_string('system.multicall'))) {
			mut var_result := create_ixr_error(-32600,
				rt.new_string('Recursive calls to system.multicall are forbidden'))
		} else {
			var_result = this.call(var_method.clone(), var_params.clone())
		}
		if rt.is_true(rt.call_function('is_a', [var_result.clone(),
			rt.new_string('IXR_Error')]))
		{
			var_return << rt.create_array([
				rt.ArrayItem{ key: 'faultCode', val: rt.get_property(var_result, 'code') },
				rt.ArrayItem{ key: 'faultString', val: rt.get_property(var_result, 'message') },
			])
		} else {
			var_return << rt.create_array([rt.ArrayItem{ key: none, val: var_result }])
		}
	}
	return var_return.clone()
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
		data:          rt.new_null()
		callbacks:     rt.new_array()
		message:       rt.new_null()
		capabilities:  rt.new_null()
	}
	obj.construct(callbacks, data, wait)
	return obj
}

fn create_ixr_message(_args ...rt.PhpVal) &Class_IXR_Message {
	mut obj := &Class_IXR_Message{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ixr_value(_args ...rt.PhpVal) &Class_IXR_Value {
	mut obj := &Class_IXR_Value{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ixr_error(_args ...rt.PhpVal) &Class_IXR_Error {
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
		else {
			return none
		}
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
		'data' {
			this.data = val
			return true
		}
		'callbacks' {
			this.callbacks = val
			return true
		}
		'message' {
			this.message = val
			return true
		}
		'capabilities' {
			this.capabilities = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}

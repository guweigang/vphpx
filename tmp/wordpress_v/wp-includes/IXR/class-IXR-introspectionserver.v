import rt

struct Class_IXR_IntrospectionServer {
	rt.PhpObjectBase
pub mut:
		signatures rt.PhpVal = rt.new_null()
		help rt.PhpVal = rt.new_null()
}

fn (mut this Class_IXR_IntrospectionServer) construct()  {
	this.setcallbacks()
	this.setcapabilities()
	rt.get_property(rt.new_object('IXR_IntrospectionServer', ['IXR_Server'], &this), 'capabilities').array_set('introspection', rt.create_array([rt.ArrayItem{ key: 'specUrl', val: 'https://web.archive.org/web/20050404090342/http://xmlrpc.usefulinc.com/doc/reserved.html' }, rt.ArrayItem{ key: 'specVersion', val: 1 }]))
	this.addcallback(rt.new_string('system.methodSignature'), rt.new_string('this:methodSignature'), rt.create_array([rt.ArrayItem{ key: none, val: 'array' }, rt.ArrayItem{ key: none, val: 'string' }]), rt.new_string('Returns an array describing the return type and required parameters of a method'))
	this.addcallback(rt.new_string('system.getCapabilities'), rt.new_string('this:getCapabilities'), rt.create_array([rt.ArrayItem{ key: none, val: 'struct' }]), rt.new_string('Returns a struct describing the XML-RPC specifications supported by this server'))
	this.addcallback(rt.new_string('system.listMethods'), rt.new_string('this:listMethods'), rt.create_array([rt.ArrayItem{ key: none, val: 'array' }]), rt.new_string('Returns an array of available methods on this server'))
	this.addcallback(rt.new_string('system.methodHelp'), rt.new_string('this:methodHelp'), rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'string' }]), rt.new_string('Returns a documentation string for the specified method'))
}

fn (mut this Class_IXR_IntrospectionServer) ixr_introspectionserver()  {
	fn () rt.PhpVal { mut temp := Class_IXR_IntrospectionServer{}; temp.construct(); return rt.new_null() }()
}

fn (mut this Class_IXR_IntrospectionServer) addcallback(var_method rt.PhpVal, var_callback rt.PhpVal, var_args rt.PhpVal, var_help rt.PhpVal)  {
	mut var_method_mutated := var_method
	mut var_args_mutated := var_args
	rt.get_property(rt.new_object('IXR_IntrospectionServer', ['IXR_Server'], &this), 'callbacks').array_set(var_method_mutated, var_callback.dup())
	this.signatures.array_set(var_method_mutated, var_args_mutated.dup())
	this.help.array_set(var_method_mutated, var_help.dup())
}

fn (mut this Class_IXR_IntrospectionServer) call(var_methodname rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.is_true(var_args_mutated) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.dup().is_array()))))))) {
		var_args_mutated = rt.create_array([rt.ArrayItem{ key: none, val: var_args_mutated }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.hasmethod(var_methodname.dup()))))) {
		return create_ixr_error(// unsupported expression: Expr_UnaryMinus, 'server error. requested method "' + (rt.get_property(rt.get_property(rt.new_object('IXR_IntrospectionServer', ['IXR_Server'], &this), 'message'), 'methodName')).str() + '" not specified.')
	}
	mut var_method := rt.get_property(rt.new_object('IXR_IntrospectionServer', ['IXR_Server'], &this), 'callbacks').array_get(var_methodname)
	mut var_signature := this.signatures.array_get(var_methodname)
	mut var_returnType := rt.call_function('array_shift', [var_signature.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		return create_ixr_error(// unsupported expression: Expr_UnaryMinus, rt.new_string('server error. wrong number of method parameters'))
	}
	mut var_ok := rt.new_bool(rt.new_bool(true))
	mut var_argsbackup := var_args_mutated.dup()
	{
		mut var_i := rt.new_int(rt.new_int(0))
		mut var_j := rt.new_int(rt.new_int(var_args_mutated.dup().array_count()))
		for {
			if !(rt.is_true(rt.less(var_i, var_j))) { break }
			mut var_arg := rt.call_function('array_shift', [var_args_mutated.dup()])
			mut var_type := rt.call_function('array_shift', [var_signature.dup()])
			mut switch_val_1 := var_type
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('int'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('i4'))) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_arg.dup().is_array())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_arg.dup().is_long()))))))) {
					var_ok = rt.new_bool(rt.new_bool(false))
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('base64'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('string'))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_arg.dup().is_string()))))) {
					var_ok = rt.new_bool(rt.new_bool(false))
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('boolean'))) {
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_ok = rt.new_bool(rt.new_bool(false))
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('float'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('double'))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_arg.dup().is_double()))))) {
					var_ok = rt.new_bool(rt.new_bool(false))
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('dateTime.iso8601'))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_arg.dup(), rt.new_string('IXR_Date')]))))) {
					var_ok = rt.new_bool(rt.new_bool(false))
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_ok)))) {
				return create_ixr_error(// unsupported expression: Expr_UnaryMinus, rt.new_string('server error. invalid method parameters'))
			}
			rt.post_inc(var_i)
		}
	}
	return this.Class_IXR_Server.call(var_methodname.dup(), var_argsbackup.dup())
}

fn (mut this Class_IXR_IntrospectionServer) methodsignature(var_method rt.PhpVal) rt.PhpVal {
	mut var_method_mutated := var_method
	if rt.is_true(rt.new_bool(!(rt.is_true(this.hasmethod(var_method_mutated.dup()))))) {
		return create_ixr_error(// unsupported expression: Expr_UnaryMinus, 'server error. requested method "' + (var_method_mutated).str() + '" not specified.')
	}
	mut var_types := this.signatures.array_get(var_method_mutated)
	mut var_return := rt.new_array()
	{
		mut iter_1 := var_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			mut switch_val_2 := var_type
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('string'))) {
				var_return.array_push('string')
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('int'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('i4'))) {
				var_return.array_push(42)
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('double'))) {
				var_return.array_push(3.1415)
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('dateTime.iso8601'))) {
				var_return.array_push(create_ixr_date(rt.call_function('time', []rt.PhpVal{})))
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('boolean'))) {
				var_return.array_push(true)
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('base64'))) {
				var_return.array_push(create_ixr_base64(rt.new_string('base64')))
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('array'))) {
				var_return.array_push(rt.create_array([rt.ArrayItem{ key: none, val: 'array' }]))
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('struct'))) {
				var_return.array_push(rt.create_array([rt.ArrayItem{ key: 'struct', val: 'struct' }]))
			}
		}
	}
	return var_return.dup()
}

fn (mut this Class_IXR_IntrospectionServer) methodhelp(var_method rt.PhpVal) rt.PhpVal {
	mut var_method_mutated := var_method
	return this.help.array_get(var_method_mutated)
}

struct Class_IXR_Server {
	rt.PhpObjectBase
}

struct Class_IXR_Error {
	rt.PhpObjectBase
}

struct Class_IXR_Date {
	rt.PhpObjectBase
}

struct Class_IXR_Base64 {
	rt.PhpObjectBase
}

fn create_ixr_introspectionserver() &Class_IXR_IntrospectionServer {
	mut obj := &Class_IXR_IntrospectionServer{
		PhpObjectBase: rt.PhpObjectBase{}
		signatures: rt.new_null()
		help: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_ixr_server() &Class_IXR_Server {
	mut obj := &Class_IXR_Server{
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

fn create_ixr_date() &Class_IXR_Date {
	mut obj := &Class_IXR_Date{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ixr_base64() &Class_IXR_Base64 {
	mut obj := &Class_IXR_Base64{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_IXR_IntrospectionServer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'IXR_IntrospectionServer' {
			this.ixr_introspectionserver()
			return rt.new_null()
		}
		'addCallback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.addcallback(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.call(dispatch_arg_0, dispatch_arg_1)
		}
		'methodSignature' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.methodsignature(dispatch_arg_0)
		}
		'methodHelp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.methodhelp(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_IXR_IntrospectionServer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'signatures' { return this.signatures }
		'help' { return this.help }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_IXR_IntrospectionServer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'signatures' { this.signatures = val; return true }
		'help' { this.help = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_IXR_Server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_IXR_Date) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Date) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Date) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_IXR_Base64) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Base64) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Base64) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_ixr_class_ixr_introspectionserver_php() {
}

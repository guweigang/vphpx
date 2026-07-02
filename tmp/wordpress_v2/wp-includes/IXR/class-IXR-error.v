import rt

struct Class_IXR_Error {
	rt.PhpObjectBase
pub mut:
	code    rt.PhpVal = rt.new_null()
	message rt.PhpVal = rt.new_null()
}

fn (mut this Class_IXR_Error) construct(var_code rt.PhpVal, var_message rt.PhpVal) {
	this.code = var_code.clone()
	this.message = rt.call_function('htmlspecialchars', [var_message.clone()])
}

fn (mut this Class_IXR_Error) ixr_error(var_code rt.PhpVal, var_message rt.PhpVal) {
	mut iife_temp_0 := Class_IXR_Error{}
	iife_temp_0.construct(var_code.clone(), var_message.clone())
	rt.new_null()
}

fn (mut this Class_IXR_Error) getxml() rt.PhpVal {
	mut var_xml := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('<methodResponse>\n  <fault>\n    <value>\n      <struct>\n        <member>\n          <name>faultCode</name>\n          <value><int>'),
		this.code),
		rt.new_string('</int></value>\n        </member>\n        <member>\n          <name>faultString</name>\n          <value><string>')),
		this.message),
		rt.new_string('</string></value>\n        </member>\n      </struct>\n    </value>\n  </fault>\n</methodResponse>\n'))).str())
	return var_xml.clone()
}

fn create_ixr_error(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_IXR_Error {
	mut obj := &Class_IXR_Error{
		PhpObjectBase: rt.PhpObjectBase{}
		code:          rt.new_null()
		message:       rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_IXR_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'IXR_Error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.ixr_error(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getXml' {
			return this.getxml()
		}
		else {
			return none
		}
	}
}

fn (this &Class_IXR_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'code' { return this.code }
		'message' { return this.message }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_IXR_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'code' {
			this.code = val
			return true
		}
		'message' {
			this.message = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

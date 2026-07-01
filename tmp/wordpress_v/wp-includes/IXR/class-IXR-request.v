import rt

struct Class_IXR_Request {
	rt.PhpObjectBase
pub mut:
	method rt.PhpVal = rt.new_null()
	args   rt.PhpVal = rt.new_null()
	xml    string
}

fn (mut this Class_IXR_Request) construct(var_method rt.PhpVal, var_args rt.PhpVal) {
	this.method = var_method.dup()
	this.args = var_args.dup()
	this.xml = rt.concat(rt.concat(rt.new_string('<?xml version="1.0"?>\n<methodCall>\n<methodName>'),
		this.method), rt.new_string('</methodName>\n<params>\n'))
	{
		mut iter_1 := this.args.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_arg := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
			mut var_v := create_ixr_value(var_arg.dup())
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_IXR_Request) ixr_request(var_method rt.PhpVal, var_args rt.PhpVal) {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_IXR_Request{}
		temp.construct(arg_0, arg_1)
		return rt.new_null()
	}(var_method.dup(), var_args.dup())
}

fn (mut this Class_IXR_Request) getlength() i64 {
	return this.xml.len
}

fn (mut this Class_IXR_Request) getxml() string {
	return this.xml
}

struct Class_IXR_Value {
	rt.PhpObjectBase
}

fn create_ixr_request(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_IXR_Request {
	mut obj := &Class_IXR_Request{
		PhpObjectBase: rt.PhpObjectBase{}
		method:        rt.new_null()
		args:          rt.new_null()
		xml:           ''
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_ixr_value() &Class_IXR_Value {
	mut obj := &Class_IXR_Value{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_IXR_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'IXR_Request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.ixr_request(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getLength' {
			return rt.new_int(this.getlength())
		}
		'getXml' {
			return rt.new_string(this.getxml())
		}
		else {
			return none
		}
	}
}

fn (this &Class_IXR_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'method' { return this.method }
		'args' { return this.args }
		'xml' { return rt.new_string(this.xml) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_IXR_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'method' {
			this.method = val
			return true
		}
		'args' {
			this.args = val
			return true
		}
		'xml' {
			this.xml = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_includes_ixr_class_ixr_request_php() {
}

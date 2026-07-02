import rt

struct Class_SimplePie_Exception {
	rt.PhpObjectBase
pub mut:
	message rt.PhpVal = rt.new_null()
	code    rt.PhpVal = rt.new_null()
	file    rt.PhpVal = rt.new_null()
	line    rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_SimplePie_Exception) getmessage() string {
	return this.message
}

fn create_simplepie_exception(arg_0 rt.PhpVal) &Class_SimplePie_Exception {
	mut obj := &Class_SimplePie_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       rt.new_null()
		code:          rt.new_null()
		file:          rt.new_null()
		line:          rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_SimplePie_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return this.getmessage()
		}
		else {
			return none
		}
	}
}

fn (this &Class_SimplePie_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return this.message }
		'code' { return this.code }
		'file' { return this.file }
		'line' { return this.line }
		else { return this.Class_Exception.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val
			return true
		}
		'code' {
			this.code = val
			return true
		}
		'file' {
			this.file = val
			return true
		}
		'line' {
			this.line = val
			return true
		}
		else {
			return this.Class_Exception.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Exception'),
		rt.new_string('SimplePie_Exception')])
}

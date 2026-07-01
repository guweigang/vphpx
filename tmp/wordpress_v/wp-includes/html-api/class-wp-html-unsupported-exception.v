import rt

struct Class_WP_HTML_Unsupported_Exception {
	rt.PhpObjectBase
pub mut:
	token_name                 string
	token_at                   i64
	token                      string
	stack_of_open_elements     rt.PhpVal = rt.new_array()
	active_formatting_elements rt.PhpVal = rt.new_array()
	message                    string
	code                       i64
	file                       string
	line                       i64
}

fn (mut this Class_WP_HTML_Unsupported_Exception) construct(message string, token_name string, token_at i64, token string, mut var_stack_of_open_elements Class_array, mut var_active_formatting_elements Class_array) {
	this.Class_Exception.construct(rt.new_string(message))
	this.token_name = token_name
	this.token_at = token_at
	this.token = token
	this.stack_of_open_elements = var_stack_of_open_elements.dup()
	this.active_formatting_elements = var_active_formatting_elements.dup()
}

fn (mut this Class_WP_HTML_Unsupported_Exception) getmessage() string {
	return this.message
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_wp_html_unsupported_exception(message string, token_name string, token_at i64, token string, arg_4 rt.PhpVal, arg_5 rt.PhpVal) &Class_WP_HTML_Unsupported_Exception {
	mut obj := &Class_WP_HTML_Unsupported_Exception{
		PhpObjectBase:              rt.PhpObjectBase{}
		token_name:                 ''
		token_at:                   i64(0)
		token:                      ''
		stack_of_open_elements:     rt.new_array()
		active_formatting_elements: rt.new_array()
		message:                    ''
		code:                       i64(0)
		file:                       ''
		line:                       i64(0)
	}
	obj.construct(message, token_name, token_at, token, arg_4, arg_5)
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_HTML_Unsupported_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_array](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_array](if args.len > 5 {
				args[5]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut
				dispatch_arg_4, mut dispatch_arg_5)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTML_Unsupported_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'token_name' { return rt.new_string(this.token_name) }
		'token_at' { return rt.new_int(this.token_at) }
		'token' { return rt.new_string(this.token) }
		'stack_of_open_elements' { return this.stack_of_open_elements }
		'active_formatting_elements' { return this.active_formatting_elements }
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTML_Unsupported_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'token_name' {
			this.token_name = val.str()
			return true
		}
		'token_at' {
			this.token_at = val.to_i64()
			return true
		}
		'token' {
			this.token = val.str()
			return true
		}
		'stack_of_open_elements' {
			this.stack_of_open_elements = val
			return true
		}
		'active_formatting_elements' {
			this.active_formatting_elements = val
			return true
		}
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_html_api_class_wp_html_unsupported_exception_php() {
}

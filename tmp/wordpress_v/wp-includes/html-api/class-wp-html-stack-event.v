import rt

pub fn Class_WP_HTML_Stack_Event.pop() string {
	return 'pop'
}

pub fn Class_WP_HTML_Stack_Event.push() string {
	return 'push'
}

struct Class_WP_HTML_Stack_Event {
	rt.PhpObjectBase
pub mut:
	token      rt.PhpVal = rt.new_null()
	operation  string
	provenance string
}

fn (mut this Class_WP_HTML_Stack_Event) construct(mut var_token Class_WP_HTML_Token, operation string, provenance string) {
	this.token = var_token.dup()
	this.operation = operation
	this.provenance = provenance
}

fn create_wp_html_stack_event(arg_0 rt.PhpVal, operation string, provenance string) &Class_WP_HTML_Stack_Event {
	mut obj := &Class_WP_HTML_Stack_Event{
		PhpObjectBase: rt.PhpObjectBase{}
		token:         rt.new_null()
		operation:     ''
		provenance:    ''
	}
	obj.construct(arg_0, operation, provenance)
	return obj
}

fn (mut this Class_WP_HTML_Stack_Event) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_HTML_Token](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.construct(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTML_Stack_Event) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'token' { return this.token }
		'operation' { return rt.new_string(this.operation) }
		'provenance' { return rt.new_string(this.provenance) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTML_Stack_Event) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'token' {
			this.token = val
			return true
		}
		'operation' {
			this.operation = val.str()
			return true
		}
		'provenance' {
			this.provenance = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_html_api_class_wp_html_stack_event_php() {
}

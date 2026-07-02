import rt

struct Class_WP_HTML_Token {
	rt.PhpObjectBase
pub mut:
		bookmark_name rt.PhpVal = rt.new_null()
		node_name string
		has_self_closing_flag bool
		namespace string
		integration_node_type rt.PhpVal = rt.new_null()
		on_destroy rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_HTML_Token) construct(mut var_bookmark_name Class_?string, node_name string, has_self_closing_flag bool, mut var_on_destroy Class_?callable) {
	this.bookmark_name = var_bookmark_name
	this.namespace = 'html'
	this.node_name = node_name
	this.has_self_closing_flag = has_self_closing_flag
	this.on_destroy = var_on_destroy
}

fn (mut this Class_WP_HTML_Token) magic_destruct() {
	if rt.is_true(rt.call_function('is_callable', [this.on_destroy])) {
		rt.call_function('call_user_func', [this.on_destroy, this.bookmark_name])
	}
}

fn (mut this Class_WP_HTML_Token) magic_wakeup() {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT + ' should never be unserialized')))
}

struct Class_LogicException {
	rt.PhpObjectBase
}

fn create_wp_html_token(arg_0 rt.PhpVal, node_name string, has_self_closing_flag bool, arg_3 rt.PhpVal) &Class_WP_HTML_Token {
	mut obj := &Class_WP_HTML_Token{
		PhpObjectBase: rt.PhpObjectBase{}
		bookmark_name: rt.new_null()
		node_name: ''
		has_self_closing_flag: false
		namespace: ''
		integration_node_type: rt.new_null()
		on_destroy: rt.new_null()
	}
	obj.construct(arg_0, node_name, has_self_closing_flag, arg_3)
	return obj
}

fn create_logicexception(_args ...rt.PhpVal) &Class_LogicException {
	mut obj := &Class_LogicException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTML_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_?callable](if args.len > 3 { args[3] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_HTML_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'bookmark_name' { return this.bookmark_name }
		'node_name' { return rt.new_string(this.node_name) }
		'has_self_closing_flag' { return rt.new_bool(this.has_self_closing_flag) }
		'namespace' { return rt.new_string(this.namespace) }
		'integration_node_type' { return this.integration_node_type }
		'on_destroy' { return this.on_destroy }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTML_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'bookmark_name' { this.bookmark_name = val; return true }
		'node_name' { this.node_name = (val).str(); return true }
		'has_self_closing_flag' { this.has_self_closing_flag = (val).to_bool(); return true }
		'namespace' { this.namespace = (val).str(); return true }
		'integration_node_type' { this.integration_node_type = val; return true }
		'on_destroy' { this.on_destroy = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_LogicException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_LogicException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_LogicException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

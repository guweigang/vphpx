import rt

struct Class_WordPress_AiClient_Common_Exception_TokenLimitReachedException {
	rt.PhpObjectBase
pub mut:
		maxTokens rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Common_Exception_TokenLimitReachedException) construct(message string, mut var_maxTokens Class_WordPress_AiClient_Common_Exception_?int, mut var_previous Class_WordPress_AiClient_Common_Exception_?Throwable)  {
	this.Class_WordPress_AiClient_Common_Exception_WordPress_AiClient_Common_Exception_RuntimeException.construct(rt.new_string(message), rt.new_int(0), rt.new_object('WordPress_AiClient_Common_Exception_?Throwable', []string{}, var_previous))
	this.maxTokens = var_maxTokens.dup()
}

fn (mut this Class_WordPress_AiClient_Common_Exception_TokenLimitReachedException) getmaxtokens() i64 {
	return (this.maxTokens).to_i64()
}

struct Class_WordPress_AiClient_Common_Exception_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_common_exception_tokenlimitreachedexception(message string, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_TokenLimitReachedException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_TokenLimitReachedException{
		PhpObjectBase: rt.PhpObjectBase{}
		maxTokens: rt.new_null()
	}
	obj.construct(message, arg_1, arg_2)
	return obj
}

fn create_wordpress_aiclient_common_exception_wordpress_aiclient_common_exception_runtimeexception() &Class_WordPress_AiClient_Common_Exception_WordPress_AiClient_Common_Exception_RuntimeException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_WordPress_AiClient_Common_Exception_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Common_Exception_TokenLimitReachedException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Common_Exception_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Common_Exception_?Throwable](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'getMaxTokens' {
			return rt.new_int(this.getmaxtokens())
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Common_Exception_TokenLimitReachedException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'maxTokens' { return this.maxTokens }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Common_Exception_TokenLimitReachedException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'maxTokens' { this.maxTokens = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WordPress_AiClient_Common_Exception_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_php_ai_client_src_common_exception_tokenlimitreachedexception_php() {
	// unsupported statement: Stmt_Declare
}

import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException) construct(var_strategy rt.PhpVal, mut var_candidates Class_WordPress_AiClientDependencies_Http_Discovery_Exception_array) {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return
		}
		mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return
	}
	mut var_classes := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_candidates])
	mut var_message := rt.call_function('sprintf', [
		rt.new_string('No valid candidate found using strategy "%s". We tested the following candidates: %s.'),
		var_strategy.dup(),
		rt.call_function('implode', [rt.new_string(', '),
			rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException', [
						'WordPress_AiClientDependencies_Http_Discovery_Exception',
						'Exception',
					], &this) },
					rt.ArrayItem{ key: none, val: 'stringify' },
				]),
				var_classes.dup(),
			])]),
	])
	this.Class_WordPress_AiClientDependencies_Http_Discovery_Exception.construct(var_message.dup())
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException) stringify(var_mixed rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_mixed.dup().is_string())) {
		return var_mixed.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_mixed.dup().is_array()))
		&& 2 == var_mixed.dup().array_count()))
	{
		return rt.call_function('sprintf', [rt.new_string('%s::%s'),
			this.stringify(var_mixed.array_get(0)), var_mixed.array_get(1)])
	}
	return if rt.is_true(rt.new_bool(var_mixed.dup().is_object())) { rt.call_function('get_class', [
			var_mixed.dup(),
		]) } else { rt.call_function('gettype', [var_mixed.dup()]) }
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_nocandidatefoundexception(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception() &Class_WordPress_AiClientDependencies_Http_Discovery_Exception {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Http_Discovery_Exception_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'stringify' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.stringify(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_third_party_http_discovery_exception_nocandidatefoundexception_php() {
}

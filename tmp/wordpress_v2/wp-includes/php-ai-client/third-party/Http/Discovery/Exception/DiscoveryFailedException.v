import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException {
	rt.PhpObjectBase
pub mut:
	exceptions rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException) construct(var_message rt.PhpVal, mut var_exceptions Class_WordPress_AiClientDependencies_Http_Discovery_Exception_array) {
	mut var_message_mutated := var_message
	this.exceptions = var_exceptions
	this.Class_WordPress_AiClientDependencies_Http_Discovery_Exception.construct(var_message_mutated.clone())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException.create(var_exceptions rt.PhpVal) rt.PhpVal {
	mut var_message :=
		rt.new_string('Could not find resource using any discovery strategy. Find more information at http://docs.php-http.org/en/latest/discovery.html#common-errors')
	mut iter_1 := var_exceptions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_e := item_1.val
		var_message = rt.concat(var_message, rt.new_string('\n - ' +
			(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()))
	}
	var_message = rt.concat(var_message, rt.new_string('\n\n'))
	return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_self',
		[]string{}, create_wordpress_aiclientdependencies_http_discovery_exception_self(var_message.clone(),
		var_exceptions.clone()))
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException) getexceptions() rt.PhpVal {
	return this.exceptions
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_discoveryfailedexception(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException{
		PhpObjectBase: rt.PhpObjectBase{}
		exceptions:    rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_self(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_self {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException.create(dispatch_arg_0)
		}
		'getExceptions' {
			return this.getexceptions()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'exceptions' { return this.exceptions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'exceptions' {
			this.exceptions = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

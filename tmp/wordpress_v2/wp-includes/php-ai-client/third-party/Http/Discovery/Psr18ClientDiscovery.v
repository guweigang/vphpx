import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery.find() rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery{}
	mut iife_result_0 :=
		iife_temp_0.findonebytype(Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface.class())
	mut var_client := iife_result_0
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1,
		'WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException')
	{
		mut var_e := var_e_1.clone()
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException',
			[]string{}, create_wordpress_aiclientdependencies_http_discovery_exception_notfoundexception(rt.new_string('No PSR-18 clients found. Make sure to install a package providing "psr/http-client-implementation". Example: "php-http/guzzle7-adapter".'),
			rt.new_int(0), var_e.clone())))
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	mut iife_temp_1 := Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery{}
	mut iife_result_1 := iife_temp_1.instantiateclass(var_client.clone())
	return iife_result_1
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_http_discovery_psr18clientdiscovery(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_classdiscovery(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_notfoundexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'find' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery.find()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

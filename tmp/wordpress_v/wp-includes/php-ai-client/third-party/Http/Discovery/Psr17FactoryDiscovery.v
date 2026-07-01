import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.createexception(var_type rt.PhpVal, mut var_e Class_WordPress_AiClientDependencies_Http_Discovery_Exception) rt.PhpVal {
	return create_wordpress_aiclientdependencies_http_discovery_exception_notfoundexception(
		'No PSR-17 ' + var_type.str() +
		' found. Install a package from this list: https://packagist.org/providers/psr/http-factory-implementation',
		rt.new_int(0), var_e.dup())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findrequestfactory() rt.PhpVal {
	mut var_messageFactory := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.findonebytype(arg_0)
	}(Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestFactoryInterface.class())
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
		mut var_e := var_e_1.dup()
		rt.throw_exception(Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.createexception(mut 'request factory', rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception',
			[]string{}, var_e)))
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
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.instantiateclass(arg_0)
	}(var_messageFactory.dup())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findresponsefactory() rt.PhpVal {
	mut var_messageFactory := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.findonebytype(arg_0)
	}(Class_WordPress_AiClientDependencies_Psr_Http_Message_ResponseFactoryInterface.class())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2,
		'WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException')
	{
		mut var_e := var_e_2.dup()
		rt.throw_exception(Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.createexception(mut 'response factory', rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception',
			[]string{}, var_e)))
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.instantiateclass(arg_0)
	}(var_messageFactory.dup())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findserverrequestfactory() rt.PhpVal {
	mut var_messageFactory := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.findonebytype(arg_0)
	}(Class_WordPress_AiClientDependencies_Psr_Http_Message_ServerRequestFactoryInterface.class())
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3,
		'WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException')
	{
		mut var_e := var_e_3.dup()
		rt.throw_exception(Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.createexception(mut 'server request factory', rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception',
			[]string{}, var_e)))
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.instantiateclass(arg_0)
	}(var_messageFactory.dup())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findstreamfactory() rt.PhpVal {
	mut var_messageFactory := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.findonebytype(arg_0)
	}(Class_WordPress_AiClientDependencies_Psr_Http_Message_StreamFactoryInterface.class())
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4,
		'WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException')
	{
		mut var_e := var_e_4.dup()
		rt.throw_exception(Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.createexception(mut 'stream factory', rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception',
			[]string{}, var_e)))
		unsafe {
			goto end_label_4
		}
	} else {
		rt.throw_exception(var_e_4)
		unsafe {
			goto end_label_4
		}
	}

	end_label_4:
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.instantiateclass(arg_0)
	}(var_messageFactory.dup())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.finduploadedfilefactory() rt.PhpVal {
	mut var_messageFactory := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.findonebytype(arg_0)
	}(Class_WordPress_AiClientDependencies_Psr_Http_Message_UploadedFileFactoryInterface.class())
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	unsafe {
		goto end_label_5
	}
	catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5,
		'WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException')
	{
		mut var_e := var_e_5.dup()
		rt.throw_exception(Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.createexception(mut 'uploaded file factory', rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception',
			[]string{}, var_e)))
		unsafe {
			goto end_label_5
		}
	} else {
		rt.throw_exception(var_e_5)
		unsafe {
			goto end_label_5
		}
	}

	end_label_5:
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.instantiateclass(arg_0)
	}(var_messageFactory.dup())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findurifactory() rt.PhpVal {
	mut var_messageFactory := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.findonebytype(arg_0)
	}(Class_WordPress_AiClientDependencies_Psr_Http_Message_UriFactoryInterface.class())
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	unsafe {
		goto end_label_6
	}
	catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6,
		'WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException')
	{
		mut var_e := var_e_6.dup()
		rt.throw_exception(Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.createexception(mut 'url factory', rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception',
			[]string{}, var_e)))
		unsafe {
			goto end_label_6
		}
	} else {
		rt.throw_exception(var_e_6)
		unsafe {
			goto end_label_6
		}
	}

	end_label_6:
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.instantiateclass(arg_0)
	}(var_messageFactory.dup())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findurlfactory() rt.PhpVal {
	return Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findurifactory()
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_http_discovery_psr17factorydiscovery() &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_classdiscovery() &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_notfoundexception() &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'createException' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Http_Discovery_Exception](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.createexception(dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'findRequestFactory' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findrequestfactory()
		}
		'findResponseFactory' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findresponsefactory()
		}
		'findServerRequestFactory' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findserverrequestfactory()
		}
		'findStreamFactory' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findstreamfactory()
		}
		'findUploadedFileFactory' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.finduploadedfilefactory()
		}
		'findUriFactory' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findurifactory()
		}
		'findUrlFactory' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery.findurlfactory()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_php_ai_client_third_party_http_discovery_psr17factorydiscovery_php() {
}

import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy {
	rt.PhpObjectBase
}

fn init_static_wordpress_aiclientdependencies_http_discovery_strategy_commonclassesstrategy() {
	rt.init_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy',
		'classes', rt.create_array([
		rt.ArrayItem{
			key: Class_WordPress_AiClientDependencies_Http_Message_MessageFactory.class()
			val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'class'
						val: Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory.class()
					},
					rt.ArrayItem{ key: 'condition', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory.class()
						},
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'class'
						val: Class_WordPress_AiClientDependencies_Http_Message_MessageFactory_GuzzleMessageFactory.class()
					},
					rt.ArrayItem{ key: 'condition', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_GuzzleHttp_Psr7_Request.class()
						},
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Http_Message_MessageFactory_GuzzleMessageFactory.class()
						},
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'class'
						val: Class_WordPress_AiClientDependencies_Http_Message_MessageFactory_DiactorosMessageFactory.class()
					},
					rt.ArrayItem{ key: 'condition', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Laminas_Diactoros_Request.class()
						},
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Http_Message_MessageFactory_DiactorosMessageFactory.class()
						},
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'class'
						val: Class_WordPress_AiClientDependencies_Http_Message_MessageFactory_SlimMessageFactory.class()
					},
					rt.ArrayItem{ key: 'condition', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Slim_Http_Request.class()
						},
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Http_Message_MessageFactory_SlimMessageFactory.class()
						},
					]) },
				]) },
			])
		},
		rt.ArrayItem{ key: Class_WordPress_AiClientDependencies_Http_Message_StreamFactory.class(), val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory.class()
				},
				rt.ArrayItem{ key: 'condition', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory.class()
					},
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Message_StreamFactory_GuzzleStreamFactory.class()
				},
				rt.ArrayItem{ key: 'condition', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_GuzzleHttp_Psr7_Request.class()
					},
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Http_Message_StreamFactory_GuzzleStreamFactory.class()
					},
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Message_StreamFactory_DiactorosStreamFactory.class()
				},
				rt.ArrayItem{ key: 'condition', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Laminas_Diactoros_Request.class()
					},
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Http_Message_StreamFactory_DiactorosStreamFactory.class()
					},
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Message_StreamFactory_SlimStreamFactory.class()
				},
				rt.ArrayItem{ key: 'condition', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Slim_Http_Request.class()
					},
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Http_Message_StreamFactory_SlimStreamFactory.class()
					},
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: Class_WordPress_AiClientDependencies_Http_Message_UriFactory.class(), val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory.class()
				},
				rt.ArrayItem{ key: 'condition', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory.class()
					},
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Message_UriFactory_GuzzleUriFactory.class()
				},
				rt.ArrayItem{ key: 'condition', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_GuzzleHttp_Psr7_Request.class()
					},
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Http_Message_UriFactory_GuzzleUriFactory.class()
					},
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Message_UriFactory_DiactorosUriFactory.class()
				},
				rt.ArrayItem{ key: 'condition', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Laminas_Diactoros_Request.class()
					},
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Http_Message_UriFactory_DiactorosUriFactory.class()
					},
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Message_UriFactory_SlimUriFactory.class()
				},
				rt.ArrayItem{ key: 'condition', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Slim_Http_Request.class()
					},
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Http_Message_UriFactory_SlimUriFactory.class()
					},
				]) },
			]) },
		]) },
		rt.ArrayItem{
			key: Class_WordPress_AiClientDependencies_Http_Client_HttpAsyncClient.class()
			val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'class'
						val: Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_HttplugClient.class()
					},
					rt.ArrayItem{ key: 'condition', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_HttplugClient.class()
						},
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_GuzzleHttp_Promise_Promise.class()
						},
						rt.ArrayItem{ key: none, val: rt.create_array([
							rt.ArrayItem{
								key: none
								val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.class()
							},
							rt.ArrayItem{ key: none, val: 'isPsr17FactoryInstalled' },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'class'
						val: Class_WordPress_AiClientDependencies_Http_Adapter_Guzzle7_Client.class()
					},
					rt.ArrayItem{
						key: 'condition'
						val: Class_WordPress_AiClientDependencies_Http_Adapter_Guzzle7_Client.class()
					},
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'class'
						val: Class_WordPress_AiClientDependencies_Http_Adapter_Guzzle6_Client.class()
					},
					rt.ArrayItem{
						key: 'condition'
						val: Class_WordPress_AiClientDependencies_Http_Adapter_Guzzle6_Client.class()
					},
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'class'
						val: Class_WordPress_AiClientDependencies_Http_Client_Curl_Client.class()
					},
					rt.ArrayItem{
						key: 'condition'
						val: Class_WordPress_AiClientDependencies_Http_Client_Curl_Client.class()
					},
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'class'
						val: Class_WordPress_AiClientDependencies_Http_Adapter_React_Client.class()
					},
					rt.ArrayItem{
						key: 'condition'
						val: Class_WordPress_AiClientDependencies_Http_Adapter_React_Client.class()
					},
				]) },
			])
		},
		rt.ArrayItem{ key: Class_WordPress_AiClientDependencies_Http_Client_HttpClient.class(), val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_HttplugClient.class()
				},
				rt.ArrayItem{ key: 'condition', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_HttplugClient.class()
					},
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.class()
						},
						rt.ArrayItem{ key: none, val: 'isPsr17FactoryInstalled' },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.class()
						},
						rt.ArrayItem{ key: none, val: 'isSymfonyImplementingHttpClient' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Guzzle7_Client.class()
				},
				rt.ArrayItem{
					key: 'condition'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Guzzle7_Client.class()
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Guzzle6_Client.class()
				},
				rt.ArrayItem{
					key: 'condition'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Guzzle6_Client.class()
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Guzzle5_Client.class()
				},
				rt.ArrayItem{
					key: 'condition'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Guzzle5_Client.class()
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Client_Curl_Client.class()
				},
				rt.ArrayItem{
					key: 'condition'
					val: Class_WordPress_AiClientDependencies_Http_Client_Curl_Client.class()
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Client_Socket_Client.class()
				},
				rt.ArrayItem{
					key: 'condition'
					val: Class_WordPress_AiClientDependencies_Http_Client_Socket_Client.class()
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Buzz_Client.class()
				},
				rt.ArrayItem{
					key: 'condition'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Buzz_Client.class()
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_React_Client.class()
				},
				rt.ArrayItem{
					key: 'condition'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_React_Client.class()
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Cake_Client.class()
				},
				rt.ArrayItem{
					key: 'condition'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Cake_Client.class()
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Artax_Client.class()
				},
				rt.ArrayItem{
					key: 'condition'
					val: Class_WordPress_AiClientDependencies_Http_Adapter_Artax_Client.class()
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.class()
					},
					rt.ArrayItem{ key: none, val: 'buzzInstantiate' },
				]) },
				rt.ArrayItem{ key: 'condition', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents.class()
					},
					rt.ArrayItem{
						key: none
						val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Message_ResponseBuilder.class()
					},
				]) },
			]) },
		]) },
		rt.ArrayItem{
			key: Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface.class()
			val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'class', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.class()
						},
						rt.ArrayItem{ key: none, val: 'symfonyPsr18Instantiate' },
					]) },
					rt.ArrayItem{ key: 'condition', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client.class()
						},
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestFactoryInterface.class()
						},
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'class'
						val: Class_WordPress_AiClientDependencies_GuzzleHttp_Client.class()
					},
					rt.ArrayItem{ key: 'condition', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.class()
						},
						rt.ArrayItem{ key: none, val: 'isGuzzleImplementingPsr18' },
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'class', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.class()
						},
						rt.ArrayItem{ key: none, val: 'buzzInstantiate' },
					]) },
					rt.ArrayItem{ key: 'condition', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents.class()
						},
						rt.ArrayItem{
							key: none
							val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Message_ResponseBuilder.class()
						},
					]) },
				]) },
			])
		},
	]))
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.getcandidates(var_type rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface.class(),
		var_type))
	{
		return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.getpsr18candidates()
	}
	return if !(rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy',
		'classes').array_get(var_type)).is_null() {
		rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy',
			'classes').array_get(var_type)
	} else {
		rt.new_array()
	}
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.getpsr18candidates() rt.PhpVal {
	mut var_candidates := rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy',
		'classes').array_get(Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface.class())
	mut iter_1 := rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy',
		'classes').array_get(Class_WordPress_AiClientDependencies_Http_Client_HttpClient.class()).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_c := item_1.val
		if !(var_c.array_get(rt.new_string('class')).is_string()) {
			continue
		}
		mut iife_temp_0 := Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery{}
		mut iife_result_0 := iife_temp_0.safeclassexists(var_c.array_get(rt.new_string('class')))
		if rt.is_true(iife_result_0)
			&& rt.is_true(rt.call_function('is_subclass_of', [var_c.array_get(rt.new_string('class')), Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface.class()])) {
			var_candidates.array_push(var_c.clone())
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
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
			'WordPress_AiClientDependencies_Http_Discovery_Strategy_Throwable')
		{
			mut var_e := var_e_1.clone()
			rt.call_function('trigger_error', [
				rt.call_function('sprintf', [
					rt.new_string('Got exception "%s (%s)" while checking if a PSR-18 Client is available'),
					rt.call_function('get_class', [var_e.clone()]),
					rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				]),
				rt.get_constant('E_USER_WARNING'),
			])
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
	}
	return var_candidates.clone()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.buzzinstantiate() rt.PhpVal {
	mut iife_temp_1 := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
	mut iife_result_1 := iife_temp_1.findresponsefactory()
	return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents',
		[]string{},
		create_wordpress_aiclientdependencies_http_discovery_strategy_wordpress_aiclientdependencies_buzz_client_filegetcontents(iife_result_1))
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.symfonypsr18instantiate() rt.PhpVal {
	mut iife_temp_2 := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
	mut iife_result_2 := iife_temp_2.findresponsefactory()
	mut iife_temp_3 := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
	mut iife_result_3 := iife_temp_3.findstreamfactory()
	return rt.new_object('WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client',
		[]string{}, create_wordpress_aiclientdependencies_symfony_component_httpclient_psr18client(rt.new_null(),
		iife_result_2, iife_result_3))
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.isguzzleimplementingpsr18() rt.PhpVal {
	return rt.call_function('defined', [
		rt.new_string('GuzzleHttp\\ClientInterface::MAJOR_VERSION'),
	])
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.issymfonyimplementinghttpclient() rt.PhpVal {
	return rt.call_function('is_subclass_of', [
		Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_HttplugClient.class(),
		Class_WordPress_AiClientDependencies_Http_Client_HttpClient.class(),
	])
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.ispsr17factoryinstalled() bool {
	mut iife_temp_4 := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
	mut iife_result_4 := iife_temp_4.findresponsefactory()
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
		'WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException')
	{
		mut var_e := var_e_2.clone()
		return false
		unsafe {
			goto end_label_2
		}
	} else if rt.instance_of(var_e_2,
		'WordPress_AiClientDependencies_Http_Discovery_Strategy_Throwable')
	{
		var_e = var_e_2.clone()
		rt.call_function('trigger_error', [
			rt.call_function('sprintf', [
				rt.new_string('Got exception "%s (%s)" while checking if a PSR-17 ResponseFactory is available'),
				rt.call_function('get_class', [var_e.clone()]),
				rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
			]),
			rt.get_constant('E_USER_WARNING'),
		])
		return false
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
	return true
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_http_discovery_strategy_commonclassesstrategy(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy{
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

fn create_wordpress_aiclientdependencies_http_discovery_strategy_wordpress_aiclientdependencies_buzz_client_filegetcontents(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_psr17factorydiscovery(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_symfony_component_httpclient_psr18client(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client {
	mut obj := &Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getCandidates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.getcandidates(dispatch_arg_0)
		}
		'getPsr18Candidates' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.getpsr18candidates()
		}
		'buzzInstantiate' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.buzzinstantiate()
		}
		'symfonyPsr18Instantiate' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.symfonypsr18instantiate()
		}
		'isGuzzleImplementingPsr18' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.isguzzleimplementingpsr18()
		}
		'isSymfonyImplementingHttpClient' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.issymfonyimplementinghttpclient()
		}
		'isPsr17FactoryInstalled' {
			return rt.new_bool(Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.ispsr17factoryinstalled())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

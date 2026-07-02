import rt

fn wp_is_connector_registered(id string) bool {
	mut var_id := id
	mut var_registry := rt.new_null()
	mut iife_temp_0 := Class_WP_Connector_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_registry = iife_result_0
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return false
	}
	return (rt.call_method(var_registry, 'is_registered', [rt.new_string(id)])).to_bool()
}

fn wp_get_connector(id string) rt.PhpVal {
	mut var_id := id
	mut var_registry := rt.new_null()
	mut iife_temp_1 := Class_WP_Connector_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	var_registry = iife_result_1
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_null()
	}
	return rt.call_method(var_registry, 'get_registered', [rt.new_string(id)])
}

fn wp_get_connectors() rt.PhpVal {
	mut var_registry := rt.new_null()
	mut iife_temp_2 := Class_WP_Connector_Registry{}
	mut iife_result_2 := iife_temp_2.get_instance()
	var_registry = iife_result_2
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_array()
	}
	return rt.call_method(var_registry, 'get_all_registered', []rt.PhpVal{})
}

fn _wp_connectors_resolve_ai_provider_logo_url(path string) string {
	mut var_path := path
	mut var_mu_plugin_dir := rt.new_null()
	mut var_logo_url := rt.new_null()
	mut var_plugin_dir := rt.new_null()
	if !(var_path.len > 0 && var_path != '0') {
		return (rt.new_null()).str()
	}
	var_path = (rt.call_function('wp_normalize_path', [rt.new_string((var_path).str())])).str()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((var_path).str())]))))) {
		return (rt.new_null()).str()
	}
	var_mu_plugin_dir = rt.call_function('wp_normalize_path', [rt.get_constant('WPMU_PLUGIN_DIR')])
	if rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_path).str()), rt.new_string((var_mu_plugin_dir).str() + '/')])) {
		var_logo_url = rt.call_function('plugins_url', [rt.call_function('substr', [rt.new_string((var_path).str()), rt.new_int(var_mu_plugin_dir.clone().to_string().len)]), rt.new_string((rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/.')])
		return (if rt.is_true(var_logo_url) { var_logo_url } else { rt.new_null() }).str()
	}
	var_plugin_dir = rt.call_function('wp_normalize_path', [rt.get_constant('WP_PLUGIN_DIR')])
	if rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_path).str()), rt.new_string((var_plugin_dir).str() + '/')])) {
		var_logo_url = rt.call_function('plugins_url', [rt.call_function('substr', [rt.new_string((var_path).str()), rt.new_int(var_plugin_dir.clone().to_string().len)])])
		return (if rt.is_true(var_logo_url) { var_logo_url } else { rt.new_null() }).str()
	}
	rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Provider logo path must be located within the plugins or must-use plugins directory.')]), rt.new_string('7.0.0')])
	return (rt.new_null()).str()
}

fn _wp_connectors_init() {
	mut var_registry := rt.new_null()
	var_registry = create_wp_connector_registry()
	mut iife_temp_3 := Class_WP_Connector_Registry{}
	mut iife_result_3 := iife_temp_3.set_instance(var_registry.clone())
	if rt.is_true(rt.call_function('wp_supports_ai', []rt.PhpVal{})) {
		_wp_connectors_register_default_ai_providers(var_registry.clone())
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
		}
	rt.call_method(var_registry, 'register', [rt.new_string('akismet'), rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Akismet Anti-spam')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Protect your site from spam.')]) }, rt.ArrayItem{ key: 'type', val: 'spam_filtering' }, rt.ArrayItem{ key: 'plugin', val: rt.create_array([rt.ArrayItem{ key: 'file', val: 'akismet/akismet.php' }, rt.ArrayItem{ key: 'is_active', val: rt.new_closure(closure_5_fn) }]) }, rt.ArrayItem{ key: 'authentication', val: rt.create_array([rt.ArrayItem{ key: 'method', val: 'api_key' }, rt.ArrayItem{ key: 'credentials_url', val: 'https://akismet.com/get/' }, rt.ArrayItem{ key: 'setting_name', val: 'wordpress_api_key' }, rt.ArrayItem{ key: 'constant_name', val: 'WPCOM_API_KEY' }]) }])])
	rt.call_function('do_action', [rt.new_string('wp_connectors_init'), var_registry.clone()])
}

fn _wp_connectors_register_default_ai_providers(var_registry rt.PhpVal) {
	mut var_defaults := rt.new_null()
	mut var_ai_registry := rt.new_null()
	mut var_connector_id := rt.new_null()
	mut var_provider_class_name := rt.new_null()
	mut var_provider_metadata := rt.new_null()
	mut var_auth_method := rt.new_null()
	mut var_is_api_key := false
	mut var_credentials_url := rt.new_null()
	mut var_authentication := map[string]rt.PhpVal{}
	mut var_name := rt.new_null()
	mut var_description := rt.new_null()
	mut var_logo_url := rt.new_null()
	mut var_args := map[string]rt.PhpVal{}
	mut var_id := rt.new_null()
	mut var_sanitized_id := rt.new_null()
	mut var_constant_case_key := rt.new_null()
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'anthropic', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'Anthropic' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Text generation with Claude.')]) }, rt.ArrayItem{ key: 'type', val: 'ai_provider' }, rt.ArrayItem{ key: 'plugin', val: rt.create_array([rt.ArrayItem{ key: 'file', val: 'ai-provider-for-anthropic/plugin.php' }]) }, rt.ArrayItem{ key: 'authentication', val: rt.create_array([rt.ArrayItem{ key: 'method', val: 'api_key' }, rt.ArrayItem{ key: 'credentials_url', val: 'https://platform.claude.com/settings/keys' }]) }]) }, rt.ArrayItem{ key: 'google', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'Google' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Text and image generation with Gemini and Imagen.')]) }, rt.ArrayItem{ key: 'type', val: 'ai_provider' }, rt.ArrayItem{ key: 'plugin', val: rt.create_array([rt.ArrayItem{ key: 'file', val: 'ai-provider-for-google/plugin.php' }]) }, rt.ArrayItem{ key: 'authentication', val: rt.create_array([rt.ArrayItem{ key: 'method', val: 'api_key' }, rt.ArrayItem{ key: 'credentials_url', val: 'https://aistudio.google.com/api-keys' }]) }]) }, rt.ArrayItem{ key: 'openai', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'OpenAI' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Text and image generation with GPT and Dall-E.')]) }, rt.ArrayItem{ key: 'type', val: 'ai_provider' }, rt.ArrayItem{ key: 'plugin', val: rt.create_array([rt.ArrayItem{ key: 'file', val: 'ai-provider-for-openai/plugin.php' }]) }, rt.ArrayItem{ key: 'authentication', val: rt.create_array([rt.ArrayItem{ key: 'method', val: 'api_key' }, rt.ArrayItem{ key: 'credentials_url', val: 'https://platform.openai.com/api-keys' }]) }]) }])
	mut iife_temp_5 := Class_WordPress_AiClient_AiClient{}
	mut iife_result_5 := iife_temp_5.defaultregistry()
	var_ai_registry = iife_result_5
	mut iter_1 := rt.call_function('array_filter', [rt.call_method(var_ai_registry, 'getRegisteredProviderIds', []rt.PhpVal{})]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_connector_id_shadow := item_1.val
		var_provider_class_name = rt.call_method(var_ai_registry, 'getProviderClassName', [var_connector_id_shadow.clone()])
		mut iife_temp_6 := Class_{"nodeType":"Expr_Variable","line":330,"name":"provider_class_name"}{}
		mut iife_result_6 := iife_temp_6.metadata()
		var_provider_metadata = iife_result_6
		var_auth_method = rt.call_method(var_provider_metadata, 'getAuthenticationMethod', []rt.PhpVal{})
		var_is_api_key = rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_auth_method)))) && rt.is_true(rt.call_method(var_auth_method, 'isApiKey', []rt.PhpVal{}))
		if var_is_api_key {
			var_credentials_url = rt.call_method(var_provider_metadata, 'getCredentialsUrl', []rt.PhpVal{})
			var_authentication = { 'method': rt.new_string('api_key') }
			if rt.is_true(var_credentials_url) {
				var_authentication['credentials_url'] = var_credentials_url.clone()
			}
		} else {
		var_authentication = { 'method': rt.new_string('none') }
		}
		var_name = rt.call_method(var_provider_metadata, 'getName', []rt.PhpVal{})
		var_description = rt.call_method(var_provider_metadata, 'getDescription', []rt.PhpVal{})
		var_logo_url = if rt.is_true(rt.call_method(var_provider_metadata, 'getLogoPath', []rt.PhpVal{})) { rt.new_string(_wp_connectors_resolve_ai_provider_logo_url(rt.call_method(var_provider_metadata, 'getLogoPath', []rt.PhpVal{}))) } else { rt.new_null() }
		if var_defaults.array_isset(var_connector_id_shadow) {
			if rt.is_true(var_name) {
				var_defaults.array_get_mut(var_connector_id_shadow).array_set('name', var_name.clone())
			}
			if rt.is_true(var_description) {
				var_defaults.array_get_mut(var_connector_id_shadow).array_set('description', var_description.clone())
			}
			if rt.is_true(var_logo_url) {
				var_defaults.array_get_mut(var_connector_id_shadow).array_set('logo_url', var_logo_url.clone())
			}
			var_defaults.array_get_mut(var_connector_id_shadow).array_get_mut('authentication').array_set('method', var_authentication['method'])
			if !(!rt.is_true(var_authentication['credentials_url'])) {
				var_defaults.array_get_mut(var_connector_id_shadow).array_get_mut('authentication').array_set('credentials_url', var_authentication['credentials_url'])
			}
		} else {
			var_defaults.array_set(var_connector_id_shadow, rt.create_array([rt.ArrayItem{ key: 'name', val: if rt.is_true(var_name) { var_name } else { rt.call_function('ucwords', [var_connector_id_shadow.clone()]) } }, rt.ArrayItem{ key: 'description', val: if rt.is_true(var_description) { var_description } else { rt.new_string('') } }, rt.ArrayItem{ key: 'type', val: 'ai_provider' }, rt.ArrayItem{ key: 'authentication', val: var_authentication }]))
			if rt.is_true(var_logo_url) {
				var_defaults.array_get_mut(var_connector_id_shadow).array_set('logo_url', var_logo_url.clone())
			}
		}
	}
	mut iter_2 := var_defaults.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_args_shadow := item_2.val
		mut var_id_shadow := item_2.key
		if rt.is_true(rt.identical(rt.new_string('api_key'), var_args_shadow['authentication'].array_get(rt.new_string('method')))) {
			var_sanitized_id = rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), var_id_shadow.clone()])
			var_args_shadow.array_get_mut('authentication').array_set('setting_name', "connectors_ai_${var_sanitized_id.to_string()}_api_key")
			var_constant_case_key = rt.new_string((rt.call_function('preg_replace', [rt.new_string('/([a-z])([A-Z])/'), rt.new_string('$1_$2'), var_sanitized_id.clone()])).str().to_upper() + '_API_KEY')
			var_args_shadow.array_get_mut('authentication').array_set('constant_name', var_constant_case_key.clone())
			var_args_shadow.array_get_mut('authentication').array_set('env_var_name', var_constant_case_key.clone())
		}
		closure_8_fn := fn [var_ai_registry, var_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			return
			unsafe { goto end_label_1 }
		
		catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Exception') {
				mut var_e := var_e_1.clone()
				return
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}
		
		end_label_1:
			return rt.new_null()
			}
		var_args_shadow.array_get_mut('plugin').array_set('is_active', rt.new_closure(closure_8_fn))
		rt.call_method(var_registry, 'register', [var_id_shadow.clone(), var_args_shadow.clone()])
	}
}

fn _wp_connectors_mask_api_key(key string) string {
	mut var_key := key
	if key.len <= 4 {
		return key
	}
	return (rt.call_function('str_repeat', [rt.new_string('•'), rt.call_function('min', [rt.new_int(key.len - 4), rt.new_int(16)])])).str() + (rt.call_function('substr', [rt.new_string(key), rt.new_int(-4)])).str()
}

fn _wp_connectors_get_api_key_source(setting_name string, env_var_name string, constant_name string) string {
	mut var_setting_name := setting_name
	mut var_env_var_name := env_var_name
	mut var_constant_name := constant_name
	mut var_env_value := rt.new_null()
	mut var_const_value := rt.new_null()
	mut var_db_value := rt.new_null()
	if rt.is_true(rt.new_bool('' != env_var_name)) {
		var_env_value = rt.call_function('getenv', [rt.new_string(env_var_name)])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_env_value)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_env_value)))) {
			return 'env'
		}
	}
	if rt.is_true(rt.new_bool('' != constant_name)) && rt.is_true(rt.call_function('defined', [rt.new_string(constant_name)])) {
		var_const_value = rt.call_function('constant', [rt.new_string(constant_name)])
		if var_const_value.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_const_value)))) {
			return 'constant'
		}
	}
	var_db_value = rt.call_function('get_option', [rt.new_string(setting_name), rt.new_string('')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_db_value)))) {
		return 'database'
	}
	return 'none'
}

fn _wp_connectors_is_ai_api_key_valid(key string, provider_id string) bool {
	mut var_key := key
	mut var_provider_id := provider_id
	mut var_registry := rt.new_null()
	mut var_e := rt.new_null()
	mut iife_temp_8 := Class_WordPress_AiClient_AiClient{}
	mut iife_result_8 := iife_temp_8.defaultregistry()
	var_registry = iife_result_8
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_registry, 'hasProvider', [rt.new_string(provider_id)]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The provider "%s" is not registered in the AI client registry.')]), rt.new_string(provider_id)]), rt.new_string('7.0.0')])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		return (rt.new_null()).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(var_registry, 'setProviderRequestAuthentication', [rt.new_string(provider_id), create_wordpress_aiclient_providers_http_dto_apikeyrequestauthentication(rt.new_string(key))])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	return (rt.call_method(var_registry, 'isProviderConfigured', [rt.new_string(provider_id)])).to_bool()
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		var_e = var_e_2.clone()
		rt.call_function('wp_trigger_error', [rt.new_string(@FN), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])
		return (rt.new_null()).to_bool()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return false
}

fn _wp_connectors_rest_settings_dispatch(var_response rt.PhpVal, var_server rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.new_null()
	mut var_is_update := false
	mut var_connector_data := map[string]rt.PhpVal{}
	mut var_connector_id := rt.new_null()
	mut var_auth := rt.new_null()
	mut var_setting_name := rt.new_null()
	mut var_value := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/wp/v2/settings'), rt.call_method(var_request, 'get_route', []rt.PhpVal{}))))) {
		return var_response.clone()
	}
	var_data = rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	if !(var_data.clone().is_array()) {
		return var_response.clone()
	}
	var_is_update = rt.is_true(rt.identical(rt.new_string('POST'), rt.call_method(var_request, 'get_method', []rt.PhpVal{}))) || rt.is_true(rt.identical(rt.new_string('PUT'), rt.call_method(var_request, 'get_method', []rt.PhpVal{})))
	mut iter_3 := wp_get_connectors().iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_connector_data_shadow := item_3.val
		mut var_connector_id_shadow := item_3.key
		var_auth = var_connector_data_shadow['authentication']
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('api_key'), var_auth.array_get(rt.new_string('method')))))) || !rt.is_true(var_auth.array_get(rt.new_string('setting_name'))) {
			continue
		}
		var_setting_name = var_auth.array_get(rt.new_string('setting_name'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.clone().array_isset(var_setting_name.clone())))))) {
			continue
		}
		var_value = var_data.array_get(var_setting_name)
		if var_is_update && var_value.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value)))) && rt.is_true(rt.identical(rt.new_string('ai_provider'), var_connector_data_shadow['type'])) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(_wp_connectors_is_ai_api_key_valid(var_value.clone(), var_connector_id_shadow.clone())))))) {
				rt.call_function('update_option', [var_setting_name.clone(), rt.new_string('')])
				var_data.array_set(var_setting_name, '')
				continue
			}
		}
		if var_value.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value)))) {
			var_data.array_set(var_setting_name, _wp_connectors_mask_api_key(var_value.clone()))
		}
	}
	rt.call_method(var_response, 'set_data', [var_data.clone()])
	return var_response.clone()
}

fn _wp_register_default_connector_settings() {
	mut var_registered_settings := rt.new_null()
	mut var_connector_data := map[string]rt.PhpVal{}
	mut var_auth := rt.new_null()
	var_registered_settings = rt.call_function('get_registered_settings', []rt.PhpVal{})
	mut iter_4 := wp_get_connectors().iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_connector_data_shadow := item_4.val
		var_auth = var_connector_data_shadow['authentication']
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('api_key'), var_auth.array_get(rt.new_string('method')))))) || !rt.is_true(var_auth.array_get(rt.new_string('setting_name'))) {
			continue
		}
		if var_registered_settings.array_isset(var_auth.array_get(rt.new_string('setting_name'))) {
			continue
		}
		if !(var_connector_data_shadow['plugin'].array_isset(rt.new_string('is_active'))) || !(rt.call_function('is_callable', [var_connector_data_shadow['plugin'].array_get(rt.new_string('is_active'))])) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('call_user_func', [var_connector_data_shadow['plugin'].array_get(rt.new_string('is_active'))]))))) {
			continue
		}
		rt.call_function('register_setting', [rt.new_string('connectors'), var_auth.array_get(rt.new_string('setting_name')), rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s API Key')]), var_connector_data_shadow['name']]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('API key for the %s connector.')]), var_connector_data_shadow['name']]) }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'show_in_rest', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }])])
	}
}

fn _wp_connectors_pass_default_keys_to_ai_client() {
	mut var_ai_registry := rt.new_null()
	mut var_connector_data := map[string]rt.PhpVal{}
	mut var_connector_id := rt.new_null()
	mut var_auth := rt.new_null()
	mut var_key_source := ''
	mut var_api_key := rt.new_null()
	mut var_e := rt.new_null()
	mut iife_temp_9 := Class_WordPress_AiClient_AiClient{}
	mut iife_result_9 := iife_temp_9.defaultregistry()
	var_ai_registry = iife_result_9
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut iter_5 := wp_get_connectors().iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_connector_data_shadow := item_5.val
		mut var_connector_id_shadow := item_5.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('ai_provider'), var_connector_data_shadow['type'])))) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		var_auth = var_connector_data_shadow['authentication']
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('api_key'), var_auth.array_get(rt.new_string('method')))))) || !rt.is_true(var_auth.array_get(rt.new_string('setting_name'))) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_ai_registry, 'hasProvider', [var_connector_id_shadow.clone()]))))) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		var_key_source = _wp_connectors_get_api_key_source(var_auth.array_get(rt.new_string('setting_name')), if !(var_auth.array_get(rt.new_string('env_var_name'))).is_null() { var_auth.array_get(rt.new_string('env_var_name')) } else { rt.new_string('') }, if !(var_auth.array_get(rt.new_string('constant_name'))).is_null() { var_auth.array_get(rt.new_string('constant_name')) } else { rt.new_string('') })
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if rt.is_true(rt.identical(rt.new_string('env'), rt.new_string((var_key_source).str()))) || rt.is_true(rt.identical(rt.new_string('constant'), rt.new_string((var_key_source).str()))) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		var_api_key = rt.call_function('get_option', [var_auth.array_get(rt.new_string('setting_name')), rt.new_string('')])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if !(var_api_key.clone().is_string()) || rt.is_true(rt.identical(rt.new_string(''), var_api_key)) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_method(var_ai_registry, 'setProviderRequestAuthentication', [var_connector_id_shadow.clone(), create_wordpress_aiclient_providers_http_dto_apikeyrequestauthentication(var_api_key.clone())])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		var_e = var_e_3.clone()
		rt.call_function('wp_trigger_error', [rt.new_string(@FN), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
}

fn _wp_connectors_get_connector_script_module_data(var_data rt.PhpVal) rt.PhpVal {
	mut var_registry := rt.new_null()
	mut var_connectors := rt.new_null()
	mut var_connector_data := map[string]rt.PhpVal{}
	mut var_connector_id := rt.new_null()
	mut var_auth := rt.new_null()
	mut var_auth_out := map[string]rt.PhpVal{}
	mut var_key_source := ''
	mut var_e := rt.new_null()
	mut var_connector_out := map[string]rt.PhpVal{}
	mut var_file := rt.new_null()
	mut var_is_activated := rt.new_null()
	mut var_is_installed := false
	mut iife_temp_10 := Class_WordPress_AiClient_AiClient{}
	mut iife_result_10 := iife_temp_10.defaultregistry()
	var_registry = iife_result_10
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('validate_plugin')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	var_connectors = rt.new_array()
	mut iter_6 := wp_get_connectors().iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_connector_data_shadow := item_6.val
		mut var_connector_id_shadow := item_6.key
		var_auth = var_connector_data_shadow['authentication']
		var_auth_out = { 'method': var_auth.array_get(rt.new_string('method')) }
		if rt.is_true(rt.identical(rt.new_string('api_key'), var_auth.array_get(rt.new_string('method')))) {
			var_auth_out['settingName'] = if !(var_auth.array_get(rt.new_string('setting_name'))).is_null() { var_auth.array_get(rt.new_string('setting_name')) } else { rt.new_string('') }
			var_auth_out['credentialsUrl'] = if !(var_auth.array_get(rt.new_string('credentials_url'))).is_null() { var_auth.array_get(rt.new_string('credentials_url')) } else { rt.new_null() }
			var_key_source = _wp_connectors_get_api_key_source(if !(var_auth.array_get(rt.new_string('setting_name'))).is_null() { var_auth.array_get(rt.new_string('setting_name')) } else { rt.new_string('') }, if !(var_auth.array_get(rt.new_string('env_var_name'))).is_null() { var_auth.array_get(rt.new_string('env_var_name')) } else { rt.new_string('') }, if !(var_auth.array_get(rt.new_string('constant_name'))).is_null() { var_auth.array_get(rt.new_string('constant_name')) } else { rt.new_string('') })
			var_auth_out['keySource'] = rt.new_string((var_key_source).str()).clone()
			if rt.is_true(rt.identical(rt.new_string('ai_provider'), var_connector_data_shadow['type'])) {
				var_auth_out['isConnected'] = rt.new_bool(rt.is_true(rt.call_method(var_registry, 'hasProvider', [var_connector_id_shadow.clone()])) && rt.is_true(rt.call_method(var_registry, 'isProviderConfigured', [var_connector_id_shadow.clone()])))
				if rt.has_exception() { unsafe { goto catch_label_4 } }
				unsafe { goto end_label_4 }

catch_label_4:
				mut var_e_4 := rt.get_and_clear_exception()
				if rt.instance_of(var_e_4, 'Exception') {
					var_e = var_e_4.clone()
					var_auth_out['isConnected'] = rt.new_bool(false)
					unsafe { goto end_label_4 }
				}
				else {
					rt.throw_exception(var_e_4)
					unsafe { goto end_label_4 }
				}

end_label_4:
			} else {
				var_auth_out['isConnected'] = rt.new_bool('none' != var_key_source)
			}
		}
		var_connector_out = { 'name': var_connector_data_shadow['name'], 'description': var_connector_data_shadow['description'], 'logoUrl': if !(!rt.is_true(var_connector_data_shadow['logo_url'])) { var_connector_data_shadow['logo_url'] } else { rt.new_null() }, 'type': var_connector_data_shadow['type'], 'authentication': var_auth_out }
		if !(!rt.is_true(var_connector_data_shadow['plugin'].array_get(rt.new_string('file')))) {
			var_file = var_connector_data_shadow['plugin'].array_get(rt.new_string('file'))
			var_is_activated = rt.new_bool((rt.call_function('call_user_func', [var_connector_data_shadow['plugin'].array_get(rt.new_string('is_active'))])).to_bool())
			var_is_installed = rt.is_true(var_is_activated) || rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_plugin', [var_file.clone()])))
			var_connector_out['plugin'] = rt.create_array([rt.ArrayItem{ key: 'file', val: var_file }, rt.ArrayItem{ key: 'isInstalled', val: var_is_installed }, rt.ArrayItem{ key: 'isActivated', val: var_is_activated }])
		}
		var_connectors.array_set(var_connector_id_shadow, var_connector_out.clone())
	}
	rt.call_function('ksort', [var_connectors.clone()])
	var_data.array_set('connectors', var_connectors.clone())
	var_data.array_set('isFileModDisabled', !(rt.is_true(rt.call_function('wp_is_file_mod_allowed', [rt.new_string('install_plugins')]))))
	return var_data.clone()
}

struct Class_WP_Connector_Registry {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_AiClient {
	rt.PhpObjectBase
}

struct Class_{"nodeType":"Expr_Variable","line":330,"name":"provider_class_name"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication {
	rt.PhpObjectBase
}

fn create_wp_connector_registry(_args ...rt.PhpVal) &Class_WP_Connector_Registry {
	mut obj := &Class_WP_Connector_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_aiclient(_args ...rt.PhpVal) &Class_WordPress_AiClient_AiClient {
	mut obj := &Class_WordPress_AiClient_AiClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_{"nodetype":"expr_variable","line":330,"name":"provider_class_name"}(_args ...rt.PhpVal) &Class_{"nodeType":"Expr_Variable","line":330,"name":"provider_class_name"} {
	mut obj := &Class_{"nodeType":"Expr_Variable","line":330,"name":"provider_class_name"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_dto_apikeyrequestauthentication(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Connector_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Connector_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Connector_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_AiClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_AiClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_AiClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_{"nodeType":"Expr_Variable","line":330,"name":"provider_class_name"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_{"nodeType":"Expr_Variable","line":330,"name":"provider_class_name"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_{"nodeType":"Expr_Variable","line":330,"name":"provider_class_name"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_filter', [rt.new_string('rest_post_dispatch'), rt.new_string('_wp_connectors_rest_settings_dispatch'), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('_wp_register_default_connector_settings'), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('_wp_connectors_pass_default_keys_to_ai_client'), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('script_module_data_options-connectors-wp-admin'), rt.new_string('_wp_connectors_get_connector_script_module_data')])
}

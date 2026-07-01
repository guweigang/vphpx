import rt

fn wp_is_connector_registered(id string) bool {
	mut var_registry := fn () rt.PhpVal { mut temp := Class_WP_Connector_Registry{}; return temp.get_instance() }()
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return false
	}
	return (rt.call_method(var_registry, 'is_registered', [rt.new_string(id)])).to_bool()
}

fn wp_get_connector(id string) rt.PhpVal {
	mut var_registry := fn () rt.PhpVal { mut temp := Class_WP_Connector_Registry{}; return temp.get_instance() }()
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_null()
	}
	return rt.call_method(var_registry, 'get_registered', [rt.new_string(id)])
}

fn wp_get_connectors() rt.PhpVal {
	mut var_registry := fn () rt.PhpVal { mut temp := Class_WP_Connector_Registry{}; return temp.get_instance() }()
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_array()
	}
	return rt.call_method(var_registry, 'get_all_registered', []rt.PhpVal{})
}

fn _wp_connectors_resolve_ai_provider_logo_url(path string) string {
	if !(var_path.len > 0 && var_path != '0') {
		return (rt.new_null()).str()
	}
	path = (rt.call_function('wp_normalize_path', [rt.new_string(path)])).str()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string(path)]))))) {
		return (rt.new_null()).str()
	}
	mut var_mu_plugin_dir := rt.call_function('wp_normalize_path', [rt.get_constant('WPMU_PLUGIN_DIR')])
	if rt.is_true(rt.call_function('str_starts_with', [rt.new_string(path), (var_mu_plugin_dir).str() + '/'])) {
		mut var_logo_url := rt.call_function('plugins_url', [rt.call_function('substr', [rt.new_string(path), rt.new_int(var_mu_plugin_dir.dup().to_string().len)]), (rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/.'])
		return (if rt.is_true(var_logo_url) { var_logo_url } else { rt.new_null() }).str()
	}
	mut var_plugin_dir := rt.call_function('wp_normalize_path', [rt.get_constant('WP_PLUGIN_DIR')])
	if rt.is_true(rt.call_function('str_starts_with', [rt.new_string(path), (var_plugin_dir).str() + '/'])) {
		var_logo_url = rt.call_function('plugins_url', [rt.call_function('substr', [rt.new_string(path), rt.new_int(var_plugin_dir.dup().to_string().len)])])
		return (if rt.is_true(var_logo_url) { var_logo_url } else { rt.new_null() }).str()
	}
	rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Provider logo path must be located within the plugins or must-use plugins directory.')]), rt.new_string('7.0.0')])
	return (rt.new_null()).str()
}

fn _wp_connectors_init() {
	mut var_registry := create_wp_connector_registry()
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Connector_Registry{}; return temp.set_instance(arg_0) }(var_registry.dup())
	if rt.is_true(rt.call_function('wp_supports_ai', []rt.PhpVal{})) {
		_wp_connectors_register_default_ai_providers(var_registry.dup())
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return rt.call_function('defined', [rt.new_string('AKISMET_VERSION')])
	}
	rt.call_method(var_registry, 'register', [rt.new_string('akismet'), rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Akismet Anti-spam')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Protect your site from spam.')]) }, rt.ArrayItem{ key: 'type', val: 'spam_filtering' }, rt.ArrayItem{ key: 'plugin', val: rt.create_array([rt.ArrayItem{ key: 'file', val: 'akismet/akismet.php' }, rt.ArrayItem{ key: 'is_active', val: rt.new_closure(closure_1_fn) }]) }, rt.ArrayItem{ key: 'authentication', val: rt.create_array([rt.ArrayItem{ key: 'method', val: 'api_key' }, rt.ArrayItem{ key: 'credentials_url', val: 'https://akismet.com/get/' }, rt.ArrayItem{ key: 'setting_name', val: 'wordpress_api_key' }, rt.ArrayItem{ key: 'constant_name', val: 'WPCOM_API_KEY' }]) }])])
	rt.call_function('do_action', [rt.new_string('wp_connectors_init'), var_registry.dup()])
}

fn _wp_connectors_register_default_ai_providers(var_registry rt.PhpVal) {
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'anthropic', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'Anthropic' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Text generation with Claude.')]) }, rt.ArrayItem{ key: 'type', val: 'ai_provider' }, rt.ArrayItem{ key: 'plugin', val: rt.create_array([rt.ArrayItem{ key: 'file', val: 'ai-provider-for-anthropic/plugin.php' }]) }, rt.ArrayItem{ key: 'authentication', val: rt.create_array([rt.ArrayItem{ key: 'method', val: 'api_key' }, rt.ArrayItem{ key: 'credentials_url', val: 'https://platform.claude.com/settings/keys' }]) }]) }, rt.ArrayItem{ key: 'google', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'Google' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Text and image generation with Gemini and Imagen.')]) }, rt.ArrayItem{ key: 'type', val: 'ai_provider' }, rt.ArrayItem{ key: 'plugin', val: rt.create_array([rt.ArrayItem{ key: 'file', val: 'ai-provider-for-google/plugin.php' }]) }, rt.ArrayItem{ key: 'authentication', val: rt.create_array([rt.ArrayItem{ key: 'method', val: 'api_key' }, rt.ArrayItem{ key: 'credentials_url', val: 'https://aistudio.google.com/api-keys' }]) }]) }, rt.ArrayItem{ key: 'openai', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'OpenAI' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Text and image generation with GPT and Dall-E.')]) }, rt.ArrayItem{ key: 'type', val: 'ai_provider' }, rt.ArrayItem{ key: 'plugin', val: rt.create_array([rt.ArrayItem{ key: 'file', val: 'ai-provider-for-openai/plugin.php' }]) }, rt.ArrayItem{ key: 'authentication', val: rt.create_array([rt.ArrayItem{ key: 'method', val: 'api_key' }, rt.ArrayItem{ key: 'credentials_url', val: 'https://platform.openai.com/api-keys' }]) }]) }])
	mut var_ai_registry := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_AiClient{}; return temp.defaultregistry() }()
	{
		mut iter_1 := rt.call_function('array_filter', [rt.call_method(var_ai_registry, 'getRegisteredProviderIds', []rt.PhpVal{})]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_connector_id := item_1.val
			mut var_provider_class_name := rt.call_method(var_ai_registry, 'getProviderClassName', [var_connector_id.dup()])
			mut var_provider_metadata := fn () rt.PhpVal { mut temp := Class_{"nodeType":"Expr_Variable","line":330,"name":"provider_class_name"}{}; return temp.metadata() }()
			mut var_auth_method := rt.call_method(var_provider_metadata, 'getAuthenticationMethod', []rt.PhpVal{})
			mut var_is_api_key := rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_method(var_auth_method, 'isApiKey', []rt.PhpVal{}))
			if var_is_api_key {
				mut var_credentials_url := rt.call_method(var_provider_metadata, 'getCredentialsUrl', []rt.PhpVal{})
				mut var_authentication := { 'method': rt.new_string('api_key') }
				if rt.is_true(var_credentials_url) {
					var_authentication['credentials_url'] = var_credentials_url.dup()
				}
			} else {
				var_authentication = { 'method': rt.new_string('none') }
			}
			mut var_name := rt.call_method(var_provider_metadata, 'getName', []rt.PhpVal{})
			mut var_description := rt.call_method(var_provider_metadata, 'getDescription', []rt.PhpVal{})
			mut var_logo_url := if rt.is_true(rt.call_method(var_provider_metadata, 'getLogoPath', []rt.PhpVal{})) { rt.new_string(_wp_connectors_resolve_ai_provider_logo_url(rt.call_method(var_provider_metadata, 'getLogoPath', []rt.PhpVal{}))) } else { rt.new_null() }
			if var_defaults.array_isset(var_connector_id) {
				if rt.is_true(var_name) {
					var_defaults.array_get_mut(var_connector_id).array_set('name', var_name.dup())
				}
				if rt.is_true(var_description) {
					var_defaults.array_get_mut(var_connector_id).array_set('description', var_description.dup())
				}
				if rt.is_true(var_logo_url) {
					var_defaults.array_get_mut(var_connector_id).array_set('logo_url', var_logo_url.dup())
				}
				var_defaults.array_get_mut(var_connector_id).array_get_mut('authentication').array_set('method', var_authentication.array_get('method'))
				if !(!rt.is_true(var_authentication.array_get('credentials_url'))) {
					var_defaults.array_get_mut(var_connector_id).array_get_mut('authentication').array_set('credentials_url', var_authentication.array_get('credentials_url'))
				}
			} else {
				var_defaults.array_set(var_connector_id, rt.create_array([rt.ArrayItem{ key: 'name', val: if rt.is_true(var_name) { var_name } else { rt.call_function('ucwords', [var_connector_id.dup()]) } }, rt.ArrayItem{ key: 'description', val: if rt.is_true(var_description) { var_description } else { rt.new_string('') } }, rt.ArrayItem{ key: 'type', val: 'ai_provider' }, rt.ArrayItem{ key: 'authentication', val: var_authentication }]))
				if rt.is_true(var_logo_url) {
					var_defaults.array_get_mut(var_connector_id).array_set('logo_url', var_logo_url.dup())
				}
			}
		}
	}
	{
		mut iter_1 := var_defaults.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_args := item_1.val
			mut var_id := item_1.key
			if rt.is_true(rt.identical(rt.new_string('api_key'), var_args.array_get('authentication').array_get('method'))) {
				mut var_sanitized_id := rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), var_id.dup()])
				var_args.array_get_mut('authentication').array_set('setting_name', "connectors_ai_${var_sanitized_id.to_string()}_api_key")
				mut var_constant_case_key := rt.new_string(// unsupported expression: Expr_Cast_String.to_string().to_upper() + '_API_KEY')
				var_args.array_get_mut('authentication').array_set('constant_name', var_constant_case_key.dup())
				var_args.array_get_mut('authentication').array_set('env_var_name', var_constant_case_key.dup())
			}
			closure_2_fn := fn [var_ai_registry, var_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return rt.call_method(var_ai_registry, 'hasProvider', [var_id.dup()])
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return rt.new_bool(false)
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
	}
			var_args.array_get_mut('plugin').array_set('is_active', rt.new_closure(closure_2_fn))
			rt.call_method(var_registry, 'register', [var_id.dup(), var_args.dup()])
		}
	}
}

fn _wp_connectors_mask_api_key(key string) string {
	if key.len <= 4 {
		return key
	}
	return (rt.call_function('str_repeat', [rt.new_string('•'), rt.call_function('min', [key.len - 4, rt.new_int(16)])])).str() + (rt.call_function('substr', [rt.new_string(key), // unsupported expression: Expr_UnaryMinus])).str()
}

fn _wp_connectors_get_api_key_source(setting_name string, env_var_name string, constant_name string) string {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_env_value := rt.call_function('getenv', [rt.new_string(env_var_name)])
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return 'env'
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('defined', [rt.new_string(constant_name)])))) {
		mut var_const_value := rt.call_function('constant', [rt.new_string(constant_name)])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_const_value.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return 'constant'
		}
	}
	mut var_db_value := rt.call_function('get_option', [rt.new_string(setting_name), rt.new_string('')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return 'database'
	}
	return 'none'
}

fn _wp_connectors_is_ai_api_key_valid(key string, provider_id string) bool {
	mut var_registry := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_AiClient{}; return temp.defaultregistry() }()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_registry, 'hasProvider', [rt.new_string(provider_id)]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The provider "%s" is not registered in the AI client registry.')]), rt.new_string(provider_id)]), rt.new_string('7.0.0')])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		return (rt.new_null()).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(var_registry, 'setProviderRequestAuthentication', [rt.new_string(provider_id), create_wordpress_aiclient_providers_http_dto_apikeyrequestauthentication(rt.new_string(key).dup())])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	return (rt.call_method(var_registry, 'isProviderConfigured', [rt.new_string(provider_id)])).to_bool()
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
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
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_response.dup()
	}
	mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().is_array()))))) {
		return var_response.dup()
	}
	mut var_is_update := rt.is_true(rt.identical(rt.new_string('POST'), rt.call_method(var_request, 'get_method', []rt.PhpVal{}))) || rt.is_true(rt.identical(rt.new_string('PUT'), rt.call_method(var_request, 'get_method', []rt.PhpVal{})))
	{
		mut iter_1 := wp_get_connectors().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_connector_data := item_1.val
			mut var_connector_id := item_1.key
			mut var_auth := var_connector_data.array_get('authentication')
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || !rt.is_true(var_auth.array_get('setting_name')))) {
				continue
			}
			mut var_setting_name := var_auth.array_get('setting_name')
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().array_isset(var_setting_name.dup())))))) {
				continue
			}
			mut var_value := var_data.array_get(var_setting_name)
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) && rt.is_true(rt.identical(, )))) {
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					
				}
			}
			if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
				
			}
		}
	}
	
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

fn create_wp_connector_registry() &Class_WP_Connector_Registry {
	mut obj := &Class_WP_Connector_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_aiclient() &Class_WordPress_AiClient_AiClient {
	mut obj := &Class_WordPress_AiClient_AiClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_{"nodetype":"expr_variable","line":330,"name":"provider_class_name"}() &Class_{"nodeType":"Expr_Variable","line":330,"name":"provider_class_name"} {
	mut obj := &Class_{"nodeType":"Expr_Variable","line":330,"name":"provider_class_name"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_dto_apikeyrequestauthentication() &Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication {
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




pub fn init_wp_includes_connectors_php() {
}

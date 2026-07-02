import rt

struct Class_WP_AI_Client_Prompt_Builder {
	rt.PhpObjectBase
pub mut:
	builder rt.PhpVal = rt.new_null()
	error   rt.PhpVal = rt.new_null()
}

fn init_static_wp_ai_client_prompt_builder() {
	rt.init_static_prop('WP_AI_Client_Prompt_Builder', 'generating_methods', rt.create_array([
		rt.ArrayItem{ key: 'generate_result', val: true },
		rt.ArrayItem{ key: 'generate_text_result', val: true },
		rt.ArrayItem{ key: 'generate_image_result', val: true },
		rt.ArrayItem{ key: 'generate_speech_result', val: true },
		rt.ArrayItem{ key: 'convert_text_to_speech_result', val: true },
		rt.ArrayItem{ key: 'generate_video_result', val: true },
		rt.ArrayItem{ key: 'generate_text', val: true },
		rt.ArrayItem{ key: 'generate_texts', val: true },
		rt.ArrayItem{ key: 'generate_image', val: true },
		rt.ArrayItem{ key: 'generate_images', val: true },
		rt.ArrayItem{ key: 'convert_text_to_speech', val: true },
		rt.ArrayItem{ key: 'convert_text_to_speeches', val: true },
		rt.ArrayItem{ key: 'generate_speech', val: true },
		rt.ArrayItem{ key: 'generate_speeches', val: true },
		rt.ArrayItem{ key: 'generate_video', val: true },
		rt.ArrayItem{ key: 'generate_videos', val: true },
	]))
	rt.init_static_prop('WP_AI_Client_Prompt_Builder', 'support_check_methods', rt.create_array([
		rt.ArrayItem{ key: 'is_supported', val: true },
		rt.ArrayItem{ key: 'is_supported_for_text_generation', val: true },
		rt.ArrayItem{ key: 'is_supported_for_image_generation', val: true },
		rt.ArrayItem{ key: 'is_supported_for_text_to_speech_conversion', val: true },
		rt.ArrayItem{ key: 'is_supported_for_video_generation', val: true },
		rt.ArrayItem{ key: 'is_supported_for_speech_generation', val: true },
		rt.ArrayItem{ key: 'is_supported_for_music_generation', val: true },
		rt.ArrayItem{ key: 'is_supported_for_embedding_generation', val: true },
	]))
}

fn (mut this Class_WP_AI_Client_Prompt_Builder) construct(mut var_registry Class_WordPress_AiClient_Providers_ProviderRegistry, var_prompt rt.PhpVal) {
	mut iife_temp_0 := Class_WordPress_AiClient_AiClient{}
	mut iife_result_0 := iife_temp_0.geteventdispatcher()
	this.builder = create_wordpress_aiclient_builders_promptbuilder(var_registry,
		var_prompt.clone(), iife_result_0)
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
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		mut iife_temp_1 := Class_WordPress_AiClient_AiClient{}
		mut iife_result_1 := iife_temp_1.geteventdispatcher()
		this.builder = create_wordpress_aiclient_builders_promptbuilder(var_registry,
			rt.new_null(), iife_result_1)
		this.error = this.exception_to_wp_error(mut rt.cast_object_ptr[Class_Exception](var_e))
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
	mut var_default_timeout := rt.new_float(30)
	mut var_filtered_default_timeout := rt.call_function('apply_filters', [
		rt.new_string('wp_ai_client_default_request_timeout'),
		var_default_timeout.clone(),
	])
	if var_filtered_default_timeout.clone().is_long()
		|| var_filtered_default_timeout.clone().is_double()
		&& rt.new_float(var_filtered_default_timeout.to_f64()) >= 0 {
		var_default_timeout = rt.new_float(var_filtered_default_timeout.to_f64())
	} else {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The %s filter must return a non-negative number.'),
				]),
				rt.new_string('<code>wp_ai_client_default_request_timeout</code>'),
			]),
			rt.new_string('7.0.0')])
	}
	mut iife_temp_2 := Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions{}
	mut iife_result_2 := iife_temp_2.fromarray(rt.create_array([
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_timeout()
			val: var_default_timeout
		},
	]))
	rt.call_method(this.builder, 'usingRequestOptions', [iife_result_2])
}

fn (mut this Class_WP_AI_Client_Prompt_Builder) using_abilities(var_abilities rt.PhpVal) rt.PhpVal {
	mut var_declarations := []rt.PhpVal{}
	mut iter_1 := var_abilities.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_ability := item_1.val
		if rt.is_true(rt.new_bool(var_ability.clone().is_string())) {
			mut var_ability_name := var_ability.clone()
			var_ability = rt.call_function('wp_get_ability', [
				var_ability.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_ability)))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('The ability %s was not found.'),
						]),
						rt.new_string('<code>' +
							(rt.call_function('esc_html', [var_ability_name.clone()])).str() +
							'</code>'),
					]),
					rt.new_string('7.0.0')])
				continue
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_ability, 'WP_Ability')))))) {
			continue
		}
		mut iife_temp_3 := Class_WP_AI_Client_Ability_Function_Resolver{}
		mut iife_result_3 := iife_temp_3.ability_name_to_function_name(rt.call_method(var_ability,
			'get_name', []rt.PhpVal{}))
		mut var_function_name := iife_result_3
		mut var_input_schema := rt.call_method(var_ability, 'get_input_schema', []rt.PhpVal{})
		var_declarations << create_wordpress_aiclient_tools_dto_functiondeclaration(var_function_name.clone(), rt.call_method(var_ability,
			'get_description', []rt.PhpVal{}), if !(!rt.is_true(var_input_schema)) {
			var_input_schema
		} else {
			rt.new_null()
		})
	}
	if !(!rt.is_true(var_declarations)) {
		return this.using_function_declarations(var_declarations.clone())
	}
	return rt.new_object('WP_AI_Client_Prompt_Builder', []string{}, this)
}

fn (mut this Class_WP_AI_Client_Prompt_Builder) magic_call(name string, mut var_arguments Class_array) bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.error)))) {
		if rt.is_true(Class_WP_AI_Client_Prompt_Builder.is_generating_method(name)) {
			return (this.error).to_bool()
		}
		if rt.is_true(Class_WP_AI_Client_Prompt_Builder.is_support_check_method(name)) {
			return false
		}
		return this
	}
	if rt.is_true(Class_WP_AI_Client_Prompt_Builder.is_support_check_method(name))
		|| rt.is_true(Class_WP_AI_Client_Prompt_Builder.is_generating_method(name)) {
		mut var_is_ai_disabled := rt.new_bool(!(rt.is_true(rt.call_function('wp_supports_ai',
			[]rt.PhpVal{}))))
		mut var_prevent := var_is_ai_disabled.clone()
		if rt.is_true(rt.new_bool(!(rt.is_true(var_prevent)))) {
			var_prevent = rt.new_bool((rt.call_function('apply_filters', [
				rt.new_string('wp_ai_client_prevent_prompt'),
				rt.new_bool(false),
				rt.new_object('WP_AI_Client_Prompt_Builder', []string{}, &this).dup(),
			])).to_bool())
		}
		if rt.is_true(var_prevent) {
			if rt.is_true(Class_WP_AI_Client_Prompt_Builder.is_support_check_method(name)) {
				return false
			}
			mut var_error_message := if rt.is_true(var_is_ai_disabled) { rt.call_function('__', [
					rt.new_string('AI features are not supported in this environment.'),
				]) } else { rt.call_function('__', [
					rt.new_string('Prompt execution was prevented by a filter.'),
				]) }
			this.error = create_wp_error(rt.new_string('prompt_prevented'),
				var_error_message.clone(), rt.create_array([
				rt.ArrayItem{ key: 'status', val: 503 },
			]))
			if rt.is_true(Class_WP_AI_Client_Prompt_Builder.is_generating_method(name)) {
				return (this.error).to_bool()
			}
			return this
		}
	}
	mut var_callable := this.get_builder_callable(name)
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_result := rt.call_callable(var_callable, [var_arguments])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_result,
		'WordPress_AiClient_Builders_PromptBuilder')))
	{
		return this
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	return var_result.to_bool()
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		this.error = this.exception_to_wp_error(mut rt.cast_object_ptr[Class_Exception](var_e))
		if rt.is_true(Class_WP_AI_Client_Prompt_Builder.is_generating_method(name)) {
			return (this.error).to_bool()
		}
		return this
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
	return false
}

fn (mut this Class_WP_AI_Client_Prompt_Builder) exception_to_wp_error(mut var_e Class_Exception) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Exception', []string{}, var_e),
		'WordPress_AiClient_Providers_Http_Exception_NetworkException')))
	{
		mut var_error_code := rt.new_string('prompt_network_error')
		mut var_status_code := rt.new_int(503)
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Exception', []string{}, var_e),
		'WordPress_AiClient_Providers_Http_Exception_ClientException')))
	{
		var_error_code = rt.new_string('prompt_client_error')
		var_status_code = if rt.is_true(var_e.getcode()) { var_e.getcode() } else { rt.new_int(400) }
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Exception', []string{}, var_e),
		'WordPress_AiClient_Providers_Http_Exception_ServerException')))
	{
		var_error_code = rt.new_string('prompt_upstream_server_error')
		var_status_code = if rt.is_true(var_e.getcode()) { var_e.getcode() } else { rt.new_int(500) }
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Exception', []string{}, var_e),
		'WordPress_AiClient_Common_Exception_TokenLimitReachedException')))
	{
		var_error_code = rt.new_string('prompt_token_limit_reached')
		var_status_code = rt.new_int(400)
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Exception', []string{}, var_e),
		'WordPress_AiClient_Common_Exception_InvalidArgumentException')))
	{
		var_error_code = rt.new_string('prompt_invalid_argument')
		var_status_code = rt.new_int(400)
	} else {
		var_error_code = rt.new_string('prompt_builder_error')
		var_status_code = rt.new_int(500)
	}
	return rt.new_object('WP_Error', []string{}, create_wp_error(var_error_code.clone(),
		var_e.getmessage(), rt.create_array([
		rt.ArrayItem{ key: 'status', val: var_status_code },
		rt.ArrayItem{ key: 'exception_class', val: rt.call_function('get_class', [
			var_e,
		]) },
	])))
}

fn Class_WP_AI_Client_Prompt_Builder.is_support_check_method(name string) bool {
	return (rt.new_bool(rt.get_static_prop('WP_AI_Client_Prompt_Builder', 'support_check_methods').array_isset(rt.new_string(name)))).to_bool()
}

fn Class_WP_AI_Client_Prompt_Builder.is_generating_method(name string) bool {
	return (rt.new_bool(rt.get_static_prop('WP_AI_Client_Prompt_Builder', 'generating_methods').array_isset(rt.new_string(name)))).to_bool()
}

fn (mut this Class_WP_AI_Client_Prompt_Builder) get_builder_callable(name string) rt.PhpVal {
	mut var_camel_case_name := rt.new_string(this.snake_to_camel_case(name))
	mut var_method := [this.builder, var_camel_case_name]
	if !(rt.call_function('is_callable', [rt.create_array_from_list(var_method)])) {
		rt.throw_exception(rt.new_object('BadMethodCallException', []string{}, create_badmethodcallexception(rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Method %1$s does not exist on %2$s.')]),
			rt.new_string(name),
			rt.call_function('get_class', [this.builder]),
		]))))
	}
	return var_method.clone()
}

fn (mut this Class_WP_AI_Client_Prompt_Builder) snake_to_camel_case(snake_case string) string {
	mut var_parts := rt.call_function('explode', [rt.new_string('_'),
		rt.new_string(snake_case)])
	mut var_camel_case := var_parts.array_get(rt.new_int(0))
	mut var_parts_count := rt.new_int(var_parts.clone().array_count())
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, var_parts_count))) { break
		 }
		var_camel_case = rt.concat(var_camel_case, rt.call_function('ucfirst', [
			var_parts.array_get(var_i),
		]))
		rt.post_inc(var_i)
	}
	return var_camel_case.str()
}

struct Class_WordPress_AiClient_Builders_PromptBuilder {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_AiClient {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions {
	rt.PhpObjectBase
}

struct Class_WP_AI_Client_Ability_Function_Resolver {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_BadMethodCallException {
	rt.PhpObjectBase
}

fn create_wp_ai_client_prompt_builder(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WP_AI_Client_Prompt_Builder {
	mut obj := &Class_WP_AI_Client_Prompt_Builder{
		PhpObjectBase: rt.PhpObjectBase{}
		builder:       rt.new_null()
		error:         rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wordpress_aiclient_builders_promptbuilder(_args ...rt.PhpVal) &Class_WordPress_AiClient_Builders_PromptBuilder {
	mut obj := &Class_WordPress_AiClient_Builders_PromptBuilder{
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

fn create_wordpress_aiclient_providers_http_dto_requestoptions(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_ai_client_ability_function_resolver(_args ...rt.PhpVal) &Class_WP_AI_Client_Ability_Function_Resolver {
	mut obj := &Class_WP_AI_Client_Ability_Function_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_tools_dto_functiondeclaration(_args ...rt.PhpVal) &Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_badmethodcallexception(_args ...rt.PhpVal) &Class_BadMethodCallException {
	mut obj := &Class_BadMethodCallException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_AI_Client_Prompt_Builder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_ProviderRegistry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'using_abilities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.using_abilities(dispatch_arg_0)
		}
		'__call' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.magic_call(dispatch_arg_0, mut dispatch_arg_1))
		}
		'exception_to_wp_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Exception](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.exception_to_wp_error(mut dispatch_arg_0)
		}
		'is_support_check_method' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WP_AI_Client_Prompt_Builder.is_support_check_method(dispatch_arg_0))
		}
		'is_generating_method' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WP_AI_Client_Prompt_Builder.is_generating_method(dispatch_arg_0))
		}
		'get_builder_callable' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_builder_callable(dispatch_arg_0)
		}
		'snake_to_camel_case' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.snake_to_camel_case(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_AI_Client_Prompt_Builder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'builder' { return this.builder }
		'error' { return this.error }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_AI_Client_Prompt_Builder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'builder' {
			this.builder = val
			return true
		}
		'error' {
			this.error = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Builders_PromptBuilder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_AI_Client_Ability_Function_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_AI_Client_Ability_Function_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_AI_Client_Ability_Function_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_BadMethodCallException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_BadMethodCallException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_BadMethodCallException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}

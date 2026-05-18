module main

import vphp

@[php_arg_name(server_info: 'serverInfo', server_capabilities: 'serverCapabilities')]
@[php_arg_default(server_info: '[]', server_capabilities: '[]')]
@[php_arg_optional(server_info: true, server_capabilities: true)]
@[php_method]
pub fn (mut app VSlimMcpApp) construct(server_info ?vphp.PhpArray, server_capabilities ?vphp.PhpArray) &VSlimMcpApp {
	app.method_handlers = map[string]vphp.PhpCallable{}
	app.tool_handlers = map[string]vphp.PhpCallable{}
	app.tool_descriptions = map[string]string{}
	app.tool_schemas = map[string]vphp.PhpArray{}
	app.resource_handlers = map[string]vphp.PhpCallable{}
	app.resource_names = map[string]string{}
	app.resource_descriptions = map[string]string{}
	app.resource_mime_types = map[string]string{}
	app.prompt_handlers = map[string]vphp.PhpCallable{}
	app.prompt_descriptions = map[string]string{}
	app.prompt_arguments = map[string]vphp.PhpArray{}
	app.server_info = {
		'name':    'vslim-mcp'
		'version': '0.1.0'
	}
	app.server_capabilities = map[string]vphp.PhpArray{}
	if info := server_info {
		app.server_info(info)
	}
	if capabilities := server_capabilities {
		app.capabilities(capabilities)
	}
	return &app
}

@[php_method: 'serverInfo']
pub fn (mut app VSlimMcpApp) server_info(info vphp.PhpArray) &VSlimMcpApp {
	for key in info.assoc_keys() {
		app.server_info[key] = info.value_at(key).to_string()
	}
	return &app
}

@[php_method]
pub fn (mut app VSlimMcpApp) capability(name string, definition vphp.PhpArray) &VSlimMcpApp {
	key := name.trim_space()
	if key == '' {
		return &app
	}
	if key in app.server_capabilities {
		mut existing := app.server_capabilities[key] or { vphp.PhpArray.new() }
		existing.release()
	}
	app.server_capabilities[key] = definition.retain()
	return &app
}

@[php_method]
pub fn (mut app VSlimMcpApp) capabilities(definitions vphp.PhpArray) &VSlimMcpApp {
	for key in definitions.assoc_keys() {
		mut definition := definitions.array_value(key) or { vphp.PhpArray.new() }
		app.capability(key, definition)
		definition.release()
	}
	return &app
}

@[php_method]
pub fn (mut app VSlimMcpApp) register(method string, handler vphp.PhpCallable) &VSlimMcpApp {
	key := method.trim_space()
	if key == '' || !handler.is_valid() || !handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'register handler must be callable', 0)
		return &app
	}
	if key in app.method_handlers {
		mut existing := app.method_handlers[key] or { vphp.PhpCallable.invalid() }
		existing.release()
	}
	app.method_handlers[key] = handler.retain()
	return &app
}

@[php_arg_name(input_schema: 'inputSchema')]
@[php_method]
pub fn (mut app VSlimMcpApp) tool(name string, description string, input_schema vphp.PhpArray, handler vphp.PhpCallable) &VSlimMcpApp {
	key := name.trim_space()
	if key == '' || !handler.is_valid() || !handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'tool handler must be callable',
			0)
		return &app
	}
	if key in app.tool_handlers {
		mut existing := app.tool_handlers[key] or { vphp.PhpCallable.invalid() }
		existing.release()
	}
	if key in app.tool_schemas {
		mut existing := app.tool_schemas[key] or { vphp.PhpArray.new() }
		existing.release()
	}
	app.tool_handlers[key] = handler.retain()
	app.tool_schemas[key] = input_schema.retain()
	app.tool_descriptions[key] = description
	return &app
}

@[php_arg_name(mime_type: 'mimeType')]
@[php_method]
pub fn (mut app VSlimMcpApp) resource(uri string, name string, description string, mime_type string, handler vphp.PhpCallable) &VSlimMcpApp {
	key := uri.trim_space()
	if key == '' || !handler.is_valid() || !handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'resource handler must be callable', 0)
		return &app
	}
	if key in app.resource_handlers {
		mut existing := app.resource_handlers[key] or { vphp.PhpCallable.invalid() }
		existing.release()
	}
	app.resource_handlers[key] = handler.retain()
	app.resource_names[key] = name
	app.resource_descriptions[key] = description
	app.resource_mime_types[key] = mime_type
	return &app
}

@[php_method]
pub fn (mut app VSlimMcpApp) prompt(name string, description string, arguments vphp.PhpArray, handler vphp.PhpCallable) &VSlimMcpApp {
	key := name.trim_space()
	if key == '' || !handler.is_valid() || !handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'prompt handler must be callable', 0)
		return &app
	}
	if key in app.prompt_handlers {
		mut existing := app.prompt_handlers[key] or { vphp.PhpCallable.invalid() }
		existing.release()
	}
	if key in app.prompt_arguments {
		mut existing := app.prompt_arguments[key] or { vphp.PhpArray.new() }
		existing.release()
	}
	app.prompt_handlers[key] = handler.retain()
	app.prompt_arguments[key] = arguments.retain()
	app.prompt_descriptions[key] = description
	return &app
}

@[php_method]
pub fn VSlimMcpApp.notification(method string, params vphp.PhpArray) string {
	payload := new_rpc_notification(method, params)
	return payload.to_json_with_flags(256)
}

@[php_method]
pub fn VSlimMcpApp.request(id vphp.PhpValue, method string, params vphp.PhpArray) string {
	payload := new_rpc_request(id, method, params)
	return payload.to_json_with_flags(256)
}

@[php_arg_name(model_preferences: 'modelPreferences', system_prompt: 'systemPrompt', max_tokens: 'maxTokens', tool_choice: 'toolChoice')]
@[php_method: 'samplingRequest']
pub fn VSlimMcpApp.sampling_request(id vphp.PhpValue, messages vphp.PhpArray, model_preferences vphp.PhpValue, system_prompt string, max_tokens int, temperature vphp.PhpValue, tools vphp.PhpValue, tool_choice vphp.PhpValue) string {
	payload := new_sampling_request(id, messages, model_preferences, system_prompt, max_tokens,
		temperature, tools, tool_choice)
	return payload.to_json_with_flags(256)
}

@[php_arg_name(protocol_version: 'protocolVersion', session_id: 'sessionId')]
@[php_method: 'queuedResult']
pub fn VSlimMcpApp.queued_result(id vphp.PhpValue, result vphp.PhpValue, notifications vphp.PhpArray, status int, protocol_version string, session_id string, headers vphp.PhpArray) vphp.PhpArray {
	return new_queued_result(id, result, notifications, status, protocol_version, session_id,
		headers_or_default(headers))
}

@[php_arg_name(protocol_version: 'protocolVersion', session_id: 'sessionId')]
@[php_method: 'queueMessages']
pub fn VSlimMcpApp.queue_messages(id vphp.PhpValue, result vphp.PhpValue, messages vphp.PhpArray, status int, protocol_version string, session_id string, headers vphp.PhpArray) vphp.PhpArray {
	return new_queued_result(id, result, messages, status, protocol_version, session_id,
		headers_or_default(headers))
}

@[php_arg_name(session_id: 'sessionId', protocol_version: 'protocolVersion')]
@[php_arg_default(result: 'null', status: '200', headers: '[]')]
@[php_arg_optional(result: true, status: true, headers: true)]
@[php_method]
pub fn VSlimMcpApp.notify(id vphp.PhpValue, method string, params vphp.PhpArray, session_id string, protocol_version string, result ?vphp.PhpValue, status int, headers ?vphp.PhpArray) vphp.PhpArray {
	mut notifications := vphp.PhpArray.new()
	notifications.push_string(VSlimMcpApp.notification(method, params))
	header_values := if custom_headers := headers {
		headers_or_default(custom_headers)
	} else {
		default_mcp_headers()
	}
	if custom_result := result {
		return new_queued_result(id, custom_result, notifications, status, protocol_version,
			session_id, header_values)
	}
	return new_queued_result(id, default_mcp_queued_result(), notifications, status,
		protocol_version, session_id, header_values)
}

@[php_arg_name(session_id: 'sessionId', protocol_version: 'protocolVersion')]
@[php_method: 'queueNotification']
pub fn VSlimMcpApp.queue_notification(id vphp.PhpValue, method string, params vphp.PhpArray, session_id string, protocol_version string) vphp.PhpArray {
	return VSlimMcpApp.notify(id, method, params, session_id, protocol_version, none, 200, none)
}

@[php_arg_name(response_id: 'responseId', request_id: 'requestId', session_id: 'sessionId', protocol_version: 'protocolVersion')]
@[php_method: 'queueRequest']
pub fn VSlimMcpApp.queue_request(response_id vphp.PhpValue, request_id vphp.PhpValue, method string, params vphp.PhpArray, session_id string, protocol_version string) vphp.PhpArray {
	mut messages := vphp.PhpArray.new()
	messages.push_string(VSlimMcpApp.request(request_id, method, params))
	return new_queued_result(response_id, default_mcp_queued_result(), messages, 200,
		protocol_version, session_id, default_mcp_headers())
}

@[php_arg_name(progress_token: 'progressToken', session_id: 'sessionId', protocol_version: 'protocolVersion')]
@[php_method: 'queueProgress']
pub fn VSlimMcpApp.queue_progress(id vphp.PhpValue, progress_token vphp.PhpValue, progress vphp.PhpValue, total vphp.PhpValue, message string, session_id string, protocol_version string) vphp.PhpArray {
	mut params := vphp.PhpArray.new()
	params.set('progressToken', progress_token)
	params.set('progress', progress)
	if !total.is_null() && !total.is_undef() {
		params.set('total', total)
	}
	if message.trim_space() != '' {
		params.string('message', message)
	}
	return VSlimMcpApp.notify(id, 'notifications/progress', params, session_id, protocol_version,
		none, 200, none)
}

@[php_arg_name(session_id: 'sessionId', protocol_version: 'protocolVersion')]
@[php_method: 'queueLog']
pub fn VSlimMcpApp.queue_log(id vphp.PhpValue, level string, message string, data vphp.PhpValue, logger string, session_id string, protocol_version string) vphp.PhpArray {
	mut params := vphp.PhpArray.new()
	params.string('level', level)
	if data.is_array() && data.count() > 0 {
		params.set('data', data)
		if message.trim_space() != '' {
			params.string('message', message)
		}
	} else {
		mut payload := vphp.PhpArray.new()
		payload.string('message', message)
		params.set('data', payload)
		payload.release()
	}
	if logger.trim_space() != '' {
		params.string('logger', logger)
	}
	return VSlimMcpApp.notify(id, 'notifications/message', params, session_id, protocol_version,
		none, 200, none)
}

@[php_arg_name(response_id: 'responseId', sampling_id: 'samplingId', session_id: 'sessionId', protocol_version: 'protocolVersion', model_preferences: 'modelPreferences', system_prompt: 'systemPrompt', max_tokens: 'maxTokens')]
@[php_method: 'queueSampling']
pub fn VSlimMcpApp.queue_sampling(response_id vphp.PhpValue, sampling_id vphp.PhpValue, messages vphp.PhpArray, session_id string, protocol_version string, model_preferences vphp.PhpValue, system_prompt string, max_tokens int) vphp.PhpArray {
	mut queue := vphp.PhpArray.new()
	queue.push_string(VSlimMcpApp.sampling_request(sampling_id, messages, model_preferences,
		system_prompt, max_tokens, vphp.PhpValue.null(), vphp.PhpValue.null(), vphp.PhpValue.null()))
	return new_queued_result(response_id, default_mcp_queued_result(), queue, 200,
		protocol_version, session_id, default_mcp_headers())
}

@[php_method: 'clientCapabilities']
pub fn VSlimMcpApp.client_capabilities(frame vphp.PhpArray) vphp.PhpArray {
	caps_raw := frame.raw_string_at('client_capabilities_json', '')
	if caps_raw.trim_space() == '' {
		return vphp.PhpArray.new()
	}
	caps := vphp.PhpJson.decode_assoc_value(caps_raw)
	defer {
		caps.release()
	}
	if !caps.is_array() {
		return vphp.PhpArray.new()
	}
	return caps.as_array() or { vphp.PhpArray.new() }
}

@[php_method: 'clientSupports']
pub fn VSlimMcpApp.client_supports(frame vphp.PhpArray, name string) bool {
	key := name.trim_space()
	if key == '' {
		return false
	}
	mut caps := VSlimMcpApp.client_capabilities(frame)
	defer {
		caps.release()
	}
	return !caps.value_at(key).is_null()
}

@[php_method: 'capabilityError']
pub fn VSlimMcpApp.capability_error(frame vphp.PhpArray, message string, status int) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	out.bool('handled', true)
	out.int('status', if status > 0 { status } else { 409 })
	out.set('headers', default_mcp_headers())
	mut error_body := new_string_map({
		'error': message
	})
	out.string('body', error_body.to_json_with_flags(256))
	out.string('protocol_version', frame.string_at('protocol_version', '2025-11-05'))
	out.string('session_id', frame.string_at('session_id', ''))
	mut messages := vphp.PhpArray.new()
	out.set('messages', messages)
	messages.release()
	return out
}

@[php_method: 'requireCapability']
pub fn VSlimMcpApp.require_capability(frame vphp.PhpArray, name string, message string, status int) vphp.PhpValue {
	caps_raw := frame.raw_string_at('client_capabilities_json', '')
	if caps_raw.trim_space() == '' {
		return vphp.PhpValue.null()
	}
	if VSlimMcpApp.client_supports(frame, name) {
		return vphp.PhpValue.null()
	}
	return VSlimMcpApp.capability_error(frame, message, status).take_value()
}

@[php_method: 'handleMcpDispatch']
pub fn (app &VSlimMcpApp) handle_mcp_dispatch(frame vphp.PhpArray) vphp.PhpArray {
	protocol_version := frame.string_at('protocol_version', '')
	raw := frame.raw_string_at('jsonrpc_raw', '')
	if raw.trim_space() == '' {
		return new_mcp_error_response(vphp.PhpNull.value(), -32700, 'Missing JSON-RPC body', 400,
			protocol_version)
	}
	message := vphp.PhpJson.decode_assoc_value(raw)
	if !message.is_array() {
		return new_mcp_error_response(vphp.PhpNull.value(), -32700, 'Invalid JSON', 400,
			protocol_version)
	}
	id_value := message.value_at('id')
	if message.string_at('jsonrpc', '') != '2.0' {
		return new_mcp_error_response(id_value, -32600, 'Invalid JSON-RPC version', 400,
			protocol_version)
	}
	method := message.string_at('method', '')
	if method == '' {
		return new_mcp_error_response(id_value, -32600, 'Missing method', 400, protocol_version)
	}
	if method == 'initialize' {
		params := message.value_at('params')
		client_version := params.string_at('protocolVersion', protocol_version)
		mut result := vphp.PhpArray.new()
		result.string('protocolVersion', if client_version == '' {
			'2025-11-05'
		} else {
			client_version
		})
		result.set('capabilities', app.effective_capabilities())
		result.set('serverInfo', app.server_info_array())
		return new_mcp_result_response(id_value, result, 200, if client_version == '' {
			protocol_version
		} else {
			client_version
		})
	}
	if method == 'ping' {
		mut result := vphp.PhpArray.new()
		return new_mcp_result_response(id_value, result, 200, protocol_version)
	}
	if method == 'tools/list' && method !in app.method_handlers {
		mut result := vphp.PhpArray.new()
		result.set('tools', app.tool_definitions())
		return new_mcp_result_response(id_value, result, 200, protocol_version)
	}
	if method == 'tools/call' && method !in app.method_handlers {
		return app.handle_builtin_tool_call(message, frame, protocol_version)
	}
	if method == 'resources/list' && method !in app.method_handlers {
		mut result := vphp.PhpArray.new()
		result.set('resources', app.resource_definitions())
		return new_mcp_result_response(id_value, result, 200, protocol_version)
	}
	if method == 'resources/read' && method !in app.method_handlers {
		return app.handle_builtin_resource_read(message, frame, protocol_version)
	}
	if method == 'prompts/list' && method !in app.method_handlers {
		mut result := vphp.PhpArray.new()
		result.set('prompts', app.prompt_definitions())
		return new_mcp_result_response(id_value, result, 200, protocol_version)
	}
	if method == 'prompts/get' && method !in app.method_handlers {
		return app.handle_builtin_prompt_get(message, frame, protocol_version)
	}
	if method !in app.method_handlers {
		return new_mcp_error_response(id_value, -32601, 'Method not found', 200, protocol_version)
	}
	handler := app.method_handlers[method] or {
		return new_mcp_error_response(id_value, -32601, 'Method not found', 200, protocol_version)
	}
	mut handler_args := []vphp.PhpArgInput{}
	handler_args << message
	handler_args << frame
	result := invoke_mcp_handler(handler, handler_args)
	if result.is_array() && !result.value_at('body').is_null() {
		return normalize_mcp_passthrough(result, protocol_version)
	}
	return new_mcp_result_response(id_value, result, 200, protocol_version)
}

@[php_method]
pub fn (app &VSlimMcpApp) handle(frame vphp.PhpArray) vphp.PhpArray {
	return app.handle_mcp_dispatch(frame)
}

@[php_method: 'handleMcp']
pub fn (app &VSlimMcpApp) handle_mcp(frame vphp.PhpArray) vphp.PhpArray {
	return app.handle_mcp_dispatch(frame)
}

pub fn (app &VSlimMcpApp) effective_capabilities() vphp.PhpArray {
	mut caps := vphp.PhpArray.new()
	mut keys := app.server_capabilities.keys()
	keys.sort()
	for key in keys {
		handler := app.server_capabilities[key] or { continue }
		caps.set(key, handler)
	}
	if app.tool_handlers.len > 0 && caps.value_at('tools').is_null() {
		mut def := vphp.PhpArray.new()
		def.bool('listChanged', false)
		caps.set('tools', def)
		def.release()
	}
	if app.resource_handlers.len > 0 && caps.value_at('resources').is_null() {
		mut def := vphp.PhpArray.new()
		def.bool('listChanged', false)
		caps.set('resources', def)
		def.release()
	}
	if app.prompt_handlers.len > 0 && caps.value_at('prompts').is_null() {
		mut def := vphp.PhpArray.new()
		def.bool('listChanged', false)
		caps.set('prompts', def)
		def.release()
	}
	return caps
}

pub fn (app &VSlimMcpApp) server_info_array() vphp.PhpArray {
	return new_string_map(app.server_info)
}

pub fn (app &VSlimMcpApp) tool_definitions() vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	mut keys := app.tool_handlers.keys()
	keys.sort()
	for key in keys {
		mut row := vphp.PhpArray.new()
		row.string('name', key)
		row.string('description', app.tool_descriptions[key] or { '' })
		if schema := app.tool_schemas[key] {
			row.set('inputSchema', schema)
		} else {
			mut schema := vphp.PhpArray.new()
			row.set('inputSchema', schema)
			schema.release()
		}
		out.push(row)
		row.release()
	}
	return out
}

pub fn (app &VSlimMcpApp) resource_definitions() vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	mut keys := app.resource_handlers.keys()
	keys.sort()
	for key in keys {
		mut row := vphp.PhpArray.new()
		row.string('uri', key)
		row.string('name', app.resource_names[key] or { '' })
		row.string('description', app.resource_descriptions[key] or { '' })
		row.string('mimeType', app.resource_mime_types[key] or { '' })
		out.push(row)
		row.release()
	}
	return out
}

pub fn (app &VSlimMcpApp) prompt_definitions() vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	mut keys := app.prompt_handlers.keys()
	keys.sort()
	for key in keys {
		mut row := vphp.PhpArray.new()
		row.string('name', key)
		row.string('description', app.prompt_descriptions[key] or { '' })
		if args := app.prompt_arguments[key] {
			row.set('arguments', args)
		} else {
			mut args := vphp.PhpArray.new()
			row.set('arguments', args)
			args.release()
		}
		out.push(row)
		row.release()
	}
	return out
}

pub fn (app &VSlimMcpApp) handle_builtin_tool_call(message vphp.PhpValue, frame vphp.PhpArray, protocol_version string) vphp.PhpArray {
	params := message.value_at('params')
	name := params.string_at('name', '')
	id := message.value_at('id')
	if name == '' || name !in app.tool_handlers {
		mut result := vphp.PhpArray.new()
		mut content := vphp.PhpArray.new()
		mut item := vphp.PhpArray.new()
		item.string('type', 'text')
		item.string('text', 'unknown tool')
		content.push(item)
		item.release()
		result.set('content', content)
		content.release()
		result.bool('isError', true)
		return new_mcp_result_response(id, result, 200, protocol_version)
	}
	arguments := params.value_at('arguments')
	handler := app.tool_handlers[name] or {
		mut fallback := vphp.PhpArray.new()
		mut content := vphp.PhpArray.new()
		mut item := vphp.PhpArray.new()
		item.string('type', 'text')
		item.string('text', 'unknown tool')
		content.push(item)
		item.release()
		fallback.set('content', content)
		content.release()
		fallback.bool('isError', true)
		return new_mcp_result_response(id, fallback, 200, protocol_version)
	}
	mut handler_args := []vphp.PhpArgInput{}
	handler_args << arguments
	handler_args << message
	handler_args << frame
	result := invoke_mcp_handler(handler, handler_args)
	return new_mcp_result_response(id, result, 200, protocol_version)
}

pub fn (app &VSlimMcpApp) handle_builtin_resource_read(message vphp.PhpValue, frame vphp.PhpArray, protocol_version string) vphp.PhpArray {
	params := message.value_at('params')
	uri := params.string_at('uri', '')
	id := message.value_at('id')
	if uri == '' || uri !in app.resource_handlers {
		return new_mcp_error_response(id, -32002, 'Resource not found', 200, protocol_version)
	}
	handler := app.resource_handlers[uri] or {
		return new_mcp_error_response(id, -32002, 'Resource not found', 200, protocol_version)
	}
	mut handler_args := []vphp.PhpArgInput{}
	handler_args << params
	handler_args << message
	handler_args << frame
	result := invoke_mcp_handler(handler, handler_args)
	if result.is_string() {
		mut body := vphp.PhpArray.new()
		mut contents := vphp.PhpArray.new()
		mut item := vphp.PhpArray.new()
		item.string('uri', uri)
		item.string('mimeType', app.resource_mime_types[uri] or { 'text/plain' })
		item.string('text', result.to_string())
		contents.push(item)
		item.release()
		body.set('contents', contents)
		contents.release()
		return new_mcp_result_response(id, body, 200, protocol_version)
	}
	return new_mcp_result_response(id, result, 200, protocol_version)
}

pub fn (app &VSlimMcpApp) handle_builtin_prompt_get(message vphp.PhpValue, frame vphp.PhpArray, protocol_version string) vphp.PhpArray {
	params := message.value_at('params')
	name := params.string_at('name', '')
	id := message.value_at('id')
	if name == '' || name !in app.prompt_handlers {
		return new_mcp_error_response(id, -32003, 'Prompt not found', 200, protocol_version)
	}
	arguments := params.value_at('arguments')
	handler := app.prompt_handlers[name] or {
		return new_mcp_error_response(id, -32003, 'Prompt not found', 200, protocol_version)
	}
	mut handler_args := []vphp.PhpArgInput{}
	handler_args << arguments
	handler_args << message
	handler_args << frame
	result := invoke_mcp_handler(handler, handler_args)
	return new_mcp_result_response(id, result, 200, protocol_version)
}

fn new_rpc_notification(method string, params vphp.PhpArray) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	out.string('jsonrpc', '2.0')
	out.string('method', method)
	out.set('params', params)
	return out
}

fn new_rpc_request(id vphp.PhpValue, method string, params vphp.PhpArray) vphp.PhpArray {
	mut out := new_rpc_notification(method, params)
	out.set('id', id)
	return out
}

fn new_sampling_request(id vphp.PhpValue, messages vphp.PhpArray, model_preferences vphp.PhpValue, system_prompt string, max_tokens int, temperature vphp.PhpValue, tools vphp.PhpValue, tool_choice vphp.PhpValue) vphp.PhpArray {
	mut params := vphp.PhpArray.new()
	params.set('messages', messages)
	if model_preferences.is_array() && model_preferences.count() > 0 {
		params.set('modelPreferences', model_preferences)
	}
	if system_prompt.trim_space() != '' {
		params.string('systemPrompt', system_prompt)
	}
	if max_tokens > 0 {
		params.int('maxTokens', max_tokens)
	}
	if !temperature.is_null() && !temperature.is_undef() {
		params.set('temperature', temperature)
	}
	if tools.is_array() && tools.count() > 0 {
		params.set('tools', tools)
	}
	if !tool_choice.is_null() && !tool_choice.is_undef() {
		params.set('toolChoice', tool_choice)
	}
	return new_rpc_request(id, 'sampling/createMessage', params)
}

fn new_queued_result(id vphp.PhpArgInput, result vphp.PhpArgInput, notifications vphp.PhpArray, status int, protocol_version string, session_id string, headers vphp.PhpArray) vphp.PhpArray {
	mut out := new_mcp_result_response(id, result, status, protocol_version)
	out.set('messages', notifications)
	out.string('session_id', session_id)
	out.set('headers', headers)
	return out
}

fn new_mcp_result_response(id vphp.PhpArgInput, result vphp.PhpArgInput, status int, protocol_version string) vphp.PhpArray {
	mut payload := vphp.PhpArray.new()
	payload.string('jsonrpc', '2.0')
	payload.set('id', id)
	payload.set('result', result)
	mut out := vphp.PhpArray.new()
	out.bool('handled', true)
	out.int('status', status)
	out.set('headers', default_mcp_headers())
	out.string('body', payload.to_json_with_flags(256))
	out.string('protocol_version', protocol_version)
	out.string('session_id', '')
	mut messages := vphp.PhpArray.new()
	out.set('messages', messages)
	messages.release()
	out.set('commands', php_array_or_empty(result.value_at('commands')))
	return out
}

fn new_mcp_error_response(id vphp.PhpArgInput, code int, message string, status int, protocol_version string) vphp.PhpArray {
	mut err := vphp.PhpArray.new()
	err.int('code', code)
	err.string('message', message)
	mut payload := vphp.PhpArray.new()
	payload.string('jsonrpc', '2.0')
	payload.set('id', id)
	payload.set('error', err)
	err.release()
	mut out := vphp.PhpArray.new()
	out.bool('handled', true)
	out.int('status', status)
	out.set('headers', default_mcp_headers())
	out.string('body', payload.to_json_with_flags(256))
	out.string('protocol_version', protocol_version)
	out.string('session_id', '')
	mut messages := vphp.PhpArray.new()
	out.set('messages', messages)
	messages.release()
	return out
}

fn normalize_mcp_passthrough(result vphp.PhpValue, protocol_version string) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	out.bool('handled', true)
	out.int('status', result.int_at('status', 200))
	out.set('headers', headers_value_or_default(result['headers']))
	out.string('body', result.raw_string_at('body', ''))
	out.string('protocol_version', first_non_empty([
		result.string_at('protocol_version', ''),
		protocol_version,
	]))
	out.string('session_id', result.string_at('session_id', ''))
	out.set('messages', string_array_or_empty(result.value_at('messages')))
	return out
}

fn default_mcp_headers() vphp.PhpArray {
	mut headers := vphp.PhpArray.new()
	headers.string('content-type', 'application/json; charset=utf-8')
	return headers
}

fn default_mcp_queued_result() vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	out.bool('queued', true)
	return out
}

fn headers_or_default(headers vphp.PhpArray) vphp.PhpArray {
	if headers.count() > 0 {
		return headers.owned()
	}
	return default_mcp_headers()
}

fn headers_value_or_default(headers vphp.PhpValue) vphp.PhpArray {
	if arr := headers.as_array() {
		return headers_or_default(arr)
	}
	return default_mcp_headers()
}

fn string_array_or_empty(input vphp.PhpValue) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	arr := input.as_array() or { return out }
	for idx := 0; idx < arr.count(); idx++ {
		out.push_string(arr.index_value(idx).to_string())
	}
	return out
}

fn php_array_or_empty(input vphp.PhpValue) vphp.PhpArray {
	if arr := input.as_array() {
		return arr.owned()
	}
	return vphp.PhpArray.new()
}

fn invoke_mcp_handler(handler vphp.PhpCallable, args []vphp.PhpArgInput) vphp.PhpValue {
	if !handler.is_valid() || !handler.is_callable() {
		return vphp.PhpValue.null()
	}
	return handler.invoke(...args)
}

pub fn (mut app VSlimMcpApp) cleanup() {
	// Direct bridge-owned handler/schema maps are released by generic_free_raw()
	// after cleanup() returns. We only free native V string maps here.
	unsafe {
		app.tool_descriptions.free()
		app.resource_names.free()
		app.resource_descriptions.free()
		app.resource_mime_types.free()
		app.prompt_descriptions.free()
		app.server_info.free()
	}
}

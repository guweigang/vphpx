module main

import vphp

@[php_method]
pub fn (mut app VSlimMcpApp) construct() &VSlimMcpApp {
	app.method_handlers = map[string]vphp.PersistentOwnedZBox{}
	app.tool_handlers = map[string]vphp.PersistentOwnedZBox{}
	app.tool_descriptions = map[string]string{}
	app.tool_schemas = map[string]vphp.PersistentOwnedZBox{}
	app.resource_handlers = map[string]vphp.PersistentOwnedZBox{}
	app.resource_names = map[string]string{}
	app.resource_descriptions = map[string]string{}
	app.resource_mime_types = map[string]string{}
	app.prompt_handlers = map[string]vphp.PersistentOwnedZBox{}
	app.prompt_descriptions = map[string]string{}
	app.prompt_arguments = map[string]vphp.PersistentOwnedZBox{}
	app.server_info = {
		'name':    'vslim-mcp'
		'version': '0.1.0'
	}
	app.server_capabilities = map[string]vphp.PersistentOwnedZBox{}
	return &app
}

@[php_method: 'serverInfo']
pub fn (mut app VSlimMcpApp) server_info(info vphp.RequestBorrowedZBox) &VSlimMcpApp {
	raw_info := info.to_zval()
	for key in raw_info.assoc_keys() {
		app.server_info[key] = zval_key(raw_info, key).to_string()
	}
	return &app
}

@[php_method]
pub fn (mut app VSlimMcpApp) capability(name string, definition vphp.RequestBorrowedZBox) &VSlimMcpApp {
	key := name.trim_space()
	if key == '' {
		return &app
	}
	if key in app.server_capabilities {
		mut existing := app.server_capabilities[key] or { vphp.PersistentOwnedZBox.new_null() }
		release_mcp_handler(mut existing)
	}
	app.server_capabilities[key] = persistent_array_or_empty(definition.to_zval())
	return &app
}

@[php_method]
pub fn (mut app VSlimMcpApp) capabilities(definitions vphp.RequestBorrowedZBox) &VSlimMcpApp {
	raw_definitions := definitions.to_zval()
	for key in raw_definitions.assoc_keys() {
		app.capability(key, vphp.RequestBorrowedZBox.of(zval_key(raw_definitions, key)))
	}
	return &app
}

@[php_method]
pub fn (mut app VSlimMcpApp) register(method string, handler vphp.RequestBorrowedZBox) &VSlimMcpApp {
	key := method.trim_space()
	raw_handler := handler.to_zval()
	if key == '' || !raw_handler.is_valid() || !raw_handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'register handler must be callable',
			0)
		return &app
	}
	if key in app.method_handlers {
		mut existing := app.method_handlers[key] or { vphp.PersistentOwnedZBox.new_null() }
		release_mcp_handler(mut existing)
	}
	app.method_handlers[key] = vphp.PersistentOwnedZBox.from_callable_zval(raw_handler)
	return &app
}

@[php_arg_name: 'input_schema=inputSchema']
@[php_method]
pub fn (mut app VSlimMcpApp) tool(name string, description string, input_schema vphp.RequestBorrowedZBox, handler vphp.RequestBorrowedZBox) &VSlimMcpApp {
	key := name.trim_space()
	raw_handler := handler.to_zval()
	raw_schema := input_schema.to_zval()
	if key == '' || !raw_handler.is_valid() || !raw_handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'tool handler must be callable',
			0)
		return &app
	}
	if key in app.tool_handlers {
		mut existing := app.tool_handlers[key] or { vphp.PersistentOwnedZBox.new_null() }
		release_mcp_handler(mut existing)
	}
	if key in app.tool_schemas {
		mut existing := app.tool_schemas[key] or { vphp.PersistentOwnedZBox.new_null() }
		release_mcp_handler(mut existing)
	}
	app.tool_handlers[key] = vphp.PersistentOwnedZBox.from_callable_zval(raw_handler)
	app.tool_schemas[key] = persistent_array_or_empty(raw_schema)
	app.tool_descriptions[key] = description
	return &app
}

@[php_arg_name: 'mime_type=mimeType']
@[php_method]
pub fn (mut app VSlimMcpApp) resource(uri string, name string, description string, mime_type string, handler vphp.RequestBorrowedZBox) &VSlimMcpApp {
	key := uri.trim_space()
	raw_handler := handler.to_zval()
	if key == '' || !raw_handler.is_valid() || !raw_handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'resource handler must be callable',
			0)
		return &app
	}
	if key in app.resource_handlers {
		mut existing := app.resource_handlers[key] or { vphp.PersistentOwnedZBox.new_null() }
		release_mcp_handler(mut existing)
	}
	app.resource_handlers[key] = vphp.PersistentOwnedZBox.from_callable_zval(raw_handler)
	app.resource_names[key] = name
	app.resource_descriptions[key] = description
	app.resource_mime_types[key] = mime_type
	return &app
}

@[php_method]
pub fn (mut app VSlimMcpApp) prompt(name string, description string, arguments vphp.RequestBorrowedZBox, handler vphp.RequestBorrowedZBox) &VSlimMcpApp {
	key := name.trim_space()
	raw_handler := handler.to_zval()
	raw_arguments := arguments.to_zval()
	if key == '' || !raw_handler.is_valid() || !raw_handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'prompt handler must be callable',
			0)
		return &app
	}
	if key in app.prompt_handlers {
		mut existing := app.prompt_handlers[key] or { vphp.PersistentOwnedZBox.new_null() }
		release_mcp_handler(mut existing)
	}
	if key in app.prompt_arguments {
		mut existing := app.prompt_arguments[key] or { vphp.PersistentOwnedZBox.new_null() }
		release_mcp_handler(mut existing)
	}
	app.prompt_handlers[key] = vphp.PersistentOwnedZBox.from_callable_zval(raw_handler)
	app.prompt_arguments[key] = persistent_array_or_empty(raw_arguments)
	app.prompt_descriptions[key] = description
	return &app
}

@[php_method]
pub fn VSlimMcpApp.notification(method string, params vphp.RequestBorrowedZBox) string {
	payload := vphp.PhpArray.must_from_zval(new_rpc_notification(method, params.to_zval())) or {
		return ''
	}
	return payload.to_json_with_flags(256)
}

@[php_method]
pub fn VSlimMcpApp.request(id vphp.RequestBorrowedZBox, method string, params vphp.RequestBorrowedZBox) string {
	payload := vphp.PhpArray.must_from_zval(new_rpc_request(id.to_zval(), method, params.to_zval())) or {
		return ''
	}
	return payload.to_json_with_flags(256)
}

@[php_arg_name: 'model_preferences=modelPreferences,system_prompt=systemPrompt,max_tokens=maxTokens,tool_choice=toolChoice']
@[php_method: 'samplingRequest']
pub fn VSlimMcpApp.sampling_request(id vphp.RequestBorrowedZBox, messages vphp.RequestBorrowedZBox, model_preferences vphp.RequestBorrowedZBox, system_prompt string, max_tokens int, temperature vphp.RequestBorrowedZBox, tools vphp.RequestBorrowedZBox, tool_choice vphp.RequestBorrowedZBox) string {
	payload := vphp.PhpArray.must_from_zval(new_sampling_request(id.to_zval(), messages.to_zval(),
		model_preferences.to_zval(), system_prompt, max_tokens, temperature.to_zval(),
		tools.to_zval(), tool_choice.to_zval())) or {
		return ''
	}
	return payload.to_json_with_flags(256)
}

@[php_arg_name: 'protocol_version=protocolVersion,session_id=sessionId']
@[php_method: 'queuedResult']
pub fn VSlimMcpApp.queued_result(id vphp.RequestBorrowedZBox, result vphp.RequestBorrowedZBox, notifications vphp.RequestBorrowedZBox, status int, protocol_version string, session_id string, headers vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(new_queued_result(id.to_zval(), result.to_zval(),
		notifications.to_zval(), status, protocol_version, session_id, headers.to_zval()))
}

@[php_arg_name: 'protocol_version=protocolVersion,session_id=sessionId']
@[php_method: 'queueMessages']
pub fn VSlimMcpApp.queue_messages(id vphp.RequestBorrowedZBox, result vphp.RequestBorrowedZBox, messages vphp.RequestBorrowedZBox, status int, protocol_version string, session_id string, headers vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(new_queued_result(id.to_zval(), result.to_zval(),
		messages.to_zval(), status, protocol_version, session_id, headers.to_zval()))
}

@[php_arg_name: 'session_id=sessionId,protocol_version=protocolVersion']
@[php_method]
pub fn VSlimMcpApp.notify(id vphp.RequestBorrowedZBox, method string, params vphp.RequestBorrowedZBox, session_id string, protocol_version string) vphp.RequestOwnedZBox {
	mut notifications := new_array()
	notifications.push_string(VSlimMcpApp.notification(method, params))
	return vphp.RequestOwnedZBox.adopt_zval(new_queued_result(id.to_zval(), default_mcp_queued_result(),
		notifications.take_zval(), 200, protocol_version, session_id, default_mcp_headers()))
}

@[php_arg_name: 'session_id=sessionId,protocol_version=protocolVersion']
@[php_method: 'queueNotification']
pub fn VSlimMcpApp.queue_notification(id vphp.RequestBorrowedZBox, method string, params vphp.RequestBorrowedZBox, session_id string, protocol_version string) vphp.RequestOwnedZBox {
	return VSlimMcpApp.notify(id, method, params, session_id, protocol_version)
}

@[php_arg_name: 'response_id=responseId,request_id=requestId,session_id=sessionId,protocol_version=protocolVersion']
@[php_method: 'queueRequest']
pub fn VSlimMcpApp.queue_request(response_id vphp.RequestBorrowedZBox, request_id vphp.RequestBorrowedZBox, method string, params vphp.RequestBorrowedZBox, session_id string, protocol_version string) vphp.RequestOwnedZBox {
	mut messages := new_array()
	messages.push_string(VSlimMcpApp.request(request_id, method, params))
	return vphp.RequestOwnedZBox.adopt_zval(new_queued_result(response_id.to_zval(), default_mcp_queued_result(),
		messages.take_zval(), 200, protocol_version, session_id, default_mcp_headers()))
}

@[php_arg_name: 'progress_token=progressToken,session_id=sessionId,protocol_version=protocolVersion']
@[php_method: 'queueProgress']
pub fn VSlimMcpApp.queue_progress(id vphp.RequestBorrowedZBox, progress_token vphp.RequestBorrowedZBox, progress vphp.RequestBorrowedZBox, total vphp.RequestBorrowedZBox, message string, session_id string, protocol_version string) vphp.RequestOwnedZBox {
	raw_progress_token := progress_token.to_zval()
	raw_progress := progress.to_zval()
	raw_total := total.to_zval()
	mut params := new_array()
	params.set('progressToken', vphp.PhpValue.from_zval(raw_progress_token))
	params.set('progress', vphp.PhpValue.from_zval(raw_progress))
	if !raw_total.is_null() && !raw_total.is_undef() {
		params.set('total', vphp.PhpValue.from_zval(raw_total))
	}
	if message.trim_space() != '' {
		params.string('message', message)
	}
	return VSlimMcpApp.notify(id, 'notifications/progress', params.to_borrowed_zbox(),
		session_id, protocol_version)
}

@[php_arg_name: 'session_id=sessionId,protocol_version=protocolVersion']
@[php_method: 'queueLog']
pub fn VSlimMcpApp.queue_log(id vphp.RequestBorrowedZBox, level string, message string, data vphp.RequestBorrowedZBox, logger string, session_id string, protocol_version string) vphp.RequestOwnedZBox {
	raw_data := data.to_zval()
	mut params := new_array()
	params.string('level', level)
	if raw_data.is_array() && raw_data.array_count() > 0 {
		params.set('data', vphp.PhpValue.from_zval(raw_data))
		if message.trim_space() != '' {
			params.string('message', message)
		}
	} else {
		mut payload := new_array()
		payload.string('message', message)
		params.set('data', payload)
		payload.release()
	}
	if logger.trim_space() != '' {
		params.string('logger', logger)
	}
	return VSlimMcpApp.notify(id, 'notifications/message', params.to_borrowed_zbox(),
		session_id, protocol_version)
}

@[php_arg_name: 'response_id=responseId,sampling_id=samplingId,session_id=sessionId,protocol_version=protocolVersion,model_preferences=modelPreferences,system_prompt=systemPrompt,max_tokens=maxTokens']
@[php_method: 'queueSampling']
pub fn VSlimMcpApp.queue_sampling(response_id vphp.RequestBorrowedZBox, sampling_id vphp.RequestBorrowedZBox, messages vphp.RequestBorrowedZBox, session_id string, protocol_version string, model_preferences vphp.RequestBorrowedZBox, system_prompt string, max_tokens int) vphp.RequestOwnedZBox {
	mut queue := new_array()
	queue.push_string(VSlimMcpApp.sampling_request(sampling_id, messages,
		model_preferences, system_prompt, max_tokens, vphp.RequestBorrowedZBox.null(),
		vphp.RequestBorrowedZBox.null(), vphp.RequestBorrowedZBox.null()))
	return vphp.RequestOwnedZBox.adopt_zval(new_queued_result(response_id.to_zval(), default_mcp_queued_result(),
		queue.take_zval(), 200, protocol_version, session_id, default_mcp_headers()))
}

@[php_method: 'clientCapabilities']
pub fn VSlimMcpApp.client_capabilities(frame vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	raw_frame := frame.to_zval()
	caps_raw := zval_raw_string_key(raw_frame, 'client_capabilities_json', '')
	if caps_raw.trim_space() == '' {
		mut out := new_array()
		return vphp.RequestOwnedZBox.adopt_zval(out.take_zval())
	}
	caps := vphp.PhpJson.decode_assoc(caps_raw)
	if !caps.is_array() {
		mut out := new_array()
		return vphp.RequestOwnedZBox.adopt_zval(out.take_zval())
	}
	return vphp.RequestOwnedZBox.of(caps)
}

@[php_method: 'clientSupports']
pub fn VSlimMcpApp.client_supports(frame vphp.RequestBorrowedZBox, name string) bool {
	key := name.trim_space()
	if key == '' {
		return false
	}
	caps := VSlimMcpApp.client_capabilities(frame)
	return !zval_key(caps.to_zval(), key).is_null()
}

@[php_method: 'capabilityError']
pub fn VSlimMcpApp.capability_error(frame vphp.RequestBorrowedZBox, message string, status int) vphp.RequestOwnedZBox {
	raw_frame := frame.to_zval()
	mut out := new_array()
	out.bool('handled', true)
	out.int('status', if status > 0 { status } else { 409 })
	out.set('headers', vphp.PhpValue.from_zval(default_mcp_headers()))
	mut error_body := new_string_map({
		'error': message
	})
	out.string('body', error_body.to_json_with_flags(256))
	out.string('protocol_version', zval_string_key(raw_frame, 'protocol_version',
		'2025-11-05'))
	out.string('session_id', zval_string_key(raw_frame, 'session_id', ''))
	mut messages := new_array()
	out.set('messages', messages)
	messages.release()
	return vphp.RequestOwnedZBox.adopt_zval(out.take_zval())
}

@[php_method: 'requireCapability']
pub fn VSlimMcpApp.require_capability(frame vphp.RequestBorrowedZBox, name string, message string, status int) vphp.RequestOwnedZBox {
	raw_frame := frame.to_zval()
	caps_raw := zval_raw_string_key(raw_frame, 'client_capabilities_json', '')
	if caps_raw.trim_space() == '' {
		return vphp.RequestOwnedZBox.new_null()
	}
	if VSlimMcpApp.client_supports(frame, name) {
		return vphp.RequestOwnedZBox.new_null()
	}
	return VSlimMcpApp.capability_error(frame, message, status)
}

@[php_method: 'handleMcpDispatch']
pub fn (app &VSlimMcpApp) handle_mcp_dispatch(frame vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	raw_frame := frame.to_zval()
	protocol_version := zval_string_key(raw_frame, 'protocol_version', '')
	raw := zval_raw_string_key(raw_frame, 'jsonrpc_raw', '')
	if raw.trim_space() == '' {
		mut null_id := vphp.PhpNull.value()
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(null_id.take_zval(),
			-32700, 'Missing JSON-RPC body', 400, protocol_version))
	}
	message := vphp.PhpJson.decode_assoc(raw)
	if !message.is_array() {
		mut null_id := vphp.PhpNull.value()
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(null_id.take_zval(),
			-32700, 'Invalid JSON', 400, protocol_version))
	}
	id := zval_key(message, 'id')
	if zval_string_key(message, 'jsonrpc', '') != '2.0' {
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(id, -32600, 'Invalid JSON-RPC version',
			400, protocol_version))
	}
	method := zval_string_key(message, 'method', '')
	if method == '' {
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(id, -32600, 'Missing method',
			400, protocol_version))
	}
	if method == 'initialize' {
		params := zval_key(message, 'params')
		client_version := zval_string_key(params, 'protocolVersion', protocol_version)
		mut result := new_array()
		result.string('protocolVersion', if client_version == '' {
			'2025-11-05'
		} else {
			client_version
		})
		result.set('capabilities', vphp.PhpValue.from_zval(app.effective_capabilities()))
		result.set('serverInfo', vphp.PhpValue.from_zval(app.server_info_zval()))
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, result.take_zval(),
			200,
			if client_version == '' {
			protocol_version
		} else {
			client_version
		}))
	}
	if method == 'ping' {
		mut result := new_array()
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, result.take_zval(),
			200, protocol_version))
	}
	if method == 'tools/list' && method !in app.method_handlers {
		mut result := new_array()
		result.set('tools', vphp.PhpValue.from_zval(app.tool_definitions()))
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, result.take_zval(),
			200,
			protocol_version))
	}
	if method == 'tools/call' && method !in app.method_handlers {
		return vphp.RequestOwnedZBox.adopt_zval(app.handle_builtin_tool_call(message,
			raw_frame, protocol_version))
	}
	if method == 'resources/list' && method !in app.method_handlers {
		mut result := new_array()
		result.set('resources', vphp.PhpValue.from_zval(app.resource_definitions()))
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, result.take_zval(),
			200,
			protocol_version))
	}
	if method == 'resources/read' && method !in app.method_handlers {
		return vphp.RequestOwnedZBox.adopt_zval(app.handle_builtin_resource_read(message,
			raw_frame, protocol_version))
	}
	if method == 'prompts/list' && method !in app.method_handlers {
		mut result := new_array()
		result.set('prompts', vphp.PhpValue.from_zval(app.prompt_definitions()))
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, result.take_zval(),
			200,
			protocol_version))
	}
	if method == 'prompts/get' && method !in app.method_handlers {
		return vphp.RequestOwnedZBox.adopt_zval(app.handle_builtin_prompt_get(message,
			raw_frame, protocol_version))
	}
	if method !in app.method_handlers {
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(id, -32601, 'Method not found',
			200, protocol_version))
	}
	handler := app.method_handlers[method] or {
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(id, -32601, 'Method not found',
			200, protocol_version))
	}
	mut handler_args := []vphp.PhpFnArg{}
	handler_args << vphp.PhpValue.from_zval(message)
	handler_args << vphp.PhpValue.from_zval(raw_frame)
	result := invoke_mcp_handler(handler, handler_args)
	if result.is_array() && !zval_key(result, 'body').is_null() {
		return vphp.RequestOwnedZBox.adopt_zval(normalize_mcp_passthrough(result, protocol_version))
	}
	return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, result, 200, protocol_version))
}

pub fn (app &VSlimMcpApp) effective_capabilities() vphp.ZVal {
	mut caps := new_array()
	mut keys := app.server_capabilities.keys()
	keys.sort()
	for key in keys {
		handler := app.server_capabilities[key] or { continue }
		caps.set_request_owned_zbox(key, handler.clone_request_owned())
	}
	if app.tool_handlers.len > 0 && zval_key(caps.to_zval(), 'tools').is_null() {
		mut def := new_array()
		def.bool('listChanged', false)
		caps.set('tools', def)
		def.release()
	}
	if app.resource_handlers.len > 0 && zval_key(caps.to_zval(), 'resources').is_null() {
		mut def := new_array()
		def.bool('listChanged', false)
		caps.set('resources', def)
		def.release()
	}
	if app.prompt_handlers.len > 0 && zval_key(caps.to_zval(), 'prompts').is_null() {
		mut def := new_array()
		def.bool('listChanged', false)
		caps.set('prompts', def)
		def.release()
	}
	return caps.take_zval()
}

pub fn (app &VSlimMcpApp) server_info_zval() vphp.ZVal {
	mut out := new_string_map(app.server_info)
	return out.take_zval()
}

pub fn (app &VSlimMcpApp) tool_definitions() vphp.ZVal {
	mut out := new_array()
	mut keys := app.tool_handlers.keys()
	keys.sort()
	for key in keys {
		mut row := new_array()
		row.string('name', key)
		row.string('description', app.tool_descriptions[key] or { '' })
		schema := app.tool_schemas[key] or {
			vphp.PersistentOwnedZBox.from_dyn(vphp.DynValue.of_map(map[string]vphp.DynValue{}))
		}
		row.set_request_owned_zbox('inputSchema', schema.clone_request_owned())
		out.push(row)
		row.release()
	}
	return out.take_zval()
}

pub fn (app &VSlimMcpApp) resource_definitions() vphp.ZVal {
	mut out := new_array()
	mut keys := app.resource_handlers.keys()
	keys.sort()
	for key in keys {
		mut row := new_array()
		row.string('uri', key)
		row.string('name', app.resource_names[key] or { '' })
		row.string('description', app.resource_descriptions[key] or { '' })
		row.string('mimeType', app.resource_mime_types[key] or { '' })
		out.push(row)
		row.release()
	}
	return out.take_zval()
}

pub fn (app &VSlimMcpApp) prompt_definitions() vphp.ZVal {
	mut out := new_array()
	mut keys := app.prompt_handlers.keys()
	keys.sort()
	for key in keys {
		mut row := new_array()
		row.string('name', key)
		row.string('description', app.prompt_descriptions[key] or { '' })
		args := app.prompt_arguments[key] or {
			vphp.PersistentOwnedZBox.from_dyn(vphp.DynValue.of_list([]vphp.DynValue{}))
		}
		row.set_request_owned_zbox('arguments', args.clone_request_owned())
		out.push(row)
		row.release()
	}
	return out.take_zval()
}

pub fn (app &VSlimMcpApp) handle_builtin_tool_call(message vphp.ZVal, frame vphp.ZVal, protocol_version string) vphp.ZVal {
	params := zval_key(message, 'params')
	name := zval_string_key(params, 'name', '')
	id := zval_key(message, 'id')
	if name == '' || name !in app.tool_handlers {
		mut result := new_array()
		mut content := new_array()
		mut item := new_array()
		item.string('type', 'text')
		item.string('text', 'unknown tool')
		content.push(item)
		item.release()
		result.set('content', content)
		content.release()
		result.bool('isError', true)
		return new_mcp_result_response(id, result.take_zval(), 200, protocol_version)
	}
	arguments := zval_key(params, 'arguments')
	handler := app.tool_handlers[name] or {
		mut fallback := new_array()
		mut content := new_array()
		mut item := new_array()
		item.string('type', 'text')
		item.string('text', 'unknown tool')
		content.push(item)
		item.release()
		fallback.set('content', content)
		content.release()
		fallback.bool('isError', true)
		return new_mcp_result_response(id, fallback.take_zval(), 200, protocol_version)
	}
	mut handler_args := []vphp.PhpFnArg{}
	handler_args << vphp.PhpValue.from_zval(arguments)
	handler_args << vphp.PhpValue.from_zval(message)
	handler_args << vphp.PhpValue.from_zval(frame)
	result := invoke_mcp_handler(handler, handler_args)
	return new_mcp_result_response(id, result, 200, protocol_version)
}

pub fn (app &VSlimMcpApp) handle_builtin_resource_read(message vphp.ZVal, frame vphp.ZVal, protocol_version string) vphp.ZVal {
	params := zval_key(message, 'params')
	uri := zval_string_key(params, 'uri', '')
	id := zval_key(message, 'id')
	if uri == '' || uri !in app.resource_handlers {
		return new_mcp_error_response(id, -32002, 'Resource not found', 200, protocol_version)
	}
	handler := app.resource_handlers[uri] or {
		return new_mcp_error_response(id, -32002, 'Resource not found', 200, protocol_version)
	}
	mut handler_args := []vphp.PhpFnArg{}
	handler_args << vphp.PhpValue.from_zval(params)
	handler_args << vphp.PhpValue.from_zval(message)
	handler_args << vphp.PhpValue.from_zval(frame)
	result := invoke_mcp_handler(handler, handler_args)
	if result.is_string() {
		mut body := new_array()
		mut contents := new_array()
		mut item := new_array()
		item.string('uri', uri)
		item.string('mimeType', app.resource_mime_types[uri] or { 'text/plain' })
		item.string('text', result.to_string())
		contents.push(item)
		item.release()
		body.set('contents', contents)
		contents.release()
		return new_mcp_result_response(id, body.take_zval(), 200, protocol_version)
	}
	return new_mcp_result_response(id, result, 200, protocol_version)
}

pub fn (app &VSlimMcpApp) handle_builtin_prompt_get(message vphp.ZVal, frame vphp.ZVal, protocol_version string) vphp.ZVal {
	params := zval_key(message, 'params')
	name := zval_string_key(params, 'name', '')
	id := zval_key(message, 'id')
	if name == '' || name !in app.prompt_handlers {
		return new_mcp_error_response(id, -32003, 'Prompt not found', 200, protocol_version)
	}
	arguments := zval_key(params, 'arguments')
	handler := app.prompt_handlers[name] or {
		return new_mcp_error_response(id, -32003, 'Prompt not found', 200, protocol_version)
	}
	mut handler_args := []vphp.PhpFnArg{}
	handler_args << vphp.PhpValue.from_zval(arguments)
	handler_args << vphp.PhpValue.from_zval(message)
	handler_args << vphp.PhpValue.from_zval(frame)
	result := invoke_mcp_handler(handler, handler_args)
	return new_mcp_result_response(id, result, 200, protocol_version)
}

fn new_rpc_notification(method string, params vphp.ZVal) vphp.ZVal {
	mut out := new_array()
	out.string('jsonrpc', '2.0')
	out.string('method', method)
	out.set('params', vphp.PhpValue.from_zval(array_or_empty(params)))
	return out.take_zval()
}

fn new_rpc_request(id vphp.ZVal, method string, params vphp.ZVal) vphp.ZVal {
	mut out := vphp.PhpArray.must_from_zval(new_rpc_notification(method, params)) or {
		return new_rpc_notification(method, params)
	}
	out.set('id', vphp.PhpValue.from_zval(id))
	return out.take_zval()
}

fn new_sampling_request(id vphp.ZVal, messages vphp.ZVal, model_preferences vphp.ZVal, system_prompt string, max_tokens int, temperature vphp.ZVal, tools vphp.ZVal, tool_choice vphp.ZVal) vphp.ZVal {
	mut params := new_array()
	params.set('messages', vphp.PhpValue.from_zval(array_or_empty(messages)))
	if model_preferences.is_array() && model_preferences.array_count() > 0 {
		params.set('modelPreferences', vphp.PhpValue.from_zval(model_preferences))
	}
	if system_prompt.trim_space() != '' {
		params.string('systemPrompt', system_prompt)
	}
	if max_tokens > 0 {
		params.int('maxTokens', max_tokens)
	}
	if !temperature.is_null() && !temperature.is_undef() {
		params.set('temperature', vphp.PhpValue.from_zval(temperature))
	}
	if tools.is_array() && tools.array_count() > 0 {
		params.set('tools', vphp.PhpValue.from_zval(tools))
	}
	if !tool_choice.is_null() && !tool_choice.is_undef() {
		params.set('toolChoice', vphp.PhpValue.from_zval(tool_choice))
	}
	return new_rpc_request(id, 'sampling/createMessage', params.take_zval())
}

fn new_queued_result(id vphp.ZVal, result vphp.ZVal, notifications vphp.ZVal, status int, protocol_version string, session_id string, headers vphp.ZVal) vphp.ZVal {
	mut out := vphp.PhpArray.must_from_zval(new_mcp_result_response(id, result, status,
		protocol_version)) or { return new_mcp_result_response(id, result, status, protocol_version) }
	out.set('messages', vphp.PhpValue.from_zval(string_array_or_empty(notifications)))
	out.string('session_id', session_id)
	out.set('headers', vphp.PhpValue.from_zval(headers_or_default(headers)))
	return out.take_zval()
}

fn new_mcp_result_response(id vphp.ZVal, result vphp.ZVal, status int, protocol_version string) vphp.ZVal {
	mut payload := new_array()
	payload.string('jsonrpc', '2.0')
	payload.set('id', vphp.PhpValue.from_zval(id))
	payload.set('result', vphp.PhpValue.from_zval(result))
	mut out := new_array()
	out.bool('handled', true)
	out.int('status', status)
	out.set('headers', vphp.PhpValue.from_zval(default_mcp_headers()))
	out.string('body', payload.to_json_with_flags(256))
	out.string('protocol_version', protocol_version)
	out.string('session_id', '')
	mut messages := new_array()
	out.set('messages', messages)
	messages.release()
	return out.take_zval()
}

fn new_mcp_error_response(id vphp.ZVal, code int, message string, status int, protocol_version string) vphp.ZVal {
	mut err := new_array()
	err.int('code', code)
	err.string('message', message)
	mut payload := new_array()
	payload.string('jsonrpc', '2.0')
	payload.set('id', vphp.PhpValue.from_zval(id))
	payload.set('error', err)
	err.release()
	mut out := new_array()
	out.bool('handled', true)
	out.int('status', status)
	out.set('headers', vphp.PhpValue.from_zval(default_mcp_headers()))
	out.string('body', payload.to_json_with_flags(256))
	out.string('protocol_version', protocol_version)
	out.string('session_id', '')
	mut messages := new_array()
	out.set('messages', messages)
	messages.release()
	return out.take_zval()
}

fn normalize_mcp_passthrough(result vphp.ZVal, protocol_version string) vphp.ZVal {
	mut out := new_array()
	out.bool('handled', true)
	out.int('status', zval_int_key(result, 'status', 200))
	out.set('headers', vphp.PhpValue.from_zval(headers_or_default(zval_key(result, 'headers'))))
	out.string('body', zval_raw_string_key(result, 'body', ''))
	out.string('protocol_version', first_non_empty([
		zval_string_key(result, 'protocol_version', ''),
		protocol_version,
	]))
	out.string('session_id', zval_string_key(result, 'session_id', ''))
	out.set('messages', vphp.PhpValue.from_zval(string_array_or_empty(zval_key(result, 'messages'))))
	return out.take_zval()
}

fn default_mcp_headers() vphp.ZVal {
	mut headers := new_array()
	headers.string('content-type', 'application/json; charset=utf-8')
	return headers.take_zval()
}

fn default_mcp_queued_result() vphp.ZVal {
	mut out := new_array()
	out.bool('queued', true)
	return out.take_zval()
}

fn headers_or_default(headers vphp.ZVal) vphp.ZVal {
	if headers.is_array() && headers.array_count() > 0 {
		return headers
	}
	return default_mcp_headers()
}

fn array_or_empty(input vphp.ZVal) vphp.ZVal {
	if input.is_array() {
		return input
	}
	mut out := new_array()
	return out.take_zval()
}

fn string_array_or_empty(input vphp.ZVal) vphp.ZVal {
	if !input.is_array() {
		mut out := new_array()
		return out.take_zval()
	}
	mut out := new_array()
	for idx := 0; idx < input.array_count(); idx++ {
		out.push_string(input.array_get(idx).to_string())
	}
	return out.take_zval()
}

fn persistent_array_or_empty(input vphp.ZVal) vphp.PersistentOwnedZBox {
	if input.is_array() {
		return vphp.PersistentOwnedZBox.from_mixed_zval(input)
	}
	return vphp.PersistentOwnedZBox.from_dyn(vphp.DynValue.of_map(map[string]vphp.DynValue{}))
}

fn invoke_mcp_handler(handler vphp.PersistentOwnedZBox, args []vphp.PhpFnArg) vphp.ZVal {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() || !handler.is_callable() {
		return vphp.RequestOwnedZBox.new_null().to_zval()
	}
	mut result := handler.fn_request_owned(...args)
	return result.take_zval()
}

fn release_mcp_handler(mut handler vphp.PersistentOwnedZBox) {
	if !handler.is_valid() {
		return
	}
	unsafe {
		mut owned := handler
		owned.release()
	}
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

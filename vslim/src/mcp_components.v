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
		vphp.PhpException.raise_class('InvalidArgumentException', 'register handler must be callable', 0)
		return &app
	}
	if key in app.method_handlers {
		mut existing := app.method_handlers[key] or { vphp.PersistentOwnedZBox.new_null() }
		release_mcp_handler(mut existing)
	}
	app.method_handlers[key] = vphp.PersistentOwnedZBox.from_callable_zval(raw_handler)
	return &app
}

@[php_method]
@[php_arg_name: 'input_schema=inputSchema']
pub fn (mut app VSlimMcpApp) tool(name string, description string, input_schema vphp.RequestBorrowedZBox, handler vphp.RequestBorrowedZBox) &VSlimMcpApp {
	key := name.trim_space()
	raw_handler := handler.to_zval()
	raw_schema := input_schema.to_zval()
	if key == '' || !raw_handler.is_valid() || !raw_handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'tool handler must be callable', 0)
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

@[php_method]
@[php_arg_name: 'mime_type=mimeType']
pub fn (mut app VSlimMcpApp) resource(uri string, name string, description string, mime_type string, handler vphp.RequestBorrowedZBox) &VSlimMcpApp {
	key := uri.trim_space()
	raw_handler := handler.to_zval()
	if key == '' || !raw_handler.is_valid() || !raw_handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'resource handler must be callable', 0)
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
		vphp.PhpException.raise_class('InvalidArgumentException', 'prompt handler must be callable', 0)
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
	return json_encode_zval(new_rpc_notification(method, params.to_zval()))
}

@[php_method]
pub fn VSlimMcpApp.request(id vphp.RequestBorrowedZBox, method string, params vphp.RequestBorrowedZBox) string {
	return json_encode_zval(new_rpc_request(id.to_zval(), method, params.to_zval()))
}

@[php_method: 'samplingRequest']
@[php_arg_name: 'model_preferences=modelPreferences,system_prompt=systemPrompt,max_tokens=maxTokens,tool_choice=toolChoice']
pub fn VSlimMcpApp.sampling_request(id vphp.RequestBorrowedZBox, messages vphp.RequestBorrowedZBox, model_preferences vphp.RequestBorrowedZBox, system_prompt string, max_tokens int, temperature vphp.RequestBorrowedZBox, tools vphp.RequestBorrowedZBox, tool_choice vphp.RequestBorrowedZBox) string {
	return json_encode_zval(new_sampling_request(id.to_zval(), messages.to_zval(), model_preferences.to_zval(), system_prompt,
		max_tokens, temperature.to_zval(), tools.to_zval(), tool_choice.to_zval()))
}

@[php_method: 'queuedResult']
@[php_arg_name: 'protocol_version=protocolVersion,session_id=sessionId']
pub fn VSlimMcpApp.queued_result(id vphp.RequestBorrowedZBox, result vphp.RequestBorrowedZBox, notifications vphp.RequestBorrowedZBox, status int, protocol_version string, session_id string, headers vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(new_queued_result(id.to_zval(), result.to_zval(), notifications.to_zval(), status,
		protocol_version, session_id, headers.to_zval()))
}

@[php_method: 'queueMessages']
@[php_arg_name: 'protocol_version=protocolVersion,session_id=sessionId']
pub fn VSlimMcpApp.queue_messages(id vphp.RequestBorrowedZBox, result vphp.RequestBorrowedZBox, messages vphp.RequestBorrowedZBox, status int, protocol_version string, session_id string, headers vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(new_queued_result(id.to_zval(), result.to_zval(), messages.to_zval(), status,
		protocol_version, session_id, headers.to_zval()))
}

@[php_method]
@[php_arg_name: 'session_id=sessionId,protocol_version=protocolVersion']
pub fn VSlimMcpApp.notify(id vphp.RequestBorrowedZBox, method string, params vphp.RequestBorrowedZBox, session_id string, protocol_version string) vphp.RequestOwnedZBox {
	mut notifications := new_array_zval()
	notifications.add_next_val(vphp.RequestOwnedZBox.new_string(VSlimMcpApp.notification(method,
		params)).to_zval())
	return vphp.RequestOwnedZBox.adopt_zval(new_queued_result(id.to_zval(), default_mcp_queued_result(),
		notifications, 200, protocol_version, session_id, default_mcp_headers()))
}

@[php_method: 'queueNotification']
@[php_arg_name: 'session_id=sessionId,protocol_version=protocolVersion']
pub fn VSlimMcpApp.queue_notification(id vphp.RequestBorrowedZBox, method string, params vphp.RequestBorrowedZBox, session_id string, protocol_version string) vphp.RequestOwnedZBox {
	return VSlimMcpApp.notify(id, method, params, session_id, protocol_version)
}

@[php_method: 'queueRequest']
@[php_arg_name: 'response_id=responseId,request_id=requestId,session_id=sessionId,protocol_version=protocolVersion']
pub fn VSlimMcpApp.queue_request(response_id vphp.RequestBorrowedZBox, request_id vphp.RequestBorrowedZBox, method string, params vphp.RequestBorrowedZBox, session_id string, protocol_version string) vphp.RequestOwnedZBox {
	mut messages := new_array_zval()
	messages.add_next_val(vphp.RequestOwnedZBox.new_string(VSlimMcpApp.request(request_id, method,
		params)).to_zval())
	return vphp.RequestOwnedZBox.adopt_zval(new_queued_result(response_id.to_zval(),
		default_mcp_queued_result(), messages, 200, protocol_version, session_id, default_mcp_headers()))
}

@[php_method: 'queueProgress']
@[php_arg_name: 'progress_token=progressToken,session_id=sessionId,protocol_version=protocolVersion']
pub fn VSlimMcpApp.queue_progress(id vphp.RequestBorrowedZBox, progress_token vphp.RequestBorrowedZBox, progress vphp.RequestBorrowedZBox, total vphp.RequestBorrowedZBox, message string, session_id string, protocol_version string) vphp.RequestOwnedZBox {
	raw_progress_token := progress_token.to_zval()
	raw_progress := progress.to_zval()
	raw_total := total.to_zval()
	mut params := new_array_zval()
	add_assoc_zval(params, 'progressToken', raw_progress_token)
	add_assoc_zval(params, 'progress', raw_progress)
	if !raw_total.is_null() && !raw_total.is_undef() {
		add_assoc_zval(params, 'total', raw_total)
	}
	if message.trim_space() != '' {
		params.add_assoc_string('message', message)
	}
	return VSlimMcpApp.notify(id, 'notifications/progress', vphp.RequestBorrowedZBox.of(params), session_id, protocol_version)
}

@[php_method: 'queueLog']
@[php_arg_name: 'session_id=sessionId,protocol_version=protocolVersion']
pub fn VSlimMcpApp.queue_log(id vphp.RequestBorrowedZBox, level string, message string, data vphp.RequestBorrowedZBox, logger string, session_id string, protocol_version string) vphp.RequestOwnedZBox {
	raw_data := data.to_zval()
	mut params := new_array_zval()
	params.add_assoc_string('level', level)
	if raw_data.is_array() && raw_data.array_count() > 0 {
		add_assoc_zval(params, 'data', raw_data)
		if message.trim_space() != '' {
			params.add_assoc_string('message', message)
		}
	} else {
		mut payload := new_array_zval()
		payload.add_assoc_string('message', message)
		add_assoc_zval(params, 'data', payload)
	}
	if logger.trim_space() != '' {
		params.add_assoc_string('logger', logger)
	}
	return VSlimMcpApp.notify(id, 'notifications/message', vphp.RequestBorrowedZBox.of(params), session_id, protocol_version)
}

@[php_method: 'queueSampling']
@[php_arg_name: 'response_id=responseId,sampling_id=samplingId,session_id=sessionId,protocol_version=protocolVersion,model_preferences=modelPreferences,system_prompt=systemPrompt,max_tokens=maxTokens']
pub fn VSlimMcpApp.queue_sampling(response_id vphp.RequestBorrowedZBox, sampling_id vphp.RequestBorrowedZBox, messages vphp.RequestBorrowedZBox, session_id string, protocol_version string, model_preferences vphp.RequestBorrowedZBox, system_prompt string, max_tokens int) vphp.RequestOwnedZBox {
	mut queue := new_array_zval()
	queue.add_next_val(vphp.RequestOwnedZBox.new_string(VSlimMcpApp.sampling_request(sampling_id,
		messages, model_preferences, system_prompt, max_tokens,
		vphp.RequestBorrowedZBox.of(vphp.RequestOwnedZBox.new_null().to_zval()), vphp.RequestBorrowedZBox.of(vphp.RequestOwnedZBox.new_null().to_zval()),
		vphp.RequestBorrowedZBox.of(vphp.RequestOwnedZBox.new_null().to_zval()))).to_zval())
	return vphp.RequestOwnedZBox.adopt_zval(new_queued_result(response_id.to_zval(),
		default_mcp_queued_result(), queue, 200, protocol_version, session_id, default_mcp_headers()))
}

@[php_method: 'clientCapabilities']
pub fn VSlimMcpApp.client_capabilities(frame vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	raw_frame := frame.to_zval()
	caps_raw := zval_raw_string_key(raw_frame, 'client_capabilities_json', '')
	if caps_raw.trim_space() == '' {
		return vphp.RequestOwnedZBox.of(new_array_zval())
	}
	caps := vphp.PhpJson.decode_assoc(caps_raw)
	if !caps.is_array() {
		return vphp.RequestOwnedZBox.of(new_array_zval())
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
	mut out := new_array_zval()
	out.add_assoc_bool('handled', true)
	out.add_assoc_long('status', if status > 0 { status } else { 409 })
	add_assoc_zval(out, 'headers', default_mcp_headers())
	out.add_assoc_string('body', json_encode_zval(new_string_map_zval({
		'error': message
	})))
	out.add_assoc_string('protocol_version', zval_string_key(raw_frame, 'protocol_version',
		'2025-11-05'))
	out.add_assoc_string('session_id', zval_string_key(raw_frame, 'session_id', ''))
	add_assoc_zval(out, 'messages', new_array_zval())
	return vphp.RequestOwnedZBox.of(out)
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
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(vphp.RequestOwnedZBox.new_null().to_zval(),
			-32700, 'Missing JSON-RPC body', 400, protocol_version))
	}
	message := vphp.PhpJson.decode_assoc(raw)
	if !message.is_array() {
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(vphp.RequestOwnedZBox.new_null().to_zval(),
			-32700, 'Invalid JSON', 400, protocol_version))
	}
	id := zval_key(message, 'id')
	if zval_string_key(message, 'jsonrpc', '') != '2.0' {
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(id, -32600,
			'Invalid JSON-RPC version', 400, protocol_version))
	}
	method := zval_string_key(message, 'method', '')
	if method == '' {
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(id, -32600, 'Missing method', 400,
			protocol_version))
	}
	if method == 'initialize' {
		params := zval_key(message, 'params')
		client_version := zval_string_key(params, 'protocolVersion', protocol_version)
		mut result := new_array_zval()
		result.add_assoc_string('protocolVersion', if client_version == '' { '2025-11-05' } else { client_version })
		add_assoc_zval(result, 'capabilities', app.effective_capabilities())
		add_assoc_zval(result, 'serverInfo', app.server_info_zval())
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, result, 200, if client_version == '' {
			protocol_version
		} else {
			client_version
		}))
	}
	if method == 'ping' {
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, new_array_zval(), 200,
			protocol_version))
	}
	if method == 'tools/list' && method !in app.method_handlers {
		mut result := new_array_zval()
		add_assoc_zval(result, 'tools', app.tool_definitions())
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, result, 200, protocol_version))
	}
	if method == 'tools/call' && method !in app.method_handlers {
		return vphp.RequestOwnedZBox.adopt_zval(app.handle_builtin_tool_call(message, raw_frame,
			protocol_version))
	}
	if method == 'resources/list' && method !in app.method_handlers {
		mut result := new_array_zval()
		add_assoc_zval(result, 'resources', app.resource_definitions())
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, result, 200, protocol_version))
	}
	if method == 'resources/read' && method !in app.method_handlers {
		return vphp.RequestOwnedZBox.adopt_zval(app.handle_builtin_resource_read(message, raw_frame,
			protocol_version))
	}
	if method == 'prompts/list' && method !in app.method_handlers {
		mut result := new_array_zval()
		add_assoc_zval(result, 'prompts', app.prompt_definitions())
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, result, 200, protocol_version))
	}
	if method == 'prompts/get' && method !in app.method_handlers {
		return vphp.RequestOwnedZBox.adopt_zval(app.handle_builtin_prompt_get(message, raw_frame,
			protocol_version))
	}
	if method !in app.method_handlers {
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(id, -32601, 'Method not found', 200,
			protocol_version))
	}
	handler := app.method_handlers[method] or {
		return vphp.RequestOwnedZBox.adopt_zval(new_mcp_error_response(id, -32601, 'Method not found', 200,
			protocol_version))
	}
	result := invoke_mcp_handler(handler, [
		message,
		raw_frame,
	])
	if result.is_array() && !zval_key(result, 'body').is_null() {
		return vphp.RequestOwnedZBox.adopt_zval(normalize_mcp_passthrough(result, protocol_version))
	}
	return vphp.RequestOwnedZBox.adopt_zval(new_mcp_result_response(id, result, 200, protocol_version))
}

pub fn (app &VSlimMcpApp) effective_capabilities() vphp.ZVal {
	mut caps := new_array_zval()
	mut keys := app.server_capabilities.keys()
	keys.sort()
	for key in keys {
		handler := app.server_capabilities[key] or { continue }
		handler.with_request_zval(fn [mut caps, key] (z vphp.ZVal) bool {
			add_assoc_zval(caps, key, z)
			return true
		})
	}
	if app.tool_handlers.len > 0 && zval_key(caps, 'tools').is_null() {
		mut def := new_array_zval()
		def.add_assoc_bool('listChanged', false)
		add_assoc_zval(caps, 'tools', def)
	}
	if app.resource_handlers.len > 0 && zval_key(caps, 'resources').is_null() {
		mut def := new_array_zval()
		def.add_assoc_bool('listChanged', false)
		add_assoc_zval(caps, 'resources', def)
	}
	if app.prompt_handlers.len > 0 && zval_key(caps, 'prompts').is_null() {
		mut def := new_array_zval()
		def.add_assoc_bool('listChanged', false)
		add_assoc_zval(caps, 'prompts', def)
	}
	return caps
}

pub fn (app &VSlimMcpApp) server_info_zval() vphp.ZVal {
	return new_string_map_zval(app.server_info)
}

pub fn (app &VSlimMcpApp) tool_definitions() vphp.ZVal {
	mut out := new_array_zval()
	mut keys := app.tool_handlers.keys()
	keys.sort()
	for key in keys {
		mut row := new_array_zval()
		row.add_assoc_string('name', key)
		row.add_assoc_string('description', app.tool_descriptions[key] or { '' })
		schema := app.tool_schemas[key] or { vphp.PersistentOwnedZBox.from_dyn(vphp.DynValue.of_map(map[string]vphp.DynValue{})) }
		schema.with_request_zval(fn [mut row] (z vphp.ZVal) bool {
			add_assoc_zval(row, 'inputSchema', z)
			return true
		})
		out.add_next_val(row)
	}
	return out
}

pub fn (app &VSlimMcpApp) resource_definitions() vphp.ZVal {
	mut out := new_array_zval()
	mut keys := app.resource_handlers.keys()
	keys.sort()
	for key in keys {
		mut row := new_array_zval()
		row.add_assoc_string('uri', key)
		row.add_assoc_string('name', app.resource_names[key] or { '' })
		row.add_assoc_string('description', app.resource_descriptions[key] or { '' })
		row.add_assoc_string('mimeType', app.resource_mime_types[key] or { '' })
		out.add_next_val(row)
	}
	return out
}

pub fn (app &VSlimMcpApp) prompt_definitions() vphp.ZVal {
	mut out := new_array_zval()
	mut keys := app.prompt_handlers.keys()
	keys.sort()
	for key in keys {
		mut row := new_array_zval()
		row.add_assoc_string('name', key)
		row.add_assoc_string('description', app.prompt_descriptions[key] or { '' })
		args := app.prompt_arguments[key] or { vphp.PersistentOwnedZBox.from_dyn(vphp.DynValue.of_list([]vphp.DynValue{})) }
		args.with_request_zval(fn [mut row] (z vphp.ZVal) bool {
			add_assoc_zval(row, 'arguments', z)
			return true
		})
		out.add_next_val(row)
	}
	return out
}

pub fn (app &VSlimMcpApp) handle_builtin_tool_call(message vphp.ZVal, frame vphp.ZVal, protocol_version string) vphp.ZVal {
	params := zval_key(message, 'params')
	name := zval_string_key(params, 'name', '')
	id := zval_key(message, 'id')
	if name == '' || name !in app.tool_handlers {
		mut result := new_array_zval()
		mut content := new_array_zval()
		mut item := new_array_zval()
		item.add_assoc_string('type', 'text')
		item.add_assoc_string('text', 'unknown tool')
		content.add_next_val(item)
		add_assoc_zval(result, 'content', content)
		result.add_assoc_bool('isError', true)
		return new_mcp_result_response(id, result, 200, protocol_version)
	}
	arguments := zval_key(params, 'arguments')
	handler := app.tool_handlers[name] or {
		mut fallback := new_array_zval()
		mut content := new_array_zval()
		mut item := new_array_zval()
		item.add_assoc_string('type', 'text')
		item.add_assoc_string('text', 'unknown tool')
		content.add_next_val(item)
		add_assoc_zval(fallback, 'content', content)
		fallback.add_assoc_bool('isError', true)
		return new_mcp_result_response(id, fallback, 200, protocol_version)
	}
	result := invoke_mcp_handler(handler, [
		arguments,
		message,
		frame,
	])
	return new_mcp_result_response(id, result, 200, protocol_version)
}

pub fn (app &VSlimMcpApp) handle_builtin_resource_read(message vphp.ZVal, frame vphp.ZVal, protocol_version string) vphp.ZVal {
	params := zval_key(message, 'params')
	uri := zval_string_key(params, 'uri', '')
	id := zval_key(message, 'id')
	if uri == '' || uri !in app.resource_handlers {
		return new_mcp_error_response(id, -32002, 'Resource not found', 200, protocol_version)
	}
	handler := app.resource_handlers[uri] or { return new_mcp_error_response(id, -32002, 'Resource not found', 200, protocol_version) }
	result := invoke_mcp_handler(handler, [
		params,
		message,
		frame,
	])
	if result.is_string() {
		mut body := new_array_zval()
		mut contents := new_array_zval()
		mut item := new_array_zval()
		item.add_assoc_string('uri', uri)
		item.add_assoc_string('mimeType', app.resource_mime_types[uri] or { 'text/plain' })
		item.add_assoc_string('text', result.to_string())
		contents.add_next_val(item)
		add_assoc_zval(body, 'contents', contents)
		return new_mcp_result_response(id, body, 200, protocol_version)
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
	handler := app.prompt_handlers[name] or { return new_mcp_error_response(id, -32003, 'Prompt not found', 200, protocol_version) }
	result := invoke_mcp_handler(handler, [
		arguments,
		message,
		frame,
	])
	return new_mcp_result_response(id, result, 200, protocol_version)
}

fn new_rpc_notification(method string, params vphp.ZVal) vphp.ZVal {
	mut out := new_array_zval()
	out.add_assoc_string('jsonrpc', '2.0')
	out.add_assoc_string('method', method)
	add_assoc_zval(out, 'params', array_or_empty(params))
	return out
}

fn new_rpc_request(id vphp.ZVal, method string, params vphp.ZVal) vphp.ZVal {
	mut out := new_rpc_notification(method, params)
	add_assoc_zval(out, 'id', id)
	return out
}

fn new_sampling_request(id vphp.ZVal, messages vphp.ZVal, model_preferences vphp.ZVal, system_prompt string, max_tokens int, temperature vphp.ZVal, tools vphp.ZVal, tool_choice vphp.ZVal) vphp.ZVal {
	mut params := new_array_zval()
	add_assoc_zval(params, 'messages', array_or_empty(messages))
	if model_preferences.is_array() && model_preferences.array_count() > 0 {
		add_assoc_zval(params, 'modelPreferences', model_preferences)
	}
	if system_prompt.trim_space() != '' {
		params.add_assoc_string('systemPrompt', system_prompt)
	}
	if max_tokens > 0 {
		params.add_assoc_long('maxTokens', max_tokens)
	}
	if !temperature.is_null() && !temperature.is_undef() {
		add_assoc_zval(params, 'temperature', temperature)
	}
	if tools.is_array() && tools.array_count() > 0 {
		add_assoc_zval(params, 'tools', tools)
	}
	if !tool_choice.is_null() && !tool_choice.is_undef() {
		add_assoc_zval(params, 'toolChoice', tool_choice)
	}
	return new_rpc_request(id, 'sampling/createMessage', params)
}

fn new_queued_result(id vphp.ZVal, result vphp.ZVal, notifications vphp.ZVal, status int, protocol_version string, session_id string, headers vphp.ZVal) vphp.ZVal {
	mut out := new_mcp_result_response(id, result, status, protocol_version)
	add_assoc_zval(out, 'messages', string_array_or_empty(notifications))
	out.add_assoc_string('session_id', session_id)
	add_assoc_zval(out, 'headers', headers_or_default(headers))
	return out
}

fn new_mcp_result_response(id vphp.ZVal, result vphp.ZVal, status int, protocol_version string) vphp.ZVal {
	mut payload := new_array_zval()
	payload.add_assoc_string('jsonrpc', '2.0')
	add_assoc_zval(payload, 'id', id)
	add_assoc_zval(payload, 'result', result)
	mut out := new_array_zval()
	out.add_assoc_bool('handled', true)
	out.add_assoc_long('status', status)
	add_assoc_zval(out, 'headers', default_mcp_headers())
	out.add_assoc_string('body', json_encode_zval(payload))
	out.add_assoc_string('protocol_version', protocol_version)
	out.add_assoc_string('session_id', '')
	add_assoc_zval(out, 'messages', new_array_zval())
	return out
}

fn new_mcp_error_response(id vphp.ZVal, code int, message string, status int, protocol_version string) vphp.ZVal {
	mut err := new_array_zval()
	err.add_assoc_long('code', code)
	err.add_assoc_string('message', message)
	mut payload := new_array_zval()
	payload.add_assoc_string('jsonrpc', '2.0')
	add_assoc_zval(payload, 'id', id)
	add_assoc_zval(payload, 'error', err)
	mut out := new_array_zval()
	out.add_assoc_bool('handled', true)
	out.add_assoc_long('status', status)
	add_assoc_zval(out, 'headers', default_mcp_headers())
	out.add_assoc_string('body', json_encode_zval(payload))
	out.add_assoc_string('protocol_version', protocol_version)
	out.add_assoc_string('session_id', '')
	add_assoc_zval(out, 'messages', new_array_zval())
	return out
}

fn normalize_mcp_passthrough(result vphp.ZVal, protocol_version string) vphp.ZVal {
	mut out := new_array_zval()
	out.add_assoc_bool('handled', true)
	out.add_assoc_long('status', zval_int_key(result, 'status', 200))
	add_assoc_zval(out, 'headers', headers_or_default(zval_key(result, 'headers')))
	out.add_assoc_string('body', zval_raw_string_key(result, 'body', ''))
	out.add_assoc_string('protocol_version', first_non_empty([
		zval_string_key(result, 'protocol_version', ''),
		protocol_version,
	]))
	out.add_assoc_string('session_id', zval_string_key(result, 'session_id', ''))
	add_assoc_zval(out, 'messages', string_array_or_empty(zval_key(result, 'messages')))
	return out
}

fn default_mcp_headers() vphp.ZVal {
	mut headers := new_array_zval()
	headers.add_assoc_string('content-type', 'application/json; charset=utf-8')
	return headers
}

fn default_mcp_queued_result() vphp.ZVal {
	mut out := new_array_zval()
	out.add_assoc_bool('queued', true)
	return out
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
	return new_array_zval()
}

fn string_array_or_empty(input vphp.ZVal) vphp.ZVal {
	if !input.is_array() {
		return new_array_zval()
	}
	mut out := new_array_zval()
	for idx := 0; idx < input.array_count(); idx++ {
		out.add_next_val(vphp.RequestOwnedZBox.new_string(input.array_get(idx).to_string()).to_zval())
	}
	return out
}

fn persistent_array_or_empty(input vphp.ZVal) vphp.PersistentOwnedZBox {
	if input.is_array() {
		return vphp.PersistentOwnedZBox.from_mixed_zval(input)
	}
	return vphp.PersistentOwnedZBox.from_dyn(vphp.DynValue.of_map(map[string]vphp.DynValue{}))
}

fn invoke_mcp_handler(handler vphp.PersistentOwnedZBox, args []vphp.ZVal) vphp.ZVal {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() || !handler.is_callable() {
		return vphp.RequestOwnedZBox.new_null().to_zval()
	}
	mut result := handler.call_request_owned(args)
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

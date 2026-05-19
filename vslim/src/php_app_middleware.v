module main

import vphp

struct PhpValueSubject {
	value vphp.PhpValue
}

struct PhpObjectSubject {
	object vphp.PhpObject
}

fn value_subject(value vphp.PhpValue) PhpValueSubject {
	return PhpValueSubject{
		value: value
	}
}

fn object_subject(object vphp.PhpObject) PhpObjectSubject {
	return PhpObjectSubject{
		object: object
	}
}

fn (subject PhpValueSubject) is_supported_route_handler() bool {
	handler := subject.value
	if !handler.is_valid() {
		return false
	}
	if handler.is_callable() || handler.is_string() || handler.is_array() {
		return true
	}
	if !handler.is_object() {
		return false
	}
	return handler.is_instance_of('Psr\\Http\\Server\\RequestHandlerInterface')
		|| handler.method_exists('mount') || handler.method_exists('render')
}

fn (kind MiddlewareRegistrationKind) registration_error() string {
	return match kind {
		.standard { 'middleware must be a PSR-15 middleware registration' }
		.before { 'before middleware must be a PSR-15 middleware registration' }
		.after { 'after middleware must be a PSR-15 middleware registration' }
	}
}

fn (kind MiddlewareRegistrationKind) supports_registration(handler vphp.PhpValue) bool {
	return match kind {
		.standard { value_subject(handler).is_supported_middleware_registration() }
		.before, .after { value_subject(handler).is_supported_phase_middleware_registration() }
	}
}

fn (mut app VSlimApp) register_middleware_kind(handler vphp.PhpValue, kind MiddlewareRegistrationKind) {
	if !kind.supports_registration(handler) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			kind.registration_error(), 0)
		return
	}
	if handler.is_object() {
		(&app).bind_cached_target_if_supported(handler)
	}
	entry := handler.retain()
	if kind == .standard && app.middlewares.len == 0 {
		cli_debug_log('middleware.register kind=${entry.kind_name()} valid=${entry.is_valid()} null=${entry.is_null()} undef=${entry.is_undef()} handler_type=${handler.type_name()} handler_class=${handler.class_name()}')
	}
	match kind {
		.standard { app.middlewares << entry }
		.before { app.before_middlewares << entry }
		.after { app.after_middlewares << entry }
	}
}

fn (group &RouteGroup) register_middleware_kind(handler vphp.PhpValue, kind MiddlewareRegistrationKind) {
	if !kind.supports_registration(handler) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			kind.registration_error(), 0)
		return
	}
	prefix := group.normalized_prefix()
	unsafe {
		mut app := &VSlimApp(group.app)
		if handler.is_object() {
			app.bind_cached_target_if_supported(handler)
		}
		match kind {
			.standard {
				app.group_middle.prefixes << prefix
				app.group_middle.handlers << handler.retain()
			}
			.before {
				app.group_before_middle.prefixes << prefix
				app.group_before_middle.handlers << handler.retain()
			}
			.after {
				app.group_after_middle.prefixes << prefix
				app.group_after_middle.handlers << handler.retain()
			}
		}
	}
}

fn (app &VSlimApp) bind_cached_target_if_supported(target vphp.PhpValue) {
	if !target.is_valid() || !target.is_object() {
		return
	}
	if target.method_exists('setApp') {
		mut app_value := app.self_value()
		defer {
			app_value.release()
		}
		mut result := target.call_method('setApp', app_value)
		result.release()
	}
}

fn (subject PhpValueSubject) is_supported_middleware_handler() bool {
	handler := subject.value
	if !handler.is_valid() {
		return false
	}
	if !handler.is_object() {
		return false
	}
	if handler.is_instance_of('Closure') {
		return false
	}
	return handler.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface')
		|| handler.method_exists('process')
}

fn (subject PhpValueSubject) is_supported_middleware_registration() bool {
	handler := subject.value
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return false
	}
	if handler.is_string() || handler.is_array() {
		return true
	}
	return value_subject(handler).is_supported_middleware_handler()
}

fn (subject PhpValueSubject) is_supported_phase_middleware_registration() bool {
	handler := subject.value
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return false
	}
	if handler.is_string() || handler.is_array() {
		return true
	}
	return value_subject(handler).is_supported_middleware_handler()
}

fn (subject PhpValueSubject) is_psr15_middleware_handler() bool {
	return subject.is_supported_middleware_handler()
}

fn (subject PhpValueSubject) is_psr15_request_handler() bool {
	handler := subject.value
	if !handler.is_valid() {
		return false
	}
	return handler.is_object()
		&& handler.is_instance_of('Psr\\Http\\Server\\RequestHandlerInterface')
}

fn (subject PhpValueSubject) is_psr_server_request_payload() bool {
	payload := subject.value
	if !payload.is_valid() {
		return false
	}
	return payload.is_object()
		&& (payload.is_instance_of('Psr\\Http\\Message\\ServerRequestInterface')
		|| (payload.method_exists('getMethod') && payload.method_exists('getUri')))
}

fn is_psr_server_request_object(payload vphp.PhpObject) bool {
	return payload.is_valid()
		&& (payload.is_instance_of('Psr\\Http\\Message\\ServerRequestInterface')
		|| (payload.method_exists('getMethod') && payload.method_exists('getUri')))
}

fn (table HookTable) collect_matching(path string) []vphp.PhpValue {
	mut out := []vphp.PhpValue{}
	for i, prefix in table.prefixes {
		if path_has_prefix(path, prefix) && i < table.handlers.len {
			out << table.handlers[i].owned()
		}
	}
	return out
}

fn release_collected_middlewares(mut hooks []vphp.PhpValue) {
	for i in 0 .. hooks.len {
		hooks[i].release()
	}
	unsafe {
		hooks.free()
	}
}

fn (app &VSlimApp) collect_standard_middlewares(group_hooks []vphp.PhpValue) []vphp.PhpValue {
	mut out := []vphp.PhpValue{}
	for idx, hook in app.middlewares {
		cloned := hook.owned()
		if idx == 0 {
			slot_addr := unsafe { usize(&app.middlewares[idx]) }
			cli_debug_log('middleware.collect app idx=${idx} slot=${slot_addr} src_kind=${hook.kind_name()} src_valid=${hook.is_valid()} src_null=${hook.is_null()} src_undef=${hook.is_undef()} clone_valid=${cloned.is_valid()} clone_null=${cloned.is_null()} clone_undef=${cloned.is_undef()}')
		}
		out << cloned
	}
	for hook in group_hooks {
		out << hook.owned()
	}
	return out
}

fn (app &VSlimApp) collect_before_middlewares(group_hooks []vphp.PhpValue) []vphp.PhpValue {
	mut out := []vphp.PhpValue{}
	for hook in app.before_middlewares {
		out << hook.owned()
	}
	for hook in group_hooks {
		out << hook.owned()
	}
	return out
}

fn (app &VSlimApp) collect_after_middlewares(group_hooks []vphp.PhpValue) []vphp.PhpValue {
	mut out := []vphp.PhpValue{}
	for hook in app.after_middlewares {
		out << hook.owned()
	}
	for hook in group_hooks {
		out << hook.owned()
	}
	return out
}

fn (subject PhpValueSubject) legacy_middleware_payload(route_params map[string]string) vphp.PhpValue {
	payload := subject.value
	if payload.is_valid() && payload.is_object()
		&& (payload.is_instance_of('VSlim\\VHttpd\\Request')
		|| payload.is_instance_of('VSlimRequest')) {
		return payload.owned()
	}
	req := VSlimRequest.from_psr_server_request(payload, route_params)
	return req.build_request_value(route_params)
}

fn (subject PhpValueSubject) middleware_target_method(explicit_method string) string {
	target := subject.value
	method := explicit_method.trim_space()
	if method != '' {
		return method
	}
	if target.is_object() && (target.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface')
		|| target.method_exists('process')) {
		return 'process'
	}
	if target.is_object() && target.method_exists('__invoke') {
		return '__invoke'
	}
	return ''
}

fn (app &VSlimApp) resolve_middleware_target(handler vphp.PhpValue) !(vphp.PhpValue, string) {
	if !handler.is_valid() {
		return error('Middleware is not valid')
	}
	if handler.is_string() {
		if !app.has_container() {
			return error('Middleware container is not configured')
		}
		return app.resolve_container_service(handler.to_string())!, ''
	}
	if handler.is_array() {
		if !app.has_container() {
			return error('Middleware container is not configured')
		}
		parts := handler.to_string_list()
		if parts.len == 0 || parts[0] == '' {
			return error('Invalid middleware container array handler')
		}
		service := app.resolve_container_service(parts[0])!
		method := if parts.len >= 2 { parts[1] } else { '' }
		return service, method
	}
	return handler, ''
}

fn (app &VSlimApp) resolve_phase_middleware_target(handler vphp.PhpValue) !vphp.PhpValue {
	target, explicit_method := app.resolve_middleware_target(handler)!
	method := value_subject(target).middleware_target_method(explicit_method)
	if method != 'process' || !target.is_object()
		|| (!target.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface')
		&& !target.method_exists('process')) {
		return error('Phase middleware must implement Psr\\Http\\Server\\MiddlewareInterface')
	}
	return target
}

fn (app &VSlimApp) resolve_route_target(handler vphp.PhpValue) !(vphp.PhpValue, string) {
	if !handler.is_valid() {
		return error('Invalid route handler')
	}
	if handler.is_string() {
		if !app.has_container() {
			return error('Route handler container is not configured')
		}
		target_value := app.resolve_container_service(handler.to_string())!
		if !target_value.is_object() {
			return error('Route handler service "${handler.to_string()}" must be an object')
		}
		if target_value.is_instance_of('Psr\\Http\\Server\\RequestHandlerInterface') {
			return target_value, 'handle'
		}
		return error('Route handler service "${handler.to_string()}" must implement Psr\\Http\\Server\\RequestHandlerInterface')
	}
	if handler.is_array() {
		if !app.has_container() {
			return error('Route handler container is not configured')
		}
		parts := handler.to_string_list()
		if parts.len != 2 || parts[0] == '' || parts[1].trim_space() == '' {
			return error('Route handler array must be ["service", "method"]')
		}
		target_value := app.resolve_container_service(parts[0])!
		if !target_value.is_object() {
			return error('Route handler service "${parts[0]}" must be an object')
		}
		if !target_value.method_exists(parts[1]) {
			return error('Container service "${parts[0]}" has no method "${parts[1]}"')
		}
		return target_value, parts[1]
	}
	return handler, ''
}

fn (app &VSlimApp) bind_route_target_if_supported(target vphp.PhpValue) {
	target_obj := target.as_object() or { return }
	if target_obj.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface') {
		// Cached middleware instances should be bound once at registration or
		// first construction, not rebound on every dispatch.
		return
	}
	if target_obj.is_instance_of('VSlim\\Controller') {
		// VSlim\Controller already resolves the effective app from the current
		// runtime dispatch context. Rebinding the same cached controller object on
		// every dispatch adds an extra bridge round-trip and has been a crash hot
		// path in repeated dispatch_request() scenarios.
		return
	}
	if target_obj.method_exists('setApp') {
		mut app_value := app.self_value()
		defer {
			app_value.release()
		}
		mut result := target_obj.call_method('setApp', app_value)
		result.release()
	}
}

fn (subject PhpValueSubject) call_route_target_method(method string, args []vphp.PhpArgInput) vphp.PhpValue {
	target := subject.value
	if method.trim_space() != '' {
		if target_obj := target.as_object() {
			return target_obj.call_method(method, ...args)
		}
	}
	if callable := target.as_callable() {
		return callable.invoke(...args)
	}
	return vphp.PhpValue.null()
}

fn (subject PhpValueSubject) route_handler_response() vphp.PhpValue {
	mut result := subject.value
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return result.owned()
	}
	res, ok := VSlimResponse.from_route_result(result)
	if ok {
		cli_debug_log('route.result normalized status=${res.status} body_len=${res.body.len} content_type=${res.content_type}')
		result.release()
		return res.to_value()
	}
	psr, psr_ok := VSlimResponse.psr7_from_route_result(result)
	if psr_ok {
		cli_debug_log('route.result psr status=${psr.get_status_code()} body_len=${psr7_stream_string(psr.body_or_empty()).len}')
		result.release()
		return psr.to_vslim_response().to_value()
	}
	return result.owned()
}

fn (mut chain MiddlewareChain) dispatch_entry(handler vphp.PhpValue, payload vphp.PhpValue) !vphp.PhpValue {
	target, explicit_method := chain.app.resolve_middleware_target(handler) or {
		cli_debug_log('middleware.target.resolve.error msg=${err.msg()} handler_valid=${handler.is_valid()} handler_kind=${handler.kind_name()}')
		return err
	}
	chain.app.bind_route_target_if_supported(target)
	method := value_subject(target).middleware_target_method(explicit_method)
	if method == 'process' && target.is_object()
		&& (target.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface')
		|| target.method_exists('process')) {
		target_obj := target.as_object() or { return error('Middleware target must be an object') }
		mut psr_payload := normalize_psr15_server_request(payload, chain.request_ctx.route_params)
		defer {
			psr_payload.release()
		}
		mut next_handler := (&chain).build_psr15_next_handler_object()
		if !next_handler.is_valid() {
			return error('Next handler object could not be created')
		}
		defer {
			next_handler.release()
		}
		mut result := target_obj.call_method(method, psr_payload, next_handler)
		defer {
			result.release()
		}
		normalized := VSlimPsr7Response.from_value(result)
		return normalized.to_vslim_response().to_value()
	}
	cli_debug_log('middleware.target.invalid method=${method} target_valid=${target.is_valid()} target_kind=${target.kind_name()} target_class=${target.class_name()}')
	return error('Middleware must implement Psr\\Http\\Server\\MiddlewareInterface')
}

fn (subject PhpValueSubject) is_supported_websocket_handler() bool {
	handler := subject.value
	if !handler.is_valid() {
		return false
	}
	if handler.is_callable() || handler.is_string() || handler.is_array() {
		return true
	}
	if !handler.is_object() {
		return false
	}
	return handler.method_exists('handleWebSocket') || handler.method_exists('onOpen')
		|| handler.method_exists('onMessage') || handler.method_exists('onClose')
		|| handler.method_exists('mount') || handler.method_exists('render')
		|| handler.method_exists('liveMarker')
}

fn (app &VSlimApp) dispatch_route_handler(handler vphp.PhpValue, payload vphp.PhpValue, route_params map[string]string) !vphp.PhpValue {
	if !handler.is_valid() {
		return error('Invalid route handler')
	}
	if handler.is_string() || handler.is_array() {
		target, method := app.resolve_route_target(handler)!
		app.bind_route_target_if_supported(target)
		mut psr_payload := normalize_psr15_server_request(payload, route_params)
		defer {
			psr_payload.release()
		}
		mut route_args := []vphp.PhpArgInput{}
		route_args << psr_payload
		mut result := value_subject(target).call_route_target_method(method, route_args)
		return value_subject(result).route_handler_response()
	}
	if value_subject(handler).is_psr15_request_handler() {
		mut psr_payload := normalize_psr15_server_request(payload, route_params)
		defer {
			psr_payload.release()
		}
		handler_obj := handler.as_object() or { return error('Route handler must be an object') }
		mut result := handler_obj.call_method('handle', psr_payload)
		return value_subject(result).route_handler_response()
	}
	mut psr_payload := normalize_psr15_server_request(payload, route_params)
	defer {
		psr_payload.release()
	}
	if callable := handler.as_callable() {
		mut result := callable.invoke(psr_payload)
		return value_subject(result).route_handler_response()
	}
	if handler_obj := handler.as_object() {
		if handler_obj.method_exists('handle') {
			return error('Route handler object must implement Psr\\Http\\Server\\RequestHandlerInterface')
		}
		if handler_obj.method_exists('mount') || handler_obj.method_exists('render') {
			effective_payload := if value_subject(payload).is_psr_server_request_payload() {
				value_subject(payload).legacy_middleware_payload(route_params)
			} else {
				payload.owned()
			}
			return dispatch_live_route_handler(handler_obj, effective_payload)!
		}
	}
	return error('Route handler is not callable')
}

fn (ctx PipelineRequestContext) with_current_request(request vphp.PhpValue) PipelineRequestContext {
	return ctx.with_payload_value(request)
}

fn (mut state Psr15NextHandlerState) dispatch_next(key u64, request vphp.PhpObject) &VSlimPsr7Response {
	return match state.mode {
		.middleware_chain {
			if state.chain_ref == unsafe { nil } {
				VSlimPsr7Response.text(500, 'Middleware chain is not available')
			} else {
				mut chain := state.chain_ref
				mut request_value := request.to_value()
				defer {
					request_value.release()
				}
				use_pre_normalized := is_psr_server_request_object(request)
					&& chain.request_ctx.route_params.len == 0
				mut raw := if use_pre_normalized {
					chain.dispatch_pre_normalized(request_value) or {
						msg := if err.msg() == '' {
							'Route handler is not callable'
						} else {
							err.msg()
						}
						error_ctx := chain.request_ctx.with_current_request(request_value)
						res := chain.app.run_error_handler_with_context_psr(error_ctx, 500, msg) or {
							chain.app.default_error_response_psr(500, msg, 'handler_not_callable')
						}
						return res
					}
				} else {
					chain.dispatch(request_value) or {
						msg := if err.msg() == '' {
							'Route handler is not callable'
						} else {
							err.msg()
						}
						error_ctx := chain.request_ctx.with_current_request(request_value)
						res := chain.app.run_error_handler_with_context_psr(error_ctx, 500, msg) or {
							chain.app.default_error_response_psr(500, msg, 'handler_not_callable')
						}
						return res
					}
				}
				defer {
					raw.release()
				}
				VSlimPsr7Response.from_value(raw)
			}
		}
		.fixed_response {
			if state.fixed_response_ref == unsafe { nil } {
				VSlimPsr7Response.text(500, 'Middleware fixed response is not available')
			} else {
				res := state.fixed_response_ref
				res.clone_with(res.get_protocol_version(),
					clone_header_values(res.headers), clone_header_names(res.header_names),
					res.body_or_empty(), res.get_status_code(), res.get_reason_phrase())
			}
		}
		.continue_marker {
			mut normalized := normalize_psr15_server_request_object(request, map[string]string{})
			if snapshot := snapshot_phase_forwarded_request(normalized) {
				store_forwarded_request_snapshot(key, snapshot)
			}
			normalized.release()
			state.has_forwarded_request = true
			VSlimPsr7Response.internal_phase_continue()
		}
	}
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handle']
pub fn (handler &VSlimPsr15NextHandler) handle(request vphp.PhpObject) &VSlimPsr7Response {
	unsafe {
		mut writable := &VSlimPsr15NextHandler(handler)
		res := writable.state.dispatch_next(forwarded_request_key(handler), request)
		if res == nil {
			return VSlimPsr7Response.text(500, 'Middleware next handler returned null')
		}
		cli_debug_log('next.handle result status=${res.get_status_code()} body_len=${psr7_stream_string(res.body_or_empty()).len}')
		return res.clone_with(res.get_protocol_version(),
			clone_header_values(res.headers), clone_header_names(res.header_names),
			res.body_or_empty(), res.get_status_code(), res.get_reason_phrase())
	}
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handle']
pub fn (handler &VSlimPsr15ContinueHandler) handle(request vphp.PhpObject) &VSlimPsr7Response {
	unsafe {
		mut writable := &VSlimPsr15ContinueHandler(handler)
		res := writable.state.dispatch_next(forwarded_request_key(handler), request)
		if res == nil {
			return VSlimPsr7Response.text(500, 'Middleware continue handler returned null')
		}
		return res.clone_with(res.get_protocol_version(),
			clone_header_values(res.headers), clone_header_names(res.header_names),
			res.body_or_empty(), res.get_status_code(), res.get_reason_phrase())
	}
}

fn (app &VSlimApp) resolve_container_service(service_id string) !vphp.PhpValue {
	if service_id == '' {
		return error('empty service id')
	}
	unsafe {
		mut mutable_app := &VSlimApp(app)
		if mutable_app.container_ref == nil {
			return error('container is not configured')
		}
		mut container := mutable_app.container_ref
		mut resolved := container.get_value(service_id) or {
			if !vphp.PhpClass.named(service_id).exists() {
				return error('container service not found')
			}
			mut created_obj := vphp.PhpClass.named(service_id).construct() or {
				return error('class "${service_id}" could not be instantiated')
			}
			mut created_value := created_obj.take_value()
			app.bind_cached_target_if_supported(created_value)
			container.set(service_id, created_value)
			out := created_value.owned()
			created_value.release()
			return out
		}
		return resolved
	}
}

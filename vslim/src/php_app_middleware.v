module main

import vphp

fn is_supported_route_handler(handler vphp.PhpValue) bool {
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

fn middleware_registration_error(kind MiddlewareRegistrationKind) string {
	return match kind {
		.standard { 'middleware must be a PSR-15 middleware registration' }
		.before { 'before middleware must be a PSR-15 middleware registration' }
		.after { 'after middleware must be a PSR-15 middleware registration' }
	}
}

fn is_supported_registration_kind(kind MiddlewareRegistrationKind, handler vphp.PhpValue) bool {
	return match kind {
		.standard { is_supported_middleware_registration(handler) }
		.before, .after { is_supported_phase_middleware_registration(handler) }
	}
}

fn register_app_middleware_kind(mut app VSlimApp, handler vphp.PhpValue, kind MiddlewareRegistrationKind) {
	if !is_supported_registration_kind(kind, handler) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			middleware_registration_error(kind), 0)
		return
	}
	if handler.is_object() {
		bind_cached_target_to_app_if_supported(&app, handler)
	}
	entry := handler.retain()
	if kind == .standard && app.php_middlewares.len == 0 {
		cli_debug_log('middleware.register kind=${entry.kind_name()} valid=${entry.is_valid()} null=${entry.is_null()} undef=${entry.is_undef()} handler_type=${handler.type_name()} handler_class=${handler.class_name()}')
	}
	match kind {
		.standard { app.php_middlewares << entry }
		.before { app.php_before_middlewares << entry }
		.after { app.php_after_middlewares << entry }
	}
}

fn register_group_middleware_kind(group &RouteGroup, handler vphp.PhpValue, kind MiddlewareRegistrationKind) {
	if !is_supported_registration_kind(kind, handler) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			middleware_registration_error(kind), 0)
		return
	}
	prefix := group.normalized_prefix()
	unsafe {
		mut app := &VSlimApp(group.app)
		if handler.is_object() {
			bind_cached_target_to_app_if_supported(app, handler)
		}
		match kind {
			.standard {
				app.php_group_middle.prefixes << prefix
				app.php_group_middle.handlers << handler.retain()
			}
			.before {
				app.php_group_before_middle.prefixes << prefix
				app.php_group_before_middle.handlers << handler.retain()
			}
			.after {
				app.php_group_after_middle.prefixes << prefix
				app.php_group_after_middle.handlers << handler.retain()
			}
		}
	}
}

fn bind_cached_target_to_app_if_supported(app &VSlimApp, target vphp.PhpValue) {
	if !target.is_valid() || !target.is_object() {
		return
	}
	if target.method_exists('setApp') {
		mut app_value := app_self_value(app)
		defer {
			app_value.release()
		}
		mut result := target.call_method('setApp', app_value)
		result.release()
	}
}

fn is_supported_php_middleware_handler(handler vphp.PhpValue) bool {
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

fn is_supported_middleware_registration(handler vphp.PhpValue) bool {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return false
	}
	if handler.is_string() || handler.is_array() {
		return true
	}
	return is_supported_php_middleware_handler(handler)
}

fn is_supported_phase_middleware_registration(handler vphp.PhpValue) bool {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return false
	}
	if handler.is_string() || handler.is_array() {
		return true
	}
	return is_supported_php_middleware_handler(handler)
}

fn is_psr15_middleware_handler(handler vphp.PhpValue) bool {
	return is_supported_php_middleware_handler(handler)
}

fn is_psr15_request_handler(handler vphp.PhpValue) bool {
	if !handler.is_valid() {
		return false
	}
	return handler.is_object()
		&& handler.is_instance_of('Psr\\Http\\Server\\RequestHandlerInterface')
}

fn is_psr_server_request_payload(payload vphp.PhpValue) bool {
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

fn collect_matching_route_hooks(table HookTable, path string) []vphp.PhpValue {
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

fn collect_standard_middlewares(app &VSlimApp, group_hooks []vphp.PhpValue) []vphp.PhpValue {
	mut out := []vphp.PhpValue{}
	for idx, hook in app.php_middlewares {
		cloned := hook.owned()
		if idx == 0 {
			slot_addr := unsafe { usize(&app.php_middlewares[idx]) }
			cli_debug_log('middleware.collect app idx=${idx} slot=${slot_addr} src_kind=${hook.kind_name()} src_valid=${hook.is_valid()} src_null=${hook.is_null()} src_undef=${hook.is_undef()} clone_valid=${cloned.is_valid()} clone_null=${cloned.is_null()} clone_undef=${cloned.is_undef()}')
		}
		out << cloned
	}
	for hook in group_hooks {
		out << hook.owned()
	}
	return out
}

fn collect_before_middlewares(app &VSlimApp, group_hooks []vphp.PhpValue) []vphp.PhpValue {
	mut out := []vphp.PhpValue{}
	for hook in app.php_before_middlewares {
		out << hook.owned()
	}
	for hook in group_hooks {
		out << hook.owned()
	}
	return out
}

fn collect_after_middlewares(app &VSlimApp, group_hooks []vphp.PhpValue) []vphp.PhpValue {
	mut out := []vphp.PhpValue{}
	for hook in app.php_after_middlewares {
		out << hook.owned()
	}
	for hook in group_hooks {
		out << hook.owned()
	}
	return out
}

fn legacy_middleware_payload(payload vphp.PhpValue, route_params map[string]string) vphp.PhpValue {
	if payload.is_valid() && payload.is_object()
		&& (payload.is_instance_of('VSlim\\VHttpd\\Request')
		|| payload.is_instance_of('VSlimRequest')) {
		return payload.owned()
	}
	req := new_vslim_request_from_psr_server_request(payload, route_params)
	return build_php_request_value(req, route_params)
}

fn middleware_target_method(target vphp.PhpValue, explicit_method string) string {
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

fn resolve_php_middleware_target(app &VSlimApp, handler vphp.PhpValue) !(vphp.PhpValue, string) {
	if !handler.is_valid() {
		return error('Middleware is not valid')
	}
	if handler.is_string() {
		if !app.has_container() {
			return error('Middleware container is not configured')
		}
		return resolve_container_service(app, handler.to_string())!, ''
	}
	if handler.is_array() {
		if !app.has_container() {
			return error('Middleware container is not configured')
		}
		parts := handler.to_string_list()
		if parts.len == 0 || parts[0] == '' {
			return error('Invalid middleware container array handler')
		}
		service := resolve_container_service(app, parts[0])!
		method := if parts.len >= 2 { parts[1] } else { '' }
		return service, method
	}
	return handler, ''
}

fn resolve_php_phase_middleware_target(app &VSlimApp, handler vphp.PhpValue) !vphp.PhpValue {
	target, explicit_method := resolve_php_middleware_target(app, handler)!
	method := middleware_target_method(target, explicit_method)
	if method != 'process' || !target.is_object()
		|| (!target.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface')
		&& !target.method_exists('process')) {
		return error('Phase middleware must implement Psr\\Http\\Server\\MiddlewareInterface')
	}
	return target
}

fn resolve_php_route_target(app &VSlimApp, handler vphp.PhpValue) !(vphp.PhpValue, string) {
	if !handler.is_valid() {
		return error('Invalid route handler')
	}
	if handler.is_string() {
		if !app.has_container() {
			return error('Route handler container is not configured')
		}
		target_value := resolve_container_service(app, handler.to_string())!
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
		target_value := resolve_container_service(app, parts[0])!
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

fn bind_route_target_to_app_if_supported(app &VSlimApp, target vphp.PhpValue) {
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
		mut app_value := app_self_value(app)
		defer {
			app_value.release()
		}
		mut result := target_obj.call_method('setApp', app_value)
		result.release()
	}
}

fn call_route_target_method(target vphp.PhpValue, method string, args []vphp.PhpArgInput) vphp.PhpValue {
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

fn route_handler_response(mut result vphp.PhpValue) vphp.PhpValue {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return result.owned()
	}
	res, ok := normalize_php_route_response_value(result)
	if ok {
		cli_debug_log('route.result normalized status=${res.status} body_len=${res.body.len} content_type=${res.content_type}')
		result.release()
		return build_php_response_value(res)
	}
	psr, psr_ok := normalize_php_route_response_psr_value(result)
	if psr_ok {
		cli_debug_log('route.result psr status=${psr.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(psr)).len}')
		result.release()
		return build_php_response_value(new_vslim_response_from_psr_response(psr))
	}
	return result.owned()
}

fn dispatch_php_middleware_entry(mut chain MiddlewareChain, handler vphp.PhpValue, payload vphp.PhpValue) !vphp.PhpValue {
	target, explicit_method := resolve_php_middleware_target(chain.app, handler) or {
		cli_debug_log('middleware.target.resolve.error msg=${err.msg()} handler_valid=${handler.is_valid()} handler_kind=${handler.kind_name()}')
		return err
	}
	bind_route_target_to_app_if_supported(chain.app, target)
	method := middleware_target_method(target, explicit_method)
	if method == 'process' && target.is_object()
		&& (target.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface')
		|| target.method_exists('process')) {
		target_obj := target.as_object() or { return error('Middleware target must be an object') }
		mut psr_payload := normalize_psr15_server_request(payload, chain.request_ctx.route_params)
		defer {
			psr_payload.release()
		}
		mut next_handler := build_php_psr15_next_handler_object(&chain)
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
		normalized := normalize_to_psr7_response_value(result)
		return build_php_response_value(new_vslim_response_from_psr_response(normalized))
	}
	cli_debug_log('middleware.target.invalid method=${method} target_valid=${target.is_valid()} target_kind=${target.kind_name()} target_class=${target.class_name()}')
	return error('Middleware must implement Psr\\Http\\Server\\MiddlewareInterface')
}

fn is_supported_websocket_handler(handler vphp.PhpValue) bool {
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

fn dispatch_route_handler(app &VSlimApp, handler vphp.PhpValue, payload vphp.PhpValue, route_params map[string]string) !vphp.PhpValue {
	if !handler.is_valid() {
		return error('Invalid route handler')
	}
	if handler.is_string() || handler.is_array() {
		target, method := resolve_php_route_target(app, handler)!
		bind_route_target_to_app_if_supported(app, target)
		mut psr_payload := normalize_psr15_server_request(payload, route_params)
		defer {
			psr_payload.release()
		}
		mut route_args := []vphp.PhpArgInput{}
		route_args << psr_payload
		mut result := call_route_target_method(target, method, route_args)
		return route_handler_response(mut result)
	}
	if is_psr15_request_handler(handler) {
		mut psr_payload := normalize_psr15_server_request(payload, route_params)
		defer {
			psr_payload.release()
		}
		handler_obj := handler.as_object() or { return error('Route handler must be an object') }
		mut result := handler_obj.call_method('handle', psr_payload)
		return route_handler_response(mut result)
	}
	mut psr_payload := normalize_psr15_server_request(payload, route_params)
	defer {
		psr_payload.release()
	}
	if callable := handler.as_callable() {
		mut result := callable.invoke(psr_payload)
		return route_handler_response(mut result)
	}
	if handler_obj := handler.as_object() {
		if handler_obj.method_exists('handle') {
			return error('Route handler object must implement Psr\\Http\\Server\\RequestHandlerInterface')
		}
		if handler_obj.method_exists('mount') || handler_obj.method_exists('render') {
			effective_payload := if is_psr_server_request_payload(payload) {
				legacy_middleware_payload(payload, route_params)
			} else {
				payload.owned()
			}
			return dispatch_live_route_handler(handler_obj, effective_payload)!
		}
	}
	return error('Route handler is not callable')
}

fn pipeline_request_context_from_current_request(ctx PipelineRequestContext, request vphp.PhpValue) PipelineRequestContext {
	return pipeline_request_context_with_payload_value(ctx, request)
}

fn dispatch_psr15_next_handler(mut state Psr15NextHandlerState, key u64, request vphp.PhpObject) &VSlimPsr7Response {
	return match state.mode {
		.middleware_chain {
			if state.chain_ref == unsafe { nil } {
				new_psr7_text_response(500, 'Middleware chain is not available')
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
						error_ctx := pipeline_request_context_from_current_request(chain.request_ctx,
							request_value)
						res := run_error_handler_with_context_psr(chain.app, error_ctx, 500, msg) or {
							default_error_response_psr(chain.app, 500, msg, 'handler_not_callable')
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
						error_ctx := pipeline_request_context_from_current_request(chain.request_ctx,
							request_value)
						res := run_error_handler_with_context_psr(chain.app, error_ctx, 500, msg) or {
							default_error_response_psr(chain.app, 500, msg, 'handler_not_callable')
						}
						return res
					}
				}
				defer {
					raw.release()
				}
				normalize_to_psr7_response_value(raw)
			}
		}
		.fixed_response {
			if state.fixed_response_ref == unsafe { nil } {
				new_psr7_text_response(500, 'Middleware fixed response is not available')
			} else {
				res := state.fixed_response_ref
				clone_psr7_response(res, res.get_protocol_version(),
					clone_header_values(res.headers), clone_header_names(res.header_names),
					response_body_or_empty(res), res.get_status_code(), res.get_reason_phrase())
			}
		}
		.continue_marker {
			mut normalized := normalize_psr15_server_request_object(request, map[string]string{})
			if snapshot := snapshot_phase_forwarded_request(normalized) {
				store_forwarded_request_snapshot(key, snapshot)
			}
			normalized.release()
			state.has_forwarded_request = true
			internal_phase_continue_response_psr()
		}
	}
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handle']
pub fn (handler &VSlimPsr15NextHandler) handle(request vphp.PhpObject) &VSlimPsr7Response {
	unsafe {
		mut writable := &VSlimPsr15NextHandler(handler)
		res := dispatch_psr15_next_handler(mut writable.state, forwarded_request_key(handler),
			request)
		if res == nil {
			return new_psr7_text_response(500, 'Middleware next handler returned null')
		}
		cli_debug_log('next.handle result status=${res.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(res)).len}')
		return clone_psr7_response(res, res.get_protocol_version(),
			clone_header_values(res.headers), clone_header_names(res.header_names),
			response_body_or_empty(res), res.get_status_code(), res.get_reason_phrase())
	}
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handle']
pub fn (handler &VSlimPsr15ContinueHandler) handle(request vphp.PhpObject) &VSlimPsr7Response {
	unsafe {
		mut writable := &VSlimPsr15ContinueHandler(handler)
		res := dispatch_psr15_next_handler(mut writable.state, forwarded_request_key(handler),
			request)
		if res == nil {
			return new_psr7_text_response(500, 'Middleware continue handler returned null')
		}
		return clone_psr7_response(res, res.get_protocol_version(),
			clone_header_values(res.headers), clone_header_names(res.header_names),
			response_body_or_empty(res), res.get_status_code(), res.get_reason_phrase())
	}
}

fn resolve_container_service(app &VSlimApp, service_id string) !vphp.PhpValue {
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
			bind_cached_target_to_app_if_supported(app, created_value)
			container.set(service_id, created_value)
			out := created_value.owned()
			created_value.release()
			return out
		}
		return resolved
	}
}

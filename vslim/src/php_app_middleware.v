module main

import vphp

fn is_supported_route_handler(handler vphp.RequestBorrowedZBox) bool {
	if !handler.is_valid() {
		return false
	}
	if handler.is_callable() || handler.is_string() || handler.is_array() {
		return true
	}
	raw := handler.to_zval()
	if !raw.is_object() {
		return false
	}
	return raw.is_instance_of('Psr\\Http\\Server\\RequestHandlerInterface')
		|| raw.method_exists('mount')
		|| raw.method_exists('render')
}

fn middleware_registration_error(kind MiddlewareRegistrationKind) string {
	return match kind {
		.standard { 'middleware must be a PSR-15 middleware registration' }
		.before { 'before middleware must be a PSR-15 middleware registration' }
		.after { 'after middleware must be a PSR-15 middleware registration' }
	}
}

fn is_supported_registration_kind(kind MiddlewareRegistrationKind, handler vphp.RequestBorrowedZBox) bool {
	return match kind {
		.standard { is_supported_middleware_registration(handler) }
		.before, .after { is_supported_phase_middleware_registration(handler) }
	}
}

fn register_app_middleware_kind(mut app VSlimApp, handler vphp.ZVal, kind MiddlewareRegistrationKind) {
	borrowed := vphp.RequestBorrowedZBox.from_zval(handler)
	if !is_supported_registration_kind(kind, borrowed) {
		vphp.throw_exception_class('InvalidArgumentException', middleware_registration_error(kind),
			0)
		return
	}
	entry := vphp.PersistentOwnedZBox.from_callable_zval(handler)
	match kind {
		.standard { app.php_middlewares << entry }
		.before { app.php_before_middlewares << entry }
		.after { app.php_after_middlewares << entry }
	}
}

fn register_group_middleware_kind(group &RouteGroup, handler vphp.ZVal, kind MiddlewareRegistrationKind) {
	borrowed := vphp.RequestBorrowedZBox.from_zval(handler)
	if !is_supported_registration_kind(kind, borrowed) {
		vphp.throw_exception_class('InvalidArgumentException', middleware_registration_error(kind),
			0)
		return
	}
	prefix := group.normalized_prefix()
	unsafe {
		mut app := &VSlimApp(group.app)
		match kind {
			.standard {
				app.php_group_middle.prefixes << prefix
				app.php_group_middle.handlers << vphp.PersistentOwnedZBox.from_callable_zval(handler)
			}
			.before {
				app.php_group_before_middle.prefixes << prefix
				app.php_group_before_middle.handlers << vphp.PersistentOwnedZBox.from_callable_zval(handler)
			}
			.after {
				app.php_group_after_middle.prefixes << prefix
				app.php_group_after_middle.handlers << vphp.PersistentOwnedZBox.from_callable_zval(handler)
			}
		}
	}
}

fn is_supported_php_middleware_handler(handler vphp.RequestBorrowedZBox) bool {
	if !handler.is_valid() {
		return false
	}
	raw := handler.to_zval()
	if !raw.is_object() {
		return false
	}
	if raw.is_instance_of('Closure') {
		return false
	}
	return raw.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface')
}

fn is_supported_middleware_registration(handler vphp.RequestBorrowedZBox) bool {
	if !handler.is_valid() || handler.to_zval().is_null() || handler.to_zval().is_undef() {
		return false
	}
	if handler.is_string() || handler.is_array() {
		return true
	}
	return is_supported_php_middleware_handler(handler)
}

fn is_supported_phase_middleware_registration(handler vphp.RequestBorrowedZBox) bool {
	if !handler.is_valid() || handler.to_zval().is_null() || handler.to_zval().is_undef() {
		return false
	}
	if handler.is_string() || handler.is_array() {
		return true
	}
	return is_supported_php_middleware_handler(handler)
}

fn is_psr15_middleware_handler(handler vphp.RequestBorrowedZBox) bool {
	return is_supported_php_middleware_handler(handler)
}

fn is_psr15_request_handler(handler vphp.RequestBorrowedZBox) bool {
	if !handler.is_valid() {
		return false
	}
	raw := handler.to_zval()
	return raw.is_object() && raw.is_instance_of('Psr\\Http\\Server\\RequestHandlerInterface')
}

fn is_psr_server_request_payload(payload vphp.RequestBorrowedZBox) bool {
	if !payload.is_valid() {
		return false
	}
	raw := payload.to_zval()
	return raw.is_object() && (raw.is_instance_of('Psr\\Http\\Message\\ServerRequestInterface')
		|| (raw.method_exists('getMethod') && raw.method_exists('getUri')))
}

fn collect_matching_route_hooks(table HookTable, path string) []vphp.RequestOwnedZBox {
	mut out := []vphp.RequestOwnedZBox{}
	for i, prefix in table.prefixes {
		if path_has_prefix(path, prefix) && i < table.handlers.len {
			out << table.handlers[i].clone_request_owned()
		}
	}
	return out
}

fn collect_registered_middlewares(app_hooks []vphp.PersistentOwnedZBox, group_hooks []vphp.RequestOwnedZBox) []vphp.RequestOwnedZBox {
	mut out := []vphp.RequestOwnedZBox{}
	for hook in app_hooks {
		out << hook.clone_request_owned()
	}
	for hook in group_hooks {
		out << hook.borrowed().clone_request_owned()
	}
	return out
}

fn legacy_middleware_payload(payload vphp.RequestBorrowedZBox, route_params map[string]string) vphp.ZVal {
	if payload.is_valid() && payload.to_zval().is_object()
		&& (payload.to_zval().is_instance_of('VSlim\\Vhttpd\\Request')
		|| payload.to_zval().is_instance_of('VSlimRequest')) {
		return payload.to_zval()
	}
	req := new_vslim_request_from_psr_server_request(payload, route_params)
	return build_php_request_object(req, route_params)
}

fn middleware_target_method(target vphp.ZVal, explicit_method string) string {
	method := explicit_method.trim_space()
	if method != '' {
		return method
	}
	if target.is_object() && target.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface') {
		return 'process'
	}
	if target.is_object() && target.method_exists('__invoke') {
		return '__invoke'
	}
	return ''
}

fn resolve_php_middleware_target(app &VSlimApp, handler vphp.RequestBorrowedZBox) !(vphp.ZVal, string) {
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
	return handler.to_zval(), ''
}

fn resolve_php_phase_middleware_target(app &VSlimApp, handler vphp.RequestBorrowedZBox) !vphp.ZVal {
	target, explicit_method := resolve_php_middleware_target(app, handler)!
	method := middleware_target_method(target, explicit_method)
	if method != 'process' || !target.is_object()
		|| !target.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface') {
		return error('Phase middleware must implement Psr\\Http\\Server\\MiddlewareInterface')
	}
	return target
}

fn resolve_php_route_target(app &VSlimApp, handler vphp.RequestBorrowedZBox) !(vphp.ZVal, string) {
	if !handler.is_valid() {
		return error('Invalid route handler')
	}
	if handler.is_string() {
		if !app.has_container() {
			return error('Route handler container is not configured')
		}
		target := resolve_container_service(app, handler.to_string())!
		if !target.is_object() {
			return error('Route handler service "${handler.to_string()}" must be an object')
		}
		if target.is_instance_of('Psr\\Http\\Server\\RequestHandlerInterface') {
			return target, 'handle'
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
		target := resolve_container_service(app, parts[0])!
		if !target.is_object() {
			return error('Route handler service "${parts[0]}" must be an object')
		}
		if !target.method_exists(parts[1]) {
			return error('Container service "${parts[0]}" has no method "${parts[1]}"')
		}
		return target, parts[1]
	}
	return handler.to_zval(), ''
}

fn bind_route_target_to_app_if_supported(app &VSlimApp, target vphp.ZVal) {
	if !target.is_valid() || !target.is_object() {
		return
	}
	if target.is_instance_of('VSlim\\Controller') {
		if target.method_exists('set_app') {
			vphp.with_method_result_zval(target, 'set_app', [wrap_runtime_app_zval(app)], fn (_ vphp.ZVal) bool {
				return true
			})
			return
		}
		if target.method_exists('setApp') {
			vphp.with_method_result_zval(target, 'setApp', [wrap_runtime_app_zval(app)], fn (_ vphp.ZVal) bool {
				return true
			})
		}
		return
	}
	if target.method_exists('setApp') {
		vphp.with_method_result_zval(target, 'setApp', [wrap_runtime_app_zval(app)], fn (_ vphp.ZVal) bool {
			return true
		})
	}
}

fn call_route_target_method(target vphp.ZVal, method string, args []vphp.ZVal) vphp.RequestOwnedZBox {
	return vphp.method_request_owned_box(target, method, args)
}

fn dispatch_php_middleware_entry(mut chain MiddlewareChain, handler vphp.RequestBorrowedZBox, payload vphp.RequestBorrowedZBox) !vphp.ZVal {
	target, explicit_method := resolve_php_middleware_target(chain.app, handler)!
	method := middleware_target_method(target, explicit_method)
	if method == 'process' && target.is_object()
		&& target.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface') {
		psr_payload := normalize_psr15_server_request_payload(payload, chain.request_ctx.route_params)
		mut next_handler := vphp.RequestOwnedZBox.from_zval(build_php_psr15_next_handler_object(&chain))
		defer {
			next_handler.release()
		}
		mut result := vphp.method_request_owned_box(target, method, [psr_payload, next_handler.to_zval()])
		defer {
			result.release()
		}
		normalized := normalize_to_psr7_response(result.to_zval())
		return build_php_psr7_response_object(normalized)
	}
	return error('Middleware must implement Psr\\Http\\Server\\MiddlewareInterface')
}

fn is_supported_websocket_handler(handler vphp.RequestBorrowedZBox) bool {
	if !handler.is_valid() {
		return false
	}
	raw := handler.to_zval()
	if handler.is_callable() || handler.is_string() || handler.is_array() {
		return true
	}
	if !raw.is_object() {
		return false
	}
	return raw.method_exists('handle_websocket') || raw.method_exists('on_open')
		|| raw.method_exists('on_message') || raw.method_exists('on_close')
		|| raw.method_exists('mount') || raw.method_exists('render')
		|| raw.method_exists('live_marker')
}

fn dispatch_route_handler(app &VSlimApp, handler vphp.RequestBorrowedZBox, payload vphp.RequestBorrowedZBox, route_params map[string]string) !vphp.ZVal {
	if !handler.is_valid() {
		return error('Invalid route handler')
	}
	if handler.is_string() || handler.is_array() {
		target, method := resolve_php_route_target(app, handler)!
		bind_route_target_to_app_if_supported(app, target)
		psr_payload := normalize_psr15_server_request_payload(payload, route_params)
		mut result := call_route_target_method(target, method, [psr_payload])
		return result.take_zval()
	}
	if is_psr15_request_handler(handler) {
		psr_payload := normalize_psr15_server_request_payload(payload, route_params)
		mut result := vphp.method_request_owned_box(handler.to_zval(), 'handle', [psr_payload])
		return result.take_zval()
	}
	psr_payload := normalize_psr15_server_request_payload(payload, route_params)
	if handler.is_callable() {
		mut result := vphp.call_request_owned_box(handler.to_zval(), [psr_payload])
		return result.take_zval()
	}
	raw := handler.to_zval()
	if raw.is_object() {
		if raw.method_exists('handle') {
			return error('Route handler object must implement Psr\\Http\\Server\\RequestHandlerInterface')
		}
		if raw.method_exists('mount') || raw.method_exists('render') {
			effective_payload := if is_psr_server_request_payload(payload) {
				vphp.RequestBorrowedZBox.from_zval(legacy_middleware_payload(payload, route_params))
			} else {
				payload
			}
			return dispatch_live_route_handler(raw, effective_payload)
		}
	}
	return error('Route handler is not callable')
}

fn dispatch_psr15_next_handler(mut state Psr15NextHandlerState, key u64, request vphp.ZVal) &VSlimPsr7Response {
	request_borrowed := vphp.RequestBorrowedZBox.from_zval(request)
	return match state.mode {
		.middleware_chain {
			if state.chain_ref == unsafe { nil } {
				new_psr7_text_response(500, 'Middleware chain is not available')
			} else {
				mut chain := state.chain_ref
				raw := chain.dispatch(request_borrowed) or {
					msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
					res := run_error_handler_with_context_psr(chain.app, chain.request_ctx, 500, msg) or {
						default_error_response_psr(chain.app, 500, msg, 'handler_not_callable')
					}
					return res
				}
				normalize_to_psr7_response(raw)
			}
		}
		.fixed_response {
			if state.fixed_response_ref == unsafe { nil } {
				new_psr7_text_response(500, 'Middleware fixed response is not available')
			} else {
				res := state.fixed_response_ref
				clone_psr7_response(res, res.get_protocol_version(), res.headers.clone(),
					clone_header_names(res.header_names), response_body_or_empty(res), res.get_status_code(),
					res.get_reason_phrase())
			}
		}
		.continue_marker {
			normalized := normalize_psr15_server_request_payload(request_borrowed, map[string]string{})
			if snapshot := snapshot_phase_forwarded_request(vphp.RequestBorrowedZBox.from_zval(normalized)) {
				store_forwarded_request_snapshot(key, snapshot)
			}
			state.has_forwarded_request = true
			internal_phase_continue_response_psr()
		}
	}
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'handle']
pub fn (handler &VSlimPsr15NextHandler) handle(request vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	unsafe {
		mut writable := &VSlimPsr15NextHandler(handler)
		return dispatch_psr15_next_handler(mut writable.state, forwarded_request_key(handler),
			request.to_zval())
	}
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'handle']
pub fn (handler &VSlimPsr15ContinueHandler) handle(request vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	unsafe {
		mut writable := &VSlimPsr15ContinueHandler(handler)
		return dispatch_psr15_next_handler(mut writable.state, forwarded_request_key(handler),
			request.to_zval())
	}
}

fn resolve_container_service(app &VSlimApp, service_id string) !vphp.ZVal {
	if service_id == '' {
		return error('empty service id')
	}
	unsafe {
		mut mutable_app := &VSlimApp(app)
		if mutable_app.container_ref == nil {
			return error('container is not configured')
		}
		mut container := mutable_app.container_ref
		resolved := container.get_entry(service_id) or {
			if !vphp.class_exists(service_id) {
				return error('container service not found')
			}
			created := vphp.php_class(service_id).construct([])
			if !created.is_valid() || !created.is_object() {
				return error('class "${service_id}" could not be instantiated')
			}
			container.set(service_id, vphp.borrow_zbox(created))
			return created
		}
		return resolved.to_zval()
	}
}

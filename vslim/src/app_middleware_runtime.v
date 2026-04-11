module main

import vphp

fn build_php_psr15_next_handler_object(chain &MiddlewareChain) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZBox.new_null().to_zval()
		bound := &VSlimPsr15NextHandler{
			state: Psr15NextHandlerState{
				mode:      .middleware_chain
				chain_ref: chain
			}
		}
		vphp.return_owned_object_raw(payload.raw, bound, C.vslim__psr15__nexthandler_ce,
			&C.vphp_class_handlers(vslimpsr15nexthandler_handlers()))
		return payload
	}
}

fn build_php_psr15_fixed_response_handler_object(res &VSlimPsr7Response) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZBox.new_null().to_zval()
		bound := &VSlimPsr15NextHandler{
			state: Psr15NextHandlerState{
				mode:               .fixed_response
				fixed_response_ref: res
			}
		}
		vphp.return_owned_object_raw(payload.raw, bound, C.vslim__psr15__nexthandler_ce,
			&C.vphp_class_handlers(vslimpsr15nexthandler_handlers()))
		return payload
	}
}

fn dispatch_php_middleware_chain(app &VSlimApp, path string, payload vphp.RequestBorrowedZBox, route_middle []vphp.RequestOwnedZBox, route_handler vphp.PersistentOwnedZBox, resource_action string, resource_missing_handler vphp.PersistentOwnedZBox, route_params map[string]string) !(vphp.ZVal, vphp.RequestOwnedZBox) {
	return dispatch_php_middleware_chain_with_plan(app, path, payload, route_middle, RawDispatchPlan{
		route_params:             snapshot_string_map(route_params)
		route_handler:            route_handler.clone()
		resource_action:          resource_action
		resource_missing_handler: resource_missing_handler.clone()
	})
}

fn dispatch_php_middleware_chain_terminal(app &VSlimApp, path string, payload vphp.RequestBorrowedZBox, route_middle []vphp.RequestOwnedZBox, route_params map[string]string, terminal_meta MiddlewareTerminalMeta) !(vphp.ZVal, vphp.RequestOwnedZBox) {
	return dispatch_php_middleware_chain_with_plan(app, path, payload, route_middle, RawDispatchPlan{
		route_params:  snapshot_string_map(route_params)
		terminal_meta: terminal_meta
	})
}

fn dispatch_php_middleware_chain_with_plan(app &VSlimApp, path string, payload vphp.RequestBorrowedZBox, route_middle []vphp.RequestOwnedZBox, plan RawDispatchPlan) !(vphp.ZVal, vphp.RequestOwnedZBox) {
	request_ctx := new_pipeline_request_context(path, payload.clone_request_owned(), plan.route_params)
	return dispatch_php_middleware_chain_with_context(app, request_ctx, route_middle, plan)
}

fn dispatch_php_middleware_chain_with_context(app &VSlimApp, ctx PipelineRequestContext, route_middle []vphp.RequestOwnedZBox, plan RawDispatchPlan) !(vphp.ZVal, vphp.RequestOwnedZBox) {
	if app.php_middlewares.len == 0 && route_middle.len == 0 {
		return execute_raw_dispatch_plan(app, ctx, plan)!,
			ctx.payload_ref.clone_request_owned()
	}
	mut chain_plan := clone_raw_dispatch_plan(plan)
	defer {
		release_raw_dispatch_plan(mut chain_plan)
	}
	mut chain := &MiddlewareChain{
		app:         app
		request_ctx: ctx
		middlewares: collect_standard_middlewares(app, route_middle)
		plan:        chain_plan
	}
	defer {
		vphp.release_persistent_boxes(mut chain.middlewares)
	}
	raw := chain.dispatch(ctx.payload_ref.borrowed()) or {
		msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
		mut error_payload := ctx.payload_ref.clone_request_owned()
		if forwarded_request := take_forwarded_request_snapshot(forwarded_request_key(chain)) {
			error_payload = vphp.RequestOwnedZBox.from_zval(request_with_forwarded_snapshot(ctx.payload_ref.borrowed(),
				ctx.route_params, forwarded_request))
		}
		error_ctx := pipeline_request_context_with_payload(ctx, error_payload)
		res := error_response_from_context(app, error_ctx, 500, msg, 'handler_not_callable')
		return build_php_response_object(res), error_payload.clone_request_owned()
	}
	cli_debug_log('middleware.chain.raw type=${raw.type_name()} class=${raw.class_name()} valid=${raw.is_valid()} null=${raw.is_null()} undef=${raw.is_undef()}')
	if forwarded_request := take_forwarded_request_snapshot(forwarded_request_key(chain)) {
		return raw, vphp.RequestOwnedZBox.from_zval(request_with_forwarded_snapshot(ctx.payload_ref.borrowed(),
			ctx.route_params, forwarded_request))
	}
	return raw, ctx.payload_ref.clone_request_owned()
}

fn (mut chain MiddlewareChain) dispatch(payload vphp.RequestBorrowedZBox) !vphp.ZVal {
	normalized := normalize_psr15_server_request_payload(payload, chain.request_ctx.route_params)
	if snapshot := snapshot_phase_forwarded_request(vphp.RequestBorrowedZBox.from_zval(normalized)) {
		store_forwarded_request_snapshot(forwarded_request_key(chain), snapshot)
	}
	effective_ctx := pipeline_request_context_with_payload(chain.request_ctx,
		payload.clone_request_owned())
	if chain.index >= chain.middlewares.len {
		return execute_raw_dispatch_plan(chain.app, effective_ctx, chain.plan)!
	}
	mw := chain.middlewares[chain.index]
	chain.index++
	if !mw.is_valid() || mw.is_null() || mw.is_undef() {
		cli_debug_log('middleware.invalid idx=${chain.index - 1} kind=${mw.kind_name()} valid=${mw.is_valid()} null=${mw.is_null()} undef=${mw.is_undef()} total=${chain.middlewares.len}')
		return error('Middleware is not valid')
	}
	mut mw_req := mw.clone_request_owned()
	defer {
		mw_req.release()
	}
	if !mw_req.is_valid() || mw_req.is_null() || mw_req.is_undef() {
		cli_debug_log('middleware.req.invalid idx=${chain.index - 1} valid=${mw_req.is_valid()} null=${mw_req.is_null()} undef=${mw_req.is_undef()} kind=${mw.kind_name()}')
	}
	raw := dispatch_php_middleware_entry(mut chain, mw_req.borrowed(), payload)!
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('Middleware must return a response')
	}
	return raw
}

fn (mut chain MiddlewareChain) dispatch_pre_normalized(payload vphp.RequestBorrowedZBox) !vphp.ZVal {
	if snapshot := snapshot_phase_forwarded_request(payload) {
		store_forwarded_request_snapshot(forwarded_request_key(chain), snapshot)
	}
	effective_ctx := pipeline_request_context_with_payload(chain.request_ctx,
		payload.clone_request_owned())
	if chain.index >= chain.middlewares.len {
		return execute_raw_dispatch_plan(chain.app, effective_ctx, chain.plan)!
	}
	mw := chain.middlewares[chain.index]
	chain.index++
	if !mw.is_valid() || mw.is_null() || mw.is_undef() {
		return error('Middleware is not valid')
	}
	mut mw_req := mw.clone_request_owned()
	defer {
		mw_req.release()
	}
	raw := dispatch_php_middleware_entry(mut chain, mw_req.borrowed(), payload)!
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('Middleware must return a response')
	}
	return raw
}

fn dispatch_php_after_phase_middleware_psr(app &VSlimApp, ctx PipelineRequestContext, hook vphp.PersistentOwnedZBox, current &VSlimPsr7Response) !vphp.ZVal {
	next_handler := build_php_psr15_fixed_response_handler_object(current)
	if !hook.is_valid() || hook.is_null() || hook.is_undef() {
		return error('Middleware is not valid')
	}
	mut hook_req := hook.clone_request_owned()
	defer {
		hook_req.release()
	}
	return dispatch_php_phase_middleware_raw(app, ctx.payload_ref.borrowed(), ctx.route_params,
		hook_req.borrowed(), next_handler)
}

fn apply_php_after_middlewares(app &VSlimApp, ctx PipelineRequestContext, initial VSlimResponse) VSlimResponse {
	cli_debug_log('after.input vslim status=${initial.status} body_len=${initial.body.len}')
	initial_psr := new_psr7_response_from_vslim_response(initial)
	cli_debug_log('after.input psr status=${initial_psr.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(initial_psr)).len}')
	psr := apply_php_after_middlewares_psr(app, ctx, initial_psr)
	cli_debug_log('after.psr final status=${psr.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(psr)).len}')
	res := new_vslim_response_from_psr_response(psr)
	cli_debug_log('after.vslim final status=${res.status} body_len=${res.body.len}')
	return res
}

fn apply_php_after_middlewares_psr(app &VSlimApp, ctx PipelineRequestContext, initial &VSlimPsr7Response) &VSlimPsr7Response {
	group_after := matching_group_after_middlewares(app, ctx.path)
	if app.php_after_middlewares.len == 0 && group_after.len == 0 {
		return initial
	}
	mut current := unsafe { initial }
	mut all := collect_after_middlewares(app, group_after)
	defer {
		vphp.release_persistent_boxes(mut all)
	}
	for hook in all {
		if !hook.is_valid() || hook.is_null() || hook.is_undef() {
			return error_response_from_context_psr(app, ctx, 500, 'Middleware is not valid',
				'handler_not_callable')
		}
		mut hook_req := hook.clone_request_owned()
		resolve_php_phase_middleware_target(app, hook_req.borrowed()) or {
			hook_req.release()
			msg := if err.msg() == '' {
				'Phase middleware must implement Psr\\Http\\Server\\MiddlewareInterface'
			} else {
				err.msg()
			}
			return error_response_from_context_psr(app, ctx, 500, msg, 'handler_not_callable')
		}
		hook_req.release()
		raw := dispatch_php_after_phase_middleware_psr(app, ctx, hook, current) or {
			msg := if err.msg() == '' { 'Middleware is not callable' } else { err.msg() }
			return error_response_from_context_psr(app, ctx, 500, msg, 'handler_not_callable')
		}
		raw_borrowed := vphp.RequestBorrowedZBox.from_zval(raw)
		if raw.is_object() && raw.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
			psr := normalize_to_psr7_response(raw)
			cli_debug_log('after.raw psr status=${psr.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(psr)).len}')
		}
		res, ok := normalize_php_route_response_psr_borrowed(raw_borrowed)
		if ok {
			cli_debug_log('after.normalized psr status=${res.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(res)).len}')
			current = res
			continue
		}
		current = error_response_from_context_psr(app, ctx, 500, 'Invalid route response',
			'invalid_response')
	}
	return current
}

fn finalize_php_response(app &VSlimApp, ctx PipelineRequestContext, initial VSlimResponse) VSlimResponse {
	return apply_php_after_middlewares(app, ctx, initial)
}

fn finalize_php_response_psr(app &VSlimApp, ctx PipelineRequestContext, initial &VSlimPsr7Response) &VSlimPsr7Response {
	return apply_php_after_middlewares_psr(app, ctx, initial)
}

fn request_with_method(req &VSlimRequest, method string) VSlimRequest {
	mut out := snapshot_vslim_request(req)
	out.method = method.clone()
	return out
}

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

fn dispatch_php_middleware_chain(app &VSlimApp, path string, payload vphp.BorrowedZVal, route_middle []vphp.RequestOwnedZBox, route_handler vphp.PersistentOwnedZVal, resource_action string, resource_missing_handler vphp.PersistentOwnedZVal, route_params map[string]string) !(vphp.ZVal, vphp.RequestOwnedZBox) {
	return dispatch_php_middleware_chain_with_plan(app, path, payload, route_middle, RawDispatchPlan{
		route_params:             route_params.clone()
		route_handler:            route_handler.clone_persistent_owned()
		resource_action:          resource_action
		resource_missing_handler: resource_missing_handler.clone_persistent_owned()
	})
}

fn dispatch_php_middleware_chain_terminal(app &VSlimApp, path string, payload vphp.BorrowedZVal, route_middle []vphp.RequestOwnedZBox, route_params map[string]string, terminal_meta MiddlewareTerminalMeta) !(vphp.ZVal, vphp.RequestOwnedZBox) {
	return dispatch_php_middleware_chain_with_plan(app, path, payload, route_middle, RawDispatchPlan{
		route_params:  route_params.clone()
		terminal_meta: terminal_meta
	})
}

fn dispatch_php_middleware_chain_with_plan(app &VSlimApp, path string, payload vphp.BorrowedZVal, route_middle []vphp.RequestOwnedZBox, plan RawDispatchPlan) !(vphp.ZVal, vphp.RequestOwnedZBox) {
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
		middlewares: collect_registered_middlewares(app.php_middlewares, route_middle)
		plan:        chain_plan
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
	if forwarded_request := take_forwarded_request_snapshot(forwarded_request_key(chain)) {
		return raw, vphp.RequestOwnedZBox.from_zval(request_with_forwarded_snapshot(ctx.payload_ref.borrowed(),
			ctx.route_params, forwarded_request))
	}
	return raw, ctx.payload_ref.clone_request_owned()
}

fn (mut chain MiddlewareChain) dispatch(payload vphp.BorrowedZVal) !vphp.ZVal {
	normalized := normalize_psr15_server_request_payload(payload, chain.request_ctx.route_params)
	if snapshot := snapshot_phase_forwarded_request(vphp.BorrowedZVal.from_zval(normalized)) {
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
	raw := dispatch_php_middleware_entry(mut chain, mw.borrowed(),
		payload)!
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('Middleware must return a response')
	}
	return raw
}

fn new_fixed_terminal_phase_chain(app &VSlimApp, ctx PipelineRequestContext, current VSlimResponse) &MiddlewareChain {
	return &MiddlewareChain{
		app:         app
		request_ctx: ctx
		middlewares: []vphp.RequestOwnedZBox{}
		plan:        RawDispatchPlan{
			route_params:  ctx.route_params.clone()
			terminal_meta: fixed_terminal_meta(current)
		}
		index:       0
	}
}

fn dispatch_php_after_phase_middleware(app &VSlimApp, ctx PipelineRequestContext, hook vphp.RequestOwnedZBox, current VSlimResponse) !vphp.ZVal {
	mut chain := new_fixed_terminal_phase_chain(app, ctx, current)
	next_handler := build_php_psr15_next_handler_object(chain)
	if !hook.is_valid() || hook.is_null() || hook.is_undef() {
		return error('Middleware is not valid')
	}
	return dispatch_php_phase_middleware_raw(app, ctx.payload_ref.borrowed(), ctx.route_params, hook.borrowed(),
		next_handler)
}

fn apply_php_after_middlewares(app &VSlimApp, ctx PipelineRequestContext, initial VSlimResponse) VSlimResponse {
	group_after := matching_group_after_middlewares(app, ctx.path)
	if app.php_after_middlewares.len == 0 && group_after.len == 0 {
		return initial
	}
	mut current := initial
	all := collect_registered_middlewares(app.php_after_middlewares, group_after)
	for hook in all {
		if !hook.is_valid() || hook.is_null() || hook.is_undef() {
			return error_response_from_context(app, ctx, 500, 'Middleware is not valid',
				'handler_not_callable')
		}
		resolve_php_phase_middleware_target(app, hook.borrowed()) or {
			msg := if err.msg() == '' {
				'Phase middleware must implement Psr\\Http\\Server\\MiddlewareInterface'
			} else {
				err.msg()
			}
			return error_response_from_context(app, ctx, 500, msg, 'handler_not_callable')
		}
		raw := dispatch_php_after_phase_middleware(app, ctx, hook, current) or {
			msg := if err.msg() == '' { 'Middleware is not callable' } else { err.msg() }
			return error_response_from_context(app, ctx, 500, msg, 'handler_not_callable')
		}
		raw_borrowed := vphp.BorrowedZVal.from_zval(raw)
		res, ok := normalize_php_route_response_borrowed(raw_borrowed)
		if ok {
			current = res
			continue
		}
		current = error_response_from_context(app, ctx, 500, 'Invalid route response',
			'invalid_response')
	}
	return current
}

fn finalize_php_response(app &VSlimApp, ctx PipelineRequestContext, initial VSlimResponse) VSlimResponse {
	return apply_php_after_middlewares(app, ctx, initial)
}

fn request_with_method(req &VSlimRequest, method string) VSlimRequest {
	return VSlimRequest{
		method:           method
		raw_path:         req.raw_path
		path:             req.path
		body:             req.body
		query_string:     req.query_string
		scheme:           req.scheme
		host:             req.host
		port:             req.port
		protocol_version: req.protocol_version
		remote_addr:      req.remote_addr
		query:            req.query.clone()
		headers:          req.headers.clone()
		cookies:          req.cookies.clone()
		attributes:       req.attributes.clone()
		server:           req.server.clone()
		uploaded_files:   req.uploaded_files.clone()
		params:           req.params.clone()
	}
}

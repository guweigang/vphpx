module appx

import httpx
import middlewarex
import vphp

fn (ctx PipelineRequestContext) with_current_request(request vphp.PhpValue) PipelineRequestContext {
	return ctx.with_payload_value(request)
}

fn dispatch_psr15_next_handler(mut state middlewarex.Psr15NextHandlerState, key u64, request vphp.PhpObject) &httpx.VSlimPsr7Response {
	return match state.mode {
		.middleware_chain {
			if state.chain_ref == unsafe { nil } {
				httpx.VSlimPsr7Response.text(500, 'Middleware chain is not available')
			} else {
				mut chain := unsafe { &MiddlewareChain(state.chain_ref) }
				mut request_value := request.to_value()
				defer {
					request_value.release()
				}
				use_pre_normalized := httpx.is_psr_server_request_object(request)
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
				psr, psr_ok := httpx.VSlimPsr7Response.from_route_result(raw)
				if psr_ok {
					psr
				} else {
					httpx.VSlimPsr7Response.from_value(raw)
				}
			}
		}
		.fixed_response {
			if state.fixed_response_ref == unsafe { nil } {
				httpx.VSlimPsr7Response.text(500, 'Middleware fixed response is not available')
			} else {
				res := state.fixed_response_ref
				res.clone_with(res.get_protocol_version(), httpx.clone_header_values(res.headers),
					httpx.clone_header_names(res.header_names), res.body_or_empty(),
					res.get_status_code(), res.get_reason_phrase())
			}
		}
		.continue_marker {
			mut normalized := httpx.normalize_psr15_server_request_object(request,
				map[string]string{})
			if snapshot := middlewarex.snapshot_phase_forwarded_request(normalized) {
				middlewarex.store_forwarded_request_snapshot(key, snapshot)
			}
			normalized.release()
			state.has_forwarded_request = true
			middlewarex.phase_continue_response()
		}
	}
}

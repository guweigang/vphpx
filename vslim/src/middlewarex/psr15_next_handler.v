module middlewarex

import httpx
import vphp

pub fn dispatch_psr15_next_handler(mut state Psr15NextHandlerState, request vphp.PhpObject) &httpx.VSlimPsr7Response {
	return match state.mode {
		.middleware_chain {
			if state.chain_ref == unsafe { nil } {
				httpx.VSlimPsr7Response.text(500, 'Middleware chain is not available')
			} else {
				mut chain := state.chain_ref
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
						res := chain.on_error(chain.app_ctx, error_ctx, msg)
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
						res := chain.on_error(chain.app_ctx, error_ctx, msg)
						return res
					}
				}
				defer {
					raw.release()
				}
				options := chain.request_ctx.response_import
				psr, psr_ok := httpx.VSlimPsr7Response.from_route_result(raw, options)
				if psr_ok {
					psr
				} else {
					httpx.VSlimPsr7Response.from_value(raw, options)
				}
			}
		}
		.fixed_response {
			if state.fixed_response_ref == unsafe { nil } {
				httpx.VSlimPsr7Response.text(500, 'Middleware fixed response is not available')
			} else {
				res := state.fixed_response_ref
				res.clone_with(res.get_protocol_version(), httpx.clone_header_values(res.headers),
					httpx.clone_header_names(res.header_names), res.body_ref,
					res.get_status_code(), res.get_reason_phrase())
			}
		}
		.continue_marker {
			state.forwarded_request.release()
			state.forwarded_request = httpx.normalize_psr15_server_request_object(request,
				map[string]string{})
			phase_continue_response()
		}
	}
}

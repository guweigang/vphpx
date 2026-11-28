module middlewarex

import httpx
import vphp

pub struct VSlimBeforeMiddlewareResult {
pub:
	response_ref vphp.PhpValue = vphp.PhpValue.null()
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
}

pub struct PhaseMiddlewareDispatchResult {
pub:
	response_ref vphp.PhpValue = vphp.PhpValue.null()
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
	continued    bool
}

fn is_internal_phase_continue_response(result vphp.PhpValue) bool {
	res, ok := httpx.VSlimPsr7Response.from_route_result(result, defer_body: true)
	if !ok {
		return false
	}
	return res.get_status_code() == 299 && res.get_header_line_name('x-vslim-continue') == '1'
}

pub fn PhaseMiddlewareDispatchResult.from_before(payload vphp.PhpValue, route_params map[string]string, cont &VSlimPsr15ContinueHandler, response vphp.PhpValue) PhaseMiddlewareDispatchResult {
	continued := cont.state.forwarded_request.is_valid() && is_internal_phase_continue_response(response)
	mut response_owner := response
	scoped_response := if response_owner.is_borrowed() {
		response_owner
	} else {
		response_owner.move_to_request_scope()
	}
	if continued {
		mut request := httpx.normalize_psr15_server_request_object(cont.state.forwarded_request, route_params)
		defer { request.release() }
		return PhaseMiddlewareDispatchResult{
			response_ref: scoped_response
			payload_ref:  request.to_borrowed().to_value().to_request_scoped()
			continued:    true
		}
	}
	return PhaseMiddlewareDispatchResult{
		response_ref: scoped_response
		payload_ref:  payload.to_request_scoped()
	}
}

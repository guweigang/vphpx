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
	res, ok := httpx.VSlimResponse.from_route_result(result)
	if !ok {
		return false
	}
	return res.status == 299 && (res.headers['x-vslim-continue'] or { '' }) == '1'
}

pub fn PhaseMiddlewareDispatchResult.from_before(payload vphp.PhpValue, route_params map[string]string, cont &VSlimPsr15ContinueHandler, response vphp.PhpValue) PhaseMiddlewareDispatchResult {
	continued := cont.state.has_forwarded_request && is_internal_phase_continue_response(response)
	return PhaseMiddlewareDispatchResult{
		response_ref: response.owned()
		payload_ref:  continued_phase_request_value(payload, route_params, cont)
		continued:    continued
	}
}

module httpx

import vphp

pub fn route_dispatch_payload(req &VSlimRequest, source_payload vphp.PhpValue, params map[string]string) (vphp.PhpValue, VSlimRequest) {
	if is_psr_server_request_payload(source_payload) {
		mut psr_payload := normalize_psr15_server_request_value(source_payload, params)
		defer { psr_payload.release() }
		return psr_payload.to_value(), req.with_method_snapshot(req.method)
	}
	dispatch_req := req.with_method_snapshot(req.method)
	return vslim_request_build_value(&dispatch_req, params), dispatch_req
}

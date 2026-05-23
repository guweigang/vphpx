module httpx

import vphp

pub fn route_dispatch_payload(req &VSlimRequest, source_payload vphp.PhpValue, params map[string]string) (vphp.PhpValue, VSlimRequest) {
	if is_psr_server_request_payload(source_payload) {
		mut psr_payload := normalize_psr15_server_request_value(source_payload, params)
		defer {
			psr_payload.release()
		}
		dispatch_req := vslim_request_from_psr_server_request_object(psr_payload, params)
		return vslim_request_build_value(dispatch_req, params), dispatch_req.to_vslim_request()
	}
	dispatch_req := req.with_method_snapshot(req.method)
	return vslim_request_build_value(&dispatch_req, params), dispatch_req
}

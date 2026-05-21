module httpx

import vphp

pub fn legacy_middleware_payload(payload vphp.PhpValue, route_params map[string]string) vphp.PhpValue {
	if payload.is_valid() && payload.is_object()
		&& (payload.is_instance_of('VSlim\\VHttpd\\Request')
		|| payload.is_instance_of('VSlimRequest')) {
		return payload.owned()
	}
	req := vslim_request_from_psr_server_request(payload, route_params)
	return vslim_request_build_value(req, route_params)
}

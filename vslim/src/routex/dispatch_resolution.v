module routex

import vphp

pub struct RouteDispatchResolution {
pub:
	response_ref vphp.PhpValue = vphp.PhpValue.null()
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
	route_params map[string]string
	handled      bool
}

pub fn RouteDispatchResolution.unresolved() RouteDispatchResolution {
	return RouteDispatchResolution{
		handled: false
	}
}

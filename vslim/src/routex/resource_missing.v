module routex

import httpx
import vphp

pub fn dispatch_resource_missing(action string, handler vphp.PhpCallable, request_payload vphp.PhpValue, params map[string]string) vphp.PhpValue {
	if !handler.is_valid() || !handler.is_callable() {
		return vphp.PhpValue.null()
	}
	mut psr_arg := httpx.normalize_psr15_server_request(request_payload, params)
	mut action_arg := vphp.PhpString.of(action)
	mut params_arg := vphp.PhpValue.from_v[map[string]string](params) or { vphp.PhpValue.null() }
	defer {
		psr_arg.release()
		action_arg.release()
		params_arg.release()
	}
	mut result := handler.invoke(psr_arg, action_arg, params_arg)
	return result.owned()
}

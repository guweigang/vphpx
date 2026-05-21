module appx

import httpx
import vphp

enum MiddlewareTerminalKind {
	none
	fixed_response
	not_found
	method_not_allowed
	error_response
}

struct MiddlewareTerminalMeta {
mut:
	kind               MiddlewareTerminalKind   = .none
	fixed_response_ref &httpx.VSlimPsr7Response = unsafe { nil }
	status             int
	message            string
	fallback_message   string
	error_code         string
	allowed_methods    []string
}

struct RawDispatchPlan {
mut:
	route_params             map[string]string
	terminal_meta            MiddlewareTerminalMeta
	route_handler            vphp.PhpValue = vphp.PhpValue.invalid()
	resource_action          string
	resource_missing_handler vphp.PhpCallable = vphp.PhpCallable.invalid()
}

struct PipelineRequestContext {
mut:
	path         string
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
	route_params map[string]string
}

struct PipelineDispatchResult {
	response_ref vphp.PhpValue = vphp.PhpValue.null()
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
}

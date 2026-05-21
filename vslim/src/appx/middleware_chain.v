module appx

import vphp

@[heap]
struct MiddlewareChain {
	app         &VSlimApp = unsafe { nil }
	request_ctx PipelineRequestContext
mut:
	middlewares []vphp.PhpValue
	plan        RawDispatchPlan
	index       int
}

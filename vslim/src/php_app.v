module main

import os
import vphp

#include "php_bridge.h"

__global (
	forwarded_requests            map[u64]PhaseForwardedServerRequestSnapshot
	vslim_trace_mem_cache_inited  bool
	vslim_trace_mem_enabled_cache bool
	vslim_trace_mem_every_cache   int
	vslim_trace_mem_counter       u64
	vslim_current_dispatch_app    &VSlimApp
)

fn enter_runtime_dispatch_app(app &VSlimApp) &VSlimApp {
	unsafe {
		prev := vslim_current_dispatch_app
		vslim_current_dispatch_app = app
		return prev
	}
}

fn leave_runtime_dispatch_app(prev &VSlimApp) {
	unsafe {
		vslim_current_dispatch_app = prev
	}
}

fn current_runtime_dispatch_app() &VSlimApp {
	unsafe {
		return vslim_current_dispatch_app
	}
}

fn vslim_trace_mem_enabled(app &VSlimApp) bool {
	if app.config_ref != unsafe { nil } && app.config_ref.has('app.trace.memory') {
		return app.config_ref.get_bool('app.trace.memory', false)
	}
	unsafe {
		if !vslim_trace_mem_cache_inited {
			mut raw := os.getenv('VSLIM_TRACE_MEM').trim_space().to_lower()
			if raw.starts_with('toml.any(') && raw.ends_with(')') && raw.len > 10 {
				raw = raw[9..raw.len - 1].trim_space().trim('"\'').to_lower()
			}
			vslim_trace_mem_enabled_cache = raw in ['1', 'true', 'yes', 'on']
			mut every_raw := os.getenv('VSLIM_TRACE_MEM_EVERY').trim_space()
			if every_raw.to_lower().starts_with('toml.any(') && every_raw.ends_with(')')
				&& every_raw.len > 10 {
				every_raw = every_raw[9..every_raw.len - 1].trim_space().trim('"\'')
			}
			mut every := every_raw.int()
			if every <= 0 {
				every = 1
			}
			vslim_trace_mem_every_cache = every
			vslim_trace_mem_cache_inited = true
		}
		return vslim_trace_mem_enabled_cache
	}
}

fn vslim_trace_mem_every(app &VSlimApp) int {
	if app.config_ref != unsafe { nil } && app.config_ref.has('app.trace.memory_every') {
		every := app.config_ref.get_int('app.trace.memory_every', 1)
		if every <= 0 {
			return 1
		}
		return every
	}
	unsafe {
		_ = vslim_trace_mem_enabled(app)
		return vslim_trace_mem_every_cache
	}
}

fn vslim_trace_mem_should_log(app &VSlimApp) bool {
	if !vslim_trace_mem_enabled(app) {
		return false
	}
	unsafe {
		vslim_trace_mem_counter++
		every := u64(vslim_trace_mem_every(app))
		return every > 0 && vslim_trace_mem_counter % every == 0
	}
}

fn vslim_mem_usage_bytes() i64 {
	mut real_usage_arg := vphp.PhpBool.of(true)
	defer {
		real_usage_arg.release()
	}
	return vphp.PhpFunction.named('memory_get_usage').with_result[vphp.PhpInt, i64](fn (val vphp.PhpInt) i64 {
		return val.value()
	}, real_usage_arg) or { -1 }
}

fn vslim_trace_mem_log(app &VSlimApp, req &VSlimRequest, stage string, base_bytes i64) {
	bytes := vslim_mem_usage_bytes()
	if bytes < 0 {
		return
	}
	delta := bytes - base_bytes
	counters := vphp.runtime_counters()
	mut context := map[string]string{}
	mut clock := resolve_app_clock(app)
	defer {
		clock.release()
	}
	context['ts'] = psr20_clock_now_unix_milli_string_or_throw(clock) or { '' }
	context['stage'] = stage
	context['method'] = req.method
	context['path'] = req.path_value()
	context['bytes'] = '${bytes}'
	context['delta'] = '${delta}'
	context['ar_len'] = '${counters.autorelease_len}'
	context['owned_len'] = '${counters.owned_len}'
	context['obj_reg'] = '${counters.obj_registry_len}'
	context['rev_reg'] = '${counters.rev_registry_len}'
	mut logger := resolve_app_logger(app)
	mut context_value := vphp.PhpValue.from_v[map[string]string](context) or {
		vphp.PhpValue.null()
	}
	mut context_arr := context_value.as_array() or { vphp.PhpArray.empty() }
	defer {
		context_value.release()
		context_arr.release()
	}
	logger.debug_context('memory trace', context_arr)
}

fn resolve_app_logger(app &VSlimApp) &VSlimLogger {
	unsafe {
		mut writable := &VSlimApp(app)
		return writable.logger()
	}
}

fn resolve_app_clock(app &VSlimApp) vphp.PhpObject {
	unsafe {
		mut writable := &VSlimApp(app)
		return writable.clock()
	}
}

fn probe_object_info(obj vphp.PhpObject, class_name string, method_name string) vphp.PhpValue {
	mut out := vphp.PhpArray.empty()
	if !obj.is_valid() {
		out.string('is_object', 'false')
		return out.take_value()
	}
	mut class_arg := vphp.PhpString.of(class_name)
	mut autoload_arg := vphp.PhpBool.of(true)
	mut method_arg := vphp.PhpString.of(method_name)
	defer {
		class_arg.release()
		autoload_arg.release()
		method_arg.release()
	}
	out.string('is_object', 'true')
	out.string('class', obj.class_name())
	out.string('is_instance_of', obj.is_instance_of(class_name).str())
	out.string('is_subclass_of', obj.is_subclass_of(class_name).str())
	out.string('method_exists', obj.method_exists(method_name).str())
	out.string('php_is_a', vphp.PhpFunction.named('is_a').result_bool(obj, class_arg,
		autoload_arg).str())
	out.string('php_method_exists', vphp.PhpFunction.named('method_exists').result_bool(obj,
		method_arg).str())
	return out.take_value()
}

@[php_arg_name: 'class_name=className,method_name=methodName']
@[php_method]
pub fn VSlimDebugObjectProbe.probe(obj vphp.PhpObject, class_name string, method_name string) vphp.PhpValue {
	return probe_object_info(obj, class_name, method_name)
}

@[php_method: 'psr7LifecycleCounters']
pub fn VSlimDebugObjectProbe.psr7_lifecycle_counters(rounds int) string {
	total_rounds := if rounds <= 0 { 1 } else { rounds }
	before := vphp.runtime_counters()
	mut scope := vphp.PhpScope.request()
	mut server_params := vphp.PhpArray.empty()
	server_params.string('REQUEST_METHOD', 'POST')
	mut req := new_psr7_server_request_string('POST', '/debug/lifecycle?probe=1', server_params)
	server_params.release()
	mut checksum := 0
	for i in 0 .. total_rounds {
		mut parsed := vphp.PhpArray.empty()
		parsed.string('message', 'hello-${i}')
		parsed.int('round', i)
		mut tags := vphp.PhpArray.empty()
		tags.push_string('alpha')
		tags.push_string('beta')
		parsed.set('tags', tags)
		tags.release()
		req = req.with_parsed_body(parsed.to_borrowed().to_value())

		mut attr_name := vphp.PhpString.of('studio.payload')
		req = req.with_attribute(attr_name.to_borrowed().to_value(),
			parsed.to_borrowed().to_value())
		attr_name.release()
		parsed.release()

		mut attrs := req.get_attributes()
		checksum += attrs.count()
		attrs.release()
		mut parsed_copy := req.get_parsed_body()
		if parsed_array := parsed_copy.as_array() {
			checksum += parsed_array.count()
			parsed_array.release()
		}
		parsed_copy.release()
	}
	scope.close()
	after := vphp.runtime_counters()
	return 'rounds=${total_rounds};checksum=${checksum};autorelease_delta=${after.autorelease_len - before.autorelease_len};owned_delta=${after.owned_len - before.owned_len};fallback_delta=${after.persistent_fallback_zval_len - before.persistent_fallback_zval_len}'
}

@[php_method]
pub fn VSlimApp.demo() &VSlimApp {
	return &VSlimApp{
		not_found_handler: vphp.PhpCallable.invalid()
		error_handler:     vphp.PhpCallable.invalid()
		use_demo:          true
	}
}

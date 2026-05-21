module appx

import httpx
import loggerx
import os
import clockx
import vphp

#include "php_bridge.h"

__global (
	vslim_trace_mem_cache_inited  bool
	vslim_trace_mem_enabled_cache bool
	vslim_trace_mem_every_cache   int
	vslim_trace_mem_counter       u64
	vslim_current_dispatch_app    &VSlimApp
)

fn (app &VSlimApp) enter_runtime_dispatch() &VSlimApp {
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

fn (app &VSlimApp) trace_mem_enabled() bool {
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

fn (app &VSlimApp) trace_mem_every() int {
	if app.config_ref != unsafe { nil } && app.config_ref.has('app.trace.memory_every') {
		every := app.config_ref.get_int('app.trace.memory_every', 1)
		if every <= 0 {
			return 1
		}
		return every
	}
	unsafe {
		_ = app.trace_mem_enabled()
		return vslim_trace_mem_every_cache
	}
}

fn (app &VSlimApp) trace_mem_should_log() bool {
	if !app.trace_mem_enabled() {
		return false
	}
	unsafe {
		vslim_trace_mem_counter++
		every := u64(app.trace_mem_every())
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

fn (app &VSlimApp) trace_mem_log(req &httpx.VSlimRequest, stage string, base_bytes i64) {
	bytes := vslim_mem_usage_bytes()
	if bytes < 0 {
		return
	}
	delta := bytes - base_bytes
	counters := vphp.runtime_counters()
	mut context := map[string]string{}
	mut clock := app.resolve_clock()
	defer {
		clock.release()
	}
	context['ts'] = clockx.psr20_clock_now_unix_milli_string_or_throw(clock) or { '' }
	context['stage'] = stage
	context['method'] = req.method
	context['path'] = req.path_value()
	context['bytes'] = '${bytes}'
	context['delta'] = '${delta}'
	context['ar_len'] = '${counters.autorelease_len}'
	context['owned_len'] = '${counters.owned_len}'
	context['obj_reg'] = '${counters.obj_registry_len}'
	context['rev_reg'] = '${counters.rev_registry_len}'
	mut log_writer := app.resolve_logger()
	mut context_value := vphp.PhpValue.from_v[map[string]string](context) or {
		vphp.PhpValue.null()
	}
	mut context_arr := context_value.as_array() or { vphp.PhpArray.empty() }
	defer {
		context_value.release()
		context_arr.release()
	}
	log_writer.debug_context('memory trace', context_arr)
}

fn (app &VSlimApp) resolve_logger() &loggerx.VSlimLogger {
	unsafe {
		mut writable := &VSlimApp(app)
		return writable.logger()
	}
}

fn (app &VSlimApp) resolve_clock() vphp.PhpObject {
	unsafe {
		mut writable := &VSlimApp(app)
		return writable.clock()
	}
}

@[php_method]
pub fn VSlimApp.demo() &VSlimApp {
	return &VSlimApp{
		not_found_handler: vphp.PhpCallable.invalid()
		error_handler:     vphp.PhpCallable.invalid()
		use_demo:          true
	}
}

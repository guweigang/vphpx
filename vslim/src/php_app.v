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
	return vphp.PhpFunction.named('memory_get_usage').with_result_zval(fn (val vphp.ZVal) i64 {
		if !val.is_valid() || val.is_null() || val.is_undef() {
			return -1
		}
		return val.to_i64()
	}, vphp.RequestOwnedZBox.new_bool(true).to_zval())
}

fn vslim_trace_mem_log(app &VSlimApp, req &VSlimRequest, stage string, base_bytes i64) {
	bytes := vslim_mem_usage_bytes()
	if bytes < 0 {
		return
	}
	delta := bytes - base_bytes
	counters := vphp.runtime_counters()
	mut context := map[string]string{}
	context['ts'] = psr20_now_unix_milli_string_or_throw(resolve_app_clock_zval(app)) or { '' }
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
	logger.debug_context('memory trace', vphp.RequestBorrowedZBox.of(vphp.new_zval_from[map[string]string](context) or {
		vphp.ZVal.new_null()
	}))
}

fn resolve_app_logger(app &VSlimApp) &VSlimLogger {
	unsafe {
		mut writable := &VSlimApp(app)
		return writable.logger()
	}
}

fn resolve_app_clock_zval(app &VSlimApp) vphp.ZVal {
	unsafe {
		mut writable := &VSlimApp(app)
		return writable.clock().to_zval()
	}
}

fn probe_object_info(obj vphp.RequestBorrowedZBox, class_name string, method_name string) vphp.RequestOwnedZBox {
	raw := obj.to_zval()
	if !raw.is_object() {
		return vphp.RequestOwnedZBox.of(vphp.new_zval_from[map[string]string]({
			'is_object': 'false'
		}) or { vphp.ZVal.new_null() })
	}
	return vphp.RequestOwnedZBox.of(vphp.new_zval_from[map[string]string]({
		'is_object':         raw.is_object().str()
		'class':             raw.class_name()
		'is_instance_of':    raw.is_instance_of(class_name).str()
		'is_subclass_of':    raw.is_subclass_of(class_name).str()
		'method_exists':     raw.method_exists(method_name).str()
		'php_is_a':          vphp.PhpFunction.named('is_a').result_bool(vphp.PhpValue.from_zval(raw),
			vphp.PhpString.of(class_name), vphp.PhpBool.of(true)).str()
		'php_method_exists': vphp.PhpFunction.named('method_exists').result_bool(vphp.PhpValue.from_zval(raw),
			vphp.PhpString.of(method_name)).str()
	}) or { vphp.ZVal.new_null() })
}

@[php_arg_name: 'class_name=className,method_name=methodName']
@[php_method]
pub fn VSlimDebugObjectProbe.probe(obj vphp.RequestBorrowedZBox, class_name string, method_name string) vphp.RequestOwnedZBox {
	return probe_object_info(obj, class_name, method_name)
}

@[php_method]
pub fn VSlimApp.demo() &VSlimApp {
	return &VSlimApp{
		not_found_handler: vphp.PersistentOwnedZBox.new_null()
		error_handler:     vphp.PersistentOwnedZBox.new_null()
		use_demo:          true
	}
}

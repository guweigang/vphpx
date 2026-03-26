module main

import os
import time
import vphp

#include "php_bridge.h"

__global (
	active_middleware_chains      []&MiddlewareChain
	vslim_trace_mem_cache_inited  bool
	vslim_trace_mem_enabled_cache bool
	vslim_trace_mem_every_cache   int
	vslim_trace_mem_counter       u64
)

fn vslim_trace_mem_enabled() bool {
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

fn vslim_trace_mem_every() int {
	unsafe {
		_ = vslim_trace_mem_enabled()
		return vslim_trace_mem_every_cache
	}
}

fn vslim_trace_mem_should_log() bool {
	if !vslim_trace_mem_enabled() {
		return false
	}
	unsafe {
		vslim_trace_mem_counter++
		every := u64(vslim_trace_mem_every())
		return every > 0 && vslim_trace_mem_counter % every == 0
	}
}

fn vslim_mem_usage_bytes() i64 {
	val := vphp.call_php('memory_get_usage', [vphp.RequestOwnedZVal.new_bool(true).to_zval()])
	if !val.is_valid() || val.is_null() || val.is_undef() {
		return -1
	}
	return val.to_i64()
}

fn vslim_trace_mem_log(app &VSlimApp, req &VSlimRequest, stage string, base_bytes i64) {
	bytes := vslim_mem_usage_bytes()
	if bytes < 0 {
		return
	}
	delta := bytes - base_bytes
	counters := vphp.runtime_counters()
	mut context := map[string]string{}
	context['ts'] = '${time.now().unix_milli()}'
	context['stage'] = stage
	context['method'] = req.method
	context['path'] = req.path
	context['bytes'] = '${bytes}'
	context['delta'] = '${delta}'
	context['ar_len'] = '${counters.autorelease_len}'
	context['owned_len'] = '${counters.owned_len}'
	context['obj_reg'] = '${counters.obj_registry_len}'
	context['rev_reg'] = '${counters.rev_registry_len}'
	mut logger := resolve_app_logger(app)
	logger.debug_context('memory trace', vphp.new_zval_from[map[string]string](context) or {
		vphp.ZVal.new_null()
	})
}

fn resolve_app_logger(app &VSlimApp) &VSlimLogger {
	unsafe {
		mut writable := &VSlimApp(app)
		return writable.logger()
	}
}

@[php_function]
fn vslim_probe_object(ctx vphp.Context) {
	obj := ctx.arg_raw(0)
	class_name := ctx.arg_raw(1).to_string()
	method_name := ctx.arg_raw(2).to_string()
	if !obj.is_object() {
		ctx.return_map({
			'is_object': 'false'
		})
		return
	}
	ctx.return_map({
		'is_object':        obj.is_object().str()
		'class':            obj.class_name()
		'is_instance_of':   obj.is_instance_of(class_name).str()
		'is_subclass_of':   obj.is_subclass_of(class_name).str()
		'method_exists':    obj.method_exists(method_name).str()
		'php_is_a':         vphp.php_fn('is_a').call([
			obj,
			vphp.ZVal.new_string(class_name),
			vphp.ZVal.new_bool(true),
		]).to_bool().str()
		'php_method_exists': vphp.php_fn('method_exists').call([
			obj,
			vphp.ZVal.new_string(method_name),
		]).to_bool().str()
	})
}

@[php_method]
pub fn VSlimApp.demo() &VSlimApp {
	return &VSlimApp{
		not_found_handler: vphp.PersistentOwnedZVal.new_null()
		error_handler:     vphp.PersistentOwnedZVal.new_null()
		use_demo:          true
	}
}

@[php_method]
pub fn (mut app VSlimApp) set_base_path(base_path string) &VSlimApp {
	app.base_path = RoutePath.normalize_base_path(base_path)
	return app
}

@[php_method]
pub fn (app &VSlimApp) has_container() bool {
	return app.container_ref != unsafe { nil }
}

@[php_method]
pub fn (mut app VSlimApp) set_container(container &VSlimContainer) &VSlimApp {
	app.container_ref = container
	app.sync_config_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) container() &VSlimContainer {
	if app.container_ref == unsafe { nil } {
		mut created := &VSlimContainer{}
		created.construct()
		app.container_ref = created
	}
	app.sync_config_to_container()
	return app.container_ref
}

@[php_method]
pub fn (app &VSlimApp) has_config() bool {
	return app.config_ref != unsafe { nil }
}

@[php_method]
pub fn (mut app VSlimApp) set_config(config &VSlimConfig) &VSlimApp {
	app.config_ref = config
	app.sync_config_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) config() &VSlimConfig {
	if app.config_ref == unsafe { nil } {
		mut created := &VSlimConfig{}
		created.construct()
		app.config_ref = created
		app.sync_config_to_container()
	}
	return app.config_ref
}

@[php_method]
pub fn (mut app VSlimApp) load_config(path string) &VSlimApp {
	mut cfg := app.config()
	cfg.load(path)
	app.sync_config_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) load_config_text(text string) &VSlimApp {
	mut cfg := app.config()
	cfg.load_text(text)
	app.sync_config_to_container()
	return app
}

fn (mut app VSlimApp) sync_config_to_container() {
	if app.container_ref == unsafe { nil } || app.config_ref == unsafe { nil } {
		return
	}
	unsafe {
		z := C.vphp_new_zval()
		if z == 0 {
			return
		}
		C.vphp_return_obj(z, app.config_ref, C.vslim__config_ce)
		app.container_ref.set('config', vphp.ZVal{
			raw: z
		})
		C.vphp_release_zval(z)
	}
}

@[php_method]
pub fn (app &VSlimApp) group(prefix string) &RouteGroup {
	return &RouteGroup{
		app:    app
		prefix: RoutePath.normalize_group_prefix(prefix)
	}
}

@[php_method]
pub fn (app &VSlimApp) dispatch(method string, raw_path string) &VSlimResponse {
	return app.dispatch_body(method, raw_path, '')
}

@[php_method]
pub fn (app &VSlimApp) dispatch_body(method string, raw_path string, body string) &VSlimResponse {
	req := new_vslim_request(method, raw_path, body)
	return app.dispatch_request(req)
}

@[php_method]
pub fn (app &VSlimApp) dispatch_request(req &VSlimRequest) &VSlimResponse {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	trace_on := vslim_trace_mem_should_log()
	mut trace_base := i64(0)
	if trace_on {
		trace_base = vslim_mem_usage_bytes()
		vslim_trace_mem_log(app, req, 'dispatch.enter', trace_base)
	}
	mut res, params := dispatch_app_request_with_params(app, req, trace_on, trace_base)
	if trace_on {
		vslim_trace_mem_log(app, req, 'dispatch.after_core', trace_base)
	}
	propagate_request_trace_headers(req, mut res)
	if resolve_effective_method(req) == 'HEAD' {
		res.body = ''
	}
	unsafe {
		mut writable := &VSlimRequest(req)
		writable.params = params.clone()
		if writable.attributes.len == 0 {
			writable.attributes = params.clone()
		}
	}
	if trace_on {
		vslim_trace_mem_log(app, req, 'dispatch.before_return', trace_base)
	}
	return to_vslim_response(res)
}

fn propagate_request_trace_headers(req &VSlimRequest, mut res VSlimResponse) {
	rid := req.request_id()
	if rid != '' && !res.has_header('x-request-id') {
		res.set_header('x-request-id', rid)
	}
	tid := req.trace_id()
	if tid != '' {
		if !res.has_header('x-trace-id') {
			res.set_header('x-trace-id', tid)
		}
		if !res.has_header('x-vhttpd-trace-id') {
			res.set_header('x-vhttpd-trace-id', tid)
		}
	}
}

@[php_method]
pub fn (app &VSlimApp) dispatch_envelope(envelope vphp.ZVal) &VSlimResponse {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	req := new_vslim_request_from_zval(envelope)
	return app.dispatch_request(req)
}

@[export: 'manual_dispatch_envelope_worker']
@[php_method]
pub fn (app &VSlimApp) dispatch_envelope_worker(envelope vphp.ZVal) {}

@[export: 'VSlimApp_dispatch_envelope_worker']
pub fn vslimapp_dispatch_envelope_worker(ptr voidptr, ctx vphp.Context) {
	app := unsafe { &VSlimApp(ptr) }
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	envelope := ctx.arg_raw(0)
	req := new_vslim_request_from_zval(envelope)
	raw := dispatch_app_request_worker(app, req)
	ctx.return_zval(raw)
}

@[php_method]
pub fn (app &VSlimApp) dispatch_envelope_map(envelope vphp.ZVal) map[string]string {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	req := new_vslim_request_from_zval(envelope)
	trace_on := vslim_trace_mem_should_log()
	mut trace_base := i64(0)
	if trace_on {
		trace_base = vslim_mem_usage_bytes()
		vslim_trace_mem_log(app, req, 'dispatch_map.enter', trace_base)
	}
	mut res, _ := dispatch_app_request_with_params(app, req, trace_on, trace_base)
	if trace_on {
		vslim_trace_mem_log(app, req, 'dispatch_map.after_core', trace_base)
	}
	propagate_request_trace_headers(req, mut res)
	if resolve_effective_method(req) == 'HEAD' {
		res.body = ''
	}
	mut out := {
		'status':       '${res.status}'
		'body':         res.body
		'content_type': res.content_type
	}
	for name, value in res.headers {
		if name == '' {
			continue
		}
		out['headers_${name.to_lower()}'] = value
	}
	return out
}

@[php_method]
pub fn (mut app VSlimApp) get(pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('GET', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) post(pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('POST', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) put(pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('PUT', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) head(pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('HEAD', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) options(pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('OPTIONS', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) patch(pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('PATCH', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) delete(pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('DELETE', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) any(pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('*', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) live(pattern string, handler vphp.ZVal) &VSlimApp {
	bind_live_view_to_app(mut app, handler)
	app.add_php_route('GET', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) live_ws(handler vphp.ZVal, frame vphp.ZVal, conn vphp.ZVal) vphp.ZVal {
	bind_live_view_to_app(mut app, handler)
	event := zval_string_key(frame, 'event', '').trim_space().to_lower()
	if event == '' {
		return vphp.RequestOwnedZVal.new_null().to_zval()
	}
	return dispatch_live_websocket_handler(mut app, handler, event, frame, conn)
}

@[php_method]
pub fn (mut app VSlimApp) websocket(pattern string, handler vphp.ZVal) &VSlimApp {
	bind_live_view_to_app(mut app, handler)
	app.add_php_websocket_route('', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) websocket_named(name string, pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_websocket_route(name, pattern, handler)
	return app
}

@[php_method]
pub fn (app &VSlimApp) has_mcp() bool {
	return app.mcp_ref != unsafe { nil }
}

@[php_method]
pub fn (mut app VSlimApp) set_mcp(mcp &VSlimMcpApp) &VSlimApp {
	app.mcp_ref = mcp
	return app
}

@[php_method]
pub fn (mut app VSlimApp) mcp() &VSlimMcpApp {
	if app.mcp_ref == unsafe { nil } {
		mut created := &VSlimMcpApp{}
		created.construct()
		app.mcp_ref = created
	}
	return app.mcp_ref
}

@[php_method]
pub fn (app &VSlimApp) handle_mcp_dispatch(frame vphp.ZVal) vphp.ZVal {
	if app.mcp_ref == unsafe { nil } {
		return vphp.RequestOwnedZVal.new_null().to_zval()
	}
	return app.mcp_ref.handle_mcp_dispatch(frame)
}

@[php_method]
pub fn (mut app VSlimApp) map(methods vphp.ZVal, pattern string, handler vphp.ZVal) &VSlimApp {
	for method in normalize_methods(vphp.BorrowedZVal.from_zval(methods)) {
		app.add_php_route(method, '', pattern, handler)
	}
	return app
}

@[php_method]
pub fn (mut app VSlimApp) resource(resource_path string, controller string) &VSlimApp {
	register_resource_routes(mut app, resource_path, controller, true)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) api_resource(resource_path string, controller string) &VSlimApp {
	register_resource_routes(mut app, resource_path, controller, false)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) singleton(resource_path string, controller string) &VSlimApp {
	register_singleton_routes(mut app, resource_path, controller, true)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) api_singleton(resource_path string, controller string) &VSlimApp {
	register_singleton_routes(mut app, resource_path, controller, false)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) resource_opts(resource_path string, controller string, options vphp.ZVal) &VSlimApp {
	opts := parse_resource_options(vphp.BorrowedZVal.from_zval(options))
	register_resource_routes_with_options(mut app, resource_path, controller, true, opts)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) api_resource_opts(resource_path string, controller string, options vphp.ZVal) &VSlimApp {
	opts := parse_resource_options(vphp.BorrowedZVal.from_zval(options))
	register_resource_routes_with_options(mut app, resource_path, controller, false, opts)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) singleton_opts(resource_path string, controller string, options vphp.ZVal) &VSlimApp {
	opts := parse_resource_options(vphp.BorrowedZVal.from_zval(options))
	register_singleton_routes_with_options(mut app, resource_path, controller, true, opts)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) api_singleton_opts(resource_path string, controller string, options vphp.ZVal) &VSlimApp {
	opts := parse_resource_options(vphp.BorrowedZVal.from_zval(options))
	register_singleton_routes_with_options(mut app, resource_path, controller, false,
		opts)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) get_named(name string, pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('GET', name, pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) post_named(name string, pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('POST', name, pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) put_named(name string, pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('PUT', name, pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) head_named(name string, pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('HEAD', name, pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) options_named(name string, pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('OPTIONS', name, pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) patch_named(name string, pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('PATCH', name, pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) delete_named(name string, pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('DELETE', name, pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) any_named(name string, pattern string, handler vphp.ZVal) &VSlimApp {
	app.add_php_route('*', name, pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) map_named(methods vphp.ZVal, name string, pattern string, handler vphp.ZVal) &VSlimApp {
	for method in normalize_methods(vphp.BorrowedZVal.from_zval(methods)) {
		app.add_php_route(method, name, pattern, handler)
	}
	return app
}

@[php_method]
pub fn (mut app VSlimApp) handle_websocket(frame vphp.ZVal, conn vphp.ZVal) vphp.ZVal {
	event := zval_string_key(frame, 'event', '').trim_space().to_lower()
	conn_id := zval_string_key(frame, 'id', '').trim_space()
	if event == '' || conn_id == '' {
		return vphp.RequestOwnedZVal.new_null().to_zval()
	}
	path := RoutePath.normalize(zval_string_key(frame, 'path', '/'))
	if event == 'open' {
		idx, matched := app.websocket_route_index(path)
		if !matched {
			return vphp.RequestOwnedZVal.new_bool(false).to_zval()
		}
		app.websocket_conn_route[conn_id] = idx
		return dispatch_websocket_route_handler(app, app.websocket_routes[idx], event,
			frame, conn)
	}
	idx := app.websocket_conn_route[conn_id] or {
		fallback_idx, matched := app.websocket_route_index(path)
		if !matched {
			return vphp.RequestOwnedZVal.new_null().to_zval()
		}
		app.websocket_conn_route[conn_id] = fallback_idx
		return dispatch_websocket_route_handler(app, app.websocket_routes[fallback_idx],
			event, frame, conn)
	}
	if idx < 0 || idx >= app.websocket_routes.len {
		app.websocket_conn_route.delete(conn_id)
		fallback_idx, matched := app.websocket_route_index(path)
		if !matched {
			return vphp.RequestOwnedZVal.new_null().to_zval()
		}
		app.websocket_conn_route[conn_id] = fallback_idx
		result := dispatch_websocket_route_handler(app, app.websocket_routes[fallback_idx],
			event, frame, conn)
		if event == 'close' {
			app.websocket_conn_route.delete(conn_id)
		}
		return result
	}
	result := dispatch_websocket_route_handler(app, app.websocket_routes[idx], event,
		frame, conn)
	if event == 'close' {
		app.websocket_conn_route.delete(conn_id)
	}
	return result
}

@[php_method]
pub fn (mut app VSlimApp) middleware(handler vphp.ZVal) &VSlimApp {
	if handler.is_valid() && handler.is_callable() {
		app.php_middlewares << vphp.PersistentOwnedZVal.from_zval(handler)
	}
	return app
}

@[php_method]
pub fn (mut app VSlimApp) before(handler vphp.ZVal) &VSlimApp {
	if handler.is_valid() && handler.is_callable() {
		app.php_before_hooks << vphp.PersistentOwnedZVal.from_zval(handler)
	}
	return app
}

@[php_method]
pub fn (mut app VSlimApp) after(handler vphp.ZVal) &VSlimApp {
	if handler.is_valid() && handler.is_callable() {
		app.php_after_hooks << vphp.PersistentOwnedZVal.from_zval(handler)
	}
	return app
}

@[php_method]
pub fn (mut app VSlimApp) set_not_found_handler(handler vphp.ZVal) &VSlimApp {
	if !handler.is_valid() || !handler.is_callable() {
		vphp.throw_exception_class('InvalidArgumentException', 'not_found handler must be callable',
			0)
		return app
	}
	app.not_found_handler = vphp.PersistentOwnedZVal.from_zval(handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) not_found(handler vphp.ZVal) &VSlimApp {
	return app.set_not_found_handler(handler)
}

@[php_method]
pub fn (mut app VSlimApp) set_error_handler(handler vphp.ZVal) &VSlimApp {
	if !handler.is_valid() || !handler.is_callable() {
		vphp.throw_exception_class('InvalidArgumentException', 'error handler must be callable',
			0)
		return app
	}
	app.error_handler = vphp.PersistentOwnedZVal.from_zval(handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) error(handler vphp.ZVal) &VSlimApp {
	return app.set_error_handler(handler)
}

@[php_method]
pub fn (mut app VSlimApp) set_error_response_json(enabled bool) &VSlimApp {
	app.error_response_json = enabled
	return app
}

@[php_method]
pub fn (app &VSlimApp) error_response_json_enabled() bool {
	return app.error_response_json
}

@[php_method]
pub fn (app &VSlimApp) has_logger() bool {
	return app.logger_ref != unsafe { nil }
}

@[php_method]
pub fn (mut app VSlimApp) set_logger(logger &VSlimLogger) &VSlimApp {
	app.logger_ref = logger
	return app
}

@[php_method]
pub fn (mut app VSlimApp) logger() &VSlimLogger {
	if app.logger_ref == unsafe { nil } {
		mut created := &VSlimLogger{}
		created.construct()
		created.set_channel('vslim.app')
		app.logger_ref = created
	}
	return app.logger_ref
}

@[php_method]
pub fn (group &RouteGroup) group(prefix string) &RouteGroup {
	return &RouteGroup{
		app:    group.app
		prefix: RoutePath.prefixed_pattern(group.prefix, prefix)
	}
}

@[php_method]
pub fn (group &RouteGroup) middleware(handler vphp.ZVal) &RouteGroup {
	if !handler.is_valid() || !handler.is_callable() {
		return group
	}
	unsafe {
		mut app := &VSlimApp(group.app)
		app.php_group_middle << RouteHook{
			prefix:  group.normalized_prefix()
			handler: vphp.PersistentOwnedZVal.from_zval(handler)
		}
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) before(handler vphp.ZVal) &RouteGroup {
	if !handler.is_valid() || !handler.is_callable() {
		return group
	}
	unsafe {
		mut app := &VSlimApp(group.app)
		app.php_group_before << RouteHook{
			prefix:  group.normalized_prefix()
			handler: vphp.PersistentOwnedZVal.from_zval(handler)
		}
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) after(handler vphp.ZVal) &RouteGroup {
	if !handler.is_valid() || !handler.is_callable() {
		return group
	}
	unsafe {
		mut app := &VSlimApp(group.app)
		app.php_group_after << RouteHook{
			prefix:  group.normalized_prefix()
			handler: vphp.PersistentOwnedZVal.from_zval(handler)
		}
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) get(pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('GET', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) post(pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('POST', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) put(pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('PUT', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) head(pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('HEAD', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) options(pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('OPTIONS', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) patch(pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('PATCH', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) delete(pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('DELETE', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) any(pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('*', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) live(pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		bind_live_view_to_app(mut app, handler)
		app.add_php_route('GET', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) websocket(pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		bind_live_view_to_app(mut app, handler)
		app.add_php_websocket_route('', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) map(methods vphp.ZVal, pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		for method in normalize_methods(vphp.BorrowedZVal.from_zval(methods)) {
			app.add_php_route(method, '', group.prefixed_pattern(pattern), handler)
		}
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) resource(resource_path string, controller string) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		register_resource_routes(mut app, group.prefixed_pattern(resource_path), controller,
			true)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) api_resource(resource_path string, controller string) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		register_resource_routes(mut app, group.prefixed_pattern(resource_path), controller,
			false)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) singleton(resource_path string, controller string) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		register_singleton_routes(mut app, group.prefixed_pattern(resource_path), controller,
			true)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) api_singleton(resource_path string, controller string) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		register_singleton_routes(mut app, group.prefixed_pattern(resource_path), controller,
			false)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) resource_opts(resource_path string, controller string, options vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		opts := parse_resource_options(vphp.BorrowedZVal.from_zval(options))
		register_resource_routes_with_options(mut app, group.prefixed_pattern(resource_path),
			controller, true, opts)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) api_resource_opts(resource_path string, controller string, options vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		opts := parse_resource_options(vphp.BorrowedZVal.from_zval(options))
		register_resource_routes_with_options(mut app, group.prefixed_pattern(resource_path),
			controller, false, opts)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) singleton_opts(resource_path string, controller string, options vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		opts := parse_resource_options(vphp.BorrowedZVal.from_zval(options))
		register_singleton_routes_with_options(mut app, group.prefixed_pattern(resource_path),
			controller, true, opts)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) api_singleton_opts(resource_path string, controller string, options vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		opts := parse_resource_options(vphp.BorrowedZVal.from_zval(options))
		register_singleton_routes_with_options(mut app, group.prefixed_pattern(resource_path),
			controller, false, opts)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) get_named(name string, pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('GET', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) post_named(name string, pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('POST', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) put_named(name string, pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('PUT', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) head_named(name string, pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('HEAD', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) options_named(name string, pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('OPTIONS', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) patch_named(name string, pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('PATCH', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) delete_named(name string, pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('DELETE', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) any_named(name string, pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('*', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) websocket_named(name string, pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_websocket_route(name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) map_named(methods vphp.ZVal, name string, pattern string, handler vphp.ZVal) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		for method in normalize_methods(vphp.BorrowedZVal.from_zval(methods)) {
			app.add_php_route(method, name, group.prefixed_pattern(pattern), handler)
		}
	}
	return group
}

@[php_method]
pub fn (app &VSlimApp) url_for(name string, params vphp.ZVal) string {
	return app.url_for_query_borrowed(name, vphp.BorrowedZVal.from_zval(params), vphp.BorrowedZVal.null())
}

@[php_method]
pub fn (app &VSlimApp) url_for_query(name string, params vphp.ZVal, query vphp.ZVal) string {
	return app.url_for_query_borrowed(name, vphp.BorrowedZVal.from_zval(params), vphp.BorrowedZVal.from_zval(query))
}

fn (app &VSlimApp) url_for_query_borrowed(name string, params vphp.BorrowedZVal, query vphp.BorrowedZVal) string {
	params_map := params.to_string_map()
	query_map := query.to_string_map()
	for route in app.routes {
		if route.name == name {
			raw := app.render_route_url(route.pattern, &params_map, &query_map) or { '' }
			return RoutePath.apply_base_path(app.base_path, raw)
		}
	}
	return ''
}

@[php_method]
pub fn (app &VSlimApp) url_for_abs(name string, params vphp.ZVal, scheme string, host string) string {
	return app.url_for_query_abs_borrowed(name, vphp.BorrowedZVal.from_zval(params), vphp.BorrowedZVal.null(),
		scheme, host)
}

@[php_method]
pub fn (app &VSlimApp) url_for_query_abs(name string, params vphp.ZVal, query vphp.ZVal, scheme string, host string) string {
	return app.url_for_query_abs_borrowed(name, vphp.BorrowedZVal.from_zval(params), vphp.BorrowedZVal.from_zval(query),
		scheme, host)
}

fn (app &VSlimApp) url_for_query_abs_borrowed(name string, params vphp.BorrowedZVal, query vphp.BorrowedZVal, scheme string, host string) string {
	path := app.url_for_query_borrowed(name, params, query)
	if path == '' {
		return ''
	}
	return RoutePath.absolute_url(scheme, host, path)
}

@[php_method]
pub fn (app &VSlimApp) redirect_to(name string, params vphp.ZVal) &VSlimResponse {
	return app.redirect_to_query_borrowed(name, vphp.BorrowedZVal.from_zval(params), vphp.BorrowedZVal.null())
}

@[php_method]
pub fn (app &VSlimApp) redirect_to_query(name string, params vphp.ZVal, query vphp.ZVal) &VSlimResponse {
	return app.redirect_to_query_borrowed(name, vphp.BorrowedZVal.from_zval(params), vphp.BorrowedZVal.from_zval(query))
}

fn (app &VSlimApp) redirect_to_query_borrowed(name string, params vphp.BorrowedZVal, query vphp.BorrowedZVal) &VSlimResponse {
	location := app.url_for_query_borrowed(name, params, query)
	mut res := &VSlimResponse{}
	res.construct(302, '', 'text/plain; charset=utf-8')
	return res.redirect(location)
}

@[php_method]
pub fn (app &VSlimApp) route_count() int {
	return app.routes.len
}

@[php_method]
pub fn (app &VSlimApp) route_names() []string {
	mut out := []string{}
	for route in app.routes {
		if route.name == '' {
			continue
		}
		if route.name !in out {
			out << route.name
		}
	}
	return out
}

@[php_method]
pub fn (app &VSlimApp) has_route_name(name string) bool {
	for route in app.routes {
		if route.name == name {
			return true
		}
	}
	return false
}

@[php_method]
pub fn (app &VSlimApp) route_manifest_lines() []string {
	mut out := []string{cap: app.routes.len}
	for route in app.routes {
		mut line := '${route.method} ${route.pattern}'
		if route.name != '' {
			line += ' #${route.name}'
		}
		out << line
	}
	return out
}

@[php_method]
pub fn (app &VSlimApp) route_conflict_keys() []string {
	mut grouped := map[string]int{}
	for route in app.routes {
		key := '${route.method} ${route.pattern}'
		grouped[key] = (grouped[key] or { 0 }) + 1
	}
	mut out := []string{}
	for key, count in grouped {
		if count > 1 {
			out << '${key} x${count}'
		}
	}
	out.sort()
	return out
}

@[php_method]
pub fn (app &VSlimApp) route_manifest() []map[string]string {
	mut out := []map[string]string{cap: app.routes.len}
	for route in app.routes {
		out << {
			'method':       route.method
			'name':         route.name
			'pattern':      route.pattern
			'handler_type': route.handler_type.str()
		}
	}
	return out
}

@[php_method]
pub fn (app &VSlimApp) route_conflicts() []map[string]string {
	mut grouped := map[string][]VSlimRoute{}
	for route in app.routes {
		key := '${route.method} ${route.pattern}'
		mut existing := grouped[key] or { []VSlimRoute{} }
		existing << route
		grouped[key] = existing
	}
	mut out := []map[string]string{}
	for key, routes in grouped {
		if routes.len <= 1 {
			continue
		}
		parts := key.split_nth(' ', 2)
		mut names := []string{}
		for route in routes {
			if route.name != '' {
				names << route.name
			}
		}
		out << {
			'method':  parts[0]
			'pattern': if parts.len > 1 { parts[1] } else { '' }
			'count':   '${routes.len}'
			'names':   names.join(',')
		}
	}
	return out
}

@[php_method]
pub fn (app &VSlimApp) allowed_methods_for(raw_path string) []string {
	path := RoutePath.normalize(raw_path)
	mut allowed := []string{}
	for route in app.routes {
		ok, _ := route.matches(path)
		if !ok {
			continue
		}
		allowed = collect_allowed_methods(allowed, route.method)
	}
	if allowed.len > 0 && 'OPTIONS' !in allowed {
		allowed << 'OPTIONS'
	}
	return allowed
}

fn (mut app VSlimApp) add_php_route(method string, name string, pattern string, handler vphp.ZVal) {
	if !is_supported_route_handler(vphp.BorrowedZVal.from_zval(handler)) {
		return
	}
	app.add_php_route_with_resource_meta(method, name, pattern, handler, '', vphp.PersistentOwnedZVal.new_null())
}

fn (mut app VSlimApp) add_php_websocket_route(name string, pattern string, handler vphp.ZVal) {
	if !is_supported_websocket_handler(vphp.BorrowedZVal.from_zval(handler)) {
		return
	}
	app.websocket_routes << VSlimRoute{
		method:       'WS'
		name:         name
		pattern:      pattern
		handler_type: .php_callable
		php_handler:  vphp.PersistentOwnedZVal.from_zval(handler)
	}
}

fn (mut app VSlimApp) add_php_route_with_resource_meta(method string, name string, pattern string, handler vphp.ZVal, resource_action string, resource_missing_handler vphp.PersistentOwnedZVal) {
	if !is_supported_route_handler(vphp.BorrowedZVal.from_zval(handler)) {
		return
	}
	app.routes << VSlimRoute{
		method:                   method.to_upper()
		name:                     name
		pattern:                  pattern
		handler_type:             .php_callable
		php_handler:              vphp.PersistentOwnedZVal.from_zval(handler)
		resource_action:          resource_action
		resource_missing_handler: resource_missing_handler
	}
}

fn (app &VSlimApp) websocket_route_index(path string) (int, bool) {
	for i, route in app.websocket_routes {
		ok, _ := route.matches(path)
		if ok {
			return i, true
		}
	}
	return -1, false
}

fn dispatch_websocket_route_handler(app &VSlimApp, route VSlimRoute, event string, frame vphp.ZVal, conn vphp.ZVal) vphp.ZVal {
	handler := route.php_handler.borrowed()
	if !handler.is_valid() {
		return vphp.RequestOwnedZVal.new_null().to_zval()
	}
	if handler.is_object() {
		obj := handler.to_zval()
		if obj.method_exists('mount') || obj.method_exists('render')
			|| obj.method_exists('live_marker') {
			unsafe {
				mut mutable_app := &VSlimApp(app)
				return dispatch_live_websocket_handler(mut mutable_app, obj, event, frame,
					conn)
			}
		}
		if obj.method_exists('handle_websocket') {
			return obj.method_owned_request('handle_websocket', [frame, conn])
		}
		match event {
			'open' {
				if obj.method_exists('on_open') {
					return obj.method_owned_request('on_open', [conn, frame])
				}
			}
			'message' {
				if obj.method_exists('on_message') {
					return obj.method_owned_request('on_message', [
						conn,
						vphp.RequestOwnedZVal.new_string(zval_string_key(frame, 'data',
							'')).to_zval(),
						frame,
					])
				}
			}
			'close' {
				if obj.method_exists('on_close') {
					return obj.method_owned_request('on_close', [
						conn,
						vphp.RequestOwnedZVal.new_int(zval_int_key(frame, 'code', 1000)).to_zval(),
						vphp.RequestOwnedZVal.new_string(zval_string_key(frame, 'reason',
							'')).to_zval(),
						frame,
					])
				}
			}
			else {}
		}
	}
	if handler.is_callable() {
		match event {
			'open' {
				return handler.call_owned_request([conn, frame])
			}
			'message' {
				return handler.call_owned_request([
					conn,
					vphp.RequestOwnedZVal.new_string(zval_string_key(frame, 'data', '')).to_zval(),
					frame,
				])
			}
			'close' {
				return handler.call_owned_request([
					conn,
					vphp.RequestOwnedZVal.new_int(zval_int_key(frame, 'code', 1000)).to_zval(),
					vphp.RequestOwnedZVal.new_string(zval_string_key(frame, 'reason',
						'')).to_zval(),
					frame,
				])
			}
			else {
				return vphp.RequestOwnedZVal.new_null().to_zval()
			}
		}
	}
	if handler.is_string() && app.has_container() {
		service := resolve_container_service(app, handler.to_string()) or {
			return vphp.RequestOwnedZVal.new_null().to_zval()
		}
		return dispatch_websocket_container_service(service, event, frame, conn)
	}
	if handler.is_array() && app.has_container() {
		parts := handler.to_string_list()
		if parts.len >= 1 && parts[0] != '' {
			service := resolve_container_service(app, parts[0]) or {
				return vphp.RequestOwnedZVal.new_null().to_zval()
			}
			if parts.len == 2 && parts[1] != '' && service.is_object()
				&& service.method_exists(parts[1]) {
				return service.method_owned_request(parts[1], websocket_handler_args(event,
					frame, conn))
			}
			return dispatch_websocket_container_service(service, event, frame, conn)
		}
	}
	return vphp.RequestOwnedZVal.new_null().to_zval()
}

fn dispatch_websocket_container_service(service vphp.ZVal, event string, frame vphp.ZVal, conn vphp.ZVal) vphp.ZVal {
	if !service.is_valid() {
		return vphp.RequestOwnedZVal.new_null().to_zval()
	}
	if service.is_object() && (service.method_exists('mount') || service.method_exists('render')
		|| service.method_exists('live_marker')) {
		return vphp.RequestOwnedZVal.new_null().to_zval()
	}
	if service.is_object() && service.method_exists('handle_websocket') {
		return service.method_owned_request('handle_websocket', [frame, conn])
	}
	match event {
		'open' {
			if service.is_object() && service.method_exists('on_open') {
				return service.method_owned_request('on_open', [conn, frame])
			}
		}
		'message' {
			if service.is_object() && service.method_exists('on_message') {
				return service.method_owned_request('on_message', websocket_handler_args(event,
					frame, conn))
			}
		}
		'close' {
			if service.is_object() && service.method_exists('on_close') {
				return service.method_owned_request('on_close', websocket_handler_args(event,
					frame, conn))
			}
		}
		else {}
	}
	if service.is_callable() {
		return service.call_owned_request(websocket_handler_args(event, frame, conn))
	}
	return vphp.RequestOwnedZVal.new_null().to_zval()
}

fn websocket_handler_args(event string, frame vphp.ZVal, conn vphp.ZVal) []vphp.ZVal {
	return match event {
		'open' {
			[conn, frame]
		}
		'message' {
			[
				conn,
				vphp.RequestOwnedZVal.new_string(zval_string_key(frame, 'data', '')).to_zval(),
				frame,
			]
		}
		'close' {
			[
				conn,
				vphp.RequestOwnedZVal.new_int(zval_int_key(frame, 'code', 1000)).to_zval(),
				vphp.RequestOwnedZVal.new_string(zval_string_key(frame, 'reason', '')).to_zval(),
				frame,
			]
		}
		else {
			[frame, conn]
		}
	}
}

fn dispatch_app_request_with_params(app &VSlimApp, req &VSlimRequest, trace_on bool, trace_base i64) (VSlimResponse, map[string]string) {
	if app.routes.len > 0 {
		if trace_on {
			vslim_trace_mem_log(app, req, 'dispatch.routes.begin', trace_base)
		}
		res, params, ok := dispatch_php_routes_with_params(app, req, trace_on, trace_base)
		if trace_on {
			vslim_trace_mem_log(app, req, 'dispatch.routes.end', trace_base)
		}
		if ok {
			return res, params
		}
	}
	if app.use_demo {
		if trace_on {
			vslim_trace_mem_log(app, req, 'dispatch.demo_fallback', trace_base)
		}
		return dispatch_demo_request_with_params(req.to_vslim_request())
	}
	if trace_on {
		vslim_trace_mem_log(app, req, 'dispatch.not_found_fallback', trace_base)
	}
	return run_not_found(app, req), map[string]string{}
}

fn dispatch_app_request_worker(app &VSlimApp, req &VSlimRequest) vphp.ZVal {
	if app.routes.len > 0 {
		raw, _, ok := dispatch_php_routes_worker_with_params(app, req)
		if ok {
			propagate_request_trace_headers_to_object(req, vphp.BorrowedZVal.from_zval(raw))
			if resolve_effective_method(req) == 'HEAD' && raw.is_object()
				&& raw.is_instance_of('VSlim\\Response') {
				if mut resp := raw.to_object[VSlimResponse]() {
					resp.body = ''
				}
			}
			return raw
		}
	}
	if app.use_demo {
		mut res, _ := dispatch_demo_request_with_params(req.to_vslim_request())
		propagate_request_trace_headers(req, mut res)
		if resolve_effective_method(req) == 'HEAD' {
			res.body = ''
		}
		return build_php_response_object(res)
	}
	mut res := run_not_found(app, req)
	propagate_request_trace_headers(req, mut res)
	if resolve_effective_method(req) == 'HEAD' {
		res.body = ''
	}
	return build_php_response_object(res)
}

fn dispatch_php_routes_with_params(app &VSlimApp, req &VSlimRequest, trace_on bool, trace_base i64) (VSlimResponse, map[string]string, bool) {
	method := resolve_effective_method(req)
	path := RoutePath.normalize(req.path)
	mut method_not_allowed := false
	mut allowed_methods := []string{}
	dispatch_req := request_with_method(req, method)

	for route in app.routes {
		if route.handler_type != .php_callable {
			continue
		}
		ok, params := route.matches(path)
		if !ok {
			continue
		}
		allowed_methods = collect_allowed_methods(allowed_methods, route.method)
		if route.method != '*' && route.method != method && !(method == 'HEAD'
			&& route.method == 'GET') {
			method_not_allowed = true
			continue
		}
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.matched', trace_base)
		}
		payload := build_php_request_object(&dispatch_req, params)
		if validation := validate_request_payload(app, &dispatch_req, vphp.BorrowedZVal.from_zval(payload)) {
			return apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
				validation), params, true
		}
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.after_build_payload', trace_base)
		}
		route_before := matching_group_before_hooks(app, path)
		before_res := run_php_before_hooks(app, route_before, vphp.BorrowedZVal.from_zval(payload))
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.after_before_hooks', trace_base)
		}
		if before_res.is_valid() && !before_res.is_null() && !before_res.is_undef() {
			res := normalize_or_handle_error(app, vphp.BorrowedZVal.from_zval(payload),
				vphp.BorrowedZVal.from_zval(before_res), 500, 'Invalid route response')
			return apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
				res), params, true
		}
		route_middle := matching_group_middle_hooks(app, path)
		raw_res := dispatch_php_middleware_chain(app, path, vphp.BorrowedZVal.from_zval(payload),
			route_middle, route.php_handler) or {
			msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
			res := run_error_handler(app, vphp.BorrowedZVal.from_zval(payload), 500, msg) or {
				default_error_response(app, 500, msg, 'handler_not_callable')
			}
			return apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
				res), params, true
		}
		mut handled_raw := raw_res
		if !handled_raw.is_valid() || handled_raw.is_null() || handled_raw.is_undef() {
			missing_raw := dispatch_resource_missing(route, vphp.BorrowedZVal.from_zval(payload),
				params)
			if missing_raw.is_valid() && !missing_raw.is_null() && !missing_raw.is_undef() {
				handled_raw = missing_raw
			} else {
				res := run_not_found_core(app, vphp.BorrowedZVal.from_zval(payload))
				return apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
					res), params, true
			}
		}
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.after_middleware_chain', trace_base)
		}
		res := normalize_or_handle_error(app, vphp.BorrowedZVal.from_zval(payload), vphp.BorrowedZVal.from_zval(handled_raw),
			500, 'Invalid route response')
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.after_normalize', trace_base)
		}
		return apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
			res), params, true
	}

	if method == 'OPTIONS' && allowed_methods.len > 0 {
		mut allow := allowed_methods.clone()
		if 'OPTIONS' !in allow {
			allow << 'OPTIONS'
		}
		payload := build_php_request_object(&dispatch_req, map[string]string{})
		mut res := VSlimResponse{
			status:       204
			body:         ''
			content_type: 'text/plain; charset=utf-8'
			headers:      {
				'content-type': 'text/plain; charset=utf-8'
				'allow':        allow.join(', ')
			}
		}
		res = apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload), res)
		return res, map[string]string{}, true
	}

	if method_not_allowed {
		payload := build_php_request_object(&dispatch_req, map[string]string{})
		mut res := run_error_handler(app, vphp.BorrowedZVal.from_zval(payload), 405, 'Method not allowed') or {
			method_not_allowed_response()
		}
		if allowed_methods.len > 0 && 'allow' !in res.headers {
			res.headers['allow'] = allowed_methods.join(', ')
		}
		return apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
			res), map[string]string{}, true
	}
	payload := build_php_request_object(&dispatch_req, map[string]string{})
	before_res := run_php_before_hooks(app, matching_group_before_hooks(app, path), vphp.BorrowedZVal.from_zval(payload))
	if before_res.is_valid() && !before_res.is_null() && !before_res.is_undef() {
		res := normalize_or_handle_error(app, vphp.BorrowedZVal.from_zval(payload), vphp.BorrowedZVal.from_zval(before_res),
			500, 'Invalid route response')
		return apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
			res), map[string]string{}, true
	}
	route_middle := matching_group_middle_hooks(app, path)
	if app.php_middlewares.len > 0 || route_middle.len > 0 {
		terminal := run_not_found_core(app, vphp.BorrowedZVal.from_zval(payload))
		raw_res := dispatch_php_middleware_chain_terminal(app, path, vphp.BorrowedZVal.from_zval(payload),
			route_middle, terminal) or {
			msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
			res := run_error_handler(app, vphp.BorrowedZVal.from_zval(payload), 500, msg) or {
				default_error_response(app, 500, msg, 'handler_not_callable')
			}
			return apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
				res), map[string]string{}, true
		}
		res := normalize_or_handle_error(app, vphp.BorrowedZVal.from_zval(payload), vphp.BorrowedZVal.from_zval(raw_res),
			500, 'Invalid route response')
		return apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
			res), map[string]string{}, true
	}
	return VSlimResponse{}, map[string]string{}, false
}

fn dispatch_php_routes_worker_with_params(app &VSlimApp, req &VSlimRequest) (vphp.ZVal, map[string]string, bool) {
	method := resolve_effective_method(req)
	path := RoutePath.normalize(req.path)
	mut method_not_allowed := false
	mut allowed_methods := []string{}
	dispatch_req := request_with_method(req, method)

	for route in app.routes {
		if route.handler_type != .php_callable {
			continue
		}
		ok, params := route.matches(path)
		if !ok {
			continue
		}
		allowed_methods = collect_allowed_methods(allowed_methods, route.method)
		if route.method != '*' && route.method != method && !(method == 'HEAD'
			&& route.method == 'GET') {
			method_not_allowed = true
			continue
		}
		payload := build_php_request_object(&dispatch_req, params)
		if validation := validate_request_payload(app, &dispatch_req, vphp.BorrowedZVal.from_zval(payload)) {
			return build_php_response_object(apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
				validation)), params, true
		}
		route_before := matching_group_before_hooks(app, path)
		before_res := run_php_before_hooks(app, route_before, vphp.BorrowedZVal.from_zval(payload))
		if before_res.is_valid() && !before_res.is_null() && !before_res.is_undef() {
			if is_worker_stream_response_borrowed(vphp.BorrowedZVal.from_zval(before_res)) {
				return before_res, params, true
			}
			res := normalize_or_handle_error(app, vphp.BorrowedZVal.from_zval(payload),
				vphp.BorrowedZVal.from_zval(before_res), 500, 'Invalid route response')
			return build_php_response_object(apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
				res)), params, true
		}
		route_middle := matching_group_middle_hooks(app, path)
		raw_res := dispatch_php_middleware_chain(app, path, vphp.BorrowedZVal.from_zval(payload),
			route_middle, route.php_handler) or {
			msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
			res := run_error_handler(app, vphp.BorrowedZVal.from_zval(payload), 500, msg) or {
				default_error_response(app, 500, msg, 'handler_not_callable')
			}
			return build_php_response_object(apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
				res)), params, true
		}
		mut handled_raw := raw_res
		if !handled_raw.is_valid() || handled_raw.is_null() || handled_raw.is_undef() {
			missing_raw := dispatch_resource_missing(route, vphp.BorrowedZVal.from_zval(payload),
				params)
			if missing_raw.is_valid() && !missing_raw.is_null() && !missing_raw.is_undef() {
				handled_raw = missing_raw
			} else {
				return build_php_response_object(apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
					run_not_found_core(app, vphp.BorrowedZVal.from_zval(payload)))), params, true
			}
		}
		if is_worker_stream_response_borrowed(vphp.BorrowedZVal.from_zval(handled_raw)) {
			return handled_raw, params, true
		}
		res := normalize_or_handle_error(app, vphp.BorrowedZVal.from_zval(payload), vphp.BorrowedZVal.from_zval(handled_raw),
			500, 'Invalid route response')
		return build_php_response_object(apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
			res)), params, true
	}

	if method == 'OPTIONS' && allowed_methods.len > 0 {
		mut allow := allowed_methods.clone()
		if 'OPTIONS' !in allow {
			allow << 'OPTIONS'
		}
		payload := build_php_request_object(&dispatch_req, map[string]string{})
		mut res := VSlimResponse{
			status:       204
			body:         ''
			content_type: 'text/plain; charset=utf-8'
			headers:      {
				'content-type': 'text/plain; charset=utf-8'
				'allow':        allow.join(', ')
			}
		}
		res = apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload), res)
		return build_php_response_object(res), map[string]string{}, true
	}

	if method_not_allowed {
		payload := build_php_request_object(&dispatch_req, map[string]string{})
		mut res := run_error_handler(app, vphp.BorrowedZVal.from_zval(payload), 405, 'Method not allowed') or {
			method_not_allowed_response()
		}
		if allowed_methods.len > 0 && 'allow' !in res.headers {
			res.headers['allow'] = allowed_methods.join(', ')
		}
		return build_php_response_object(apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
			res)), map[string]string{}, true
	}
	payload := build_php_request_object(&dispatch_req, map[string]string{})
	before_res := run_php_before_hooks(app, matching_group_before_hooks(app, path), vphp.BorrowedZVal.from_zval(payload))
	if before_res.is_valid() && !before_res.is_null() && !before_res.is_undef() {
		if is_worker_stream_response_borrowed(vphp.BorrowedZVal.from_zval(before_res)) {
			return before_res, map[string]string{}, true
		}
		res := normalize_or_handle_error(app, vphp.BorrowedZVal.from_zval(payload), vphp.BorrowedZVal.from_zval(before_res),
			500, 'Invalid route response')
		return build_php_response_object(apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
			res)), map[string]string{}, true
	}
	route_middle := matching_group_middle_hooks(app, path)
	if app.php_middlewares.len > 0 || route_middle.len > 0 {
		terminal := run_not_found_core(app, vphp.BorrowedZVal.from_zval(payload))
		raw_res := dispatch_php_middleware_chain_terminal(app, path, vphp.BorrowedZVal.from_zval(payload),
			route_middle, terminal) or {
			msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
			res := run_error_handler(app, vphp.BorrowedZVal.from_zval(payload), 500, msg) or {
				default_error_response(app, 500, msg, 'handler_not_callable')
			}
			return build_php_response_object(apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
				res)), map[string]string{}, true
		}
		if is_worker_stream_response_borrowed(vphp.BorrowedZVal.from_zval(raw_res)) {
			return raw_res, map[string]string{}, true
		}
		res := normalize_or_handle_error(app, vphp.BorrowedZVal.from_zval(payload), vphp.BorrowedZVal.from_zval(raw_res),
			500, 'Invalid route response')
		return build_php_response_object(apply_php_after_hooks(app, path, vphp.BorrowedZVal.from_zval(payload),
			res)), map[string]string{}, true
	}
	return vphp.RequestOwnedZVal.new_null().to_zval(), map[string]string{}, false
}

fn dispatch_resource_missing(route VSlimRoute, request_payload vphp.BorrowedZVal, params map[string]string) vphp.ZVal {
	if !route.resource_missing_handler.is_valid() {
		return vphp.RequestOwnedZVal.new_null().to_zval()
	}
	missing := route.resource_missing_handler.borrowed()
	if !missing.is_valid() || !missing.is_callable() {
		return vphp.RequestOwnedZVal.new_null().to_zval()
	}
	params_z := vphp.new_zval_from[map[string]string](params) or {
		vphp.RequestOwnedZVal.new_null().to_zval()
	}
	action_z := vphp.RequestOwnedZVal.new_string(route.resource_action).to_zval()
	return missing.call_owned_request([request_payload.to_zval(), action_z, params_z])
}

fn vslim_max_body_bytes() int {
	raw := os.getenv('VSLIM_MAX_BODY_BYTES').trim_space()
	if raw == '' {
		return 0
	}
	max_bytes := raw.int()
	if max_bytes <= 0 {
		return 0
	}
	return max_bytes
}

fn validate_request_payload(app &VSlimApp, req &VSlimRequest, request_payload vphp.BorrowedZVal) ?VSlimResponse {
	max_bytes := vslim_max_body_bytes()
	if max_bytes > 0 && req.body.len > max_bytes {
		return run_error_handler(app, request_payload, 413, 'Payload too large') or {
			default_error_response(app, 413, 'Payload Too Large', 'payload_too_large')
		}
	}
	parse_msg := req.parse_error()
	if parse_msg != '' {
		return run_error_handler(app, request_payload, 400, 'Bad Request: invalid JSON body') or {
			default_error_response(app, 400, 'Bad Request: invalid JSON body', 'bad_json_body')
		}
	}
	return none
}

fn dispatch_php_before_hooks(app &VSlimApp, route_before []vphp.PersistentOwnedZVal, payload vphp.BorrowedZVal, index int) vphp.ZVal {
	total := app.php_before_hooks.len + route_before.len
	if index >= total {
		return unsafe {
			vphp.ZVal{
				raw: 0
			}
		}
	}
	hook := if index < app.php_before_hooks.len {
		app.php_before_hooks[index]
	} else {
		route_before[index - app.php_before_hooks.len]
	}
	res := hook.call_owned_request([payload.to_zval()])
	if !res.is_valid() || res.is_null() || res.is_undef() {
		return dispatch_php_before_hooks(app, route_before, payload, index + 1)
	}
	return res
}

fn run_php_before_hooks(app &VSlimApp, route_before []vphp.PersistentOwnedZVal, payload vphp.BorrowedZVal) vphp.ZVal {
	if app.php_before_hooks.len == 0 && route_before.len == 0 {
		return unsafe {
			vphp.ZVal{
				raw: 0
			}
		}
	}
	return dispatch_php_before_hooks(app, route_before, payload, 0)
}

fn matching_group_before_hooks(app &VSlimApp, path string) []vphp.PersistentOwnedZVal {
	mut out := []vphp.PersistentOwnedZVal{}
	for item in app.php_group_before {
		if path_has_prefix(path, item.prefix) {
			out << item.handler
		}
	}
	return out
}

fn matching_group_after_hooks(app &VSlimApp, path string) []vphp.PersistentOwnedZVal {
	mut out := []vphp.PersistentOwnedZVal{}
	for item in app.php_group_after {
		if path_has_prefix(path, item.prefix) {
			out << item.handler
		}
	}
	return out
}

fn matching_group_middle_hooks(app &VSlimApp, path string) []vphp.PersistentOwnedZVal {
	mut out := []vphp.PersistentOwnedZVal{}
	for item in app.php_group_middle {
		if path_has_prefix(path, item.prefix) {
			out << item.handler
		}
	}
	return out
}

fn path_has_prefix(path string, prefix string) bool {
	if prefix == '' {
		return true
	}
	if path == prefix {
		return true
	}
	return path.starts_with(prefix + '/')
}

fn build_php_request_object(req &VSlimRequest, params map[string]string) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZVal.new_null().to_zval()
		mut bound := &VSlimRequest{
			method:           req.method
			raw_path:         req.raw_path
			path:             req.path
			body:             req.body
			query_string:     req.query_string
			scheme:           req.scheme
			host:             req.host
			port:             req.port
			protocol_version: req.protocol_version
			remote_addr:      req.remote_addr
			query:            req.query.clone()
			headers:          req.headers.clone()
			cookies:          req.cookies.clone()
			attributes:       req.attributes.clone()
			server:           req.server.clone()
			uploaded_files:   req.uploaded_files.clone()
			params:           params.clone()
		}
		C.vphp_return_obj(payload.raw, bound, C.vslim__request_ce)
		C.vphp_bind_handlers(C.vphp_get_obj_from_zval(payload.raw), &C.vphp_class_handlers(vslimrequest_handlers()))
		return payload
	}
}

fn build_php_response_object(res VSlimResponse) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZVal.new_null().to_zval()
		bound := to_vslim_response(res)
		C.vphp_return_obj(payload.raw, bound, C.vslim__response_ce)
		C.vphp_bind_handlers(C.vphp_get_obj_from_zval(payload.raw), &C.vphp_class_handlers(vslimresponse_handlers()))
		return payload
	}
}

fn dispatch_php_middleware_chain(app &VSlimApp, path string, payload vphp.BorrowedZVal, route_middle []vphp.PersistentOwnedZVal, route_handler vphp.PersistentOwnedZVal) !vphp.ZVal {
	return dispatch_php_middleware_chain_with_terminal(app, path, payload, route_middle,
		route_handler, VSlimResponse{}, false)
}

fn dispatch_php_middleware_chain_terminal(app &VSlimApp, path string, payload vphp.BorrowedZVal, route_middle []vphp.PersistentOwnedZVal, terminal VSlimResponse) !vphp.ZVal {
	return dispatch_php_middleware_chain_with_terminal(app, path, payload, route_middle,
		vphp.PersistentOwnedZVal.new_null(), terminal, true)
}

fn dispatch_php_middleware_chain_with_terminal(app &VSlimApp, path string, payload vphp.BorrowedZVal, route_middle []vphp.PersistentOwnedZVal, route_handler vphp.PersistentOwnedZVal, terminal VSlimResponse, has_terminal bool) !vphp.ZVal {
	if app.php_middlewares.len == 0 && route_middle.len == 0 {
		if has_terminal {
			return build_php_response_object(terminal)
		}
		return dispatch_route_handler(app, route_handler.borrowed(), payload)
	}
	mut middlewares := []vphp.RequestOwnedZVal{}
	for hook in app.php_middlewares {
		middlewares << hook.clone_request_owned()
	}
	for hook in route_middle {
		middlewares << hook.clone_request_owned()
	}
	mut chain := MiddlewareChain{
		app:               app
		path:              path
		middlewares:       middlewares
		route_handler:     route_handler.clone_request_owned()
		has_terminal:      has_terminal
		terminal_response: terminal
	}
	return chain.dispatch(payload)
}

fn (mut chain MiddlewareChain) dispatch(payload vphp.BorrowedZVal) !vphp.ZVal {
	if chain.index >= chain.middlewares.len {
		if chain.has_terminal {
			return build_php_response_object(chain.terminal_response)
		}
		return dispatch_route_handler(chain.app, chain.route_handler.borrowed(), payload)
	}
	mw := chain.middlewares[chain.index]
	chain.index++
	raw := with_active_middleware_chain(chain, fn [payload, mw] () vphp.ZVal {
		return mw.call_owned_request([payload.to_zval(), vphp.RequestOwnedZVal.new_string('vslim_middleware_next').to_zval()])
	})
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('Middleware must return a response')
	}
	return raw
}

fn with_active_middleware_chain(chain &MiddlewareChain, invoke fn () vphp.ZVal) vphp.ZVal {
	unsafe {
		active_middleware_chains << chain
		defer {
			if active_middleware_chains.len > 0 {
				active_middleware_chains = active_middleware_chains[..active_middleware_chains.len - 1]
			}
		}
		return invoke()
	}
}

fn invoke_active_middleware_next(_request_payload vphp.ZVal) vphp.ZVal {
	unsafe {
		if active_middleware_chains.len == 0 {
			return vphp.RequestOwnedZVal.new_null().to_zval()
		}
		mut chain := active_middleware_chains[active_middleware_chains.len - 1]
		payload := vphp.BorrowedZVal.from_zval(_request_payload)
		raw := chain.dispatch(payload) or {
			msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
			res := run_error_handler(chain.app, payload, 500, msg) or {
				default_error_response(chain.app, 500, msg, 'handler_not_callable')
			}
			return build_php_response_object(res)
		}
		res := normalize_or_handle_error(chain.app, payload, vphp.BorrowedZVal.from_zval(raw),
			500, 'Invalid route response')
		return build_php_response_object(res)
	}
}

fn apply_php_after_hooks(app &VSlimApp, path string, request_payload vphp.BorrowedZVal, initial VSlimResponse) VSlimResponse {
	if app.php_after_hooks.len == 0 && app.php_group_after.len == 0 {
		return initial
	}
	mut current := initial
	group_after := matching_group_after_hooks(app, path)
	total := app.php_after_hooks.len + group_after.len
	for i in 0 .. total {
		hook := if i < app.php_after_hooks.len {
			app.php_after_hooks[i]
		} else {
			group_after[i - app.php_after_hooks.len]
		}
		response_payload := build_php_response_object(current)
		res := hook.call_owned_request([request_payload.to_zval(), response_payload])
		if res.is_valid() && !res.is_null() && !res.is_undef() {
			current = normalize_or_handle_error(app, request_payload, vphp.BorrowedZVal.from_zval(res),
				500, 'Invalid route response')
		}
	}
	return current
}

fn normalize_or_handle_error(app &VSlimApp, request_payload vphp.BorrowedZVal, result vphp.BorrowedZVal, fallback_status int, fallback_message string) VSlimResponse {
	res, ok := normalize_php_route_response_borrowed(result)
	if ok {
		return res
	}
	handled := run_error_handler(app, request_payload, fallback_status, fallback_message) or {
		return default_error_response(app, fallback_status, fallback_message, 'invalid_response')
	}
	return handled
}

fn run_not_found(app &VSlimApp, req &VSlimRequest) VSlimResponse {
	payload := build_php_request_object(req, map[string]string{})
	path := RoutePath.normalize(req.path)
	b_payload := vphp.BorrowedZVal.from_zval(payload)
	res := run_not_found_core(app, b_payload)
	return apply_php_after_hooks(app, path, b_payload, res)
}

fn run_not_found_core(app &VSlimApp, payload vphp.BorrowedZVal) VSlimResponse {
	nf := app.not_found_handler
	if nf.is_valid() && nf.is_callable() {
		raw := nf.call_owned_request([payload.to_zval()])
		return normalize_or_handle_error(app, payload, vphp.BorrowedZVal.from_zval(raw),
			404, 'Not Found')
	}
	return default_error_response(app, 404, 'Not Found', 'not_found')
}

fn run_error_handler(app &VSlimApp, request_payload vphp.BorrowedZVal, status int, message string) ?VSlimResponse {
	eh := app.error_handler
	if !eh.is_valid() || !eh.is_callable() {
		return none
	}
	raw := eh.call_owned_request([
		request_payload.to_zval(),
		vphp.RequestOwnedZVal.new_string(message).to_zval(),
		vphp.RequestOwnedZVal.new_int(status).to_zval(),
	])
	res, ok := normalize_php_route_response_borrowed(vphp.BorrowedZVal.from_zval(raw))
	if !ok {
		return none
	}
	return res
}

fn default_error_response(app &VSlimApp, status int, message string, error_code string) VSlimResponse {
	if app.error_response_json {
		esc_code := json_escape(error_code)
		return json_response(status, '{"ok":false,"code":"${esc_code}","error":"${esc_code}","status":${status},"message":"${json_escape(message)}"}')
	}
	return text_response(status, message)
}

fn json_escape(input string) string {
	return input.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r',
		'\\r').replace('\t', '\\t')
}

fn is_supported_route_handler(handler vphp.BorrowedZVal) bool {
	if !handler.is_valid() {
		return false
	}
	if handler.is_callable() || handler.is_string() || handler.is_array() {
		return true
	}
	raw := handler.to_zval()
	if !raw.is_object() {
		return false
	}
	return raw.method_exists('__invoke') || raw.method_exists('handle_request')
		|| raw.method_exists('mount') || raw.method_exists('render')
}

fn is_supported_websocket_handler(handler vphp.BorrowedZVal) bool {
	if !handler.is_valid() {
		return false
	}
	raw := handler.to_zval()
	if handler.is_callable() || handler.is_string() || handler.is_array() {
		return true
	}
	if !raw.is_object() {
		return false
	}
	return raw.method_exists('handle_websocket') || raw.method_exists('on_open')
		|| raw.method_exists('on_message') || raw.method_exists('on_close')
		|| raw.method_exists('mount') || raw.method_exists('render')
		|| raw.method_exists('live_marker')
}

fn dispatch_route_handler(app &VSlimApp, handler vphp.BorrowedZVal, payload vphp.BorrowedZVal) !vphp.ZVal {
	if !handler.is_valid() {
		return error('Invalid route handler')
	}
	if handler.is_callable() {
		return handler.call_owned_request([payload.to_zval()])
	}
	if handler.is_string() && app.has_container() {
		resolved := resolve_container_service(app, handler.to_string()) or {
			return error('Container service "${handler.to_string()}" not found')
		}
		if resolved.is_callable() {
			return resolved.call_owned_request([payload.to_zval()])
		}
		if resolved.is_object() && resolved.method_exists('__invoke') {
			return resolved.method_owned_request('__invoke', [
				payload.to_zval(),
			])
		}
		return error('Container service "${handler.to_string()}" is not callable')
	}
	if handler.is_array() && app.has_container() {
		parts := handler.to_string_list()
		if parts.len == 1 && parts[0] != '' {
			service := resolve_container_service(app, parts[0]) or {
				return error('Container service "${parts[0]}" not found')
			}
			if service.is_callable() {
				return service.call_owned_request([payload.to_zval()])
			}
			if service.is_object() && service.method_exists('__invoke') {
				return service.method_owned_request('__invoke', [
					payload.to_zval(),
				])
			}
			return error('Container service "${parts[0]}" is not callable')
		}
		if parts.len == 2 && parts[0] != '' {
			service := resolve_container_service(app, parts[0]) or {
				return error('Container service "${parts[0]}" not found')
			}
			method := if parts[1] == '' { '__invoke' } else { parts[1] }
			if service.is_object() && service.method_exists(method) {
				return service.method_owned_request(method, [
					payload.to_zval(),
				])
			}
			return error('Container service "${parts[0]}" has no method "${method}"')
		}
		return error('Invalid container array handler')
	}
	raw := handler.to_zval()
	if raw.is_object() {
		if raw.method_exists('handle_request') {
			return raw.method_owned_request('handle_request', [
				payload.to_zval(),
			])
		}
		if raw.method_exists('mount') || raw.method_exists('render') {
			return dispatch_live_route_handler(raw, payload)
		}
		if raw.method_exists('__invoke') {
			return raw.method_owned_request('__invoke', [
				payload.to_zval(),
			])
		}
	}
	return error('Route handler is not callable')
}

fn dispatch_live_route_handler(handler vphp.ZVal, payload vphp.BorrowedZVal) !vphp.ZVal {
	socket := vphp.php_class('VSlim\\Live\\Socket').construct([])
	if !socket.is_valid() || !socket.is_object() {
		return error('Live socket bootstrap failed')
	}
	if handler.method_exists('mount') {
		mount_res := handler.method_owned_request('mount', [
			payload.to_zval(),
			socket,
		])
		if mount_res.is_valid() && !mount_res.is_null() && !mount_res.is_undef() {
			return mount_res
		}
	}
	if handler.method_exists('render') {
		res := handler.method_owned_request('render', [
			payload.to_zval(),
			socket,
		])
		if res.is_string() {
			return build_php_response_object(VSlimResponse{
				status:       200
				body:         res.get_string()
				content_type: 'text/html; charset=utf-8'
				headers:      {
					'content-type': 'text/html; charset=utf-8'
				}
			})
		}
		return res
	}
	if handler.method_exists('__invoke') {
		return handler.method_owned_request('__invoke', [
			payload.to_zval(),
			socket,
		])
	}
	return error('Live handler must define render() or __invoke()')
}

fn dispatch_live_websocket_handler(mut app VSlimApp, handler vphp.ZVal, event string, frame vphp.ZVal, conn vphp.ZVal) vphp.ZVal {
	if !handler.is_object() {
		return vphp.RequestOwnedZVal.new_null().to_zval()
	}
	match event {
		'open' {
			if conn.is_object() && conn.method_exists('accept') {
				_ = conn.method_owned_request('accept', [])
			}
			return vphp.RequestOwnedZVal.new_null().to_zval()
		}
		'message' {
			data := zval_string_key(frame, 'data', '')
			message := decode_live_message(data) or {
				return vphp.RequestOwnedZVal.new_string(live_protocol_error('invalid_json',
					'Invalid JSON message')).to_zval()
			}
			match zval_string_key(message, 'type', '') {
				'join' {
					return vphp.RequestOwnedZVal.new_string(dispatch_live_join(mut app,
						handler, frame, conn, message)).to_zval()
				}
				'event' {
					return vphp.RequestOwnedZVal.new_string(dispatch_live_event(mut app,
						handler, frame, conn, message)).to_zval()
				}
				'heartbeat' {
					return vphp.RequestOwnedZVal.new_string(live_heartbeat_response()).to_zval()
				}
				else {
					return vphp.RequestOwnedZVal.new_string(live_protocol_error('unsupported_type',
						'Unsupported live message type')).to_zval()
				}
			}
		}
		'info' {
			data := zval_string_key(frame, 'data', '')
			message := decode_live_message(data) or {
				return vphp.RequestOwnedZVal.new_string(live_protocol_error('invalid_info',
					'Invalid info message')).to_zval()
			}
			return vphp.RequestOwnedZVal.new_string(dispatch_live_info(mut app, handler,
				frame, conn, message)).to_zval()
		}
		'close' {
			conn_id := zval_string_key(frame, 'id', '').trim_space()
			clear_live_socket_state(conn)
			if conn_id != '' && conn_id in app.live_ws_sockets {
				app.live_ws_sockets.delete(conn_id)
			}
			return vphp.RequestOwnedZVal.new_null().to_zval()
		}
		else {
			return vphp.RequestOwnedZVal.new_null().to_zval()
		}
	}
}

fn dispatch_live_join(mut app VSlimApp, handler vphp.ZVal, frame vphp.ZVal, conn vphp.ZVal, message vphp.ZVal) string {
	socket_z, mut socket := live_socket_for_message(mut app, handler, frame, message)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := build_live_request(frame, message, socket)
	req_z := build_php_request_object(req, map[string]string{})
	if handler.method_exists('mount') {
		_ = handler.method_owned_request('mount', [req_z, socket_z])
	}
	persist_live_socket_state(handler, conn, socket)
	execute_live_socket_pubsub(conn, socket)
	html := render_live_html(handler, req_z, socket_z, socket)
	return live_patch_response(socket, html, live_default_root_id(handler, socket))
}

fn dispatch_live_event(mut app VSlimApp, handler vphp.ZVal, frame vphp.ZVal, conn vphp.ZVal, message vphp.ZVal) string {
	socket_z, mut socket := live_socket_for_event(mut app, handler, frame)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := build_live_request(frame, message, socket)
	req_z := build_php_request_object(req, map[string]string{})
	name_z := vphp.RequestOwnedZVal.new_string(zval_string_key(message, 'event', '')).to_zval()
	payload := zval_key(message, 'payload')
	if dispatch_live_component_event(handler, payload, name_z, socket_z) {
		// handled by target component
	} else if handler.method_exists('handle_event') {
		_ = handler.method_owned_request('handle_event', [name_z, payload, socket_z])
	} else if handler.method_exists('handleEvent') {
		_ = handler.method_owned_request('handleEvent', [name_z, payload, socket_z])
	}
	persist_live_socket_state(handler, conn, socket)
	execute_live_socket_pubsub(conn, socket)
	html := render_live_html(handler, req_z, socket_z, socket)
	return live_patch_response(socket, html, live_default_root_id(handler, socket))
}

fn dispatch_live_info(mut app VSlimApp, handler vphp.ZVal, frame vphp.ZVal, conn vphp.ZVal, message vphp.ZVal) string {
	socket_z, mut socket := live_socket_for_event(mut app, handler, frame)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := build_live_request(frame, message, socket)
	req_z := build_php_request_object(req, map[string]string{})
	mut payload := zval_key(message, 'payload')
	room := zval_string_key(frame, 'room', '').trim_space()
	if room != '' {
		payload = live_info_payload_with_topic(payload, room)
	}
	name_z := vphp.RequestOwnedZVal.new_string(zval_string_key(message, 'event', '')).to_zval()
	if dispatch_live_component_info(handler, payload, name_z, socket_z) {
		// handled by target component
	} else if handler.method_exists('handle_info') {
		_ = handler.method_owned_request('handle_info', [name_z, payload, socket_z])
	} else if handler.method_exists('handleInfo') {
		_ = handler.method_owned_request('handleInfo', [name_z, payload, socket_z])
	}
	persist_live_socket_state(handler, conn, socket)
	execute_live_socket_pubsub(conn, socket)
	html := render_live_html(handler, req_z, socket_z, socket)
	return live_patch_response(socket, html, live_default_root_id(handler, socket))
}

fn render_live_html(handler vphp.ZVal, req_z vphp.ZVal, socket_z vphp.ZVal, socket &VSlimLiveSocket) string {
	if handler.method_exists('render') {
		rendered := handler.method_owned_request('render', [req_z, socket_z])
		if rendered.is_string() {
			return rendered.to_string()
		}
		res, ok := normalize_php_route_response(rendered)
		if ok {
			return res.body
		}
	}
	if is_live_view_object(handler) {
		mut live := handler.to_object[VSlimLiveView]() or { return '' }
		return live.html(socket)
	}
	return ''
}

fn dispatch_live_component_event(handler vphp.ZVal, payload vphp.ZVal, event_name vphp.ZVal, socket_z vphp.ZVal) bool {
	target := live_component_target(payload)
	if target == '' {
		return false
	}
	target_z := vphp.RequestOwnedZVal.new_string(target).to_zval()
	if handler.method_exists('component') {
		component := handler.method_owned_request('component', [target_z, socket_z])
		if component.is_object() {
			bind_live_component_socket(component, socket_z)
		}
		if component.is_object() && live_component_handles_event(component) {
			if component.method_exists('handle_event') {
				_ = component.method_owned_request('handle_event', [event_name, payload, socket_z])
			} else if component.method_exists('handleEvent') {
				_ = component.method_owned_request('handleEvent', [event_name, payload, socket_z])
			}
			return true
		}
	}
	if handler.method_exists('handle_component_event') {
		_ = handler.method_owned_request('handle_component_event', [target_z, event_name, payload, socket_z])
		return true
	}
	if handler.method_exists('handleComponentEvent') {
		_ = handler.method_owned_request('handleComponentEvent', [target_z, event_name, payload, socket_z])
		return true
	}
	return false
}

fn dispatch_live_component_info(handler vphp.ZVal, payload vphp.ZVal, event_name vphp.ZVal, socket_z vphp.ZVal) bool {
	target := live_component_target(payload)
	if target == '' {
		return false
	}
	target_z := vphp.RequestOwnedZVal.new_string(target).to_zval()
	if handler.method_exists('component') {
		component := handler.method_owned_request('component', [target_z, socket_z])
		if component.is_object() {
			bind_live_component_socket(component, socket_z)
		}
		if component.is_object() && live_component_handles_info(component) {
			if component.method_exists('handle_info') {
				_ = component.method_owned_request('handle_info', [event_name, payload, socket_z])
			} else if component.method_exists('handleInfo') {
				_ = component.method_owned_request('handleInfo', [event_name, payload, socket_z])
			}
			return true
		}
	}
	if handler.method_exists('handle_component_info') {
		_ = handler.method_owned_request('handle_component_info', [target_z, event_name, payload, socket_z])
		return true
	}
	if handler.method_exists('handleComponentInfo') {
		_ = handler.method_owned_request('handleComponentInfo', [target_z, event_name, payload, socket_z])
		return true
	}
	return false
}

fn bind_live_component_socket(component vphp.ZVal, socket_z vphp.ZVal) {
	if !component.is_object() {
		return
	}
	if component.method_exists('bind_socket') {
		_ = component.method_owned_request('bind_socket', [socket_z])
		return
	}
	if component.method_exists('bindSocket') {
		_ = component.method_owned_request('bindSocket', [socket_z])
	}
}

fn live_component_target(payload vphp.ZVal) string {
	if !payload.is_valid() || payload.is_null() || payload.is_undef() || !payload.is_array() {
		return ''
	}
	target := zval_string_key(payload, 'target', '').trim_space()
	if !target.starts_with('component:') {
		return ''
	}
	return target.all_after('component:').trim_space()
}

fn live_component_handles_event(component vphp.ZVal) bool {
	if !component.is_object() {
		return false
	}
	return component.method_exists('handle_event') || component.method_exists('handleEvent')
}

fn live_component_handles_info(component vphp.ZVal) bool {
	if !component.is_object() {
		return false
	}
	return component.method_exists('handle_info') || component.method_exists('handleInfo')
}

fn build_live_request(frame vphp.ZVal, message vphp.ZVal, socket &VSlimLiveSocket) &VSlimRequest {
	raw_path := zval_string_key(message, 'path', socket.raw_path)
	mut req := new_vslim_request('GET', raw_path, '')
	req.set_headers(zval_key(frame, 'headers'))
	req.set_remote_addr(zval_string_key(frame, 'remote_addr', ''))
	req.set_scheme(zval_string_key(frame, 'scheme', ''))
	req.set_host(zval_string_key(frame, 'host', ''))
	req.set_port(zval_string_key(frame, 'port', ''))
	return req
}

fn live_socket_for_message(mut app VSlimApp, handler vphp.ZVal, frame vphp.ZVal, message vphp.ZVal) (vphp.ZVal, &VSlimLiveSocket) {
	if live_uses_dispatch(frame) {
		return live_socket_from_frame_metadata(handler, frame, message)
	}
	conn_id := zval_string_key(frame, 'id', '').trim_space()
	if conn_id != '' && conn_id in app.live_ws_sockets {
		socket_owned := app.live_ws_sockets[conn_id] or { vphp.PersistentOwnedZVal.new_null() }
		socket_z := socket_owned.clone_request_owned().to_zval()
		mut existing := socket_z.to_object[VSlimLiveSocket]() or { unsafe { nil } }
		if existing != unsafe { nil } {
			existing.connected = true
			existing.raw_path = live_normalize_target(zval_string_key(message, 'path',
				existing.raw_path))
			root_id := zval_string_key(message, 'root_id', existing.root_id)
			if root_id != '' {
				existing.root_id = root_id
			}
			return socket_z, existing
		}
	}
	socket_z := vphp.php_class('VSlim\\Live\\Socket').construct([])
	mut created := socket_z.to_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.RequestOwnedZVal.new_null().to_zval(), unsafe { nil }
	}
	created.id = conn_id
	created.connected = true
	created.raw_path = live_normalize_target(zval_string_key(message, 'path', zval_string_key(frame,
		'path', '/')))
	mut root_id := zval_string_key(message, 'root_id', '')
	if root_id == '' {
		root_id = live_view_root_id(handler)
	}
	created.root_id = root_id
	if conn_id != '' {
		app.live_ws_sockets[conn_id] = vphp.PersistentOwnedZVal.from_zval(socket_z)
	}
	return socket_z, created
}

fn live_socket_for_event(mut app VSlimApp, handler vphp.ZVal, frame vphp.ZVal) (vphp.ZVal, &VSlimLiveSocket) {
	if live_uses_dispatch(frame) {
		return live_socket_from_frame_metadata(handler, frame, zval_key(frame, 'metadata'))
	}
	conn_id := zval_string_key(frame, 'id', '').trim_space()
	if conn_id != '' && conn_id in app.live_ws_sockets {
		socket_owned := app.live_ws_sockets[conn_id] or { vphp.PersistentOwnedZVal.new_null() }
		socket_z := socket_owned.clone_request_owned().to_zval()
		mut existing := socket_z.to_object[VSlimLiveSocket]() or { unsafe { nil } }
		if existing != unsafe { nil } {
			existing.connected = true
			return socket_z, existing
		}
	}
	socket_z := vphp.php_class('VSlim\\Live\\Socket').construct([])
	mut created := socket_z.to_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.RequestOwnedZVal.new_null().to_zval(), unsafe { nil }
	}
	created.id = conn_id
	created.connected = true
	created.raw_path = live_normalize_target(zval_string_key(frame, 'path', '/'))
	created.root_id = live_view_root_id(handler)
	if conn_id != '' {
		app.live_ws_sockets[conn_id] = vphp.PersistentOwnedZVal.from_zval(socket_z)
	}
	return socket_z, created
}

fn live_uses_dispatch(frame vphp.ZVal) bool {
	return zval_string_key(frame, 'mode', '').trim_space().to_lower() == 'websocket_dispatch'
}

fn live_socket_from_frame_metadata(handler vphp.ZVal, frame vphp.ZVal, message vphp.ZVal) (vphp.ZVal, &VSlimLiveSocket) {
	socket_z := vphp.php_class('VSlim\\Live\\Socket').construct([])
	mut created := socket_z.to_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.RequestOwnedZVal.new_null().to_zval(), unsafe { nil }
	}
	created.id = zval_string_key(frame, 'id', '').trim_space()
	created.connected = true
	metadata := zval_key(frame, 'metadata')
	session_meta := decode_live_session_metadata(metadata)
	path_from_message := live_normalize_target(zval_string_key(message, 'path', ''))
	path_from_meta := live_normalize_target(session_meta['target'] or { '' })
	path_from_frame := live_normalize_target(zval_string_key(frame, 'path', '/'))
	if path_from_message != '' && path_from_message != '/' {
		created.raw_path = path_from_message
	} else if path_from_meta != '' && path_from_meta != '/' {
		created.raw_path = path_from_meta
	} else {
		created.raw_path = path_from_frame
	}
	root_from_message := zval_string_key(message, 'root_id', '').trim_space()
	root_from_meta := (session_meta['root_id'] or { '' }).trim_space()
	if root_from_message != '' {
		created.root_id = root_from_message
	} else if root_from_meta != '' {
		created.root_id = root_from_meta
	} else {
		created.root_id = live_view_root_id(handler)
	}
	for key, value in decode_live_assigns_metadata(metadata) {
		created.assign(key, vphp.RequestOwnedZVal.new_string(value).to_zval())
	}
	return socket_z, created
}

const live_meta_session_key = '_vslim_live_session'
const live_meta_assigns_key = '_vslim_live_assigns'
const live_meta_root_key = '_vslim_live_root'
const live_meta_path_key = '_vslim_live_path'

fn persist_live_socket_state(handler vphp.ZVal, conn vphp.ZVal, socket &VSlimLiveSocket) {
	if !conn.is_object() {
		return
	}
	session_json := encode_live_session(handler, socket)
	_ = conn.method_owned_request('setMeta', [
		vphp.RequestOwnedZVal.new_string(live_meta_session_key).to_zval(),
		vphp.RequestOwnedZVal.new_string(session_json).to_zval(),
	])
}

fn clear_live_socket_state(conn vphp.ZVal) {
	if !conn.is_object() {
		return
	}
	for key in [live_meta_session_key, live_meta_assigns_key, live_meta_root_key, live_meta_path_key] {
		_ = conn.method_owned_request('clearMeta', [
			vphp.RequestOwnedZVal.new_string(key).to_zval(),
		])
	}
}

fn decode_live_session_metadata(metadata vphp.ZVal) map[string]string {
	session_json := zval_string_key(metadata, live_meta_session_key, '').trim_space()
	if session_json == '' {
		return map[string]string{}
	}
	session_z := decode_live_message(session_json) or { vphp.RequestOwnedZVal.new_null().to_zval() }
	if !session_z.is_valid() || session_z.is_null() || session_z.is_undef() || !session_z.is_array() {
		return map[string]string{}
	}
	mut out := map[string]string{}
	for key in session_z.assoc_keys() {
		if key == 'assigns' {
			continue
		}
		out[key] = zval_key(session_z, key).to_string()
	}
	return out
}

fn decode_live_assigns_metadata(metadata vphp.ZVal) map[string]string {
	session_json := zval_string_key(metadata, live_meta_session_key, '').trim_space()
	if session_json != '' {
		session_z := decode_live_message(session_json) or { vphp.RequestOwnedZVal.new_null().to_zval() }
		assigns_z := zval_key(session_z, 'assigns')
		if assigns_z.is_valid() && !assigns_z.is_null() && !assigns_z.is_undef() && assigns_z.is_array() {
			return zval_string_map(assigns_z)
		}
	}
	assigns_json := zval_string_key(metadata, live_meta_assigns_key, '')
	if assigns_json.trim_space() == '' {
		return map[string]string{}
	}
	assigns_z := decode_live_message(assigns_json) or { vphp.RequestOwnedZVal.new_null().to_zval() }
	if assigns_z.is_valid() && !assigns_z.is_null() && !assigns_z.is_undef() && assigns_z.is_array() {
		return zval_string_map(assigns_z)
	}
	return map[string]string{}
}

fn encode_live_session(handler vphp.ZVal, socket &VSlimLiveSocket) string {
	mut out := new_array_zval()
	out.add_assoc_string('version', '1')
	out.add_assoc_string('view', handler.class_name().trim_space())
	out.add_assoc_string('root_id', socket.root_id.trim_space())
	out.add_assoc_string('target', socket.raw_path.trim_space())
	add_assoc_zval(out, 'assigns', encode_live_assigns_zval(socket))
	return json_encode_zval(out)
}

fn encode_live_assigns(socket &VSlimLiveSocket) string {
	return json_encode_zval(encode_live_assigns_zval(socket))
}

fn encode_live_assigns_zval(socket &VSlimLiveSocket) vphp.ZVal {
	mut out := new_array_zval()
	for key, value in socket.assigns {
		out.add_assoc_string(key, value)
	}
	return out
}

fn zval_string_map(value vphp.ZVal) map[string]string {
	mut out := map[string]string{}
	if !value.is_valid() || value.is_null() || value.is_undef() || !value.is_array() {
		return out
	}
	for key in value.assoc_keys() {
		out[key] = zval_key(value, key).to_string()
	}
	return out
}

fn live_default_root_id(handler vphp.ZVal, socket &VSlimLiveSocket) string {
	if socket.root_id.trim_space() != '' {
		return socket.root_id.trim_space()
	}
	root_id := live_view_root_id(handler)
	if root_id != '' {
		return root_id
	}
	return 'live-root'
}

fn live_view_root_id(handler vphp.ZVal) string {
	if !is_live_view_object(handler) {
		return ''
	}
	if live := handler.to_object[VSlimLiveView]() {
		return live.root_id.trim_space()
	}
	if handler.method_exists('root_id') {
		root := handler.method_owned_request('root_id', [])
		if root.is_valid() && !root.is_null() && !root.is_undef() {
			return root.to_string().trim_space()
		}
	}
	return ''
}

fn live_patch_response(socket &VSlimLiveSocket, html string, root_id string) string {
	mut ops := socket.patches.clone()
	if ops.len == 0 && html.trim_space() != '' {
		ops << {
			'op':   'replace'
			'id':   root_id
			'html': html
		}
	}
	mut out := new_array_zval()
	out.add_assoc_string('type', 'patch')
	mut ops_z := new_array_zval()
	for op in ops {
		mut row := new_array_zval()
		row.add_assoc_string('op', op['op'] or { '' })
		row.add_assoc_string('id', op['id'] or { '' })
		if 'html' in op {
			row.add_assoc_string('html', op['html'] or { '' })
		}
		if 'text' in op {
			row.add_assoc_string('text', op['text'] or { '' })
		}
		if 'name' in op {
			row.add_assoc_string('name', op['name'] or { '' })
		}
		if 'value' in op {
			row.add_assoc_string('value', op['value'] or { '' })
		}
		ops_z.add_next_val(row)
	}
	add_assoc_zval(out, 'ops', ops_z)
	mut events_z := new_array_zval()
	for event in socket.events {
		mut row := new_array_zval()
		row.add_assoc_string('event', event['event'] or { '' })
		payload := event['payload'] or { '' }
		if payload.trim_space() == '' {
			row.add_assoc_string('payload', '')
		} else {
			decoded_payload := decode_live_message(payload) or {
				row.add_assoc_string('payload', payload)
				events_z.add_next_val(row)
				continue
			}
			add_assoc_zval(row, 'payload', decoded_payload)
		}
		events_z.add_next_val(row)
	}
	add_assoc_zval(out, 'events', events_z)
	if socket.redirect_to.trim_space() != '' {
		out.add_assoc_string('redirect_to', socket.redirect_to)
	}
	if socket.navigate_to.trim_space() != '' {
		out.add_assoc_string('navigate_to', socket.navigate_to)
	}
	mut flash_z := new_array_zval()
	for item in socket.flashes {
		mut row := new_array_zval()
		row.add_assoc_string('kind', item['kind'] or { '' })
		row.add_assoc_string('message', item['message'] or { '' })
		flash_z.add_next_val(row)
	}
	add_assoc_zval(out, 'flash', flash_z)
	return json_encode_zval(out)
}

fn live_protocol_error(code string, message string) string {
	mut out := new_array_zval()
	out.add_assoc_string('type', 'error')
	out.add_assoc_string('error', code)
	out.add_assoc_string('message', message)
	return json_encode_zval(out)
}

fn execute_live_socket_pubsub(conn vphp.ZVal, socket &VSlimLiveSocket) {
	if !conn.is_object() {
		return
	}
	for cmd in socket.pubsub {
		match cmd['op'] or { '' } {
			'join' {
				if conn.method_exists('join') {
					_ = conn.method_owned_request('join', [
						vphp.RequestOwnedZVal.new_string(cmd['room'] or { '' }).to_zval(),
					])
				}
			}
			'leave' {
				if conn.method_exists('leave') {
					_ = conn.method_owned_request('leave', [
						vphp.RequestOwnedZVal.new_string(cmd['room'] or { '' }).to_zval(),
					])
				}
			}
			'broadcast_info' {
				if conn.method_exists('broadcastDispatch') {
					except_id := if (cmd['include_self'] or { 'false' }) == 'true' {
						''
					} else {
						socket.id
					}
					_ = conn.method_owned_request('broadcastDispatch', [
						vphp.RequestOwnedZVal.new_string(cmd['room'] or { '' }).to_zval(),
						vphp.RequestOwnedZVal.new_string(live_info_payload(cmd['event'] or { '' },
							cmd['payload'] or { '{}' })).to_zval(),
						vphp.RequestOwnedZVal.new_string(except_id).to_zval(),
					])
				}
			}
			else {}
		}
	}
}

fn live_info_payload(event string, payload_json string) string {
	mut out := new_array_zval()
	out.add_assoc_string('type', 'info')
	out.add_assoc_string('event', event.trim_space())
	decoded_payload := decode_live_message(payload_json) or { vphp.RequestOwnedZVal.new_null().to_zval() }
	if decoded_payload.is_valid() && !decoded_payload.is_null() && !decoded_payload.is_undef() {
		add_assoc_zval(out, 'payload', decoded_payload)
	} else {
		mut fallback := new_array_zval()
		fallback.add_assoc_string('value', payload_json)
		add_assoc_zval(out, 'payload', fallback)
	}
	return json_encode_zval(out)
}

fn live_info_payload_with_topic(payload vphp.ZVal, room string) vphp.ZVal {
	topic := room.trim_space()
	if topic == '' {
		return payload
	}
	mut out := new_array_zval()
	if payload.is_valid() && !payload.is_null() && !payload.is_undef() && payload.is_array() {
		if payload.is_list() {
			for idx := 0; idx < payload.array_count(); idx++ {
				out.add_next_val(payload.array_get(idx))
			}
		} else {
			for key in payload.assoc_keys() {
				add_assoc_zval(out, key, zval_key(payload, key))
			}
		}
	} else if payload.is_valid() && !payload.is_null() && !payload.is_undef() {
		add_assoc_zval(out, 'value', payload)
	}
	out.add_assoc_string('topic', topic)
	return out
}

fn live_heartbeat_response() string {
	mut out := new_array_zval()
	out.add_assoc_string('type', 'heartbeat')
	out.add_assoc_bool('ok', true)
	return json_encode_zval(out)
}

fn decode_live_message(raw string) ?vphp.ZVal {
	if raw.trim_space() == '' {
		return none
	}
	decoded := vphp.php_fn('json_decode').call_owned_request([
		vphp.RequestOwnedZVal.new_string(raw).to_zval(),
		vphp.RequestOwnedZVal.new_bool(true).to_zval(),
	])
	if !decoded.is_array() {
		return none
	}
	return decoded
}

fn is_live_view_object(handler vphp.ZVal) bool {
	if !handler.is_object() {
		return false
	}
	if handler.is_instance_of('VSlim\\Live\\View') || handler.is_instance_of('VSlimLiveView') {
		return true
	}
	class_name := handler.class_name().trim_space()
	return class_name == 'VSlim\\Live\\View' || class_name == 'VSlimLiveView'
}

fn bind_live_view_to_app(mut app VSlimApp, handler vphp.ZVal) {
	if !is_live_view_object(handler) {
		return
	}
	mut live := handler.to_object[VSlimLiveView]() or { return }
	live.set_app(app)
}

fn resolve_container_service(app &VSlimApp, service_id string) !vphp.ZVal {
	if service_id == '' {
		return error('empty service id')
	}
	unsafe {
		mut mutable_app := &VSlimApp(app)
		if mutable_app.container_ref == nil {
			return error('container is not configured')
		}
		mut container := mutable_app.container_ref
		resolved := container.get_entry(service_id) or {
			if !vphp.class_exists(service_id) {
				return error('container service not found')
			}
			created := vphp.php_class(service_id).construct([])
			if !created.is_valid() || !created.is_object() {
				return error('class "${service_id}" could not be instantiated')
			}
			container.set(service_id, created)
			created
		}
		return resolved
	}
}

fn request_with_method(req &VSlimRequest, method string) VSlimRequest {
	return VSlimRequest{
		method:           method
		raw_path:         req.raw_path
		path:             req.path
		body:             req.body
		query_string:     req.query_string
		scheme:           req.scheme
		host:             req.host
		port:             req.port
		protocol_version: req.protocol_version
		remote_addr:      req.remote_addr
		query:            req.query.clone()
		headers:          req.headers.clone()
		cookies:          req.cookies.clone()
		attributes:       req.attributes.clone()
		server:           req.server.clone()
		uploaded_files:   req.uploaded_files.clone()
		params:           req.params.clone()
	}
}

fn register_resource_routes(mut app VSlimApp, raw_resource_path string, controller string, include_page_routes bool) {
	register_resource_routes_with_options(mut app, raw_resource_path, controller, include_page_routes,
		ResourceRouteOptions{})
}

fn register_singleton_routes(mut app VSlimApp, raw_resource_path string, controller string, include_page_routes bool) {
	register_singleton_routes_with_options(mut app, raw_resource_path, controller, include_page_routes,
		ResourceRouteOptions{})
}

struct ResourceRouteOptions {
mut:
	only            map[string]bool
	except          map[string]bool
	names           map[string]string
	name_prefix     string
	param_name      string                   = 'id'
	shallow         bool
	missing_handler vphp.PersistentOwnedZVal = vphp.PersistentOwnedZVal.new_null()
}

fn register_resource_routes_with_options(mut app VSlimApp, raw_resource_path string, controller string, include_page_routes bool, options ResourceRouteOptions) {
	clean_controller := controller.trim_space()
	path := normalize_resource_path(raw_resource_path)
	if clean_controller == '' || path == '' {
		return
	}
	base_name := resource_name_from_path(path)
	mut opts := options
	actions := ['index', 'create', 'store', 'show', 'edit', 'update', 'destroy']
	handler_index := make_resource_handler(clean_controller, 'index')
	handler_show := make_resource_handler(clean_controller, 'show')
	handler_store := make_resource_handler(clean_controller, 'store')
	handler_update := make_resource_handler(clean_controller, 'update')
	handler_destroy := make_resource_handler(clean_controller, 'destroy')
	handler_create := make_resource_handler(clean_controller, 'create')
	handler_edit := make_resource_handler(clean_controller, 'edit')
	id_param := normalize_resource_param_name(opts.param_name)
	member_base_path := if opts.shallow { shallow_member_base_path(path) } else { path }
	id_path := '${member_base_path}/:${id_param}'
	if handler_index.is_valid() && should_include_resource_action(opts, 'index', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'index'), path, handler_index, 'index', opts.missing_handler)
	}
	if include_page_routes && handler_create.is_valid()
		&& should_include_resource_action(opts, 'create', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'create'), '${path}/create', handler_create, 'create', opts.missing_handler)
	}
	if handler_store.is_valid() && should_include_resource_action(opts, 'store', actions) {
		app.add_php_route_with_resource_meta('POST', resource_route_name(opts, base_name,
			'store'), path, handler_store, 'store', opts.missing_handler)
	}
	if handler_show.is_valid() && should_include_resource_action(opts, 'show', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'show'), id_path, handler_show, 'show', opts.missing_handler)
	}
	if include_page_routes && handler_edit.is_valid()
		&& should_include_resource_action(opts, 'edit', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'edit'), '${id_path}/edit', handler_edit, 'edit', opts.missing_handler)
	}
	if handler_update.is_valid() && should_include_resource_action(opts, 'update', actions) {
		name := resource_route_name(opts, base_name, 'update')
		app.add_php_route_with_resource_meta('PUT', name, id_path, handler_update, 'update',
			opts.missing_handler)
		app.add_php_route_with_resource_meta('PATCH', name, id_path, handler_update, 'update',
			opts.missing_handler)
	}
	if handler_destroy.is_valid() && should_include_resource_action(opts, 'destroy', actions) {
		app.add_php_route_with_resource_meta('DELETE', resource_route_name(opts, base_name,
			'destroy'), id_path, handler_destroy, 'destroy', opts.missing_handler)
	}
}

fn register_singleton_routes_with_options(mut app VSlimApp, raw_resource_path string, controller string, include_page_routes bool, options ResourceRouteOptions) {
	clean_controller := controller.trim_space()
	path := normalize_resource_path(raw_resource_path)
	if clean_controller == '' || path == '' {
		return
	}
	base_name := resource_name_from_path(path)
	opts := options
	actions := ['show', 'create', 'store', 'edit', 'update', 'destroy']
	handler_show := make_resource_handler(clean_controller, 'show')
	handler_store := make_resource_handler(clean_controller, 'store')
	handler_update := make_resource_handler(clean_controller, 'update')
	handler_destroy := make_resource_handler(clean_controller, 'destroy')
	handler_create := make_resource_handler(clean_controller, 'create')
	handler_edit := make_resource_handler(clean_controller, 'edit')
	if handler_show.is_valid() && should_include_resource_action(opts, 'show', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'show'), path, handler_show, 'show', opts.missing_handler)
	}
	if include_page_routes && handler_create.is_valid()
		&& should_include_resource_action(opts, 'create', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'create'), '${path}/create', handler_create, 'create', opts.missing_handler)
	}
	if handler_store.is_valid() && should_include_resource_action(opts, 'store', actions) {
		app.add_php_route_with_resource_meta('POST', resource_route_name(opts, base_name,
			'store'), path, handler_store, 'store', opts.missing_handler)
	}
	if include_page_routes && handler_edit.is_valid()
		&& should_include_resource_action(opts, 'edit', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'edit'), '${path}/edit', handler_edit, 'edit', opts.missing_handler)
	}
	if handler_update.is_valid() && should_include_resource_action(opts, 'update', actions) {
		name := resource_route_name(opts, base_name, 'update')
		app.add_php_route_with_resource_meta('PUT', name, path, handler_update, 'update',
			opts.missing_handler)
		app.add_php_route_with_resource_meta('PATCH', name, path, handler_update, 'update',
			opts.missing_handler)
	}
	if handler_destroy.is_valid() && should_include_resource_action(opts, 'destroy', actions) {
		app.add_php_route_with_resource_meta('DELETE', resource_route_name(opts, base_name,
			'destroy'), path, handler_destroy, 'destroy', opts.missing_handler)
	}
}

fn make_resource_handler(controller string, action string) vphp.ZVal {
	if controller.trim_space() == '' || action.trim_space() == '' {
		return vphp.ZVal.new_null()
	}
	if vphp.class_exists(controller) {
		exists := vphp.call_php('method_exists', [
			vphp.RequestOwnedZVal.new_string(controller).to_zval(),
			vphp.RequestOwnedZVal.new_string(action).to_zval(),
		])
		if !exists.is_valid() || !exists.to_bool() {
			return vphp.ZVal.new_null()
		}
	}
	handler := vphp.new_zval_from[[]string]([controller, action]) or { return vphp.ZVal.new_null() }
	return handler
}

fn normalize_resource_path(path string) string {
	mut clean := path.trim_space()
	if clean == '' {
		return ''
	}
	if !clean.starts_with('/') {
		clean = '/${clean}'
	}
	clean = clean.trim_right('/')
	if clean == '' {
		return '/'
	}
	return clean
}

fn resource_name_from_path(path string) string {
	mut clean := path.trim_space()
	if clean.starts_with('/') {
		clean = clean[1..]
	}
	if clean == '' {
		return 'resource'
	}
	return clean.replace('/', '.')
}

fn parse_resource_options(options vphp.BorrowedZVal) ResourceRouteOptions {
	mut out := ResourceRouteOptions{
		only:            map[string]bool{}
		except:          map[string]bool{}
		names:           map[string]string{}
		name_prefix:     ''
		param_name:      'id'
		shallow:         false
		missing_handler: vphp.PersistentOwnedZVal.new_null()
	}
	if !options.is_valid() || !options.is_array() {
		return out
	}
	only_raw := options.to_zval().get('only') or { vphp.ZVal.new_null() }
	except_raw := options.to_zval().get('except') or { vphp.ZVal.new_null() }
	name_prefix_raw := options.to_zval().get('name_prefix') or { vphp.ZVal.new_null() }
	if name_prefix_raw.is_valid() && !name_prefix_raw.is_null() && !name_prefix_raw.is_undef() {
		out.name_prefix = name_prefix_raw.to_string().trim_space()
	}
	param_raw := options.to_zval().get('param') or { vphp.ZVal.new_null() }
	if param_raw.is_valid() && !param_raw.is_null() && !param_raw.is_undef() {
		out.param_name = normalize_resource_param_name(param_raw.to_string())
	}
	shallow_raw := options.to_zval().get('shallow') or { vphp.ZVal.new_null() }
	if shallow_raw.is_valid() && !shallow_raw.is_null() && !shallow_raw.is_undef() {
		out.shallow = parse_resource_bool_option(shallow_raw)
	}
	missing_raw := options.to_zval().get('missing') or { vphp.ZVal.new_null() }
	if missing_raw.is_valid() && missing_raw.is_callable() {
		out.missing_handler = vphp.PersistentOwnedZVal.from_zval(missing_raw)
	}
	for action in parse_action_list(only_raw) {
		out.only[action] = true
	}
	for action in parse_action_list(except_raw) {
		out.except[action] = true
	}

	names_raw := options.to_zval().get('names') or { vphp.ZVal.new_null() }
	if names_raw.is_valid() && names_raw.is_array() {
		for key, value in names_raw.to_string_map() {
			if key.trim_space() != '' && value.trim_space() != '' {
				out.names[key.trim_space()] = value.trim_space()
			}
		}
	}
	for action in ['index', 'create', 'store', 'show', 'edit', 'update', 'destroy'] {
		alt := options.to_zval().get('name_${action}') or { vphp.ZVal.new_null() }
		if alt.is_valid() && !alt.is_null() && !alt.is_undef() && alt.to_string().trim_space() != '' {
			out.names[action] = alt.to_string().trim_space()
		}
	}
	return out
}

fn normalize_resource_param_name(param_name string) string {
	mut clean := param_name.trim_space().trim_left(':')
	if clean == '' {
		return 'id'
	}
	return clean
}

fn parse_resource_bool_option(raw vphp.ZVal) bool {
	if raw.is_bool() {
		return raw.to_bool()
	}
	if raw.is_long() {
		return raw.to_i64() != 0
	}
	if raw.is_string() {
		value := raw.to_string().trim_space().to_lower()
		return value in ['1', 'true', 'yes', 'on']
	}
	return false
}

fn shallow_member_base_path(path string) string {
	mut clean := normalize_resource_path(path)
	if clean == '' || clean == '/' {
		return clean
	}
	segments := clean.trim_left('/').split('/').filter(it.len > 0)
	if segments.len == 0 {
		return clean
	}
	last_segment := segments[segments.len - 1]
	return '/${last_segment}'
}

fn parse_action_list(raw vphp.ZVal) []string {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return []string{}
	}
	if raw.is_array() {
		mut out := []string{}
		for item in raw.to_string_list() {
			clean := item.trim_space().to_lower()
			if clean != '' && clean !in out {
				out << clean
			}
		}
		return out
	}
	mut out := []string{}
	for part in raw.to_string().split(',') {
		clean := part.trim_space().to_lower()
		if clean != '' && clean !in out {
			out << clean
		}
	}
	return out
}

fn should_include_resource_action(opts ResourceRouteOptions, action string, all_actions []string) bool {
	if opts.only.len > 0 {
		return action in opts.only
	}
	if action in opts.except {
		return false
	}
	return action in all_actions
}

fn resource_route_name(opts ResourceRouteOptions, base_name string, action string) string {
	if action in opts.names {
		return opts.names[action]
	}
	if opts.name_prefix.trim_space() != '' {
		return '${opts.name_prefix}.${action}'
	}
	return '${base_name}.${action}'
}

fn resolve_effective_method(req &VSlimRequest) string {
	method := req.method.to_upper()
	if method != 'POST' {
		return method
	}
	mut override := req.header('x-http-method-override').trim_space().to_upper()
	if override == '' {
		override = req.query('_method').trim_space().to_upper()
	}
	if override == '' {
		override = parse_body_method_override(req.body)
	}
	allowed := ['PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS']
	if override in allowed {
		return override
	}
	return method
}

fn parse_body_method_override(body string) string {
	if body == '' {
		return ''
	}
	for pair in body.split('&') {
		if !pair.starts_with('_method=') {
			continue
		}
		return pair.all_after('_method=').trim_space().to_upper()
	}
	return ''
}

fn collect_allowed_methods(existing []string, route_method string) []string {
	mut out := existing.clone()
	mut incoming := []string{}
	match route_method {
		'*' {
			incoming = ['GET', 'HEAD', 'POST', 'PUT', 'PATCH', 'DELETE']
		}
		'GET' {
			incoming = ['GET', 'HEAD']
		}
		else {
			incoming = [route_method]
		}
	}
	for method in incoming {
		if method !in out {
			out << method
		}
	}
	return out
}

fn normalize_methods(methods vphp.BorrowedZVal) []string {
	mut out := []string{}
	if methods.is_string() {
		raw := methods.to_string().replace('|', ',')
		for part in raw.split(',') {
			method := part.trim_space().to_upper()
			if method == '' {
				continue
			}
			if method == 'ANY' || method == '*' {
				return ['*']
			}
			if method !in out {
				out << method
			}
		}
		return out
	}
	if methods.is_array() {
		for part in methods.to_string_list() {
			method := part.trim_space().to_upper()
			if method == '' {
				continue
			}
			if method == 'ANY' || method == '*' {
				return ['*']
			}
			if method !in out {
				out << method
			}
		}
	}
	return out
}

fn normalize_php_route_response_borrowed(result vphp.BorrowedZVal) (VSlimResponse, bool) {
	return normalize_php_route_response(result.to_zval())
}

fn normalize_php_route_response(result vphp.ZVal) (VSlimResponse, bool) {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return text_response(200, ''), true
	}
	if result.is_object()
		&& (result.is_instance_of('VSlim\\Response') || result.is_instance_of('VSlimResponse')) {
		if resp := result.to_object[VSlimResponse]() {
			return VSlimResponse{
				status:       resp.status
				body:         resp.body
				content_type: resp.content_type
				headers:      resp.headers()
			}, true
		}
	}
	if result.is_string() {
		return text_response(200, result.get_string()), true
	}
	if result.is_array() {
		mut headers := map[string]string{}
		if h := result.get('headers') {
			headers = h.fold[map[string]string](map[string]string{}, fn (key vphp.ZVal, val vphp.ZVal, mut acc map[string]string) {
				acc[key.to_string()] = val.to_string()
			})
		}
		status := if s := result.get('status') { int(s.to_i64()) } else { 200 }
		body := result.get_or('body', '')
		content_type := result.get_or('content_type', headers['content-type'] or {
			'text/plain; charset=utf-8'
		})
		if 'content-type' !in headers {
			headers['content-type'] = content_type
		}
		return VSlimResponse{
			status:       status
			body:         body
			content_type: headers['content-type'] or { '' }
			headers:      headers
		}, true
	}
	return VSlimResponse{}, false
}

fn (mut app VSlimApp) free() {
	for i in 0 .. app.php_middlewares.len {
		mut z := app.php_middlewares[i]
		z.release()
	}
	for i in 0 .. app.php_before_hooks.len {
		mut z := app.php_before_hooks[i]
		z.release()
	}
	for i in 0 .. app.php_after_hooks.len {
		mut z := app.php_after_hooks[i]
		z.release()
	}
	for i in 0 .. app.php_group_before.len {
		unsafe { app.php_group_before[i].prefix.free() }
		mut z := app.php_group_before[i].handler
		z.release()
	}
	for i in 0 .. app.php_group_after.len {
		unsafe { app.php_group_after[i].prefix.free() }
		mut z := app.php_group_after[i].handler
		z.release()
	}
	for i in 0 .. app.php_group_middle.len {
		unsafe { app.php_group_middle[i].prefix.free() }
		mut z := app.php_group_middle[i].handler
		z.release()
	}
	for i in 0 .. app.routes.len {
		unsafe {
			app.routes[i].method.free()
			app.routes[i].name.free()
			app.routes[i].pattern.free()
		}
		mut z := app.routes[i].php_handler
		z.release()
	}
	for i in 0 .. app.websocket_routes.len {
		unsafe {
			app.websocket_routes[i].method.free()
			app.websocket_routes[i].name.free()
			app.websocket_routes[i].pattern.free()
		}
		mut z := app.websocket_routes[i].php_handler
		z.release()
	}
	mut nf := app.not_found_handler
	nf.release()
	mut eh := app.error_handler
	eh.release()
	for key, _ in app.view_helpers {
		mut handler := app.view_helpers[key] or { continue }
		release_view_helper(mut handler)
	}
	unsafe {
		app.base_path.free()
		app.routes.free()
		app.websocket_routes.free()
		app.websocket_conn_route.free()
		app.php_middlewares.free()
		app.php_before_hooks.free()
		app.php_after_hooks.free()
		app.php_group_before.free()
		app.php_group_after.free()
		app.php_group_middle.free()
		app.view_helpers.free()
	}
}

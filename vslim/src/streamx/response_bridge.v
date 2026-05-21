module streamx

import httpx
import vphp

pub fn is_worker_stream_response(value vphp.PhpValue) bool {
	return value.is_object() && (value.is_instance_of('VSlim\\Stream\\Response')
		|| value.is_instance_of('VPhp\\VSlim\\Stream\\Response')
		|| value.is_instance_of('VPhp\\VHttpd\\PhpWorker\\StreamResponse'))
}

pub fn propagate_request_trace_headers_to_value(req &httpx.VSlimRequest, value vphp.PhpValue) {
	if obj := value.as_object() {
		propagate_request_trace_headers_to_object(req, obj)
	}
}

pub fn propagate_request_trace_headers_to_object(req &httpx.VSlimRequest, obj vphp.PhpObject) {
	if !obj.is_valid() || !obj.method_exists('hasHeader') || !obj.method_exists('setHeader') {
		return
	}
	rid := req.request_id()
	if rid != '' {
		mut request_id_name_arg := vphp.PhpString.of('x-request-id')
		defer {
			request_id_name_arg.release()
		}
		missing := obj.with_method_result[vphp.PhpValue, bool]('hasHeader', fn (has vphp.PhpValue) bool {
			return !has.is_valid() || !has.to_bool()
		}, request_id_name_arg) or { true }
		if missing {
			mut rid_arg := vphp.PhpString.of(rid)
			defer {
				rid_arg.release()
			}
			obj.with_method_result[vphp.PhpValue, bool]('setHeader', fn (_ vphp.PhpValue) bool {
				return true
			}, request_id_name_arg, rid_arg) or { false }
		}
	}
	tid := req.trace_id()
	if tid == '' {
		return
	}
	mut trace_id_name_arg := vphp.PhpString.of('x-trace-id')
	defer {
		trace_id_name_arg.release()
	}
	missing_trace := obj.with_method_result[vphp.PhpValue, bool]('hasHeader', fn (has vphp.PhpValue) bool {
		return !has.is_valid() || !has.to_bool()
	}, trace_id_name_arg) or { true }
	if missing_trace {
		mut tid_arg := vphp.PhpString.of(tid)
		defer {
			tid_arg.release()
		}
		obj.with_method_result[vphp.PhpValue, bool]('setHeader', fn (_ vphp.PhpValue) bool {
			return true
		}, trace_id_name_arg, tid_arg) or { false }
	}
	mut vhttpd_trace_id_name_arg := vphp.PhpString.of('x-vhttpd-trace-id')
	defer {
		vhttpd_trace_id_name_arg.release()
	}
	missing_vhttpd := obj.with_method_result[vphp.PhpValue, bool]('hasHeader', fn (has vphp.PhpValue) bool {
		return !has.is_valid() || !has.to_bool()
	}, vhttpd_trace_id_name_arg) or { true }
	if missing_vhttpd {
		mut tid_arg := vphp.PhpString.of(tid)
		defer {
			tid_arg.release()
		}
		obj.with_method_result[vphp.PhpValue, bool]('setHeader', fn (_ vphp.PhpValue) bool {
			return true
		}, vhttpd_trace_id_name_arg, tid_arg) or { false }
	}
}

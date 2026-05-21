module websocketx

import vphp

pub fn is_live_handler_value(handler vphp.PhpValue) bool {
	if obj := handler.as_object() {
		return is_live_handler_object(obj)
	}
	return false
}

pub fn is_live_handler_object(handler vphp.PhpObject) bool {
	return handler.method_exists('mount') || handler.method_exists('render')
		|| handler.method_exists('liveMarker')
}

pub fn is_supported_handler_value(handler vphp.PhpValue) bool {
	if !handler.is_valid() {
		return false
	}
	if handler.is_callable() || handler.is_string() || handler.is_array() {
		return true
	}
	if obj := handler.as_object() {
		return obj.method_exists('handleWebSocket') || obj.method_exists('onOpen')
			|| obj.method_exists('onMessage') || obj.method_exists('onClose')
			|| is_live_handler_object(obj)
	}
	return false
}

pub fn dispatch_handler_value(handler vphp.PhpValue, event string, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	if !handler.is_valid() {
		return vphp.PhpValue.null()
	}
	if obj := handler.as_object() {
		return dispatch_handler_object(obj, event, frame, conn)
	}
	if callable := handler.as_callable() {
		mut frame_scope := vphp.PhpScope.frame()
		defer {
			frame_scope.release()
		}
		return callable.invoke(...handler_args(mut frame_scope, event, frame, conn))
	}
	return vphp.PhpValue.null()
}

pub fn dispatch_service_handler(service vphp.PhpValue, method string, event string, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	clean_method := method.trim_space()
	if clean_method != '' && service.is_object() && service.method_exists(clean_method) {
		mut frame_scope := vphp.PhpScope.frame()
		defer {
			frame_scope.release()
		}
		service_obj := service.as_object() or { return vphp.PhpValue.null() }
		return service_obj.call_method(clean_method, ...handler_args(mut frame_scope, event, frame,
			conn))
	}
	return dispatch_handler_value(service, event, frame, conn)
}

pub fn dispatch_handler_object(handler vphp.PhpObject, event string, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	if !handler.is_valid() || is_live_handler_object(handler) {
		return vphp.PhpValue.null()
	}
	if handler.method_exists('handleWebSocket') {
		return handler.call_method('handleWebSocket', frame, conn)
	}
	match event {
		'open' {
			if handler.method_exists('onOpen') {
				return handler.call_method('onOpen', conn, frame)
			}
		}
		'message' {
			if handler.method_exists('onMessage') {
				mut frame_scope := vphp.PhpScope.frame()
				defer {
					frame_scope.release()
				}
				return handler.call_method('onMessage', ...handler_args(mut frame_scope, event,
					frame, conn))
			}
		}
		'close' {
			if handler.method_exists('onClose') {
				mut frame_scope := vphp.PhpScope.frame()
				defer {
					frame_scope.release()
				}
				return handler.call_method('onClose', ...handler_args(mut frame_scope, event,
					frame, conn))
			}
		}
		else {}
	}

	return vphp.PhpValue.null()
}

pub fn handler_args(mut frame_scope vphp.FrameScope, event string, frame vphp.PhpArray, conn vphp.PhpObject) []vphp.PhpArgInput {
	mut out := []vphp.PhpArgInput{}
	match event {
		'open' {
			out << conn
			out << frame
		}
		'message' {
			out << conn
			out << frame_scope.string(frame.string_at('data', ''))
			out << frame
		}
		'close' {
			out << conn
			out << frame_scope.int(frame.int_at('code', 1000))
			out << frame_scope.string(frame.string_at('reason', ''))
			out << frame
		}
		else {
			out << frame
			out << conn
		}
	}

	return out
}

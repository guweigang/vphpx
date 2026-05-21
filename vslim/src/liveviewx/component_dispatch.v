module liveviewx

import vphp

fn dispatch_live_component_event(handler vphp.PhpObject, payload vphp.PhpValue, event_name vphp.PhpString, socket_obj vphp.PhpObject) bool {
	target := live_component_target(payload)
	if target == '' {
		return false
	}
	mut target_arg := vphp.PhpString.of(target)
	defer {
		target_arg.release()
	}
	if handler.method_exists('component') {
		mut component := handler.call_method('component', target_arg, socket_obj)
		defer {
			component.release()
		}
		if component_obj := component.as_object() {
			bind_live_component_socket(component_obj, socket_obj)
			if live_component_handles_event(component_obj)
				&& component_obj.method_exists('handleEvent') {
				live_call_method(component_obj, 'handleEvent', event_name, payload, socket_obj)
				return true
			}
		}
	}
	if handler.method_exists('handleComponentEvent') {
		live_call_method(handler, 'handleComponentEvent', target_arg, event_name, payload,
			socket_obj)
		return true
	}
	return false
}

fn dispatch_live_component_info(handler vphp.PhpObject, payload vphp.PhpValue, event_name vphp.PhpString, socket_obj vphp.PhpObject) bool {
	target := live_component_target(payload)
	if target == '' {
		return false
	}
	mut target_arg := vphp.PhpString.of(target)
	defer {
		target_arg.release()
	}
	if handler.method_exists('component') {
		mut component := handler.call_method('component', target_arg, socket_obj)
		defer {
			component.release()
		}
		if component_obj := component.as_object() {
			bind_live_component_socket(component_obj, socket_obj)
			if live_component_handles_info(component_obj)
				&& component_obj.method_exists('handleInfo') {
				live_call_method(component_obj, 'handleInfo', event_name, payload, socket_obj)
				return true
			}
		}
	}
	if handler.method_exists('handleComponentInfo') {
		live_call_method(handler, 'handleComponentInfo', target_arg, event_name, payload,
			socket_obj)
		return true
	}
	return false
}

fn bind_live_component_socket(component vphp.PhpObject, socket_obj vphp.PhpObject) {
	if component.method_exists('bindSocket') {
		live_call_method(component, 'bindSocket', socket_obj)
	}
}

fn live_component_target(payload vphp.PhpValue) string {
	if !payload.is_valid() || payload.is_null() || payload.is_undef() || !payload.is_array() {
		return ''
	}
	target := payload.string_at('target', '').trim_space()
	if !target.starts_with('component:') {
		return ''
	}
	return target.all_after('component:').trim_space()
}

fn live_component_handles_event(component vphp.PhpObject) bool {
	return component.method_exists('handleEvent')
}

fn live_component_handles_info(component vphp.PhpObject) bool {
	return component.method_exists('handleInfo')
}

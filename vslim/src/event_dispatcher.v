module main

import vphp

@[php_method]
pub fn (mut provider VSlimPsr14ListenerProvider) construct() &VSlimPsr14ListenerProvider {
	if provider.listeners.len == 0 {
		provider.listeners = map[string][]vphp.PersistentOwnedZBox{}
	}
	return &provider
}

@[php_method]
pub fn (mut provider VSlimPsr14ListenerProvider) listen(event_class string, listener vphp.RequestBorrowedZBox) &VSlimPsr14ListenerProvider {
	ensure_psr14_listener_provider(mut provider)
	key := normalize_psr14_event_key(event_class)
	if key == '' {
		vphp.throw_exception_class('InvalidArgumentException', 'event class must not be empty', 0)
		return &provider
	}
	if !listener.is_valid() || !listener.is_callable() {
		vphp.throw_exception_class('InvalidArgumentException', 'listener must be callable', 0)
		return &provider
	}
	mut listeners := provider.listeners[key] or { []vphp.PersistentOwnedZBox{} }
	listeners << vphp.PersistentOwnedZBox.from_callable_zval(listener.to_zval())
	provider.listeners[key] = listeners
	return &provider
}

@[php_method: 'listenAny']
pub fn (mut provider VSlimPsr14ListenerProvider) listen_any(listener vphp.RequestBorrowedZBox) &VSlimPsr14ListenerProvider {
	return provider.listen('*', listener)
}

@[php_method: 'listenerCount']
pub fn (provider &VSlimPsr14ListenerProvider) listener_count() int {
	mut count := 0
	for _, listeners in provider.listeners {
		count += listeners.len
	}
	return count
}

@[php_arg_type: 'event=object']
@[php_return_type: 'iterable']
@[php_method: 'getListenersForEvent']
pub fn (provider &VSlimPsr14ListenerProvider) get_listeners_for_event(event vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	if !event.is_valid() || !event.is_object() {
		vphp.throw_exception_class('InvalidArgumentException', 'event must be an object', 0)
		return vphp.own_request_zbox(new_psr14_listener_array())
	}
	mut out := new_psr14_listener_array()
	for listener in provider.listeners_for_event(event.to_zval()) {
		listener.with_request_zval(fn [mut out] (z vphp.ZVal) bool {
			out.add_next_val(z)
			return true
		})
	}
	return vphp.own_request_zbox(out)
}

@[php_method]
pub fn (mut dispatcher VSlimPsr14EventDispatcher) construct() &VSlimPsr14EventDispatcher {
	ensure_psr14_dispatcher(mut dispatcher)
	return &dispatcher
}

@[php_method: 'setProvider']
@[php_arg_type: 'provider=Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (mut dispatcher VSlimPsr14EventDispatcher) set_provider(provider &VSlimPsr14ListenerProvider) &VSlimPsr14EventDispatcher {
	dispatcher.provider_ref = provider
	return &dispatcher
}

@[php_method]
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (mut dispatcher VSlimPsr14EventDispatcher) provider() &VSlimPsr14ListenerProvider {
	ensure_psr14_dispatcher(mut dispatcher)
	return dispatcher.provider_ref
}

@[php_method]
pub fn (mut dispatcher VSlimPsr14EventDispatcher) listen(event_class string, listener vphp.RequestBorrowedZBox) &VSlimPsr14EventDispatcher {
	mut provider := dispatcher.provider()
	provider.listen(event_class, listener)
	return &dispatcher
}

@[php_method: 'listenAny']
pub fn (mut dispatcher VSlimPsr14EventDispatcher) listen_any(listener vphp.RequestBorrowedZBox) &VSlimPsr14EventDispatcher {
	mut provider := dispatcher.provider()
	provider.listen_any(listener)
	return &dispatcher
}

@[php_arg_type: 'event=object']
@[php_return_type: 'object']
@[php_method: 'dispatch']
pub fn (mut dispatcher VSlimPsr14EventDispatcher) dispatch(event vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	if !event.is_valid() || !event.is_object() {
		vphp.throw_exception_class('InvalidArgumentException', 'event must be an object', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	if psr14_propagation_stopped(event.to_zval()) {
		return event.clone_request_owned()
	}
	provider := dispatcher.provider()
	for listener in provider.listeners_for_event(event.to_zval()) {
		if psr14_propagation_stopped(event.to_zval()) {
			break
		}
		listener.with_call_result([event.to_zval()], fn (result vphp.ZVal) bool {
			return result.is_valid()
		})
	}
	return event.clone_request_owned()
}

fn ensure_psr14_listener_provider(mut provider VSlimPsr14ListenerProvider) {
	if provider.listeners.len == 0 {
		provider.listeners = map[string][]vphp.PersistentOwnedZBox{}
	}
}

fn ensure_psr14_dispatcher(mut dispatcher VSlimPsr14EventDispatcher) {
	if dispatcher.provider_ref != unsafe { nil } {
		return
	}
	mut provider := &VSlimPsr14ListenerProvider{}
	provider.construct()
	dispatcher.provider_ref = provider
}

pub fn (provider &VSlimPsr14ListenerProvider) listeners_for_event(event vphp.ZVal) []vphp.PersistentOwnedZBox {
	mut out := []vphp.PersistentOwnedZBox{}
	for key in psr14_event_keys(event) {
		if key !in provider.listeners {
			continue
		}
		listeners := provider.listeners[key] or { continue }
		for listener in listeners {
			out << listener
		}
	}
	return out
}

fn psr14_event_keys(event vphp.ZVal) []string {
	mut out := []string{}
	mut seen := map[string]bool{}
	class_name := event.class_name().trim_space()
	if class_name != '' {
		push_psr14_key(mut out, mut seen, class_name)
		mut parent := event.parent_class_name().trim_space()
		for parent != '' {
			push_psr14_key(mut out, mut seen, parent)
			parent = psr14_parent_class_name(parent)
		}
		for iface in event.interface_names() {
			push_psr14_key(mut out, mut seen, iface)
		}
	}
	push_psr14_key(mut out, mut seen, '*')
	return out
}

fn push_psr14_key(mut out []string, mut seen map[string]bool, key string) {
	normalized := normalize_psr14_event_key(key)
	if normalized == '' || normalized in seen {
		return
	}
	seen[normalized] = true
	out << normalized
}

fn normalize_psr14_event_key(key string) string {
	normalized := key.trim_space()
	if normalized == '*' {
		return normalized
	}
	return normalized
}

fn psr14_parent_class_name(class_name string) string {
	if class_name.trim_space() == '' {
		return ''
	}
	return vphp.with_php_call_result_zval('get_parent_class', [vphp.RequestOwnedZBox.new_string(class_name).to_zval()], fn (res vphp.ZVal) string {
		if !res.is_valid() || res.is_null() || res.is_undef() || (res.is_bool() && !res.to_bool()) {
			return ''
		}
		return res.to_string().trim_space()
	})
}

fn psr14_propagation_stopped(event vphp.ZVal) bool {
	if !event.is_valid() || !event.is_object() {
		return false
	}
	if !event.is_instance_of('Psr\\EventDispatcher\\StoppableEventInterface')
		&& !event.method_exists('isPropagationStopped') {
		return false
	}
	return vphp.with_method_result_zval(event, 'isPropagationStopped', []vphp.ZVal{}, fn (res vphp.ZVal) bool {
		return res.is_valid() && res.to_bool()
	})
}

fn new_psr14_listener_array() vphp.ZVal {
	mut out := vphp.ZVal.new_null()
	out.array_init()
	return out
}

pub fn (provider &VSlimPsr14ListenerProvider) free() {
	for _, listeners in provider.listeners {
		for listener in listeners {
			mut owned := listener
			owned.release()
		}
	}
	unsafe {
		provider.listeners.free()
	}
}

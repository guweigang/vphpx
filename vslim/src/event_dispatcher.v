module main

import vphp

@[php_method]
pub fn (mut provider VSlimPsr14ListenerProvider) construct() &VSlimPsr14ListenerProvider {
	if provider.listeners.len == 0 {
		provider.listeners = map[string][]vphp.PersistentOwnedZBox{}
	}
	return &provider
}

@[php_arg_name: 'event_class=eventClass']
@[php_method]
pub fn (mut provider VSlimPsr14ListenerProvider) listen(event_class string, listener vphp.RequestBorrowedZBox) &VSlimPsr14ListenerProvider {
	ensure_psr14_listener_provider(mut provider)
	key := normalize_psr14_event_key(event_class)
	if key == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'event class must not be empty',
			0)
		return &provider
	}
	if !listener.is_valid() || !listener.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'listener must be callable',
			0)
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

@[php_method: 'getListenersForEvent']
@[php_return_type: 'iterable']
pub fn (provider &VSlimPsr14ListenerProvider) get_listeners_for_event(event vphp.PhpObject) vphp.RequestOwnedZBox {
	mut out := new_psr14_listener_array()
	for listener in provider.listeners_for_event(event.to_zval()) {
		mut listener_arg := listener.clone_request_owned()
		out.add_next_val(listener_arg.to_zval())
		listener_arg.release()
	}
	return vphp.RequestOwnedZBox.of(out)
}

@[php_method]
pub fn (mut dispatcher VSlimPsr14EventDispatcher) construct() &VSlimPsr14EventDispatcher {
	ensure_psr14_dispatcher(mut dispatcher)
	return &dispatcher
}

@[php_arg_type: 'provider=Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'setProvider']
pub fn (mut dispatcher VSlimPsr14EventDispatcher) set_provider(provider &VSlimPsr14ListenerProvider) &VSlimPsr14EventDispatcher {
	dispatcher.provider_ref = provider
	return &dispatcher
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method]
pub fn (mut dispatcher VSlimPsr14EventDispatcher) provider() &VSlimPsr14ListenerProvider {
	ensure_psr14_dispatcher(mut dispatcher)
	return dispatcher.provider_ref
}

@[php_arg_name: 'event_class=eventClass']
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

@[php_method: 'dispatch']
@[php_return_type: 'object']
pub fn (mut dispatcher VSlimPsr14EventDispatcher) dispatch(event vphp.PhpObject) vphp.RequestOwnedZBox {
	if psr14_propagation_stopped(event.to_zval()) {
		return vphp.RequestOwnedZBox.of(event.to_zval())
	}
	provider := dispatcher.provider()
	for listener in provider.listeners_for_event(event.to_zval()) {
		if psr14_propagation_stopped(event.to_zval()) {
			break
		}
		listener.with_fn_result[vphp.PhpValue, bool](fn (result vphp.PhpValue) bool {
			return result.to_zval().is_valid()
		}, vphp.PhpValue.from_zval(event.to_zval())) or { false }
	}
	return vphp.RequestOwnedZBox.of(event.to_zval())
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
	mut class_arg := vphp.PhpString.of(class_name)
	defer {
		class_arg.release()
	}
	return vphp.PhpFunction.named('get_parent_class').with_result[vphp.PhpValue, string](fn (res vphp.PhpValue) string {
		raw := res.to_zval()
		if !raw.is_valid() || raw.is_null() || raw.is_undef() || (raw.is_bool() && !raw.to_bool()) {
			return ''
		}
		return raw.to_string().trim_space()
	}, class_arg) or { '' }
}

fn psr14_propagation_stopped(event vphp.ZVal) bool {
	if !event.is_valid() || !event.is_object() {
		return false
	}
	if !event.is_instance_of('Psr\\EventDispatcher\\StoppableEventInterface')
		&& !event.method_exists('isPropagationStopped') {
		return false
	}
	return vphp.PhpObject.borrowed(event).with_method_result[vphp.PhpBool, bool]('isPropagationStopped',
		fn (res vphp.PhpBool) bool {
		return res.value()
	}) or { false }
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

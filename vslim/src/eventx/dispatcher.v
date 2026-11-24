module eventx

import vphp

@[vphp.PhpExportMethod(name: '')]
pub fn (mut provider VSlimPsr14ListenerProvider) construct() &VSlimPsr14ListenerProvider {
	if provider.listeners.len == 0 {
		provider.listeners = map[string][]ListenerRegistration{}
	}
	return &provider
}

pub fn VSlimPsr14ListenerProvider.new_default() &VSlimPsr14ListenerProvider {
	mut provider := &VSlimPsr14ListenerProvider{}
	provider.construct()
	return provider
}

@[vphp.PhpArgName(v_name: 'event_class', php_name: 'eventClass')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut provider VSlimPsr14ListenerProvider) listen(event_class string, listener vphp.PhpCallable) &VSlimPsr14ListenerProvider {
	provider.register_listener(event_class, listener)
	return &provider
}

@[vphp.PhpArgName(v_name: 'event_class', php_name: 'eventClass')]
@[vphp.PhpExportMethod(name: 'listenWeak')]
pub fn (mut provider VSlimPsr14ListenerProvider) listen_weak(event_class string, listener vphp.PhpObject) !&VSlimPsr14ListenerProvider {
	if !listener.to_zval().is_callable() {
		vphp.PhpException.raise_class('TypeError', 'Weak event listener must be a callable object', 0)
		return error('Weak event listener must be a callable object')
	}
	reference := vphp.PhpWeakReference.create(listener)!
	provider.register_listener(event_class, reference)
	return &provider
}

fn (mut provider VSlimPsr14ListenerProvider) register_listener(event_class string, listener ListenerRegistration) {
	key := normalize_psr14_event_key(event_class)
	if key == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'event class must not be empty',
			0)
		return
	}
	provider.ensure()
	if state := vphp.owned_object_php_state(provider) {
		if listeners := state.value_at(key).as_array() {
			if listener is vphp.PhpWeakReference {
				mut active := vphp.PhpArray.new()
				for i in 0 .. listeners.count() {
					if listener_entry_alive(listeners.index_value(i)) {
						active.push_zval(listeners.get_index(i))
					}
				}
				active.push(listener)
				state.set(key, active)
				active.release()
			} else {
				append_listener(listeners, listener)
			}
		} else {
			mut listeners := vphp.PhpArray.new()
			append_listener(listeners, listener)
			state.set(key, listeners)
			listeners.release()
		}
		return
	}
	mut listeners := provider.listeners[key] or { []ListenerRegistration{} }
	match listener {
		vphp.PhpCallable {
			listeners << listener.retain()
		}
		vphp.PhpWeakReference {
			mut index := listeners.len
			for index > 0 {
				index--
				entry := listeners[index]
				if entry is vphp.PhpWeakReference {
					if !weak_listener_alive(entry) {
						mut expired := entry
						expired.release()
						listeners.delete(index)
					}
				}
			}
			listeners << listener.retain()
		}
	}
	provider.listeners[key] = listeners
}

@[vphp.PhpExportMethod(name: 'listenAny')]
pub fn (mut provider VSlimPsr14ListenerProvider) listen_any(listener vphp.PhpCallable) &VSlimPsr14ListenerProvider {
	return provider.listen('*', listener)
}

@[vphp.PhpExportMethod(name: 'listenerCount')]
pub fn (provider &VSlimPsr14ListenerProvider) listener_count() int {
	mut count := 0
	for _, listeners in provider.listeners {
		for listener in listeners {
			if listener is vphp.PhpCallable || weak_listener_alive(listener as vphp.PhpWeakReference) {
				count++
			}
		}
	}
	if state := vphp.owned_object_php_state(provider) {
		for key in state.key_strings() {
			if listeners := state.value_at(key).as_array() {
				for i in 0 .. listeners.count() {
					if listener_entry_alive(listeners.index_value(i)) {
						count++
					}
				}
			}
		}
	}
	return count
}

@[vphp.PhpExportMethod(name: 'count')]
pub fn (provider &VSlimPsr14ListenerProvider) count() int {
	return provider.listener_count()
}

struct ListenerGeneratorCursor {
mut:
	next int
}

@[vphp.PhpExportMethod(name: 'getListenersForEvent')]
@[vphp.PhpReturnType(php_type: 'iterable')]
pub fn (provider &VSlimPsr14ListenerProvider) get_listeners_for_event(event vphp.PhpObject) !vphp.PhpGenerator {
	mut snapshot := provider.listener_snapshot(event)
	defer {
		snapshot.release()
	}
	mut cursor := &ListenerGeneratorCursor{}
	return vphp.PhpGenerator.from_producer(vphp.PhpGeneratorProducer{
		capture: snapshot.borrowed().to_value()
		resume:  fn [mut cursor] (input vphp.PhpGeneratorInput) !vphp.PhpGeneratorStep {
			if raised := input.exception {
				return vphp.PhpGeneratorStep.throw_exception(raised)
			}
			listeners := input.capture.as_array() or { return error('missing listener snapshot') }
			for cursor.next < listeners.count() {
				entry := listeners.index_value(cursor.next)
				cursor.next++
				mut listener := resolve_listener_entry(entry) or { continue }
				return vphp.PhpGeneratorStep.yield_value(listener.move_to_request_scope())
			}
			return vphp.PhpGeneratorStep.finish(vphp.PhpValue.null())
		}
	})
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut dispatcher VSlimPsr14EventDispatcher) construct() &VSlimPsr14EventDispatcher {
	dispatcher.ensure()
	return &dispatcher
}

pub fn VSlimPsr14EventDispatcher.from_provider(provider &VSlimPsr14ListenerProvider) &VSlimPsr14EventDispatcher {
	return &VSlimPsr14EventDispatcher{ provider_ref: provider }
}

pub fn VSlimPsr14EventDispatcher.new_for_owner(owner voidptr) &VSlimPsr14EventDispatcher {
	dispatcher := &VSlimPsr14EventDispatcher{}
	if state := vphp.owned_object_php_state(owner) {
		mut value := vphp.bind_owned_object_value[VSlimPsr14EventDispatcher](dispatcher)
		state.set('dispatcher', value)
		value.release()
	}
	return dispatcher
}

pub fn (dispatcher &VSlimPsr14EventDispatcher) retain_for_owner(owner voidptr) {
	if state := vphp.owned_object_php_state(owner) {
		mut value := vphp.bind_borrowed_object_value[VSlimPsr14EventDispatcher](dispatcher)
		state.set('dispatcher', value)
		value.release()
	}
}

@[vphp.PhpExportMethod(name: 'setProvider')]
pub fn (mut dispatcher VSlimPsr14EventDispatcher) export_set_provider(provider PsrListenerProvider) &VSlimPsr14EventDispatcher {
	object := provider.to_object()
	mut previous := dispatcher.explicit_provider().to_request_owned()
	defer {
		previous.release()
	}
	dispatcher.remember_provider_object(object)
	if object.class_name() == 'VSlim\\Psr14\\ListenerProvider' {
		dispatcher.provider_ref = object.to_v_object[VSlimPsr14ListenerProvider]() or { unsafe { nil } }
		if dispatcher.provider_ref != unsafe { nil } {
			if state := vphp.owned_object_php_state(dispatcher) {
				state.remove('native_provider')
			}
			return &dispatcher
		}
	}
	dispatcher.provider_ref = unsafe { nil }
	dispatcher.ensure()
	return &dispatcher
}

fn (mut dispatcher VSlimPsr14EventDispatcher) remember_provider_object(provider vphp.PhpObject) {
	if state := vphp.owned_object_php_state(dispatcher) {
		if provider.is_valid() {
			state.set('provider', provider)
		} else {
			state.remove('provider')
		}
		dispatcher.provider_object_ref.release()
		return
	}
	mut previous := dispatcher.provider_object_ref
	dispatcher.provider_object_ref = if provider.is_valid() { provider.retain() } else { provider }
	previous.release()
}

fn (dispatcher &VSlimPsr14EventDispatcher) explicit_provider() vphp.PhpObject {
	if state := vphp.owned_object_php_state(dispatcher) {
		if provider := state.value_at('provider').as_object() {
			return provider
		}
	}
	return dispatcher.provider_object_ref.borrowed()
}

pub fn (mut dispatcher VSlimPsr14EventDispatcher) set_provider(provider &VSlimPsr14ListenerProvider) &VSlimPsr14EventDispatcher {
	dispatcher.provider_ref = provider
	if state := vphp.owned_object_php_state(dispatcher) {
		mut value := vphp.bind_borrowed_object_value[VSlimPsr14ListenerProvider](provider)
		state.set('native_provider', value)
		value.release()
	}
	dispatcher.remember_provider_object(vphp.PhpObject.invalid())
	return &dispatcher
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'provider')]
pub fn (mut dispatcher VSlimPsr14EventDispatcher) provider_object() vphp.PhpObject {
	explicit := dispatcher.explicit_provider()
	if explicit.is_valid() {
		return explicit.to_value().to_request_scoped().as_object() or { vphp.PhpObject.invalid() }
	}
	mut value := vphp.bind_borrowed_object_value[VSlimPsr14ListenerProvider](dispatcher.provider())
	return value.move_to_request_scope().as_object() or { vphp.PhpObject.invalid() }
}

pub fn (mut dispatcher VSlimPsr14EventDispatcher) provider() &VSlimPsr14ListenerProvider {
	dispatcher.ensure()
	return dispatcher.provider_ref
}

@[vphp.PhpArgName(v_name: 'event_class', php_name: 'eventClass')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut dispatcher VSlimPsr14EventDispatcher) listen(event_class string, listener vphp.PhpCallable) &VSlimPsr14EventDispatcher {
	mut provider := dispatcher.provider()
	provider.listen(event_class, listener)
	return &dispatcher
}

@[vphp.PhpArgName(v_name: 'event_class', php_name: 'eventClass')]
@[vphp.PhpExportMethod(name: 'listenWeak')]
pub fn (mut dispatcher VSlimPsr14EventDispatcher) listen_weak(event_class string, listener vphp.PhpObject) !&VSlimPsr14EventDispatcher {
	mut provider := dispatcher.provider()
	provider.listen_weak(event_class, listener)!
	return &dispatcher
}

@[vphp.PhpExportMethod(name: 'listenAny')]
pub fn (mut dispatcher VSlimPsr14EventDispatcher) listen_any(listener vphp.PhpCallable) &VSlimPsr14EventDispatcher {
	mut provider := dispatcher.provider()
	provider.listen_any(listener)
	return &dispatcher
}

@[vphp.PhpExportMethod(name: 'dispatch')]
@[vphp.PhpReturnType(php_type: 'object')]
pub fn (mut dispatcher VSlimPsr14EventDispatcher) dispatch(event vphp.PhpObject) vphp.PhpObject {
	if psr14_propagation_stopped(event) {
		return event.to_request_owned()
	}
	provider := dispatcher.provider()
	explicit := dispatcher.explicit_provider()
	if explicit.is_valid() && explicit.class_name() != 'VSlim\\Psr14\\ListenerProvider' {
		mut native_pin := vphp.bind_borrowed_object_value[VSlimPsr14ListenerProvider](provider)
		mut external_pin := explicit.to_request_owned()
		ok := dispatch_external_listeners(external_pin, event)
		external_pin.release()
		if !ok {
			native_pin.release()
			return event.to_request_owned()
		}
		result := dispatch_native_listeners(provider, event)
		native_pin.release()
		return result
	}
	return dispatch_native_listeners(provider, event)
}

fn dispatch_native_listeners(provider &VSlimPsr14ListenerProvider, event vphp.PhpObject) vphp.PhpObject {
	if vphp.has_exception() {
		return event.to_request_owned()
	}
	mut snapshot := provider.listener_snapshot(event)
	defer {
		snapshot.release()
	}
	for i in 0 .. snapshot.count() {
		mut resolved := resolve_listener_entry(snapshot.index_value(i)) or { continue }
		listener := vphp.PhpCallable.from_zval(resolved.to_zval()) or {
			resolved.release()
			continue
		}
		continued := dispatch_listener(listener, event)
		resolved.release()
		if !continued {
			break
		}
	}
	return event.to_request_owned()
}

fn dispatch_external_listeners(provider vphp.PhpObject, event vphp.PhpObject) bool {
	mut value := provider.call_method_by_value('getListenersForEvent', event)
	defer {
		value.release()
	}
	mut listeners := vphp.PhpIterable.from_zval(value.to_zval()) or { return false }
	defer {
		listeners.release()
	}
	return listeners.each_value_by_value_while(fn [event] (value vphp.PhpValue) bool {
		mut listener := vphp.PhpCallable.from_value(value) or {
			if !vphp.has_exception() {
				vphp.PhpException.raise_class('TypeError', 'Listener provider must yield callable values', 0)
			}
			return false
		}
		defer {
			listener.release()
		}
		return dispatch_listener(listener, event) && !psr14_propagation_stopped(event)
	}) or { return false }
}

fn dispatch_listener(listener vphp.PhpCallable, event vphp.PhpObject) bool {
	if vphp.has_exception() || psr14_propagation_stopped(event) {
		return false
	}
	listener.with_result[vphp.PhpValue, bool](fn (result vphp.PhpValue) bool {
		return result.is_valid()
	}, event) or { false }
	return !vphp.has_exception()
}

fn (mut provider VSlimPsr14ListenerProvider) ensure() {
	if provider.listeners.len == 0 {
		provider.listeners = map[string][]ListenerRegistration{}
	}
}

fn (mut dispatcher VSlimPsr14EventDispatcher) ensure() {
	if dispatcher.provider_ref != unsafe { nil } {
		return
	}
	provider := VSlimPsr14ListenerProvider.new_default()
	dispatcher.provider_ref = provider
	if state := vphp.owned_object_php_state(dispatcher) {
		mut value := vphp.bind_owned_object_value[VSlimPsr14ListenerProvider](provider)
		state.set('native_provider', value)
		value.release()
	}
}

fn append_listener(listeners vphp.PhpArray, listener ListenerRegistration) {
	match listener {
		vphp.PhpCallable {
			mut value := listener.to_request_owned()
			listeners.push(value)
			value.release()
		}
		vphp.PhpWeakReference {
			listeners.push(listener)
		}
	}
}

fn weak_listener_alive(reference vphp.PhpWeakReference) bool {
	mut target := reference.get() or { return false }
	target.release()
	return true
}

fn listener_entry_alive(entry vphp.PhpValue) bool {
	reference := vphp.PhpWeakReference.from_zval(entry.to_zval()) or { return true }
	return weak_listener_alive(reference)
}

fn resolve_listener_entry(entry vphp.PhpValue) ?vphp.PhpValue {
	if reference := vphp.PhpWeakReference.from_zval(entry.to_zval()) {
		mut target := reference.get()?
		return target.take_value()
	}
	return entry.to_request_owned()
}

fn (provider &VSlimPsr14ListenerProvider) listener_snapshot(event vphp.PhpObject) vphp.PhpArray {
	snapshot := vphp.PhpArray.new()
	state := vphp.owned_object_php_state(provider)
	for key in psr14_event_keys(event) {
		for listener in provider.listeners[key] or { []ListenerRegistration{} } {
			append_listener(snapshot, listener)
		}
		if owned := state {
			if listeners := owned.value_at(key).as_array() {
				for i in 0 .. listeners.count() {
					snapshot.push_zval(listeners.get_index(i))
				}
			}
		}
	}
	return snapshot
}

pub fn (provider &VSlimPsr14ListenerProvider) listeners_for_event(event vphp.PhpObject) []vphp.PhpCallable {
	mut snapshot := provider.listener_snapshot(event)
	defer {
		snapshot.release()
	}
	mut out := []vphp.PhpCallable{cap: snapshot.count()}
	for i in 0 .. snapshot.count() {
		mut resolved := resolve_listener_entry(snapshot.index_value(i)) or { continue }
		if listener := vphp.PhpCallable.from_zval(resolved.to_zval()) {
			out << listener.retain()
		}
		resolved.release()
	}
	return out
}

fn psr14_event_keys(event vphp.PhpObject) []string {
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
		if !res.is_valid() || res.is_null() || res.is_undef() || (res.is_bool() && !res.to_bool()) {
			return ''
		}
		return res.to_string().trim_space()
	}, class_arg) or { '' }
}

fn psr14_propagation_stopped(event vphp.PhpObject) bool {
	if !event.is_valid() {
		return false
	}
	if !event.is_instance_of('Psr\\EventDispatcher\\StoppableEventInterface')
		&& !event.method_exists('isPropagationStopped') {
		return false
	}
	return event.with_method_result[vphp.PhpBool, bool]('isPropagationStopped', fn (res vphp.PhpBool) bool {
		return res.value()
	}) or { false }
}

pub fn (provider &VSlimPsr14ListenerProvider) free() {
	for _, listeners in provider.listeners {
		for listener in listeners {
			match listener {
				vphp.PhpCallable {
					mut owned := listener
					owned.release()
				}
				vphp.PhpWeakReference {
					mut owned := listener
					owned.release()
				}
			}
		}
	}
	unsafe {
		provider.listeners.free()
	}
}

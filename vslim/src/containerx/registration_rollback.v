module containerx

import registrationx
import vphp

enum ContainerChangeKind {
	registration
	resolution
}

struct ContainerRegistration {
mut:
	entry    ?vphp.PhpValue
	factory  ?vphp.PhpCallable
	resolved ?vphp.PhpValue
}

struct ContainerPhpRegistrations {
	entries   vphp.PhpArray
	factories vphp.PhpArray
	resolved  vphp.PhpArray
}

fn container_php_map(state vphp.PhpArray, key string) ?vphp.PhpArray {
	if entries := state.value_at(key).as_array() {
		return entries
	}
	mut entries := vphp.PhpArray.new()
	state.set(key, entries)
	entries.release()
	return state.value_at(key).as_array()
}

fn (c &VSlimContainer) php_registrations() ?ContainerPhpRegistrations {
	state := vphp.owned_object_php_state(c)?
	return ContainerPhpRegistrations{
		entries:   container_php_map(state, 'entries')?
		factories: container_php_map(state, 'factories')?
		resolved:  container_php_map(state, 'resolved')?
	}
}

pub fn (mut c VSlimContainer) init_php_state() {
	if c.entries.len == 0 && c.factories.len == 0 && c.resolved.len == 0 {
		return
	}
	stored := c.php_registrations() or { return }
	for id, value in c.entries {
		stored.entries.set_value(id, value)
	}
	for id, factory in c.factories {
		stored.factories.set_callable(id, factory)
	}
	for id, value in c.resolved {
		stored.resolved.set_value(id, value)
	}
	container_release_map(mut c.entries)
	container_release_factory_map(mut c.factories)
	container_release_map(mut c.resolved)
}

fn (c &VSlimContainer) find_registration(id string) ContainerRegistration {
	if stored := c.php_registrations() {
		return ContainerRegistration{
			entry:    stored.entries.find(id)
			factory:  stored.factories.value_at(id).as_callable()
			resolved: stored.resolved.find(id)
		}
	}
	mut registration := ContainerRegistration{}
	if entry := c.entries[id] {
		registration.entry = entry
	}
	if factory := c.factories[id] {
		registration.factory = factory
	}
	if resolved := c.resolved[id] {
		registration.resolved = resolved
	}
	return registration
}

fn take_php_value(values vphp.PhpArray, id string) ?vphp.PhpValue {
	value := values.find(id)?
	saved := value.retain()
	values.remove(id)
	return saved
}

fn (mut c VSlimContainer) take_registration(id string, kind ContainerChangeKind) ContainerRegistration {
	mut saved := ContainerRegistration{}
	if stored := c.php_registrations() {
		saved.resolved = take_php_value(stored.resolved, id)
		if kind == .registration {
			saved.entry = take_php_value(stored.entries, id)
			if callable := stored.factories.value_at(id).as_callable() {
				saved.factory = callable.retain()
				stored.factories.remove(id)
			}
		}
		return saved
	}
	if value := c.resolved[id] {
		saved.resolved = value
		c.resolved.delete(id)
	}
	if kind == .registration {
		if value := c.entries[id] {
			saved.entry = value
			c.entries.delete(id)
		}
		if value := c.factories[id] {
			saved.factory = value
			c.factories.delete(id)
		}
	}
	return saved
}

fn (mut c VSlimContainer) restore_registration(id string, saved ContainerRegistration) {
	if stored := c.php_registrations() {
		if entry := saved.entry {
			stored.entries.set_value(id, entry)
		}
		if factory := saved.factory {
			stored.factories.set_callable(id, factory)
		}
		if resolved := saved.resolved {
			stored.resolved.set_value(id, resolved)
		}
		saved.release()
		return
	}
	if entry := saved.entry {
		c.entries[id] = entry
	}
	if factory := saved.factory {
		c.factories[id] = factory
	}
	if resolved := saved.resolved {
		c.resolved[id] = resolved
	}
}

fn (saved ContainerRegistration) release() {
	if mut entry := saved.entry {
		entry.release()
	}
	if mut factory := saved.factory {
		factory.release()
	}
	if mut resolved := saved.resolved {
		resolved.release()
	}
}

fn (mut c VSlimContainer) replace_registration(id string, kind ContainerChangeKind, next ContainerRegistration) {
	saved := c.take_registration(id, kind)
	c.restore_registration(id, next)
	mut scope := registrationx.current_registration_scope() or {
		saved.release()
		return
	}
	key := id.clone()
	receiver := &c
	scope.add_change(fn [receiver, key, kind, saved] (commit bool) {
		if commit {
			saved.release()
		} else {
			mut target := receiver
			failed := target.take_registration(key, kind)
			target.restore_registration(key, saved)
			failed.release()
		}
	})
}

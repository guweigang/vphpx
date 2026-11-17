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

fn (mut c VSlimContainer) take_registration(id string, kind ContainerChangeKind) ContainerRegistration {
	mut saved := ContainerRegistration{}
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

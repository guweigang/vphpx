module registrationx

import vphp

type RegistrationStateCapture = fn (mut RegistrationScope)

@[heap]
pub struct RegistrationStateContext {
	parent  &RegistrationStateContext
	capture RegistrationStateCapture
}

@[thread_local]
__global registration_state_context &RegistrationStateContext

pub fn watch_registration_state(capture fn (mut RegistrationScope)) &RegistrationStateContext {
	unsafe {
		context := &RegistrationStateContext{
			parent:  registration_state_context
			capture: capture
		}
		registration_state_context = context
		return context
	}
}

pub fn (context &RegistrationStateContext) close() {
	unsafe {
		registration_state_context = context.parent
	}
}

struct RegistrationChange {
	apply fn (bool)
	owner vphp.PhpValue
}

@[heap]
pub struct RegistrationScope {
mut:
	parent         &RegistrationScope = unsafe { nil }
	changes        []RegistrationChange
	snapshots      map[usize]bool
	object_tracker vphp.PlainObjectTracker
}

@[thread_local]
__global registration_scope &RegistrationScope

pub fn begin_registration_scope() &RegistrationScope {
	unsafe {
		mut scope := &RegistrationScope{ parent: registration_scope }
		registration_scope = scope
		mut context := registration_state_context
		for !isnil(context) {
			context.capture(mut scope)
			context = context.parent
		}
		return scope
	}
}

pub fn current_registration_scope() ?&RegistrationScope {
	unsafe {
		if isnil(registration_scope) {
			return none
		}
		return registration_scope
	}
}

pub fn (mut scope RegistrationScope) add_change(change fn (bool)) {
	// Keep the PHP receiver alive until the outermost callback settles the change.
	mut current := vphp.PhpValue.adopt_zval(vphp.PhpObject.current_request_owned_zval())
	defer {
		current.release()
	}
	scope.changes << RegistrationChange{
		apply: change
		owner: current.retain()
	}
}

pub fn (mut scope RegistrationScope) needs_snapshot(owner usize) bool {
	if owner in scope.snapshots {
		return false
	}
	scope.snapshots[owner] = true
	return true
}

pub fn (scope &RegistrationScope) has_changes() bool {
	return scope.changes.len > 0
}

pub fn (mut scope RegistrationScope) snapshot_service(value vphp.PhpValue) {
	if !value.is_object() {
		return
	}
	if !scope.object_tracker.is_valid() {
		scope.object_tracker = vphp.PlainObjectTracker.new()
	}
	if snapshot := scope.object_tracker.capture(value) {
		scope.add_change(fn [snapshot] (commit bool) {
			if !commit {
				snapshot.restore()
			}
			snapshot.release()
		})
	}
}

pub fn (mut scope RegistrationScope) finish() {
	unsafe {
		registration_scope = scope.parent
	}
	scope.object_tracker.release()
	commit := !vphp.has_exception()
	if commit && scope.parent != unsafe { nil } {
		// A successful inner callback is still part of the enclosing callback.
		scope.parent.changes << scope.changes
	} else {
		for i := scope.changes.len - 1; i >= 0; i-- {
			scope.changes[i].apply(commit)
		}
		for mut change in scope.changes {
			change.owner.release()
		}
	}
	unsafe {
		scope.changes.free()
		scope.snapshots.free()
	}
}

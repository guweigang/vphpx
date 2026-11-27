module registrationx

import vphp

type RegistrationStateCapture = fn (mut RegistrationScope)

@[heap]
pub struct RegistrationStateContext {
	parent  &RegistrationStateContext
	capture RegistrationStateCapture
}

@[thread_local]
__global registration_state_contexts map[usize]&RegistrationStateContext

pub fn watch_registration_state(capture fn (mut RegistrationScope)) &RegistrationStateContext {
	fiber := vphp.PhpFiber.current_id()
	unsafe {
		init_registration_fibers()
		context := &RegistrationStateContext{
			parent:  registration_state_contexts[fiber] or { nil }
			capture: capture
		}
		registration_state_contexts[fiber] = context
		return context
	}
}

pub fn (context &RegistrationStateContext) close() {
	fiber := vphp.PhpFiber.current_id()
	unsafe {
		if isnil(context.parent) {
			registration_state_contexts.delete(fiber)
		} else {
			registration_state_contexts[fiber] = context.parent
		}
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
__global registration_scopes map[usize]&RegistrationScope

@[thread_local]
__global registration_fibers_initialized bool

fn init_registration_fibers() {
	unsafe {
		if !registration_fibers_initialized {
			registration_scopes = map[usize]&RegistrationScope{}
			registration_state_contexts = map[usize]&RegistrationStateContext{}
			registration_fibers_initialized = true
		}
	}
}

pub fn begin_registration_scope() &RegistrationScope {
	fiber := vphp.PhpFiber.current_id()
	unsafe {
		init_registration_fibers()
		mut scope := &RegistrationScope{
			parent: registration_scopes[fiber] or { nil }
		}
		registration_scopes[fiber] = scope
		mut context := registration_state_contexts[fiber] or { nil }
		for !isnil(context) {
			context.capture(mut scope)
			context = context.parent
		}
		return scope
	}
}

pub fn current_registration_scope() ?&RegistrationScope {
	fiber := vphp.PhpFiber.current_id()
	unsafe {
		scope := registration_scopes[fiber] or { return none }
		return scope
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
	fiber := vphp.PhpFiber.current_id()
	unsafe {
		if isnil(scope.parent) {
			registration_scopes.delete(fiber)
		} else {
			registration_scopes[fiber] = scope.parent
		}
	}
	mut failure := vphp.PhpException.take_current()
	defer {
		if mut original := failure {
			if !vphp.has_exception() {
				original.throw()
			}
			original.release()
		}
	}
	scope.object_tracker.release()
	failure = registration_cleanup_failure(failure)
	commit := failure == none && !vphp.has_exception()
	if commit && scope.parent != unsafe { nil } {
		// A successful inner callback is still part of the enclosing callback.
		scope.parent.changes << scope.changes
	} else {
		for i := scope.changes.len - 1; i >= 0; i-- {
			scope.changes[i].apply(commit)
			failure = registration_cleanup_failure(failure)
		}
		for mut change in scope.changes {
			change.owner.release()
			failure = registration_cleanup_failure(failure)
		}
	}
	unsafe {
		scope.changes.free()
		scope.snapshots.free()
	}
}

fn registration_cleanup_failure(primary ?vphp.PhpThrowable) ?vphp.PhpThrowable {
	mut cleanup := vphp.PhpException.take_current() or { return primary }
	if original := primary {
		original.append_previous(cleanup)
		cleanup.release()
		return original
	}
	return cleanup
}

module vphp

import vphp.zend

pub struct PlainObjectTracker {
	handle voidptr
}

pub struct PlainObjectSnapshot {
	handle voidptr
}

pub fn PlainObjectTracker.new() PlainObjectTracker {
	return PlainObjectTracker{ handle: zend.new_plain_object_tracker() }
}

pub fn (tracker PlainObjectTracker) is_valid() bool {
	return tracker.handle != unsafe { nil }
}

// Capture the eligible object graph once per tracker, keeping its original instances.
pub fn (tracker PlainObjectTracker) capture(root PhpValue) ?PlainObjectSnapshot {
	if !tracker.is_valid() {
		return none
	}
	handle := zend.capture_plain_object(tracker.handle, root.to_zval().raw_ptr())
	if handle == unsafe { nil } {
		return none
	}
	return PlainObjectSnapshot{ handle: handle }
}

pub fn (tracker PlainObjectTracker) release() {
	zend.release_plain_object_state(tracker.handle)
}

pub fn (value PhpValue) snapshot_plain_object() ?PlainObjectSnapshot {
	tracker := PlainObjectTracker.new()
	defer {
		tracker.release()
	}
	return tracker.capture(value)
}

pub fn (snapshot PlainObjectSnapshot) restore() {
	zend.restore_plain_objects(snapshot.handle)
}

pub fn (snapshot PlainObjectSnapshot) release() {
	zend.release_plain_object_state(snapshot.handle)
}

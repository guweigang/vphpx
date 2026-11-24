module zend

#include "v_bridge.h"

fn C.vphp_task_enter_fiber(voidptr) voidptr
fn C.vphp_task_restore_fiber(voidptr)
fn C.vphp_task_can_suspend() bool
fn C.vphp_task_swap_group(voidptr) voidptr
fn C.vphp_task_current_group() voidptr
fn C.vphp_task_stream_is_open(voidptr) bool
fn C.vphp_task_stream_same(voidptr, voidptr) bool
fn C.vphp_task_socket_open(&char, usize, bool, &C.zval, &C.zval, &C.zval) bool
fn C.vphp_task_socket_connected(voidptr, &C.zval) bool
fn C.vphp_task_socket_accept(voidptr, &C.zval, &C.zval) int
fn C.vphp_task_dependency_ptr(&C.zval) voidptr
fn C.vphp_task_close_dependency(&C.zval)
fn C.vphp_task_stream_descriptor(voidptr, &usize, &bool) int
fn C.vphp_task_poll_wait(&usize, &i32, &i32, i32, i32) i32

pub fn task_enter_fiber(raw voidptr) voidptr {
	return C.vphp_task_enter_fiber(raw)
}

pub fn task_restore_fiber(previous voidptr) {
	C.vphp_task_restore_fiber(previous)
}

pub fn task_can_suspend() bool {
	return C.vphp_task_can_suspend()
}

pub fn task_swap_group(group voidptr) voidptr {
	return C.vphp_task_swap_group(group)
}

pub fn task_current_group() voidptr {
	return C.vphp_task_current_group()
}

pub fn task_stream_is_open(raw voidptr) bool {
	return C.vphp_task_stream_is_open(raw)
}

pub fn task_stream_same(first voidptr, second voidptr) bool {
	return C.vphp_task_stream_same(first, second)
}

pub fn task_socket_open(address string, listen bool, context voidptr, result voidptr, failure voidptr) bool {
	return unsafe {
		C.vphp_task_socket_open(&char(address.str), usize(address.len), listen, &C.zval(context),
			&C.zval(result), &C.zval(failure))
	}
}

pub fn task_socket_connected(raw voidptr, failure voidptr) bool {
	return unsafe { C.vphp_task_socket_connected(raw, &C.zval(failure)) }
}

pub fn task_socket_accept(raw voidptr, result voidptr, failure voidptr) int {
	return unsafe { C.vphp_task_socket_accept(raw, &C.zval(result), &C.zval(failure)) }
}

pub fn task_dependency_ptr(raw voidptr) voidptr {
	return unsafe { C.vphp_task_dependency_ptr(&C.zval(raw)) }
}

pub fn task_close_dependency(raw voidptr) {
	unsafe { C.vphp_task_close_dependency(&C.zval(raw)) }
}

pub fn task_stream_descriptor(raw voidptr, fd &usize, buffered &bool) bool {
	return C.vphp_task_stream_descriptor(raw, fd, buffered) == 0
}

pub fn task_poll_wait(fds []usize, interests []i32, mut ready []i32, timeout int) i32 {
	return C.vphp_task_poll_wait(fds.data, interests.data, ready.data, i32(fds.len), i32(timeout))
}

pub fn task_poll_ready(fd usize, interest i32) !bool {
	return task_poll_ready_for(fd, interest, 0)
}

pub fn task_poll_ready_for(fd usize, interest i32, milliseconds int) !bool {
	mut ready := i32(0)
	if C.vphp_task_poll_wait(&fd, &interest, &ready, 1, i32(milliseconds)) < 0 {
		return error('Unable to poll task streams')
	}
	return ready & interest != 0
}

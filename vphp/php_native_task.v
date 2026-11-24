module vphp

import sync.stdatomic
import vphp.zend

// PhpNativeTask owns a V thread and its cached result. Its PHP request thread
// can wait repeatedly, including from several managed Fibers.
pub struct PhpNativeTask[T] {
pub mut:
	handle thread T
mut:
	completed u64
	result    ?T
}

// The job and its result must contain only V-owned data.
pub fn spawn_php_native_task[J, T](job J, execute fn (J) T) &PhpNativeTask[T] {
	// Zend may hold the only reference to this pointer.
	mut task := unsafe { &PhpNativeTask[T](malloc_uncollectable(int(sizeof(PhpNativeTask[T])))) }
	unsafe { *task = PhpNativeTask[T]{} }
	task.handle = spawn run_php_native_task[J, T](job, execute, task)
	return task
}

fn run_php_native_task[J, T](job J, execute fn (J) T, task &PhpNativeTask[T]) T {
	result := execute(job)
	stdatomic.store_u64(&task.completed, 1)
	return result
}

pub fn (mut task PhpNativeTask[T]) wait() !T {
	for zend.task_can_suspend() && !task.is_complete() {
		sleep_php_task(1)!
	}
	// Another Fiber may have joined the thread while this one was suspended.
	if result := task.result {
		return result
	}
	result := task.handle.wait()
	task.result = result
	return result
}

pub fn (task &PhpNativeTask[T]) is_complete() bool {
	return stdatomic.load_u64(&task.completed) != 0
}

// Release once, after the PHP owner and all of its waiters are done.
pub fn (task &PhpNativeTask[T]) release() {
	if stdatomic.load_u64(&task.completed) == 0 {
		spawn release_php_native_task[T](task)
		return
	}
	release_php_native_task[T](task)
}

fn release_php_native_task[T](task &PhpNativeTask[T]) {
	if task.result == none {
		task.handle.wait()
	}
	unsafe { free(task) }
}

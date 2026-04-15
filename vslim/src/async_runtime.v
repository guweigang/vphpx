module main

fn C.emalloc(size usize) voidptr
fn C.efree(ptr voidptr)

enum VSlimAsyncKind {
	database_query
	database_execute
}

struct VSlimAsyncJob {
mut:
	kind     VSlimAsyncKind
	database VSlimDatabaseAsyncJob
}

struct VSlimAsyncResult {
	ok             bool
	rows           []map[string]string
	affected_rows  u64
	last_insert_id i64
	error          string
}

struct VSlimAsyncHandle {
mut:
	handle thread VSlimAsyncResult
}

fn async_run(job VSlimAsyncJob) VSlimAsyncResult {
	match job.kind {
		.database_query, .database_execute {
			return database_async_run(job.database)
		}
	}
}

fn async_spawn(job VSlimAsyncJob) &VSlimAsyncHandle {
	unsafe {
		mut handle := &VSlimAsyncHandle(C.emalloc(usize(sizeof(VSlimAsyncHandle))))
		handle.handle = spawn async_run(job)
		return handle
	}
}

fn async_wait(ptr &VSlimAsyncHandle) VSlimAsyncResult {
	if ptr == unsafe { nil } {
		return VSlimAsyncResult{
			error: 'async handle is missing'
		}
	}
	return ptr.handle.wait()
}

fn async_release(ptr &VSlimAsyncHandle) {
	if ptr == unsafe { nil } {
		return
	}
	unsafe {
		C.efree(ptr)
	}
}

module databasex

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

fn (job VSlimAsyncJob) run() VSlimAsyncResult {
	match job.kind {
		.database_query, .database_execute {
			return job.database.run_async()
		}
	}
}

fn (job VSlimAsyncJob) spawn() &VSlimAsyncHandle {
	unsafe {
		mut handle := &VSlimAsyncHandle(C.emalloc(usize(sizeof(VSlimAsyncHandle))))
		handle.handle = spawn job.run()
		return handle
	}
}

fn (handle &VSlimAsyncHandle) wait() VSlimAsyncResult {
	if handle == unsafe { nil } {
		return VSlimAsyncResult{
			error: 'async handle is missing'
		}
	}
	return handle.handle.wait()
}

fn (handle &VSlimAsyncHandle) release() {
	if handle == unsafe { nil } {
		return
	}
	unsafe {
		C.efree(handle)
	}
}

module databasex

struct VSlimAsyncResult {
	ok             bool
	rows           []map[string]string
	affected_rows  u64
	last_insert_id i64
	error          string
}

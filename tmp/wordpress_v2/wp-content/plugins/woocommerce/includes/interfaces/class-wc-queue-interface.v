import rt

interface WC_Queue_Interface {
	add(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	schedule_single(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	schedule_recurring(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	schedule_cron(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	cancel(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	cancel_all(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_next(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	search(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_hook := rt.new_null()
	mut var_args := rt.new_null()
	mut var_group := rt.new_null()
	mut var_timestamp := rt.new_null()
	mut var_interval_in_seconds := rt.new_null()
	mut var_cron_schedule := rt.new_null()
	mut var_return_format := rt.new_null()
}

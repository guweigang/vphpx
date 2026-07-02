import rt

interface Base {
	construct(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	save(rt.PhpVal) rt.PhpVal
	load() rt.PhpVal
	mtime() rt.PhpVal
	touch() rt.PhpVal
	unlink() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_location := rt.new_null()
	mut var_name := rt.new_null()
	mut var_type := rt.new_null()
	mut var_data := rt.new_null()
	rt.call_function('class_alias', [rt.new_string('SimplePie\\Cache\\Base'),
		rt.new_string('SimplePie_Cache_Base')])
}

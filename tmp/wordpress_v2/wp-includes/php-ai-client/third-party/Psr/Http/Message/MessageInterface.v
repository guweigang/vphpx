import rt

interface MessageInterface {
	getprotocolversion() rt.PhpVal
	withprotocolversion(rt.PhpVal) rt.PhpVal
	getheaders() rt.PhpVal
	hasheader(rt.PhpVal) rt.PhpVal
	getheader(rt.PhpVal) rt.PhpVal
	getheaderline(rt.PhpVal) rt.PhpVal
	withheader(rt.PhpVal, rt.PhpVal) rt.PhpVal
	withaddedheader(rt.PhpVal, rt.PhpVal) rt.PhpVal
	withoutheader(rt.PhpVal) rt.PhpVal
	getbody() rt.PhpVal
	withbody(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_version := rt.new_null()
	mut var_name := rt.new_null()
	mut var_value := rt.new_null()
	mut var_body := rt.new_null()
}

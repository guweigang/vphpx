import rt

interface RequestInterface {
	getrequesttarget() rt.PhpVal
	withrequesttarget(rt.PhpVal) rt.PhpVal
	getmethod() rt.PhpVal
	withmethod(rt.PhpVal) rt.PhpVal
	geturi() rt.PhpVal
	withuri(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_requestTarget := rt.new_null()
	mut var_method := rt.new_null()
	mut var_uri := rt.new_null()
	mut var_preserveHost := rt.new_null()
}

import rt

interface ServerRequestInterface {
	getserverparams() rt.PhpVal
	getcookieparams() rt.PhpVal
	withcookieparams(rt.PhpVal) rt.PhpVal
	getqueryparams() rt.PhpVal
	withqueryparams(rt.PhpVal) rt.PhpVal
	getuploadedfiles() rt.PhpVal
	withuploadedfiles(rt.PhpVal) rt.PhpVal
	getparsedbody() rt.PhpVal
	withparsedbody(rt.PhpVal) rt.PhpVal
	getattributes() rt.PhpVal
	getattribute(rt.PhpVal, rt.PhpVal) rt.PhpVal
	withattribute(rt.PhpVal, rt.PhpVal) rt.PhpVal
	withoutattribute(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_cookies := rt.new_null()
	mut var_query := rt.new_null()
	mut var_uploadedFiles := rt.new_null()
	mut var_data := rt.new_null()
	mut var_name := rt.new_null()
	mut var_default := rt.new_null()
	mut var_value := rt.new_null()
}

import rt

interface Positionable {
	getlinenumber() rt.PhpVal
	getlineno() rt.PhpVal
	getcolumnnumber() rt.PhpVal
	getcolno() rt.PhpVal
	setposition(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_lineNumber := rt.new_null()
	mut var_columnNumber := rt.new_null()
}

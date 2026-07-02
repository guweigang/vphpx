import rt

interface LeafType {
	serialize(rt.PhpVal) rt.PhpVal
	parsevalue(rt.PhpVal) rt.PhpVal
	parseliteral(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_value := rt.new_null()
	mut var_valueNode := rt.new_null()
	mut var_variables := rt.new_null()
}

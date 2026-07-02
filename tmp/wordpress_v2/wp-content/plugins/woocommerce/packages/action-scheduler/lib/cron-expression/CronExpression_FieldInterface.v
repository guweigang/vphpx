import rt

interface CronExpression_FieldInterface {
	issatisfiedby(rt.PhpVal, rt.PhpVal) rt.PhpVal
	increment(rt.PhpVal, rt.PhpVal) rt.PhpVal
	validate(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_date := rt.new_null()
	mut var_value := rt.new_null()
	mut var_invert := rt.new_null()
}

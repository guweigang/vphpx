import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	return rt.create_array([
		rt.ArrayItem{ key: 'weight', val: rt.create_array([
			rt.ArrayItem{ key: 'kg', val: rt.call_function('__', [
				rt.new_string('kg'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'g', val: rt.call_function('__', [
				rt.new_string('g'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'lbs', val: rt.call_function('__', [
				rt.new_string('lbs'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'oz', val: rt.call_function('__', [
				rt.new_string('oz'), rt.new_string('woocommerce')]) },
		]) },
		rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
			rt.ArrayItem{ key: 'm', val: rt.call_function('__', [
				rt.new_string('m'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'cm', val: rt.call_function('__', [
				rt.new_string('cm'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'mm', val: rt.call_function('__', [
				rt.new_string('mm'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'in', val: rt.call_function('__', [
				rt.new_string('in'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'yd', val: rt.call_function('__', [
				rt.new_string('yd'), rt.new_string('woocommerce')]) },
		]) },
	])
}

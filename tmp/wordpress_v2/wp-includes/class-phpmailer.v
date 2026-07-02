import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('function_exists', [rt.new_string('_deprecated_file')])) {
		rt.call_function('_deprecated_file', [
			rt.call_function('basename', [rt.new_string(@FILE)]),
			rt.new_string('5.5.0'),
			rt.new_string((rt.get_constant('WPINC')).str() + '/PHPMailer/PHPMailer.php'),
			rt.call_function('__', [
				rt.new_string('The PHPMailer class has been moved to wp-includes/PHPMailer subdirectory and now uses the PHPMailer\\PHPMailer namespace.'),
			]),
		])
	}
	rt.include_file(@DIR + '/PHPMailer/PHPMailer.php', '4')
	rt.include_file(@DIR + '/PHPMailer/Exception.php', '4')
	rt.call_function('class_alias', [Class_PHPMailer_PHPMailer_PHPMailer.class(),
		rt.new_string('PHPMailer')])
	rt.call_function('class_alias', [Class_PHPMailer_PHPMailer_Exception.class(),
		rt.new_string('phpmailerException')])
}

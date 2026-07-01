import rt

pub fn init_wp_includes_class_smtp_php() {
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('5.5.0'),
		(rt.get_constant('WPINC')).str() + '/PHPMailer/SMTP.php',
		rt.call_function('__', [
			rt.new_string('The SMTP class has been moved to the wp-includes/PHPMailer subdirectory and now uses the PHPMailer\\PHPMailer namespace.'),
		]),
	])
	rt.include_file(@DIR + '/PHPMailer/SMTP.php', '4')
	rt.call_function('class_alias', [Class_PHPMailer_PHPMailer_SMTP.class(),
		rt.new_string('SMTP')])
}

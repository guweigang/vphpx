import rt

interface CronExpression_FieldInterface {
	issatisfiedby(rt.PhpVal, rt.PhpVal) rt.PhpVal
	increment(rt.PhpVal, rt.PhpVal) rt.PhpVal
	validate(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_lib_cron_expression_cronexpression_fieldinterface_php() {
	mut var_date := rt.new_null()
	mut var_value := rt.new_null()
	mut var_invert := rt.new_null()
}

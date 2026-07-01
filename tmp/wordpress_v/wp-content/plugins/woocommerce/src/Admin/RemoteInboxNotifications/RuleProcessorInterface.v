import rt

interface RuleProcessorInterface {
		process( rt.PhpVal,  rt.PhpVal) rt.PhpVal
		validate( rt.PhpVal) rt.PhpVal
}



pub fn init_wp_content_plugins_woocommerce_src_admin_remoteinboxnotifications_ruleprocessorinterface_php() {
	mut var_rule := rt.new_null()
	mut var_stored_state := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

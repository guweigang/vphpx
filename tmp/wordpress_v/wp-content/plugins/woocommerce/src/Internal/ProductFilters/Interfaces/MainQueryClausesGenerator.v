import rt

interface MainQueryClausesGenerator {
		add_query_clauses_for_main_query( rt.PhpVal,  rt.PhpVal) rt.PhpVal
}



pub fn init_wp_content_plugins_woocommerce_src_internal_productfilters_interfaces_mainqueryclausesgenerator_php() {
	mut var_args := rt.new_null()
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

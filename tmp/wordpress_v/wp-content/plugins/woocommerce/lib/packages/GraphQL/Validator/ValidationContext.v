import rt

interface ValidationContext {
	reporterror(rt.PhpVal) rt.PhpVal
	geterrors() rt.PhpVal
	getdocument() rt.PhpVal
	getschema() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_validationcontext_php() {
	mut var_error := rt.new_null()
	// unsupported statement: Stmt_Declare
}

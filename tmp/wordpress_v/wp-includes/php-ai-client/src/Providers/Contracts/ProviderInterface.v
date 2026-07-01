import rt

interface ProviderInterface {
	metadata() rt.PhpVal
	model(rt.PhpVal, rt.PhpVal) rt.PhpVal
	availability() rt.PhpVal
	modelmetadatadirectory() rt.PhpVal
}

pub fn init_wp_includes_php_ai_client_src_providers_contracts_providerinterface_php() {
	mut var_modelId := rt.new_null()
	mut var_modelConfig := rt.new_null()
	// unsupported statement: Stmt_Declare
}

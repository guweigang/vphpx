import rt

interface RegistryAware {
	set_registry(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_includes_simplepie_src_registryaware_php() {
	mut var_registry := rt.new_null()
	// unsupported statement: Stmt_Declare
}

import rt

interface Akismet_Ability_Interface {
	get_config() rt.PhpVal
	execute(rt.PhpVal) rt.PhpVal
	current_user_has_permission(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_akismet_abilities_interface_akismet_ability_php() {
	mut var_input := rt.new_null()
	// unsupported statement: Stmt_Declare
}

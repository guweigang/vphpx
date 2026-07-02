import rt

interface Akismet_Ability_Interface {
	get_config() rt.PhpVal
	execute(rt.PhpVal) rt.PhpVal
	current_user_has_permission(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_input := rt.new_null()
}

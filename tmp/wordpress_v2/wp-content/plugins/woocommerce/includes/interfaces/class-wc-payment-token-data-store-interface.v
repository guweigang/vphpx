import rt

interface WC_Payment_Token_Data_Store_Interface {
	get_tokens(rt.PhpVal) rt.PhpVal
	get_users_default_token(rt.PhpVal) rt.PhpVal
	get_token_by_id(rt.PhpVal) rt.PhpVal
	get_metadata(rt.PhpVal) rt.PhpVal
	get_token_type_by_id(rt.PhpVal) rt.PhpVal
	set_default_status(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_args := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_token_id := rt.new_null()
	mut var_status := rt.new_null()
}

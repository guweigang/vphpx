import rt
import crypto.md5

struct Class_PasswordHash {
	rt.PhpObjectBase
pub mut:
		itoa64 string
		iteration_count_log2 rt.PhpVal = rt.new_null()
		portable_hashes rt.PhpVal = rt.new_null()
		random_state rt.PhpVal = rt.new_null()
}

fn (mut this Class_PasswordHash) construct(var_iteration_count_log2 rt.PhpVal, var_portable_hashes rt.PhpVal)  {
	mut var_iteration_count_log2_mutated := var_iteration_count_log2
	this.itoa64 = './0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_iteration_count_log2_mutated, rt.new_int(4))) || rt.is_true(rt.greater(var_iteration_count_log2_mutated, rt.new_int(31))))) {
		var_iteration_count_log2_mutated = rt.new_int(rt.new_int(8))
	}
	this.iteration_count_log2 = var_iteration_count_log2_mutated.dup()
	this.portable_hashes = var_portable_hashes.dup()
	this.random_state = rt.call_function('microtime', []rt.PhpVal{})
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('getmypid')])) {
		// unsupported expression: Expr_AssignOp_Concat
	}
}

fn (mut this Class_PasswordHash) passwordhash(var_iteration_count_log2 rt.PhpVal, var_portable_hashes rt.PhpVal)  {
	mut var_iteration_count_log2_mutated := var_iteration_count_log2
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_PasswordHash{}; temp.construct(arg_0, arg_1); return rt.new_null() }(var_iteration_count_log2_mutated.dup(), var_portable_hashes.dup())
}

fn (mut this Class_PasswordHash) get_random_bytes(var_count rt.PhpVal) rt.PhpVal {
	mut var_count_mutated := var_count
	mut var_output := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_readable', [rt.new_string('/dev/urandom')])) && rt.is_true(mut var_fh := rt.call_function('fopen', [rt.new_string('/dev/urandom'), rt.new_string('rb')])))) {
		var_output = rt.call_function('fread', [var_fh.dup(), var_count_mutated.dup()])
		rt.call_function('fclose', [var_fh.dup()])
	}
	if rt.is_true(rt.less(rt.new_int(var_output.dup().to_string().len), var_count_mutated)) {
		var_output = rt.new_string(rt.new_string(''))
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_count_mutated))) { break }
				this.random_state = rt.new_string(md5.hexhash((rt.call_function('microtime', []rt.PhpVal{})).str() + (this.random_state).str()))
				// unsupported expression: Expr_AssignOp_Concat
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
		var_output = rt.call_function('substr', [var_output.dup(), rt.new_int(0), var_count_mutated.dup()])
	}
	return var_output.dup()
}

fn (mut this Class_PasswordHash) encode64(var_input rt.PhpVal, var_count rt.PhpVal) rt.PhpVal {
	mut var_count_mutated := var_count
	mut var_output := rt.new_string(rt.new_string(''))
	mut var_i := rt.new_int(rt.new_int(0))
	for {
		mut var_value := rt.call_function('ord', [var_input.array_get(rt.post_inc(var_i))])
		// unsupported expression: Expr_AssignOp_Concat
		if rt.is_true(rt.less(var_i, var_count_mutated)) {
			// unsupported expression: Expr_AssignOp_BitwiseOr
		}
		// unsupported expression: Expr_AssignOp_Concat
		if rt.is_true(rt.greater_equal(rt.post_inc(var_i), var_count_mutated)) {
			break
		}
		if rt.is_true(rt.less(var_i, var_count_mutated)) {
			// unsupported expression: Expr_AssignOp_BitwiseOr
		}
		// unsupported expression: Expr_AssignOp_Concat
		if rt.is_true(rt.greater_equal(rt.post_inc(var_i), var_count_mutated)) {
			break
		}
		// unsupported expression: Expr_AssignOp_Concat
		if !(rt.is_true(rt.less(var_i, var_count_mutated))) {
			break
		}
	}
	return var_output.dup()
}

fn (mut this Class_PasswordHash) gensalt_private(var_input rt.PhpVal) rt.PhpVal {
	mut var_output := rt.new_string(rt.new_string('$P$'))
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	return var_output.dup()
}

fn (mut this Class_PasswordHash) crypt_private(var_password rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_output := rt.new_string(rt.new_string('*0'))
	if rt.is_true(rt.identical(rt.call_function('substr', [var_setting.dup(), rt.new_int(0), rt.new_int(2)]), var_output)) {
		var_output = rt.new_string(rt.new_string('*1'))
	}
	mut var_id := rt.call_function('substr', [var_setting.dup(), rt.new_int(0), rt.new_int(3)])
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return var_output.dup()
	}
	mut var_count_log2 := rt.call_function('strpos', [this.itoa64, var_setting.array_get(3)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_count_log2, rt.new_int(7))) || rt.is_true(rt.greater(var_count_log2, rt.new_int(30))))) {
		return var_output.dup()
	}
	mut var_count := rt.new_int(rt.shift_left(rt.new_int(1), var_count_log2))
	mut var_salt := rt.call_function('substr', [var_setting.dup(), rt.new_int(4), rt.new_int(8)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_output.dup()
	}
	mut var_hash := rt.new_string(rt.new_string(md5.hexhash((var_salt).str() + (var_password).str())))
	for {
		var_hash = rt.new_string(rt.new_string(md5.hexhash((var_hash).str() + (var_password).str())))
		if !(rt.is_true(rt.pre_dec(var_count))) {
			break
		}
	}
	var_output = rt.call_function('substr', [var_setting.dup(), rt.new_int(0), rt.new_int(12)])
	// unsupported expression: Expr_AssignOp_Concat
	return var_output.dup()
}

fn (mut this Class_PasswordHash) gensalt_blowfish(var_input rt.PhpVal) rt.PhpVal {
	mut var_itoa64 := rt.new_string(rt.new_string('./ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))
	mut var_output := rt.new_string(rt.new_string('$2a$'))
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	mut var_i := rt.new_int(rt.new_int(0))
	for {
		mut var_c1 := rt.call_function('ord', [var_input.array_get(rt.post_inc(var_i))])
		// unsupported expression: Expr_AssignOp_Concat
		var_c1 = rt.new_int(rt.bitwise_and(var_c1, rt.new_int(3)) << 4)
		if rt.is_true(rt.greater_equal(var_i, rt.new_int(16))) {
			// unsupported expression: Expr_AssignOp_Concat
			break
		}
		mut var_c2 := rt.call_function('ord', [var_input.array_get(rt.post_inc(var_i))])
		// unsupported expression: Expr_AssignOp_BitwiseOr
		// unsupported expression: Expr_AssignOp_Concat
		var_c1 = rt.new_int(rt.bitwise_and(var_c2, rt.new_int(15)) << 2)
		var_c2 = rt.call_function('ord', [var_input.array_get(rt.post_inc(var_i))])
		// unsupported expression: Expr_AssignOp_BitwiseOr
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		if !(rt.is_true(rt.new_int(1))) {
			break
		}
	}
	return var_output.dup()
}

fn (mut this Class_PasswordHash) hashpassword(var_password rt.PhpVal) rt.PhpVal {
	if var_password.dup().to_string().len > 4096 {
		return rt.new_string('*')
	}
	mut var_random := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.get_constant('CRYPT_BLOWFISH'), rt.new_int(1))) && rt.is_true(rt.new_bool(!(rt.is_true(this.portable_hashes)))))) {
		var_random = this.get_random_bytes(rt.new_int(16))
		mut var_hash := rt.call_function('crypt', [var_password.dup(), this.gensalt_blowfish(var_random.dup())])
		if var_hash.dup().to_string().len == 60 {
			return var_hash.dup()
		}
	}
	if var_random.dup().to_string().len < 6 {
		var_random = this.get_random_bytes(rt.new_int(6))
	}
	var_hash = this.crypt_private(var_password.dup(), this.gensalt_private(var_random.dup()))
	if var_hash.dup().to_string().len == 34 {
		return var_hash.dup()
	}
	return rt.new_string('*')
}

fn (mut this Class_PasswordHash) checkpassword(var_password rt.PhpVal, var_stored_hash rt.PhpVal) bool {
	if var_password.dup().to_string().len > 4096 {
		return false
	}
	mut var_hash := this.crypt_private(var_password.dup(), var_stored_hash.dup())
	if rt.is_true(rt.identical(var_hash.array_get(0), rt.new_string('*'))) {
		var_hash = rt.call_function('crypt', [var_password.dup(), var_stored_hash.dup()])
	}
	return (rt.identical(var_hash, var_stored_hash)).to_bool()
}

fn create_passwordhash(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_PasswordHash {
	mut obj := &Class_PasswordHash{
		PhpObjectBase: rt.PhpObjectBase{}
		itoa64: ''
		iteration_count_log2: rt.new_null()
		portable_hashes: rt.new_null()
		random_state: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_PasswordHash) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'PasswordHash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.passwordhash(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_random_bytes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_random_bytes(dispatch_arg_0)
		}
		'encode64' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.encode64(dispatch_arg_0, dispatch_arg_1)
		}
		'gensalt_private' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.gensalt_private(dispatch_arg_0)
		}
		'crypt_private' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.crypt_private(dispatch_arg_0, dispatch_arg_1)
		}
		'gensalt_blowfish' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.gensalt_blowfish(dispatch_arg_0)
		}
		'HashPassword' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.hashpassword(dispatch_arg_0)
		}
		'CheckPassword' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.checkpassword(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_PasswordHash) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'itoa64' { return rt.new_string(this.itoa64) }
		'iteration_count_log2' { return this.iteration_count_log2 }
		'portable_hashes' { return this.portable_hashes }
		'random_state' { return this.random_state }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_PasswordHash) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'itoa64' { this.itoa64 = (val).str(); return true }
		'iteration_count_log2' { this.iteration_count_log2 = val; return true }
		'portable_hashes' { this.portable_hashes = val; return true }
		'random_state' { this.random_state = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_phpass_php() {
}

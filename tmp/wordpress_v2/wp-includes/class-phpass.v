import rt
import crypto.md5

struct Class_PasswordHash {
	rt.PhpObjectBase
pub mut:
	itoa64               string
	iteration_count_log2 rt.PhpVal = rt.new_null()
	portable_hashes      rt.PhpVal = rt.new_null()
	random_state         rt.PhpVal = rt.new_null()
}

fn (mut this Class_PasswordHash) construct(var_iteration_count_log2 rt.PhpVal, var_portable_hashes rt.PhpVal) {
	mut var_iteration_count_log2_mutated := var_iteration_count_log2
	this.itoa64 = './0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
	if rt.is_true(rt.less(var_iteration_count_log2_mutated, rt.new_int(4)))
		|| rt.is_true(rt.greater(var_iteration_count_log2_mutated, rt.new_int(31))) {
		var_iteration_count_log2_mutated = rt.new_int(8)
	}
	this.iteration_count_log2 = var_iteration_count_log2_mutated.clone()
	this.portable_hashes = var_portable_hashes.clone()
	this.random_state = rt.call_function('microtime', []rt.PhpVal{})
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('getmypid')])) {
		this.random_state = rt.concat(this.random_state,
			rt.call_function('getmypid', []rt.PhpVal{}))
	}
}

fn (mut this Class_PasswordHash) passwordhash(var_iteration_count_log2 rt.PhpVal, var_portable_hashes rt.PhpVal) {
	mut var_iteration_count_log2_mutated := var_iteration_count_log2
	mut iife_temp_0 := Class_PasswordHash{}
	iife_temp_0.construct(var_iteration_count_log2_mutated.clone(), var_portable_hashes.clone())
	rt.new_null()
}

fn (mut this Class_PasswordHash) get_random_bytes(var_count rt.PhpVal) rt.PhpVal {
	mut var_count_mutated := var_count
	mut var_output := rt.new_string('')
	mut var_fh := rt.call_function('fopen', [rt.new_string('/dev/urandom'),
		rt.new_string('rb')])
	if rt.is_true(rt.call_function('is_readable', [rt.new_string('/dev/urandom')]))
		&& rt.is_true(var_fh) {
		var_output = rt.call_function('fread', [var_fh.clone(),
			var_count_mutated.clone()])
		rt.call_function('fclose', [var_fh.clone()])
	}
	if rt.is_true(rt.less(rt.new_int(var_output.clone().to_string().len), var_count_mutated)) {
		var_output = rt.new_string('')
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_count_mutated))) { break
			 }
			this.random_state = rt.new_string(md5.hexhash(
				(rt.call_function('microtime', []rt.PhpVal{})).str() + (this.random_state).str()))
			var_output = rt.concat(var_output,
				rt.new_string(md5.hexhash(this.random_state.to_string())))
			var_i = rt.add(var_i, rt.new_int(16))
		}
		var_output = rt.call_function('substr', [var_output.clone(),
			rt.new_int(0), var_count_mutated.clone()])
	}
	return var_output.clone()
}

fn (mut this Class_PasswordHash) encode64(var_input rt.PhpVal, var_count rt.PhpVal) rt.PhpVal {
	mut var_count_mutated := var_count
	mut var_output := rt.new_string('')
	mut var_i := rt.new_int(0)
	for {
		mut var_value := rt.call_function('ord', [var_input.array_get(rt.post_inc(var_i))])
		var_output = rt.concat(var_output, this.itoa64.array_get(rt.new_int(rt.bitwise_and(var_value,
			rt.new_int(63)))))
		if rt.is_true(rt.less(var_i, var_count_mutated)) {
			rt.new_null()
		}
		var_output = rt.concat(var_output, this.itoa64.array_get(rt.new_int(rt.shift_right(var_value,
			rt.new_int(6)) & 63)))
		if rt.is_true(rt.greater_equal(rt.post_inc(var_i), var_count_mutated)) {
			break
		}
		if rt.is_true(rt.less(var_i, var_count_mutated)) {
			rt.new_null()
		}
		var_output = rt.concat(var_output, this.itoa64.array_get(rt.new_int(rt.shift_right(var_value,
			rt.new_int(12)) & 63)))
		if rt.is_true(rt.greater_equal(rt.post_inc(var_i), var_count_mutated)) {
			break
		}
		var_output = rt.concat(var_output, this.itoa64.array_get(rt.new_int(rt.shift_right(var_value,
			rt.new_int(18)) & 63)))
		if !(rt.is_true(rt.less(var_i, var_count_mutated))) {
			break
		}
	}
	return var_output.clone()
}

fn (mut this Class_PasswordHash) gensalt_private(var_input rt.PhpVal) rt.PhpVal {
	mut var_output := rt.new_string('$P$')
	var_output = rt.concat(var_output, this.itoa64.array_get(rt.call_function('min', [
		rt.add(this.iteration_count_log2, rt.new_int(5)),
		rt.new_int(30),
	])))
	var_output = rt.concat(var_output, this.encode64(var_input.clone(), rt.new_int(6)))
	return var_output.clone()
}

fn (mut this Class_PasswordHash) crypt_private(var_password rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_output := rt.new_string('*0')
	if rt.is_true(rt.identical(rt.call_function('substr', [var_setting.clone(),
		rt.new_int(0), rt.new_int(2)]), var_output))
	{
		var_output = rt.new_string('*1')
	}
	mut var_id := rt.call_function('substr', [var_setting.clone(),
		rt.new_int(0), rt.new_int(3)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_id, rt.new_string('$P$')))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_id, rt.new_string('$H$'))))) {
		return var_output.clone()
	}
	mut var_count_log2 := rt.call_function('strpos', [rt.new_string(this.itoa64),
		var_setting.array_get(rt.new_int(3))])
	if rt.is_true(rt.less(var_count_log2, rt.new_int(7)))
		|| rt.is_true(rt.greater(var_count_log2, rt.new_int(30))) {
		return var_output.clone()
	}
	mut var_count := rt.new_int(rt.shift_left(rt.new_int(1), var_count_log2))
	mut var_salt := rt.call_function('substr', [var_setting.clone(),
		rt.new_int(4), rt.new_int(8)])
	if rt.is_true(rt.new_bool(var_salt.clone().to_string().len != 8)) {
		return var_output.clone()
	}
	mut var_hash := rt.new_string(md5.hexhash(var_salt.str() + var_password.str()))
	for {
		var_hash = rt.new_string(md5.hexhash(var_hash.str() + var_password.str()))
		if !(rt.is_true(rt.pre_dec(var_count))) {
			break
		}
	}
	var_output = rt.call_function('substr', [var_setting.clone(),
		rt.new_int(0), rt.new_int(12)])
	var_output = rt.concat(var_output, this.encode64(var_hash.clone(), rt.new_int(16)))
	return var_output.clone()
}

fn (mut this Class_PasswordHash) gensalt_blowfish(var_input rt.PhpVal) rt.PhpVal {
	mut var_itoa64 :=
		rt.new_string('./ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789')
	mut var_output := rt.new_string('$2a$')
	var_output = rt.concat(var_output, rt.call_function('chr', [
		rt.new_int((rt.add(rt.call_function('ord', [rt.new_string('0')]), rt.div(this.iteration_count_log2,
			rt.new_int(10)))).to_i64()),
	]))
	var_output = rt.concat(var_output, rt.call_function('chr', [
		rt.add(rt.call_function('ord', [rt.new_string('0')]), rt.mod_(this.iteration_count_log2,
			rt.new_int(10))),
	]))
	var_output = rt.concat(var_output, rt.new_string('$'))
	mut var_i := rt.new_int(0)
	for {
		mut var_c1 := rt.call_function('ord', [var_input.array_get(rt.post_inc(var_i))])
		var_output = rt.concat(var_output, var_itoa64.array_get(rt.new_int(rt.shift_right(var_c1,
			rt.new_int(2)))))
		var_c1 = rt.new_int(rt.bitwise_and(var_c1, rt.new_int(3)) << 4)
		if rt.is_true(rt.greater_equal(var_i, rt.new_int(16))) {
			var_output = rt.concat(var_output, var_itoa64.array_get(var_c1))
			break
		}
		mut var_c2 := rt.call_function('ord', [var_input.array_get(rt.post_inc(var_i))])
		rt.new_null()
		var_output = rt.concat(var_output, var_itoa64.array_get(var_c1))
		var_c1 = rt.new_int(rt.bitwise_and(var_c2, rt.new_int(15)) << 2)
		var_c2 = rt.call_function('ord', [var_input.array_get(rt.post_inc(var_i))])
		rt.new_null()
		var_output = rt.concat(var_output, var_itoa64.array_get(var_c1))
		var_output = rt.concat(var_output, var_itoa64.array_get(rt.new_int(rt.bitwise_and(var_c2,
			rt.new_int(63)))))
		if !(rt.is_true(rt.new_int(1))) {
			break
		}
	}
	return var_output.clone()
}

fn (mut this Class_PasswordHash) hashpassword(var_password rt.PhpVal) rt.PhpVal {
	if var_password.clone().to_string().len > 4096 {
		return rt.new_string('*')
	}
	mut var_random := rt.new_string('')
	if rt.is_true(rt.identical(rt.get_constant('CRYPT_BLOWFISH'), rt.new_int(1)))
		&& rt.is_true(rt.new_bool(!(rt.is_true(this.portable_hashes)))) {
		var_random = this.get_random_bytes(rt.new_int(16))
		mut var_hash := rt.call_function('crypt', [var_password.clone(),
			this.gensalt_blowfish(var_random.clone())])
		if var_hash.clone().to_string().len == 60 {
			return var_hash.clone()
		}
	}
	if var_random.clone().to_string().len < 6 {
		var_random = this.get_random_bytes(rt.new_int(6))
	}
	var_hash = this.crypt_private(var_password.clone(), this.gensalt_private(var_random.clone()))
	if var_hash.clone().to_string().len == 34 {
		return var_hash.clone()
	}
	return rt.new_string('*')
}

fn (mut this Class_PasswordHash) checkpassword(var_password rt.PhpVal, var_stored_hash rt.PhpVal) bool {
	if var_password.clone().to_string().len > 4096 {
		return false
	}
	mut var_hash := this.crypt_private(var_password.clone(), var_stored_hash.clone())
	if rt.is_true(rt.identical(var_hash.array_get(rt.new_int(0)), rt.new_string('*'))) {
		var_hash = rt.call_function('crypt', [var_password.clone(),
			var_stored_hash.clone()])
	}
	return (rt.identical(var_hash, var_stored_hash)).to_bool()
}

fn create_passwordhash(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_PasswordHash {
	mut obj := &Class_PasswordHash{
		PhpObjectBase:        rt.PhpObjectBase{}
		itoa64:               ''
		iteration_count_log2: rt.new_null()
		portable_hashes:      rt.new_null()
		random_state:         rt.new_null()
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
		else {
			return none
		}
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
		'itoa64' {
			this.itoa64 = val.str()
			return true
		}
		'iteration_count_log2' {
			this.iteration_count_log2 = val
			return true
		}
		'portable_hashes' {
			this.portable_hashes = val
			return true
		}
		'random_state' {
			this.random_state = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

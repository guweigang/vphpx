module rt

// echo_val 输出 PhpVal 的字符串形式到标准输出 (echo 语句)
pub fn echo_val(v PhpVal) {
	ctx_ptr := C.php2v_get_current_ctx()
	if ctx_ptr != 0 {
		mut ctx := &RequestContext(ctx_ptr)
		ctx.output_buf += v.to_string()
		return
	}
	print(v.to_string())
}

pub fn print_val(v PhpVal) PhpVal {
	ctx_ptr := C.php2v_get_current_ctx()
	if ctx_ptr != 0 {
		mut ctx := &RequestContext(ctx_ptr)
		ctx.output_buf += v.to_string()
		return new_int(1)
	}
	print(v.to_string())
	return new_int(1)
}

pub fn print_str(s string) {
	ctx_ptr := C.php2v_get_current_ctx()
	if ctx_ptr != 0 {
		mut ctx := &RequestContext(ctx_ptr)
		ctx.output_buf += s
		return
	}
	print(s)
}

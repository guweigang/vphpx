module rt

fn C.php2v_append_output(str &char, len usize)

// echo_val 输出 PhpVal 的字符串形式到标准输出 (echo 语句)
pub fn echo_val(v PhpVal) {
	ctx_ptr := C.php2v_get_current_ctx()
	if ctx_ptr != 0 {
		str_val := v.to_string()
		unsafe {
			C.php2v_append_output(&char(str_val.str), usize(str_val.len))
		}
		return
	}
	print(v.to_string())
}

pub fn print_val(v PhpVal) PhpVal {
	ctx_ptr := C.php2v_get_current_ctx()
	if ctx_ptr != 0 {
		str_val := v.to_string()
		unsafe {
			C.php2v_append_output(&char(str_val.str), usize(str_val.len))
		}
		return new_int(1)
	}
	print(v.to_string())
	return new_int(1)
}

pub fn print_str(s string) {
	ctx_ptr := C.php2v_get_current_ctx()
	if ctx_ptr != 0 {
		unsafe {
			C.php2v_append_output(&char(s.str), usize(s.len))
		}
		return
	}
	print(s)
}

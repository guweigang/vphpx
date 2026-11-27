module zend

pub fn new_stream_context(options voidptr, result voidptr) bool {
	return unsafe { C.vphp_new_stream_context(&C.zval(options), &C.zval(result)) }
}

pub fn open_stream(path string, mode string, context voidptr, report_errors bool, result voidptr) bool {
	return unsafe {
		C.vphp_open_stream(&char(path.str), usize(path.len), &char(mode.str), usize(mode.len),
			&C.zval(context), report_errors, &C.zval(result))
	}
}

pub fn is_stream_resource(value voidptr) bool {
	return unsafe { C.vphp_is_stream_resource(&C.zval(value)) }
}

pub fn stream_wrapper_data(value voidptr, result voidptr) bool {
	return unsafe { C.vphp_stream_wrapper_data(&C.zval(value), &C.zval(result)) }
}

pub fn stream_read_checked(value voidptr, length i64, result voidptr) bool {
	return unsafe { C.vphp_stream_read_checked(&C.zval(value), length, &C.zval(result)) }
}

pub fn stream_read_complete_line(value voidptr, max_bytes int, result voidptr) bool {
	return unsafe { C.vphp_stream_read_complete_line(&C.zval(value), usize(max_bytes), &C.zval(result)) }
}

pub fn stream_read_line_fragment(value voidptr, max_bytes int, result voidptr) bool {
	return unsafe { C.vphp_stream_read_line_fragment(&C.zval(value), usize(max_bytes), &C.zval(result)) }
}

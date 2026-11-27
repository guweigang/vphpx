module execute

import vphp.zend
import vphp.zval

pub fn (handle Handle) num_args() int {
	return zend.execute_num_args_ptr(handle.raw_ptr())
}

pub fn (handle Handle) arg_ptr(index int) voidptr {
	return zend.execute_arg_ptr(handle.raw_ptr(), index)
}

pub fn (handle Handle) arg_handle(index int) zval.Handle {
	return zval.Handle.from_ptr(handle.arg_ptr(index))
}

pub fn (handle Handle) read_arg_default(index int, result zval.Handle) bool {
	return zend.execute_read_arg_default(handle.raw_ptr(), index, result.raw_ptr())
}

module zend

pub type GeneratorResume = fn (voidptr, &C.zval, &C.zval, &C.zval, i32, &C.zval)

pub type GeneratorClose = fn (voidptr, &C.zval)

fn C.vphp_init_generator_system(module_number int)
fn C.vphp_create_generator(result &C.zval, capture &C.zval, state voidptr, resume GeneratorResume, close GeneratorClose, release fn (voidptr), by_reference bool, release_capture_after_start bool) bool

pub fn create_generator(result voidptr, capture voidptr, state voidptr, resume GeneratorResume, close GeneratorClose, release fn (voidptr), by_reference bool, release_capture_after_start bool) bool {
	return unsafe {
		C.vphp_create_generator(&C.zval(result), &C.zval(capture), state, resume, close,
			release, by_reference, release_capture_after_start)
	}
}

module zend

pub type ClassPropertyHandler = fn (voidptr, &char, int, &C.zval)
pub type ClassSyncHandler = fn (voidptr, &C.zval)
pub type ClassAllocateHandler = fn () voidptr
pub type ClassReleaseHandler = fn (voidptr)

@[params]
pub struct TypedClassHandlersConfig {
pub:
	prop_handler  ClassPropertyHandler
	write_handler ClassPropertyHandler
	sync_handler  ClassSyncHandler
	new_raw       ClassAllocateHandler
	cleanup_raw   ClassReleaseHandler
	free_raw      ClassReleaseHandler
}

@[params]
pub struct ClassHandlersConfig {
pub:
	prop_handler  voidptr
	write_handler voidptr
	sync_handler  voidptr
	new_raw       voidptr
	cleanup_raw   voidptr
	free_raw      voidptr
}

pub fn new_class_handlers(config ClassHandlersConfig) voidptr {
	return new_typed_class_handlers(
		prop_handler:  ClassPropertyHandler(config.prop_handler)
		write_handler: ClassPropertyHandler(config.write_handler)
		sync_handler:  ClassSyncHandler(config.sync_handler)
		new_raw:       ClassAllocateHandler(config.new_raw)
		cleanup_raw:   ClassReleaseHandler(config.cleanup_raw)
		free_raw:      ClassReleaseHandler(config.free_raw)
	)
}

pub fn new_typed_class_handlers(config TypedClassHandlersConfig) voidptr {
	return unsafe {
		&C.vphp_class_handlers{
			prop_handler:  config.prop_handler
			write_handler: config.write_handler
			sync_handler:  config.sync_handler
			new_raw:       config.new_raw
			cleanup_raw:   config.cleanup_raw
			free_raw:      config.free_raw
		}
	}
}

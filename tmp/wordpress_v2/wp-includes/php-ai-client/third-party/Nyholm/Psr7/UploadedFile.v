import rt

pub fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile.errors() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: rt.get_constant('UPLOAD_ERR_OK'), val: 1 },
		rt.ArrayItem{ key: rt.get_constant('UPLOAD_ERR_INI_SIZE'), val: 1 },
		rt.ArrayItem{ key: rt.get_constant('UPLOAD_ERR_FORM_SIZE'), val: 1 },
		rt.ArrayItem{ key: rt.get_constant('UPLOAD_ERR_PARTIAL'), val: 1 },
		rt.ArrayItem{ key: rt.get_constant('UPLOAD_ERR_NO_FILE'), val: 1 },
		rt.ArrayItem{ key: rt.get_constant('UPLOAD_ERR_NO_TMP_DIR'), val: 1 },
		rt.ArrayItem{ key: rt.get_constant('UPLOAD_ERR_CANT_WRITE'), val: 1 },
		rt.ArrayItem{ key: rt.get_constant('UPLOAD_ERR_EXTENSION'), val: 1 },
	])
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile {
	rt.PhpObjectBase
pub mut:
	clientFilename  rt.PhpVal = rt.new_null()
	clientMediaType rt.PhpVal = rt.new_null()
	error           rt.PhpVal = rt.new_null()
	file            rt.PhpVal = rt.new_null()
	moved           rt.PhpVal = rt.new_bool(false)
	size            rt.PhpVal = rt.new_null()
	stream          rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) construct(var_streamOrFile rt.PhpVal, var_size rt.PhpVal, var_errorStatus rt.PhpVal, var_clientFilename rt.PhpVal, var_clientMediaType rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_errorStatus.clone().is_long())))
		|| !(Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile.errors().array_isset(var_errorStatus)) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Upload file error status must be an integer value and one of the "UPLOAD_ERR_*" constants'))))
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_size.clone().is_long()))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Upload file size must be an integer'))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_clientFilename))))
		&& !(var_clientFilename.clone().is_string()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Upload file client filename must be a string or null'))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_clientMediaType))))
		&& !(var_clientMediaType.clone().is_string()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Upload file client media type must be a string or null'))))
	}
	this.error = var_errorStatus.clone()
	this.size = var_size.clone()
	this.clientFilename = var_clientFilename.clone()
	this.clientMediaType = var_clientMediaType.clone()
	if rt.is_true(rt.identical(rt.get_constant('UPLOAD_ERR_OK'), this.error)) {
		if var_streamOrFile.clone().is_string()
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_streamOrFile)))) {
			this.file = var_streamOrFile.clone()
		} else if rt.is_true(rt.call_function('is_resource', [
			var_streamOrFile.clone()]))
		{
			mut iife_temp_0 := Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{}
			mut iife_result_0 := iife_temp_0.create(var_streamOrFile.clone())
			this.stream = iife_result_0
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_streamOrFile,
			'WordPress_AiClientDependencies_Psr_Http_Message_StreamInterface')))
		{
			this.stream = var_streamOrFile.clone()
		} else {
			rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
				[]string{},
				create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Invalid stream or file provided for UploadedFile'))))
		}
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) validateactive() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('UPLOAD_ERR_OK'), this.error)))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.new_string('Cannot retrieve stream due to upload error'))))
	}
	if rt.is_true(this.moved) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.new_string('Cannot retrieve stream after it has already been moved'))))
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) getstream() rt.PhpVal {
	this.validateactive()
	if rt.is_true(rt.new_bool(rt.instance_of(this.stream,
		'WordPress_AiClientDependencies_Psr_Http_Message_StreamInterface')))
	{
		return this.stream
	}
	mut var_resource := rt.call_function('fopen', [this.file, rt.new_string('r')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_resource)) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException',
			[]string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.call_function('sprintf', [
			rt.new_string('The file "%s" cannot be opened: %s'),
			this.file,
			if !(rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message'))).is_null() {
				rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message'))
			} else {
				rt.new_string('')
			},
		]))))
	}
	mut iife_temp_1 := Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{}
	mut iife_result_1 := iife_temp_1.create(var_resource.clone())
	return iife_result_1
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) moveto(var_targetPath rt.PhpVal) {
	this.validateactive()
	if !(var_targetPath.clone().is_string())
		|| rt.is_true(rt.identical(rt.new_string(''), var_targetPath)) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Invalid path provided for move operation; must be a non-empty string'))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.file)))) {
		this.moved = if rt.is_true(rt.identical(rt.new_string('cli'), rt.get_constant('PHP_SAPI'))) { rt.call_function('rename', [
				this.file,
				var_targetPath.clone(),
			]) } else { rt.call_function('move_uploaded_file', [this.file, var_targetPath.clone()]) }
		if rt.is_true(rt.identical(rt.new_bool(false), this.moved)) {
			rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException',
				[]string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.call_function('sprintf', [
				rt.new_string('Uploaded file could not be moved to "%s": %s'),
				var_targetPath.clone(),
				if !(rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message'))).is_null() {
					rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message'))
				} else {
					rt.new_string('')
				},
			]))))
		}
	} else {
		mut var_stream := this.getstream()
		if rt.is_true(rt.call_method(var_stream, 'isSeekable', []rt.PhpVal{})) {
			rt.call_method(var_stream, 'rewind', []rt.PhpVal{})
		}
		mut var_resource := rt.call_function('fopen', [var_targetPath.clone(),
			rt.new_string('w')])
		if rt.is_true(rt.identical(rt.new_bool(false), var_resource)) {
			rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException',
				[]string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.call_function('sprintf', [
				rt.new_string('The file "%s" cannot be opened: %s'),
				var_targetPath.clone(),
				if !(rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message'))).is_null() {
					rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message'))
				} else {
					rt.new_string('')
				},
			]))))
		}
		mut iife_temp_2 := Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{}
		mut iife_result_2 := iife_temp_2.create(var_resource.clone())
		mut var_dest := iife_result_2
		for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_stream, 'eof', []rt.PhpVal{}))))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_dest, 'write', [
				rt.call_method(var_stream, 'read', [rt.new_int(1048576)]),
			])))))
			{
				break
			}
		}
		this.moved = rt.new_bool(true)
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) getsize() i64 {
	return (this.size).to_i64()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) geterror() i64 {
	return (this.error).to_i64()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) getclientfilename() string {
	return (this.clientFilename).str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) getclientmediatype() string {
	return (this.clientMediaType).str()
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_uploadedfile(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile{
		PhpObjectBase:   rt.PhpObjectBase{}
		clientFilename:  rt.new_null()
		clientMediaType: rt.new_null()
		error:           rt.new_null()
		file:            rt.new_null()
		moved:           rt.new_bool(false)
		size:            rt.new_null()
		stream:          rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4)
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_stream(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		'validateActive' {
			this.validateactive()
			return rt.new_null()
		}
		'getStream' {
			return this.getstream()
		}
		'moveTo' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.moveto(dispatch_arg_0)
			return rt.new_null()
		}
		'getSize' {
			return rt.new_int(this.getsize())
		}
		'getError' {
			return rt.new_int(this.geterror())
		}
		'getClientFilename' {
			return rt.new_string(this.getclientfilename())
		}
		'getClientMediaType' {
			return rt.new_string(this.getclientmediatype())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'clientFilename' { return this.clientFilename }
		'clientMediaType' { return this.clientMediaType }
		'error' { return this.error }
		'file' { return this.file }
		'moved' { return this.moved }
		'size' { return this.size }
		'stream' { return this.stream }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'clientFilename' {
			this.clientFilename = val
			return true
		}
		'clientMediaType' {
			this.clientMediaType = val
			return true
		}
		'error' {
			this.error = val
			return true
		}
		'file' {
			this.file = val
			return true
		}
		'moved' {
			this.moved = val
			return true
		}
		'size' {
			this.size = val
			return true
		}
		'stream' {
			this.stream = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

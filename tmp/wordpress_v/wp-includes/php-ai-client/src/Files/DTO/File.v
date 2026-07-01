import rt

pub fn Class_WordPress_AiClient_Files_DTO_File.key_file_type() string {
	return 'fileType'
}
pub fn Class_WordPress_AiClient_Files_DTO_File.key_mime_type() string {
	return 'mimeType'
}
pub fn Class_WordPress_AiClient_Files_DTO_File.key_url() string {
	return 'url'
}
pub fn Class_WordPress_AiClient_Files_DTO_File.key_base64_data() string {
	return 'base64Data'
}
struct Class_WordPress_AiClient_Files_DTO_File {
	rt.PhpObjectBase
pub mut:
		mimeType rt.PhpVal = rt.new_null()
		fileType rt.PhpVal = rt.new_null()
		url string
		base64Data rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) construct(file string, mut var_mimeType Class_WordPress_AiClient_Files_DTO_?string)  {
	mut var_mimeType_mutated := var_mimeType
	this.detectandprocessfile(file, mut var_mimeType_mutated)
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) detectandprocessfile(file string, mut var_providedMimeType Class_WordPress_AiClient_Files_DTO_?string)  {
	mut var_matches := rt.new_null()
	if this.isurl(file) {
		this.fileType = fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Files_Enums_FileTypeEnum{}; return temp.remote() }()
		this.url = file
		this.mimeType = this.determinemimetype(mut var_providedMimeType, mut rt.cast_object_ptr[Class_WordPress_AiClient_Files_DTO_?string](rt.new_null()), mut file)
		return rt.new_null()
	}
	mut var_dataUriPattern := rt.new_string('/^data:(?:([a-zA-Z0-9][a-zA-Z0-9!#$&\\-\\^_+.]*\\/[a-zA-Z0-9][a-zA-Z0-9!#$&\\-\\^_+.]*' + '(?:;[a-zA-Z0-9\\-]+=[a-zA-Z0-9\\-]+)*)?;)?base64,([A-Za-z0-9+\\/]*={0,2})$/')
	if rt.is_true(rt.call_function('preg_match', [var_dataUriPattern.dup(), rt.new_string(file), var_matches.dup()])) {
		this.fileType = fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Files_Enums_FileTypeEnum{}; return temp.inline() }()
		this.base64Data = var_matches.array_get(2)
		mut var_extractedMimeType := if !rt.is_true(var_matches.array_get(1)) { rt.new_null() } else { var_matches.array_get(1) }
		this.mimeType = this.determinemimetype(mut var_providedMimeType, mut rt.cast_object_ptr[Class_WordPress_AiClient_Files_DTO_?string](var_extractedMimeType), mut rt.cast_object_ptr[Class_WordPress_AiClient_Files_DTO_?string](rt.new_null()))
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [rt.new_string(file)])) && rt.is_true(rt.call_function('is_file', [rt.new_string(file)])))) {
		this.fileType = fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Files_Enums_FileTypeEnum{}; return temp.inline() }()
		this.base64Data = this.convertfiletobase64(file)
		this.mimeType = this.determinemimetype(mut var_providedMimeType, mut rt.cast_object_ptr[Class_WordPress_AiClient_Files_DTO_?string](rt.new_null()), mut file)
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[A-Za-z0-9+\\/]*={0,2}$/'), rt.new_string(file)])) {
		if rt.is_true(rt.identical(var_providedMimeType, rt.new_null())) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('MIME type is required when providing plain base64 data without data URI format.'))))
		}
		this.fileType = fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Files_Enums_FileTypeEnum{}; return temp.inline() }()
		this.base64Data = rt.new_string(file).dup()
		this.mimeType = create_wordpress_aiclient_files_valueobjects_mimetype(var_providedMimeType.dup())
		return rt.new_null()
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Invalid file provided. Expected URL, base64 data, or valid local file path.'))))
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) isurl(string string) bool {
	return rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^https?:\\/\\//i'), rt.new_string(string)]))
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) convertfiletobase64(filePath string) string {
	mut var_fileContent := rt.call_function('file_get_contents', [rt.new_string(filePath)])
	if rt.is_true(rt.identical(var_fileContent, rt.new_bool(false))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [rt.new_string('Unable to read file: %s'), rt.new_string(filePath)]))))
	}
	return (rt.call_function('base64_encode', [var_fileContent.dup()])).str()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) getfiletype() rt.PhpVal {
	return this.fileType
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) isinline() bool {
	return (rt.call_method(this.fileType, 'isInline', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) isremote() bool {
	return (rt.call_method(this.fileType, 'isRemote', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) geturl() string {
	return this.url
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) getbase64data() string {
	return (this.base64Data).str()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) getdatauri() string {
	if rt.is_true(rt.identical(this.base64Data, rt.new_null())) {
		return (rt.new_null()).str()
	}
	return (rt.call_function('sprintf', [rt.new_string('data:%s;base64,%s'), this.getmimetype(), this.base64Data])).str()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) getmimetype() string {
	return (// unsupported expression: Expr_Cast_String).str()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) getmimetypeobject() rt.PhpVal {
	return this.mimeType
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) isvideo() bool {
	return (rt.call_method(this.mimeType, 'isVideo', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) isimage() bool {
	return (rt.call_method(this.mimeType, 'isImage', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) isaudio() bool {
	return (rt.call_method(this.mimeType, 'isAudio', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) istext() bool {
	return (rt.call_method(this.mimeType, 'isText', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) isdocument() bool {
	return (rt.call_method(this.mimeType, 'isDocument', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) ismimetype(type string) bool {
	return (rt.call_method(this.mimeType, 'isType', [rt.new_string(type)])).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) determinemimetype(mut var_providedMimeType Class_WordPress_AiClient_Files_DTO_?string, mut var_extractedMimeType Class_WordPress_AiClient_Files_DTO_?string, mut var_pathOrUrl Class_WordPress_AiClient_Files_DTO_?string) rt.PhpVal {
	mut var_extractedMimeType_mutated := var_extractedMimeType
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_wordpress_aiclient_files_valueobjects_mimetype(var_providedMimeType.dup())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_wordpress_aiclient_files_valueobjects_mimetype(var_extractedMimeType_mutated.dup())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_parsedUrl := rt.call_function('parse_url', [var_pathOrUrl])
		mut var_path := if !(var_parsedUrl.array_get('path')).is_null() { var_parsedUrl.array_get('path') } else { var_pathOrUrl }
		mut var_cleanPath := rt.call_function('strtok', [var_path.dup(), rt.new_string('?#')])
		if rt.is_true(rt.identical(var_cleanPath, rt.new_bool(false))) {
			var_cleanPath = var_path.dup()
		}
		mut var_extension := rt.call_function('pathinfo', [var_cleanPath.dup(), rt.get_constant('PATHINFO_EXTENSION')])
		if !(!rt.is_true(var_extension)) {
			return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Files_ValueObjects_MimeType{}; return temp.fromextension(arg_0) }(var_extension.dup())
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'WordPress_AiClient_Common_Exception_InvalidArgumentException') {
				mut var_e := var_e_1.dup()
				var_e = rt.new_null()
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Unable to determine MIME type. Please provide it explicitly.'))))
	return rt.new_null()
}

fn Class_WordPress_AiClient_Files_DTO_File.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'oneOf', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_file_type(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'const', val: Class_WordPress_AiClient_Files_Enums_FileTypeEnum.remote() }, rt.ArrayItem{ key: 'description', val: 'The file type.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_mime_type(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The MIME type of the file.' }, rt.ArrayItem{ key: 'pattern', val: '^[a-zA-Z0-9][a-zA-Z0-9!#$&\\-\\^_+.]*\\/[a-zA-Z0-9]' + '[a-zA-Z0-9!#$&\\-\\^_+.]*$' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_url(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'description', val: 'The URL to the remote file.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_file_type() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_mime_type() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_url() }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_file_type(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'const', val: Class_WordPress_AiClient_Files_Enums_FileTypeEnum.inline() }, rt.ArrayItem{ key: 'description', val: 'The file type.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_mime_type(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The MIME type of the file.' }, rt.ArrayItem{ key: 'pattern', val: '^[a-zA-Z0-9][a-zA-Z0-9!#$&\\-\\^_+.]*\\/[a-zA-Z0-9]' + '[a-zA-Z0-9!#$&\\-\\^_+.]*$' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_base64_data(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The base64-encoded file data.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_file_type() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_mime_type() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_base64_data() }]) }]) }]) }])
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) toarray() rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_file_type(), val: rt.get_property(this.fileType, 'value') }, rt.ArrayItem{ key: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_mime_type(), val: this.getmimetype() }])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_url(), this.url)
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.fileType, 'isRemote', []rt.PhpVal{}))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_data.array_set(Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_base64_data(), this.base64Data)
	} else {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.new_string('File requires either url or base64Data. This should not be a possible condition.'))))
	}
	return var_data.dup()
}

fn Class_WordPress_AiClient_Files_DTO_File.fromarray(mut var_array Class_WordPress_AiClient_Files_DTO_array) rt.PhpVal {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Files_DTO_File{}; return temp.validatefromarraydata(arg_0, arg_1) }(rt.new_object('WordPress_AiClient_Files_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_file_type() }]))
	mut var_mimeType := if !(var_array.array_get(Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_mime_type())).is_null() { var_array.array_get(Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_mime_type()) } else { rt.new_null() }
	if var_array.array_isset(Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_url()) {
		return create_wordpress_aiclient_files_dto_self(var_array.array_get(Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_url()), var_mimeType.dup())
	} else if var_array.array_isset(Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_base64_data()) {
		return create_wordpress_aiclient_files_dto_self(var_array.array_get(Class_WordPress_AiClient_Files_DTO_WordPress_AiClient_Files_DTO_File.key_base64_data()), var_mimeType.dup())
	} else {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('File requires either url or base64Data.'))))
	}
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) magic_clone()  {
	this.mimeType = // unsupported expression: Expr_Clone
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Files_Enums_FileTypeEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Files_ValueObjects_MimeType {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Files_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_files_dto_file(file string, arg_1 rt.PhpVal) &Class_WordPress_AiClient_Files_DTO_File {
	mut obj := &Class_WordPress_AiClient_Files_DTO_File{
		PhpObjectBase: rt.PhpObjectBase{}
		mimeType: rt.new_null()
		fileType: rt.new_null()
		url: ''
		base64Data: rt.new_null()
	}
	obj.construct(file, arg_1)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject() &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_files_enums_filetypeenum() &Class_WordPress_AiClient_Files_Enums_FileTypeEnum {
	mut obj := &Class_WordPress_AiClient_Files_Enums_FileTypeEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception() &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_files_valueobjects_mimetype() &Class_WordPress_AiClient_Files_ValueObjects_MimeType {
	mut obj := &Class_WordPress_AiClient_Files_ValueObjects_MimeType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_runtimeexception() &Class_WordPress_AiClient_Common_Exception_RuntimeException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_files_dto_self() &Class_WordPress_AiClient_Files_DTO_self {
	mut obj := &Class_WordPress_AiClient_Files_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Files_DTO_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'detectAndProcessFile' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Files_DTO_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			this.detectandprocessfile(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'isUrl' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.isurl(dispatch_arg_0))
		}
		'convertFileToBase64' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.convertfiletobase64(dispatch_arg_0))
		}
		'getFileType' {
			return this.getfiletype()
		}
		'isInline' {
			return rt.new_bool(this.isinline())
		}
		'isRemote' {
			return rt.new_bool(this.isremote())
		}
		'getUrl' {
			return rt.new_string(this.geturl())
		}
		'getBase64Data' {
			return rt.new_string(this.getbase64data())
		}
		'getDataUri' {
			return rt.new_string(this.getdatauri())
		}
		'getMimeType' {
			return rt.new_string(this.getmimetype())
		}
		'getMimeTypeObject' {
			return this.getmimetypeobject()
		}
		'isVideo' {
			return rt.new_bool(this.isvideo())
		}
		'isImage' {
			return rt.new_bool(this.isimage())
		}
		'isAudio' {
			return rt.new_bool(this.isaudio())
		}
		'isText' {
			return rt.new_bool(this.istext())
		}
		'isDocument' {
			return rt.new_bool(this.isdocument())
		}
		'isMimeType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.ismimetype(dispatch_arg_0))
		}
		'determineMimeType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Files_DTO_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Files_DTO_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Files_DTO_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.determinemimetype(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Files_DTO_File.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Files_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Files_DTO_File.fromarray(mut dispatch_arg_0)
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Files_DTO_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'mimeType' { return this.mimeType }
		'fileType' { return this.fileType }
		'url' { return rt.new_string(this.url) }
		'base64Data' { return this.base64Data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'mimeType' { this.mimeType = val; return true }
		'fileType' { this.fileType = val; return true }
		'url' { this.url = (val).str(); return true }
		'base64Data' { this.base64Data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Files_Enums_FileTypeEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Files_Enums_FileTypeEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Files_Enums_FileTypeEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Files_ValueObjects_MimeType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Files_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Files_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Files_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_php_ai_client_src_files_dto_file_php() {
	// unsupported statement: Stmt_Declare
}

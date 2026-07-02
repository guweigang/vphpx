import rt

struct Class_WordPress_AiClient_Files_ValueObjects_MimeType {
	rt.PhpObjectBase
pub mut:
	value string
}

fn init_static_wordpress_aiclient_files_valueobjects_mimetype() {
	rt.init_static_prop('WordPress_AiClient_Files_ValueObjects_MimeType', 'extensionMap', rt.create_array([
		rt.ArrayItem{ key: 'txt', val: 'text/plain' },
		rt.ArrayItem{ key: 'html', val: 'text/html' },
		rt.ArrayItem{ key: 'htm', val: 'text/html' },
		rt.ArrayItem{ key: 'css', val: 'text/css' },
		rt.ArrayItem{ key: 'js', val: 'application/javascript' },
		rt.ArrayItem{ key: 'json', val: 'application/json' },
		rt.ArrayItem{ key: 'xml', val: 'application/xml' },
		rt.ArrayItem{ key: 'csv', val: 'text/csv' },
		rt.ArrayItem{ key: 'md', val: 'text/markdown' },
		rt.ArrayItem{ key: 'jpg', val: 'image/jpeg' },
		rt.ArrayItem{ key: 'jpeg', val: 'image/jpeg' },
		rt.ArrayItem{ key: 'png', val: 'image/png' },
		rt.ArrayItem{ key: 'gif', val: 'image/gif' },
		rt.ArrayItem{ key: 'bmp', val: 'image/bmp' },
		rt.ArrayItem{ key: 'webp', val: 'image/webp' },
		rt.ArrayItem{ key: 'svg', val: 'image/svg+xml' },
		rt.ArrayItem{ key: 'ico', val: 'image/x-icon' },
		rt.ArrayItem{ key: 'pdf', val: 'application/pdf' },
		rt.ArrayItem{ key: 'doc', val: 'application/msword' },
		rt.ArrayItem{
			key: 'docx'
			val: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
		},
		rt.ArrayItem{ key: 'xls', val: 'application/vnd.ms-excel' },
		rt.ArrayItem{
			key: 'xlsx'
			val: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
		},
		rt.ArrayItem{ key: 'ppt', val: 'application/vnd.ms-powerpoint' },
		rt.ArrayItem{
			key: 'pptx'
			val: 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
		},
		rt.ArrayItem{ key: 'odt', val: 'application/vnd.oasis.opendocument.text' },
		rt.ArrayItem{ key: 'ods', val: 'application/vnd.oasis.opendocument.spreadsheet' },
		rt.ArrayItem{ key: 'zip', val: 'application/zip' },
		rt.ArrayItem{ key: 'tar', val: 'application/x-tar' },
		rt.ArrayItem{ key: 'gz', val: 'application/gzip' },
		rt.ArrayItem{ key: 'rar', val: 'application/x-rar-compressed' },
		rt.ArrayItem{ key: '7z', val: 'application/x-7z-compressed' },
		rt.ArrayItem{ key: 'mp3', val: 'audio/mpeg' },
		rt.ArrayItem{ key: 'wav', val: 'audio/wav' },
		rt.ArrayItem{ key: 'ogg', val: 'audio/ogg' },
		rt.ArrayItem{ key: 'flac', val: 'audio/flac' },
		rt.ArrayItem{ key: 'm4a', val: 'audio/m4a' },
		rt.ArrayItem{ key: 'aac', val: 'audio/aac' },
		rt.ArrayItem{ key: 'mp4', val: 'video/mp4' },
		rt.ArrayItem{ key: 'avi', val: 'video/x-msvideo' },
		rt.ArrayItem{ key: 'mov', val: 'video/quicktime' },
		rt.ArrayItem{ key: 'wmv', val: 'video/x-ms-wmv' },
		rt.ArrayItem{ key: 'flv', val: 'video/x-flv' },
		rt.ArrayItem{ key: 'webm', val: 'video/webm' },
		rt.ArrayItem{ key: 'mkv', val: 'video/x-matroska' },
		rt.ArrayItem{ key: 'ttf', val: 'font/ttf' },
		rt.ArrayItem{ key: 'otf', val: 'font/otf' },
		rt.ArrayItem{ key: 'woff', val: 'font/woff' },
		rt.ArrayItem{ key: 'woff2', val: 'font/woff2' },
		rt.ArrayItem{ key: 'php', val: 'application/x-httpd-php' },
		rt.ArrayItem{ key: 'sh', val: 'application/x-sh' },
		rt.ArrayItem{ key: 'exe', val: 'application/x-msdownload' },
	]))
	rt.init_static_prop('WordPress_AiClient_Files_ValueObjects_MimeType', 'documentTypes', rt.create_array([
		rt.ArrayItem{ key: none, val: 'application/pdf' },
		rt.ArrayItem{ key: none, val: 'application/msword' },
		rt.ArrayItem{
			key: none
			val: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
		},
		rt.ArrayItem{ key: none, val: 'application/vnd.ms-excel' },
		rt.ArrayItem{
			key: none
			val: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
		},
		rt.ArrayItem{ key: none, val: 'application/vnd.ms-powerpoint' },
		rt.ArrayItem{
			key: none
			val: 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
		},
		rt.ArrayItem{ key: none, val: 'application/vnd.oasis.opendocument.text' },
		rt.ArrayItem{ key: none, val: 'application/vnd.oasis.opendocument.spreadsheet' },
	]))
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) construct(value string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WordPress_AiClient_Files_ValueObjects_MimeType.isvalid(value))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('Invalid MIME type: %s'),
			rt.new_string(value),
		]))))
	}
	this.value = value.to_lower()
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) toextension() string {
	mut var_extension := rt.call_function('array_search', [rt.new_string(this.value),
		rt.get_static_prop('WordPress_AiClient_Files_ValueObjects_MimeType', 'extensionMap'),
		rt.new_bool(true)])
	if rt.is_true(rt.identical(var_extension, rt.new_bool(false))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('No known extension for MIME type: %s'),
			rt.new_string(this.value),
		]))))
	}
	return var_extension.str()
}

fn Class_WordPress_AiClient_Files_ValueObjects_MimeType.fromextension(extension string) rt.PhpVal {
	mut extension_mutated := extension
	extension_mutated = extension_mutated.to_lower()
	if !(rt.get_static_prop('WordPress_AiClient_Files_ValueObjects_MimeType', 'extensionMap').array_isset(rt.new_string(extension_mutated))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('Unknown file extension: %s'),
			rt.new_string(extension_mutated).clone(),
		]))))
	}
	return rt.new_object('WordPress_AiClient_Files_ValueObjects_self', []string{}, create_wordpress_aiclient_files_valueobjects_self(rt.get_static_prop('WordPress_AiClient_Files_ValueObjects_MimeType',
		'extensionMap').array_get(rt.new_string(extension_mutated))))
}

fn Class_WordPress_AiClient_Files_ValueObjects_MimeType.isvalid(mimeType string) bool {
	return (rt.call_function('preg_match', [
		rt.new_string('/^[a-zA-Z0-9][a-zA-Z0-9!#$&\\-\\^_+.]*\\/[a-zA-Z0-9][a-zA-Z0-9!#$&\\-\\^_+.]*$/'),
		rt.new_string(mimeType),
	])).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) istype(mimeType string) bool {
	return (rt.call_function('str_starts_with', [rt.new_string(this.value),
		rt.new_string(mimeType.to_lower() + '/')])).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) isimage() bool {
	return this.istype('image')
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) isaudio() bool {
	return this.istype('audio')
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) isvideo() bool {
	return this.istype('video')
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) istext() bool {
	return this.istype('text')
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) isdocument() bool {
	return (rt.call_function('in_array', [rt.new_string(this.value),
		rt.get_static_prop('WordPress_AiClient_Files_ValueObjects_MimeType', 'documentTypes'),
		rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) equals(var_other rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.instance_of(var_other,
		'WordPress_AiClient_Files_ValueObjects_self')))
	{
		return (rt.identical(this.value, rt.get_property(var_other, 'value'))).to_bool()
	}
	if rt.is_true(rt.new_bool(var_other.clone().is_string())) {
		return (rt.identical(this.value, rt.new_string(var_other.clone().to_string().to_lower()))).to_bool()
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
		[]string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [
		rt.new_string('Invalid MIME type comparison: %s'),
		rt.call_function('gettype', [var_other.clone()]),
	]))))
	return false
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) magic_tostring() string {
	return this.value
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Files_ValueObjects_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_files_valueobjects_mimetype(value string) &Class_WordPress_AiClient_Files_ValueObjects_MimeType {
	mut obj := &Class_WordPress_AiClient_Files_ValueObjects_MimeType{
		PhpObjectBase: rt.PhpObjectBase{}
		value:         ''
	}
	obj.construct(value)
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_files_valueobjects_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Files_ValueObjects_self {
	mut obj := &Class_WordPress_AiClient_Files_ValueObjects_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'toExtension' {
			return rt.new_string(this.toextension())
		}
		'fromExtension' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WordPress_AiClient_Files_ValueObjects_MimeType.fromextension(dispatch_arg_0)
		}
		'isValid' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WordPress_AiClient_Files_ValueObjects_MimeType.isvalid(dispatch_arg_0))
		}
		'isType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.istype(dispatch_arg_0))
		}
		'isImage' {
			return rt.new_bool(this.isimage())
		}
		'isAudio' {
			return rt.new_bool(this.isaudio())
		}
		'isVideo' {
			return rt.new_bool(this.isvideo())
		}
		'isText' {
			return rt.new_bool(this.istext())
		}
		'isDocument' {
			return rt.new_bool(this.isdocument())
		}
		'equals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.equals(dispatch_arg_0))
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Files_ValueObjects_MimeType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'value' { return rt.new_string(this.value) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'value' {
			this.value = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Files_ValueObjects_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

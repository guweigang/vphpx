import rt

struct Class_WordPress_AiClient_Files_ValueObjects_MimeType {
	rt.PhpObjectBase
pub mut:
		value string
		extensionMap rt.PhpVal = rt.new_array()
		documentTypes rt.PhpVal = rt.new_array()
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) construct(value string)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WordPress_AiClient_Files_ValueObjects_MimeType.isvalid(value))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Invalid MIME type: %s'), rt.new_string(value)]))))
	}
	this.value = value.to_lower()
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) toextension() string {
	mut var_extension := rt.call_function('array_search', [this.value, // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)])
	if rt.is_true(rt.identical(var_extension, rt.new_bool(false))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('No known extension for MIME type: %s'), this.value]))))
	}
	return (var_extension).str()
}

fn Class_WordPress_AiClient_Files_ValueObjects_MimeType.fromextension(extension string) rt.PhpVal {
	mut extension_mutated := extension
	extension_mutated = extension_mutated.to_lower()
	if !(// unsupported expression: Expr_StaticPropertyFetch.array_isset(rt.new_string(extension_mutated))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Unknown file extension: %s'), rt.new_string(extension_mutated).dup()]))))
	}
	return create_wordpress_aiclient_files_valueobjects_self(// unsupported expression: Expr_StaticPropertyFetch.array_get(extension_mutated))
}

fn Class_WordPress_AiClient_Files_ValueObjects_MimeType.isvalid(mimeType string) bool {
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) istype(mimeType string) bool {
	return (rt.call_function('str_starts_with', [this.value, mimeType.to_lower() + '/'])).to_bool()
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
	return (rt.call_function('in_array', [this.value, // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) equals(var_other rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.instance_of(var_other, 'WordPress_AiClient_Files_ValueObjects_self'))) {
		return (rt.identical(this.value, rt.get_property(var_other, 'value'))).to_bool()
	}
	if rt.is_true(rt.new_bool(var_other.dup().is_string())) {
		return (rt.identical(this.value, rt.new_string(var_other.dup().to_string().to_lower()))).to_bool()
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Invalid MIME type comparison: %s'), rt.call_function('gettype', [var_other.dup()])]))))
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
		value: ''
		extensionMap: rt.new_array()
		documentTypes: rt.new_array()
	}
	obj.construct(value)
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception() &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_files_valueobjects_self() &Class_WordPress_AiClient_Files_ValueObjects_self {
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
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Files_ValueObjects_MimeType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'value' { return rt.new_string(this.value) }
		'extensionMap' { return this.extensionMap }
		'documentTypes' { return this.documentTypes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Files_ValueObjects_MimeType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'value' { this.value = (val).str(); return true }
		'extensionMap' { this.extensionMap = val; return true }
		'documentTypes' { this.documentTypes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_includes_php_ai_client_src_files_valueobjects_mimetype_php() {
	// unsupported statement: Stmt_Declare
}

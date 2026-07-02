import rt

pub fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream.read_write_hash() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'read', val: rt.create_array([rt.ArrayItem{ key: 'r', val: true }, rt.ArrayItem{ key: 'w+', val: true }, rt.ArrayItem{ key: 'r+', val: true }, rt.ArrayItem{ key: 'x+', val: true }, rt.ArrayItem{ key: 'c+', val: true }, rt.ArrayItem{ key: 'rb', val: true }, rt.ArrayItem{ key: 'w+b', val: true }, rt.ArrayItem{ key: 'r+b', val: true }, rt.ArrayItem{ key: 'x+b', val: true }, rt.ArrayItem{ key: 'c+b', val: true }, rt.ArrayItem{ key: 'rt', val: true }, rt.ArrayItem{ key: 'w+t', val: true }, rt.ArrayItem{ key: 'r+t', val: true }, rt.ArrayItem{ key: 'x+t', val: true }, rt.ArrayItem{ key: 'c+t', val: true }, rt.ArrayItem{ key: 'a+', val: true }]) }, rt.ArrayItem{ key: 'write', val: rt.create_array([rt.ArrayItem{ key: 'w', val: true }, rt.ArrayItem{ key: 'w+', val: true }, rt.ArrayItem{ key: 'rw', val: true }, rt.ArrayItem{ key: 'r+', val: true }, rt.ArrayItem{ key: 'x+', val: true }, rt.ArrayItem{ key: 'c+', val: true }, rt.ArrayItem{ key: 'wb', val: true }, rt.ArrayItem{ key: 'w+b', val: true }, rt.ArrayItem{ key: 'r+b', val: true }, rt.ArrayItem{ key: 'x+b', val: true }, rt.ArrayItem{ key: 'c+b', val: true }, rt.ArrayItem{ key: 'w+t', val: true }, rt.ArrayItem{ key: 'r+t', val: true }, rt.ArrayItem{ key: 'x+t', val: true }, rt.ArrayItem{ key: 'c+t', val: true }, rt.ArrayItem{ key: 'a', val: true }, rt.ArrayItem{ key: 'a+', val: true }]) }])
}
struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	rt.PhpObjectBase
pub mut:
		stream rt.PhpVal = rt.new_null()
		seekable bool
		readable rt.PhpVal = rt.new_null()
		writable rt.PhpVal = rt.new_null()
		uri rt.PhpVal = rt.new_null()
		size rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) construct(var_body rt.PhpVal) {
	mut var_body_mutated := var_body
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [var_body_mutated.clone()]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('First argument to Stream::__construct() must be resource'))))
	}
	this.stream = var_body_mutated.clone()
	mut var_meta := rt.call_function('stream_get_meta_data', [this.stream])
	this.seekable = rt.is_true(var_meta.array_get(rt.new_string('seekable'))) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('fseek', [this.stream, rt.new_int(0), rt.get_constant('SEEK_CUR')])))
	this.readable = rt.new_bool(Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Stream.read_write_hash().array_get(rt.new_string('read')).array_isset(var_meta.array_get(rt.new_string('mode'))))
	this.writable = rt.new_bool(Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Stream.read_write_hash().array_get(rt.new_string('write')).array_isset(var_meta.array_get(rt.new_string('mode'))))
}

fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream.create(body string) rt.PhpVal {
	mut body_mutated := body
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_string(body_mutated), 'WordPress_AiClientDependencies_Psr_Http_Message_StreamInterface'))) {
		return rt.new_string(body_mutated)
	}
	if rt.is_true(rt.new_bool(rt.new_string(body_mutated).clone().is_string())) {
		if 200000 <= body_mutated.len {
		body_mutated = (Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream.openzvalstream(body_mutated)).str()
		} else {
			mut var_resource := rt.call_function('fopen', [rt.new_string('php://memory'), rt.new_string('r+')])
			rt.call_function('fwrite', [var_resource.clone(), rt.new_string(body_mutated).clone()])
			rt.call_function('fseek', [var_resource.clone(), rt.new_int(0)])
		body_mutated = (var_resource).str()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [rt.new_string(body_mutated).clone()]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('First argument to Stream::create() must be a string, resource or StreamInterface'))))
	}
	return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_self', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_self(rt.new_string(body_mutated).clone()))
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) magic_destruct() {
	this.close()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) close() {
	if !(this.stream).is_null() {
		if rt.is_true(rt.call_function('is_resource', [this.stream])) {
			rt.call_function('fclose', [this.stream])
		}
		this.detach()
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) detach() rt.PhpVal {
	if !(!(this.stream).is_null()) {
		return rt.new_null()
	}
	mut var_result := this.stream
	this.stream = rt.new_null()
	this.size = this.uri = rt.new_null()
	this.readable = this.writable = this.seekable = false
	return var_result.clone()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) geturi() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), this.uri)))) {
		this.uri = if !(this.getmetadata(rt.new_string('uri'))).is_null() { this.getmetadata(rt.new_string('uri')) } else { rt.new_bool(false) }
	}
	return this.uri
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) getsize() i64 {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.size)))) {
		return (this.size).to_i64()
	}
	if !(!(this.stream).is_null()) {
		return (rt.new_null()).to_i64()
	}
	mut var_uri := this.geturi()
	if rt.is_true(var_uri) {
		rt.call_function('clearstatcache', [rt.new_bool(true), var_uri.clone()])
	}
	mut var_stats := rt.call_function('fstat', [this.stream])
	if var_stats.array_isset(rt.new_string('size')) {
		this.size = var_stats.array_get(rt.new_string('size'))
		return (this.size).to_i64()
	}
	return (rt.new_null()).to_i64()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) tell() i64 {
	if !(!(this.stream).is_null()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.new_string('Stream is detached'))))
	}
	mut var_result := rt.call_function('ftell', [this.stream])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception('Unable to determine stream position: ' + (if !(rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message'))).is_null() { rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message')) } else { rt.new_string('') }).str())))
	}
	return (var_result).to_i64()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) eof() bool {
	return !(!(this.stream).is_null()) || rt.is_true(rt.call_function('feof', [this.stream]))
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) isseekable() bool {
	return this.seekable
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) seek(var_offset rt.PhpVal, var_whence rt.PhpVal) {
	if !(!(this.stream).is_null()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.new_string('Stream is detached'))))
	}
	if !(this.seekable) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.new_string('Stream is not seekable'))))
	}
	if rt.is_true(rt.identical(-1, rt.call_function('fseek', [this.stream, var_offset.clone(), var_whence.clone()]))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception('Unable to seek to stream position "' + (var_offset).str() + '" with whence ' + (rt.call_function('var_export', [var_whence.clone(), rt.new_bool(true)])).str())))
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) rewind() {
	this.seek(rt.new_int(0), rt.new_null())
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) iswritable() bool {
	return (this.writable).to_bool()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) write(var_string rt.PhpVal) i64 {
	if !(!(this.stream).is_null()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.new_string('Stream is detached'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.writable)))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.new_string('Cannot write to a non-writable stream'))))
	}
	this.size = rt.new_null()
	mut var_result := rt.call_function('fwrite', [this.stream, var_string.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception('Unable to write to stream: ' + (if !(rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message'))).is_null() { rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message')) } else { rt.new_string('') }).str())))
	}
	return (var_result).to_i64()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) isreadable() bool {
	return (this.readable).to_bool()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) read(var_length rt.PhpVal) string {
	if !(!(this.stream).is_null()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.new_string('Stream is detached'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.readable)))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.new_string('Cannot read from non-readable stream'))))
	}
	mut var_result := rt.call_function('fread', [this.stream, var_length.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception('Unable to read from stream: ' + (if !(rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message'))).is_null() { rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message')) } else { rt.new_string('') }).str())))
	}
	return (var_result).str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) getcontents() string {
	if !(!(this.stream).is_null()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception(rt.new_string('Stream is detached'))))
	}
	mut var_exception := rt.new_null()
	closure_1_fn := fn [mut var_exception] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_type := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_message := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_exception = create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception('Unable to read stream contents: ' + (var_message).str())
		rt.throw_exception(var_exception)
		return rt.new_null()
		}
	closure_2_fn := fn [mut var_exception] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_type := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_message := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_exception = create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception('Unable to read stream contents: ' + (var_message).str())
		rt.throw_exception(var_exception)
		return rt.new_null()
		}
	rt.call_function('set_error_handler', [rt.new_closure(closure_1_fn)])
	return (rt.call_function('stream_get_contents', [this.stream])).str()
	unsafe { goto finally_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WordPress_AiClientDependencies_Nyholm_Psr7_Throwable') {
		mut var_e := var_e_1.clone()
		rt.throw_exception(if rt.is_true(rt.identical(var_e, var_exception)) { var_e } else { create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception('Unable to read stream contents: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.new_int(0), var_e.clone()) })
		unsafe { goto finally_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto finally_label_1 }
	}

finally_label_1:
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	if rt.has_exception() { return rt.new_null() }

end_label_1:
	return ''
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) getmetadata(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_key)))) && !(var_key.clone().is_string()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Metadata key must be a string'))))
	}
	if !(!(this.stream).is_null()) {
		return if rt.is_true(var_key) { rt.new_null() } else { rt.new_array() }
	}
	mut var_meta := rt.call_function('stream_get_meta_data', [this.stream])
	if rt.is_true(rt.identical(rt.new_null(), var_key)) {
		return var_meta.clone()
	}
	return if !(var_meta.array_get(var_key)).is_null() { var_meta.array_get(var_key) } else { rt.new_null() }
}

fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream.openzvalstream(body string) rt.PhpVal {
	mut body_mutated := body
	mut var_wrapper := rt.new_null()
	var_wrapper = rt.call_function('get_class', [rt.create_object_dynamically(rt.new_null(), []rt.PhpVal{})])
	if !(var_wrapper).is_null() { var_wrapper } else { rt.call_function('stream_wrapper_register', [rt.new_string('Nyholm-Psr7-Zval'), var_wrapper]) }
	mut var_context := rt.call_function('stream_context_create', [rt.create_array([rt.ArrayItem{ key: 'Nyholm-Psr7-Zval', val: rt.create_array([rt.ArrayItem{ key: 'data', val: body_mutated }]) }])])
	mut var_stream := rt.call_function('fopen', [rt.new_string('Nyholm-Psr7-Zval://'), rt.new_string('r+'), rt.new_bool(false), var_context.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_stream)))) {
		rt.call_function('stream_wrapper_register', [rt.new_string('Nyholm-Psr7-Zval'), var_wrapper.clone()])
	var_stream = rt.call_function('fopen', [rt.new_string('Nyholm-Psr7-Zval://'), rt.new_string('r+'), rt.new_bool(false), var_context.clone()])
	}
	return var_stream.clone()
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_self {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_stream(arg_0 rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{
		PhpObjectBase: rt.PhpObjectBase{}
		stream: rt.new_null()
		seekable: false
		readable: rt.new_null()
		writable: rt.new_null()
		uri: rt.new_null()
		size: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_self(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_self {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_self{
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

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'create' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream.create(dispatch_arg_0)
		}
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'close' {
			this.close()
			return rt.new_null()
		}
		'detach' {
			return this.detach()
		}
		'getUri' {
			return this.geturi()
		}
		'getSize' {
			return rt.new_int(this.getsize())
		}
		'tell' {
			return rt.new_int(this.tell())
		}
		'eof' {
			return rt.new_bool(this.eof())
		}
		'isSeekable' {
			return rt.new_bool(this.isseekable())
		}
		'seek' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.seek(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'rewind' {
			this.rewind()
			return rt.new_null()
		}
		'isWritable' {
			return rt.new_bool(this.iswritable())
		}
		'write' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.write(dispatch_arg_0))
		}
		'isReadable' {
			return rt.new_bool(this.isreadable())
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.read(dispatch_arg_0))
		}
		'getContents' {
			return rt.new_string(this.getcontents())
		}
		'getMetadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getmetadata(dispatch_arg_0)
		}
		'openZvalStream' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream.openzvalstream(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'stream' { return this.stream }
		'seekable' { return rt.new_bool(this.seekable) }
		'readable' { return this.readable }
		'writable' { return this.writable }
		'uri' { return this.uri }
		'size' { return this.size }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'stream' { this.stream = val; return true }
		'seekable' { this.seekable = (val).to_bool(); return true }
		'readable' { this.readable = val; return true }
		'writable' { this.writable = val; return true }
		'uri' { this.uri = val; return true }
		'size' { this.size = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
	rt.register_class_factory('WordPress_AiClientDependencies_Nyholm_Psr7_Stream', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_wordpress_aiclientdependencies_nyholm_psr7_stream(c_arg_0)
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Stream', ['StreamInterface'], obj)
	})
	rt.register_class_factory('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception()
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException', []string{}, obj)
	})
	rt.register_class_factory('WordPress_AiClientDependencies_Nyholm_Psr7_self', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_nyholm_psr7_self()
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_self', []string{}, obj)
	})
	rt.register_class_factory('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_nyholm_psr7_runtimeexception()
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_RuntimeException', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}

import rt

struct Class_POMO_Reader {
	rt.PhpObjectBase
pub mut:
			endian rt.PhpVal = rt.new_string('little')
			_pos i64
			is_overloaded bool
}

fn (mut this Class_POMO_Reader) construct()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_substr')])) && rt.is_true(rt.bitwise_and(// unsupported expression: Expr_Cast_Int, rt.new_int(2))))) {
		this.is_overloaded = true
	} else {
		this.is_overloaded = false
	}
	this._pos = 0
}

fn (mut this Class_POMO_Reader) pomo_reader()  {
	rt.call_function('_deprecated_constructor', [Class_POMO_Reader.class(), rt.new_string('5.4.0'), Class_static.class()])
	fn () rt.PhpVal { mut temp := Class_POMO_Reader{}; temp.construct(); return rt.new_null() }()
}

fn (mut this Class_POMO_Reader) setendian(var_endian rt.PhpVal)  {
	this.endian = var_endian.dup()
}

fn (mut this Class_POMO_Reader) readint32() bool {
	mut var_bytes := this.read(rt.new_int(4))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	mut var_endian_letter := rt.new_string(if rt.is_true(rt.identical(rt.new_string('big'), this.endian)) { rt.new_string('N') } else { rt.new_string('V') })
	mut var_int := rt.call_function('unpack', [var_endian_letter.dup(), var_bytes.dup()])
	return (rt.call_function('reset', [var_int.dup()])).to_bool()
}

fn (mut this Class_POMO_Reader) readint32array(var_count rt.PhpVal) bool {
	mut var_bytes := this.read(rt.mul(rt.new_int(4), var_count))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	mut var_endian_letter := rt.new_string(if rt.is_true(rt.identical(rt.new_string('big'), this.endian)) { rt.new_string('N') } else { rt.new_string('V') })
	return (rt.call_function('unpack', [rt.concat(var_endian_letter, var_count), var_bytes.dup()])).to_bool()
}

fn (mut this Class_POMO_Reader) substr(var_input_string rt.PhpVal, var_start rt.PhpVal, var_length rt.PhpVal) rt.PhpVal {
	mut var_length_mutated := var_length
	if rt.is_true(this.is_overloaded) {
		return rt.call_function('mb_substr', [var_input_string.dup(), var_start.dup(), var_length_mutated.dup(), rt.new_string('ascii')])
	} else {
		return rt.call_function('substr', [var_input_string.dup(), var_start.dup(), var_length_mutated.dup()])
	}
	return rt.new_null()
}

fn (mut this Class_POMO_Reader) strlen(var_input_string rt.PhpVal) i64 {
	if rt.is_true(this.is_overloaded) {
		return (rt.call_function('mb_strlen', [var_input_string.dup(), rt.new_string('ascii')])).to_i64()
	} else {
		return var_input_string.dup().to_string().len
	}
	return i64(0)
}

fn (mut this Class_POMO_Reader) str_split(var_input_string rt.PhpVal, var_chunk_size rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('str_split')]))))) {
		mut var_length := rt.new_int(this.strlen(var_input_string.dup()))
		mut var_out := []rt.PhpVal{}
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_length))) { break }
				var_out << this.substr(var_input_string.dup(), var_i.dup(), var_chunk_size.dup())
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
		return var_out.dup()
	} else {
		return rt.call_function('str_split', [var_input_string.dup(), var_chunk_size.dup()])
	}
	return rt.new_null()
}

fn (mut this Class_POMO_Reader) pos() i64 {
	return this._pos
}

fn (mut this Class_POMO_Reader) is_resource() bool {
	return true
}

fn (mut this Class_POMO_Reader) close() bool {
	return true
}

struct Class_POMO_FileReader {
	rt.PhpObjectBase
pub mut:
			_f rt.PhpVal = rt.new_null()
}

fn (mut this Class_POMO_FileReader) construct(var_filename rt.PhpVal)  {
	this.Class_POMO_Reader.construct()
	this._f = rt.call_function('fopen', [var_filename.dup(), rt.new_string('rb')])
}

fn (mut this Class_POMO_FileReader) pomo_filereader(var_filename rt.PhpVal)  {
	rt.call_function('_deprecated_constructor', [Class_POMO_FileReader.class(), rt.new_string('5.4.0'), Class_static.class()])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_POMO_FileReader{}; temp.construct(arg_0); return rt.new_null() }(var_filename.dup())
}

fn (mut this Class_POMO_FileReader) read(var_bytes rt.PhpVal) rt.PhpVal {
	mut var_bytes_mutated := var_bytes
	return rt.call_function('fread', [this._f, var_bytes_mutated.dup()])
}

fn (mut this Class_POMO_FileReader) seekto(var_pos rt.PhpVal) bool {
	if rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, rt.call_function('fseek', [this._f, var_pos.dup(), rt.get_constant('SEEK_SET')]))) {
		return false
	}
	this.dispatch_set_prop('_pos', var_pos.dup())
	return true
}

fn (mut this Class_POMO_FileReader) is_resource() bool {
	return (rt.call_function('is_resource', [this._f])).to_bool()
}

fn (mut this Class_POMO_FileReader) feof() rt.PhpVal {
	return rt.call_function('feof', [this._f])
}

fn (mut this Class_POMO_FileReader) close() bool {
	return (rt.call_function('fclose', [this._f])).to_bool()
}

fn (mut this Class_POMO_FileReader) read_all() rt.PhpVal {
	return rt.call_function('stream_get_contents', [this._f])
}

struct Class_POMO_StringReader {
	rt.PhpObjectBase
pub mut:
			_str rt.PhpVal = rt.new_string('')
}

fn (mut this Class_POMO_StringReader) construct(str string)  {
	this.Class_POMO_Reader.construct()
	this._str = rt.new_string(str).dup()
	this.dispatch_set_prop('_pos', rt.new_int(0))
}

fn (mut this Class_POMO_StringReader) pomo_stringreader(str string)  {
	rt.call_function('_deprecated_constructor', [Class_POMO_StringReader.class(), rt.new_string('5.4.0'), Class_static.class()])
	fn (arg_0 string) rt.PhpVal { mut temp := Class_POMO_StringReader{}; temp.construct(arg_0); return rt.new_null() }(str)
}

fn (mut this Class_POMO_StringReader) read(var_bytes rt.PhpVal) rt.PhpVal {
	mut var_bytes_mutated := var_bytes
	mut var_data := this.substr(this._str, rt.new_int(rt.get_property(rt.new_object('POMO_StringReader', ['POMO_Reader'], &this), '_pos')), var_bytes_mutated.dup())
	// unsupported expression: Expr_AssignOp_Plus
	if this.strlen(this._str) < rt.get_property(rt.new_object('POMO_StringReader', ['POMO_Reader'], &this), '_pos') {
		this.dispatch_set_prop('_pos', this.strlen(this._str))
	}
	return var_data.dup()
}

fn (mut this Class_POMO_StringReader) seekto(var_pos rt.PhpVal) i64 {
	this.dispatch_set_prop('_pos', var_pos.dup())
	if this.strlen(this._str) < rt.get_property(rt.new_object('POMO_StringReader', ['POMO_Reader'], &this), '_pos') {
		this.dispatch_set_prop('_pos', this.strlen(this._str))
	}
	return rt.get_property(rt.new_object('POMO_StringReader', ['POMO_Reader'], &this), '_pos')
}

fn (mut this Class_POMO_StringReader) length() i64 {
	return this.strlen(this._str)
}

fn (mut this Class_POMO_StringReader) read_all() rt.PhpVal {
	return this.substr(this._str, rt.new_int(rt.get_property(rt.new_object('POMO_StringReader', ['POMO_Reader'], &this), '_pos')), rt.new_int(this.strlen(this._str)))
}

struct Class_POMO_CachedFileReader {
	rt.PhpObjectBase
}

fn (mut this Class_POMO_CachedFileReader) construct(var_filename rt.PhpVal)  {
	this.Class_POMO_StringReader.construct()
	this.dispatch_set_prop('_str', rt.call_function('file_get_contents', [var_filename.dup()]))
	if rt.is_true(rt.identical(rt.new_bool(false), rt.get_property(rt.new_object('POMO_CachedFileReader', ['POMO_StringReader', 'POMO_Reader'], &this), '_str'))) {
		return
	}
	this.dispatch_set_prop('_pos', rt.new_int(0))
}

fn (mut this Class_POMO_CachedFileReader) pomo_cachedfilereader(var_filename rt.PhpVal)  {
	rt.call_function('_deprecated_constructor', [Class_POMO_CachedFileReader.class(), rt.new_string('5.4.0'), Class_static.class()])
	fn (arg_0 string) rt.PhpVal { mut temp := Class_POMO_CachedFileReader{}; return temp.construct(arg_0) }((var_filename).str())
}

struct Class_POMO_CachedIntFileReader {
	rt.PhpObjectBase
}

fn (mut this Class_POMO_CachedIntFileReader) construct(var_filename rt.PhpVal)  {
	this.Class_POMO_CachedFileReader.construct((var_filename).str())
}

fn (mut this Class_POMO_CachedIntFileReader) pomo_cachedintfilereader(var_filename rt.PhpVal)  {
	rt.call_function('_deprecated_constructor', [Class_POMO_CachedIntFileReader.class(), rt.new_string('5.4.0'), Class_static.class()])
	fn (arg_0 string) rt.PhpVal { mut temp := Class_POMO_CachedIntFileReader{}; temp.construct(arg_0); return rt.new_null() }((var_filename).str())
}

fn create_pomo_reader() &Class_POMO_Reader {
	mut obj := &Class_POMO_Reader{
		PhpObjectBase: rt.PhpObjectBase{}
		endian: rt.new_string('little')
		_pos: i64(0)
		is_overloaded: false
	}
	obj.construct()
	return obj
}

fn create_pomo_filereader(arg_0 rt.PhpVal) &Class_POMO_FileReader {
	mut obj := &Class_POMO_FileReader{
		PhpObjectBase: rt.PhpObjectBase{}
		_f: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_pomo_stringreader(str string) &Class_POMO_StringReader {
	mut obj := &Class_POMO_StringReader{
		PhpObjectBase: rt.PhpObjectBase{}
		_str: rt.new_string('')
	}
	obj.construct(str)
	return obj
}

fn create_pomo_cachedfilereader(arg_0 rt.PhpVal) &Class_POMO_CachedFileReader {
	mut obj := &Class_POMO_CachedFileReader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_pomo_cachedintfilereader(arg_0 rt.PhpVal) &Class_POMO_CachedIntFileReader {
	mut obj := &Class_POMO_CachedIntFileReader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_POMO_Reader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'POMO_Reader' {
			this.pomo_reader()
			return rt.new_null()
		}
		'setEndian' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setendian(dispatch_arg_0)
			return rt.new_null()
		}
		'readint32' {
			return rt.new_bool(this.readint32())
		}
		'readint32array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.readint32array(dispatch_arg_0))
		}
		'substr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.substr(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'strlen' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.strlen(dispatch_arg_0))
		}
		'str_split' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.str_split(dispatch_arg_0, dispatch_arg_1)
		}
		'pos' {
			return rt.new_int(this.pos())
		}
		'is_resource' {
			return rt.new_bool(this.is_resource())
		}
		'close' {
			return rt.new_bool(this.close())
		}
		else { return none }
	}
}

fn (this &Class_POMO_Reader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'endian' { return this.endian }
		'_pos' { return rt.new_int(this._pos) }
		'is_overloaded' { return rt.new_bool(this.is_overloaded) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_POMO_Reader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'endian' { this.endian = val; return true }
		'_pos' { this._pos = (val).to_i64(); return true }
		'is_overloaded' { this.is_overloaded = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_POMO_FileReader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'POMO_FileReader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.pomo_filereader(dispatch_arg_0)
			return rt.new_null()
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.read(dispatch_arg_0)
		}
		'seekto' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.seekto(dispatch_arg_0))
		}
		'is_resource' {
			return rt.new_bool(this.is_resource())
		}
		'feof' {
			return this.feof()
		}
		'close' {
			return rt.new_bool(this.close())
		}
		'read_all' {
			return this.read_all()
		}
		else { return none }
	}
}

fn (this &Class_POMO_FileReader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_f' { return this._f }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_POMO_FileReader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_f' { this._f = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_POMO_StringReader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'POMO_StringReader' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.pomo_stringreader(dispatch_arg_0)
			return rt.new_null()
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.read(dispatch_arg_0)
		}
		'seekto' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.seekto(dispatch_arg_0))
		}
		'length' {
			return rt.new_int(this.length())
		}
		'read_all' {
			return this.read_all()
		}
		else { return none }
	}
}

fn (this &Class_POMO_StringReader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_str' { return this._str }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_POMO_StringReader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_str' { this._str = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_POMO_CachedFileReader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'POMO_CachedFileReader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.pomo_cachedfilereader(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_POMO_CachedFileReader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_POMO_CachedFileReader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_POMO_CachedIntFileReader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'POMO_CachedIntFileReader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.pomo_cachedintfilereader(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_POMO_CachedIntFileReader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_POMO_CachedIntFileReader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_pomo_streams_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('POMO_Reader'), rt.new_bool(false)]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('POMO_FileReader'), rt.new_bool(false)]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('POMO_StringReader'), rt.new_bool(false)]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('POMO_CachedFileReader'), rt.new_bool(false)]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('POMO_CachedIntFileReader'), rt.new_bool(false)]))))) {
	}
}

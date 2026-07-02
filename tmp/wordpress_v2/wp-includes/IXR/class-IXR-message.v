import rt

struct Class_IXR_Message {
	rt.PhpObjectBase
pub mut:
	message             rt.PhpVal = rt.new_bool(false)
	messageType         rt.PhpVal = rt.new_bool(false)
	faultCode           rt.PhpVal = rt.new_bool(false)
	faultString         rt.PhpVal = rt.new_bool(false)
	methodName          rt.PhpVal = rt.new_string('')
	params              rt.PhpVal = rt.new_array()
	_arraystructs       rt.PhpVal = rt.new_array()
	_arraystructstypes  rt.PhpVal = rt.new_array()
	_currentStructName  rt.PhpVal = rt.new_array()
	_param              rt.PhpVal = rt.new_null()
	_value              rt.PhpVal = rt.new_null()
	_currentTag         rt.PhpVal = rt.new_null()
	_currentTagContents string
	_parser             rt.PhpVal = rt.new_null()
}

fn (mut this Class_IXR_Message) construct(var_message rt.PhpVal) {
	this.message = var_message
}

fn (mut this Class_IXR_Message) ixr_message(var_message rt.PhpVal) {
	mut iife_temp_0 := Class_IXR_Message{}
	iife_temp_0.construct(var_message.clone())
	rt.new_null()
}

fn (mut this Class_IXR_Message) parse() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('xml_parser_create'),
	])))))
	{
		rt.call_function('trigger_error', [
			rt.call_function('__', [
				rt.new_string("PHP's XML extension is not available. Please contact your hosting provider to enable PHP's XML extension."),
			]),
		])
		return false
	}
	mut var_header := rt.call_function('preg_replace', [
		rt.new_string('/<\\?xml.*?\\?' + '>/s'),
		rt.new_string(''),
		rt.call_function('substr', [this.message, rt.new_int(0),
			rt.new_int(100)]),
		rt.new_int(1),
	])
	this.message = rt.new_string(rt.call_function('substr_replace', [this.message, var_header.clone(),
		rt.new_int(0), rt.new_int(100)]).to_string().trim_space())
	if rt.is_true(rt.equal(rt.new_string(''), this.message)) {
		return false
	}
	var_header = rt.call_function('preg_replace', [rt.new_string('/^<!DOCTYPE[^>]*+>/i'),
		rt.new_string(''), rt.call_function('substr', [this.message, rt.new_int(0),
			rt.new_int(200)]),
		rt.new_int(1)])
	this.message = rt.new_string(rt.call_function('substr_replace', [this.message, var_header.clone(),
		rt.new_int(0), rt.new_int(200)]).to_string().trim_space())
	if rt.is_true(rt.equal(rt.new_string(''), this.message)) {
		return false
	}
	mut var_root_tag := rt.call_function('substr', [this.message, rt.new_int(0),
		rt.call_function('strcspn', [
			rt.call_function('substr', [this.message, rt.new_int(0),
				rt.new_int(20)]),
			rt.new_string('> \t\r\n'),
		])])
	if rt.is_true(rt.identical(rt.new_string('<!DOCTYPE'),
		rt.new_string(var_root_tag.clone().to_string().to_upper())))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_root_tag.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: '<methodCall' },
			rt.ArrayItem{ key: none, val: '<methodResponse' },
			rt.ArrayItem{ key: none, val: '<fault' },
		])])))))
	{
		return false
	}
	mut var_element_limit := rt.new_int(30000)
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('apply_filters')])) {
		var_element_limit = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_element_limit'),
			var_element_limit.clone(),
		])
	}
	if rt.is_true(var_element_limit)
		&& rt.is_true(rt.less(rt.mul(rt.new_int(2), var_element_limit), rt.call_function('substr_count', [this.message, rt.new_string('<')]))) {
		return false
	}
	this._parser = rt.call_function('xml_parser_create', []rt.PhpVal{})
	rt.call_function('xml_parser_set_option', [this._parser, rt.get_constant('XML_OPTION_CASE_FOLDING'),
		rt.new_bool(false)])
	rt.call_function('xml_set_element_handler', [this._parser,
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('IXR_Message', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'tag_open' },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('IXR_Message', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'tag_close' },
		])])
	rt.call_function('xml_set_character_data_handler', [this._parser,
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('IXR_Message', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'cdata' },
		])])
	mut var_chunk_size := rt.new_int(262144)
	var_chunk_size = rt.call_function('apply_filters', [
		rt.new_string('xmlrpc_chunk_parsing_size'),
		var_chunk_size.clone(),
	])
	mut var_final := rt.new_bool(false)
	for {
		if rt.is_true(rt.less_equal(rt.new_int(this.message.to_string().len), var_chunk_size)) {
			var_final = rt.new_bool(true)
		}
		mut var_part := rt.call_function('substr', [this.message, rt.new_int(0),
			var_chunk_size.clone()])
		this.message = rt.call_function('substr', [this.message, var_chunk_size.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('xml_parse', [this._parser,
			var_part.clone(), var_final.clone()])))))
		{
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('xml_parser_free', [this._parser])
			}
			this._parser = rt.new_null()
			return false
		}
		if rt.is_true(var_final) {
			break
		}
		if !(true) {
			break
		}
	}
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
		rt.call_function('xml_parser_free', [this._parser])
	}
	this._parser = rt.new_null()
	if rt.is_true(rt.equal(this.messageType, rt.new_string('fault'))) {
		this.faultCode = this.params.array_get(rt.new_int(0)).array_get(rt.new_string('faultCode'))
		this.faultString =
			this.params.array_get(rt.new_int(0)).array_get(rt.new_string('faultString'))
	}
	return true
}

fn (mut this Class_IXR_Message) tag_open(var_parser rt.PhpVal, var_tag rt.PhpVal, var_attr rt.PhpVal) {
	this._currentTagContents = ''
	this._currentTag = var_tag.clone()
	mut switch_val_1 := var_tag
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('methodCall')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('methodResponse')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('fault'))) {
		this.messageType = var_tag.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('data'))) {
		this._arraystructstypes.array_push('array')
		this._arraystructs.array_push(rt.new_array())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('struct'))) {
		this._arraystructstypes.array_push('struct')
		this._arraystructs.array_push(rt.new_array())
	}
}

fn (mut this Class_IXR_Message) cdata(var_parser rt.PhpVal, var_cdata rt.PhpVal) {
	this._currentTagContents = rt.concat(this._currentTagContents, var_cdata)
}

fn (mut this Class_IXR_Message) tag_close(var_parser rt.PhpVal, var_tag rt.PhpVal) {
	mut var_valueFlag := rt.new_bool(false)
	mut switch_val_2 := var_tag
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('int')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('i4'))) {
		mut var_value := rt.new_int(this._currentTagContents.trim_space().i64())
		var_valueFlag = rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('double'))) {
		var_value = rt.new_float(this._currentTagContents.trim_space().f64())
		var_valueFlag = rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('string'))) {
		var_value = rt.new_string(this._currentTagContents.trim_space())
		var_valueFlag = rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('dateTime.iso8601'))) {
		var_value = create_ixr_date(rt.new_string(this._currentTagContents.trim_space()))
		var_valueFlag = rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('value'))) {
		if rt.is_true(rt.new_bool(this._currentTagContents.trim_space() != '')) {
			var_value = rt.new_string(this._currentTagContents)
			var_valueFlag = rt.new_bool(true)
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('boolean'))) {
		var_value = rt.new_bool((rt.new_string(this._currentTagContents.trim_space())).to_bool())
		var_valueFlag = rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('base64'))) {
		var_value = rt.call_function('base64_decode', [
			rt.new_string(this._currentTagContents),
		])
		var_valueFlag = rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('data')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('struct'))) {
		var_value = rt.call_function('array_pop', [this._arraystructs])
		rt.call_function('array_pop', [this._arraystructstypes])
		var_valueFlag = rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('member'))) {
		rt.call_function('array_pop', [this._currentStructName])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('name'))) {
		this._currentStructName.array_push(this._currentTagContents.trim_space())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('methodName'))) {
		this.methodName = rt.new_string(this._currentTagContents.trim_space())
	}
	if rt.is_true(var_valueFlag) {
		if this._arraystructs.array_count() > 0 {
			if rt.is_true(rt.equal(this._arraystructstypes.array_get(rt.new_int(this._arraystructstypes.array_count() - 1)),
				rt.new_string('struct')))
			{
				this._arraystructs.array_get_mut(this._arraystructs.array_count() - 1).array_set(this._currentStructName.array_get(rt.new_int(this._currentStructName.array_count() - 1)),
					var_value.clone())
			} else {
				this._arraystructs.array_get_mut(this._arraystructs.array_count() - 1).array_push(var_value.clone())
			}
		} else {
			this.params.array_push(var_value.clone())
		}
	}
	this._currentTagContents = ''
}

struct Class_IXR_Date {
	rt.PhpObjectBase
}

fn create_ixr_message(arg_0 rt.PhpVal) &Class_IXR_Message {
	mut obj := &Class_IXR_Message{
		PhpObjectBase:       rt.PhpObjectBase{}
		message:             rt.new_bool(false)
		messageType:         rt.new_bool(false)
		faultCode:           rt.new_bool(false)
		faultString:         rt.new_bool(false)
		methodName:          rt.new_string('')
		params:              rt.new_array()
		_arraystructs:       rt.new_array()
		_arraystructstypes:  rt.new_array()
		_currentStructName:  rt.new_array()
		_param:              rt.new_null()
		_value:              rt.new_null()
		_currentTag:         rt.new_null()
		_currentTagContents: ''
		_parser:             rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_ixr_date(_args ...rt.PhpVal) &Class_IXR_Date {
	mut obj := &Class_IXR_Date{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_IXR_Message) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'IXR_Message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.ixr_message(dispatch_arg_0)
			return rt.new_null()
		}
		'parse' {
			return rt.new_bool(this.parse())
		}
		'tag_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.tag_open(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'cdata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.cdata(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'tag_close' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.tag_close(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_IXR_Message) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return this.message }
		'messageType' { return this.messageType }
		'faultCode' { return this.faultCode }
		'faultString' { return this.faultString }
		'methodName' { return this.methodName }
		'params' { return this.params }
		'_arraystructs' { return this._arraystructs }
		'_arraystructstypes' { return this._arraystructstypes }
		'_currentStructName' { return this._currentStructName }
		'_param' { return this._param }
		'_value' { return this._value }
		'_currentTag' { return this._currentTag }
		'_currentTagContents' { return rt.new_string(this._currentTagContents) }
		'_parser' { return this._parser }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_IXR_Message) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val
			return true
		}
		'messageType' {
			this.messageType = val
			return true
		}
		'faultCode' {
			this.faultCode = val
			return true
		}
		'faultString' {
			this.faultString = val
			return true
		}
		'methodName' {
			this.methodName = val
			return true
		}
		'params' {
			this.params = val
			return true
		}
		'_arraystructs' {
			this._arraystructs = val
			return true
		}
		'_arraystructstypes' {
			this._arraystructstypes = val
			return true
		}
		'_currentStructName' {
			this._currentStructName = val
			return true
		}
		'_param' {
			this._param = val
			return true
		}
		'_value' {
			this._value = val
			return true
		}
		'_currentTag' {
			this._currentTag = val
			return true
		}
		'_currentTagContents' {
			this._currentTagContents = val.str()
			return true
		}
		'_parser' {
			this._parser = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_IXR_Date) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Date) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Date) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

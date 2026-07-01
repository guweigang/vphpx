import rt

pub fn Class_SimplePie_XML_Declaration_Parser.state_before_version_name() string {
	return 'before_version_name'
}
pub fn Class_SimplePie_XML_Declaration_Parser.state_version_name() string {
	return 'version_name'
}
pub fn Class_SimplePie_XML_Declaration_Parser.state_version_equals() string {
	return 'version_equals'
}
pub fn Class_SimplePie_XML_Declaration_Parser.state_version_value() string {
	return 'version_value'
}
pub fn Class_SimplePie_XML_Declaration_Parser.state_encoding_name() string {
	return 'encoding_name'
}
pub fn Class_SimplePie_XML_Declaration_Parser.state_emit() string {
	return 'emit'
}
pub fn Class_SimplePie_XML_Declaration_Parser.state_encoding_equals() string {
	return 'encoding_equals'
}
pub fn Class_SimplePie_XML_Declaration_Parser.state_standalone_name() string {
	return 'standalone_name'
}
pub fn Class_SimplePie_XML_Declaration_Parser.state_encoding_value() string {
	return 'encoding_value'
}
pub fn Class_SimplePie_XML_Declaration_Parser.state_standalone_equals() string {
	return 'standalone_equals'
}
pub fn Class_SimplePie_XML_Declaration_Parser.state_standalone_value() string {
	return 'standalone_value'
}
pub fn Class_SimplePie_XML_Declaration_Parser.state_error() bool {
	return false
}
struct Class_SimplePie_XML_Declaration_Parser {
	rt.PhpObjectBase
pub mut:
		version rt.PhpVal = rt.new_string('1.0')
		encoding rt.PhpVal = rt.new_string('UTF-8')
		standalone bool
		state rt.PhpVal = rt.new_null()
		data string
		data_length i64
		position rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) construct(data string)  {
	this.data = data
	this.data_length = this.data.len
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) parse() bool {
	for rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.state) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && this.has_data())) {
		mut var_state := this.state
		rt.call_method(rt.new_object('SimplePie_XML_Declaration_Parser', []string{}, &this), var_state, []rt.PhpVal{})
	}
	this.data = ''
	if rt.is_true(rt.identical(this.state, Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_emit())) {
		return true
	}
	this.version = rt.new_string('1.0')
	this.encoding = rt.new_string('UTF-8')
	this.standalone = false
	return false
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) has_data() bool {
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) skip_whitespace() rt.PhpVal {
	mut var_whitespace := rt.call_function('strspn', [this.data, rt.new_string('\t\n\r '), this.position])
	// unsupported expression: Expr_AssignOp_Plus
	return var_whitespace.dup()
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) get_value() bool {
	mut var_quote := rt.call_function('substr', [this.data, this.position, rt.new_int(1)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_quote, rt.new_string('"'))) || rt.is_true(rt.identical(var_quote, rt.new_string('\''))))) {
		rt.post_inc(this.position)
		mut var_len := rt.call_function('strcspn', [this.data, var_quote.dup(), this.position])
		if this.has_data() {
			mut var_value := rt.call_function('substr', [this.data, this.position, var_len.dup()])
			// unsupported expression: Expr_AssignOp_Plus
			return (var_value).to_bool()
		}
	}
	return false
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) before_version_name()  {
	if rt.is_true(this.skip_whitespace()) {
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_version_name()
	} else {
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_error()
	}
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) version_name()  {
	if rt.is_true(rt.identical(rt.call_function('substr', [this.data, this.position, rt.new_int(7)]), rt.new_string('version'))) {
		// unsupported expression: Expr_AssignOp_Plus
		this.skip_whitespace()
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_version_equals()
	} else {
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_error()
	}
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) version_equals()  {
	if rt.is_true(rt.identical(rt.call_function('substr', [this.data, this.position, rt.new_int(1)]), rt.new_string('='))) {
		rt.post_inc(this.position)
		this.skip_whitespace()
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_version_value()
	} else {
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_error()
	}
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) version_value()  {
	if rt.is_true(mut var_version := rt.new_bool(this.get_value())) {
		this.version = var_version.dup()
		this.skip_whitespace()
		if this.has_data() {
			this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_encoding_name()
		} else {
			this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_emit()
		}
	} else {
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_error()
	}
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) encoding_name()  {
	if rt.is_true(rt.identical(rt.call_function('substr', [this.data, this.position, rt.new_int(8)]), rt.new_string('encoding'))) {
		// unsupported expression: Expr_AssignOp_Plus
		this.skip_whitespace()
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_encoding_equals()
	} else {
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_standalone_name()
	}
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) encoding_equals()  {
	if rt.is_true(rt.identical(rt.call_function('substr', [this.data, this.position, rt.new_int(1)]), rt.new_string('='))) {
		rt.post_inc(this.position)
		this.skip_whitespace()
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_encoding_value()
	} else {
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_error()
	}
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) encoding_value()  {
	if rt.is_true(mut var_encoding := rt.new_bool(this.get_value())) {
		this.encoding = var_encoding.dup()
		this.skip_whitespace()
		if this.has_data() {
			this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_standalone_name()
		} else {
			this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_emit()
		}
	} else {
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_error()
	}
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) standalone_name()  {
	if rt.is_true(rt.identical(rt.call_function('substr', [this.data, this.position, rt.new_int(10)]), rt.new_string('standalone'))) {
		// unsupported expression: Expr_AssignOp_Plus
		this.skip_whitespace()
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_standalone_equals()
	} else {
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_error()
	}
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) standalone_equals()  {
	if rt.is_true(rt.identical(rt.call_function('substr', [this.data, this.position, rt.new_int(1)]), rt.new_string('='))) {
		rt.post_inc(this.position)
		this.skip_whitespace()
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_standalone_value()
	} else {
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_error()
	}
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) standalone_value()  {
	if rt.is_true(mut var_standalone := rt.new_bool(this.get_value())) {
		mut switch_val_1 := var_standalone
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('yes'))) {
			this.standalone = true
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('no'))) {
			this.standalone = false
		} else {
			this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_error()
			return rt.new_null()
		}
		this.skip_whitespace()
		if this.has_data() {
			this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_error()
		} else {
			this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_emit()
		}
	} else {
		this.state = Class_SimplePie_XML_Declaration_SimplePie_XML_Declaration_Parser.state_error()
	}
}

fn create_simplepie_xml_declaration_parser(data string) &Class_SimplePie_XML_Declaration_Parser {
	mut obj := &Class_SimplePie_XML_Declaration_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
		version: rt.new_string('1.0')
		encoding: rt.new_string('UTF-8')
		standalone: false
		state: rt.new_null()
		data: ''
		data_length: i64(0)
		position: rt.new_int(0)
	}
	obj.construct(data)
	return obj
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'parse' {
			return rt.new_bool(this.parse())
		}
		'has_data' {
			return rt.new_bool(this.has_data())
		}
		'skip_whitespace' {
			return this.skip_whitespace()
		}
		'get_value' {
			return rt.new_bool(this.get_value())
		}
		'before_version_name' {
			this.before_version_name()
			return rt.new_null()
		}
		'version_name' {
			this.version_name()
			return rt.new_null()
		}
		'version_equals' {
			this.version_equals()
			return rt.new_null()
		}
		'version_value' {
			this.version_value()
			return rt.new_null()
		}
		'encoding_name' {
			this.encoding_name()
			return rt.new_null()
		}
		'encoding_equals' {
			this.encoding_equals()
			return rt.new_null()
		}
		'encoding_value' {
			this.encoding_value()
			return rt.new_null()
		}
		'standalone_name' {
			this.standalone_name()
			return rt.new_null()
		}
		'standalone_equals' {
			this.standalone_equals()
			return rt.new_null()
		}
		'standalone_value' {
			this.standalone_value()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_XML_Declaration_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'version' { return this.version }
		'encoding' { return this.encoding }
		'standalone' { return rt.new_bool(this.standalone) }
		'state' { return this.state }
		'data' { return rt.new_string(this.data) }
		'data_length' { return rt.new_int(this.data_length) }
		'position' { return this.position }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_XML_Declaration_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'version' { this.version = val; return true }
		'encoding' { this.encoding = val; return true }
		'standalone' { this.standalone = (val).to_bool(); return true }
		'state' { this.state = val; return true }
		'data' { this.data = (val).str(); return true }
		'data_length' { this.data_length = (val).to_i64(); return true }
		'position' { this.position = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_simplepie_src_xml_declaration_parser_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_alias', [rt.new_string('SimplePie\\XML\\Declaration\\Parser'), rt.new_string('SimplePie_XML_Declaration_Parser')])
}

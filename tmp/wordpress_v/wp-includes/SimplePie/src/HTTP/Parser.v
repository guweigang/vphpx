import rt

pub fn Class_SimplePie_HTTP_Parser.state_http_version() string {
	return 'http_version'
}
pub fn Class_SimplePie_HTTP_Parser.state_status() string {
	return 'status'
}
pub fn Class_SimplePie_HTTP_Parser.state_reason() string {
	return 'reason'
}
pub fn Class_SimplePie_HTTP_Parser.state_new_line() string {
	return 'new_line'
}
pub fn Class_SimplePie_HTTP_Parser.state_body() string {
	return 'body'
}
pub fn Class_SimplePie_HTTP_Parser.state_name() string {
	return 'name'
}
pub fn Class_SimplePie_HTTP_Parser.state_value() string {
	return 'value'
}
pub fn Class_SimplePie_HTTP_Parser.state_value_char() string {
	return 'value_char'
}
pub fn Class_SimplePie_HTTP_Parser.state_quote() string {
	return 'quote'
}
pub fn Class_SimplePie_HTTP_Parser.state_quote_escaped() string {
	return 'quote_escaped'
}
pub fn Class_SimplePie_HTTP_Parser.state_quote_char() string {
	return 'quote_char'
}
pub fn Class_SimplePie_HTTP_Parser.state_chunked() string {
	return 'chunked'
}
pub fn Class_SimplePie_HTTP_Parser.state_emit() string {
	return 'emit'
}
pub fn Class_SimplePie_HTTP_Parser.state_error() bool {
	return false
}
struct Class_SimplePie_HTTP_Parser {
	rt.PhpObjectBase
pub mut:
		http_version rt.PhpVal = rt.new_float(0)
		status_code rt.PhpVal = rt.new_int(0)
		reason string
		psr7Compatible bool
		headers rt.PhpVal = rt.new_array()
		body rt.PhpVal = rt.new_string('')
		state rt.PhpVal = rt.new_null()
		data string
		data_length i64
		position rt.PhpVal = rt.new_int(0)
		name rt.PhpVal = rt.new_string('')
		value string
}

fn (mut this Class_SimplePie_HTTP_Parser) construct(data string, psr7Compatible bool)  {
	mut data_mutated := data
	this.data = (rt.new_string(data_mutated)).str()
	this.data_length = this.data.len
	this.psr7Compatible = psr7Compatible
}

fn (mut this Class_SimplePie_HTTP_Parser) parse() bool {
	for rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.state) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(this.has_data()))) {
		mut var_state := this.state
		rt.call_method(rt.new_object('SimplePie_HTTP_Parser', []string{}, &this), var_state, []rt.PhpVal{})
	}
	this.data = ''
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(this.state, Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_emit())) || rt.is_true(rt.identical(this.state, Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_body())))) {
		return true
	}
	this.http_version = rt.new_float(0)
	this.status_code = rt.new_int(0)
	this.reason = ''
	this.headers = rt.new_array()
	this.body = rt.new_string('')
	return false
}

fn (mut this Class_SimplePie_HTTP_Parser) has_data() rt.PhpVal {
	return // unsupported expression: Expr_Cast_Bool
}

fn (mut this Class_SimplePie_HTTP_Parser) is_linear_whitespace() rt.PhpVal {
	return // unsupported expression: Expr_Cast_Bool
}

fn (mut this Class_SimplePie_HTTP_Parser) http_version()  {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(rt.new_string(rt.call_function('substr', [this.data, rt.new_int(0), rt.new_int(5)]).to_string().to_upper()), rt.new_string('HTTP/'))))) {
		mut var_len := rt.call_function('strspn', [this.data, rt.new_string('0123456789.'), rt.new_int(5)])
		mut var_http_version := rt.call_function('substr', [this.data, rt.new_int(5), var_len.dup()])
		// unsupported expression: Expr_AssignOp_Plus
		if rt.is_true(rt.less_equal(rt.call_function('substr_count', [var_http_version.dup(), rt.new_string('.')]), rt.new_int(1))) {
			this.http_version = // unsupported expression: Expr_Cast_Double
			// unsupported expression: Expr_AssignOp_Plus
			this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_status()
		} else {
			this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_error()
		}
	} else {
		this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_error()
	}
}

fn (mut this Class_SimplePie_HTTP_Parser) status()  {
	if rt.is_true(mut var_len := rt.call_function('strspn', [this.data, rt.new_string('0123456789'), this.position])) {
		this.status_code = // unsupported expression: Expr_Cast_Int
		// unsupported expression: Expr_AssignOp_Plus
		this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_reason()
	} else {
		this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_error()
	}
}

fn (mut this Class_SimplePie_HTTP_Parser) reason()  {
	mut var_len := rt.call_function('strcspn', [this.data, rt.new_string('\n'), this.position])
	this.reason = rt.call_function('substr', [this.data, this.position, var_len.dup()]).to_string().trim_space()
	// unsupported expression: Expr_AssignOp_Plus
	this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_new_line()
}

fn (mut this Class_SimplePie_HTTP_Parser) add_header(name string, value string)  {
	mut var_headers := rt.new_null()
	if rt.is_true(this.psr7Compatible) {
		// unsupported expression: Expr_AssignRef
		var_headers.array_get_mut(name).array_push(value)
	} else {
		// unsupported expression: Expr_AssignRef
		// unsupported expression: Expr_AssignOp_Concat
	}
}

fn (mut this Class_SimplePie_HTTP_Parser) replace_header(name string, value string)  {
	mut var_headers := rt.new_null()
	if rt.is_true(this.psr7Compatible) {
		// unsupported expression: Expr_AssignRef
		var_headers.array_set(name, rt.create_array([rt.ArrayItem{ key: none, val: value }]))
	} else {
		// unsupported expression: Expr_AssignRef
		var_headers.array_set(name, value)
	}
}

fn (mut this Class_SimplePie_HTTP_Parser) new_line()  {
	this.value = this.value.trim_space()
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.name = rt.new_string(this.name.to_string().to_lower())
		if rt.is_true(rt.new_bool(this.headers.array_isset(this.name) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			this.add_header((this.name).str(), this.value)
		} else {
			this.replace_header((this.name).str(), this.value)
		}
	}
	this.name = rt.new_string('')
	this.value = ''
	if rt.is_true(rt.identical(rt.call_function('substr', [this.data.array_get(this.position), rt.new_int(0), rt.new_int(2)]), rt.new_string('\r\n'))) {
		// unsupported expression: Expr_AssignOp_Plus
		this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_body()
	} else if rt.is_true(rt.identical(this.data.array_get(this.position), rt.new_string('\n'))) {
		rt.post_inc(this.position)
		this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_body()
	} else {
		this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_name()
	}
}

fn (mut this Class_SimplePie_HTTP_Parser) name()  {
	mut var_len := rt.call_function('strcspn', [this.data, rt.new_string('\n:'), this.position])
	if this.data.array_isset(rt.add(this.position, var_len)) {
		if rt.is_true(rt.identical(this.data.array_get(rt.add(this.position, var_len)), rt.new_string('\n'))) {
			// unsupported expression: Expr_AssignOp_Plus
			this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_new_line()
		} else {
			this.name = rt.call_function('substr', [this.data, this.position, var_len.dup()])
			// unsupported expression: Expr_AssignOp_Plus
			this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_value()
		}
	} else {
		this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_error()
	}
}

fn (mut this Class_SimplePie_HTTP_Parser) linear_whitespace()  {
	for {
		if rt.is_true(rt.identical(rt.call_function('substr', [this.data, this.position, rt.new_int(2)]), rt.new_string('\r\n'))) {
			// unsupported expression: Expr_AssignOp_Plus
		} else if rt.is_true(rt.identical(this.data.array_get(this.position), rt.new_string('\n'))) {
			rt.post_inc(this.position)
		}
		// unsupported expression: Expr_AssignOp_Plus
		if !(rt.is_true(rt.new_bool(rt.is_true(this.has_data()) && rt.is_true(this.is_linear_whitespace())))) {
			break
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_SimplePie_HTTP_Parser) value()  {
	if rt.is_true(this.is_linear_whitespace()) {
		this.linear_whitespace()
	} else {
		mut switch_val_1 := this.data.array_get(this.position)
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('"'))) {
			if rt.is_true(rt.identical(rt.new_string(this.name.to_string().to_lower()), rt.new_string('etag'))) {
				// unsupported expression: Expr_AssignOp_Concat
				rt.post_inc(this.position)
				this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_value_char()
				break
			}
			rt.post_inc(this.position)
			this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_quote()
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('\n'))) {
			rt.post_inc(this.position)
			this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_new_line()
		} else {
			this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_value_char()
		}
	}
}

fn (mut this Class_SimplePie_HTTP_Parser) value_char()  {
	mut var_len := rt.call_function('strcspn', [this.data, rt.new_string('\t \n"'), this.position])
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Plus
	this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_value()
}

fn (mut this Class_SimplePie_HTTP_Parser) quote()  {
	if rt.is_true(this.is_linear_whitespace()) {
		this.linear_whitespace()
	} else {
		mut switch_val_2 := this.data.array_get(this.position)
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('"'))) {
			rt.post_inc(this.position)
			this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_value()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('\n'))) {
			rt.post_inc(this.position)
			this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_new_line()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('\\'))) {
			rt.post_inc(this.position)
			this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_quote_escaped()
		} else {
			this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_quote_char()
		}
	}
}

fn (mut this Class_SimplePie_HTTP_Parser) quote_char()  {
	mut var_len := rt.call_function('strcspn', [this.data, rt.new_string('\t \n"\\'), this.position])
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Plus
	this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_value()
}

fn (mut this Class_SimplePie_HTTP_Parser) quote_escaped()  {
	// unsupported expression: Expr_AssignOp_Concat
	rt.post_inc(this.position)
	this.state = Class_SimplePie_HTTP_SimplePie_HTTP_Parser.state_quote()
}

fn (mut this Class_SimplePie_HTTP_Parser) body()  {
	this.body = rt.call_function('substr', [, ])
	if !(!rt.is_true(.array_get())) {
		.array_unset()
	} else {
	}
}

fn (mut this Class_SimplePie_HTTP_Parser) chunked()  {
	mut var_matches := rt.new_null()
	if rt.is_true() {
	}
	
}

fn Class_SimplePie_HTTP_Parser.prepareheaders(headers string, count i64) rt.PhpVal {
	mut headers_mutated := headers
}

fn create_simplepie_http_parser(data string, psr7Compatible bool) &Class_SimplePie_HTTP_Parser {
	mut obj := &Class_SimplePie_HTTP_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
		http_version: rt.new_float(0)
		status_code: rt.new_int(0)
		reason: ''
		psr7Compatible: false
		headers: rt.new_array()
		body: rt.new_string('')
		state: rt.new_null()
		data: ''
		data_length: i64(0)
		position: rt.new_int(0)
		name: rt.new_string('')
		value: ''
	}
	obj.construct(data, psr7Compatible)
	return obj
}

fn (mut this Class_SimplePie_HTTP_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parse' {
			return rt.new_bool(this.parse())
		}
		'has_data' {
			return this.has_data()
		}
		'is_linear_whitespace' {
			return this.is_linear_whitespace()
		}
		'http_version' {
			this.http_version()
			return rt.new_null()
		}
		'status' {
			this.status()
			return rt.new_null()
		}
		'reason' {
			this.reason()
			return rt.new_null()
		}
		'add_header' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.add_header(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'replace_header' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.replace_header(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'new_line' {
			this.new_line()
			return rt.new_null()
		}
		'name' {
			this.name()
			return rt.new_null()
		}
		'linear_whitespace' {
			this.linear_whitespace()
			return rt.new_null()
		}
		'value' {
			this.value()
			return rt.new_null()
		}
		'value_char' {
			this.value_char()
			return rt.new_null()
		}
		'quote' {
			this.quote()
			return rt.new_null()
		}
		'quote_char' {
			this.quote_char()
			return rt.new_null()
		}
		'quote_escaped' {
			this.quote_escaped()
			return rt.new_null()
		}
		'body' {
			this.body()
			return rt.new_null()
		}
		'chunked' {
			this.chunked()
			return rt.new_null()
		}
		'prepareHeaders' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_SimplePie_HTTP_Parser.prepareheaders(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_HTTP_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'http_version' { return this.http_version }
		'status_code' { return this.status_code }
		'reason' { return rt.new_string(this.reason) }
		'psr7Compatible' { return rt.new_bool(this.psr7Compatible) }
		'headers' { return this.headers }
		'body' { return this.body }
		'state' { return this.state }
		'data' { return rt.new_string(this.data) }
		'data_length' { return rt.new_int(this.data_length) }
		'position' { return this.position }
		'name' { return this.name }
		'value' { return rt.new_string(this.value) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_HTTP_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'http_version' { this.http_version = val; return true }
		'status_code' { this.status_code = val; return true }
		'reason' { this.reason = (val).str(); return true }
		'psr7Compatible' { this.psr7Compatible = (val).to_bool(); return true }
		'headers' { this.headers = val; return true }
		'body' { this.body = val; return true }
		'state' { this.state = val; return true }
		'data' { this.data = (val).str(); return true }
		'data_length' { this.data_length = (val).to_i64(); return true }
		'position' { this.position = val; return true }
		'name' { this.name = val; return true }
		'value' { this.value = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_simplepie_src_http_parser_php() {
	// unsupported statement: Stmt_Declare
}

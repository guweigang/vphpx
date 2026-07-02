import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.sof() string {
	return '<SOF>'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.eof() string {
	return '<EOF>'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bang() string {
	return '!'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.dollar() string {
	return '$'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.amp() string {
	return '&'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_l() string {
	return '('
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_r() string {
	return ')'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.spread() string {
	return '...'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.colon() string {
	return ':'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.equals() string {
	return '='
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.at() string {
	return '@'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bracket_l() string {
	return '['
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bracket_r() string {
	return ']'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l() string {
	return '{'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.pipe() string {
	return '|'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_r() string {
	return '}'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name() string {
	return 'Name'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.int() string {
	return 'Int'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.float() string {
	return 'Float'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.string() string {
	return 'String'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.block_string() string {
	return 'BlockString'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.comment() string {
	return 'Comment'
}
struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token {
	rt.PhpObjectBase
pub mut:
		kind string
		start i64
		end i64
		line i64
		column i64
		value rt.PhpVal = rt.new_null()
		prev rt.PhpVal = rt.new_null()
		next rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) construct(kind string, start i64, end i64, line i64, column i64, mut var_previous Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Token, mut var_value Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string) {
	this.kind = kind
	this.start = start
	this.end = end
	this.line = line
	this.column = column
	this.prev = var_previous
	this.value = var_value
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) getdescription() string {
	return this.kind + if rt.is_true(rt.identical(this.value, rt.new_null())) { '' } else { rt.concat(rt.concat(rt.new_string(' "'), this.value), rt.new_string('"')) }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) toarray() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'kind', val: this.kind }, rt.ArrayItem{ key: 'value', val: this.value }, rt.ArrayItem{ key: 'line', val: this.line }, rt.ArrayItem{ key: 'column', val: this.column }])
}

fn create_automattic_woocommerce_vendor_graphql_language_token(kind string, start i64, end i64, line i64, column i64, arg_5 rt.PhpVal, arg_6 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token{
		PhpObjectBase: rt.PhpObjectBase{}
		kind: ''
		start: i64(0)
		end: i64(0)
		line: i64(0)
		column: i64(0)
		value: rt.new_null()
		prev: rt.new_null()
		next: rt.new_null()
	}
	obj.construct(kind, start, end, line, column, arg_5, arg_6)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Token](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](if args.len > 6 { args[6] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6)
			return rt.new_null()
		}
		'getDescription' {
			return rt.new_string(this.getdescription())
		}
		'toArray' {
			return this.toarray()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'kind' { return rt.new_string(this.kind) }
		'start' { return rt.new_int(this.start) }
		'end' { return rt.new_int(this.end) }
		'line' { return rt.new_int(this.line) }
		'column' { return rt.new_int(this.column) }
		'value' { return this.value }
		'prev' { return this.prev }
		'next' { return this.next }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'kind' { this.kind = (val).str(); return true }
		'start' { this.start = (val).to_i64(); return true }
		'end' { this.end = (val).to_i64(); return true }
		'line' { this.line = (val).to_i64(); return true }
		'column' { this.column = (val).to_i64(); return true }
		'value' { this.value = val; return true }
		'prev' { this.prev = val; return true }
		'next' { this.next = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}

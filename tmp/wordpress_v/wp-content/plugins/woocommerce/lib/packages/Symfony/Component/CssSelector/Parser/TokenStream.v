import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream {
	rt.PhpObjectBase
pub mut:
	tokens  rt.PhpVal = rt.new_array()
	used    rt.PhpVal = rt.new_array()
	cursor  rt.PhpVal = rt.new_int(0)
	peeked  rt.PhpVal = rt.new_null()
	peeking bool
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) push(mut var_token Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Token) rt.PhpVal {
	this.tokens.array_push(var_token.dup())
	return rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) freeze() rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) getnext() rt.PhpVal {
	if rt.is_true(this.peeking) {
		this.peeking = false
		this.used.array_push(this.peeked)
		return this.peeked
	}
	if !(this.tokens.array_isset(this.cursor)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_InternalErrorException',
			[]string{},
			create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_internalerrorexception(rt.new_string('Unexpected token stream end.'))))
	}
	return this.tokens.array_get(rt.post_inc(this.cursor))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) getpeek() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.peeking)))) {
		this.peeked = this.getnext()
		this.peeking = true
	}
	return this.peeked
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) getused() rt.PhpVal {
	return this.used
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) getnextidentifier() string {
	mut var_next := this.getnext()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_next, 'isIdentifier', []rt.PhpVal{}))))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp :=
				Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
			return temp.unexpectedtoken(arg_0, arg_1)
		}(rt.new_string('identifier'), var_next.dup()))
	}
	return (rt.call_method(var_next, 'getValue', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) getnextidentifierorstar() string {
	mut var_next := this.getnext()
	if rt.is_true(rt.call_method(var_next, 'isIdentifier', []rt.PhpVal{})) {
		return (rt.call_method(var_next, 'getValue', []rt.PhpVal{})).str()
	}
	if rt.is_true(rt.call_method(var_next, 'isDelimiter', [
		rt.create_array([rt.ArrayItem{ key: none, val: '*' }]),
	]))
	{
		return (rt.new_null()).str()
	}
	rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp :=
			Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
		return temp.unexpectedtoken(arg_0, arg_1)
	}(rt.new_string('identifier or "*"'), var_next.dup()))
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) skipwhitespace() {
	mut var_peek := this.getpeek()
	if rt.is_true(rt.call_method(var_peek, 'isWhitespace', []rt.PhpVal{})) {
		this.getnext()
	}
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_InternalErrorException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_tokenstream() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream{
		PhpObjectBase: rt.PhpObjectBase{}
		tokens:        rt.new_array()
		used:          rt.new_array()
		cursor:        rt.new_int(0)
		peeked:        rt.new_null()
		peeking:       false
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_internalerrorexception() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_InternalErrorException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_InternalErrorException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_syntaxerrorexception() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'push' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Token](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.push(mut dispatch_arg_0)
		}
		'freeze' {
			return this.freeze()
		}
		'getNext' {
			return this.getnext()
		}
		'getPeek' {
			return this.getpeek()
		}
		'getUsed' {
			return this.getused()
		}
		'getNextIdentifier' {
			return rt.new_string(this.getnextidentifier())
		}
		'getNextIdentifierOrStar' {
			return rt.new_string(this.getnextidentifierorstar())
		}
		'skipWhitespace' {
			this.skipwhitespace()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tokens' { return this.tokens }
		'used' { return this.used }
		'cursor' { return this.cursor }
		'peeked' { return this.peeked }
		'peeking' { return rt.new_bool(this.peeking) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tokens' {
			this.tokens = val
			return true
		}
		'used' {
			this.used = val
			return true
		}
		'cursor' {
			this.cursor = val
			return true
		}
		'peeked' {
			this.peeked = val
			return true
		}
		'peeking' {
			this.peeking = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_InternalErrorException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_InternalErrorException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_InternalErrorException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_parser_tokenstream_php() {
}

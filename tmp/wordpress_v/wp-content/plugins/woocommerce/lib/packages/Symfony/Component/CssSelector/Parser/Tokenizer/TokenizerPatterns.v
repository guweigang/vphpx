import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns {
	rt.PhpObjectBase
pub mut:
	unicodeEscapePattern string
	simpleEscapePattern  string
	newLineEscapePattern string
	escapePattern        rt.PhpVal = rt.new_null()
	stringEscapePattern  rt.PhpVal = rt.new_null()
	nonAsciiPattern      string
	nmCharPattern        rt.PhpVal = rt.new_null()
	nmStartPattern       rt.PhpVal = rt.new_null()
	identifierPattern    rt.PhpVal = rt.new_null()
	hashPattern          rt.PhpVal = rt.new_null()
	numberPattern        string
	quotedStringPattern  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) construct() {
	this.unicodeEscapePattern = '\\\\([0-9a-f]{1,6})(?:\\r\\n|[ \\n\\r\\t\\f])?'
	this.simpleEscapePattern = '\\\\(.)'
	this.newLineEscapePattern = '\\\\(?:\\n|\\r\\n|\\r|\\f)'
	this.escapePattern = this.unicodeEscapePattern + '|\\\\[^\\n\\r\\f0-9a-f]'
	this.stringEscapePattern = this.newLineEscapePattern + '|' + (this.escapePattern).str()
	this.nonAsciiPattern = '[^\\x00-\\x7F]'
	this.nmCharPattern = '[_a-z0-9-]|' + (this.escapePattern).str() + '|' + this.nonAsciiPattern
	this.nmStartPattern = '[_a-z]|' + (this.escapePattern).str() + '|' + this.nonAsciiPattern
	this.identifierPattern = '-?(?:' +
		(this.nmStartPattern).str() + ')(?:' + (this.nmCharPattern).str() + ')*'
	this.hashPattern = '#((?:' + (this.nmCharPattern).str() + ')+)'
	this.numberPattern = '[+-]?(?:[0-9]*\\.[0-9]+|[0-9]+)'
	this.quotedStringPattern = '([^\\n\\r\\f\\\\%s]|' + (this.stringEscapePattern).str() + ')*'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) getnewlineescapepattern() string {
	return '~' + this.newLineEscapePattern + '~'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) getsimpleescapepattern() string {
	return '~' + this.simpleEscapePattern + '~'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) getunicodeescapepattern() string {
	return '~' + this.unicodeEscapePattern + '~i'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) getidentifierpattern() string {
	return '~^' + (this.identifierPattern).str() + '~i'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) gethashpattern() string {
	return '~^' + (this.hashPattern).str() + '~i'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) getnumberpattern() string {
	return '~^' + this.numberPattern + '~'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) getquotedstringpattern(quote string) string {
	return '~^' +
		(rt.call_function('sprintf', [this.quotedStringPattern, rt.new_string(quote)])).str() + '~i'
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_tokenizer_tokenizerpatterns() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns{
		PhpObjectBase:        rt.PhpObjectBase{}
		unicodeEscapePattern: ''
		simpleEscapePattern:  ''
		newLineEscapePattern: ''
		escapePattern:        rt.new_null()
		stringEscapePattern:  rt.new_null()
		nonAsciiPattern:      ''
		nmCharPattern:        rt.new_null()
		nmStartPattern:       rt.new_null()
		identifierPattern:    rt.new_null()
		hashPattern:          rt.new_null()
		numberPattern:        ''
		quotedStringPattern:  rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'getNewLineEscapePattern' {
			return rt.new_string(this.getnewlineescapepattern())
		}
		'getSimpleEscapePattern' {
			return rt.new_string(this.getsimpleescapepattern())
		}
		'getUnicodeEscapePattern' {
			return rt.new_string(this.getunicodeescapepattern())
		}
		'getIdentifierPattern' {
			return rt.new_string(this.getidentifierpattern())
		}
		'getHashPattern' {
			return rt.new_string(this.gethashpattern())
		}
		'getNumberPattern' {
			return rt.new_string(this.getnumberpattern())
		}
		'getQuotedStringPattern' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.getquotedstringpattern(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'unicodeEscapePattern' { return rt.new_string(this.unicodeEscapePattern) }
		'simpleEscapePattern' { return rt.new_string(this.simpleEscapePattern) }
		'newLineEscapePattern' { return rt.new_string(this.newLineEscapePattern) }
		'escapePattern' { return this.escapePattern }
		'stringEscapePattern' { return this.stringEscapePattern }
		'nonAsciiPattern' { return rt.new_string(this.nonAsciiPattern) }
		'nmCharPattern' { return this.nmCharPattern }
		'nmStartPattern' { return this.nmStartPattern }
		'identifierPattern' { return this.identifierPattern }
		'hashPattern' { return this.hashPattern }
		'numberPattern' { return rt.new_string(this.numberPattern) }
		'quotedStringPattern' { return this.quotedStringPattern }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'unicodeEscapePattern' {
			this.unicodeEscapePattern = val.str()
			return true
		}
		'simpleEscapePattern' {
			this.simpleEscapePattern = val.str()
			return true
		}
		'newLineEscapePattern' {
			this.newLineEscapePattern = val.str()
			return true
		}
		'escapePattern' {
			this.escapePattern = val
			return true
		}
		'stringEscapePattern' {
			this.stringEscapePattern = val
			return true
		}
		'nonAsciiPattern' {
			this.nonAsciiPattern = val.str()
			return true
		}
		'nmCharPattern' {
			this.nmCharPattern = val
			return true
		}
		'nmStartPattern' {
			this.nmStartPattern = val
			return true
		}
		'identifierPattern' {
			this.identifierPattern = val
			return true
		}
		'hashPattern' {
			this.hashPattern = val
			return true
		}
		'numberPattern' {
			this.numberPattern = val.str()
			return true
		}
		'quotedStringPattern' {
			this.quotedStringPattern = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_parser_tokenizer_tokenizerpatterns_php() {
}

import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader {
	rt.PhpObjectBase
pub mut:
	source   string
	length   i64
	position rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) construct(source string) {
	mut source_mutated := source
	this.source = (rt.new_string(source_mutated)).str()
	this.length = source_mutated.len
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) iseof() bool {
	return (rt.greater_equal(this.position, this.length)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) getposition() i64 {
	return (this.position).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) getremaininglength() i64 {
	return (rt.sub(this.length, this.position)).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) getsubstring(length i64, offset i64) string {
	return (rt.call_function('substr', [this.source, rt.add(this.position, rt.new_int(offset)),
		rt.new_int(length)])).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) getoffset(string string) rt.PhpVal {
	mut var_position := rt.call_function('strpos', [this.source, rt.new_string(string),
		this.position])
	return if rt.is_true(rt.identical(rt.new_bool(false), var_position)) {
		rt.new_bool(false)
	} else {
		rt.sub(var_position, this.position)
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) findpattern(pattern string) bool {
	mut var_matches := rt.new_null()
	mut var_source := rt.call_function('substr', [this.source, this.position])
	if rt.is_true(rt.call_function('preg_match', [rt.new_string(pattern),
		var_source.dup(), var_matches.dup()]))
	{
		return var_matches.to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) moveforward(length i64) {
	// unsupported expression: Expr_AssignOp_Plus
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) movetoend() {
	this.position = this.length
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_reader(source string) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader{
		PhpObjectBase: rt.PhpObjectBase{}
		source:        ''
		length:        i64(0)
		position:      rt.new_int(0)
	}
	obj.construct(source)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'isEOF' {
			return rt.new_bool(this.iseof())
		}
		'getPosition' {
			return rt.new_int(this.getposition())
		}
		'getRemainingLength' {
			return rt.new_int(this.getremaininglength())
		}
		'getSubstring' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.getsubstring(dispatch_arg_0, dispatch_arg_1))
		}
		'getOffset' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getoffset(dispatch_arg_0)
		}
		'findPattern' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.findpattern(dispatch_arg_0))
		}
		'moveForward' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.moveforward(dispatch_arg_0)
			return rt.new_null()
		}
		'moveToEnd' {
			this.movetoend()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'source' { return rt.new_string(this.source) }
		'length' { return rt.new_int(this.length) }
		'position' { return this.position }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'source' {
			this.source = val.str()
			return true
		}
		'length' {
			this.length = val.to_i64()
			return true
		}
		'position' {
			this.position = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_parser_reader_php() {
}

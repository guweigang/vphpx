import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken {
	rt.PhpObjectBase
pub mut:
		id i64
		text string
		line i64
		pos i64
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken) construct(id i64, text string, line i64, position i64)  {
	mut id_mutated := id
	mut text_mutated := text
	mut line_mutated := line
	mut position_mutated := position
	this.id = (rt.new_int(id_mutated)).to_i64()
	this.text = (rt.new_string(text_mutated)).str()
	this.line = (rt.new_int(line_mutated)).to_i64()
	this.pos = (rt.new_int(position_mutated)).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken) gettokenname() string {
	if rt.is_true(rt.identical(rt.new_string('UNKNOWN'), mut var_name := rt.call_function('token_name', [this.id]))) {
		var_name = if rt.is_true(rt.new_bool(this.text.len > 1 || rt.is_true(rt.less(rt.call_function('ord', [this.text]), rt.new_int(32))))) { rt.new_null() } else { this.text }
	}
	return (var_name).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken) is(var_kind rt.PhpVal) bool {
	{
		mut iter_1 := rt.cast_array(var_kind).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if rt.is_true(rt.call_function('in_array', [var_value.dup(), rt.create_array([rt.ArrayItem{ key: none, val: this.id }, rt.ArrayItem{ key: none, val: this.text }]), rt.new_bool(true)])) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken) isignorable() bool {
	return (rt.call_function('in_array', [this.id, rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('T_WHITESPACE') }, rt.ArrayItem{ key: none, val: rt.get_constant('T_COMMENT') }, rt.ArrayItem{ key: none, val: rt.get_constant('T_DOC_COMMENT') }, rt.ArrayItem{ key: none, val: rt.get_constant('T_OPEN_TAG') }]), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken) magic_tostring() string {
	return (// unsupported expression: Expr_Cast_String).str()
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken.tokenize(code string, flags i64) rt.PhpVal {
	mut var_line := rt.new_int(rt.new_int(1))
	mut var_position := rt.new_int(rt.new_int(0))
	mut var_tokens := rt.call_function('token_get_all', [rt.new_string(code), rt.new_int(flags)])
	{
		mut iter_1 := var_tokens.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_token := item_1.val
			mut var_index := item_1.key
			if rt.is_true(rt.new_bool(var_token.dup().is_string())) {
				mut var_id := rt.call_function('ord', [var_token.dup()])
				mut var_text := var_token
			} else {
				// unsupported assign target: Expr_List
			}
			var_tokens.array_set(var_index, create_automattic_woocommerce_vendor_symfony_polyfill_php80_static(var_id.dup(), var_text.dup(), var_line.dup(), var_position.dup()))
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	return var_tokens.dup()
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_static {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_polyfill_php80_phptoken(id i64, text string, line i64, position i64) &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken{
		PhpObjectBase: rt.PhpObjectBase{}
		id: i64(0)
		text: ''
		line: i64(0)
		pos: i64(0)
	}
	obj.construct(id, text, line, position)
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_polyfill_php80_static() &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'getTokenName' {
			return rt.new_string(this.gettokenname())
		}
		'is' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is(dispatch_arg_0))
		}
		'isIgnorable' {
			return rt.new_bool(this.isignorable())
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'tokenize' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken.tokenize(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return rt.new_int(this.id) }
		'text' { return rt.new_string(this.text) }
		'line' { return rt.new_int(this.line) }
		'pos' { return rt.new_int(this.pos) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' { this.id = (val).to_i64(); return true }
		'text' { this.text = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		'pos' { this.pos = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_polyfill_php80_phptoken_php() {
}

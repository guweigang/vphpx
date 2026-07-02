import rt

struct Class_WP_Block_Parser_Frame {
	rt.PhpObjectBase
pub mut:
	block              rt.PhpVal = rt.new_null()
	token_start        rt.PhpVal = rt.new_null()
	token_length       rt.PhpVal = rt.new_null()
	prev_offset        rt.PhpVal = rt.new_null()
	leading_html_start rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Block_Parser_Frame) construct(var_block rt.PhpVal, var_token_start rt.PhpVal, var_token_length rt.PhpVal, var_prev_offset rt.PhpVal, var_leading_html_start rt.PhpVal) {
	this.block = var_block.clone()
	this.token_start = var_token_start.clone()
	this.token_length = var_token_length.clone()
	this.prev_offset = if !var_prev_offset.is_null() {
		var_prev_offset
	} else {
		rt.add(var_token_start, var_token_length)
	}
	this.leading_html_start = var_leading_html_start.clone()
}

fn create_wp_block_parser_frame(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) &Class_WP_Block_Parser_Frame {
	mut obj := &Class_WP_Block_Parser_Frame{
		PhpObjectBase:      rt.PhpObjectBase{}
		block:              rt.new_null()
		token_start:        rt.new_null()
		token_length:       rt.new_null()
		prev_offset:        rt.new_null()
		leading_html_start: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4)
	return obj
}

fn (mut this Class_WP_Block_Parser_Frame) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Block_Parser_Frame) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block' { return this.block }
		'token_start' { return this.token_start }
		'token_length' { return this.token_length }
		'prev_offset' { return this.prev_offset }
		'leading_html_start' { return this.leading_html_start }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Parser_Frame) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block' {
			this.block = val
			return true
		}
		'token_start' {
			this.token_start = val
			return true
		}
		'token_length' {
			this.token_length = val
			return true
		}
		'prev_offset' {
			this.prev_offset = val
			return true
		}
		'leading_html_start' {
			this.leading_html_start = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

struct Class_WP_Block_Parser_Block {
	rt.PhpObjectBase
pub mut:
	blockName    rt.PhpVal = rt.new_null()
	attrs        rt.PhpVal = rt.new_null()
	innerBlocks  rt.PhpVal = rt.new_null()
	innerHTML    rt.PhpVal = rt.new_null()
	innerContent rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Block_Parser_Block) construct(var_name rt.PhpVal, var_attrs rt.PhpVal, var_inner_blocks rt.PhpVal, var_inner_html rt.PhpVal, var_inner_content rt.PhpVal) {
	this.blockName = var_name.clone()
	this.attrs = var_attrs.clone()
	this.innerBlocks = var_inner_blocks.clone()
	this.innerHTML = var_inner_html.clone()
	this.innerContent = var_inner_content.clone()
}

fn create_wp_block_parser_block(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) &Class_WP_Block_Parser_Block {
	mut obj := &Class_WP_Block_Parser_Block{
		PhpObjectBase: rt.PhpObjectBase{}
		blockName:     rt.new_null()
		attrs:         rt.new_null()
		innerBlocks:   rt.new_null()
		innerHTML:     rt.new_null()
		innerContent:  rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4)
	return obj
}

fn (mut this Class_WP_Block_Parser_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_Block_Parser_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'blockName' { return this.blockName }
		'attrs' { return this.attrs }
		'innerBlocks' { return this.innerBlocks }
		'innerHTML' { return this.innerHTML }
		'innerContent' { return this.innerContent }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Parser_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'blockName' {
			this.blockName = val
			return true
		}
		'attrs' {
			this.attrs = val
			return true
		}
		'innerBlocks' {
			this.innerBlocks = val
			return true
		}
		'innerHTML' {
			this.innerHTML = val
			return true
		}
		'innerContent' {
			this.innerContent = val
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

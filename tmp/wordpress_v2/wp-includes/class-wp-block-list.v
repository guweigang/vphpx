import rt

struct Class_WP_Block_List {
	rt.PhpObjectBase
pub mut:
	blocks            rt.PhpVal = rt.new_null()
	available_context rt.PhpVal = rt.new_null()
	registry          rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Block_List) construct(var_blocks rt.PhpVal, var_available_context rt.PhpVal, var_registry rt.PhpVal) {
	mut var_registry_mutated := var_registry
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_registry_mutated,
		'WP_Block_Type_Registry'))))))
	{
		mut iife_temp_0 := Class_WP_Block_Type_Registry{}
		mut iife_result_0 := iife_temp_0.get_instance()
		var_registry_mutated = iife_result_0
	}
	this.blocks = var_blocks.clone()
	this.available_context = var_available_context.clone()
	this.registry = var_registry_mutated.clone()
}

fn (mut this Class_WP_Block_List) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.blocks.array_isset(var_offset))
}

fn (mut this Class_WP_Block_List) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	mut var_block := this.blocks.array_get(var_offset)
	if !var_block.is_null() && var_block.clone().is_array() {
		var_block = create_wp_block(var_block.clone(), this.available_context, this.registry)
		this.blocks.array_set(var_offset, var_block.clone())
	}
	return var_block.clone()
}

fn (mut this Class_WP_Block_List) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.new_bool(var_offset.clone().is_null())) {
		this.blocks.array_push(var_value.clone())
	} else {
		this.blocks.array_set(var_offset, var_value.clone())
	}
}

fn (mut this Class_WP_Block_List) offsetunset(var_offset rt.PhpVal) {
	this.blocks.array_unset(var_offset)
}

fn (mut this Class_WP_Block_List) rewind() {
	rt.call_function('reset', [this.blocks])
}

fn (mut this Class_WP_Block_List) current() rt.PhpVal {
	return this.offsetget(this.key())
}

fn (mut this Class_WP_Block_List) key() rt.PhpVal {
	return rt.call_function('key', [this.blocks])
}

fn (mut this Class_WP_Block_List) next() {
	rt.call_function('next', [this.blocks])
}

fn (mut this Class_WP_Block_List) valid() bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.call_function('key', [
		this.blocks,
	]))))
}

fn (mut this Class_WP_Block_List) count() i64 {
	return this.blocks.array_count()
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

fn create_wp_block_list(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Block_List {
	mut obj := &Class_WP_Block_List{
		PhpObjectBase:     rt.PhpObjectBase{}
		blocks:            rt.new_null()
		available_context: rt.new_null()
		registry:          rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block(_args ...rt.PhpVal) &Class_WP_Block {
	mut obj := &Class_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_List) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetexists(dispatch_arg_0)
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'rewind' {
			this.rewind()
			return rt.new_null()
		}
		'current' {
			return this.current()
		}
		'key' {
			return this.key()
		}
		'next' {
			this.next()
			return rt.new_null()
		}
		'valid' {
			return rt.new_bool(this.valid())
		}
		'count' {
			return rt.new_int(this.count())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Block_List) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'blocks' { return this.blocks }
		'available_context' { return this.available_context }
		'registry' { return this.registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_List) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'blocks' {
			this.blocks = val
			return true
		}
		'available_context' {
			this.available_context = val
			return true
		}
		'registry' {
			this.registry = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

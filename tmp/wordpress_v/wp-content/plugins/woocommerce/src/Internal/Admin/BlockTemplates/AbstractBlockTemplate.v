import rt

struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate {
	rt.PhpObjectBase
pub mut:
		block_cache rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) get_id() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) get_title() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) get_description() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) get_area() string {
	return 'uncategorized'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) get_block(block_id string) rt.PhpVal {
	mut block_id_mutated := block_id
	return if !(this.block_cache.array_get(block_id_mutated)).is_null() { this.block_cache.array_get(block_id_mutated) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) cache_block(mut var_block Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface)  {
	mut var_id := var_block.get_id()
	if this.block_cache.array_isset(var_id) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError', []string{}, create_automattic_woocommerce_internal_admin_blocktemplates_valueerror(rt.new_string('A block with the specified ID already exists in the template.'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError', []string{}, create_automattic_woocommerce_internal_admin_blocktemplates_valueerror(rt.new_string('The block template that the block belongs to must be the same as this template.'))))
	}
	this.block_cache.array_set(var_id, var_block.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) uncache_block(block_id string)  {
	mut block_id_mutated := block_id
	if this.block_cache.array_isset(rt.new_string(block_id_mutated)) {
		this.block_cache.array_unset(rt.new_string(block_id_mutated))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) generate_block_id(id_base string) string {
	mut var_instance_count := rt.new_int(rt.new_int(0))
	for {
		rt.post_inc(var_instance_count)
		mut var_block_id := rt.new_string(id_base + '-' + (var_instance_count).str())
		if !(this.block_cache.array_isset(var_block_id)) {
			break
		}
	}
	return (var_block_id).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) get_root_template() rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) get_formatted_template() rt.PhpVal {
	mut var_inner_blocks := this.get_inner_blocks_sorted_by_order()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_block := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_block.get_formatted_template()
	}
	mut var_block := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_block.get_formatted_template()
	}
	mut var_inner_blocks_formatted_template := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_inner_blocks.dup()])
	return var_inner_blocks_formatted_template.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) to_json() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_id() }, rt.ArrayItem{ key: 'title', val: this.get_title() }, rt.ArrayItem{ key: 'description', val: this.get_description() }, rt.ArrayItem{ key: 'area', val: this.get_area() }, rt.ArrayItem{ key: 'blockTemplates', val: this.get_formatted_template() }])
}

struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_abstractblocktemplate() &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
		block_cache: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_valueerror() &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_title' {
			return rt.new_string(this.get_title())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_area' {
			return rt.new_string(this.get_area())
		}
		'get_block' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_block(dispatch_arg_0)
		}
		'cache_block' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			this.cache_block(mut dispatch_arg_0)
			return rt.new_null()
		}
		'uncache_block' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.uncache_block(dispatch_arg_0)
			return rt.new_null()
		}
		'generate_block_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.generate_block_id(dispatch_arg_0))
		}
		'get_root_template' {
			return this.get_root_template()
		}
		'get_formatted_template' {
			return this.get_formatted_template()
		}
		'to_json' {
			return this.to_json()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_cache' { return this.block_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_cache' { this.block_cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_blocktemplates_abstractblocktemplate_php() {
}

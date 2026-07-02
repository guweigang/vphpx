import rt

struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplate) get_id() string {
	return 'woocommerce-block-template'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplate) add_block(mut var_block_config Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array) rt.PhpVal {
	mut var_block := create_automattic_woocommerce_internal_admin_blocktemplates_block(var_block_config,
		this.get_root_template(), rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplate', [
		'Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate',
	], &this))
	return this.add_inner_block(rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_Block',
		[]string{}, var_block))
}

struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Block {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_blocktemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_abstractblocktemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_block(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Block {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'add_block' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_block(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

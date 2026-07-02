import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
pub mut:
	is_lazy_loaded rt.PhpVal = rt.new_bool(true)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) register_block_type() {
	mut var_block_settings := rt.create_array([
		rt.ArrayItem{ key: 'render_callback', val: this.get_block_type_render_callback() },
		rt.ArrayItem{ key: 'editor_style', val: this.get_block_type_editor_style() },
		rt.ArrayItem{ key: 'style', val: this.get_block_type_style() },
	])
	if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'api_version')).is_null() {
		var_block_settings.array_set('api_version', rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'api_version').to_i64())
	}
	mut var_metadata_path := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_api'), 'get_block_metadata_path', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'block_name'),
		rt.new_string('inner-blocks/'),
	])
	rt.call_function('register_block_type_from_metadata', [var_metadata_path.clone(),
		var_block_settings.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(this.is_lazy_loaded) {
		return rt.new_null()
	}
	return this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_script(var_key.clone())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractinnerblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock{
		PhpObjectBase:  rt.PhpObjectBase{}
		is_lazy_loaded: rt.new_bool(true)
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_block_type' {
			this.register_block_type()
			return rt.new_null()
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'is_lazy_loaded' { return this.is_lazy_loaded }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'is_lazy_loaded' {
			this.is_lazy_loaded = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

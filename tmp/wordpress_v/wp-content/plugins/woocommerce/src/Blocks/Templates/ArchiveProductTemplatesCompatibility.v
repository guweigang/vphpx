import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility.loop_item_id() string {
	return 'product-loop-item'
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility {
	rt.PhpObjectBase
pub mut:
	hook_data rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) update_render_block_data(var_parsed_block rt.PhpVal, var_source_block rt.PhpVal, var_parent_block rt.PhpVal) rt.PhpVal {
	if !(this.is_archive_template()) {
		return var_parsed_block.dup()
	}
	if rt.is_true(var_parent_block) {
		return var_parsed_block.dup()
	}
	this.inner_blocks_walker(var_parsed_block.dup())
	return var_parsed_block.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) inject_hooks(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if !(this.is_archive_template()) {
		return var_block_content.dup()
	}
	if !rt.is_true(var_block.array_get('attrs').array_get('isInherited')) {
		return var_block_content.dup()
	}
	mut var_block_name := var_block.array_get('blockName')
	if this.is_null_post_template(var_block.dup()) {
		var_block_name =
			Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility.loop_item_id()
	}
	closure_1_fn := fn [var_block_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_hook := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return rt.call_function('in_array', [var_block_name.dup(),
			var_hook.array_get('block_names'), rt.new_bool(true)])
	}
	mut var_block_hooks := rt.call_function('array_filter', [this.hook_data,
		rt.new_closure(closure_1_fn)])
	if this.is_post_or_product_template(var_block_name.dup()) && !(!rt.is_true(var_block_content)) {
		this.restore_default_hooks()
		mut var_content := rt.call_function('sprintf', [rt.new_string('%1$s%2$s%3$s'),
			this.get_hooks_buffer(var_block_hooks.dup(), rt.new_string('before')),
			var_block_content.dup(), this.get_hooks_buffer(var_block_hooks.dup(),
				rt.new_string('after'))])
		this.remove_default_hooks()
		return var_content.dup()
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_hook := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return var_hook.array_get('block_names')
		}
		mut var_hook := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return var_hook.array_get('block_names')
	}
	mut var_supported_blocks := rt.call_function('array_merge', [
		rt.new_array(),
		rt.call_function('array_map', [rt.new_closure(closure_2_fn),
			rt.call_function('array_values', [this.hook_data])])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_block_name.dup(), var_supported_blocks.dup(), rt.new_bool(true)])))))
	{
		return var_block_content.dup()
	}
	if rt.is_true(rt.identical(rt.new_string('core/query-no-results'), var_block_name)) {
		if var_block_content.dup().to_string().trim_space() == '' {
			return var_block_content.dup()
		}
		this.restore_default_hooks()
		var_content = rt.call_function('sprintf', [rt.new_string('%1$s%2$s%3$s'),
			this.get_hooks_buffer(var_block_hooks.dup(), rt.new_string('before')),
			var_block_content.dup(), this.get_hooks_buffer(var_block_hooks.dup(),
				rt.new_string('after'))])
		this.remove_default_hooks()
		return var_content.dup()
	}
	if !rt.is_true(var_block_content) {
		return var_block_content.dup()
	}
	return rt.call_function('sprintf', [rt.new_string('%1$s%2$s%3$s'),
		this.get_hooks_buffer(var_block_hooks.dup(), rt.new_string('before')),
		var_block_content.dup(), this.get_hooks_buffer(var_block_hooks.dup(), rt.new_string('after'))])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) set_hook_data() {
	this.hook_data = rt.create_array([
		rt.ArrayItem{ key: 'woocommerce_before_main_content', val: rt.create_array([
			rt.ArrayItem{ key: 'block_names', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/query' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-collection' },
			]) },
			rt.ArrayItem{ key: 'position', val: 'before' },
			rt.ArrayItem{ key: 'hooked', val: rt.create_array([
				rt.ArrayItem{ key: 'woocommerce_output_content_wrapper', val: 10 },
				rt.ArrayItem{ key: 'woocommerce_breadcrumb', val: 20 },
			]) },
		]) },
		rt.ArrayItem{ key: 'woocommerce_after_main_content', val: rt.create_array([
			rt.ArrayItem{ key: 'block_names', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/query' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-collection' },
			]) },
			rt.ArrayItem{ key: 'position', val: 'after' },
			rt.ArrayItem{ key: 'hooked', val: rt.create_array([
				rt.ArrayItem{ key: 'woocommerce_output_content_wrapper_end', val: 10 },
			]) },
		]) },
		rt.ArrayItem{ key: 'woocommerce_before_shop_loop_item_title', val: rt.create_array([
			rt.ArrayItem{ key: 'block_names', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/post-title' },
			]) },
			rt.ArrayItem{ key: 'position', val: 'before' },
			rt.ArrayItem{ key: 'hooked', val: rt.create_array([
				rt.ArrayItem{ key: 'woocommerce_show_product_loop_sale_flash', val: 10 },
				rt.ArrayItem{ key: 'woocommerce_template_loop_product_thumbnail', val: 10 },
			]) },
		]) },
		rt.ArrayItem{ key: 'woocommerce_shop_loop_item_title', val: rt.create_array([
			rt.ArrayItem{ key: 'block_names', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/post-title' },
			]) },
			rt.ArrayItem{ key: 'position', val: 'after' },
			rt.ArrayItem{ key: 'hooked', val: rt.create_array([
				rt.ArrayItem{ key: 'woocommerce_template_loop_product_title', val: 10 },
			]) },
		]) },
		rt.ArrayItem{ key: 'woocommerce_after_shop_loop_item_title', val: rt.create_array([
			rt.ArrayItem{ key: 'block_names', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/post-title' },
			]) },
			rt.ArrayItem{ key: 'position', val: 'after' },
			rt.ArrayItem{ key: 'hooked', val: rt.create_array([
				rt.ArrayItem{ key: 'woocommerce_template_loop_rating', val: 5 },
				rt.ArrayItem{ key: 'woocommerce_template_loop_price', val: 10 },
			]) },
		]) },
		rt.ArrayItem{ key: 'woocommerce_before_shop_loop_item', val: rt.create_array([
			rt.ArrayItem{ key: 'block_names', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility.loop_item_id()
				},
			]) },
			rt.ArrayItem{ key: 'position', val: 'before' },
			rt.ArrayItem{ key: 'hooked', val: rt.create_array([
				rt.ArrayItem{ key: 'woocommerce_template_loop_product_link_open', val: 10 },
			]) },
		]) },
		rt.ArrayItem{ key: 'woocommerce_after_shop_loop_item', val: rt.create_array([
			rt.ArrayItem{ key: 'block_names', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility.loop_item_id()
				},
			]) },
			rt.ArrayItem{ key: 'position', val: 'after' },
			rt.ArrayItem{ key: 'hooked', val: rt.create_array([
				rt.ArrayItem{ key: 'woocommerce_template_loop_product_link_close', val: 5 },
				rt.ArrayItem{ key: 'woocommerce_template_loop_add_to_cart', val: 10 },
			]) },
		]) },
		rt.ArrayItem{ key: 'woocommerce_before_shop_loop', val: rt.create_array([
			rt.ArrayItem{ key: 'block_names', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/post-template' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
			]) },
			rt.ArrayItem{ key: 'position', val: 'before' },
			rt.ArrayItem{ key: 'hooked', val: rt.create_array([
				rt.ArrayItem{ key: 'woocommerce_output_all_notices', val: 10 },
				rt.ArrayItem{ key: 'woocommerce_result_count', val: 20 },
				rt.ArrayItem{ key: 'woocommerce_catalog_ordering', val: 30 },
			]) },
			rt.ArrayItem{ key: 'permanently_removed_actions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce_output_all_notices' },
				rt.ArrayItem{ key: none, val: 'woocommerce_result_count' },
				rt.ArrayItem{ key: none, val: 'woocommerce_catalog_ordering' },
			]) },
		]) },
		rt.ArrayItem{ key: 'woocommerce_after_shop_loop', val: rt.create_array([
			rt.ArrayItem{ key: 'block_names', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/post-template' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
			]) },
			rt.ArrayItem{ key: 'position', val: 'after' },
			rt.ArrayItem{ key: 'hooked', val: rt.create_array([
				rt.ArrayItem{ key: 'woocommerce_pagination', val: 10 },
			]) },
			rt.ArrayItem{ key: 'permanently_removed_actions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce_pagination' },
			]) },
		]) },
		rt.ArrayItem{ key: 'woocommerce_no_products_found', val: rt.create_array([
			rt.ArrayItem{ key: 'block_names', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/query-no-results' },
			]) },
			rt.ArrayItem{ key: 'position', val: 'before' },
			rt.ArrayItem{ key: 'hooked', val: rt.create_array([
				rt.ArrayItem{ key: 'wc_no_products_found', val: 10 },
			]) },
			rt.ArrayItem{ key: 'permanently_removed_actions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wc_no_products_found' },
			]) },
		]) },
		rt.ArrayItem{ key: 'woocommerce_archive_description', val: rt.create_array([
			rt.ArrayItem{ key: 'block_names', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/term-description' },
			]) },
			rt.ArrayItem{ key: 'position', val: 'before' },
			rt.ArrayItem{ key: 'hooked', val: rt.create_array([
				rt.ArrayItem{ key: 'woocommerce_taxonomy_archive_description', val: 10 },
				rt.ArrayItem{ key: 'woocommerce_product_archive_description', val: 10 },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) is_archive_template() bool {
	return rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{}))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) inner_blocks_walker(var_block rt.PhpVal) {
	if this.is_products_block_with_inherit_query(var_block.dup())
		|| this.is_product_collection_block_with_inherit_query(var_block.dup()) {
		this.inject_attribute(var_block.dup())
		this.remove_default_hooks()
	}
	if !(!rt.is_true(var_block.array_get('innerBlocks'))) {
		rt.call_function('array_walk', [var_block.array_get('innerBlocks'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility', [
					'Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility',
				], &this) },
				rt.ArrayItem{ key: none, val: 'inner_blocks_walker' },
			])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) restore_default_hooks() {
	{
		mut iter_1 := this.hook_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_hook := item_1.key
			if !(var_data.array_isset(rt.new_string('hooked'))) {
				continue
			}
			{
				mut iter_2 := var_data.array_get('hooked').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_priority := item_2.val
					mut var_callback := item_2.key
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
						var_callback.dup(),
						if !(var_data.array_get('permanently_removed_actions')).is_null() {
							var_data.array_get('permanently_removed_actions')
						} else {
							rt.new_array()
						},
						rt.new_bool(true),
					])))))
					{
						rt.call_function('add_action', [var_hook.dup(),
							var_callback.dup(), var_priority.dup()])
					}
				}
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) is_block_within_namespace(var_block rt.PhpVal) bool {
	mut var_attributes := var_block.array_get('attrs')
	return var_attributes.array_isset(rt.new_string('__woocommerceNamespace'))
		&& rt.is_true(rt.identical(rt.new_string('woocommerce/product-query/product-template'), var_attributes.array_get('__woocommerceNamespace')))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) is_block_inherited(var_block rt.PhpVal) rt.PhpVal {
	mut var_attributes := var_block.array_get('attrs')
	mut var_outcome := rt.new_bool(rt.new_bool(
		var_attributes.array_isset(rt.new_string('isInherited'))
		&& rt.is_true(rt.identical(rt.new_int(1), var_attributes.array_get('isInherited')))))
	return var_outcome.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) is_null_post_template(var_block rt.PhpVal) bool {
	mut var_block_name := var_block.array_get('blockName')
	return rt.is_true(rt.identical(rt.new_string('core/null'), var_block_name))
		&& rt.is_true(rt.new_bool(rt.is_true(this.is_block_inherited(var_block.dup()))
		|| this.is_block_within_namespace(var_block.dup())))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) is_post_template(var_block_name rt.PhpVal) rt.PhpVal {
	mut var_block_name_mutated := var_block_name
	return rt.identical(rt.new_string('core/post-template'), var_block_name_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) is_product_template(var_block_name rt.PhpVal) rt.PhpVal {
	mut var_block_name_mutated := var_block_name
	return rt.identical(rt.new_string('woocommerce/product-template'), var_block_name_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) is_post_or_product_template(var_block_name rt.PhpVal) bool {
	mut var_block_name_mutated := var_block_name
	return rt.is_true(this.is_post_template(var_block_name_mutated.dup()))
		|| rt.is_true(this.is_product_template(var_block_name_mutated.dup()))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) is_products_block_with_inherit_query(var_block rt.PhpVal) bool {
	return
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core/query'), var_block.array_get('blockName')))
		&& var_block.array_get('attrs').array_isset(rt.new_string('namespace'))))
		&& rt.is_true(rt.identical(rt.new_string('woocommerce/product-query'), var_block.array_get('attrs').array_get('namespace')))))
		&& var_block.array_get('attrs').array_get('query').array_isset(rt.new_string('inherit'))))
		&& rt.is_true(var_block.array_get('attrs').array_get('query').array_get('inherit'))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) is_product_collection_block_with_inherit_query(var_block rt.PhpVal) bool {
	return
		rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('woocommerce/product-collection'), var_block.array_get('blockName')))
		&& var_block.array_get('attrs').array_get('query').array_isset(rt.new_string('inherit'))))
		&& rt.is_true(var_block.array_get('attrs').array_get('query').array_get('inherit'))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) inject_attribute(var_block rt.PhpVal) {
	var_block.array_get_mut('attrs').array_set('isInherited', 1)
	if !(!rt.is_true(var_block.array_get('innerBlocks'))) {
		rt.call_function('array_walk', [var_block.array_get('innerBlocks'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility', [
					'Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility',
				], &this) },
				rt.ArrayItem{ key: none, val: 'inject_attribute' },
			])])
	}
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_archiveproducttemplatescompatibility() &Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility{
		PhpObjectBase: rt.PhpObjectBase{}
		hook_data:     rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplatecompatibility() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'update_render_block_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.update_render_block_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'inject_hooks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.inject_hooks(dispatch_arg_0, dispatch_arg_1)
		}
		'set_hook_data' {
			this.set_hook_data()
			return rt.new_null()
		}
		'is_archive_template' {
			return rt.new_bool(this.is_archive_template())
		}
		'inner_blocks_walker' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.inner_blocks_walker(dispatch_arg_0)
			return rt.new_null()
		}
		'restore_default_hooks' {
			this.restore_default_hooks()
			return rt.new_null()
		}
		'is_block_within_namespace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_block_within_namespace(dispatch_arg_0))
		}
		'is_block_inherited' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_block_inherited(dispatch_arg_0)
		}
		'is_null_post_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_null_post_template(dispatch_arg_0))
		}
		'is_post_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_post_template(dispatch_arg_0)
		}
		'is_product_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_product_template(dispatch_arg_0)
		}
		'is_post_or_product_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_post_or_product_template(dispatch_arg_0))
		}
		'is_products_block_with_inherit_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_products_block_with_inherit_query(dispatch_arg_0))
		}
		'is_product_collection_block_with_inherit_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_product_collection_block_with_inherit_query(dispatch_arg_0))
		}
		'inject_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.inject_attribute(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'hook_data' { return this.hook_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'hook_data' {
			this.hook_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_archiveproducttemplatescompatibility_php() {
}

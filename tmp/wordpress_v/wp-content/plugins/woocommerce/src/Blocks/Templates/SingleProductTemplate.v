import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.slug() string {
	return 'single-product'
}

struct Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate) init() {
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate', [
				'Automattic_WooCommerce_Blocks_Templates_AbstractTemplate',
			], &this) },
			rt.ArrayItem{ key: none, val: 'render_block_template' },
		])])
	rt.call_function('add_filter', [rt.new_string('get_block_templates'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate', [
				'Automattic_WooCommerce_Blocks_Templates_AbstractTemplate',
			], &this) },
			rt.ArrayItem{ key: none, val: 'update_single_product_content' },
		]),
		rt.new_int(11), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate) get_template_title() rt.PhpVal {
	return rt.call_function('_x', [rt.new_string('Single Product'),
		rt.new_string('Template name'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate) get_template_description() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Displays a single product.'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate) render_block_template() {
	mut var_post := rt.new_null()
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_embed', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('is_singular', [rt.new_string('product')]))))
	{
		// unsupported statement: Stmt_Global
		mut var_compatibility_layer :=
			create_automattic_woocommerce_blocks_templates_singleproducttemplatecompatibility()
		var_compatibility_layer.init()
		mut var_valid_slugs := rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.slug()
			},
		])
		mut var_single_product_slug := rt.new_string(if rt.is_true(rt.new_bool(
			rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post, 'post_type')))
			&& rt.is_true(rt.get_property(var_post, 'post_name'))))
		{
			'single-product-' + (rt.get_property(var_post, 'post_name')).str()
		} else {
			rt.new_string('')
		})
		if rt.is_true(var_single_product_slug) {
			var_valid_slugs.array_push('single-product-' +
				(rt.get_property(var_post, 'post_name')).str())
		}
		mut var_templates := rt.call_function('get_block_templates', [
			rt.create_array([rt.ArrayItem{ key: 'slug__in', val: var_valid_slugs }]),
		])
		if var_templates.dup().array_count() == 0 {
			return rt.new_null()
		}
		mut var_template := rt.call_function('reset', [var_templates.dup()])
		if var_valid_slugs.dup().array_count() > 1 && var_templates.dup().array_count() > 1 {
			{
				mut iter_1 := var_templates.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_t := item_1.val
					if rt.is_true(rt.identical(var_single_product_slug, rt.get_property(var_t,
						'slug')))
					{
						var_template = var_t
						break
					}
				}
			}
		}
		if rt.is_true(rt.new_bool(!var_template.is_null() && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
			return temp.template_has_legacy_template_block(arg_0)
		}(var_template.dup()))))
		{
			rt.call_function('add_filter', [
				rt.new_string('woocommerce_disable_compatibility_layer'),
				rt.new_string('__return_true'),
			])
		}
		mut var_product := rt.call_function('wc_get_product', [
			rt.get_property(var_post, 'ID'),
		])
		if rt.is_true(var_product) {
			mut var_consent :=
				rt.new_string(rt.new_string('I acknowledge that using experimental APIs means my theme or plugin will inevitably break in the next version of WooCommerce'))
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore{}
				return temp.load_product(arg_0, arg_1)
			}(var_consent.dup(), rt.call_method(var_product, 'get_id', []rt.PhpVal{}))
			rt.call_function('wp_interactivity_state', [
				rt.new_string('woocommerce/products'),
				rt.create_array([
					rt.ArrayItem{ key: 'productId', val: rt.call_method(var_product, 'get_id',
						[]rt.PhpVal{}) },
					rt.ArrayItem{ key: 'variationId', val: rt.new_null() },
				]),
			])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate) update_single_product_content(var_query_result rt.PhpVal) rt.PhpVal {
	mut var_query_result_mutated := var_query_result
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			mut var_product := rt.new_null()
			if rt.is_true(rt.call_function('str_contains', [
				rt.get_property(var_template, 'slug'),
				Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.slug(),
			]))
			{
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('REST_REQUEST')])) && rt.is_true(rt.get_constant('REST_REQUEST'))))))))) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
					return temp.template_has_legacy_template_block(arg_0)
				}(var_template.dup())))))))
				{
					closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
						mut var_classes := if args.len > 0 { args[0].dup() } else { rt.new_null() }
						return rt.call_function('array_merge', [
							var_classes.dup(), rt.call_function('wc_get_product_class',
								[]rt.PhpVal{})])
					}
					rt.call_function('add_filter', [rt.new_string('body_class'),
						rt.new_closure(closure_2_fn)])
					// unsupported statement: Stmt_Global
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
						'Automattic_WooCommerce_Blocks_Templates_WC_Product'))))))
					{
						mut var_product_id := rt.call_function('get_the_ID', []rt.PhpVal{})
						if rt.is_true(var_product_id) {
							rt.call_function('wc_setup_product_data', [
								var_product_id.dup()])
						}
					}
					if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
						rt.set_property(var_template, 'content', this.add_password_form(rt.get_property(var_template,
							'content')))
					} else {
						rt.set_property(var_template, 'content', fn (arg_0 rt.PhpVal) rt.PhpVal {
							mut temp :=
								Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility{}
							return temp.add_compatibility_layer(arg_0)
						}(rt.get_property(var_template, 'content')))
					}
				}
			}
			return var_template.dup()
		}
		mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_product := rt.new_null()
		if rt.is_true(rt.call_function('str_contains', [
			rt.get_property(var_template, 'slug'),
			Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.slug(),
		]))
		{
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('REST_REQUEST')])) && rt.is_true(rt.get_constant('REST_REQUEST'))))))))) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
				return temp.template_has_legacy_template_block(arg_0)
			}(var_template.dup())))))))
			{
				closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_classes := if args.len > 0 { args[0].dup() } else { rt.new_null() }
					return rt.call_function('array_merge', [var_classes.dup(),
						rt.call_function('wc_get_product_class', []rt.PhpVal{})])
				}
				rt.call_function('add_filter', [rt.new_string('body_class'),
					rt.new_closure(closure_4_fn)])
				// unsupported statement: Stmt_Global
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
					'Automattic_WooCommerce_Blocks_Templates_WC_Product'))))))
				{
					mut var_product_id := rt.call_function('get_the_ID', []rt.PhpVal{})
					if rt.is_true(var_product_id) {
						rt.call_function('wc_setup_product_data', [
							var_product_id.dup()])
					}
				}
				if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
					rt.set_property(var_template, 'content', this.add_password_form(rt.get_property(var_template,
						'content')))
				} else {
					rt.set_property(var_template, 'content', fn (arg_0 rt.PhpVal) rt.PhpVal {
						mut temp :=
							Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility{}
						return temp.add_compatibility_layer(arg_0)
					}(rt.get_property(var_template, 'content')))
				}
			}
		}
		return var_template.dup()
	}
	var_query_result_mutated = rt.call_function('array_map', [
		rt.new_closure(closure_2_fn),
		var_query_result_mutated.dup(),
	])
	return var_query_result_mutated.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.replace_first_single_product_template_block_with_password_form(var_parsed_blocks rt.PhpVal, var_is_already_replaced rt.PhpVal) rt.PhpVal {
	mut var_parsed_blocks_mutated := var_parsed_blocks
	mut var_single_product_template_blocks := rt.create_array([
		rt.ArrayItem{ key: none, val: 'woocommerce/product-image-gallery' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-details' },
		rt.ArrayItem{ key: none, val: 'woocommerce/add-to-cart-form' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-meta' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-rating' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-price' },
		rt.ArrayItem{ key: none, val: 'woocommerce/related-products' },
		rt.ArrayItem{ key: none, val: 'woocommerce/add-to-cart-with-options' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-gallery' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-collection' },
		rt.ArrayItem{ key: none, val: 'core/post-title' },
		rt.ArrayItem{ key: none, val: 'core/post-excerpt' },
	])
	closure_5_fn := fn [var_single_product_template_blocks] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.call_function('in_array', [var_block.array_get('blockName'), var_single_product_template_blocks.dup(), rt.new_bool(true)]))
			|| rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core/pattern'), var_block.array_get('blockName')))
			&& var_block.array_get('attrs').array_isset(rt.new_string('slug'))))
			&& rt.is_true(rt.identical(rt.new_string('woocommerce-blocks/related-products'), var_block.array_get('attrs').array_get('slug')))))))
		{
			if rt.is_true(var_carry.array_get('is_already_replaced')) {
				return rt.create_array([
					rt.ArrayItem{ key: 'blocks', val: var_carry.array_get('blocks') },
					rt.ArrayItem{ key: 'html_block', val: rt.new_null() },
					rt.ArrayItem{ key: 'removed', val: true },
					rt.ArrayItem{ key: 'is_already_replaced', val: true },
				])
			}
			return rt.create_array([
				rt.ArrayItem{ key: 'blocks', val: var_carry.array_get('blocks') },
				rt.ArrayItem{ key: 'html_block', val: rt.call_function('parse_blocks', [
					'<!-- wp:html -->' +
						(rt.call_function('get_the_password_form', []rt.PhpVal{})).str() +
						'<!-- /wp:html -->',
				]).array_get(0) },
				rt.ArrayItem{ key: 'removed', val: false },
				rt.ArrayItem{
					key: 'is_already_replaced'
					val: var_carry.array_get('is_already_replaced')
				},
			])
		}
		if var_block.array_isset(rt.new_string('innerBlocks'))
			&& var_block.array_get('innerBlocks').array_count() > 0 {
			mut var_index := rt.new_int(rt.new_int(0))
			mut var_new_inner_blocks := rt.new_array()
			mut var_new_inner_contents := var_block.array_get('innerContent')
			{
				mut iter_1 := var_block.array_get('innerContent').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_inner_content := item_1.val
					if rt.is_true(rt.identical(rt.new_int(var_block.array_get('innerBlocks').array_count()),
						var_index))
					{
						break
					}
					mut var_blocks := Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.replace_first_single_product_template_block_with_password_form(rt.create_array([
						rt.ArrayItem{
							key: none
							val: var_block.array_get('innerBlocks').array_get(var_index)
						},
					]), var_carry.array_get('is_already_replaced'))
					mut var_new_blocks := var_blocks.array_get('blocks')
					mut var_html_block := var_blocks.array_get('html_block')
					mut var_is_removed := var_blocks.array_get('removed')
					var_carry.array_set('is_already_replaced',
						var_blocks.array_get('is_already_replaced'))
					if !var_html_block.is_null() {
						var_new_inner_blocks = rt.call_function('array_merge', [
							var_new_inner_blocks.dup(), var_new_blocks.dup(),
							rt.create_array([
								rt.ArrayItem{ key: none, val: var_html_block },
							])])
						var_carry.array_set('is_already_replaced', true)
					} else {
						var_new_inner_blocks = rt.call_function('array_merge', [
							var_new_inner_blocks.dup(), var_new_blocks.dup()])
					}
					if rt.is_true(var_is_removed) {
						var_new_inner_contents.array_unset(var_index)
						if rt.is_true(rt.less(rt.add(var_index, rt.new_int(1)),
							rt.new_int(var_new_inner_contents.dup().array_count())))
						{
							var_new_inner_contents.array_unset(rt.add(var_index, rt.new_int(1)))
						}
						var_new_inner_contents = rt.call_function('array_values', [
							var_new_inner_contents.dup(),
						])
					}
					rt.post_inc(var_index)
				}
			}
			var_block.array_set('innerBlocks', var_new_inner_blocks.dup())
			var_block.array_set('innerContent', var_new_inner_contents.dup())
			if var_new_inner_blocks.dup().array_count() == 0 {
				return rt.create_array([
					rt.ArrayItem{ key: 'blocks', val: var_carry.array_get('blocks') },
					rt.ArrayItem{ key: 'html_block', val: rt.new_null() },
					rt.ArrayItem{ key: 'removed', val: true },
					rt.ArrayItem{
						key: 'is_already_replaced'
						val: var_carry.array_get('is_already_replaced')
					},
				])
			}
			return rt.create_array([
				rt.ArrayItem{ key: 'blocks', val: rt.call_function('array_merge', [
					var_carry.array_get('blocks'),
					rt.create_array([rt.ArrayItem{ key: none, val: var_block }]),
				]) },
				rt.ArrayItem{ key: 'html_block', val: rt.new_null() },
				rt.ArrayItem{ key: 'removed', val: false },
				rt.ArrayItem{
					key: 'is_already_replaced'
					val: var_carry.array_get('is_already_replaced')
				},
			])
		}
		return rt.create_array([
			rt.ArrayItem{ key: 'blocks', val: rt.call_function('array_merge', [
				var_carry.array_get('blocks'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_block }]),
			]) },
			rt.ArrayItem{ key: 'html_block', val: rt.new_null() },
			rt.ArrayItem{ key: 'removed', val: false },
			rt.ArrayItem{
				key: 'is_already_replaced'
				val: var_carry.array_get('is_already_replaced')
			},
		])
	}
	return rt.call_function('array_reduce', [var_parsed_blocks_mutated.dup(),
		rt.new_closure(closure_5_fn),
		rt.create_array([
			rt.ArrayItem{ key: 'blocks', val: rt.new_array() },
			rt.ArrayItem{ key: 'html_block', val: rt.new_null() },
			rt.ArrayItem{ key: 'removed', val: false },
			rt.ArrayItem{ key: 'is_already_replaced', val: var_is_already_replaced },
		])])
}

fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.add_password_form(var_content rt.PhpVal) rt.PhpVal {
	mut var_parsed_blocks := rt.call_function('parse_blocks', [
		var_content.dup()])
	mut var_blocks := Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.replace_first_single_product_template_block_with_password_form(var_parsed_blocks.dup(),
		rt.new_bool(false))
	mut var_serialized_blocks := rt.call_function('serialize_blocks', [
		var_blocks.array_get('blocks'),
	])
	return var_serialized_blocks.dup()
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_singleproducttemplate() &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplate() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_singleproducttemplatecompatibility() &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils() &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_sharedstores_productsstore() &Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore {
	mut obj := &Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_template_title' {
			return this.get_template_title()
		}
		'get_template_description' {
			return this.get_template_description()
		}
		'render_block_template' {
			this.render_block_template()
			return rt.new_null()
		}
		'update_single_product_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_single_product_content(dispatch_arg_0)
		}
		'replace_first_single_product_template_block_with_password_form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.replace_first_single_product_template_block_with_password_form(dispatch_arg_0,
				dispatch_arg_1)
		}
		'add_password_form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.add_password_form(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_singleproducttemplate_php() {
}

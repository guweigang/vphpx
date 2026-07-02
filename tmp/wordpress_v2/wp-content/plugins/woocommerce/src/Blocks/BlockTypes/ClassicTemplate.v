import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('legacy-template')
		api_version rt.PhpVal = rt.new_string('3')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) initialize() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('render_block'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock'], &this) }, rt.ArrayItem{ key: none, val: 'add_alignment_class_to_wrapper' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('enqueue_block_assets'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock'], &this) }, rt.ArrayItem{ key: none, val: 'enqueue_block_assets' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	mut var_attributes_mutated := var_attributes
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_attributes_mutated))
	rt.call_function('wp_interactivity_config', [rt.new_string('core/router'), rt.create_array([rt.ArrayItem{ key: 'clientNavigationDisabled', val: true }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) enqueue_block_assets() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Frontend_Scripts')])) && rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		mut var_frontend_scripts := create_wc_frontend_scripts()
		mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":72,"name":"frontend_scripts"}{}
		mut iife_result_0 := iife_temp_0.get_styles()
		mut var_styles := iife_result_0
		mut iter_1 := var_styles.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_style := item_1.val
			mut var_handle := item_1.key
			rt.call_function('wp_enqueue_style', [var_handle.clone(), rt.call_function('set_url_scheme', [var_style.array_get(rt.new_string('src'))]), var_style.array_get(rt.new_string('deps')), var_style.array_get(rt.new_string('version')), var_style.array_get(rt.new_string('media'))])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) enqueue_assets(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) {
	mut var_attributes_mutated := var_attributes
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock.enqueue_assets(var_attributes_mutated.clone(), var_content.clone(), var_block.clone())
	if rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) {
		rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock'], &this) }, rt.ArrayItem{ key: none, val: 'enqueue_legacy_assets' }]), rt.new_int(20)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) enqueue_legacy_assets() {
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('wc-product-gallery-zoom')])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-zoom')])
	}
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('wc-product-gallery-slider')])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-flexslider')])
	}
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('wc-product-gallery-lightbox')])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-photoswipe-ui-default')])
		rt.call_function('wp_enqueue_style', [rt.new_string('photoswipe-default-skin')])
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.call_function('wc_get_template', [rt.new_string('single-product/photoswipe.php')])
			return rt.new_null()
			}
		rt.call_function('add_action', [rt.new_string('wp_footer'), rt.new_closure(closure_2_fn)])
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-single-product')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	if !(var_attributes_mutated.array_isset(rt.new_string('template'))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Frontend_Scripts')])) {
	mut var_frontend_scripts := create_wc_frontend_scripts()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":155,"name":"frontend_scripts"}{}
	mut iife_result_2 := iife_temp_2.load_scripts()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate.slug(), var_attributes_mutated.array_get(rt.new_string('template')))) {
		return this.render_order_received()
	}
	if rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) {
		rt.call_function('add_filter', [rt.new_string('woocommerce_single_product_zoom_enabled'), rt.new_string('__return_true')])
		rt.call_function('add_filter', [rt.new_string('woocommerce_single_product_photoswipe_enabled'), rt.new_string('__return_true')])
		rt.call_function('add_filter', [rt.new_string('woocommerce_single_product_flexslider_enabled'), rt.new_string('__return_true')])
		return this.render_single_product()
	}
	mut var_valid := rt.new_bool(false)
	mut var_archive_templates := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate.slug() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate.slug() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blocks_Templates_ProductTagTemplate.slug() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate.slug() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate.slug() }])
	if rt.is_true(rt.call_function('in_array', [var_attributes_mutated.array_get(rt.new_string('template')), var_archive_templates.clone(), rt.new_bool(true)])) {
	var_valid = rt.new_bool(true)
	}
	mut iter_2 := var_archive_templates.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_template := item_2.val
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_attributes_mutated.array_get(rt.new_string('template')), var_template.clone()]))) {
		var_valid = rt.new_bool(true)
		}
	}
	if rt.is_true(var_valid) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('isRenderingPhpTemplate'), rt.new_bool(true)])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('hasFilterableProducts'), rt.new_bool(true)])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('pageUrl'), rt.call_function('html_entity_decode', [rt.call_function('get_pagenum_link', []rt.PhpVal{})])])
		return this.render_archive_product()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	print('You\'re using the ClassicTemplate block')
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) render_order_received() rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	print('<div class="wp-block-group">')
	rt.call_function('printf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'), rt.new_string('h1'), rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{}), rt.call_function('esc_html__', [rt.new_string('Order confirmation'), rt.new_string('woocommerce')])])
	mut iife_temp_3 := Class_WC_Shortcode_Checkout{}
	mut iife_result_3 := iife_temp_3.output(rt.new_array())
	print('</div>')
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) render_single_product() rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_before_main_content')])
	mut var_product_query := create_automattic_woocommerce_blocks_blocktypes_wp_query(rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'p', val: rt.call_function('get_the_ID', []rt.PhpVal{}) }]))
	for rt.is_true(var_product_query.have_posts()) {
		var_product_query.the_post()
		rt.call_function('wc_get_template_part', [rt.new_string('content'), rt.new_string('single-product')])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_after_main_content')])
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) render_archive_product() rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_before_main_content')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_show_page_title'), rt.new_bool(true)])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_page_title', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_archive_description')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('woocommerce_product_loop', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('woocommerce_before_shop_loop')])
		rt.call_function('woocommerce_product_loop_start', []rt.PhpVal{})
		if rt.is_true(rt.call_function('wc_get_loop_prop', [rt.new_string('total')])) {
			for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
				rt.call_function('the_post', []rt.PhpVal{})
				rt.call_function('do_action', [rt.new_string('woocommerce_shop_loop')])
				rt.call_function('wc_get_template_part', [rt.new_string('content'), rt.new_string('product')])
			}
		}
		rt.call_function('woocommerce_product_loop_end', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('woocommerce_after_shop_loop')])
	} else {
		rt.call_function('do_action', [rt.new_string('woocommerce_no_products_found')])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_after_main_content')])
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) add_alignment_class_to_wrapper(content string, mut var_block Class_Automattic_WooCommerce_Blocks_BlockTypes_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical('woocommerce/' + (this.block_name).str(), var_block.array_get(rt.new_string('blockName')))))) {
		return rt.new_string(content)
	}
	mut var_attributes := rt.cast_array(var_block.array_get(rt.new_string('attrs')))
	if !(var_attributes.array_isset(rt.new_string('align'))) {
		var_attributes.array_set('align', 'wide')
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_4 := iife_temp_4.get_align_class_and_style(var_attributes.clone())
	mut var_align_class_and_style := iife_result_4
	if !(var_align_class_and_style.array_isset(rt.new_string('class'))) {
		return rt.new_string(content)
	}
	mut var_first_tag := rt.new_string('<[^<>]+>')
	mut var_matches := rt.new_array()
	rt.call_function('preg_match', [var_first_tag.clone(), rt.new_string(content), var_matches.clone()])
	if var_matches.array_isset(rt.new_int(0)) && rt.is_true(rt.identical(rt.call_function('strpos', [var_matches.array_get(rt.new_int(0)), rt.new_string(' class=')]), rt.new_bool(false))) {
		mut var_pattern_before_tag_closing := rt.new_string('/.+?(?=>)/')
		return rt.call_function('preg_replace', [var_pattern_before_tag_closing.clone(), rt.new_string('$0 class="' + (var_align_class_and_style.array_get(rt.new_string('class'))).str() + '"'), rt.new_string(content), rt.new_int(1)])
	}
	mut var_pattern_get_class := rt.new_string('/(?<=class=\\"|\')[^"|\']+(?=\\"|\')/')
	return rt.call_function('preg_replace', [var_pattern_get_class.clone(), rt.new_string('$0 ' + (var_align_class_and_style.array_get(rt.new_string('class'))).str()), rt.new_string(content), rt.new_int(1)])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock {
	rt.PhpObjectBase
}

struct Class_WC_Frontend_Scripts {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":72,"name":"frontend_scripts"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":155,"name":"frontend_scripts"} {
	rt.PhpObjectBase
}

struct Class_WC_Shortcode_Checkout {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_classictemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('legacy-template')
		api_version: rt.new_string('3')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractdynamicblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_frontend_scripts(_args ...rt.PhpVal) &Class_WC_Frontend_Scripts {
	mut obj := &Class_WC_Frontend_Scripts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_{"nodetype":"expr_variable","line":72,"name":"frontend_scripts"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":72,"name":"frontend_scripts"} {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":72,"name":"frontend_scripts"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_{"nodetype":"expr_variable","line":155,"name":"frontend_scripts"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":155,"name":"frontend_scripts"} {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":155,"name":"frontend_scripts"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcode_checkout(_args ...rt.PhpVal) &Class_WC_Shortcode_Checkout {
	mut obj := &Class_WC_Shortcode_Checkout{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_wp_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'enqueue_block_assets' {
			this.enqueue_block_assets()
			return rt.new_null()
		}
		'enqueue_assets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'enqueue_legacy_assets' {
			this.enqueue_legacy_assets()
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'render_order_received' {
			return this.render_order_received()
		}
		'render_single_product' {
			return this.render_single_product()
		}
		'render_archive_product' {
			return this.render_archive_product()
		}
		'add_alignment_class_to_wrapper' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.add_alignment_class_to_wrapper(dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'api_version' { return this.api_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		'api_version' { this.api_version = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Frontend_Scripts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Frontend_Scripts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Frontend_Scripts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":72,"name":"frontend_scripts"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":72,"name":"frontend_scripts"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":72,"name":"frontend_scripts"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":155,"name":"frontend_scripts"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":155,"name":"frontend_scripts"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":155,"name":"frontend_scripts"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shortcode_Checkout) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shortcode_Checkout) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_Checkout) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

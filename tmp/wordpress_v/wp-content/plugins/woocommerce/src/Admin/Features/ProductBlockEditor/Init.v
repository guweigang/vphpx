import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init.editor_context_name() string {
	return 'woocommerce/edit-product'
}
struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init {
	rt.PhpObjectBase
pub mut:
		supported_product_types rt.PhpVal = rt.new_array()
		product_templates rt.PhpVal = rt.new_array()
		redirection_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) construct()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{}))))))) {
		return
	}
	this.supported_product_types.array_push(Class_Automattic_WooCommerce_Enums_ProductType.variable())
	this.supported_product_types.array_push(Class_Automattic_WooCommerce_Enums_ProductType.external())
	this.supported_product_types.array_push(Class_Automattic_WooCommerce_Enums_ProductType.grouped())
	this.redirection_controller = create_automattic_woocommerce_admin_features_productblockeditor_redirectioncontroller()
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('product_block_editor'))) {
		rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_styles' }])])
		rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'dequeue_conflicting_styles' }]), rt.new_int(100)])
		rt.call_function('add_action', [rt.new_string('get_edit_post_link'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_edit_product_link' }]), rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_filter', [rt.new_string('woocommerce_admin_get_user_data_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_user_data_fields' }])])
		rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_scripts' }])])
		rt.call_function('add_filter', [rt.new_string('woocommerce_register_post_type_product_variation'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enable_rest_api_for_product_variation' }])])
		rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'set_current_screen_to_block_editor_if_wc_admin' }])])
		rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_layout_templates' }])])
		rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_user_metas' }])])
		rt.call_function('add_filter', [rt.new_string('register_block_type_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_metadata_attribute' }])])
		rt.call_function('add_filter', [rt.new_string('woocommerce_get_block_types'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_block_types' }]), rt.new_int(999), rt.new_int(1)])
		rt.call_function('add_filter', [rt.new_string('woocommerce_rest_prepare_product_object'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'possibly_add_template_id' }]), rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_filter', [rt.new_string('woocommerce_rest_prepare_product_variation_object'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'possibly_add_template_id' }]), rt.new_int(10), rt.new_int(2)])
		fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry{}; return temp.get_instance() }()
		mut var_tracks := create_automattic_woocommerce_admin_features_productblockeditor_tracks()
		var_tracks.init()
		this.register_product_templates()
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) possibly_add_template_id(var_response rt.PhpVal, var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_mutated)))) {
		return var_response.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'meta_exists', [rt.new_string('_product_template_id')]))))) {
		mut var_product_template_id := rt.call_function('apply_filters', [rt.new_string('experimental_woocommerce_product_editor_product_template_id_for_product'), rt.new_string(''), var_product_mutated.dup()])
		if rt.is_true(var_product_template_id) {
			rt.get_property(var_response, 'data').array_get_mut('meta_data').array_push(create_wc_meta_data(rt.create_array([rt.ArrayItem{ key: 'key', val: '_product_template_id' }, rt.ArrayItem{ key: 'value', val: var_product_template_id }])))
		}
	}
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) enqueue_scripts()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_or_embed_page() }())))) {
		return rt.new_null()
	}
	mut var_editor_settings := this.get_product_editor_settings()
	mut var_script_handle := rt.new_string(rt.new_string('wc-admin-edit-product'))
	rt.call_function('wp_register_script', [var_script_handle.dup(), rt.new_string(''), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-blocks' }]), rt.new_string('0.1.0'), rt.new_bool(true)])
	rt.call_function('wp_enqueue_script', [var_script_handle.dup()])
	rt.call_function('wp_add_inline_script', [var_script_handle.dup(), 'var productBlockEditorSettings = productBlockEditorSettings || ' + (rt.call_function('wp_json_encode', [var_editor_settings.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() + ';', rt.new_string('before')])
	rt.call_function('wp_add_inline_script', [var_script_handle.dup(), rt.call_function('sprintf', [rt.new_string('wp.blocks.setCategories( %s );'), rt.call_function('wp_json_encode', [var_editor_settings.array_get('blockCategories'), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])]), rt.new_string('before')])
	rt.call_function('wp_tinymce_inline_scripts', []rt.PhpVal{})
	rt.call_function('wp_enqueue_media', []rt.PhpVal{})
	rt.call_function('wp_register_style', [rt.new_string('wc-global-presets'), rt.new_bool(false)])
	rt.call_function('wp_add_inline_style', [rt.new_string('wc-global-presets'), rt.call_function('wp_get_global_stylesheet', [rt.create_array([rt.ArrayItem{ key: none, val: 'presets' }])])])
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-global-presets')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) enqueue_styles()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }())))) {
		return rt.new_null()
	}
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-product-editor')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-editor')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-format-library')])
	rt.call_function('wp_enqueue_editor', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('enqueue_block_editor_assets')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) dequeue_conflicting_styles()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }())))) {
		return rt.new_null()
	}
	rt.call_function('wp_dequeue_style', [rt.new_string('woocommerce-blocktheme')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) update_edit_product_link(var_link rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	mut var_product := rt.call_function('wc_get_product', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return var_link.dup()
	}
	if rt.is_true(rt.identical(rt.call_method(var_product, 'get_type', []rt.PhpVal{}), Class_Automattic_WooCommerce_Enums_ProductType.simple())) {
		return rt.call_function('admin_url', ['admin.php?page=wc-admin&path=/product/' + (rt.call_method(var_product, 'get_id', []rt.PhpVal{})).str()])
	}
	return var_link.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) enable_rest_api_for_product_variation(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('show_in_rest', true)
	return var_args_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) add_user_data_fields(var_user_data_fields rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_merge', [var_user_data_fields.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'variable_product_block_tour_shown' }, rt.ArrayItem{ key: none, val: 'local_attributes_notice_dismissed_ids' }, rt.ArrayItem{ key: none, val: 'variable_items_without_price_notice_dismissed' }, rt.ArrayItem{ key: none, val: 'product_advice_card_dismissed' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) set_current_screen_to_block_editor_if_wc_admin()  {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }()) {
		rt.call_method(var_screen, 'is_block_editor', [rt.new_bool(true)])
		rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'), 'wp.blocks && wp.blocks.unstable__bootstrapServerSideBlockDefinitions && wp.blocks.unstable__bootstrapServerSideBlockDefinitions(' + (rt.call_function('wp_json_encode', [rt.call_function('get_block_editor_server_block_settings', []rt.PhpVal{}), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() + ');'])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) get_product_editor_settings() rt.PhpVal {
	mut var_editor_settings := rt.new_null()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_product_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_product_template, 'to_json', []rt.PhpVal{})
	}
	mut var_product_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_product_template, 'to_json', []rt.PhpVal{})
	}
	var_editor_settings.array_set('productTemplates', rt.call_function('array_map', [rt.new_closure(closure_1_fn), this.product_templates]))
	mut var_block_editor_context := create_wp_block_editor_context(rt.create_array([rt.ArrayItem{ key: 'name', val: Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init.editor_context_name() }]))
	return rt.call_function('get_block_editor_settings', [var_editor_settings.dup(), var_block_editor_context])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) get_default_product_templates() rt.PhpVal {
	mut var_templates := rt.new_array()
	var_templates.array_push(create_automattic_woocommerce_admin_features_productblockeditor_producttemplate(rt.create_array([rt.ArrayItem{ key: 'id', val: 'standard-product-template' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Standard product'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A single physical or virtual product, e.g. a t-shirt or an eBook.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'icon', val: 'shipping' }, rt.ArrayItem{ key: 'layout_template_id', val: 'simple-product' }, rt.ArrayItem{ key: 'product_data', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Enums_ProductType.simple() }]) }])))
	var_templates.array_push(create_automattic_woocommerce_admin_features_productblockeditor_producttemplate(rt.create_array([rt.ArrayItem{ key: 'id', val: 'grouped-product-template' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Grouped product'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A set of products that go well together, e.g. camera kit.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'icon', val: 'group' }, rt.ArrayItem{ key: 'layout_template_id', val: 'simple-product' }, rt.ArrayItem{ key: 'product_data', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Enums_ProductType.grouped() }]) }])))
	var_templates.array_push(create_automattic_woocommerce_admin_features_productblockeditor_producttemplate(rt.create_array([rt.ArrayItem{ key: 'id', val: 'affiliate-product-template' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Affiliate product'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A link to a product sold on a different website, e.g. brand collab.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order', val: 30 }, rt.ArrayItem{ key: 'icon', val: 'link' }, rt.ArrayItem{ key: 'layout_template_id', val: 'simple-product' }, rt.ArrayItem{ key: 'product_data', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Enums_ProductType.external() }]) }])))
	return var_templates.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) create_default_product_template_by_custom_product_type(mut var_templates Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array) rt.PhpVal {
	mut var_templates_mutated := var_templates
	mut var_registered_product_types := rt.call_function('wc_get_product_types', []rt.PhpVal{})
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_product_type := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_product_type.dup(), this.supported_product_types, rt.new_bool(true)]))))
	}
	mut var_custom_product_types := rt.call_function('array_filter', [var_registered_product_types.dup(), rt.new_closure(closure_3_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_product_data := rt.call_method(var_template, 'get_product_data', []rt.PhpVal{})
	return rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_product_data.dup().is_null()))))) && rt.is_true(rt.new_bool(var_product_data.dup().array_isset(rt.new_string('type')))))
	}
	mut var_templates_with_product_type := rt.call_function('array_filter', [var_templates_mutated.dup(), rt.new_closure(closure_4_fn)])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_product_data := rt.call_method(var_template, 'get_product_data', []rt.PhpVal{})
	return var_product_data.array_get('type')
	}
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_product_data := rt.call_method(var_template, 'get_product_data', []rt.PhpVal{})
	return var_product_data.array_get('type')
	}
	mut var_custom_product_types_on_templates := rt.call_function('array_map', [rt.new_closure(closure_5_fn), var_templates_with_product_type.dup()])
	{
		mut iter_1 := var_custom_product_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_title := item_1.val
			mut var_product_type := item_1.key
			if rt.is_true(rt.call_function('in_array', [var_product_type.dup(), var_custom_product_types_on_templates.dup(), rt.new_bool(true)])) {
				continue
			}
			var_templates_mutated.array_push(create_automattic_woocommerce_admin_features_productblockeditor_producttemplate(rt.create_array([rt.ArrayItem{ key: 'id', val: (var_product_type).str() + '-product-template' }, rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'product_data', val: rt.create_array([rt.ArrayItem{ key: 'type', val: var_product_type }]) }])))
		}
	}
	return rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array', []string{}, var_templates_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) register_layout_templates()  {
	mut var_layout_template_registry := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry.class()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_layout_template_registry, 'is_registered', [rt.new_string('simple-product')]))))) {
		rt.call_method(var_layout_template_registry, 'register', [rt.new_string('simple-product'), rt.new_string('product-form'), Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate.class()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_layout_template_registry, 'is_registered', [rt.new_string('product-variation')]))))) {
		rt.call_method(var_layout_template_registry, 'register', [rt.new_string('product-variation'), rt.new_string('product-form'), Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate.class()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) register_product_templates()  {
	this.product_templates = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_editor_product_templates'), this.get_default_product_templates()])
	this.product_templates = this.create_default_product_template_by_custom_product_type(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array]())
	rt.call_function('usort', [, ])
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) register_user_metas()  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) register_metadata_attribute(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) get_block_types(var_block_types rt.PhpVal) rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks {
	rt.PhpObjectBase
}

struct Class_WC_Meta_Data {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_WP_Block_Editor_Context {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_productblockeditor_init() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init{
		PhpObjectBase: rt.PhpObjectBase{}
		supported_product_types: rt.new_array()
		product_templates: rt.new_array()
		redirection_controller: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_productblockeditor_redirectioncontroller() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_productblockeditor_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_productblockeditor_blockregistry() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_productblockeditor_tracks() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_meta_data() &Class_WC_Meta_Data {
	mut obj := &Class_WC_Meta_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_editor_context() &Class_WP_Block_Editor_Context {
	mut obj := &Class_WP_Block_Editor_Context{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_productblockeditor_producttemplate() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'possibly_add_template_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.possibly_add_template_id(dispatch_arg_0, dispatch_arg_1)
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'enqueue_styles' {
			this.enqueue_styles()
			return rt.new_null()
		}
		'dequeue_conflicting_styles' {
			this.dequeue_conflicting_styles()
			return rt.new_null()
		}
		'update_edit_product_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_edit_product_link(dispatch_arg_0, dispatch_arg_1)
		}
		'enable_rest_api_for_product_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.enable_rest_api_for_product_variation(dispatch_arg_0)
		}
		'add_user_data_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_user_data_fields(dispatch_arg_0)
		}
		'set_current_screen_to_block_editor_if_wc_admin' {
			this.set_current_screen_to_block_editor_if_wc_admin()
			return rt.new_null()
		}
		'get_product_editor_settings' {
			return this.get_product_editor_settings()
		}
		'get_default_product_templates' {
			return this.get_default_product_templates()
		}
		'create_default_product_template_by_custom_product_type' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.create_default_product_template_by_custom_product_type(mut dispatch_arg_0)
		}
		'register_layout_templates' {
			this.register_layout_templates()
			return rt.new_null()
		}
		'register_product_templates' {
			this.register_product_templates()
			return rt.new_null()
		}
		'register_user_metas' {
			this.register_user_metas()
			return rt.new_null()
		}
		'register_metadata_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_metadata_attribute(dispatch_arg_0)
		}
		'get_block_types' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_types(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'supported_product_types' { return this.supported_product_types }
		'product_templates' { return this.product_templates }
		'redirection_controller' { return this.redirection_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'supported_product_types' { this.supported_product_types = val; return true }
		'product_templates' { this.product_templates = val; return true }
		'redirection_controller' { this.redirection_controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Meta_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Meta_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Block_Editor_Context) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Editor_Context) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Editor_Context) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_productblockeditor_init_php() {
	// unsupported statement: Stmt_Declare
}

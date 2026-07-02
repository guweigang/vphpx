import rt

pub fn Class_WC_Products_Tracking.tracks_source() string {
	return 'product-legacy-editor'
}
pub fn Class_WC_Products_Tracking.track_product_published_callback() string {
	return 'track_product_published'
}
struct Class_WC_Products_Tracking {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Products_Tracking) init() {
	rt.call_function('add_action', [rt.new_string('load-edit.php'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_products_view' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('load-edit-tags.php'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_categories_and_tags_view' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('edit_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_product_updated' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_after_insert_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_product_published' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('created_product_cat'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_product_category_created' }])])
	rt.call_function('add_action', [rt.new_string('edited_product_cat'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_product_category_updated' }])])
	rt.call_function('add_action', [rt.new_string('add_meta_boxes_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_product_updated_client_side' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'possibly_add_product_tracking_scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'possibly_add_product_import_scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'possibly_add_attribute_tracking_scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'possibly_add_tag_tracking_scripts' }])])
	rt.call_function('add_action', [rt.new_string(Class_WC_Products_Tracking.track_product_published_callback()), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Products_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_product_published_maybe_defer' }]), rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_WC_Products_Tracking) track_products_view() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('post_type')) && rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('post_type'))]))) && !(rt.get_superglobal('_GET').array_isset(rt.new_string('_wp_http_referer'))) {
		mut iife_temp_0 := Class_WC_Tracks{}
		mut iife_result_0 := iife_temp_0.record_event(rt.new_string('products_view'))
		if rt.get_superglobal('_GET').array_isset(rt.new_string('s')) && 0 < rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('s'))])]).to_string().len {
		mut iife_temp_1 := Class_WC_Tracks{}
		mut iife_result_1 := iife_temp_1.record_event(rt.new_string('products_search'))
		}
	}
}

fn (mut this Class_WC_Products_Tracking) track_categories_and_tags_view() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('post_type')) && rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('post_type'))]))) && rt.get_superglobal('_GET').array_isset(rt.new_string('taxonomy')) && !(rt.get_superglobal('_GET').array_isset(rt.new_string('_wp_http_referer'))) {
		mut var_taxonomy := rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('taxonomy'))])
		if rt.is_true(rt.identical(rt.new_string('product_cat'), var_taxonomy)) {
		mut iife_temp_2 := Class_WC_Tracks{}
		mut iife_result_2 := iife_temp_2.record_event(rt.new_string('categories_view'))
		} else if rt.is_true(rt.identical(rt.new_string('product_tag'), var_taxonomy)) {
		mut iife_temp_3 := Class_WC_Tracks{}
		mut iife_result_3 := iife_temp_3.record_event(rt.new_string('tags_view'))
		}
		if rt.get_superglobal('_GET').array_isset(rt.new_string('s')) && 0 < rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('s'))])]).to_string().len {
			if rt.is_true(rt.identical(rt.new_string('product_cat'), var_taxonomy)) {
			mut iife_temp_4 := Class_WC_Tracks{}
			mut iife_result_4 := iife_temp_4.record_event(rt.new_string('categories_search'))
			} else if rt.is_true(rt.identical(rt.new_string('product_tag'), var_taxonomy)) {
			mut iife_temp_5 := Class_WC_Tracks{}
			mut iife_result_5 := iife_temp_5.record_event(rt.new_string('tags_search'))
			}
		}
	}
}

fn (mut this Class_WC_Products_Tracking) track_product_updated(var_product_id rt.PhpVal, var_post rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post, 'post_type'))))) {
		return
	}
mut iife_temp_6 := Class_WC_Products_Tracking{}
mut iife_result_6 := iife_temp_6.is_importing()
mut var_source := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_source'), rt.new_string((if rt.is_true(iife_result_6) { 'import' } else { Class_WC_Products_Tracking.tracks_source() }).str())])
mut var_properties := { 'product_id': var_product_id, 'source': var_source }
mut iife_temp_7 := Class_WC_Tracks{}
mut iife_result_7 := iife_temp_7.record_event(rt.new_string('product_edit'), var_properties.clone())
}

fn (mut this Class_WC_Products_Tracking) track_product_updated_client_side(var_post rt.PhpVal) {
	mut var_handle := rt.new_string('wc-tracks-product-updated-client-side')
	rt.call_function('wp_register_script', [var_handle.clone(), rt.new_string(''), rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]), rt.get_constant('WC_VERSION'), rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
	rt.call_function('wp_enqueue_script', [var_handle.clone()])
	rt.call_function('wp_add_inline_script', [var_handle.clone(), rt.new_string('\n\t\t\tjQuery(function($) {\n\t\t\t\tif ( $( \'h1.wp-heading-inline\' ).text().trim() === \'' + (rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Edit product'), rt.new_string('woocommerce')])])).str() + '\') {\n\t\t\t\t\tvar initialStockValue = $( \'#_stock\' ).val();\n\t\t\t\t\tvar isBlockEditor = false;\n\t\t\t\t\tvar child_element = \'#publish\';\n\n\t\t\t\t\tif ( $( \'.block-editor\' ).length !== 0 && $( \'.block-editor\' )[0] ) {\n\t\t                isBlockEditor = true;\n\t\t\t\t\t}\n\n\t\t\t\t\tif ( isBlockEditor ) {\n\t\t\t\t\t\tchild_element = \'.editor-post-publish-button\';\n\t\t\t\t\t}\n\n\t\t\t\t\t$( \'#wpwrap\' ).on( \'click\', child_element, function() {\n\t\t\t\t\t\tvar description_value  = \'\';\n\t\t\t\t\t\tvar tagsText = \'\';\n\t\t\t\t\t\tvar currentStockValue = $( \'#_stock\' ).val();\n\n\t\t\t\t\t\tfunction getProductTypeOptions() {\n\t\t\t\t\t\t\tconst productTypeOptionsCheckboxes = $( \'input[type="checkbox"][data-product-type-option-id]\' );\n\t\t\t\t\t\t\tconst productTypeOptions = productTypeOptionsCheckboxes.map( function() {\n\t\t\t\t\t\t\t\treturn {\n\t\t\t\t\t\t\t\t\tid: $( this ).data( \'product-type-option-id\' ),\n\t\t\t\t\t\t\t\t\tisEnabled: $( this ).is( \':checked\' ),\n\t\t\t\t\t\t\t\t};\n\t\t\t\t\t\t\t} ).get();\n\t\t\t\t\t\t\treturn productTypeOptions;\n\t\t\t\t\t\t}\n\n\t\t\t\t\t\tfunction getProductTypeOptionsString( productTypeOptions ) {\n\t\t\t\t\t\t\treturn productTypeOptions\n\t\t\t\t\t\t\t\t.filter( productTypeOption => productTypeOption.isEnabled )\n\t\t\t\t\t\t\t\t.map( productTypeOption => productTypeOption.id )\n\t\t\t\t\t\t\t\t.join( \', \' );\n\t\t\t\t\t\t}\n\n\t\t\t\t\t\tconst productTypeOptions = getProductTypeOptions();\n\t\t\t\t\t\tconst productTypeOptionsString = getProductTypeOptionsString( productTypeOptions );\n\n\t\t\t\t\t\tif ( ! isBlockEditor ) {\n\t\t\t\t\t\t\ttagsText          = $( \'[name="tax_input[product_tag]"]\' ).val();\n\t\t\t\t\t\t\tif ( $( \'#content\' ).is( \':visible\' ) ) {\n\t\t\t\t\t\t\t\tdescription_value = $( \'#content\' ).val();\n\t\t\t\t\t\t\t} else if ( typeof tinymce === \'object\' && tinymce.get( \'content\' ) ) {\n\t\t\t\t\t\t\t\tdescription_value = tinymce.get( \'content\' ).getContent();\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t} else {\n\t\t\t\t\t\t\tdescription_value  = $( \'.block-editor-rich-text__editable\' ).text();\n\t\t\t\t\t\t}\n\n\t\t\t\t\t\t// We can\'t just check the number of \'.woocommerce_attribute\' elements because\n\t\t\t\t\t\t// there might be empty ones, which get stripped out when saved. So, we\'ll check\n\t\t\t\t\t\t// whether the name and values have been filled out.\n\t\t\t\t\t\tvar numberOfAttributes = $( \'.woocommerce_attribute\' ).filter( function () {\n\t\t\t\t\t\t\tvar attributeElement = $( this );\n\t\t\t\t\t\t\tvar attributeName = attributeElement.find( \'input.attribute_name\' ).val();\n\t\t\t\t\t\t\tvar attributeValues = attributeElement.find( \'textarea[name^="attribute_values"]\' ).val();\n\n\t\t\t\t\t\t\treturn attributeName !== \'\' && attributeValues !== \'\';\n\t\t\t\t\t\t} ).length;\n\n\t\t\t\t\t\tvar properties = {\n\t\t\t\t\t\t\tattributes:\t\t\t\t     numberOfAttributes,\n\t\t\t\t\t\t\tcategories:\t\t\t\t     $( \'[name="tax_input[product_cat][]"]:checked\' ).length,\n\t\t\t\t\t\t\tcross_sells:\t\t\t     $( \'#crosssell_ids option\' ).length ? \'Yes\' : \'No\',\n\t\t\t\t\t\t\tdescription:\t\t\t     description_value.trim() !== \'\' ? \'Yes\' : \'No\',\n\t\t\t\t\t\t\tenable_reviews:\t\t\t     $( \'#comment_status\' ).is( \':checked\' ) ? \'Yes\' : \'No\',\n\t\t\t\t\t\t\tis_virtual:\t\t\t\t     $( \'#_virtual\' ).is( \':checked\' ) ? \'Yes\' : \'No\',\n\t\t\t\t\t\t\tis_block_editor:\t\t     isBlockEditor,\n\t\t\t\t\t\t\tis_downloadable:\t\t     $( \'#_downloadable\' ).is( \':checked\' ) ? \'Yes\' : \'No\',\n\t\t\t\t\t\t\tmanage_stock:\t\t\t     $( \'#_manage_stock\' ).is( \':checked\' ) ? \'Yes\' : \'No\',\n\t\t\t\t\t\t\tmenu_order:\t\t\t\t     parseInt( $( \'#menu_order\' ).val(), 10 ) !== 0 ? \'Yes\' : \'No\',\n\t\t\t\t\t\t\tproduct_gallery:\t\t     $( \'#product_images_container .product_images > li\' ).length,\n\t\t\t\t\t\t\tproduct_image:\t\t\t     $( \'#_thumbnail_id\' ).val() > 0 ? \'Yes\' : \'No\',\n\t\t\t\t\t\t\tproduct_type:\t\t\t     $( \'#product-type\' ).val(),\n\t\t\t\t\t\t\tproduct_type_options_string: productTypeOptionsString,\n\t\t\t\t\t\t\tpurchase_note:\t\t\t     $( \'#_purchase_note\' ).val().length ? \'yes\' : \'no\',\n\t\t\t\t\t\t\tsale_price:\t\t\t\t     $( \'#_sale_price\' ).val() ? \'yes\' : \'no\',\n\t\t\t\t\t\t\tshort_description:\t\t     $( \'#excerpt\' ).val().length ? \'yes\' : \'no\',\n\t\t\t\t\t\t\tstock_quantity_update:\t     ( initialStockValue != currentStockValue ) ? \'Yes\' : \'No\',\n\t\t\t\t\t\t\ttags:\t\t\t\t\t     tagsText.length > 0 ? tagsText.split( \',\' ).length : 0,\n\t\t\t\t\t\t\tupsells:\t\t\t\t     $( \'#upsell_ids option\' ).length ? \'Yes\' : \'No\',\n\t\t\t\t\t\t\tweight:\t\t\t\t\t     $( \'#_weight\' ).val() ? \'Yes\' : \'No\',\n\t\t\t\t\t\t};\n\t\t\t\t\t\tif ( window.wcTracks && window.wcTracks.recordEvent ) {\n\t\t\t\t\t\t\twindow.wcTracks.recordEvent( \'product_update\', properties );\n\t\t\t\t\t\t}\n\t\t\t\t\t} );\n\t\t\t\t}\n\t\t\t});\n\t\t\t')])
}

fn Class_WC_Products_Tracking.get_possible_product_type_options_ids() rt.PhpVal {
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product_type_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product_type_option.array_get(rt.new_string('id'))
		}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product_type_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product_type_option.array_get(rt.new_string('id'))
		}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product_type_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product_type_option.array_get(rt.new_string('id'))
		}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product_type_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product_type_option.array_get(rt.new_string('id'))
		}
	mut var_product_type_options_ids := rt.call_function('array_values', [rt.call_function('array_map', [rt.new_closure(closure_9_fn), rt.call_function('apply_filters', [rt.new_string('product_type_options'), rt.call_function('wc_get_default_product_type_options', []rt.PhpVal{})])])])
	return var_product_type_options_ids.clone()
}

fn Class_WC_Products_Tracking.get_product_type_options(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_possible_product_type_options_ids := Class_WC_Products_Tracking.get_possible_product_type_options_ids()
	mut var_post_meta := rt.call_function('get_post_meta', [var_post_id.clone()])
	mut var_product_type_options := rt.new_array()
	mut iter_1 := var_possible_product_type_options_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product_type_option_id := item_1.val
		var_product_type_options.array_set(var_product_type_option_id, if var_post_meta.array_isset(var_product_type_option_id) { var_post_meta.array_get(var_product_type_option_id).array_get(rt.new_int(0)) } else { rt.new_string('no') })
	}
	return var_product_type_options.clone()
}

fn Class_WC_Products_Tracking.get_product_type_options_string(var_product_type_options rt.PhpVal) rt.PhpVal {
	mut var_product_type_options_mutated := var_product_type_options
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_is_enabled := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_string('yes'), var_is_enabled)
		}
	return rt.call_function('implode', [rt.new_string(', '), rt.func_array_keys(rt.call_function('array_filter', [var_product_type_options_mutated.clone(), rt.new_closure(closure_13_fn)]))])
}

fn (mut this Class_WC_Products_Tracking) track_product_published(var_post_id rt.PhpVal, var_post rt.PhpVal, var_update rt.PhpVal, var_post_before rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post, 'post_type'))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status'))))) || (rt.is_true(var_post_before) && rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post_before, 'post_status')))) {
		return
	}
	mut var_product := rt.call_function('wc_get_product', [var_post_id.clone()])
	mut var_product_type_options := Class_WC_Products_Tracking.get_product_type_options(var_post_id.clone())
	mut var_product_type_options_string := Class_WC_Products_Tracking.get_product_type_options_string(var_product_type_options.clone())
	mut iife_temp_13 := Class_WC_Products_Tracking{}
	mut iife_result_13 := iife_temp_13.is_importing()
	mut var_is_importing := iife_result_13
	mut var_properties := { 'attributes': rt.new_int(rt.call_method(var_product, 'get_attributes', []rt.PhpVal{}).array_count()), 'categories': rt.new_int(rt.call_method(var_product, 'get_category_ids', []rt.PhpVal{}).array_count()), 'cross_sells': if !(!rt.is_true(rt.call_method(var_product, 'get_cross_sell_ids', []rt.PhpVal{}))) { 'yes' } else { 'no' }, 'description': if rt.is_true(rt.call_method(var_product, 'get_description', []rt.PhpVal{})) { 'yes' } else { 'no' }, 'dimensions': if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wc_format_dimensions', [rt.call_method(var_product, 'get_dimensions', [rt.new_bool(false)])]), rt.new_string('N/A'))))) { 'yes' } else { 'no' }, 'enable_reviews': if rt.is_true(rt.call_method(var_product, 'get_reviews_allowed', []rt.PhpVal{})) { 'yes' } else { 'no' }, 'is_downloadable': if rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) { 'yes' } else { 'no' }, 'is_virtual': if rt.is_true(rt.call_method(var_product, 'is_virtual', []rt.PhpVal{})) { 'yes' } else { 'no' }, 'manage_stock': if rt.is_true(rt.call_method(var_product, 'get_manage_stock', []rt.PhpVal{})) { 'yes' } else { 'no' }, 'menu_order': if rt.is_true(rt.call_method(var_product, 'get_menu_order', []rt.PhpVal{})) { 'yes' } else { 'no' }, 'product_id': var_post_id, 'product_gallery': rt.new_int(rt.call_method(var_product, 'get_gallery_image_ids', []rt.PhpVal{}).array_count()), 'product_image': if rt.is_true(rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})) { 'yes' } else { 'no' }, 'product_type': rt.call_method(var_product, 'get_type', []rt.PhpVal{}), 'product_type_options': var_product_type_options_string, 'purchase_note': if rt.is_true(rt.call_method(var_product, 'get_purchase_note', []rt.PhpVal{})) { 'yes' } else { 'no' }, 'sale_price': if rt.is_true(rt.call_method(var_product, 'get_sale_price', []rt.PhpVal{})) { 'yes' } else { 'no' }, 'source': rt.call_function('apply_filters', [rt.new_string('woocommerce_product_source'), rt.new_string((if rt.is_true(var_is_importing) { 'import' } else { Class_WC_Products_Tracking.tracks_source() }).str())]), 'short_description': if rt.is_true(rt.call_method(var_product, 'get_short_description', []rt.PhpVal{})) { 'yes' } else { 'no' }, 'tags': rt.new_int(rt.call_method(var_product, 'get_tag_ids', []rt.PhpVal{}).array_count()), 'upsells': if !(!rt.is_true(rt.call_method(var_product, 'get_upsell_ids', []rt.PhpVal{}))) { 'yes' } else { 'no' }, 'weight': if rt.is_true(rt.call_method(var_product, 'get_weight', []rt.PhpVal{})) { 'yes' } else { 'no' }, 'global_unique_id': if rt.is_true(rt.call_method(var_product, 'get_global_unique_id', []rt.PhpVal{})) { 'yes' } else { 'no' } }
	this.track_product_published_maybe_defer('product_add_publish', mut rt.cast_object_ptr[Class_array](var_properties), (var_is_importing).to_bool())
}

fn (mut this Class_WC_Products_Tracking) track_product_published_maybe_defer(event_name string, mut var_event_properties Class_array, defer bool) {
	if var_defer {
		rt.call_function('as_schedule_single_action', [rt.call_function('time', []rt.PhpVal{}), rt.new_string(Class_WC_Products_Tracking.track_product_published_callback()), rt.create_array([rt.ArrayItem{ key: none, val: event_name }, rt.ArrayItem{ key: none, val: var_event_properties }]), rt.new_string('woocommerce-tracks')])
	} else {
	mut iife_temp_14 := Class_WC_Tracks{}
	mut iife_result_14 := iife_temp_14.record_event(rt.new_string(event_name), rt.new_object('array', []string{}, var_event_properties))
	}
}

fn (mut this Class_WC_Products_Tracking) track_product_category_created(var_category_id rt.PhpVal) {
	mut iife_temp_15 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_15 := iife_temp_15.is_defined(rt.new_string('DOING_AJAX'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_15)))) || !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('action'))) || (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('add-tag'), rt.get_superglobal('_POST').array_get(rt.new_string('action')))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('add-product_cat'), rt.get_superglobal('_POST').array_get(rt.new_string('action'))))))) {
		return
	}
	mut var_category := rt.call_function('get_term', [var_category_id.clone(), rt.new_string('product_cat')])
	mut var_parent_category := rt.new_string((if rt.is_true(rt.greater(rt.get_property(var_category, 'parent'), rt.new_int(0))) { 'Other' } else { 'None' }).str())
	if rt.is_true(rt.greater(rt.get_property(var_category, 'parent'), rt.new_int(0))) {
		mut var_parent := rt.call_function('get_term', [var_category_id.clone(), rt.new_string('product_cat')])
		if rt.is_true(rt.identical(rt.new_string('uncategorized'), rt.get_property(var_parent, 'name'))) {
		var_parent_category = rt.new_string('Uncategorized')
		}
	}
mut var_properties := { 'category_id': var_category_id, 'parent_id': rt.get_property(var_category, 'parent'), 'parent_category': var_parent_category, 'page': if rt.is_true(rt.identical(rt.new_string('add-tag'), rt.get_superglobal('_POST').array_get(rt.new_string('action')))) { 'categories' } else { 'product' }, 'display_type': if rt.get_superglobal('_POST').array_isset(rt.new_string('display_type')) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('display_type'))]) } else { rt.new_string('') }, 'image': if rt.get_superglobal('_POST').array_isset(rt.new_string('product_cat_thumbnail_id')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_superglobal('_POST').array_get(rt.new_string('product_cat_thumbnail_id')))))) { 'Yes' } else { 'No' } }
mut iife_temp_16 := Class_WC_Tracks{}
mut iife_result_16 := iife_temp_16.record_event(rt.new_string('product_category_add'), var_properties.clone())
}

fn (mut this Class_WC_Products_Tracking) track_product_category_updated(var_category_id rt.PhpVal) {
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('action'))) || (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('editedtag'), rt.get_superglobal('_POST').array_get(rt.new_string('action')))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('inline-save-tax'), rt.get_superglobal('_POST').array_get(rt.new_string('action'))))))) {
		return
	}
mut iife_temp_17 := Class_WC_Tracks{}
mut iife_result_17 := iife_temp_17.record_event(rt.new_string('product_category_update'))
}

fn (mut this Class_WC_Products_Tracking) get_product_screen(var_hook rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('edit.php'), var_hook)) && rt.get_superglobal('_GET').array_isset(rt.new_string('post_type')) && rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('post_type'))]))) {
		return rt.new_string('list')
	}
	if rt.is_true(rt.identical(rt.new_string('post-new.php'), var_hook)) && rt.get_superglobal('_GET').array_isset(rt.new_string('post_type')) && rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('post_type'))]))) {
		return rt.new_string('new')
	}
	if rt.is_true(rt.identical(rt.new_string('post.php'), var_hook)) && rt.get_superglobal('_GET').array_isset(rt.new_string('post')) && rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [rt.new_int(rt.get_superglobal('_GET').array_get(rt.new_string('post')).to_i64())]))) {
		return rt.new_string('edit')
	}
	if rt.is_true(rt.identical(rt.new_string('product_page_product_importer'), var_hook)) {
		return rt.new_string('import')
	}
	return rt.new_bool(false)
}

fn (mut this Class_WC_Products_Tracking) possibly_add_product_tracking_scripts(var_hook rt.PhpVal) {
	mut var_product_screen := this.get_product_screen(var_hook.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_screen)))) {
		return
	}
	mut iife_temp_18 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_18 := iife_temp_18.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('product-tracking'), rt.new_bool(false))
	rt.call_function('wp_localize_script', [rt.new_string('wc-admin-product-tracking'), rt.new_string('productScreen'), rt.create_array([rt.ArrayItem{ key: 'name', val: var_product_screen }])])
}

fn (mut this Class_WC_Products_Tracking) possibly_add_product_import_scripts(var_hook rt.PhpVal) {
	mut var_product_screen := this.get_product_screen(var_hook.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('import'), var_product_screen)))) {
		return
	}
mut iife_temp_19 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
mut iife_result_19 := iife_temp_19.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('product-import-tracking'), rt.new_bool(false))
}

fn (mut this Class_WC_Products_Tracking) possibly_add_attribute_tracking_scripts(var_hook rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product_page_product_attributes'), var_hook)))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('page'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product_attributes'), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('page'))]))))) {
		return
	}
mut iife_temp_20 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
mut iife_result_20 := iife_temp_20.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('attributes-tracking'), rt.new_bool(false))
}

fn (mut this Class_WC_Products_Tracking) possibly_add_tag_tracking_scripts(var_hook rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit-tags.php'), var_hook)))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('post_type'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('post_type'))]))))) {
		return
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('taxonomy')) && rt.is_true(rt.identical(rt.new_string('product_tag'), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('taxonomy'))]))) {
		mut iife_temp_21 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
		mut iife_result_21 := iife_temp_21.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('tags-tracking'), rt.new_bool(false))
		return
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('taxonomy')) && rt.is_true(rt.identical(rt.new_string('product_cat'), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('taxonomy'))]))) {
		mut iife_temp_22 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
		mut iife_result_22 := iife_temp_22.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('category-tracking'), rt.new_bool(false))
		return
	}
mut iife_temp_23 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
mut iife_result_23 := iife_temp_23.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('add-term-tracking'), rt.new_bool(false))
}

fn (mut this Class_WC_Products_Tracking) is_importing() bool {
	if rt.get_superglobal('_POST').array_isset(rt.new_string('action')) && rt.is_true(rt.identical(rt.new_string('woocommerce_do_ajax_product_import'), rt.get_superglobal('_POST').array_get(rt.new_string('action')))) {
		return true
	}
	return false
	return false
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

fn create_wc_products_tracking(_args ...rt.PhpVal) &Class_WC_Products_Tracking {
	mut obj := &Class_WC_Products_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks(_args ...rt.PhpVal) &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Products_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'track_products_view' {
			this.track_products_view()
			return rt.new_null()
		}
		'track_categories_and_tags_view' {
			this.track_categories_and_tags_view()
			return rt.new_null()
		}
		'track_product_updated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.track_product_updated(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'track_product_updated_client_side' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.track_product_updated_client_side(dispatch_arg_0)
			return rt.new_null()
		}
		'get_possible_product_type_options_ids' {
			return Class_WC_Products_Tracking.get_possible_product_type_options_ids()
		}
		'get_product_type_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Products_Tracking.get_product_type_options(dispatch_arg_0)
		}
		'get_product_type_options_string' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Products_Tracking.get_product_type_options_string(dispatch_arg_0)
		}
		'track_product_published' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.track_product_published(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'track_product_published_maybe_defer' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.track_product_published_maybe_defer(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'track_product_category_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.track_product_category_created(dispatch_arg_0)
			return rt.new_null()
		}
		'track_product_category_updated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.track_product_category_updated(dispatch_arg_0)
			return rt.new_null()
		}
		'get_product_screen' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_screen(dispatch_arg_0)
		}
		'possibly_add_product_tracking_scripts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.possibly_add_product_tracking_scripts(dispatch_arg_0)
			return rt.new_null()
		}
		'possibly_add_product_import_scripts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.possibly_add_product_import_scripts(dispatch_arg_0)
			return rt.new_null()
		}
		'possibly_add_attribute_tracking_scripts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.possibly_add_attribute_tracking_scripts(dispatch_arg_0)
			return rt.new_null()
		}
		'possibly_add_tag_tracking_scripts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.possibly_add_tag_tracking_scripts(dispatch_arg_0)
			return rt.new_null()
		}
		'is_importing' {
			return rt.new_bool(this.is_importing())
		}
		else { return none }
	}
}

fn (this &Class_WC_Products_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Products_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/wc-admin-functions.php', '4')
}

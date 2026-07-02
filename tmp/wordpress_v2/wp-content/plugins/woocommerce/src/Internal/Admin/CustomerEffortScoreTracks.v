import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.ces_tracks_queue_option_name() string {
	return 'woocommerce_ces_tracks_queue'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.clear_ces_tracks_queue_for_page_option_name() string {
	return 'woocommerce_clear_ces_tracks_queue_for_page'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.shown_for_actions_option_name() string {
	return 'woocommerce_ces_shown_for_actions'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.product_add_publish_action_name() string {
	return 'product_add_publish'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.product_update_action_name() string {
	return 'product_update'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.shop_order_update_action_name() string {
	return 'shop_order_update'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.settings_change_action_name() string {
	return 'settings_change'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.add_product_categories_action_name() string {
	return 'add_product_categories'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.add_product_tags_action_name() string {
	return 'add_product_tags'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.add_product_attributes_action_name() string {
	return 'add_product_attributes'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.import_products_action_name() string {
	return 'import_products'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.search_action_name() string {
	return 'ces_search'
}

struct Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks {
	rt.PhpObjectBase
pub mut:
	onsubmit_label rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) construct() {
	this.enable_survey_enqueing_if_tracking_is_enabled()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) enable_survey_enqueing_if_tracking_is_enabled() {
	mut var_pagenow := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		return
	}
	mut var_allow_tracking := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_allow_tracking'),
		rt.new_string('no'),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_allow_tracking)))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_clear_ces_tracks_queue' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_options'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'run_on_update_options' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('product_cat_add_form'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_script_track_product_categories' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('product_tag_add_form'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_script_track_product_tags' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_attribute_added'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'run_on_add_product_attributes' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('load-edit.php'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'run_on_load_edit_php' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('product_page_product_importer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'run_on_product_import' },
		]),
		rt.new_int(10), rt.new_int(3)])
	if rt.is_true(rt.identical(rt.new_string('post.php'), var_pagenow)) {
		rt.call_function('add_action', [rt.new_string('transition_post_status'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'run_on_transition_post_status' },
			]),
			rt.new_int(10), rt.new_int(3)])
	}
	this.onsubmit_label = rt.call_function('__', [
		rt.new_string('Thank you for your feedback!'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) get_script_track_edit_php(var_action rt.PhpVal, var_title rt.PhpVal, var_first_question rt.PhpVal, var_second_question rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [
		rt.new_string("(function( $ ) {\n\t\t\t\t'use strict';\n\t\t\t\t// Hook on submit button and sets a 1000ms interval function\n\t\t\t\t// to determine successful add tag or otherwise.\n\t\t\t\t$('#addtag #submit').on( 'click', function() {\n\t\t\t\t\tconst initialCount = $('.tags tbody > tr').length;\n\t\t\t\t\tconst interval = setInterval( function() {\n\t\t\t\t\t\tif ( $('.tags tbody > tr').length > initialCount ) {\n\t\t\t\t\t\t\t// New tag detected.\n\t\t\t\t\t\t\tclearInterval( interval );\n\t\t\t\t\t\t\twp.data.dispatch('wc/customer-effort-score').addCesSurvey({ action: '%s', title: '%s', firstQuestion: '%s', secondQuestion: '%s', onsubmitLabel: '%s' });\n\t\t\t\t\t\t} else {\n\t\t\t\t\t\t\t// Form is no longer loading, most likely failed.\n\t\t\t\t\t\t\tif ( $( '#addtag .submit .spinner.is-active' ).length < 1 ) {\n\t\t\t\t\t\t\t\tclearInterval( interval );\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t}\n\t\t\t\t\t}, 1000 );\n\t\t\t\t});\n\t\t\t})( jQuery );"),
		rt.call_function('esc_js', [var_action.clone()]),
		rt.call_function('esc_js', [var_title.clone()]),
		rt.call_function('esc_js', [var_first_question.clone()]),
		rt.call_function('esc_js', [var_second_question.clone()]),
		rt.call_function('esc_js', [this.onsubmit_label]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) get_product_count() rt.PhpVal {
	mut var_query := create_automattic_woocommerce_internal_admin_wc_product_query(rt.create_array([
		rt.ArrayItem{ key: 'limit', val: 1 },
		rt.ArrayItem{ key: 'paginate', val: true },
		rt.ArrayItem{ key: 'return', val: 'ids' },
		rt.ArrayItem{ key: 'status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'publish' },
		]) },
	]))
	mut var_products := rt.call_method(var_query, 'get_products', []rt.PhpVal{})
	mut var_product_count := rt.new_int(rt.get_property(var_products, 'total').to_i64())
	return var_product_count.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) get_shop_order_count() rt.PhpVal {
	mut var_query := create_automattic_woocommerce_internal_admin_wc_order_query(rt.create_array([
		rt.ArrayItem{ key: 'limit', val: 1 },
		rt.ArrayItem{ key: 'paginate', val: true },
		rt.ArrayItem{ key: 'return', val: 'ids' },
	]))
	mut var_shop_orders := rt.call_method(var_query, 'get_orders', []rt.PhpVal{})
	mut var_shop_order_count := rt.new_int(rt.get_property(var_shop_orders, 'total').to_i64())
	return var_shop_order_count.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) has_been_shown(var_action rt.PhpVal) rt.PhpVal {
	mut var_shown_for_features := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.shown_for_actions_option_name(),
		rt.new_array(),
	])
	mut var_has_been_shown := rt.call_function('in_array', [var_action.clone(),
		var_shown_for_features.clone(), rt.new_bool(true)])
	return var_has_been_shown.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) enqueue_to_ces_tracks(var_item rt.PhpVal) {
	mut var_queue := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.ces_tracks_queue_option_name(),
		rt.new_array(),
	])
	var_queue = if var_queue.clone().is_array() { var_queue } else { rt.new_array() }
	closure_1_fn := fn [var_item] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_queue_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_has_duplicate := rt.call_function('array_filter', [
		var_queue.clone(), rt.new_closure(closure_1_fn)])
	if rt.is_true(var_has_duplicate) {
		return
	}
	var_queue.array_push(var_item.clone())
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.ces_tracks_queue_option_name(),
		var_queue.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) enqueue_ces_survey_for_search(var_search_area rt.PhpVal, var_page_now rt.PhpVal, var_admin_page rt.PhpVal) {
	mut var_page_now_mutated := var_page_now
	if rt.is_true(this.has_been_shown(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.search_action_name())) {
		return
	}
	this.enqueue_to_ces_tracks(rt.create_array([
		rt.ArrayItem{
			key: 'action'
			val: Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.search_action_name()
		},
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('How easy was it to use search?'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'firstQuestion', val: rt.call_function('__', [
			rt.new_string('The search feature in WooCommerce is easy to use.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'secondQuestion', val: rt.call_function('__', [
			rt.new_string("The search's functionality meets my needs."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'onsubmit_label', val: this.onsubmit_label },
		rt.ArrayItem{ key: 'pagenow', val: var_page_now_mutated },
		rt.ArrayItem{ key: 'adminpage', val: var_admin_page },
		rt.ArrayItem{ key: 'props', val: rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'search_area', val: var_search_area },
		])) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) run_on_transition_post_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post, 'post_type'))) {
		this.maybe_enqueue_ces_survey_for_product(var_new_status.clone(), var_old_status.clone())
	} else if rt.is_true(rt.identical(rt.new_string('shop_order'), rt.get_property(var_post,
		'post_type')))
	{
		this.enqueue_ces_survey_for_edited_shop_order()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) maybe_enqueue_ces_survey_for_product(var_new_status rt.PhpVal, var_old_status rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_new_status)))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_old_status)))) {
		this.enqueue_ces_survey_for_new_product()
	} else {
		this.enqueue_ces_survey_for_edited_product()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) enqueue_ces_survey_for_new_product() {
	if rt.is_true(this.has_been_shown(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.product_add_publish_action_name())) {
		return
	}
	this.enqueue_to_ces_tracks(rt.create_array([
		rt.ArrayItem{
			key: 'action'
			val: Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.product_add_publish_action_name()
		},
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('🎉 Congrats on adding your first product!'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'firstQuestion', val: rt.call_function('__', [
			rt.new_string('The product creation screen is easy to use.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'secondQuestion', val: rt.call_function('__', [
			rt.new_string("The product creation screen's functionality meets my needs."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'onsubmit_label', val: this.onsubmit_label },
		rt.ArrayItem{ key: 'pagenow', val: 'product' },
		rt.ArrayItem{ key: 'adminpage', val: 'post-php' },
		rt.ArrayItem{ key: 'props', val: rt.create_array([
			rt.ArrayItem{ key: 'product_count', val: this.get_product_count() },
		]) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) enqueue_ces_survey_for_edited_product() {
	if rt.is_true(this.has_been_shown(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.product_update_action_name())) {
		return
	}
	this.enqueue_to_ces_tracks(rt.create_array([
		rt.ArrayItem{
			key: 'action'
			val: Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.product_update_action_name()
		},
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('How easy was it to edit your product?'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'firstQuestion', val: rt.call_function('__', [
			rt.new_string('The product update process is easy to complete.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'secondQuestion', val: rt.call_function('__', [
			rt.new_string('The product update process meets my needs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'onsubmit_label', val: this.onsubmit_label },
		rt.ArrayItem{ key: 'pagenow', val: 'product' },
		rt.ArrayItem{ key: 'adminpage', val: 'post-php' },
		rt.ArrayItem{ key: 'props', val: rt.create_array([
			rt.ArrayItem{ key: 'product_count', val: this.get_product_count() },
		]) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) enqueue_ces_survey_for_edited_shop_order() {
	if rt.is_true(this.has_been_shown(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.shop_order_update_action_name())) {
		return
	}
	this.enqueue_to_ces_tracks(rt.create_array([
		rt.ArrayItem{
			key: 'action'
			val: Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.shop_order_update_action_name()
		},
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('How easy was it to update an order?'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'firstQuestion', val: rt.call_function('__', [
			rt.new_string('The order details screen is easy to use.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'secondQuestion', val: rt.call_function('__', [
			rt.new_string("The order details screen's functionality meets my needs."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'onsubmit_label', val: this.onsubmit_label },
		rt.ArrayItem{ key: 'pagenow', val: 'shop_order' },
		rt.ArrayItem{ key: 'adminpage', val: 'post-php' },
		rt.ArrayItem{ key: 'props', val: rt.create_array([
			rt.ArrayItem{ key: 'order_count', val: this.get_shop_order_count() },
		]) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) maybe_clear_ces_tracks_queue() {
	mut var_clear_ces_tracks_queue_for_page := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.clear_ces_tracks_queue_for_page_option_name(),
		rt.new_bool(false),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_clear_ces_tracks_queue_for_page)))) {
		return
	}
	mut var_queue := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.ces_tracks_queue_option_name(),
		rt.new_array(),
	])
	var_queue = if var_queue.clone().is_array() { var_queue } else { rt.new_array() }
	closure_2_fn := fn [var_clear_ces_tracks_queue_for_page] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_remaining_items := rt.call_function('array_filter', [
		var_queue.clone(), rt.new_closure(closure_2_fn)])
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.ces_tracks_queue_option_name(),
		rt.call_function('array_values', [var_remaining_items.clone()]),
	])
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.clear_ces_tracks_queue_for_page_option_name(),
		rt.new_bool(false),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) add_script_track_product_categories() {
	if rt.is_true(this.has_been_shown(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.add_product_categories_action_name())) {
		return
	}
	mut var_handle := rt.new_string('wc-tracks-customer-effort-score-product-categories')
	rt.call_function('wp_register_script', [var_handle.clone(),
		rt.new_string(''), rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.get_constant('WC_VERSION'), rt.new_bool(true)])
	rt.call_function('wp_enqueue_script', [var_handle.clone()])
	rt.call_function('wp_add_inline_script', [var_handle.clone(),
		this.get_script_track_edit_php(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.add_product_categories_action_name(), rt.call_function('__', [
			rt.new_string('How easy was it to add product category?'),
			rt.new_string('woocommerce'),
		]), rt.call_function('__', [
			rt.new_string('The product category details screen is easy to use.'),
			rt.new_string('woocommerce'),
		]), rt.call_function('__', [
			rt.new_string("The product category details screen's functionality meets my needs."),
			rt.new_string('woocommerce'),
		]))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) add_script_track_product_tags() {
	if rt.is_true(this.has_been_shown(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.add_product_tags_action_name())) {
		return
	}
	mut var_handle := rt.new_string('wc-tracks-customer-effort-score-product-tags')
	rt.call_function('wp_register_script', [var_handle.clone(),
		rt.new_string(''), rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.get_constant('WC_VERSION'), rt.new_bool(true)])
	rt.call_function('wp_enqueue_script', [var_handle.clone()])
	rt.call_function('wp_add_inline_script', [var_handle.clone(),
		this.get_script_track_edit_php(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.add_product_tags_action_name(), rt.call_function('__', [
			rt.new_string('How easy was it to add a product tag?'),
			rt.new_string('woocommerce'),
		]), rt.call_function('__', [
			rt.new_string('The product tag details screen is easy to use.'),
			rt.new_string('woocommerce'),
		]), rt.call_function('__', [
			rt.new_string("The product tag details screen's functionality meets my needs."),
			rt.new_string('woocommerce'),
		]))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) run_on_product_import() {
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('step')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('done'), rt.get_superglobal('_GET').array_get(rt.new_string('step')))))) {
		return
	}
	if rt.is_true(this.has_been_shown(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.import_products_action_name())) {
		return
	}
	this.enqueue_to_ces_tracks(rt.create_array([
		rt.ArrayItem{
			key: 'action'
			val: Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.import_products_action_name()
		},
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('How easy was it to import products?'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'firstQuestion', val: rt.call_function('__', [
			rt.new_string('The product import process is easy to complete.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'secondQuestion', val: rt.call_function('__', [
			rt.new_string('The product import process meets my needs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'onsubmit_label', val: this.onsubmit_label },
		rt.ArrayItem{ key: 'pagenow', val: 'product_page_product_importer' },
		rt.ArrayItem{ key: 'adminpage', val: 'product_page_product_importer' },
		rt.ArrayItem{ key: 'props', val: rt.array_to_object(rt.new_array()) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) run_on_update_options() {
	mut var_current_tab := rt.new_null()
	mut var_current_section := rt.new_null()
	if rt.is_true(this.has_been_shown(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.settings_change_action_name())) {
		return
	}
	mut var_props := rt.create_array([
		rt.ArrayItem{ key: 'settings_area', val: var_current_tab },
	])
	if rt.is_true(var_current_section) {
		var_props.array_set('settings_section', var_current_section.clone())
	}
	this.enqueue_to_ces_tracks(rt.create_array([
		rt.ArrayItem{
			key: 'action'
			val: Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.settings_change_action_name()
		},
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('How easy was it to update your settings?'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'firstQuestion', val: rt.call_function('__', [
			rt.new_string('The settings screen is easy to use.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'secondQuestion', val: rt.call_function('__', [
			rt.new_string("The settings screen's functionality meets my needs."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'onsubmit_label', val: this.onsubmit_label },
		rt.ArrayItem{ key: 'pagenow', val: 'woocommerce_page_wc-settings' },
		rt.ArrayItem{ key: 'adminpage', val: 'woocommerce_page_wc-settings' },
		rt.ArrayItem{ key: 'props', val: rt.array_to_object(var_props) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) run_on_add_product_attributes() {
	if rt.is_true(this.has_been_shown(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.add_product_attributes_action_name())) {
		return
	}
	this.enqueue_to_ces_tracks(rt.create_array([
		rt.ArrayItem{
			key: 'action'
			val: Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks.add_product_attributes_action_name()
		},
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('How easy was it to add a product attribute?'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'firstQuestion', val: rt.call_function('__', [
			rt.new_string('Product attributes are easy to use.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'secondQuestion', val: rt.call_function('__', [
			rt.new_string("Product attributes' functionality meets my needs."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'onsubmit_label', val: this.onsubmit_label },
		rt.ArrayItem{ key: 'pagenow', val: 'product_page_product_attributes' },
		rt.ArrayItem{ key: 'adminpage', val: 'product_page_product_attributes' },
		rt.ArrayItem{ key: 'props', val: rt.array_to_object(rt.new_array()) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) run_on_load_edit_php() {
	mut var_allowed_types := rt.create_array([rt.ArrayItem{ key: none, val: 'product' },
		rt.ArrayItem{ key: none, val: 'shop_order' }])
	mut var_post_type := rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'post_type')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_post_type.clone(), var_allowed_types.clone(), rt.new_bool(true)])))))
	{
		return
	}
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('s'))) {
		return
	}
	mut var_page_now := rt.new_string('edit-' + var_post_type.str())
	this.enqueue_ces_survey_for_search(var_post_type.clone(), var_page_now.clone(),
		rt.new_string('edit-php'))
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_customereffortscoretracks() &Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks{
		PhpObjectBase:  rt.PhpObjectBase{}
		onsubmit_label: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_product_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_order_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'enable_survey_enqueing_if_tracking_is_enabled' {
			this.enable_survey_enqueing_if_tracking_is_enabled()
			return rt.new_null()
		}
		'get_script_track_edit_php' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_script_track_edit_php(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_product_count' {
			return this.get_product_count()
		}
		'get_shop_order_count' {
			return this.get_shop_order_count()
		}
		'has_been_shown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.has_been_shown(dispatch_arg_0)
		}
		'enqueue_to_ces_tracks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.enqueue_to_ces_tracks(dispatch_arg_0)
			return rt.new_null()
		}
		'enqueue_ces_survey_for_search' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_ces_survey_for_search(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'run_on_transition_post_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.run_on_transition_post_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'maybe_enqueue_ces_survey_for_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.maybe_enqueue_ces_survey_for_product(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'enqueue_ces_survey_for_new_product' {
			this.enqueue_ces_survey_for_new_product()
			return rt.new_null()
		}
		'enqueue_ces_survey_for_edited_product' {
			this.enqueue_ces_survey_for_edited_product()
			return rt.new_null()
		}
		'enqueue_ces_survey_for_edited_shop_order' {
			this.enqueue_ces_survey_for_edited_shop_order()
			return rt.new_null()
		}
		'maybe_clear_ces_tracks_queue' {
			this.maybe_clear_ces_tracks_queue()
			return rt.new_null()
		}
		'add_script_track_product_categories' {
			this.add_script_track_product_categories()
			return rt.new_null()
		}
		'add_script_track_product_tags' {
			this.add_script_track_product_tags()
			return rt.new_null()
		}
		'run_on_product_import' {
			this.run_on_product_import()
			return rt.new_null()
		}
		'run_on_update_options' {
			this.run_on_update_options()
			return rt.new_null()
		}
		'run_on_add_product_attributes' {
			this.run_on_add_product_attributes()
			return rt.new_null()
		}
		'run_on_load_edit_php' {
			this.run_on_load_edit_php()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'onsubmit_label' { return this.onsubmit_label }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CustomerEffortScoreTracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'onsubmit_label' {
			this.onsubmit_label = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

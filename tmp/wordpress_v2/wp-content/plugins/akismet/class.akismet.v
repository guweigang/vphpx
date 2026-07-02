import rt

pub fn Class_Akismet.api_host() string {
	return 'rest.akismet.com'
}
pub fn Class_Akismet.api_port() i64 {
	return 80
}
pub fn Class_Akismet.max_delay_before_moderation_email() i64 {
	return 86400
}
pub fn Class_Akismet.alert_code_commercial() i64 {
	return 30001
}
pub fn Class_Akismet.user_status_active() string {
	return 'active'
}
pub fn Class_Akismet.user_status_no_sub() string {
	return 'no-sub'
}
pub fn Class_Akismet.user_status_missing() string {
	return 'missing'
}
pub fn Class_Akismet.user_status_cancelled() string {
	return 'cancelled'
}
pub fn Class_Akismet.user_status_suspended() string {
	return 'suspended'
}
pub fn Class_Akismet.key_status_valid() string {
	return 'valid'
}
pub fn Class_Akismet.key_status_invalid() string {
	return 'invalid'
}
pub fn Class_Akismet.key_status_failed() string {
	return 'failed'
}
struct Class_Akismet {
	rt.PhpObjectBase
}

fn init_static_akismet() {
		rt.init_static_prop('Akismet', 'limit_notices', rt.create_array([rt.ArrayItem{ key: 10501, val: 'FIRST_MONTH_OVER_LIMIT' }, rt.ArrayItem{ key: 10502, val: 'SECOND_MONTH_OVER_LIMIT' }, rt.ArrayItem{ key: 10504, val: 'THIRD_MONTH_APPROACHING_LIMIT' }, rt.ArrayItem{ key: 10508, val: 'THIRD_MONTH_OVER_LIMIT' }, rt.ArrayItem{ key: 10516, val: 'FOUR_PLUS_MONTHS_OVER_LIMIT' }]))
		rt.init_static_prop('Akismet', 'last_comment', rt.new_string(''))
		rt.init_static_prop('Akismet', 'initiated', rt.new_bool(false))
		rt.init_static_prop('Akismet', 'last_comment_result', rt.new_null())
		rt.init_static_prop('Akismet', 'comment_as_submitted_allowed_keys', rt.create_array([rt.ArrayItem{ key: 'blog', val: '' }, rt.ArrayItem{ key: 'blog_charset', val: '' }, rt.ArrayItem{ key: 'blog_lang', val: '' }, rt.ArrayItem{ key: 'blog_ua', val: '' }, rt.ArrayItem{ key: 'comment_agent', val: '' }, rt.ArrayItem{ key: 'comment_author', val: '' }, rt.ArrayItem{ key: 'comment_author_IP', val: '' }, rt.ArrayItem{ key: 'comment_author_email', val: '' }, rt.ArrayItem{ key: 'comment_author_url', val: '' }, rt.ArrayItem{ key: 'comment_content', val: '' }, rt.ArrayItem{ key: 'comment_date_gmt', val: '' }, rt.ArrayItem{ key: 'comment_tags', val: '' }, rt.ArrayItem{ key: 'comment_type', val: '' }, rt.ArrayItem{ key: 'guid', val: '' }, rt.ArrayItem{ key: 'is_test', val: '' }, rt.ArrayItem{ key: 'permalink', val: '' }, rt.ArrayItem{ key: 'reporter', val: '' }, rt.ArrayItem{ key: 'site_domain', val: '' }, rt.ArrayItem{ key: 'submit_referer', val: '' }, rt.ArrayItem{ key: 'submit_uri', val: '' }, rt.ArrayItem{ key: 'user_ID', val: '' }, rt.ArrayItem{ key: 'user_agent', val: '' }, rt.ArrayItem{ key: 'user_id', val: '' }, rt.ArrayItem{ key: 'user_ip', val: '' }]))
}

fn Class_Akismet.init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Akismet', 'initiated'))))) {
		Class_Akismet.init_hooks()
	}
}

fn Class_Akismet.init_hooks() {
	rt.set_static_prop('Akismet', 'initiated', rt.new_bool(true))
	rt.call_function('add_action', [rt.new_string('wp_insert_comment'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'auto_check_update_meta' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_insert_comment'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'schedule_email_fallback' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_insert_comment'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'schedule_approval_fallback' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('preprocess_comment'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'auto_check_comment' }]), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('rest_pre_insert_comment'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'rest_auto_check_comment' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('comment_form'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'load_form_js' }])])
	rt.call_function('add_action', [rt.new_string('do_shortcode_tag'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'load_form_js_via_filter' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('akismet_scheduled_delete'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'delete_old_comments' }])])
	rt.call_function('add_action', [rt.new_string('akismet_scheduled_delete'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'delete_old_comments_meta' }])])
	rt.call_function('add_action', [rt.new_string('akismet_scheduled_delete'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'delete_orphaned_commentmeta' }])])
	rt.call_function('add_action', [rt.new_string('akismet_schedule_cron_recheck'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'cron_recheck' }])])
	rt.call_function('add_action', [rt.new_string('akismet_email_fallback'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'email_fallback' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('akismet_approval_fallback'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'approval_fallback' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('comment_form'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'add_comment_nonce' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('comment_form'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'output_custom_form_fields' }])])
	rt.call_function('add_filter', [rt.new_string('script_loader_tag'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'set_form_js_async' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('notify_moderator'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'disable_emails_if_unreachable' }]), rt.new_int(1000), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('notify_post_author'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'disable_emails_if_unreachable' }]), rt.new_int(1000), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('pre_comment_approved'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'last_comment_status' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('transition_comment_status'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'transition_comment_status' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('xmlrpc_call'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'pre_check_pingback' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('jetpack_options_whitelist'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'add_to_jetpack_options_whitelist' }])])
	rt.call_function('add_filter', [rt.new_string('jetpack_contact_form_html'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'inject_custom_form_fields' }])])
	rt.call_function('add_filter', [rt.new_string('jetpack_contact_form_akismet_values'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'prepare_custom_form_values' }])])
	rt.call_function('add_filter', [rt.new_string('gform_get_form_filter'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'inject_custom_form_fields' }])])
	rt.call_function('add_filter', [rt.new_string('gform_akismet_fields'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'prepare_custom_form_values' }])])
	rt.call_function('add_filter', [rt.new_string('wpcf7_form_elements'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'append_custom_form_fields' }])])
	rt.call_function('add_filter', [rt.new_string('wpcf7_akismet_parameters'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'prepare_custom_form_values' }])])
	rt.call_function('add_filter', [rt.new_string('frm_filter_final_form'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'inject_custom_form_fields' }])])
	rt.call_function('add_filter', [rt.new_string('frm_akismet_values'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'prepare_custom_form_values' }])])
	rt.call_function('add_filter', [rt.new_string('fluentform_form_element_start'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'output_custom_form_fields' }])])
	rt.call_function('add_filter', [rt.new_string('fluentform_akismet_fields'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'prepare_custom_form_values' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('fluentform/form_element_start'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'output_custom_form_fields' }])])
	rt.call_function('add_filter', [rt.new_string('fluentform/akismet_fields'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'prepare_custom_form_values' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('update_option_wordpress_api_key'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'updated_option' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('add_option_wordpress_api_key'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'added_option' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('comment_form_after'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' }, rt.ArrayItem{ key: none, val: 'display_comment_form_privacy_notice' }])])
}

fn Class_Akismet.get_api_key() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('akismet_get_api_key'), if rt.is_true(rt.call_function('defined', [rt.new_string('WPCOM_API_KEY')])) { rt.call_function('constant', [rt.new_string('WPCOM_API_KEY')]) } else { rt.call_function('get_option', [rt.new_string('wordpress_api_key')]) }])
}

fn Class_Akismet.get_access_token() rt.PhpVal {
	mut var_access_token := rt.new_null()
	if rt.is_true(rt.new_bool(var_access_token.clone().is_null())) {
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'api_key', val: Class_Akismet.get_api_key() }])
	var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.clone(), rt.new_string('token')])
	mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_request_args.clone()), rt.new_string('token'))
	var_access_token = var_response.array_get(rt.new_int(1))
	}
	return var_access_token.clone()
}

fn Class_Akismet.check_key_status(var_key rt.PhpVal, var_ip rt.PhpVal) rt.PhpVal {
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'key', val: var_key }, rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }])
	var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.clone(), rt.new_string('verify-key')])
	return Class_Akismet.http_post(Class_Akismet.build_query(var_request_args.clone()), rt.new_string('verify-key'), var_ip.clone())
}

fn Class_Akismet.verify_key(var_key rt.PhpVal, var_ip rt.PhpVal) string {
	if rt.is_true(rt.new_bool(var_key.clone().to_string().len != 12)) {
		return 'invalid'
	}
	mut var_response := Class_Akismet.check_key_status(var_key.clone(), var_ip.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_response.array_get(rt.new_int(1)), rt.new_string('valid'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_response.array_get(rt.new_int(1)), rt.new_string('invalid'))))) {
		return 'failed'
	}
	return (var_response.array_get(rt.new_int(1))).str()
}

fn Class_Akismet.deactivate_key(var_key rt.PhpVal) string {
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'key', val: var_key }, rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }])
	var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.clone(), rt.new_string('deactivate')])
	mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_request_args.clone()), rt.new_string('deactivate'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_response.array_get(rt.new_int(1)), rt.new_string('deactivated'))))) {
		return 'failed'
	}
	return (var_response.array_get(rt.new_int(1))).str()
}

fn Class_Akismet.get_stats(interval string, var_api_key rt.PhpVal) bool {
	mut interval_mutated := interval
	mut var_api_key_mutated := var_api_key
	if rt.is_true(rt.new_bool(var_api_key_mutated.clone().is_null())) {
	var_api_key_mutated = Class_Akismet.get_api_key()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_api_key_mutated)))) {
		return false
	}
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }, rt.ArrayItem{ key: 'key', val: var_api_key_mutated }, rt.ArrayItem{ key: 'from', val: interval_mutated }])
	var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.clone(), rt.new_string('get-stats')])
	mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_request_args.clone()), rt.new_string('get-stats'))
	if !rt.is_true(var_response.array_get(rt.new_int(1))) {
		return false
	}
	mut var_data := rt.call_function('json_decode', [var_response.array_get(rt.new_int(1))])
	if !(var_data.clone().is_object()) {
		return false
	}
	if !(rt.get_property(var_data, 'spam')).is_null() {
		rt.set_property(var_data, 'spam', rt.new_int((rt.get_property(var_data, 'spam')).to_i64()))
	}
	if !(rt.get_property(var_data, 'ham')).is_null() {
		rt.set_property(var_data, 'ham', rt.new_int((rt.get_property(var_data, 'ham')).to_i64()))
	}
	if !(rt.get_property(var_data, 'missed_spam')).is_null() {
		rt.set_property(var_data, 'missed_spam', rt.new_int((rt.get_property(var_data, 'missed_spam')).to_i64()))
	}
	if !(rt.get_property(var_data, 'false_positives')).is_null() {
		rt.set_property(var_data, 'false_positives', rt.new_int((rt.get_property(var_data, 'false_positives')).to_i64()))
	}
	if !(rt.get_property(var_data, 'accuracy')).is_null() {
		rt.set_property(var_data, 'accuracy', rt.new_float((rt.get_property(var_data, 'accuracy')).to_f64()))
	}
	if !(rt.get_property(var_data, 'time_saved')).is_null() {
		rt.set_property(var_data, 'time_saved', rt.new_int((rt.get_property(var_data, 'time_saved')).to_i64()))
	}
	if !(rt.get_property(var_data, 'breakdown')).is_null() && rt.get_property(var_data, 'breakdown').is_object() {
		mut iter_1 := rt.get_property(var_data, 'breakdown').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_stats := item_1.val
			mut var_period := item_1.key
			if !(var_stats.clone().is_object()) {
				continue
			}
			if !(rt.get_property(var_stats, 'spam')).is_null() {
				rt.set_property(var_stats, 'spam', rt.new_int((rt.get_property(var_stats, 'spam')).to_i64()))
			}
			if !(rt.get_property(var_stats, 'ham')).is_null() {
				rt.set_property(var_stats, 'ham', rt.new_int((rt.get_property(var_stats, 'ham')).to_i64()))
			}
			if !(rt.get_property(var_stats, 'missed_spam')).is_null() {
				rt.set_property(var_stats, 'missed_spam', rt.new_int((rt.get_property(var_stats, 'missed_spam')).to_i64()))
			}
			if !(rt.get_property(var_stats, 'false_positives')).is_null() {
				rt.set_property(var_stats, 'false_positives', rt.new_int((rt.get_property(var_stats, 'false_positives')).to_i64()))
			}
		}
	}
	return (var_data).to_bool()
}

fn Class_Akismet.comment_check(var_comment_data rt.PhpVal, var_api_key rt.PhpVal) bool {
	mut var_api_key_mutated := var_api_key
	if rt.is_true(rt.new_bool(var_api_key_mutated.clone().is_null())) {
	var_api_key_mutated = Class_Akismet.get_api_key()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_api_key_mutated)))) {
		return false
	}
	mut var_request := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }, rt.ArrayItem{ key: 'blog_lang', val: rt.call_function('get_locale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'blog_charset', val: rt.call_function('get_option', [rt.new_string('blog_charset')]) }, rt.ArrayItem{ key: 'user_ip', val: Class_Akismet.get_ip_address() }, rt.ArrayItem{ key: 'user_agent', val: Class_Akismet.get_user_agent() }]), var_comment_data.clone()])
	var_request = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request.clone(), rt.new_string('comment-check')])
	mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_request.clone()), rt.new_string('comment-check'))
	if !rt.is_true(var_response.array_get(rt.new_int(1))) {
		return false
	}
	mut var_result := rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'is_spam', val: rt.identical(rt.new_string('true'), var_response.array_get(rt.new_int(1))) }]))
	if var_response.array_get(rt.new_int(0)).array_isset(rt.new_string('x-akismet-pro-tip')) {
		rt.set_property(var_result, 'pro_tip', var_response.array_get(rt.new_int(0)).array_get(rt.new_string('x-akismet-pro-tip')))
	}
	if var_response.array_get(rt.new_int(0)).array_isset(rt.new_string('x-akismet-guid')) {
		rt.set_property(var_result, 'guid', var_response.array_get(rt.new_int(0)).array_get(rt.new_string('x-akismet-guid')))
	}
	if var_response.array_get(rt.new_int(0)).array_isset(rt.new_string('x-akismet-error')) {
		rt.set_property(var_result, 'error', var_response.array_get(rt.new_int(0)).array_get(rt.new_string('x-akismet-error')))
	}
	if var_response.array_get(rt.new_int(0)).array_isset(rt.new_string('x-akismet-debug-help')) {
		rt.set_property(var_result, 'debug_help', var_response.array_get(rt.new_int(0)).array_get(rt.new_string('x-akismet-debug-help')))
	}
	return (var_result).to_bool()
}

fn Class_Akismet.add_to_jetpack_options_whitelist(var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	var_options_mutated.array_push('wordpress_api_key')
	return var_options_mutated.clone()
}

fn Class_Akismet.updated_option(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WPCOM_JSON_API_Update_Option_Endpoint')]))))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_old_value, var_value_mutated)))) {
		Class_Akismet.verify_key(var_value_mutated.clone())
	}
}

fn Class_Akismet.added_option(var_option_name rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_option_name_mutated := var_option_name
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string('wordpress_api_key'), var_option_name_mutated)) {
		return Class_Akismet.updated_option(rt.new_string(''), var_value_mutated.clone())
	}
	return rt.new_null()
}

fn Class_Akismet.rest_auto_check_comment(var_commentdata rt.PhpVal) rt.PhpVal {
	mut var_commentdata_mutated := var_commentdata
	return Class_Akismet.auto_check_comment((var_commentdata_mutated).str(), rt.new_string('rest_api'))
}

fn Class_Akismet.auto_check_comment(var_commentdata rt.PhpVal, context string) rt.PhpVal {
	mut var_commentdata_mutated := var_commentdata
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Akismet.get_api_key())))) {
		return var_commentdata_mutated.clone()
	}
	if !(var_commentdata_mutated.array_isset(rt.new_string('comment_meta'))) {
		var_commentdata_mutated.array_set('comment_meta', rt.new_array())
	}
	rt.set_static_prop('Akismet', 'last_comment_result', rt.new_null())
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_check_comment_disallowed_list')])) {
		mut var_comment_author := if var_commentdata_mutated.array_isset(rt.new_string('comment_author')) { var_commentdata_mutated.array_get(rt.new_string('comment_author')) } else { rt.new_string('') }
		mut var_comment_author_email := if var_commentdata_mutated.array_isset(rt.new_string('comment_author_email')) { var_commentdata_mutated.array_get(rt.new_string('comment_author_email')) } else { rt.new_string('') }
		mut var_comment_author_url := if var_commentdata_mutated.array_isset(rt.new_string('comment_author_url')) { var_commentdata_mutated.array_get(rt.new_string('comment_author_url')) } else { rt.new_string('') }
		mut var_comment_content := if var_commentdata_mutated.array_isset(rt.new_string('comment_content')) { var_commentdata_mutated.array_get(rt.new_string('comment_content')) } else { rt.new_string('') }
		mut var_comment_author_ip := if var_commentdata_mutated.array_isset(rt.new_string('comment_author_IP')) { var_commentdata_mutated.array_get(rt.new_string('comment_author_IP')) } else { rt.new_string('') }
		mut var_comment_agent := if var_commentdata_mutated.array_isset(rt.new_string('comment_agent')) { var_commentdata_mutated.array_get(rt.new_string('comment_agent')) } else { rt.new_string('') }
		if rt.is_true(rt.call_function('wp_check_comment_disallowed_list', [var_comment_author.clone(), var_comment_author_email.clone(), var_comment_author_url.clone(), var_comment_content.clone(), var_comment_author_ip.clone(), var_comment_agent.clone()])) {
			var_commentdata_mutated.array_set('akismet_result', 'skipped')
			var_commentdata_mutated.array_get_mut('comment_meta').array_set('akismet_result', 'skipped')
			var_commentdata_mutated.array_set('akismet_skipped_microtime', rt.call_function('microtime', [rt.new_bool(true)]))
			var_commentdata_mutated.array_get_mut('comment_meta').array_set('akismet_skipped_microtime', var_commentdata_mutated.array_get(rt.new_string('akismet_skipped_microtime')))
			Class_Akismet.set_last_comment(var_commentdata_mutated.clone())
			return var_commentdata_mutated.clone()
		}
	}
	mut var_comment := var_commentdata_mutated.clone()
	var_comment.array_set('user_ip', Class_Akismet.get_ip_address())
	var_comment.array_set('user_agent', Class_Akismet.get_user_agent())
	var_comment.array_set('referrer', Class_Akismet.get_referer())
	var_comment.array_set('blog', rt.call_function('get_option', [rt.new_string('home')]))
	var_comment.array_set('blog_lang', rt.call_function('get_locale', []rt.PhpVal{}))
	var_comment.array_set('blog_charset', rt.call_function('get_option', [rt.new_string('blog_charset')]))
	var_comment.array_set('permalink', rt.call_function('get_permalink', [var_comment.array_get(rt.new_string('comment_post_ID'))]))
	if !(!rt.is_true(var_comment.array_get(rt.new_string('user_ID')))) {
		var_comment.array_set('user_role', Class_Akismet.get_user_roles(var_comment.array_get(rt.new_string('user_ID'))))
	}
	mut var_akismet_nonce_option := rt.call_function('apply_filters', [rt.new_string('akismet_comment_nonce'), rt.call_function('get_option', [rt.new_string('akismet_comment_nonce')])])
	var_comment.array_set('akismet_comment_nonce', 'inactive')
	if rt.is_true(rt.equal(var_akismet_nonce_option, rt.new_string('true'))) || rt.is_true(rt.equal(var_akismet_nonce_option, rt.new_string(''))) {
		var_comment.array_set('akismet_comment_nonce', 'failed')
		if rt.get_superglobal('_POST').array_isset(rt.new_string('akismet_comment_nonce')) && rt.get_superglobal('_POST').array_get(rt.new_string('akismet_comment_nonce')).is_string() && rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_POST').array_get(rt.new_string('akismet_comment_nonce')), rt.new_string('akismet_comment_nonce_' + (var_comment.array_get(rt.new_string('comment_post_ID'))).str())])) {
			var_comment.array_set('akismet_comment_nonce', 'passed')
		}
		if rt.get_superglobal('_POST').array_isset(rt.new_string('_ajax_nonce-replyto-comment')) && rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('replyto-comment'), rt.new_string('_ajax_nonce-replyto-comment')])) {
			var_comment.array_set('akismet_comment_nonce', 'passed')
		}
	}
	if rt.is_true(Class_Akismet.is_test_mode()) {
		var_comment.array_set('is_test', 'true')
	}
	mut iter_2 := rt.get_superglobal('_POST').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		if rt.is_true(rt.new_bool(var_value.clone().is_string())) {
			var_comment.array_set("POST_${var_key.to_string()}", var_value.clone())
		}
	}
	mut iter_3 := rt.get_superglobal('_SERVER').iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		if !(var_value.clone().is_string()) {
			continue
		}
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^HTTP_COOKIE/'), var_key.clone()])) {
			continue
		}
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(HTTP_|REMOTE_ADDR|REQUEST_URI|DOCUMENT_URI)/'), var_key.clone()])) {
			var_comment.array_set("${var_key.to_string()}", var_value.clone())
		}
	}
	mut var_post := rt.call_function('get_post', [var_comment.array_get(rt.new_string('comment_post_ID'))])
	if !(var_post.clone().is_null()) {
		var_comment.array_set('comment_post_modified_gmt', rt.get_property(var_post, 'post_modified_gmt'))
		var_comment.array_set('comment_context', rt.new_array())
		mut var_tag_names := rt.call_function('wp_get_post_tags', [rt.get_property(var_post, 'ID'), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'names' }])])
		if rt.is_true(var_tag_names) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_tag_names.clone()]))))) {
			mut iter_4 := var_tag_names.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_tag_name := item_4.val
				var_comment.array_get_mut('comment_context').array_push(var_tag_name.clone())
			}
		}
		mut var_category_names := rt.call_function('wp_get_post_categories', [rt.get_property(var_post, 'ID'), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'names' }])])
		if rt.is_true(var_category_names) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_category_names.clone()]))))) {
			mut iter_5 := var_category_names.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_category_name := item_5.val
				var_comment.array_get_mut('comment_context').array_push(var_category_name.clone())
			}
		}
	}
	var_comment.array_set('callback', rt.call_function('get_rest_url', [rt.new_null(), rt.new_string('akismet/v1/webhook')]))
	var_comment = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_comment.clone(), rt.new_string('comment-check')])
	mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_comment.clone()), rt.new_string('comment-check'))
	rt.call_function('do_action', [rt.new_string('akismet_comment_check_response'), var_response.clone()])
	var_commentdata_mutated.array_set('comment_as_submitted', rt.call_function('array_intersect_key', [var_comment.clone(), rt.get_static_prop('Akismet', 'comment_as_submitted_allowed_keys')]))
	mut iter_6 := rt.get_superglobal('_POST').iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value := item_6.val
		mut var_key := item_6.key
		if var_value.clone().is_string() && rt.is_true(rt.identical(rt.call_function('strpos', [var_key.clone(), rt.new_string('ak_')]), rt.new_int(0))) {
			var_commentdata_mutated.array_get_mut('comment_as_submitted').array_set('POST_' + (var_key).str(), var_value.clone())
		}
	}
	var_commentdata_mutated.array_set('akismet_result', var_response.array_get(rt.new_int(1)))
	if rt.is_true(rt.identical(rt.new_string('true'), var_response.array_get(rt.new_int(1)))) || rt.is_true(rt.identical(rt.new_string('false'), var_response.array_get(rt.new_int(1)))) {
		var_commentdata_mutated.array_get_mut('comment_meta').array_set('akismet_result', var_response.array_get(rt.new_int(1)))
	} else {
		var_commentdata_mutated.array_get_mut('comment_meta').array_set('akismet_error', rt.call_function('time', []rt.PhpVal{}))
	}
	if var_response.array_get(rt.new_int(0)).array_isset(rt.new_string('x-akismet-pro-tip')) {
		var_commentdata_mutated.array_set('akismet_pro_tip', var_response.array_get(rt.new_int(0)).array_get(rt.new_string('x-akismet-pro-tip')))
		var_commentdata_mutated.array_get_mut('comment_meta').array_set('akismet_pro_tip', var_response.array_get(rt.new_int(0)).array_get(rt.new_string('x-akismet-pro-tip')))
	}
	if var_response.array_get(rt.new_int(0)).array_isset(rt.new_string('x-akismet-guid')) {
		var_commentdata_mutated.array_set('akismet_guid', var_response.array_get(rt.new_int(0)).array_get(rt.new_string('x-akismet-guid')))
		var_commentdata_mutated.array_get_mut('comment_meta').array_set('akismet_guid', var_response.array_get(rt.new_int(0)).array_get(rt.new_string('x-akismet-guid')))
		if rt.is_true(rt.identical(rt.new_string('false'), var_response.array_get(rt.new_int(1)))) {
			if var_response.array_get(rt.new_int(0)).array_isset(rt.new_string('X-akismet-recheck-after')) {
				var_commentdata_mutated.array_set('comment_approved', '0')
				rt.set_static_prop('Akismet', 'last_comment_result', rt.new_string('0'))
				mut var_delay := rt.mul(var_response.array_get(rt.new_int(0)).array_get(rt.new_string('X-akismet-recheck-after')), rt.new_int(2))
				var_commentdata_mutated.array_get_mut('comment_meta').array_set('akismet_schedule_approval_fallback', var_delay.clone())
				var_commentdata_mutated.array_get_mut('comment_meta').array_set('akismet_delay_moderation_email', true)
				Class_Akismet.log(rt.new_string('Delaying moderation email for comment from ' + (var_commentdata_mutated.array_get(rt.new_string('comment_author'))).str() + ' for ' + (var_delay).str() + ' seconds'))
				var_commentdata_mutated.array_get_mut('comment_meta').array_set('akismet_schedule_email_fallback', var_delay.clone())
			}
		}
	}
	var_commentdata_mutated.array_get_mut('comment_meta').array_set('akismet_as_submitted', var_commentdata_mutated.array_get(rt.new_string('comment_as_submitted')))
	if var_response.array_get(rt.new_int(0)).array_isset(rt.new_string('x-akismet-error')) {
		rt.set_static_prop('Akismet', 'last_comment_result', rt.new_string('0'))
	} else if rt.is_true(rt.equal(rt.new_string('true'), var_response.array_get(rt.new_int(1)))) {
		rt.set_static_prop('Akismet', 'last_comment_result', rt.new_string('spam'))
		mut var_discard := rt.new_bool(var_commentdata_mutated.array_isset(rt.new_string('akismet_pro_tip')) && rt.is_true(rt.identical(var_commentdata_mutated.array_get(rt.new_string('akismet_pro_tip')), rt.new_string('discard'))) && rt.is_true(Class_Akismet.allow_discard()))
		rt.call_function('do_action', [rt.new_string('akismet_spam_caught'), var_discard.clone()])
		if rt.is_true(var_discard) {
			mut var_incr := rt.call_function('apply_filters', [rt.new_string('akismet_spam_count_incr'), rt.new_int(1)])
			if rt.is_true(var_incr) {
				rt.call_function('update_option', [rt.new_string('akismet_spam_count'), rt.add(rt.call_function('get_option', [rt.new_string('akismet_spam_count')]), var_incr)])
			}
			if rt.is_true(rt.identical(rt.new_string('rest_api'), rt.new_string(context))) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('akismet_rest_comment_discarded'), rt.call_function('__', [rt.new_string('Comment discarded.'), rt.new_string('akismet')])))
			} else if rt.is_true(rt.identical(rt.new_string('xml-rpc'), rt.new_string(context))) {
				return var_commentdata_mutated.clone()
			} else {
				mut var_redirect_to := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_REFERER')) { rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER')) } else { if rt.is_true(var_post) { rt.call_function('get_permalink', [var_post.clone()]) } else { rt.call_function('home_url', []rt.PhpVal{}) } }
				rt.call_function('wp_safe_redirect', [rt.call_function('esc_url_raw', [var_redirect_to.clone()])])
				exit(0)
			}
		} else if rt.is_true(rt.identical(rt.new_string('rest_api'), rt.new_string(context))) {
			var_commentdata_mutated.array_set('comment_approved', 'spam')
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string('true'), var_response.array_get(rt.new_int(1)))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string('false'), var_response.array_get(rt.new_int(1)))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))) {
			rt.set_static_prop('Akismet', 'last_comment_result', rt.new_string('0'))
		}
		var_commentdata_mutated.array_get_mut('comment_meta').array_set('akismet_delay_moderation_email', true)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('akismet_schedule_cron_recheck')]))))) {
			rt.call_function('wp_schedule_single_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(1200)), rt.new_string('akismet_schedule_cron_recheck')])
			rt.call_function('do_action', [rt.new_string('akismet_scheduled_recheck'), rt.new_string('invalid-response-' + (var_response.array_get(rt.new_int(1))).str())])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('akismet_scheduled_delete')]))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}), rt.new_string('daily'), rt.new_string('akismet_scheduled_delete')])
	}
	Class_Akismet.set_last_comment(var_commentdata_mutated.clone())
	Class_Akismet.fix_scheduled_recheck()
	return var_commentdata_mutated.clone()
}

fn Class_Akismet.get_last_comment() rt.PhpVal {
	return rt.get_static_prop('Akismet', 'last_comment')
}

fn Class_Akismet.set_last_comment(var_comment rt.PhpVal) {
	mut var_comment_mutated := var_comment
	if rt.is_true(rt.new_bool(var_comment_mutated.clone().is_null())) {
		rt.set_static_prop('Akismet', 'last_comment', rt.new_null())
	} else {
		rt.set_static_prop('Akismet', 'last_comment', rt.call_function('wp_filter_comment', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'comment_author_IP', val: Class_Akismet.get_ip_address() }]), var_comment_mutated.clone()])]))
	}
}

fn Class_Akismet.auto_check_update_meta(var_id rt.PhpVal, var_comment rt.PhpVal) {
	mut var_comment_mutated := var_comment
	if var_comment_mutated.clone().is_object() && !(!rt.is_true(rt.get_static_prop('Akismet', 'last_comment'))) && rt.get_static_prop('Akismet', 'last_comment').is_array() {
		if rt.is_true(Class_Akismet.matches_last_comment_by_id(var_id.clone())) {
			if rt.get_static_prop('Akismet', 'last_comment').array_isset(rt.new_string('akismet_result')) && rt.is_true(rt.equal(rt.get_static_prop('Akismet', 'last_comment').array_get(rt.new_string('akismet_result')), rt.new_string('true'))) {
				Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('check-spam'))
				if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.get_property(var_comment_mutated, 'comment_approved'), rt.new_string('spam'))))) {
					Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('status-changed-' + (rt.get_property(var_comment_mutated, 'comment_approved')).str()))
				}
			} else if rt.get_static_prop('Akismet', 'last_comment').array_isset(rt.new_string('akismet_result')) && rt.is_true(rt.equal(rt.get_static_prop('Akismet', 'last_comment').array_get(rt.new_string('akismet_result')), rt.new_string('false'))) {
				if rt.is_true(rt.call_function('get_comment_meta', [rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string('akismet_schedule_approval_fallback'), rt.new_bool(true)])) {
					Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('check-ham-pending'))
				} else {
					Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('check-ham'))
				}
				if rt.is_true(rt.equal(rt.get_property(var_comment_mutated, 'comment_approved'), rt.new_string('spam'))) || rt.is_true(rt.equal(rt.get_property(var_comment_mutated, 'comment_approved'), rt.new_string('trash'))) {
					if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_check_comment_disallowed_list')])) {
						if rt.is_true(rt.call_function('wp_check_comment_disallowed_list', [rt.get_property(var_comment_mutated, 'comment_author'), rt.get_property(var_comment_mutated, 'comment_author_email'), rt.get_property(var_comment_mutated, 'comment_author_url'), rt.get_property(var_comment_mutated, 'comment_content'), rt.get_property(var_comment_mutated, 'comment_author_IP'), rt.get_property(var_comment_mutated, 'comment_agent')])) {
							Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('wp-disallowed'))
						} else {
							Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('status-changed-' + (rt.get_property(var_comment_mutated, 'comment_approved')).str()))
						}
					} else {
						Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('status-changed-' + (rt.get_property(var_comment_mutated, 'comment_approved')).str()))
					}
				}
			} else if rt.get_static_prop('Akismet', 'last_comment').array_isset(rt.new_string('akismet_result')) && rt.is_true(rt.equal(rt.new_string('skipped'), rt.get_static_prop('Akismet', 'last_comment').array_get(rt.new_string('akismet_result')))) {
				Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('wp-disallowed'))
				Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('akismet-skipped-disallowed'))
			} else {
				if !(rt.get_static_prop('Akismet', 'last_comment').array_isset(rt.new_string('akismet_result'))) {
					Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('akismet-skipped'))
				} else {
					Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('check-error'), rt.create_array([rt.ArrayItem{ key: 'response', val: rt.call_function('substr', [rt.get_static_prop('Akismet', 'last_comment').array_get(rt.new_string('akismet_result')), rt.new_int(0), rt.new_int(50)]) }]))
				}
			}
		}
	}
}

fn Class_Akismet.schedule_email_fallback(var_id rt.PhpVal, var_comment rt.PhpVal) {
	mut var_comment_mutated := var_comment
	Class_Akismet.log(rt.new_string('Checking whether to schedule_email_fallback for comment #' + (var_id).str()))
	mut var_email_delay := rt.call_function('get_comment_meta', [var_id.clone(), rt.new_string('akismet_schedule_email_fallback'), rt.new_bool(true)])
	if rt.is_true(var_email_delay) {
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_schedule_email_fallback')])
		rt.call_function('wp_schedule_single_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), var_email_delay), rt.new_string('akismet_email_fallback'), rt.create_array([rt.ArrayItem{ key: none, val: var_id }])])
		Class_Akismet.log(rt.new_string('Scheduled email fallback for ' + (rt.add(rt.call_function('time', []rt.PhpVal{}), var_email_delay)).str() + ' for comment #' + (var_id).str()))
	} else {
		Class_Akismet.log(rt.new_string('No need to schedule_email_fallback for comment #' + (var_id).str()))
	}
}

fn Class_Akismet.email_fallback(var_comment_id rt.PhpVal) {
	mut var_comment_id_mutated := var_comment_id
	Class_Akismet.log(rt.new_string('In email fallback for comment #' + (var_comment_id_mutated).str()))
	if rt.is_true(rt.call_function('get_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_delayed_moderation_email'), rt.new_bool(true)])) {
		Class_Akismet.log(rt.new_string('Triggering notification emails for comment #' + (var_comment_id_mutated).str() + '. They will be sent if comment is not spam.'))
		rt.call_function('delete_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_delayed_moderation_email')])
		rt.call_function('wp_new_comment_notify_moderator', [var_comment_id_mutated.clone()])
		rt.call_function('wp_new_comment_notify_postauthor', [var_comment_id_mutated.clone()])
	} else {
		Class_Akismet.log(rt.new_string('No need to send fallback email for comment #' + (var_comment_id_mutated).str()))
	}
	rt.call_function('delete_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_delay_moderation_email')])
}

fn Class_Akismet.schedule_approval_fallback(var_id rt.PhpVal, var_comment rt.PhpVal) {
	mut var_comment_mutated := var_comment
	Class_Akismet.log(rt.new_string('Checking whether to schedule_approval_fallback for comment #' + (var_id).str()))
	mut var_approval_delay := rt.call_function('get_comment_meta', [var_id.clone(), rt.new_string('akismet_schedule_approval_fallback'), rt.new_bool(true)])
	if rt.is_true(var_approval_delay) {
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_schedule_approval_fallback')])
		rt.call_function('wp_schedule_single_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), var_approval_delay), rt.new_string('akismet_approval_fallback'), rt.create_array([rt.ArrayItem{ key: none, val: var_id }])])
		Class_Akismet.log(rt.new_string('Scheduled approval fallback for ' + (rt.add(rt.call_function('time', []rt.PhpVal{}), var_approval_delay)).str() + ' for comment #' + (var_id).str()))
	} else {
		Class_Akismet.log(rt.new_string('No need to schedule_approval_fallback for comment #' + (var_id).str()))
	}
}

fn Class_Akismet.approval_fallback(var_comment_id rt.PhpVal) {
	mut var_comment_id_mutated := var_comment_id
	Class_Akismet.log(rt.new_string('In approval fallback for comment #' + (var_comment_id_mutated).str()))
	if rt.is_true(rt.equal(rt.call_function('wp_get_comment_status', [var_comment_id_mutated.clone()]), rt.new_string('unapproved'))) {
		if rt.is_true(Class_Akismet.last_comment_status_change_came_from_akismet(var_comment_id_mutated.clone())) {
			mut var_comment := rt.call_function('get_comment', [var_comment_id_mutated.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
				Class_Akismet.log(rt.new_string('Comment #' + (var_comment_id_mutated).str() + ' no longer exists.'))
			} else {
				if rt.is_true(rt.call_function('check_comment', [rt.get_property(var_comment, 'comment_author'), rt.get_property(var_comment, 'comment_author_email'), rt.get_property(var_comment, 'comment_author_url'), rt.get_property(var_comment, 'comment_content'), rt.get_property(var_comment, 'comment_author_IP'), rt.get_property(var_comment, 'comment_agent'), rt.get_property(var_comment, 'comment_type')])) {
					Class_Akismet.log(rt.new_string('Approving comment #' + (var_comment_id_mutated).str()))
					rt.call_function('wp_set_comment_status', [var_comment_id_mutated.clone(), rt.new_int(1)])
				} else {
					Class_Akismet.log(rt.new_string('Not approving comment #' + (var_comment_id_mutated).str() + ' because it does not pass check_comment()'))
				}
			}
			Class_Akismet.update_comment_history(rt.get_property(var_comment, 'comment_ID'), rt.new_string(''), rt.new_string('check-ham'))
		} else {
			Class_Akismet.log(rt.new_string('No need to fallback approve comment #' + (var_comment_id_mutated).str() + ' because it was not last modified by Akismet.'))
			mut var_history := Class_Akismet.get_comment_history(var_comment_id_mutated.clone())
			if !(!rt.is_true(var_history)) {
				mut var_most_recent_history_event := var_history.array_get(rt.new_int(0))
				rt.call_function('error_log', [rt.new_string('Comment history: ' + (println(var_history.clone().to_string())).str())])
			}
		}
	} else {
		Class_Akismet.log(rt.new_string('No need to fallback approve comment #' + (var_comment_id_mutated).str() + ' because it is not pending.'))
	}
}

fn Class_Akismet.delete_old_comments() {
	mut var_wpdb := rt.new_null()
	mut var_delete_limit := rt.call_function('apply_filters', [rt.new_string('akismet_delete_comment_limit'), if rt.is_true(rt.call_function('defined', [rt.new_string('AKISMET_DELETE_LIMIT')])) { rt.get_constant('AKISMET_DELETE_LIMIT') } else { rt.new_int(10000) }])
	var_delete_limit = rt.call_function('max', [rt.new_int(1), rt.new_int(var_delete_limit.clone().to_i64())])
	mut var_delete_interval := rt.call_function('apply_filters', [rt.new_string('akismet_delete_comment_interval'), rt.new_int(15)])
	var_delete_interval = rt.call_function('max', [rt.new_int(1), rt.new_int(var_delete_interval.clone().to_i64())])
	mut var_comment_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT comment_id FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE DATE_SUB(NOW(), INTERVAL %d DAY) > comment_date_gmt AND comment_approved = \'spam\' LIMIT %d')), var_delete_interval.clone(), var_delete_limit.clone()])])
	for rt.is_true(var_comment_ids) {
		if !rt.is_true(var_comment_ids) {
			return
		}
		rt.set_property(var_wpdb, 'queries', rt.new_array())
		mut var_comments := rt.new_array()
		mut iter_7 := var_comment_ids.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_comment_id := item_7.val
			var_comments.array_set(var_comment_id, rt.call_function('get_comment', [var_comment_id.clone()]))
			rt.call_function('do_action', [rt.new_string('delete_comment'), var_comment_id.clone(), var_comments.array_get(var_comment_id)])
			rt.call_function('do_action', [rt.new_string('akismet_batch_delete_count'), rt.new_string(@FN)])
		}
		mut var_format_string := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(if rt.call_function('is_countable', [var_comment_ids.clone()]) { var_comment_ids.clone().array_count() } else { 0 }), rt.new_string('%s')])])
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_id IN ( ')) + (var_format_string).str() + ' )').str()), var_comment_ids.clone()])])
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'commentmeta')), rt.new_string(' WHERE comment_id IN ( ')) + (var_format_string).str() + ' )').str()), var_comment_ids.clone()])])
		mut iter_8 := var_comment_ids.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_comment_id := item_8.val
			rt.call_function('do_action', [rt.new_string('deleted_comment'), var_comment_id.clone(), var_comments.array_get(var_comment_id)])
			var_comments.array_unset(var_comment_id)
		}
		rt.call_function('clean_comment_cache', [var_comment_ids.clone()])
		rt.call_function('do_action', [rt.new_string('akismet_delete_comment_batch'), rt.new_int(if rt.call_function('is_countable', [var_comment_ids.clone()]) { var_comment_ids.clone().array_count() } else { 0 })])
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('akismet_optimize_table'), rt.equal(rt.call_function('mt_rand', [rt.new_int(1), rt.new_int(5000)]), rt.new_int(11)), rt.get_property(var_wpdb, 'comments')])) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.new_string('OPTIMIZE TABLE '), rt.get_property(var_wpdb, 'comments'))])
	}
}

fn Class_Akismet.delete_old_comments_meta() {
	mut var_wpdb := rt.new_null()
	mut var_interval := rt.call_function('apply_filters', [rt.new_string('akismet_delete_commentmeta_interval'), rt.new_int(15)])
	var_interval = rt.call_function('absint', [var_interval.clone()])
	if rt.is_true(rt.less(var_interval, rt.new_int(1))) {
	var_interval = rt.new_int(1)
	}
	mut var_comment_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT m.comment_id FROM '), rt.get_property(var_wpdb, 'commentmeta')), rt.new_string(' as m INNER JOIN ')), rt.get_property(var_wpdb, 'comments')), rt.new_string(' as c USING(comment_id) WHERE m.meta_key = \'akismet_as_submitted\' AND DATE_SUB(NOW(), INTERVAL %d DAY) > c.comment_date_gmt LIMIT 10000')), var_interval.clone()])])
	for rt.is_true(var_comment_ids) {
		if !rt.is_true(var_comment_ids) {
			return
		}
		rt.set_property(var_wpdb, 'queries', rt.new_array())
		mut iter_9 := var_comment_ids.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_comment_id := item_9.val
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_as_submitted')])
			rt.call_function('do_action', [rt.new_string('akismet_batch_delete_count'), rt.new_string(@FN)])
		}
		rt.call_function('do_action', [rt.new_string('akismet_delete_commentmeta_batch'), rt.new_int(if rt.call_function('is_countable', [var_comment_ids.clone()]) { var_comment_ids.clone().array_count() } else { 0 })])
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('akismet_optimize_table'), rt.equal(rt.call_function('mt_rand', [rt.new_int(1), rt.new_int(5000)]), rt.new_int(11)), rt.get_property(var_wpdb, 'commentmeta')])) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.new_string('OPTIMIZE TABLE '), rt.get_property(var_wpdb, 'commentmeta'))])
	}
}

fn Class_Akismet.delete_orphaned_commentmeta() {
	mut var_wpdb := rt.new_null()
	mut var_last_meta_id := rt.new_int(0)
	mut var_start_time := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_TIME_FLOAT')) { rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_TIME_FLOAT')) } else { rt.call_function('microtime', [rt.new_bool(true)]) }
	mut var_max_exec_time := rt.call_function('max', [rt.sub(rt.call_function('ini_get', [rt.new_string('max_execution_time')]), rt.new_int(5)), rt.new_int(3)])
	mut var_commentmeta_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT m.meta_id, m.comment_id, m.meta_key FROM '), rt.get_property(var_wpdb, 'commentmeta')), rt.new_string(' as m LEFT JOIN ')), rt.get_property(var_wpdb, 'comments')), rt.new_string(' as c USING(comment_id) WHERE c.comment_id IS NULL AND m.meta_id > %d ORDER BY m.meta_id LIMIT 1000')), var_last_meta_id.clone()])])
	for rt.is_true(var_commentmeta_results) {
		if !rt.is_true(var_commentmeta_results) {
			return
		}
		rt.set_property(var_wpdb, 'queries', rt.new_array())
		mut var_commentmeta_deleted := rt.new_int(0)
		mut iter_10 := var_commentmeta_results.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_commentmeta := item_10.val
			if rt.is_true(rt.equal(rt.new_string('akismet_'), rt.call_function('substr', [rt.get_property(var_commentmeta, 'meta_key'), rt.new_int(0), rt.new_int(8)]))) {
				rt.call_function('delete_comment_meta', [rt.get_property(var_commentmeta, 'comment_id'), rt.get_property(var_commentmeta, 'meta_key')])
				rt.call_function('do_action', [rt.new_string('akismet_batch_delete_count'), rt.new_string(@FN)])
				rt.pre_inc(var_commentmeta_deleted)
			}
		var_last_meta_id = rt.get_property(var_commentmeta, 'meta_id')
		}
		rt.call_function('do_action', [rt.new_string('akismet_delete_commentmeta_batch'), var_commentmeta_deleted.clone()])
		if rt.is_true(rt.greater(rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_start_time), var_max_exec_time)) {
			return
		}
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('akismet_optimize_table'), rt.equal(rt.call_function('mt_rand', [rt.new_int(1), rt.new_int(5000)]), rt.new_int(11)), rt.get_property(var_wpdb, 'commentmeta')])) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.new_string('OPTIMIZE TABLE '), rt.get_property(var_wpdb, 'commentmeta'))])
	}
}

fn Class_Akismet.get_user_comments_approved(var_user_id rt.PhpVal, var_comment_author_email rt.PhpVal, var_comment_author rt.PhpVal, var_comment_author_url rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_comment_author_email_mutated := var_comment_author_email
	mut var_comment_author_mutated := var_comment_author
	mut var_comment_author_url_mutated := var_comment_author_url
	mut var_excluded_comment_types := rt.call_function('apply_filters', [rt.new_string('akismet_excluded_comment_types'), rt.new_array()])
	mut var_comment_type_where := rt.new_string('')
	if var_excluded_comment_types.clone().is_array() && !(!rt.is_true(var_excluded_comment_types)) {
		var_excluded_comment_types = rt.call_function('array_unique', [var_excluded_comment_types.clone()])
		mut iter_11 := var_excluded_comment_types.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_excluded_comment_type := item_11.val
			var_comment_type_where = rt.concat(var_comment_type_where, rt.call_method(var_wpdb, 'prepare', [rt.new_string(' AND comment_type <> %s '), var_excluded_comment_type.clone()]))
		}
	}
	if !(!rt.is_true(var_user_id)) {
		return rt.new_int((rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE user_id = %d AND comment_approved = 1')) + (var_comment_type_where).str()).str()), var_user_id.clone()])])).to_i64())
	}
	if !(!rt.is_true(var_comment_author_email_mutated)) {
		return rt.new_int((rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_author_email = %s AND comment_author = %s AND comment_author_url = %s AND comment_approved = 1')) + (var_comment_type_where).str()).str()), var_comment_author_email_mutated.clone(), var_comment_author_mutated.clone(), var_comment_author_url_mutated.clone()])])).to_i64())
	}
	return 0
}

fn Class_Akismet.get_comment_history(var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_comment_id_mutated := var_comment_id
	mut var_history := rt.call_function('get_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_history'), rt.new_bool(false)])
	if !rt.is_true(var_history) || !rt.is_true(var_history.array_get(rt.new_int(0))) {
		return rt.new_bool(false)
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_entry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(var_entry.clone().is_array() && var_entry.array_isset(rt.new_string('time')) && var_entry.array_get(rt.new_string('time')).is_long() || var_entry.array_get(rt.new_string('time')).is_double())
		}
	var_history = rt.call_function('array_filter', [var_history.clone(), rt.new_closure(closure_1_fn)])
	rt.call_function('usort', [var_history.clone(), rt.new_string('Akismet::_cmp_time')])
	return var_history.clone()
}

fn Class_Akismet.update_comment_history(var_comment_id rt.PhpVal, var_message rt.PhpVal, var_event rt.PhpVal, var_meta rt.PhpVal) {
	mut var_current_user := rt.new_null()
	mut var_comment_id_mutated := var_comment_id
	mut var_message_mutated := var_message
	mut var_event_mutated := var_event
	mut var_user := rt.new_string('')
	var_event_mutated = rt.create_array([rt.ArrayItem{ key: 'time', val: Class_Akismet._get_microtime() }, rt.ArrayItem{ key: 'event', val: var_event_mutated }])
	if var_current_user.clone().is_object() && !(rt.get_property(var_current_user, 'user_login')).is_null() {
		var_event_mutated.array_set('user', rt.get_property(var_current_user, 'user_login'))
	}
	if !(!rt.is_true(var_meta)) {
		var_event_mutated.array_set('meta', var_meta.clone())
	}
mut var_r := rt.call_function('add_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_history'), var_event_mutated.clone(), rt.new_bool(false)])
}

fn Class_Akismet.check_db_comment(var_id rt.PhpVal, recheck_reason string) bool {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Akismet.get_api_key())))) {
		return (create_wp_error(rt.new_string('akismet-not-configured'), rt.call_function('__', [rt.new_string('Akismet is not configured. Please enter an API key.'), rt.new_string('akismet')]))).to_bool()
	}
	mut var_c := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_ID = %d')), var_id.clone()]), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_c)))) {
		return (create_wp_error(rt.new_string('invalid-comment-id'), rt.call_function('__', [rt.new_string('Comment not found.'), rt.new_string('akismet')]))).to_bool()
	}
	var_c.array_set('user_ip', var_c.array_get(rt.new_string('comment_author_IP')))
	var_c.array_set('user_agent', var_c.array_get(rt.new_string('comment_agent')))
	var_c.array_set('referrer', '')
	var_c.array_set('blog', rt.call_function('get_option', [rt.new_string('home')]))
	var_c.array_set('blog_lang', rt.call_function('get_locale', []rt.PhpVal{}))
	var_c.array_set('blog_charset', rt.call_function('get_option', [rt.new_string('blog_charset')]))
	var_c.array_set('permalink', rt.call_function('get_permalink', [var_c.array_get(rt.new_string('comment_post_ID'))]))
	var_c.array_set('recheck_reason', recheck_reason)
	var_c.array_set('user_role', '')
	if !(!rt.is_true(var_c.array_get(rt.new_string('user_ID')))) {
		var_c.array_set('user_role', Class_Akismet.get_user_roles(var_c.array_get(rt.new_string('user_ID'))))
	}
	if rt.is_true(Class_Akismet.is_test_mode()) {
		var_c.array_set('is_test', 'true')
	}
	var_c = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_c.clone(), rt.new_string('comment-check')])
	mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_c.clone()), rt.new_string('comment-check'))
	if !(!rt.is_true(var_response.array_get(rt.new_int(1)))) {
		return (var_response.array_get(rt.new_int(1))).to_bool()
	}
	return false
}

fn Class_Akismet.recheck_comment(var_id rt.PhpVal, recheck_reason string) rt.PhpVal {
	rt.call_function('add_comment_meta', [var_id.clone(), rt.new_string('akismet_rechecking'), rt.new_bool(true)])
	mut var_api_response := Class_Akismet.check_db_comment((var_id).str(), rt.new_string(recheck_reason))
	if rt.is_true(rt.call_function('is_wp_error', [var_api_response.clone()])) {
	} else if rt.is_true(rt.identical(rt.new_string('true'), var_api_response)) {
		rt.call_function('wp_set_comment_status', [var_id.clone(), rt.new_string('spam')])
		rt.call_function('update_comment_meta', [var_id.clone(), rt.new_string('akismet_result'), rt.new_string('true')])
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_error')])
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_delay_moderation_email')])
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_delayed_moderation_email')])
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_schedule_approval_fallback')])
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_schedule_email_fallback')])
		Class_Akismet.update_comment_history(var_id.clone(), rt.new_string(''), rt.new_string('recheck-spam'))
	} else if rt.is_true(rt.identical(rt.new_string('false'), var_api_response)) {
		rt.call_function('update_comment_meta', [var_id.clone(), rt.new_string('akismet_result'), rt.new_string('false')])
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_error')])
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_delay_moderation_email')])
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_delayed_moderation_email')])
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_schedule_approval_fallback')])
		rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_schedule_email_fallback')])
		Class_Akismet.update_comment_history(var_id.clone(), rt.new_string(''), rt.new_string('recheck-ham'))
	} else {
		rt.call_function('update_comment_meta', [var_id.clone(), rt.new_string('akismet_result'), rt.new_string('error')])
		Class_Akismet.update_comment_history(var_id.clone(), rt.new_string(''), rt.new_string('recheck-error'), rt.create_array([rt.ArrayItem{ key: 'response', val: rt.call_function('substr', [var_api_response.clone(), rt.new_int(0), rt.new_int(50)]) }]))
	}
	rt.call_function('delete_comment_meta', [var_id.clone(), rt.new_string('akismet_rechecking')])
	return var_api_response.clone()
}

fn Class_Akismet.transition_comment_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	mut var_comment_mutated := var_comment
	if rt.is_true(rt.equal(var_new_status, var_old_status)) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('spam'), var_new_status)) || rt.is_true(rt.identical(rt.new_string('spam'), var_old_status)) {
		rt.call_function('wp_cache_delete', [rt.new_string('akismet_spam_count'), rt.new_string('widget')])
	}
	if rt.is_true(rt.equal(var_new_status, rt.new_string('delete'))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_comment_mutated, 'comment_post_ID')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_IMPORTING')])) && rt.is_true(rt.equal(rt.get_constant('WP_IMPORTING'), rt.new_bool(true))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('get_comment_meta', [rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string('akismet_rechecking')])) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('getallheaders')])) {
		mut var_request_headers := rt.call_function('getallheaders', []rt.PhpVal{})
		mut iter_12 := var_request_headers.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_value := item_12.val
			mut var_header := item_12.key
			if rt.is_true(rt.equal(rt.new_string(var_header.clone().to_string().to_lower()), rt.new_string('x-akismet-webhook'))) {
				return rt.new_null()
			}
		}
	}
	if ((((((((rt.get_superglobal('_POST').array_isset(rt.new_string('status')) && rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_POST').array_get(rt.new_string('status')), rt.create_array([rt.ArrayItem{ key: none, val: 'spam' }, rt.ArrayItem{ key: none, val: 'unspam' }, rt.ArrayItem{ key: none, val: 'approved' }])]))) || (rt.get_superglobal('_POST').array_isset(rt.new_string('spam')) && rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('spam'))).to_i64()) == 1)) || (rt.get_superglobal('_POST').array_isset(rt.new_string('unspam')) && rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('unspam'))).to_i64()) == 1)) || (rt.get_superglobal('_POST').array_isset(rt.new_string('comment_status')) && rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_POST').array_get(rt.new_string('comment_status')), rt.create_array([rt.ArrayItem{ key: none, val: 'spam' }, rt.ArrayItem{ key: none, val: 'unspam' }])])))) || (rt.get_superglobal('_GET').array_isset(rt.new_string('action')) && rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_GET').array_get(rt.new_string('action')), rt.create_array([rt.ArrayItem{ key: none, val: 'spam' }, rt.ArrayItem{ key: none, val: 'unspam' }, rt.ArrayItem{ key: none, val: 'spamcomment' }, rt.ArrayItem{ key: none, val: 'unspamcomment' }])])))) || (rt.get_superglobal('_POST').array_isset(rt.new_string('action')) && rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_POST').array_get(rt.new_string('action')), rt.create_array([rt.ArrayItem{ key: none, val: 'editedcomment' }])])))) || (rt.get_superglobal('_GET').array_isset(rt.new_string('for')) && rt.is_true(rt.equal(rt.new_string('jetpack'), rt.get_superglobal('_GET').array_get(rt.new_string('for')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('IS_WPCOM')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_WPCOM'))))))) || (rt.is_true(rt.call_function('defined', [rt.new_string('REST_API_REQUEST')])) && rt.is_true(rt.get_constant('REST_API_REQUEST')))) || (rt.is_true(rt.call_function('defined', [rt.new_string('REST_REQUEST')])) && rt.is_true(rt.get_constant('REST_REQUEST'))) {
		if rt.is_true(rt.equal(var_new_status, rt.new_string('spam'))) && rt.is_true(rt.equal(var_old_status, rt.new_string('approved'))) || rt.is_true(rt.equal(var_old_status, rt.new_string('unapproved'))) || rt.is_true(rt.new_bool(!(rt.is_true(var_old_status)))) {
			return Class_Akismet.submit_spam_comment(rt.get_property(var_comment_mutated, 'comment_ID'))
		} else if rt.is_true(rt.equal(var_old_status, rt.new_string('spam'))) && rt.is_true(rt.equal(var_new_status, rt.new_string('approved'))) || rt.is_true(rt.equal(var_new_status, rt.new_string('unapproved'))) {
			return Class_Akismet.submit_nonspam_comment(rt.get_property(var_comment_mutated, 'comment_ID'))
		}
	}
	Class_Akismet.update_comment_history(rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string(''), rt.new_string('status-' + (var_new_status).str()))
	return rt.new_null()
}

fn Class_Akismet.submit_spam_comment(var_comment_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_current_user := rt.new_null()
	mut var_current_site := rt.new_null()
	mut var_comment_id_mutated := var_comment_id
	var_comment_id_mutated = rt.new_int((var_comment_id_mutated).to_i64())
	mut var_comment := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_ID = %d')), var_comment_id_mutated.clone()]), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string('spam'), var_comment.array_get(rt.new_string('comment_approved')))))) {
		return
	}
	Class_Akismet.update_comment_history(var_comment_id_mutated.clone(), rt.new_string(''), rt.new_string('report-spam'))
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Akismet.get_api_key())))) {
		return
	}
	mut var_as_submitted := Class_Akismet.sanitize_comment_as_submitted(rt.call_function('get_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_as_submitted'), rt.new_bool(true)]))
	if rt.is_true(var_as_submitted) && var_as_submitted.clone().is_array() && var_as_submitted.array_isset(rt.new_string('comment_content')) {
	var_comment = rt.call_function('array_merge', [var_comment.clone(), var_as_submitted.clone()])
	}
	var_comment.array_set('blog', rt.call_function('get_option', [rt.new_string('home')]))
	var_comment.array_set('blog_lang', rt.call_function('get_locale', []rt.PhpVal{}))
	var_comment.array_set('blog_charset', rt.call_function('get_option', [rt.new_string('blog_charset')]))
	var_comment.array_set('permalink', rt.call_function('get_permalink', [var_comment.array_get(rt.new_string('comment_post_ID'))]))
	if rt.is_true(rt.new_bool(var_current_user.clone().is_object())) {
		var_comment.array_set('reporter', rt.get_property(var_current_user, 'user_login'))
	}
	if rt.is_true(rt.new_bool(var_current_site.clone().is_object())) {
		var_comment.array_set('site_domain', rt.get_property(var_current_site, 'domain'))
	}
	var_comment.array_set('user_role', '')
	if !(!rt.is_true(var_comment.array_get(rt.new_string('user_ID')))) {
		var_comment.array_set('user_role', Class_Akismet.get_user_roles(var_comment.array_get(rt.new_string('user_ID'))))
	}
	if rt.is_true(Class_Akismet.is_test_mode()) {
		var_comment.array_set('is_test', 'true')
	}
	mut var_post := rt.call_function('get_post', [var_comment.array_get(rt.new_string('comment_post_ID'))])
	if !(var_post.clone().is_null()) {
		var_comment.array_set('comment_post_modified_gmt', rt.get_property(var_post, 'post_modified_gmt'))
	}
	var_comment.array_set('comment_check_response', Class_Akismet.last_comment_check_response(var_comment_id_mutated.clone()))
	var_comment = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_comment.clone(), rt.new_string('submit-spam')])
	mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_comment.clone()), rt.new_string('submit-spam'))
	rt.call_function('update_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_user_result'), rt.new_string('true')])
	if rt.is_true(var_comment.array_get(rt.new_string('reporter'))) {
		rt.call_function('update_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_user'), var_comment.array_get(rt.new_string('reporter'))])
	}
	rt.call_function('do_action', [rt.new_string('akismet_submit_spam_comment'), var_comment_id_mutated.clone(), var_response.array_get(rt.new_int(1))])
}

fn Class_Akismet.submit_nonspam_comment(var_comment_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_current_user := rt.new_null()
	mut var_current_site := rt.new_null()
	mut var_comment_id_mutated := var_comment_id
	var_comment_id_mutated = rt.new_int((var_comment_id_mutated).to_i64())
	mut var_comment := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_ID = %d')), var_comment_id_mutated.clone()]), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		return
	}
	Class_Akismet.update_comment_history(var_comment_id_mutated.clone(), rt.new_string(''), rt.new_string('report-ham'))
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Akismet.get_api_key())))) {
		return
	}
	mut var_as_submitted := Class_Akismet.sanitize_comment_as_submitted(rt.call_function('get_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_as_submitted'), rt.new_bool(true)]))
	if rt.is_true(var_as_submitted) && var_as_submitted.clone().is_array() && var_as_submitted.array_isset(rt.new_string('comment_content')) {
	var_comment = rt.call_function('array_merge', [var_comment.clone(), var_as_submitted.clone()])
	}
	var_comment.array_set('blog', rt.call_function('get_option', [rt.new_string('home')]))
	var_comment.array_set('blog_lang', rt.call_function('get_locale', []rt.PhpVal{}))
	var_comment.array_set('blog_charset', rt.call_function('get_option', [rt.new_string('blog_charset')]))
	var_comment.array_set('permalink', rt.call_function('get_permalink', [var_comment.array_get(rt.new_string('comment_post_ID'))]))
	var_comment.array_set('user_role', '')
	if rt.is_true(rt.new_bool(var_current_user.clone().is_object())) {
		var_comment.array_set('reporter', rt.get_property(var_current_user, 'user_login'))
	}
	if rt.is_true(rt.new_bool(var_current_site.clone().is_object())) {
		var_comment.array_set('site_domain', rt.get_property(var_current_site, 'domain'))
	}
	if !(!rt.is_true(var_comment.array_get(rt.new_string('user_ID')))) {
		var_comment.array_set('user_role', Class_Akismet.get_user_roles(var_comment.array_get(rt.new_string('user_ID'))))
	}
	if rt.is_true(Class_Akismet.is_test_mode()) {
		var_comment.array_set('is_test', 'true')
	}
	mut var_post := rt.call_function('get_post', [var_comment.array_get(rt.new_string('comment_post_ID'))])
	if !(var_post.clone().is_null()) {
		var_comment.array_set('comment_post_modified_gmt', rt.get_property(var_post, 'post_modified_gmt'))
	}
	var_comment.array_set('comment_check_response', Class_Akismet.last_comment_check_response(var_comment_id_mutated.clone()))
	var_comment = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_comment.clone(), rt.new_string('submit-ham')])
	mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_comment.clone()), rt.new_string('submit-ham'))
	rt.call_function('update_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_user_result'), rt.new_string('false')])
	if rt.is_true(var_comment.array_get(rt.new_string('reporter'))) {
		rt.call_function('update_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_user'), var_comment.array_get(rt.new_string('reporter'))])
	}
	rt.call_function('do_action', [rt.new_string('akismet_submit_nonspam_comment'), var_comment_id_mutated.clone(), var_response.array_get(rt.new_int(1))])
}

fn Class_Akismet.cron_recheck() bool {
	mut var_wpdb := rt.new_null()
	mut var_api_key := Class_Akismet.get_api_key()
	mut var_status := Class_Akismet.verify_key(var_api_key.clone())
	if rt.is_true(rt.call_function('get_option', [rt.new_string('akismet_alert_code')])) || rt.is_true(rt.equal(var_status, rt.new_string('invalid'))) {
		rt.call_function('wp_schedule_single_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(21600)), rt.new_string('akismet_schedule_cron_recheck')])
		rt.call_function('do_action', [rt.new_string('akismet_scheduled_recheck'), rt.new_string('key-problem-' + (rt.call_function('get_option', [rt.new_string('akismet_alert_code')])).str() + '-' + (var_status).str())])
		return false
	}
	rt.call_function('delete_option', [rt.new_string('akismet_available_servers')])
	mut var_comment_errors := rt.call_method(var_wpdb, 'get_col', [rt.concat(rt.concat(rt.new_string('SELECT comment_id FROM '), rt.get_property(var_wpdb, 'commentmeta')), rt.new_string(' WHERE meta_key = \'akismet_error\'\tLIMIT 100'))])
	mut iter_13 := rt.cast_array(var_comment_errors).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_comment_id := item_13.val
		mut var_comment := rt.call_function('get_comment', [var_comment_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) || rt.is_true(rt.less(rt.call_function('strtotime', [rt.get_property(var_comment, 'comment_date_gmt')]), rt.call_function('strtotime', [rt.new_string('-15 days')]))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_comment, 'comment_approved'), rt.new_string('0'))))) {
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_error')])
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_delay_moderation_email')])
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_delayed_moderation_email')])
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_schedule_approval_fallback')])
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_schedule_email_fallback')])
			continue
		}
		rt.call_function('add_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_rechecking'), rt.new_bool(true)])
		var_status = Class_Akismet.check_db_comment((var_comment_id).str(), rt.new_string('retry'))
		mut var_event := rt.new_string('')
		if rt.is_true(rt.equal(var_status, rt.new_string('true'))) {
		var_event = rt.new_string('cron-retry-spam')
		} else if rt.is_true(rt.equal(var_status, rt.new_string('false'))) {
		var_event = rt.new_string('cron-retry-ham')
		}
		if !(!rt.is_true(var_event)) {
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_error')])
			Class_Akismet.update_comment_history(var_comment_id.clone(), rt.new_string(''), var_event.clone())
			rt.call_function('update_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_result'), var_status.clone()])
			var_comment = rt.call_function('get_comment', [var_comment_id.clone()])
			if rt.is_true(var_comment) && rt.is_true(rt.equal(rt.new_string('unapproved'), rt.call_function('wp_get_comment_status', [var_comment_id.clone()]))) {
				if rt.is_true(rt.equal(var_status, rt.new_string('true'))) {
					rt.call_function('wp_spam_comment', [var_comment_id.clone()])
				} else if rt.is_true(rt.equal(var_status, rt.new_string('false'))) {
					if rt.is_true(rt.call_function('check_comment', [rt.get_property(var_comment, 'comment_author'), rt.get_property(var_comment, 'comment_author_email'), rt.get_property(var_comment, 'comment_author_url'), rt.get_property(var_comment, 'comment_content'), rt.get_property(var_comment, 'comment_author_IP'), rt.get_property(var_comment, 'comment_agent'), rt.get_property(var_comment, 'comment_type')])) {
						rt.call_function('wp_set_comment_status', [var_comment_id.clone(), rt.new_int(1)])
					} else if rt.is_true(rt.call_function('get_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_delayed_moderation_email'), rt.new_bool(true)])) {
						rt.call_function('wp_new_comment_notify_moderator', [var_comment_id.clone()])
						rt.call_function('wp_new_comment_notify_postauthor', [var_comment_id.clone()])
					}
				}
			}
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_delay_moderation_email')])
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_delayed_moderation_email')])
		} else {
			if rt.is_true(rt.less(rt.sub(rt.new_int(rt.call_function('gmdate', [rt.new_string('U')]).to_i64()), rt.call_function('strtotime', [rt.get_property(var_comment, 'comment_date_gmt')])), Class_Akismet.max_delay_before_moderation_email())) {
				rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_delay_moderation_email')])
				rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_delayed_moderation_email')])
				rt.call_function('wp_new_comment_notify_moderator', [var_comment_id.clone()])
				rt.call_function('wp_new_comment_notify_postauthor', [var_comment_id.clone()])
			}
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_rechecking')])
			rt.call_function('wp_schedule_single_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(1200)), rt.new_string('akismet_schedule_cron_recheck')])
			rt.call_function('do_action', [rt.new_string('akismet_scheduled_recheck'), rt.new_string('check-db-comment-' + (var_status).str())])
			return false
		}
		rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('akismet_rechecking')])
	}
	mut var_remaining := rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'commentmeta')), rt.new_string(' WHERE meta_key = \'akismet_error\''))])
	if rt.is_true(var_remaining) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('akismet_schedule_cron_recheck')]))))) {
		rt.call_function('wp_schedule_single_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(1200)), rt.new_string('akismet_schedule_cron_recheck')])
		rt.call_function('do_action', [rt.new_string('akismet_scheduled_recheck'), rt.new_string('remaining')])
	}
	return false
}

fn Class_Akismet.fix_scheduled_recheck() {
	mut var_future_check := rt.call_function('wp_next_scheduled', [rt.new_string('akismet_schedule_cron_recheck')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_future_check)))) {
		return
	}
	if rt.is_true(rt.greater(rt.call_function('get_option', [rt.new_string('akismet_alert_code')]), rt.new_int(0))) {
		return
	}
	mut var_check_range := rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(1200))
	if rt.is_true(rt.greater(var_future_check, var_check_range)) {
		rt.call_function('wp_clear_scheduled_hook', [rt.new_string('akismet_schedule_cron_recheck')])
		rt.call_function('wp_schedule_single_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(300)), rt.new_string('akismet_schedule_cron_recheck')])
		rt.call_function('do_action', [rt.new_string('akismet_scheduled_recheck'), rt.new_string('fix-scheduled-recheck')])
	}
}

fn Class_Akismet.add_comment_nonce(var_post_id rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Akismet.get_api_key())))) {
		return
	}
	mut var_akismet_comment_nonce_option := rt.call_function('apply_filters', [rt.new_string('akismet_comment_nonce'), rt.call_function('get_option', [rt.new_string('akismet_comment_nonce')])])
	if rt.is_true(rt.equal(var_akismet_comment_nonce_option, rt.new_string('true'))) || rt.is_true(rt.equal(var_akismet_comment_nonce_option, rt.new_string(''))) {
		print('<p style="display: none;">')
		rt.call_function('wp_nonce_field', [rt.new_string('akismet_comment_nonce_' + (var_post_id_mutated).str()), rt.new_string('akismet_comment_nonce'), rt.new_bool(false)])
		print('</p>')
	}
}

fn Class_Akismet.is_test_mode() bool {
	return rt.is_true(rt.call_function('defined', [rt.new_string('AKISMET_TEST_MODE')])) && rt.is_true(rt.get_constant('AKISMET_TEST_MODE'))
}

fn Class_Akismet.allow_discard() bool {
	if rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AJAX')])) && rt.is_true(rt.get_constant('DOING_AJAX')) {
		return false
	}
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		return false
	}
	return (rt.identical(rt.call_function('get_option', [rt.new_string('akismet_strictness')]), rt.new_string('1'))).to_bool()
}

fn Class_Akismet.get_ip_address() rt.PhpVal {
	return if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REMOTE_ADDR')) { rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')) } else { rt.new_null() }
}

fn Class_Akismet.comments_match(var_comment1 rt.PhpVal, var_comment2 rt.PhpVal) bool {
	mut var_comment1_mutated := var_comment1
	mut var_comment2_mutated := var_comment2
	var_comment1_mutated = rt.cast_array(var_comment1_mutated)
	var_comment2_mutated = rt.cast_array(var_comment2_mutated)
	if !(!rt.is_true(var_comment1_mutated.array_get(rt.new_string('akismet_guid')))) && !(!rt.is_true(var_comment2_mutated.array_get(rt.new_string('akismet_guid')))) {
		return (rt.equal(var_comment1_mutated.array_get(rt.new_string('akismet_guid')), var_comment2_mutated.array_get(rt.new_string('akismet_guid')))).to_bool()
	} else {
		if !(!rt.is_true(var_comment1_mutated.array_get(rt.new_string('akismet_skipped_microtime')))) && !(!rt.is_true(var_comment2_mutated.array_get(rt.new_string('akismet_skipped_microtime')))) {
			return (rt.equal(rt.new_string(var_comment1_mutated.array_get(rt.new_string('akismet_skipped_microtime')).to_string()), rt.new_string(var_comment2_mutated.array_get(rt.new_string('akismet_skipped_microtime')).to_string()))).to_bool()
		}
	}
	return false
}

fn Class_Akismet.matches_last_comment(var_comment rt.PhpVal) bool {
	mut var_comment_mutated := var_comment
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Akismet', 'last_comment'))))) {
		return false
	}
	return (Class_Akismet.comments_match(var_comment_mutated.clone(), rt.get_static_prop('Akismet', 'last_comment'))).to_bool()
}

fn Class_Akismet.matches_last_comment_by_id(var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_comment_id_mutated := var_comment_id
	return Class_Akismet.matches_last_comment(Class_Akismet.get_fields_for_comment_matching(var_comment_id_mutated.clone()))
}

fn Class_Akismet.get_fields_for_comment_matching(var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_comment_id_mutated := var_comment_id
	return rt.create_array([rt.ArrayItem{ key: 'akismet_guid', val: rt.call_function('get_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_guid'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'akismet_skipped_microtime', val: rt.call_function('get_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_skipped_microtime'), rt.new_bool(true)]) }])
}

fn Class_Akismet.get_user_agent() rt.PhpVal {
	return if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_USER_AGENT')) { rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')) } else { rt.new_null() }
}

fn Class_Akismet.get_referer() rt.PhpVal {
	return if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_REFERER')) { rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER')) } else { rt.new_null() }
}

fn Class_Akismet.get_user_roles(var_user_id rt.PhpVal) bool {
	mut var_comment_user := rt.new_null()
	mut var_roles := rt.new_bool(false)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_User')]))))) {
		return false
	}
	if rt.is_true(rt.greater(var_user_id, rt.new_int(0))) {
		var_comment_user = create_wp_user(var_user_id.clone())
		if !(rt.get_property(var_comment_user, 'roles')).is_null() {
		var_roles = rt.call_function('implode', [rt.new_string(','), rt.get_property(var_comment_user, 'roles')])
		}
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_super_admin', [var_user_id.clone()])) {
		if !rt.is_true(var_roles) {
		var_roles = rt.new_string('super_admin')
		} else {
			rt.get_property(var_comment_user, 'roles').array_push('super_admin')
		var_roles = rt.call_function('implode', [rt.new_string(','), rt.get_property(var_comment_user, 'roles')])
		}
	}
	return (var_roles).to_bool()
}

fn Class_Akismet.last_comment_status(var_approved rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	mut var_comment_mutated := var_comment
	if rt.is_true(rt.new_bool(rt.get_static_prop('Akismet', 'last_comment_result').is_null())) {
		return var_approved.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Akismet.matches_last_comment(var_comment_mutated.clone()))))) {
		Class_Akismet.log(rt.new_string("comment_is_spam mismatched comment, returning unaltered ${var_approved.to_string()}"))
		return var_approved.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('trash'), var_approved)) {
		return var_approved.clone()
	}
	mut var_incr := rt.call_function('apply_filters', [rt.new_string('akismet_spam_count_incr'), rt.new_int(1)])
	if rt.is_true(var_incr) {
		rt.call_function('update_option', [rt.new_string('akismet_spam_count'), rt.add(rt.call_function('get_option', [rt.new_string('akismet_spam_count')]), var_incr)])
	}
	return rt.get_static_prop('Akismet', 'last_comment_result')
}

fn Class_Akismet.disable_emails_if_unreachable(var_maybe_notify rt.PhpVal, var_comment_id rt.PhpVal) bool {
	mut var_comment_id_mutated := var_comment_id
	if rt.is_true(var_maybe_notify) {
		if rt.is_true(rt.call_function('get_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_delay_moderation_email'), rt.new_bool(true)])) {
			Class_Akismet.log(rt.new_string('Disabling notification email for comment #' + (var_comment_id_mutated).str()))
			rt.call_function('update_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_delayed_moderation_email'), rt.new_bool(true)])
			rt.call_function('delete_comment_meta', [var_comment_id_mutated.clone(), rt.new_string('akismet_delay_moderation_email')])
			return false
		}
	}
	return (var_maybe_notify).to_bool()
}

fn Class_Akismet._cmp_time(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	mut var_a_valid := rt.new_bool(var_a.clone().is_array() && var_a.array_isset(rt.new_string('time')) && var_a.array_get(rt.new_string('time')).is_long() || var_a.array_get(rt.new_string('time')).is_double())
	mut var_b_valid := rt.new_bool(var_b.clone().is_array() && var_b.array_isset(rt.new_string('time')) && var_b.array_get(rt.new_string('time')).is_long() || var_b.array_get(rt.new_string('time')).is_double())
	if rt.is_true(var_a_valid) && rt.is_true(var_b_valid) {
		return (rt.new_null()).to_i64()
	}
	if rt.is_true(var_a_valid) && rt.is_true(rt.new_bool(!(rt.is_true(var_b_valid)))) {
		return -1
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_a_valid)))) && rt.is_true(var_b_valid) {
		return 1
	}
	return 0
}

fn Class_Akismet._get_microtime() rt.PhpVal {
	mut var_mtime := rt.call_function('explode', [rt.new_string(' '), rt.call_function('microtime', []rt.PhpVal{})])
	return rt.add(var_mtime.array_get(rt.new_int(1)), var_mtime.array_get(rt.new_int(0)))
}

fn Class_Akismet.http_post(var_request rt.PhpVal, var_path rt.PhpVal, var_ip rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_request_mutated := var_request
	mut var_akismet_ua := rt.call_function('sprintf', [rt.new_string('WordPress/%s | Akismet/%s'), var_GLOBALS.array_get(rt.new_string('wp_version')), rt.call_function('constant', [rt.new_string('AKISMET_VERSION')])])
	var_akismet_ua = rt.call_function('apply_filters', [rt.new_string('akismet_ua'), var_akismet_ua.clone()])
	mut var_host := rt.new_string(Class_Akismet.api_host())
	mut var_api_key := Class_Akismet.get_api_key()
	if rt.is_true(var_api_key) {
	var_request_mutated = rt.call_function('add_query_arg', [rt.new_string('api_key'), var_api_key.clone(), var_request_mutated.clone()])
	}
	mut var_http_host := var_host.clone()
	if rt.is_true(var_ip) && rt.is_true(rt.call_function('long2ip', [rt.call_function('ip2long', [var_ip.clone()])])) {
	var_http_host = var_ip
	}
	mut var_http_args := { 'body': var_request_mutated, 'headers': { 'Content-Type': 'application/x-www-form-urlencoded; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str(), 'Host': var_host, 'User-Agent': var_akismet_ua }, 'httpversion': rt.new_string('1.0'), 'timeout': rt.new_int(15) }
	mut var_http_akismet_url := rt.new_string("http://${var_http_host.to_string()}/1.1/${var_path.to_string()}")
	mut var_akismet_url := var_http_akismet_url
	mut var_ssl_failed := rt.new_bool(false)
	mut var_ssl := var_ssl_failed
	mut var_ssl_disabled := rt.call_function('get_option', [rt.new_string('akismet_ssl_disabled')])
	if rt.is_true(var_ssl_disabled) && rt.is_true(rt.less(var_ssl_disabled, rt.sub(rt.call_function('time', []rt.PhpVal{}), 60 * 60 * 24))) {
		var_ssl_disabled = rt.new_bool(false)
		rt.call_function('delete_option', [rt.new_string('akismet_ssl_disabled')])
	} else if rt.is_true(var_ssl_disabled) {
		rt.call_function('do_action', [rt.new_string('akismet_ssl_disabled')])
	}
	var_ssl = rt.call_function('wp_http_supports', [rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ssl_disabled)))) && rt.is_true(var_ssl) {
		var_akismet_url = rt.call_function('set_url_scheme', [var_akismet_url.clone(), rt.new_string('https')])
		rt.call_function('do_action', [rt.new_string('akismet_https_request_pre')])
	}
	mut var_response := rt.call_function('wp_remote_post', [var_akismet_url.clone(), rt.create_array_from_native_map(var_http_args)])
	Class_Akismet.log(rt.call_function('compact', [rt.new_string('akismet_url'), rt.new_string('http_args'), rt.new_string('response')]))
	if rt.is_true(var_ssl) && rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.call_function('do_action', [rt.new_string('akismet_https_request_failure'), var_response.clone()])
		var_response = rt.call_function('wp_remote_post', [var_akismet_url.clone(), rt.create_array_from_native_map(var_http_args)])
		Class_Akismet.log(rt.call_function('compact', [rt.new_string('akismet_url'), rt.new_string('http_args'), rt.new_string('response')]))
		if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
			var_ssl_failed = rt.new_bool(true)
			rt.call_function('do_action', [rt.new_string('akismet_https_request_failure'), var_response.clone()])
			rt.call_function('do_action', [rt.new_string('akismet_http_request_pre')])
			var_response = rt.call_function('wp_remote_post', [var_http_akismet_url.clone(), rt.create_array_from_native_map(var_http_args)])
			Class_Akismet.log(rt.call_function('compact', [rt.new_string('http_akismet_url'), rt.new_string('http_args'), rt.new_string('response')]))
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.call_function('do_action', [rt.new_string('akismet_request_failure'), var_response.clone()])
		return rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: '' }])
	}
	if rt.is_true(var_ssl_failed) {
		rt.call_function('update_option', [rt.new_string('akismet_ssl_disabled'), rt.call_function('time', []rt.PhpVal{})])
		rt.call_function('do_action', [rt.new_string('akismet_https_disabled')])
	}
	mut var_simplified_response := [var_response.array_get(rt.new_string('headers')), var_response.array_get(rt.new_string('body'))]
	mut var_alert_code_check_paths := ['verify-key', 'comment-check', 'get-stats']
	if rt.is_true(rt.call_function('in_array', [var_path.clone(), rt.create_array_from_list(var_alert_code_check_paths)])) {
		Class_Akismet.update_alert(var_simplified_response.clone())
	}
	return var_simplified_response.clone()
}

fn Class_Akismet.update_alert(var_response rt.PhpVal) {
	mut var_response_mutated := var_response
	mut var_alert_option_prefix := rt.new_string('akismet_alert_')
	mut var_alert_header_prefix := rt.new_string('x-akismet-alert-')
	mut var_alert_header_names := ['code', 'msg', 'api-calls', 'usage-limit', 'upgrade-plan', 'upgrade-url', 'upgrade-type', 'upgrade-via-support', 'recommended-plan-name']
	for var_alert_header_name in var_alert_header_names {
		mut var_value := rt.new_null()
		if var_response_mutated.array_get(rt.new_int(0)).array_isset((var_alert_header_prefix).str() + alert_header_name) {
		var_value = var_response_mutated.array_get(rt.new_int(0)).array_get(rt.new_string((var_alert_header_prefix).str() + alert_header_name))
		}
		mut var_option_name := rt.new_string((var_alert_option_prefix).str() + (rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), rt.new_string(alert_header_name)])).str())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_value, rt.call_function('get_option', [var_option_name.clone()]))))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_value)))) {
				rt.call_function('delete_option', [var_option_name.clone()])
			} else {
				rt.call_function('update_option', [var_option_name.clone(), var_value.clone()])
			}
		}
	}
}

fn Class_Akismet.set_form_js_async(var_tag rt.PhpVal, var_handle rt.PhpVal, var_src rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('akismet-frontend'), var_handle)))) {
		return var_tag.clone()
	}
	return rt.call_function('preg_replace', [rt.new_string('/^<script /i'), rt.new_string('<script defer '), var_tag.clone()])
}

fn Class_Akismet.get_akismet_form_fields() rt.PhpVal {
	mut var_field_count := rt.new_null()
	mut var_fields := rt.new_string('')
	mut var_prefix := rt.new_string('ak_')
	if rt.is_true(rt.identical(rt.new_string('wpcf7_form_elements'), rt.call_function('current_filter', []rt.PhpVal{}))) {
	var_prefix = rt.new_string('_wpcf7_ak_')
	}
	var_fields = rt.concat(var_fields, rt.new_string('<p style="display: none !important;" class="akismet-fields-container" data-prefix="' + (rt.call_function('esc_attr', [var_prefix.clone()])).str() + '">'))
	var_fields = rt.concat(var_fields, rt.new_string('<label>&#916;<textarea name="' + (var_prefix).str() + 'hp_textarea" cols="45" rows="8" maxlength="100"></textarea></label>'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('amp_is_request')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('amp_is_request', []rt.PhpVal{}))))) {
		rt.pre_inc(var_field_count)
		var_fields = rt.concat(var_fields, rt.new_string('<input type="hidden" id="ak_js_' + (var_field_count).str() + '" name="' + (var_prefix).str() + 'js" value="' + (rt.call_function('mt_rand', [rt.new_int(0), rt.new_int(250)])).str() + '"/>'))
		var_fields = rt.concat(var_fields, rt.call_function('wp_get_inline_script_tag', [rt.new_string('document.getElementById( "ak_js_' + (var_field_count).str() + '" ).setAttribute( "value", ( new Date() ).getTime() );')]))
	}
	var_fields = rt.concat(var_fields, rt.new_string('</p>'))
	return var_fields.clone()
}

fn Class_Akismet.output_custom_form_fields(var_post_id rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	if rt.is_true(rt.identical(rt.new_string('fluentform/form_element_start'), rt.call_function('current_filter', []rt.PhpVal{}))) && rt.is_true(rt.call_function('did_action', [rt.new_string('fluentform_form_element_start')])) {
		return
	}
	rt.echo_val(Class_Akismet.get_akismet_form_fields())
}

fn Class_Akismet.inject_custom_form_fields(var_html rt.PhpVal) rt.PhpVal {
	mut var_html_mutated := var_html
	var_html_mutated = rt.call_function('str_replace', [rt.new_string('</form>'), rt.new_string((Class_Akismet.get_akismet_form_fields()).str() + '</form>'), var_html_mutated.clone()])
	return var_html_mutated.clone()
}

fn Class_Akismet.append_custom_form_fields(var_html rt.PhpVal) rt.PhpVal {
	mut var_html_mutated := var_html
	var_html_mutated = rt.concat(var_html_mutated, Class_Akismet.get_akismet_form_fields())
	return var_html_mutated.clone()
}

fn Class_Akismet.prepare_custom_form_values(var_form rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_form_mutated := var_form
	mut var_data_mutated := var_data
	if rt.is_true(rt.identical(rt.new_string('fluentform/akismet_fields'), rt.call_function('current_filter', []rt.PhpVal{}))) && rt.is_true(rt.call_function('did_filter', [rt.new_string('fluentform_akismet_fields')])) {
		return var_form_mutated.clone()
	}
	if rt.is_true(rt.new_bool(var_data_mutated.clone().is_null())) {
	var_data_mutated = rt.get_superglobal('_POST')
	}
	mut var_prefix := rt.new_string('ak_')
	if rt.is_true(rt.identical(rt.new_string('wpcf7_akismet_parameters'), rt.call_function('current_filter', []rt.PhpVal{}))) {
	var_prefix = rt.new_string('_wpcf7_ak_')
	}
	mut iter_14 := var_data_mutated.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_val := item_14.val
		mut var_key := item_14.key
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_key.clone(), var_prefix.clone()]))) {
			var_form_mutated.array_set('POST_ak_' + (rt.call_function('substr', [var_key.clone(), rt.new_int(var_prefix.clone().to_string().len)])).str(), var_val.clone())
		}
	}
	return var_form_mutated.clone()
}

fn Class_Akismet.bail_on_activation(var_message rt.PhpVal, deactivate bool) {
	mut var_message_mutated := var_message
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('charset')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_message_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if var_deactivate {
		mut var_plugins := rt.call_function('get_option', [rt.new_string('active_plugins')])
		mut var_akismet := rt.call_function('plugin_basename', [rt.new_string((rt.get_constant('AKISMET__PLUGIN_DIR')).str() + 'akismet.php')])
		mut var_update := rt.new_bool(false)
		mut iter_15 := var_plugins.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_plugin := item_15.val
			mut var_i := item_15.key
			if rt.is_true(rt.identical(var_plugin, var_akismet)) {
				var_plugins.array_set(var_i, false)
			var_update = rt.new_bool(true)
			}
		}
		if rt.is_true(var_update) {
			rt.call_function('update_option', [rt.new_string('active_plugins'), rt.call_function('array_filter', [var_plugins.clone()])])
		}
	}
	exit(0)
}

fn Class_Akismet.view(var_name rt.PhpVal, mut var_args Class_array) {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('apply_filters', [rt.new_string('akismet_view_arguments'), var_args_mutated, var_name.clone()])
	mut iter_16 := var_args_mutated.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_val := item_16.val
		mut var_key := item_16.key
	mut var_{"nodeType":"Expr_Variable","line":2074,"name":"key"} := var_val
	}
	mut var_file := rt.new_string((rt.get_constant('AKISMET__PLUGIN_DIR')).str() + 'views/' + (rt.call_function('basename', [var_name.clone()])).str() + '.php')
	if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
		rt.include_file((var_file).to_string(), '1')
	}
}

fn Class_Akismet.plugin_activation() {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.call_function('version_compare', [var_GLOBALS.array_get(rt.new_string('wp_version')), rt.get_constant('AKISMET__MINIMUM_WP_VERSION'), rt.new_string('<')])) {
		mut var_message := rt.new_string('<strong>' + (rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Akismet %1$s requires WordPress %2$s or higher.'), rt.new_string('akismet')]), rt.get_constant('AKISMET_VERSION'), rt.get_constant('AKISMET__MINIMUM_WP_VERSION')])).str() + '</strong> ' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please <a href="%1$s">upgrade WordPress</a> to a current version, or <a href="%2$s">downgrade to version 2.4 of the Akismet plugin</a>.'), rt.new_string('akismet')]), rt.new_string('https://codex.wordpress.org/Upgrading_WordPress'), rt.new_string('https://wordpress.org/plugins/akismet')])).str())
		Class_Akismet.bail_on_activation((var_message).to_bool())
	} else if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_NAME')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_NAME')), rt.new_string('/wp-admin/plugins.php')]))))) {
		rt.call_function('add_option', [rt.new_string('Activated_Akismet'), rt.new_bool(true)])
	}
}

fn Class_Akismet.plugin_deactivation() {
	Class_Akismet.deactivate_key(Class_Akismet.get_api_key())
	mut var_akismet_cron_events := ['akismet_schedule_cron_recheck', 'akismet_scheduled_delete']
	for var_akismet_cron_event in var_akismet_cron_events {
		mut var_timestamp := rt.call_function('wp_next_scheduled', [rt.new_string(akismet_cron_event)])
		if rt.is_true(var_timestamp) {
			rt.call_function('wp_unschedule_event', [var_timestamp.clone(), rt.new_string(akismet_cron_event)])
		}
	}
}

fn Class_Akismet.build_query(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return rt.call_function('_http_build_query', [var_args_mutated.clone(), rt.new_string(''), rt.new_string('&')])
}

fn Class_Akismet.log(var_akismet_debug rt.PhpVal) {
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('akismet_debug_log'), rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')])) && rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG_LOG')])) && rt.is_true(rt.get_constant('WP_DEBUG_LOG')) && rt.is_true(rt.call_function('defined', [rt.new_string('AKISMET_DEBUG')])) && rt.is_true(rt.get_constant('AKISMET_DEBUG')))])) {
		rt.call_function('error_log', [println(rt.call_function('compact', [rt.new_string('akismet_debug')]).to_string())])
	}
}

fn Class_Akismet.pre_check_pingback(var_method rt.PhpVal, var_args rt.PhpVal, var_server rt.PhpVal) {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_method, rt.new_string('pingback.ping'))))) {
		return
	}
	if !(var_server.clone().is_null()) && !(!rt.is_true(var_args_mutated.array_get(rt.new_int(1)))) {
		mut var_is_multicall := rt.new_bool(false)
		mut var_multicall_count := rt.new_int(0)
		if rt.is_true(rt.identical(rt.new_string('system.multicall'), rt.get_property(rt.get_property(var_server, 'message'), 'methodName'))) {
		var_is_multicall = rt.new_bool(true)
		var_multicall_count = rt.new_int(if rt.call_function('is_countable', [rt.get_property(rt.get_property(var_server, 'message'), 'params')]) { rt.get_property(rt.get_property(var_server, 'message'), 'params').array_count() } else { 0 })
		}
		mut var_post_id := rt.call_function('url_to_postid', [var_args_mutated.array_get(rt.new_int(1))])
		mut var_pingbacks_closed := rt.new_bool(false)
		mut var_post := rt.call_function('get_post', [var_post_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('pings_open', [var_post.clone()]))))) {
		var_pingbacks_closed = rt.new_bool(true)
		}
		mut var_comment := rt.create_array([rt.ArrayItem{ key: 'comment_author_url', val: var_args_mutated.array_get(rt.new_int(0)) }, rt.ArrayItem{ key: 'comment_post_ID', val: var_post_id }, rt.ArrayItem{ key: 'comment_author', val: '' }, rt.ArrayItem{ key: 'comment_author_email', val: '' }, rt.ArrayItem{ key: 'comment_content', val: '' }, rt.ArrayItem{ key: 'comment_type', val: 'pingback' }, rt.ArrayItem{ key: 'akismet_pre_check', val: '1' }, rt.ArrayItem{ key: 'comment_pingback_target', val: var_args_mutated.array_get(rt.new_int(1)) }, rt.ArrayItem{ key: 'pingbacks_closed', val: if rt.is_true(var_pingbacks_closed) { '1' } else { '0' } }, rt.ArrayItem{ key: 'is_multicall', val: var_is_multicall }, rt.ArrayItem{ key: 'multicall_count', val: var_multicall_count }])
		var_comment = Class_Akismet.auto_check_comment((var_comment).str(), rt.new_string('xml-rpc'))
		if var_comment.array_isset(rt.new_string('akismet_result')) && rt.is_true(rt.equal(rt.new_string('true'), var_comment.array_get(rt.new_string('akismet_result')))) {
			rt.call_method(var_server, 'error', [create_ixr_error(rt.new_int(0), rt.new_string('Invalid discovery target'))])
		}
	}
}

fn Class_Akismet.sanitize_comment_as_submitted(var_meta_value rt.PhpVal) rt.PhpVal {
	mut var_meta_value_mutated := var_meta_value
	if !rt.is_true(var_meta_value_mutated) {
		return var_meta_value_mutated.clone()
	}
	var_meta_value_mutated = rt.cast_array(var_meta_value_mutated)
	mut iter_17 := var_meta_value_mutated.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_value := item_17.val
		mut var_key := item_17.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_value.clone()]))))) {
			var_meta_value_mutated.array_unset(var_key)
		} else {
			if rt.is_true(rt.identical(rt.call_function('strpos', [var_key.clone(), rt.new_string('POST_ak_')]), rt.new_int(0))) {
				continue
			}
			if !(rt.get_static_prop('Akismet', 'comment_as_submitted_allowed_keys').array_isset(var_key)) {
				var_meta_value_mutated.array_unset(var_key)
			}
		}
	}
	return var_meta_value_mutated.clone()
}

fn Class_Akismet.predefined_api_key() bool {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WPCOM_API_KEY')])) {
		return true
	}
	return (rt.call_function('apply_filters', [rt.new_string('akismet_predefined_api_key'), rt.new_bool(false)])).to_bool()
}

fn Class_Akismet.display_comment_form_privacy_notice() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('display'), rt.call_function('apply_filters', [rt.new_string('akismet_comment_form_privacy_notice'), rt.call_function('get_option', [rt.new_string('akismet_comment_form_privacy_notice'), rt.new_string('hide')])]))))) {
		return
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('akismet_comment_form_privacy_notice_markup'), rt.new_string('<p class="akismet_comment_form_privacy_notice">' + (rt.call_function('wp_kses', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This site uses Akismet to reduce spam. <a href="%s" target="_blank" rel="nofollow noopener">Learn how your comment data is processed.</a>'), rt.new_string('akismet')]), rt.new_string('https://akismet.com/privacy/')]), rt.create_array([rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.new_array() }, rt.ArrayItem{ key: 'target', val: rt.new_array() }, rt.ArrayItem{ key: 'rel', val: rt.new_array() }]) }])])).str() + '</p>')]))
}

fn Class_Akismet.load_form_js() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('amp_is_request')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('amp_is_request', []rt.PhpVal{}))))) && rt.is_true(Class_Akismet.get_api_key()) {
		rt.call_function('wp_register_script', [rt.new_string('akismet-frontend'), rt.new_string((rt.call_function('plugin_dir_url', [rt.new_string(@FILE)])).str() + '_inc/akismet-frontend.js'), rt.new_array(), rt.call_function('filemtime', [rt.new_string((rt.call_function('plugin_dir_path', [rt.new_string(@FILE)])).str() + '_inc/akismet-frontend.js')]), rt.new_bool(true)])
		rt.call_function('wp_enqueue_script', [rt.new_string('akismet-frontend')])
	}
}

fn Class_Akismet.load_form_js_via_filter(var_return_value rt.PhpVal, var_tag rt.PhpVal, var_attr rt.PhpVal, var_m rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('in_array', [var_tag.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'contact-form' }, rt.ArrayItem{ key: none, val: 'gravityform' }, rt.ArrayItem{ key: none, val: 'contact-form-7' }, rt.ArrayItem{ key: none, val: 'formidable' }, rt.ArrayItem{ key: none, val: 'fluentform' }])])) {
		Class_Akismet.load_form_js()
	}
	return var_return_value.clone()
}

fn Class_Akismet.last_comment_status_change_came_from_akismet(var_comment_id rt.PhpVal) bool {
	mut var_comment_id_mutated := var_comment_id
	mut var_history := Class_Akismet.get_comment_history(var_comment_id_mutated.clone())
	if !rt.is_true(var_history) {
		return false
	}
	mut var_most_recent_history_event := var_history.array_get(rt.new_int(0))
	if !(var_most_recent_history_event.array_isset(rt.new_string('event'))) {
		return false
	}
	mut var_akismet_history_events := ['check-error', 'cron-retry-ham', 'cron-retry-spam', 'check-ham', 'check-ham-pending', 'check-spam', 'recheck-error', 'recheck-ham', 'recheck-spam', 'webhook-ham', 'webhook-spam']
	if rt.is_true(rt.call_function('in_array', [var_most_recent_history_event.array_get(rt.new_string('event')), rt.create_array_from_list(var_akismet_history_events)])) {
		return true
	}
	return false
}

fn Class_Akismet.last_comment_check_response(var_comment_id rt.PhpVal) string {
	mut var_comment_id_mutated := var_comment_id
	mut var_history := Class_Akismet.get_comment_history(var_comment_id_mutated.clone())
	if rt.is_true(var_history) {
		var_history = rt.call_function('array_reverse', [var_history.clone()])
		mut iter_18 := var_history.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_akismet_history_entry := item_18.val
			if !(var_akismet_history_entry.clone().is_array()) {
				continue
			}
			if !(var_akismet_history_entry.array_isset(rt.new_string('event'))) {
				continue
			}
			if rt.is_true(rt.call_function('in_array', [var_akismet_history_entry.array_get(rt.new_string('event')), rt.create_array([rt.ArrayItem{ key: none, val: 'recheck-spam' }, rt.ArrayItem{ key: none, val: 'check-spam' }, rt.ArrayItem{ key: none, val: 'cron-retry-spam' }, rt.ArrayItem{ key: none, val: 'webhook-spam' }, rt.ArrayItem{ key: none, val: 'webhook-spam-noaction' }]), rt.new_bool(true)])) {
				return 'true'
			} else if rt.is_true(rt.call_function('in_array', [var_akismet_history_entry.array_get(rt.new_string('event')), rt.create_array([rt.ArrayItem{ key: none, val: 'recheck-ham' }, rt.ArrayItem{ key: none, val: 'check-ham' }, rt.ArrayItem{ key: none, val: 'cron-retry-ham' }, rt.ArrayItem{ key: none, val: 'webhook-ham' }, rt.ArrayItem{ key: none, val: 'webhook-ham-noaction' }]), rt.new_bool(true)])) {
				return 'false'
			}
		}
	}
	return ''
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_User {
	rt.PhpObjectBase
}

struct Class_IXR_Error {
	rt.PhpObjectBase
}

fn create_akismet(_args ...rt.PhpVal) &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ixr_error(_args ...rt.PhpVal) &Class_IXR_Error {
	mut obj := &Class_IXR_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Akismet.init()
			return rt.new_null()
		}
		'init_hooks' {
			Class_Akismet.init_hooks()
			return rt.new_null()
		}
		'get_api_key' {
			return Class_Akismet.get_api_key()
		}
		'get_access_token' {
			return Class_Akismet.get_access_token()
		}
		'check_key_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Akismet.check_key_status(dispatch_arg_0, dispatch_arg_1)
		}
		'verify_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_Akismet.verify_key(dispatch_arg_0, dispatch_arg_1))
		}
		'deactivate_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Akismet.deactivate_key(dispatch_arg_0))
		}
		'get_stats' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet.get_stats(dispatch_arg_0, dispatch_arg_1))
		}
		'comment_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet.comment_check(dispatch_arg_0, dispatch_arg_1))
		}
		'add_to_jetpack_options_whitelist' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet.add_to_jetpack_options_whitelist(dispatch_arg_0)
		}
		'updated_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Akismet.updated_option(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'added_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Akismet.added_option(dispatch_arg_0, dispatch_arg_1)
		}
		'rest_auto_check_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet.rest_auto_check_comment(dispatch_arg_0)
		}
		'auto_check_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Akismet.auto_check_comment(dispatch_arg_0, dispatch_arg_1)
		}
		'get_last_comment' {
			return Class_Akismet.get_last_comment()
		}
		'set_last_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet.set_last_comment(dispatch_arg_0)
			return rt.new_null()
		}
		'auto_check_update_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Akismet.auto_check_update_meta(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'schedule_email_fallback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Akismet.schedule_email_fallback(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'email_fallback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet.email_fallback(dispatch_arg_0)
			return rt.new_null()
		}
		'schedule_approval_fallback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Akismet.schedule_approval_fallback(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'approval_fallback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet.approval_fallback(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_old_comments' {
			Class_Akismet.delete_old_comments()
			return rt.new_null()
		}
		'delete_old_comments_meta' {
			Class_Akismet.delete_old_comments_meta()
			return rt.new_null()
		}
		'delete_orphaned_commentmeta' {
			Class_Akismet.delete_orphaned_commentmeta()
			return rt.new_null()
		}
		'get_user_comments_approved' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_int(Class_Akismet.get_user_comments_approved(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'get_comment_history' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet.get_comment_history(dispatch_arg_0)
		}
		'update_comment_history' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_Akismet.update_comment_history(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'check_db_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Akismet.check_db_comment(dispatch_arg_0, dispatch_arg_1))
		}
		'recheck_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Akismet.recheck_comment(dispatch_arg_0, dispatch_arg_1)
		}
		'transition_comment_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Akismet.transition_comment_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'submit_spam_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet.submit_spam_comment(dispatch_arg_0)
			return rt.new_null()
		}
		'submit_nonspam_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet.submit_nonspam_comment(dispatch_arg_0)
			return rt.new_null()
		}
		'cron_recheck' {
			return rt.new_bool(Class_Akismet.cron_recheck())
		}
		'fix_scheduled_recheck' {
			Class_Akismet.fix_scheduled_recheck()
			return rt.new_null()
		}
		'add_comment_nonce' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet.add_comment_nonce(dispatch_arg_0)
			return rt.new_null()
		}
		'is_test_mode' {
			return rt.new_bool(Class_Akismet.is_test_mode())
		}
		'allow_discard' {
			return rt.new_bool(Class_Akismet.allow_discard())
		}
		'get_ip_address' {
			return Class_Akismet.get_ip_address()
		}
		'comments_match' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet.comments_match(dispatch_arg_0, dispatch_arg_1))
		}
		'matches_last_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet.matches_last_comment(dispatch_arg_0))
		}
		'matches_last_comment_by_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet.matches_last_comment_by_id(dispatch_arg_0)
		}
		'get_fields_for_comment_matching' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet.get_fields_for_comment_matching(dispatch_arg_0)
		}
		'get_user_agent' {
			return Class_Akismet.get_user_agent()
		}
		'get_referer' {
			return Class_Akismet.get_referer()
		}
		'get_user_roles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet.get_user_roles(dispatch_arg_0))
		}
		'last_comment_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Akismet.last_comment_status(dispatch_arg_0, dispatch_arg_1)
		}
		'disable_emails_if_unreachable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet.disable_emails_if_unreachable(dispatch_arg_0, dispatch_arg_1))
		}
		'_cmp_time' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(Class_Akismet._cmp_time(dispatch_arg_0, dispatch_arg_1))
		}
		'_get_microtime' {
			return Class_Akismet._get_microtime()
		}
		'http_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Akismet.http_post(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'update_alert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet.update_alert(dispatch_arg_0)
			return rt.new_null()
		}
		'set_form_js_async' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Akismet.set_form_js_async(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_akismet_form_fields' {
			return Class_Akismet.get_akismet_form_fields()
		}
		'output_custom_form_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet.output_custom_form_fields(dispatch_arg_0)
			return rt.new_null()
		}
		'inject_custom_form_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet.inject_custom_form_fields(dispatch_arg_0)
		}
		'append_custom_form_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet.append_custom_form_fields(dispatch_arg_0)
		}
		'prepare_custom_form_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Akismet.prepare_custom_form_values(dispatch_arg_0, dispatch_arg_1)
		}
		'bail_on_activation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			Class_Akismet.bail_on_activation(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'view' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_Akismet.view(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'plugin_activation' {
			Class_Akismet.plugin_activation()
			return rt.new_null()
		}
		'plugin_deactivation' {
			Class_Akismet.plugin_deactivation()
			return rt.new_null()
		}
		'build_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet.build_query(dispatch_arg_0)
		}
		'log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet.log(dispatch_arg_0)
			return rt.new_null()
		}
		'pre_check_pingback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Akismet.pre_check_pingback(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'sanitize_comment_as_submitted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet.sanitize_comment_as_submitted(dispatch_arg_0)
		}
		'predefined_api_key' {
			return rt.new_bool(Class_Akismet.predefined_api_key())
		}
		'display_comment_form_privacy_notice' {
			Class_Akismet.display_comment_form_privacy_notice()
			return rt.new_null()
		}
		'load_form_js' {
			Class_Akismet.load_form_js()
			return rt.new_null()
		}
		'load_form_js_via_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_Akismet.load_form_js_via_filter(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'last_comment_status_change_came_from_akismet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet.last_comment_status_change_came_from_akismet(dispatch_arg_0))
		}
		'last_comment_check_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Akismet.last_comment_check_response(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_IXR_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

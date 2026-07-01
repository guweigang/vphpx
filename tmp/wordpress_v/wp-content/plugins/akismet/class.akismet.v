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
pub mut:
		limit_notices rt.PhpVal = rt.new_array()
		last_comment rt.PhpVal = rt.new_string('')
		initiated rt.PhpVal = rt.new_bool(false)
		last_comment_result rt.PhpVal = rt.new_null()
		comment_as_submitted_allowed_keys rt.PhpVal = rt.new_array()
}

fn Class_Akismet.init()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		Class_Akismet.init_hooks()
	}
}

fn Class_Akismet.init_hooks()  {
	// unsupported assign target: Expr_StaticPropertyFetch
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
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(var_access_token.dup().is_null())) {
		mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'api_key', val: Class_Akismet.get_api_key() }])
		var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.dup(), rt.new_string('token')])
		mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_request_args.dup()), rt.new_string('token'))
		mut var_access_token := var_response.array_get(1)
	}
	return var_access_token.dup()
}

fn Class_Akismet.check_key_status(var_key rt.PhpVal, var_ip rt.PhpVal) rt.PhpVal {
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'key', val: var_key }, rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }])
	var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.dup(), rt.new_string('verify-key')])
	return Class_Akismet.http_post(Class_Akismet.build_query(var_request_args.dup()), rt.new_string('verify-key'), var_ip.dup())
}

fn Class_Akismet.verify_key(var_key rt.PhpVal, var_ip rt.PhpVal) string {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		return 'invalid'
	}
	mut var_response := Class_Akismet.check_key_status(var_key.dup(), var_ip.dup())
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
		return 'failed'
	}
	return (var_response.array_get(1)).str()
}

fn Class_Akismet.deactivate_key(var_key rt.PhpVal) string {
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'key', val: var_key }, rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }])
	var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.dup(), rt.new_string('deactivate')])
	mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_request_args.dup()), rt.new_string('deactivate'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		return 'failed'
	}
	return (var_response.array_get(1)).str()
}

fn Class_Akismet.get_stats(interval string, var_api_key rt.PhpVal) bool {
	mut interval_mutated := interval
	mut var_api_key_mutated := var_api_key
	if rt.is_true(rt.new_bool(var_api_key_mutated.dup().is_null())) {
		var_api_key_mutated = Class_Akismet.get_api_key()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_api_key_mutated)))) {
		return false
	}
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }, rt.ArrayItem{ key: 'key', val: var_api_key_mutated }, rt.ArrayItem{ key: 'from', val: interval_mutated }])
	var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.dup(), rt.new_string('get-stats')])
	mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_request_args.dup()), rt.new_string('get-stats'))
	if !rt.is_true(var_response.array_get(1)) {
		return false
	}
	mut var_data := rt.call_function('json_decode', [var_response.array_get(1)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().is_object()))))) {
		return false
	}
	if !(rt.get_property(var_data, 'spam')).is_null() {
		rt.set_property(var_data, 'spam', // unsupported expression: Expr_Cast_Int)
	}
	if !(rt.get_property(var_data, 'ham')).is_null() {
		rt.set_property(var_data, 'ham', // unsupported expression: Expr_Cast_Int)
	}
	if !(rt.get_property(var_data, 'missed_spam')).is_null() {
		rt.set_property(var_data, 'missed_spam', // unsupported expression: Expr_Cast_Int)
	}
	if !(rt.get_property(var_data, 'false_positives')).is_null() {
		rt.set_property(var_data, 'false_positives', // unsupported expression: Expr_Cast_Int)
	}
	if !(rt.get_property(var_data, 'accuracy')).is_null() {
		rt.set_property(var_data, 'accuracy', // unsupported expression: Expr_Cast_Double)
	}
	if !(rt.get_property(var_data, 'time_saved')).is_null() {
		rt.set_property(var_data, 'time_saved', // unsupported expression: Expr_Cast_Int)
	}
	if rt.is_true(rt.new_bool(!(rt.get_property(var_data, 'breakdown')).is_null() && rt.is_true(rt.new_bool(rt.get_property(var_data, 'breakdown').is_object())))) {
		{
			mut iter_1 := rt.get_property(var_data, 'breakdown').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_stats := item_1.val
				mut var_period := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_stats.dup().is_object()))))) {
					continue
				}
				if !(rt.get_property(var_stats, 'spam')).is_null() {
					rt.set_property(var_stats, 'spam', // unsupported expression: Expr_Cast_Int)
				}
				if !(rt.get_property(var_stats, 'ham')).is_null() {
					rt.set_property(var_stats, 'ham', // unsupported expression: Expr_Cast_Int)
				}
				if !(rt.get_property(var_stats, 'missed_spam')).is_null() {
					rt.set_property(var_stats, 'missed_spam', // unsupported expression: Expr_Cast_Int)
				}
				if !(rt.get_property(var_stats, 'false_positives')).is_null() {
					rt.set_property(var_stats, 'false_positives', // unsupported expression: Expr_Cast_Int)
				}
			}
		}
	}
	return (var_data).to_bool()
}

fn Class_Akismet.comment_check(var_comment_data rt.PhpVal, var_api_key rt.PhpVal) bool {
	mut var_api_key_mutated := var_api_key
	if rt.is_true(rt.new_bool(var_api_key_mutated.dup().is_null())) {
		var_api_key_mutated = Class_Akismet.get_api_key()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_api_key_mutated)))) {
		return false
	}
	mut var_request := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }, rt.ArrayItem{ key: 'blog_lang', val: rt.call_function('get_locale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'blog_charset', val: rt.call_function('get_option', [rt.new_string('blog_charset')]) }, rt.ArrayItem{ key: 'user_ip', val: Class_Akismet.get_ip_address() }, rt.ArrayItem{ key: 'user_agent', val: Class_Akismet.get_user_agent() }]), var_comment_data.dup()])
	var_request = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request.dup(), rt.new_string('comment-check')])
	mut var_response := Class_Akismet.http_post(Class_Akismet.build_query(var_request.dup()), rt.new_string('comment-check'))
	if !rt.is_true(var_response.array_get(1)) {
		return false
	}
	mut var_result := // unsupported expression: Expr_Cast_Object
	if var_response.array_get(0).array_isset(rt.new_string('x-akismet-pro-tip')) {
		rt.set_property(var_result, 'pro_tip', var_response.array_get(0).array_get('x-akismet-pro-tip'))
	}
	if var_response.array_get(0).array_isset(rt.new_string('x-akismet-guid')) {
		rt.set_property(var_result, 'guid', var_response.array_get(0).array_get('x-akismet-guid'))
	}
	if var_response.array_get(0).array_isset(rt.new_string('x-akismet-error')) {
		rt.set_property(var_result, 'error', var_response.array_get(0).array_get('x-akismet-error'))
	}
	if var_response.array_get(0).array_isset(rt.new_string('x-akismet-debug-help')) {
		rt.set_property(var_result, 'debug_help', var_response.array_get(0).array_get('x-akismet-debug-help'))
	}
	return (var_result).to_bool()
}

fn Class_Akismet.add_to_jetpack_options_whitelist(var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	var_options_mutated.array_push('wordpress_api_key')
	return var_options_mutated.dup()
}

fn Class_Akismet.updated_option(var_old_value rt.PhpVal, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WPCOM_JSON_API_Update_Option_Endpoint')]))))) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		Class_Akismet.verify_key(var_value_mutated.dup())
	}
}

fn Class_Akismet.added_option(var_option_name rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_option_name_mutated := var_option_name
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string('wordpress_api_key'), var_option_name_mutated)) {
		return Class_Akismet.updated_option(rt.new_string(''), var_value_mutated.dup())
	}
	return rt.new_null()
}

fn Class_Akismet.rest_auto_check_comment(var_commentdata rt.PhpVal) rt.PhpVal {
	mut var_commentdata_mutated := var_commentdata
	return Class_Akismet.auto_check_comment((var_commentdata_mutated).str(), rt.new_string('rest_api'))
}

fn Class_Akismet.auto_check_comment(var_commentdata rt.PhpVal, context string) rt.PhpVal {
	mut var_commentdata_mutated := var_commentdata
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		return .dup()
	}
	if !(.array_isset()) {
	}
	
}

fn Class_Akismet.get_last_comment() rt.PhpVal {
}

fn Class_Akismet.set_last_comment(var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
}

fn Class_Akismet.auto_check_update_meta(var_id rt.PhpVal, var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
}

fn Class_Akismet.schedule_email_fallback(var_id rt.PhpVal, var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
}

fn Class_Akismet.email_fallback(var_comment_id rt.PhpVal)  {
	mut var_comment_id_mutated := var_comment_id
}

fn Class_Akismet.schedule_approval_fallback(var_id rt.PhpVal, var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
}

fn Class_Akismet.approval_fallback(var_comment_id rt.PhpVal)  {
	mut var_comment_id_mutated := var_comment_id
}

fn Class_Akismet.delete_old_comments()  {
	mut var_wpdb := rt.new_null()
}

fn Class_Akismet.delete_old_comments_meta()  {
	mut var_wpdb := rt.new_null()
}

fn Class_Akismet.delete_orphaned_commentmeta()  {
	mut var_wpdb := rt.new_null()
}

fn Class_Akismet.get_user_comments_approved(var_user_id rt.PhpVal, var_comment_author_email rt.PhpVal, var_comment_author rt.PhpVal, var_comment_author_url rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_comment_author_email_mutated := var_comment_author_email
	mut var_comment_author_mutated := var_comment_author
	mut var_comment_author_url_mutated := var_comment_author_url
}

fn Class_Akismet.get_comment_history(var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_comment_id_mutated := var_comment_id
}

fn Class_Akismet.update_comment_history(var_comment_id rt.PhpVal, var_message rt.PhpVal, var_event rt.PhpVal, var_meta rt.PhpVal)  {
	mut var_current_user := rt.new_null()
	mut var_comment_id_mutated := var_comment_id
	mut var_message_mutated := var_message
	mut var_event_mutated := var_event
}

fn Class_Akismet.check_db_comment(var_id rt.PhpVal, recheck_reason string) bool {
	mut var_wpdb := rt.new_null()
}

fn Class_Akismet.recheck_comment(var_id rt.PhpVal, recheck_reason string) rt.PhpVal {
}

fn Class_Akismet.transition_comment_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	mut var_comment_mutated := var_comment
	return rt.new_null()
}

fn Class_Akismet.submit_spam_comment(var_comment_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_current_user := rt.new_null()
	mut var_current_site := rt.new_null()
	mut var_comment_id_mutated := var_comment_id
}

fn Class_Akismet.submit_nonspam_comment(var_comment_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_current_user := rt.new_null()
	mut var_current_site := rt.new_null()
	mut var_comment_id_mutated := var_comment_id
}

fn Class_Akismet.cron_recheck() bool {
	mut var_wpdb := rt.new_null()
	return false
}

fn Class_Akismet.fix_scheduled_recheck()  {
}

fn Class_Akismet.add_comment_nonce(var_post_id rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
}

fn Class_Akismet.is_test_mode() bool {
}

fn Class_Akismet.allow_discard() bool {
}

fn Class_Akismet.get_ip_address() rt.PhpVal {
}

fn Class_Akismet.comments_match(var_comment1 rt.PhpVal, var_comment2 rt.PhpVal) bool {
	mut var_comment1_mutated := var_comment1
	mut var_comment2_mutated := var_comment2
}

fn Class_Akismet.matches_last_comment(var_comment rt.PhpVal) bool {
	mut var_comment_mutated := var_comment
}

fn Class_Akismet.matches_last_comment_by_id(var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_comment_id_mutated := var_comment_id
}

fn Class_Akismet.get_fields_for_comment_matching(var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_comment_id_mutated := var_comment_id
}

fn Class_Akismet.get_user_agent() rt.PhpVal {
}

fn Class_Akismet.get_referer() rt.PhpVal {
}

fn Class_Akismet.get_user_roles(var_user_id rt.PhpVal) bool {
}

fn Class_Akismet.last_comment_status(var_approved rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	mut var_comment_mutated := var_comment
}

fn Class_Akismet.disable_emails_if_unreachable(var_maybe_notify rt.PhpVal, var_comment_id rt.PhpVal) bool {
	mut var_comment_id_mutated := var_comment_id
}

fn Class_Akismet._cmp_time(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
}

fn Class_Akismet._get_microtime() rt.PhpVal {
}

fn Class_Akismet.http_post(var_request rt.PhpVal, var_path rt.PhpVal, var_ip rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_request_mutated := var_request
}

fn Class_Akismet.update_alert(var_response rt.PhpVal)  {
	mut var_response_mutated := var_response
}

fn Class_Akismet.set_form_js_async(var_tag rt.PhpVal, var_handle rt.PhpVal, var_src rt.PhpVal) rt.PhpVal {
}

fn Class_Akismet.get_akismet_form_fields() rt.PhpVal {
	mut var_field_count := rt.new_null()
}

fn Class_Akismet.output_custom_form_fields(var_post_id rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
}

fn Class_Akismet.inject_custom_form_fields(var_html rt.PhpVal) rt.PhpVal {
	mut var_html_mutated := var_html
}

fn Class_Akismet.append_custom_form_fields(var_html rt.PhpVal) rt.PhpVal {
	mut var_html_mutated := var_html
}

fn Class_Akismet.prepare_custom_form_values(var_form rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_form_mutated := var_form
	mut var_data_mutated := var_data
}

fn Class_Akismet.bail_on_activation(var_message rt.PhpVal, deactivate bool)  {
	mut var_message_mutated := var_message
}

fn Class_Akismet.view(var_name rt.PhpVal, mut var_args Class_array)  {
	mut var_args_mutated := var_args
}

fn Class_Akismet.plugin_activation()  {
	mut var_GLOBALS := rt.new_null()
}

fn Class_Akismet.plugin_deactivation()  {
}

fn Class_Akismet.build_query(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn Class_Akismet.log(var_akismet_debug rt.PhpVal)  {
}

fn Class_Akismet.pre_check_pingback(var_method rt.PhpVal, var_args rt.PhpVal, var_server rt.PhpVal)  {
	mut var_args_mutated := var_args
}

fn Class_Akismet.sanitize_comment_as_submitted(var_meta_value rt.PhpVal) rt.PhpVal {
	mut var_meta_value_mutated := var_meta_value
}

fn Class_Akismet.predefined_api_key() bool {
}

fn Class_Akismet.display_comment_form_privacy_notice()  {
}

fn Class_Akismet.load_form_js()  {
}

fn Class_Akismet.load_form_js_via_filter(var_return_value rt.PhpVal, var_tag rt.PhpVal, var_attr rt.PhpVal, var_m rt.PhpVal) rt.PhpVal {
}

fn Class_Akismet.last_comment_status_change_came_from_akismet(var_comment_id rt.PhpVal) bool {
	mut var_comment_id_mutated := var_comment_id
}

fn Class_Akismet.last_comment_check_response(var_comment_id rt.PhpVal) string {
	mut var_comment_id_mutated := var_comment_id
}

fn create_akismet() &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
		limit_notices: rt.new_array()
		last_comment: rt.new_string('')
		initiated: rt.new_bool(false)
		last_comment_result: rt.new_null()
		comment_as_submitted_allowed_keys: rt.new_array()
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
	match prop_name {
		'limit_notices' { return this.limit_notices }
		'last_comment' { return this.last_comment }
		'initiated' { return this.initiated }
		'last_comment_result' { return this.last_comment_result }
		'comment_as_submitted_allowed_keys' { return this.comment_as_submitted_allowed_keys }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'limit_notices' { this.limit_notices = val; return true }
		'last_comment' { this.last_comment = val; return true }
		'initiated' { this.initiated = val; return true }
		'last_comment_result' { this.last_comment_result = val; return true }
		'comment_as_submitted_allowed_keys' { this.comment_as_submitted_allowed_keys = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_akismet_class_akismet_php() {
}

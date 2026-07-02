import rt

var_wpcom_api_key = if rt.is_true(rt.call_function('defined', [
	rt.new_string('WPCOM_API_KEY'),
]))
{ rt.call_function('constant', [rt.new_string('WPCOM_API_KEY')]) } else { rt.new_string('') }
mut iife_temp_0 := Class_Akismet{}
mut iife_result_0 := iife_temp_0.get_api_key()
var_akismet_api_host = rt.new_string(iife_result_0.str() + '.rest.akismet.com')
var_akismet_api_port = 80
fn akismet_test_mode() rt.PhpVal {
	mut iife_temp_1 := Class_Akismet{}
	mut iife_result_1 := iife_temp_1.is_test_mode()
	return iife_result_1
}

fn akismet_http_post(var_request rt.PhpVal, var_host rt.PhpVal, var_path_arg rt.PhpVal, port i64, var_ip rt.PhpVal) rt.PhpVal {
	mut var_port := port
	mut var_path := var_path_arg
	var_path = rt.call_function('str_replace', [rt.new_string('/1.1/'),
		rt.new_string(''), var_path.clone()])
	mut iife_temp_2 := Class_Akismet{}
	mut iife_result_2 := iife_temp_2.http_post(var_request.clone(), var_path.clone(),
		var_ip.clone())
	return iife_result_2
}

fn akismet_microtime() rt.PhpVal {
	mut iife_temp_3 := Class_Akismet{}
	mut iife_result_3 := iife_temp_3._get_microtime()
	return iife_result_3
}

fn akismet_delete_old() rt.PhpVal {
	mut iife_temp_4 := Class_Akismet{}
	mut iife_result_4 := iife_temp_4.delete_old_comments()
	return iife_result_4
}

fn akismet_delete_old_metadata() rt.PhpVal {
	mut iife_temp_5 := Class_Akismet{}
	mut iife_result_5 := iife_temp_5.delete_old_comments_meta()
	return iife_result_5
}

fn akismet_check_db_comment(var_id rt.PhpVal, recheck_reason string) rt.PhpVal {
	mut var_recheck_reason := recheck_reason
	mut iife_temp_6 := Class_Akismet{}
	mut iife_result_6 := iife_temp_6.check_db_comment(var_id.clone(), rt.new_string(recheck_reason))
	return iife_result_6
}

fn akismet_rightnow() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('Akismet_Admin'),
	])))))
	{
		return false
	}
	mut iife_temp_7 := Class_Akismet_Admin{}
	mut iife_result_7 := iife_temp_7.rightnow_stats()
	return iife_result_7.to_bool()
}

fn akismet_admin_init() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_version_warning() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_load_js_and_css() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_nonce_field(var_action rt.PhpVal) rt.PhpVal {
	return rt.call_function('wp_nonce_field', [var_action.clone()])
}

fn akismet_plugin_action_links(var_links rt.PhpVal, var_file rt.PhpVal) rt.PhpVal {
	mut iife_temp_8 := Class_Akismet_Admin{}
	mut iife_result_8 := iife_temp_8.plugin_action_links(var_links.clone(), var_file.clone())
	return iife_result_8
}

fn akismet_conf() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_stats_display() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_stats() rt.PhpVal {
	mut iife_temp_9 := Class_Akismet_Admin{}
	mut iife_result_9 := iife_temp_9.dashboard_stats()
	return iife_result_9
}

fn akismet_admin_warnings() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_comment_row_action(var_a rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	mut iife_temp_10 := Class_Akismet_Admin{}
	mut iife_result_10 := iife_temp_10.comment_row_actions(var_a.clone(), var_comment.clone())
	return iife_result_10
}

fn akismet_comment_status_meta_box(var_comment rt.PhpVal) rt.PhpVal {
	mut iife_temp_11 := Class_Akismet_Admin{}
	mut iife_result_11 := iife_temp_11.comment_status_meta_box(var_comment.clone())
	return iife_result_11
}

fn akismet_comments_columns(var_columns rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
	return var_columns.clone()
}

fn akismet_comment_column_row(var_column rt.PhpVal, var_comment_id rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_text_add_link_callback(var_m rt.PhpVal) rt.PhpVal {
	mut iife_temp_12 := Class_Akismet_Admin{}
	mut iife_result_12 := iife_temp_12.text_add_link_callback(var_m.clone())
	return iife_result_12
}

fn akismet_text_add_link_class(var_comment_text rt.PhpVal) rt.PhpVal {
	mut iife_temp_13 := Class_Akismet_Admin{}
	mut iife_result_13 := iife_temp_13.text_add_link_class(var_comment_text.clone())
	return iife_result_13
}

fn akismet_check_for_spam_button(var_comment_status rt.PhpVal) rt.PhpVal {
	mut iife_temp_14 := Class_Akismet_Admin{}
	mut iife_result_14 := iife_temp_14.check_for_spam_button(var_comment_status.clone())
	return iife_result_14
}

fn akismet_submit_nonspam_comment(var_comment_id rt.PhpVal) rt.PhpVal {
	mut iife_temp_15 := Class_Akismet{}
	mut iife_result_15 := iife_temp_15.submit_nonspam_comment(var_comment_id.clone())
	return iife_result_15
}

fn akismet_submit_spam_comment(var_comment_id rt.PhpVal) rt.PhpVal {
	mut iife_temp_16 := Class_Akismet{}
	mut iife_result_16 := iife_temp_16.submit_spam_comment(var_comment_id.clone())
	return iife_result_16
}

fn akismet_transition_comment_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	mut iife_temp_17 := Class_Akismet{}
	mut iife_result_17 := iife_temp_17.transition_comment_status(var_new_status.clone(),
		var_old_status.clone(), var_comment.clone())
	return iife_result_17
}

fn akismet_spam_count(type bool) rt.PhpVal {
	mut var_type := type
	mut iife_temp_18 := Class_Akismet_Admin{}
	mut iife_result_18 := iife_temp_18.get_spam_count(rt.new_bool(type))
	return iife_result_18
}

fn akismet_recheck_queue() rt.PhpVal {
	mut iife_temp_19 := Class_Akismet_Admin{}
	mut iife_result_19 := iife_temp_19.recheck_queue()
	return iife_result_19
}

fn akismet_remove_comment_author_url() rt.PhpVal {
	mut iife_temp_20 := Class_Akismet_Admin{}
	mut iife_result_20 := iife_temp_20.remove_comment_author_url()
	return iife_result_20
}

fn akismet_add_comment_author_url() rt.PhpVal {
	mut iife_temp_21 := Class_Akismet_Admin{}
	mut iife_result_21 := iife_temp_21.add_comment_author_url()
	return iife_result_21
}

fn akismet_check_server_connectivity() rt.PhpVal {
	mut iife_temp_22 := Class_Akismet_Admin{}
	mut iife_result_22 := iife_temp_22.check_server_connectivity()
	return iife_result_22
}

fn akismet_get_server_connectivity(cache_timeout i64) rt.PhpVal {
	mut var_cache_timeout := cache_timeout
	mut iife_temp_23 := Class_Akismet_Admin{}
	mut iife_result_23 := iife_temp_23.get_server_connectivity(rt.new_int(cache_timeout))
	return iife_result_23
}

fn akismet_server_connectivity_ok() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
	return true
}

fn akismet_admin_menu() rt.PhpVal {
	mut iife_temp_24 := Class_Akismet_Admin{}
	mut iife_result_24 := iife_temp_24.admin_menu()
	return iife_result_24
}

fn akismet_load_menu() rt.PhpVal {
	mut iife_temp_25 := Class_Akismet_Admin{}
	mut iife_result_25 := iife_temp_25.load_menu()
	return iife_result_25
}

fn akismet_init() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_get_key() rt.PhpVal {
	mut iife_temp_26 := Class_Akismet{}
	mut iife_result_26 := iife_temp_26.get_api_key()
	return iife_result_26
}

fn akismet_check_key_status(var_key rt.PhpVal, var_ip rt.PhpVal) rt.PhpVal {
	mut iife_temp_27 := Class_Akismet{}
	mut iife_result_27 := iife_temp_27.check_key_status(var_key.clone(), var_ip.clone())
	return iife_result_27
}

fn akismet_update_alert(var_response rt.PhpVal) rt.PhpVal {
	mut iife_temp_28 := Class_Akismet{}
	mut iife_result_28 := iife_temp_28.update_alert(var_response.clone())
	return iife_result_28
}

fn akismet_verify_key(var_key rt.PhpVal, var_ip rt.PhpVal) rt.PhpVal {
	mut iife_temp_29 := Class_Akismet{}
	mut iife_result_29 := iife_temp_29.verify_key(var_key.clone(), var_ip.clone())
	return iife_result_29
}

fn akismet_get_user_roles(var_user_id rt.PhpVal) rt.PhpVal {
	mut iife_temp_30 := Class_Akismet{}
	mut iife_result_30 := iife_temp_30.get_user_roles(var_user_id.clone())
	return iife_result_30
}

fn akismet_result_spam(var_approved rt.PhpVal) rt.PhpVal {
	mut iife_temp_31 := Class_Akismet{}
	mut iife_result_31 := iife_temp_31.comment_is_spam(var_approved.clone())
	return iife_result_31
}

fn akismet_result_hold(var_approved rt.PhpVal) rt.PhpVal {
	mut iife_temp_32 := Class_Akismet{}
	mut iife_result_32 := iife_temp_32.comment_needs_moderation(var_approved.clone())
	return iife_result_32
}

fn akismet_get_user_comments_approved(var_user_id rt.PhpVal, var_comment_author_email rt.PhpVal, var_comment_author rt.PhpVal, var_comment_author_url rt.PhpVal) rt.PhpVal {
	mut iife_temp_33 := Class_Akismet{}
	mut iife_result_33 := iife_temp_33.get_user_comments_approved(var_user_id.clone(),
		var_comment_author_email.clone(), var_comment_author.clone(),
		var_comment_author_url.clone())
	return iife_result_33
}

fn akismet_update_comment_history(var_comment_id rt.PhpVal, var_message rt.PhpVal, var_event rt.PhpVal) rt.PhpVal {
	mut iife_temp_34 := Class_Akismet{}
	mut iife_result_34 := iife_temp_34.update_comment_history(var_comment_id.clone(),
		var_message.clone(), var_event.clone())
	return iife_result_34
}

fn akismet_get_comment_history(var_comment_id rt.PhpVal) rt.PhpVal {
	mut iife_temp_35 := Class_Akismet{}
	mut iife_result_35 := iife_temp_35.get_comment_history(var_comment_id.clone())
	return iife_result_35
}

fn akismet_cmp_time(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	mut iife_temp_36 := Class_Akismet{}
	mut iife_result_36 := iife_temp_36._cmp_time(var_a.clone(), var_b.clone())
	return iife_result_36
}

fn akismet_auto_check_update_meta(var_id rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	mut iife_temp_37 := Class_Akismet{}
	mut iife_result_37 := iife_temp_37.auto_check_update_meta(var_id.clone(), var_comment.clone())
	return iife_result_37
}

fn akismet_auto_check_comment(var_commentdata rt.PhpVal) rt.PhpVal {
	mut iife_temp_38 := Class_Akismet{}
	mut iife_result_38 := iife_temp_38.auto_check_comment(var_commentdata.clone())
	return iife_result_38
}

fn akismet_get_ip_address() rt.PhpVal {
	mut iife_temp_39 := Class_Akismet{}
	mut iife_result_39 := iife_temp_39.get_ip_address()
	return iife_result_39
}

fn akismet_cron_recheck() rt.PhpVal {
	mut iife_temp_40 := Class_Akismet{}
	mut iife_result_40 := iife_temp_40.cron_recheck()
	return iife_result_40
}

fn akismet_add_comment_nonce(var_post_id rt.PhpVal) rt.PhpVal {
	mut iife_temp_41 := Class_Akismet{}
	mut iife_result_41 := iife_temp_41.add_comment_nonce(var_post_id.clone())
	return iife_result_41
}

fn akismet_fix_scheduled_recheck() rt.PhpVal {
	mut iife_temp_42 := Class_Akismet{}
	mut iife_result_42 := iife_temp_42.fix_scheduled_recheck()
	return iife_result_42
}

fn akismet_spam_comments() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
	return rt.new_array()
}

fn akismet_spam_totals() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
	return rt.new_array()
}

fn akismet_manage_page() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_caught() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn redirect_old_akismet_urls() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_kill_proxy_check(var_option rt.PhpVal) i64 {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
	return 0
}

fn akismet_pingback_forwarded_for(var_r rt.PhpVal, var_url rt.PhpVal) bool {
	return false
}

fn akismet_pre_check_pingback(var_method rt.PhpVal) rt.PhpVal {
	mut iife_temp_43 := Class_Akismet{}
	mut iife_result_43 := iife_temp_43.pre_check_pingback(var_method.clone())
	return iife_result_43
}

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

fn create_akismet(_args ...rt.PhpVal) &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet_admin(_args ...rt.PhpVal) &Class_Akismet_Admin {
	mut obj := &Class_Akismet_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Akismet_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wpcom_api_key := rt.get_superglobal('wpcom_api_key')
	mut var_akismet_api_host := rt.get_superglobal('akismet_api_host')
	mut var_akismet_api_port := rt.get_superglobal('akismet_api_port')
}

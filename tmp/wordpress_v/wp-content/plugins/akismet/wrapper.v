import rt

fn akismet_test_mode() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.is_test_mode()
	}()
}

fn akismet_http_post(var_request rt.PhpVal, var_host rt.PhpVal, var_path rt.PhpVal, port i64, var_ip rt.PhpVal) rt.PhpVal {
	var_path = rt.call_function('str_replace', [rt.new_string('/1.1/'),
		rt.new_string(''), var_path.dup()])
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.http_post(arg_0, arg_1, arg_2)
	}(var_request.dup(), var_path.dup(), var_ip.dup())
}

fn akismet_microtime() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp._get_microtime()
	}()
}

fn akismet_delete_old() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.delete_old_comments()
	}()
}

fn akismet_delete_old_metadata() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.delete_old_comments_meta()
	}()
}

fn akismet_check_db_comment(var_id rt.PhpVal, recheck_reason string) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.check_db_comment(arg_0, arg_1)
	}(var_id.dup(), rt.new_string(recheck_reason))
}

fn akismet_rightnow() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('Akismet_Admin'),
	])))))
	{
		return false
	}
	return (fn () rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.rightnow_stats()
	}()).to_bool()
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
	return rt.call_function('wp_nonce_field', [var_action.dup()])
}

fn akismet_plugin_action_links(var_links rt.PhpVal, var_file rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.plugin_action_links(arg_0, arg_1)
	}(var_links.dup(), var_file.dup())
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
	return fn () rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.dashboard_stats()
	}()
}

fn akismet_admin_warnings() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_comment_row_action(var_a rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.comment_row_actions(arg_0, arg_1)
	}(var_a.dup(), var_comment.dup())
}

fn akismet_comment_status_meta_box(var_comment rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.comment_status_meta_box(arg_0)
	}(var_comment.dup())
}

fn akismet_comments_columns(var_columns rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
	return var_columns.dup()
}

fn akismet_comment_column_row(var_column rt.PhpVal, var_comment_id rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_text_add_link_callback(var_m rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.text_add_link_callback(arg_0)
	}(var_m.dup())
}

fn akismet_text_add_link_class(var_comment_text rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.text_add_link_class(arg_0)
	}(var_comment_text.dup())
}

fn akismet_check_for_spam_button(var_comment_status rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.check_for_spam_button(arg_0)
	}(var_comment_status.dup())
}

fn akismet_submit_nonspam_comment(var_comment_id rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.submit_nonspam_comment(arg_0)
	}(var_comment_id.dup())
}

fn akismet_submit_spam_comment(var_comment_id rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.submit_spam_comment(arg_0)
	}(var_comment_id.dup())
}

fn akismet_transition_comment_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.transition_comment_status(arg_0, arg_1, arg_2)
	}(var_new_status.dup(), var_old_status.dup(), var_comment.dup())
}

fn akismet_spam_count(type bool) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.get_spam_count(arg_0)
	}(rt.new_bool(type))
}

fn akismet_recheck_queue() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.recheck_queue()
	}()
}

fn akismet_remove_comment_author_url() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.remove_comment_author_url()
	}()
}

fn akismet_add_comment_author_url() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.add_comment_author_url()
	}()
}

fn akismet_check_server_connectivity() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.check_server_connectivity()
	}()
}

fn akismet_get_server_connectivity(cache_timeout i64) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.get_server_connectivity(arg_0)
	}(rt.new_int(cache_timeout))
}

fn akismet_server_connectivity_ok() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
	return true
}

fn akismet_admin_menu() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.admin_menu()
	}()
}

fn akismet_load_menu() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.load_menu()
	}()
}

fn akismet_init() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0')])
}

fn akismet_get_key() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.get_api_key()
	}()
}

fn akismet_check_key_status(var_key rt.PhpVal, var_ip rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.check_key_status(arg_0, arg_1)
	}(var_key.dup(), var_ip.dup())
}

fn akismet_update_alert(var_response rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.update_alert(arg_0)
	}(var_response.dup())
}

fn akismet_verify_key(var_key rt.PhpVal, var_ip rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.verify_key(arg_0, arg_1)
	}(var_key.dup(), var_ip.dup())
}

fn akismet_get_user_roles(var_user_id rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.get_user_roles(arg_0)
	}(var_user_id.dup())
}

fn akismet_result_spam(var_approved rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.comment_is_spam(arg_0)
	}(var_approved.dup())
}

fn akismet_result_hold(var_approved rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.comment_needs_moderation(arg_0)
	}(var_approved.dup())
}

fn akismet_get_user_comments_approved(var_user_id rt.PhpVal, var_comment_author_email rt.PhpVal, var_comment_author rt.PhpVal, var_comment_author_url rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.get_user_comments_approved(arg_0, arg_1, arg_2, arg_3)
	}(var_user_id.dup(), var_comment_author_email.dup(), var_comment_author.dup(),
		var_comment_author_url.dup())
}

fn akismet_update_comment_history(var_comment_id rt.PhpVal, var_message rt.PhpVal, var_event rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.update_comment_history(arg_0, arg_1, arg_2)
	}(var_comment_id.dup(), var_message.dup(), var_event.dup())
}

fn akismet_get_comment_history(var_comment_id rt.PhpVal) rt.PhpVal {
	return
}

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

fn create_akismet() &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet_admin() &Class_Akismet_Admin {
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

pub fn init_wp_content_plugins_akismet_wrapper_php() {
	// unsupported statement: Stmt_Global
	mut var_wpcom_api_key := if rt.is_true(rt.call_function('defined', [
		rt.new_string('WPCOM_API_KEY'),
	]))
	{ rt.call_function('constant', [rt.new_string('WPCOM_API_KEY')]) } else { rt.new_string('') }
	mut var_akismet_api_host := rt.new_string((fn () rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.get_api_key()
	}()).str() + '.rest.akismet.com')
	mut var_akismet_api_port := 80
}

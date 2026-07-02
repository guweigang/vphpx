import rt

struct Class_Akismet_Ability_Comment_Check {
	rt.PhpObjectBase
}

fn (mut this Class_Akismet_Ability_Comment_Check) get_ability_name() string {
	return 'akismet/comment-check'
}

fn (mut this Class_Akismet_Ability_Comment_Check) get_label() string {
	return (rt.call_function('__', [rt.new_string('Check comment for spam'), rt.new_string('akismet')])).str()
}

fn (mut this Class_Akismet_Ability_Comment_Check) get_description() string {
	return (rt.call_function('__', [rt.new_string('Checks a comment against the Akismet spam filter to determine if it is spam or legitimate content.'), rt.new_string('akismet')])).str()
}

fn (mut this Class_Akismet_Ability_Comment_Check) get_input_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'comment_author', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Name of the comment author.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'comment_author_email', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email address of the comment author.'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'format', val: 'email' }]) }, rt.ArrayItem{ key: 'comment_author_url', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('URL/website of the comment author.'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'format', val: 'uri' }]) }, rt.ArrayItem{ key: 'comment_content', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The comment content/text.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'comment_type', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The comment type (e.g., "comment", "trackback", "pingback").'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'default', val: 'comment' }]) }, rt.ArrayItem{ key: 'comment_post_ID', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID of the post the comment is being submitted to.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'permalink', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The permanent link to the post or page.'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'format', val: 'uri' }]) }, rt.ArrayItem{ key: 'user_ip', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('IP address of the commenter.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'user_agent', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('User agent string of the web browser submitting the comment.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'referrer', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The HTTP_REFERER header.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'user_role', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The user role of the comment author if logged in.'), rt.new_string('akismet')]) }]) }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
}

fn (mut this Class_Akismet_Ability_Comment_Check) get_output_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'success', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the check was successfully performed.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'is_spam', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the comment is identified as spam.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'pro_tip', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optional recommendation from Akismet (e.g., "discard" for obvious spam).'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'guid', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for this check, used for webhooks and updates.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'error', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Error message if the check could not be completed.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'debug_help', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Debug information to help troubleshoot issues.'), rt.new_string('akismet')]) }]) }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
}

fn (mut this Class_Akismet_Ability_Comment_Check) get_config() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'label', val: this.get_label() }, rt.ArrayItem{ key: 'description', val: this.get_description() }, rt.ArrayItem{ key: 'category', val: Class_Akismet_Abilities.category_slug() }, rt.ArrayItem{ key: 'input_schema', val: this.get_input_schema() }, rt.ArrayItem{ key: 'output_schema', val: this.get_output_schema() }, rt.ArrayItem{ key: 'execute_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Akismet_Ability_Comment_Check', ['Akismet_Ability', 'Akismet_Ability_Interface'], &this) }, rt.ArrayItem{ key: none, val: 'execute' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Akismet_Ability_Comment_Check', ['Akismet_Ability', 'Akismet_Ability_Interface'], &this) }, rt.ArrayItem{ key: none, val: 'current_user_has_permission' }]) }, rt.ArrayItem{ key: 'meta', val: rt.create_array([rt.ArrayItem{ key: 'annotations', val: rt.create_array([rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'destructive', val: false }, rt.ArrayItem{ key: 'idempotent', val: false }]) }, rt.ArrayItem{ key: 'mcp', val: rt.create_array([rt.ArrayItem{ key: 'public', val: rt.identical(rt.call_function('get_option', [rt.new_string('akismet_enable_mcp_access')]), rt.new_string('1')) }, rt.ArrayItem{ key: 'type', val: 'tool' }]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }]) }])
}

fn (mut this Class_Akismet_Ability_Comment_Check) execute(mut var_input Class_?array) rt.PhpVal {
	mut iife_temp_0 := Class_Akismet{}
	mut iife_result_0 := iife_temp_0.get_api_key()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return create_wp_error(rt.new_string('akismet_not_configured'), rt.call_function('__', [rt.new_string('Akismet is not configured. Please enter an API key.'), rt.new_string('akismet')]))
	}
	mut iife_temp_1 := Class_Akismet{}
	mut iife_result_1 := iife_temp_1.comment_check(rt.new_object('?array', []string{}, var_input))
	mut var_result := iife_result_1
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return create_wp_error(rt.new_string('comment_check_failed'), rt.call_function('__', [rt.new_string('Failed to check comment with Akismet API.'), rt.new_string('akismet')]))
	}
	mut var_response := { 'success': rt.new_bool(true), 'is_spam': rt.get_property(var_result, 'is_spam') }
	if !(rt.get_property(var_result, 'pro_tip')).is_null() {
		var_response['pro_tip'] = rt.get_property(var_result, 'pro_tip')
	}
	if !(rt.get_property(var_result, 'guid')).is_null() {
		var_response['guid'] = rt.get_property(var_result, 'guid')
	}
	if !(rt.get_property(var_result, 'error')).is_null() {
		var_response['error'] = rt.get_property(var_result, 'error')
	}
	if !(rt.get_property(var_result, 'debug_help')).is_null() {
		var_response['debug_help'] = rt.get_property(var_result, 'debug_help')
	}
	return var_response.clone()
}

struct Class_Akismet_Ability {
	rt.PhpObjectBase
}

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_akismet_ability_comment_check(_args ...rt.PhpVal) &Class_Akismet_Ability_Comment_Check {
	mut obj := &Class_Akismet_Ability_Comment_Check{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet_ability(_args ...rt.PhpVal) &Class_Akismet_Ability {
	mut obj := &Class_Akismet_Ability{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn (mut this Class_Akismet_Ability_Comment_Check) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_ability_name' {
			return rt.new_string(this.get_ability_name())
		}
		'get_label' {
			return rt.new_string(this.get_label())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_input_schema' {
			return this.get_input_schema()
		}
		'get_output_schema' {
			return this.get_output_schema()
		}
		'get_config' {
			return this.get_config()
		}
		'execute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.execute(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Akismet_Ability_Comment_Check) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Ability_Comment_Check) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Akismet_Ability) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet_Ability) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Ability) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

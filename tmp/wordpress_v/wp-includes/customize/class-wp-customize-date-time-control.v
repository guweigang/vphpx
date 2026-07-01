import rt

struct Class_WP_Customize_Date_Time_Control {
	rt.PhpObjectBase
pub mut:
		prop_type rt.PhpVal = rt.new_string('date_time')
		min_year rt.PhpVal = rt.new_int(1000)
		max_year rt.PhpVal = rt.new_int(9999)
		allow_past_date rt.PhpVal = rt.new_bool(true)
		include_time rt.PhpVal = rt.new_bool(true)
		twelve_hour_format rt.PhpVal = rt.new_bool(true)
}

fn (mut this Class_WP_Customize_Date_Time_Control) render_content()  {
}

fn (mut this Class_WP_Customize_Date_Time_Control) json() rt.PhpVal {
	mut var_data := this.Class_WP_Customize_Control.json()
	var_data.array_set('maxYear', // unsupported expression: Expr_Cast_Int)
	var_data.array_set('minYear', // unsupported expression: Expr_Cast_Int)
	var_data.array_set('allowPastDate', // unsupported expression: Expr_Cast_Bool)
	var_data.array_set('twelveHourFormat', // unsupported expression: Expr_Cast_Bool)
	var_data.array_set('includeTime', // unsupported expression: Expr_Cast_Bool)
	return var_data.dup()
}

fn (mut this Class_WP_Customize_Date_Time_Control) content_template()  {
	mut var_data := rt.call_function('array_merge', [this.json(), this.get_month_choices()])
	mut var_timezone_info := this.get_timezone_info()
	mut var_date_format := rt.call_function('get_option', [rt.new_string('date_format')])
	var_date_format = rt.call_function('preg_replace', [rt.new_string('/(?<!\\\\)[Yyo]/'), rt.new_string('%1$s'), var_date_format.dup()])
	var_date_format = rt.call_function('preg_replace', [rt.new_string('/(?<!\\\\)[FmMn]/'), rt.new_string('%2$s'), var_date_format.dup()])
	var_date_format = rt.call_function('preg_replace', [rt.new_string('/(?<!\\\\)[jd]/'), rt.new_string('%3$s'), var_date_format.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_date_format = rt.new_string(rt.new_string('%1$s-%2$s-%3$s'))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [var_data.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Date')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Month')])
	// unsupported statement: Stmt_InlineHTML
	mut var_month_field := rt.new_string(rt.new_string(rt.call_function('ob_get_clean', []rt.PhpVal{}).to_string().trim_space()))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Day')])
	// unsupported statement: Stmt_InlineHTML
	mut var_day_field := rt.new_string(rt.new_string(rt.call_function('ob_get_clean', []rt.PhpVal{}).to_string().trim_space()))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Year')])
	// unsupported statement: Stmt_InlineHTML
	mut var_year_field := rt.new_string(rt.new_string(rt.call_function('ob_get_clean', []rt.PhpVal{}).to_string().trim_space()))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [var_date_format.dup(), var_year_field.dup(), var_month_field.dup(), var_day_field.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Time')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Hour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Minute')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Meridian')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('AM')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('PM')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_timezone_info.array_get('description'))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Date_Time_Control) get_month_choices() rt.PhpVal {
	mut var_wp_locale := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_months := rt.new_array()
	{
		mut var_i := rt.new_int(rt.new_int(1))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(13)))) { break }
			mut var_month_text := rt.call_method(var_wp_locale, 'get_month_abbrev', [rt.call_method(var_wp_locale, 'get_month', [var_i.dup()])])
			var_months.array_get_mut(var_i).array_set('text', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s-%2$s')]), var_i.dup(), var_month_text.dup()]))
			var_months.array_get_mut(var_i).array_set('value', var_i.dup())
			rt.post_inc(var_i)
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'month_choices', val: var_months }])
}

fn (mut this Class_WP_Customize_Date_Time_Control) get_timezone_info() rt.PhpVal {
	mut var_tz_string := rt.call_function('get_option', [rt.new_string('timezone_string')])
	mut var_timezone_info := rt.new_array()
	if rt.is_true(var_tz_string) {
		mut var_tz := create_datetimezone(var_tz_string.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.dup()
			var_tz = rt.new_string(rt.new_string(''))
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		if rt.is_true(var_tz) {
			mut var_now := create_datetime(rt.new_string('now'), var_tz.dup())
			mut var_formatted_gmt_offset := this.format_gmt_offset(rt.div(rt.call_method(var_tz, 'getOffset', [var_now]), rt.get_constant('HOUR_IN_SECONDS')))
			mut var_tz_name := rt.call_function('str_replace', [rt.new_string('_'), rt.new_string(' '), rt.call_method(var_tz, 'getName', []rt.PhpVal{})])
			var_timezone_info.array_set('abbr', var_now.format(rt.new_string('T')))
			var_timezone_info.array_set('description', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your timezone is set to %1$s (%2$s), currently %3$s (Coordinated Universal Time %4$s).')]), var_tz_name.dup(), '<abbr>' + (var_timezone_info.array_get('abbr')).str() + '</abbr>', '<abbr>UTC</abbr>' + (var_formatted_gmt_offset).str(), var_formatted_gmt_offset.dup()]))
		} else {
			var_timezone_info.array_set('description', '')
		}
	} else {
		var_formatted_gmt_offset = this.format_gmt_offset(// unsupported expression: Expr_Cast_Int)
		var_timezone_info.array_set('description', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your timezone is set to %1$s (Coordinated Universal Time %2$s).')]), '<abbr>UTC</abbr>' + (var_formatted_gmt_offset).str(), var_formatted_gmt_offset.dup()]))
	}
	return var_timezone_info.dup()
}

fn (mut this Class_WP_Customize_Date_Time_Control) format_gmt_offset(var_offset rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.less_equal(rt.new_int(0), var_offset)) {
		mut var_formatted_offset := rt.new_string('+' + (// unsupported expression: Expr_Cast_String).str())
	} else {
		var_formatted_offset = // unsupported expression: Expr_Cast_String
	}
	var_formatted_offset = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '.25' }, rt.ArrayItem{ key: none, val: '.5' }, rt.ArrayItem{ key: none, val: '.75' }]), rt.create_array([rt.ArrayItem{ key: none, val: ':15' }, rt.ArrayItem{ key: none, val: ':30' }, rt.ArrayItem{ key: none, val: ':45' }]), var_formatted_offset.dup()])
	return var_formatted_offset.dup()
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_wp_customize_date_time_control() &Class_WP_Customize_Date_Time_Control {
	mut obj := &Class_WP_Customize_Date_Time_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type: rt.new_string('date_time')
		min_year: rt.new_int(1000)
		max_year: rt.new_int(9999)
		allow_past_date: rt.new_bool(true)
		include_time: rt.new_bool(true)
		twelve_hour_format: rt.new_bool(true)
	}
	return obj
}

fn create_wp_customize_control() &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone() &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime() &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Date_Time_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			this.render_content()
			return rt.new_null()
		}
		'json' {
			return this.json()
		}
		'content_template' {
			this.content_template()
			return rt.new_null()
		}
		'get_month_choices' {
			return this.get_month_choices()
		}
		'get_timezone_info' {
			return this.get_timezone_info()
		}
		'format_gmt_offset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_gmt_offset(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Customize_Date_Time_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'min_year' { return this.min_year }
		'max_year' { return this.max_year }
		'allow_past_date' { return this.allow_past_date }
		'include_time' { return this.include_time }
		'twelve_hour_format' { return this.twelve_hour_format }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Date_Time_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' { this.prop_type = val; return true }
		'min_year' { this.min_year = val; return true }
		'max_year' { this.max_year = val; return true }
		'allow_past_date' { this.allow_past_date = val; return true }
		'include_time' { this.include_time = val; return true }
		'twelve_hour_format' { this.twelve_hour_format = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Customize_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_customize_class_wp_customize_date_time_control_php() {
}

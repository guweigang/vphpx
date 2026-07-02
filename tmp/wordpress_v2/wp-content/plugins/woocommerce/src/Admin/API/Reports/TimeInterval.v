import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_api_reports_timeinterval() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_API_Reports_TimeInterval',
		'iso_datetime_format', rt.new_string('Y-m-d\\TH:i:s'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_API_Reports_TimeInterval',
		'sql_datetime_format', rt.new_string('Y-m-d H:i:s'))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.convert_local_datetime_to_gmt(var_datetime_string rt.PhpVal) rt.PhpVal {
	mut var_datetime := create_automattic_woocommerce_admin_api_reports_datetime(var_datetime_string.clone(), create_automattic_woocommerce_admin_api_reports_datetimezone(rt.call_function('wc_timezone_string',
		[]rt.PhpVal{})))
	rt.call_method(var_datetime, 'setTimezone', [
		create_automattic_woocommerce_admin_api_reports_datetimezone(rt.new_string('GMT')),
	])
	return var_datetime.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.default_before() rt.PhpVal {
	mut var_datetime := create_automattic_woocommerce_admin_api_reports_wc_datetime()
	if rt.is_true(rt.call_function('get_option', [rt.new_string('timezone_string')])) {
		rt.call_method(var_datetime, 'setTimezone', [
			create_automattic_woocommerce_admin_api_reports_datetimezone(rt.call_function('wc_timezone_string',
				[]rt.PhpVal{})),
		])
	} else {
		rt.call_method(var_datetime, 'set_utc_offset', [
			rt.call_function('wc_timezone_offset', []rt.PhpVal{}),
		])
	}
	return var_datetime.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.default_after() rt.PhpVal {
	mut var_now := rt.call_function('time', []rt.PhpVal{})
	mut var_week_back := rt.sub(var_now, rt.get_constant('WEEK_IN_SECONDS'))
	mut var_datetime := create_automattic_woocommerce_admin_api_reports_wc_datetime()
	rt.call_method(var_datetime, 'setTimestamp', [var_week_back.clone()])
	if rt.is_true(rt.call_function('get_option', [rt.new_string('timezone_string')])) {
		rt.call_method(var_datetime, 'setTimezone', [
			create_automattic_woocommerce_admin_api_reports_datetimezone(rt.call_function('wc_timezone_string',
				[]rt.PhpVal{})),
		])
	} else {
		rt.call_method(var_datetime, 'set_utc_offset', [
			rt.call_function('wc_timezone_offset', []rt.PhpVal{}),
		])
	}
	return var_datetime.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.db_datetime_format(var_time_interval rt.PhpVal, var_table_name rt.PhpVal, date_column_name string) rt.PhpVal {
	mut var_first_day_of_week := rt.call_function('absint', [
		rt.call_function('get_option', [rt.new_string('start_of_week')]),
	])
	if rt.is_true(rt.identical(rt.new_int(1), var_first_day_of_week)) {
		mut var_week_format :=
			rt.new_string("DATE_FORMAT(${var_table_name.to_string()}.`${var_date_column_name}`, '%x-%v')")
	} else {
		var_week_format =
			rt.new_string("CONCAT(YEAR(${var_table_name.to_string()}.`${var_date_column_name}`), '-', LPAD( FLOOR( ( DAYOFYEAR(${var_table_name.to_string()}.`${var_date_column_name}`) + ( ( DATE_FORMAT(MAKEDATE(YEAR(${var_table_name.to_string()}.`${var_date_column_name}`),1), '%w') - ${var_first_day_of_week.to_string()} + 7 ) % 7 ) - 1 ) / 7  ) + 1 , 2, '0'))")
	}
	mut var_mysql_date_format_mapping := rt.create_array([
		rt.ArrayItem{
			key: 'hour'
			val: "DATE_FORMAT(${var_table_name.to_string()}.`${var_date_column_name}`, '%Y-%m-%d %H')"
		},
		rt.ArrayItem{
			key: 'day'
			val: "DATE_FORMAT(${var_table_name.to_string()}.`${var_date_column_name}`, '%Y-%m-%d')"
		},
		rt.ArrayItem{ key: 'week', val: var_week_format },
		rt.ArrayItem{
			key: 'month'
			val: "DATE_FORMAT(${var_table_name.to_string()}.`${var_date_column_name}`, '%Y-%m')"
		},
		rt.ArrayItem{
			key: 'quarter'
			val: "CONCAT(YEAR(${var_table_name.to_string()}.`${var_date_column_name}`), '-', QUARTER(${var_table_name.to_string()}.`${var_date_column_name}`))"
		},
		rt.ArrayItem{
			key: 'year'
			val: 'YEAR(${var_table_name.to_string()}.`${var_date_column_name}`)'
		},
	])
	return var_mysql_date_format_mapping.array_get(var_time_interval)
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.quarter(var_datetime rt.PhpVal) rt.PhpVal {
	mut var_datetime_mutated := var_datetime
	match rt.new_int((rt.call_method(var_datetime_mutated, 'format', [
		rt.new_string('m')])).to_i64()) {
		1, 2, 3 {
			return rt.new_int(1)
		}
		4, 5, 6 {
			return rt.new_int(2)
		}
		7, 8, 9 {
			return rt.new_int(3)
		}
		10, 11, 12 {
			return rt.new_int(4)
		}
	}

	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.simple_week_number(var_datetime rt.PhpVal, var_first_day_of_week rt.PhpVal) i64 {
	mut var_datetime_mutated := var_datetime
	mut var_first_day_of_week_mutated := var_first_day_of_week
	mut var_beg_of_year_day := create_automattic_woocommerce_admin_api_reports_datetime(rt.concat(rt.call_method(var_datetime_mutated,
		'format', [rt.new_string('Y')]), rt.new_string('-01-01')))
	mut var_adj_day_beg_of_year := rt.mod_(rt.add(rt.sub(rt.new_int((var_beg_of_year_day.format(rt.new_string('w'))).to_i64()),
		var_first_day_of_week_mutated), rt.new_int(7)), rt.new_int(7))
	mut var_days_since_start_of_year :=
		rt.new_int((rt.call_method(var_datetime_mutated, 'format', [rt.new_string('z')])).to_i64()) +
		1
	return
		rt.new_int((rt.call_function('floor', [rt.div(rt.sub(rt.add(var_days_since_start_of_year, var_adj_day_beg_of_year), rt.new_int(1)), rt.new_int(7))])).to_i64()) +
		1
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.week_number(var_datetime rt.PhpVal, var_first_day_of_week rt.PhpVal) rt.PhpVal {
	mut var_datetime_mutated := var_datetime
	mut var_first_day_of_week_mutated := var_first_day_of_week
	if rt.is_true(rt.identical(rt.new_int(1), var_first_day_of_week_mutated)) {
		mut var_week_number := rt.new_int((rt.call_method(var_datetime_mutated, 'format', [
			rt.new_string('W'),
		])).to_i64())
	} else {
		var_week_number = Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.simple_week_number(var_datetime_mutated.clone(),
			var_first_day_of_week_mutated.clone())
	}
	return var_week_number.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.time_interval_id(var_time_interval rt.PhpVal, var_datetime rt.PhpVal) string {
	mut var_datetime_mutated := var_datetime
	mut var_php_time_format_for := rt.create_array([
		rt.ArrayItem{ key: 'hour', val: 'Y-m-d H' },
		rt.ArrayItem{ key: 'day', val: 'Y-m-d' },
		rt.ArrayItem{ key: 'week', val: 'o-W' },
		rt.ArrayItem{ key: 'month', val: 'Y-m' },
		rt.ArrayItem{
			key: 'quarter'
			val: 'Y-' +(Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.quarter(var_datetime_mutated.clone())).str()
		},
		rt.ArrayItem{ key: 'year', val: 'Y' },
	])
	mut var_first_day_of_week := rt.call_function('absint', [
		rt.call_function('get_option', [rt.new_string('start_of_week')]),
	])
	if rt.is_true(rt.identical(rt.new_string('week'), var_time_interval))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), var_first_day_of_week)))) {
		mut var_week_no := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.simple_week_number(var_datetime_mutated.clone(),
			var_first_day_of_week.clone())
		var_week_no = rt.call_function('str_pad', [var_week_no.clone(),
			rt.new_int(2), rt.new_string('0'), rt.get_constant('STR_PAD_LEFT')])
		mut var_year_no := rt.call_method(var_datetime_mutated, 'format', [
			rt.new_string('Y'),
		])
		return '${var_year_no.to_string()}-${var_week_no.to_string()}'
	}
	return (rt.call_method(var_datetime_mutated, 'format', [
		var_php_time_format_for.array_get(var_time_interval),
	])).str()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.intervals_between(var_start_datetime rt.PhpVal, var_end_datetime rt.PhpVal, var_interval rt.PhpVal) i64 {
	mut var_start_datetime_mutated := var_start_datetime
	mut switch_val_2 := var_interval
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('hour'))) {
		mut var_end_timestamp := rt.new_int((rt.call_method(var_end_datetime, 'format', [
			rt.new_string('U'),
		])).to_i64())
		mut var_start_timestamp := rt.new_int((rt.call_method(var_start_datetime_mutated, 'format', [
			rt.new_string('U'),
		])).to_i64())
		mut var_addendum := rt.new_int(0)
		mut var_start_min_sec := rt.add(rt.mul(rt.new_int((rt.call_method(var_start_datetime_mutated,
			'format', [rt.new_string('i')])).to_i64()), rt.get_constant('MINUTE_IN_SECONDS')), rt.new_int((rt.call_method(var_start_datetime_mutated,
			'format', [rt.new_string('s')])).to_i64()))
		mut var_end_min_sec := rt.add(rt.mul(rt.new_int((rt.call_method(var_end_datetime, 'format', [
			rt.new_string('i'),
		])).to_i64()), rt.get_constant('MINUTE_IN_SECONDS')), rt.new_int((rt.call_method(var_end_datetime,
			'format', [rt.new_string('s')])).to_i64()))
		if rt.is_true(rt.less(var_end_min_sec, var_start_min_sec)) {
			var_addendum = rt.new_int(1)
		}
		mut var_diff_timestamp := rt.sub(var_end_timestamp, var_start_timestamp)
		return (rt.add(
			rt.new_int((rt.call_function('floor', [rt.div(rt.new_int(var_diff_timestamp.to_i64()), rt.get_constant('HOUR_IN_SECONDS'))])).to_i64()) +
			1, var_addendum)).to_i64()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('day'))) {
		mut var_days := rt.call_method(rt.call_method(var_start_datetime_mutated, 'diff', [
			var_end_datetime.clone(),
		]), 'format', [rt.new_string('%r%a')])
		mut var_end_hour_min_sec := rt.add(rt.add(rt.mul(rt.new_int((rt.call_method(var_end_datetime,
			'format', [rt.new_string('H')])).to_i64()), rt.get_constant('HOUR_IN_SECONDS')), rt.mul(rt.new_int((rt.call_method(var_end_datetime,
			'format', [rt.new_string('i')])).to_i64()), rt.get_constant('MINUTE_IN_SECONDS'))), rt.new_int((rt.call_method(var_end_datetime,
			'format', [rt.new_string('s')])).to_i64()))
		mut var_start_hour_min_sec := rt.add(rt.add(rt.mul(rt.new_int((rt.call_method(var_start_datetime_mutated,
			'format', [rt.new_string('H')])).to_i64()), rt.get_constant('HOUR_IN_SECONDS')), rt.mul(rt.new_int((rt.call_method(var_start_datetime_mutated,
			'format', [rt.new_string('i')])).to_i64()), rt.get_constant('MINUTE_IN_SECONDS'))), rt.new_int((rt.call_method(var_start_datetime_mutated,
			'format', [rt.new_string('s')])).to_i64()))
		if rt.is_true(rt.less(var_end_hour_min_sec, var_start_hour_min_sec)) {
			rt.post_inc(var_days)
		}
		return (rt.add(var_days, rt.new_int(1))).to_i64()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('week'))) {
		mut var_week_count := rt.new_int(0)
		for {
			var_start_datetime_mutated =
				Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_week_start(var_start_datetime_mutated.to_bool())
			rt.post_inc(var_week_count)
			if !(rt.is_true(rt.less_equal(var_start_datetime_mutated, var_end_datetime))) {
				break
			}
		}
		return var_week_count.to_i64()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('month'))) {
		mut var_year_diff_in_months :=
			rt.new_int((rt.call_method(var_end_datetime, 'format', [rt.new_string('Y')])).to_i64()) -
			rt.new_int((rt.call_method(var_start_datetime_mutated, 'format', [rt.new_string('Y')])).to_i64()) -
			1 * 12
		mut var_month_diff :=
			rt.new_int((rt.call_method(var_end_datetime, 'format', [rt.new_string('n')])).to_i64()) +
			12 -
			rt.new_int((rt.call_method(var_start_datetime_mutated, 'format', [rt.new_string('n')])).to_i64())
		var_month_diff = rt.add(var_month_diff, rt.add(var_year_diff_in_months, rt.new_int(1)))
		return var_month_diff.to_i64()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('quarter'))) {
		mut var_year_diff_in_quarters :=
			rt.new_int((rt.call_method(var_end_datetime, 'format', [rt.new_string('Y')])).to_i64()) -
			rt.new_int((rt.call_method(var_start_datetime_mutated, 'format', [rt.new_string('Y')])).to_i64()) -
			1 * 4
		mut var_quarter_diff := rt.add(Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.quarter(var_end_datetime.clone()), rt.sub(rt.new_int(4),
			Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.quarter(var_start_datetime_mutated.clone())))
		var_quarter_diff = rt.add(var_quarter_diff,
			rt.add(var_year_diff_in_quarters, rt.new_int(1)))
		return var_quarter_diff.to_i64()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('year'))) {
		mut var_year_diff := rt.new_int((rt.call_method(var_end_datetime, 'format', [
			rt.new_string('Y'),
		])).to_i64()) - rt.new_int((rt.call_method(var_start_datetime_mutated, 'format', [
			rt.new_string('Y'),
		])).to_i64())
		return (rt.add(var_year_diff, rt.new_int(1))).to_i64()
	}
	return 0
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_hour_start(var_datetime rt.PhpVal, reversed bool) rt.PhpVal {
	mut var_datetime_mutated := var_datetime
	mut var_hour_increment := rt.new_int(if var_reversed { 0 } else { 1 })
	mut var_timestamp := rt.new_int((rt.call_method(var_datetime_mutated, 'format', [
		rt.new_string('U'),
	])).to_i64())
	mut var_seconds_into_hour := rt.add(rt.mul(rt.new_int((rt.call_method(var_datetime_mutated,
		'format', [rt.new_string('i')])).to_i64()), rt.get_constant('MINUTE_IN_SECONDS')), rt.new_int((rt.call_method(var_datetime_mutated,
		'format', [rt.new_string('s')])).to_i64()))
	mut var_hours_offset_timestamp := rt.add(var_timestamp, rt.sub(rt.mul(var_hour_increment,
		rt.get_constant('HOUR_IN_SECONDS')), var_seconds_into_hour))
	if var_reversed {
		rt.post_dec(var_hours_offset_timestamp)
	}
	mut var_hours_offset_time := create_automattic_woocommerce_admin_api_reports_datetime()
	var_hours_offset_time.settimestamp(var_hours_offset_timestamp.clone())
	var_hours_offset_time.settimezone(create_automattic_woocommerce_admin_api_reports_datetimezone(rt.call_function('wc_timezone_string',
		[]rt.PhpVal{})))
	return mut var_hours_offset_time
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_day_start(var_datetime rt.PhpVal, reversed bool) rt.PhpVal {
	mut var_datetime_mutated := var_datetime
	mut var_oneday :=
		create_automattic_woocommerce_admin_api_reports_dateinterval(rt.new_string('P1D'))
	mut var_new_datetime := var_datetime_mutated.dup()
	if var_reversed {
		rt.call_method(var_new_datetime, 'sub', [var_oneday])
		rt.call_method(var_new_datetime, 'setTime', [rt.new_int(23),
			rt.new_int(59), rt.new_int(59)])
	} else {
		rt.call_method(var_new_datetime, 'add', [var_oneday])
		rt.call_method(var_new_datetime, 'setTime', [rt.new_int(0),
			rt.new_int(0), rt.new_int(0)])
	}
	return var_new_datetime.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_week_start(var_datetime rt.PhpVal, reversed bool) rt.PhpVal {
	mut var_datetime_mutated := var_datetime
	mut var_seven_days :=
		create_automattic_woocommerce_admin_api_reports_dateinterval(rt.new_string('P7D'))
	mut var_default_timezone := rt.call_function('date_default_timezone_get', []rt.PhpVal{})
	mut var_original_timezone := rt.call_method(var_datetime_mutated, 'getTimezone', []rt.PhpVal{})
	rt.call_function('date_default_timezone_set', [rt.new_string('UTC')])
	mut var_start_end_timestamp := rt.call_function('get_weekstartend', [
		rt.call_method(var_datetime_mutated, 'format', [rt.new_string('Y-m-d')]),
	])
	rt.call_function('date_default_timezone_set', [var_default_timezone.clone()])
	if var_reversed {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_DateTime{}
		mut iife_result_0 := iife_temp_0.createfromformat(rt.new_string('U'),
			var_start_end_timestamp.array_get(rt.new_string('end')))
		mut var_result := rt.call_method(iife_result_0, 'sub', [var_seven_days])
	} else {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_DateTime{}
		mut iife_result_1 := iife_temp_1.createfromformat(rt.new_string('U'),
			var_start_end_timestamp.array_get(rt.new_string('start')))
		var_result = rt.call_method(iife_result_1, 'add', [var_seven_days])
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_DateTime{}
	mut iife_result_2 := iife_temp_2.createfromformat(rt.new_string('Y-m-d H:i:s'), rt.call_method(var_result,
		'format', [rt.new_string('Y-m-d H:i:s')]), var_original_timezone.clone())
	return iife_result_2
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_month_start(var_datetime rt.PhpVal, reversed bool) rt.PhpVal {
	mut var_datetime_mutated := var_datetime
	mut var_month_increment := rt.new_int(1)
	mut var_year := rt.call_method(var_datetime_mutated, 'format', [
		rt.new_string('Y')])
	mut var_month := rt.new_int((rt.call_method(var_datetime_mutated, 'format', [
		rt.new_string('m'),
	])).to_i64())
	if var_reversed {
		mut var_beg_of_month_datetime := create_automattic_woocommerce_admin_api_reports_datetime(rt.new_string('${var_year.to_string()}-${var_month.to_string()}-01 00:00:00'), create_automattic_woocommerce_admin_api_reports_datetimezone(rt.call_function('wc_timezone_string',
			[]rt.PhpVal{})))
		mut var_timestamp :=
			rt.new_int((var_beg_of_month_datetime.format(rt.new_string('U'))).to_i64())
		mut var_end_of_prev_month_timestamp := rt.sub(var_timestamp, rt.new_int(1))
		rt.call_method(var_datetime_mutated, 'setTimestamp', [
			var_end_of_prev_month_timestamp.clone()])
	} else {
		var_month = rt.add(var_month, var_month_increment)
		if rt.is_true(rt.greater(var_month, rt.new_int(12))) {
			var_month = rt.new_int(1)
			rt.post_inc(var_year)
		}
		mut var_day := rt.new_string('01')
		var_datetime_mutated = create_automattic_woocommerce_admin_api_reports_datetime(rt.new_string('${var_year.to_string()}-${var_month.to_string()}-${var_day.to_string()} 00:00:00'), create_automattic_woocommerce_admin_api_reports_datetimezone(rt.call_function('wc_timezone_string',
			[]rt.PhpVal{})))
	}
	return var_datetime_mutated.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_quarter_start(var_datetime rt.PhpVal, reversed bool) rt.PhpVal {
	mut var_datetime_mutated := var_datetime
	mut var_year := rt.call_method(var_datetime_mutated, 'format', [
		rt.new_string('Y')])
	mut var_month := rt.new_int((rt.call_method(var_datetime_mutated, 'format', [
		rt.new_string('n'),
	])).to_i64())
	mut switch_val_3 := var_month
	if rt.is_true(rt.equal(switch_val_3, rt.new_int(1)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(2)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(3))) {
		if var_reversed {
			var_month = rt.new_int(1)
		} else {
			var_month = rt.new_int(4)
		}
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(4)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(5)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(6))) {
		if var_reversed {
			var_month = rt.new_int(4)
		} else {
			var_month = rt.new_int(7)
		}
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(7)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(8)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(9))) {
		if var_reversed {
			var_month = rt.new_int(7)
		} else {
			var_month = rt.new_int(10)
		}
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(10)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(11)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(12))) {
		if var_reversed {
			var_month = rt.new_int(10)
		} else {
			var_month = rt.new_int(1)
			rt.post_inc(var_year)
		}
	}
	var_datetime_mutated = create_automattic_woocommerce_admin_api_reports_datetime(rt.new_string('${var_year.to_string()}-${var_month.to_string()}-01 00:00:00'), create_automattic_woocommerce_admin_api_reports_datetimezone(rt.call_function('wc_timezone_string',
		[]rt.PhpVal{})))
	if var_reversed {
		mut var_timestamp := rt.new_int((rt.call_method(var_datetime_mutated, 'format', [
			rt.new_string('U'),
		])).to_i64())
		mut var_end_of_prev_month_timestamp := rt.sub(var_timestamp, rt.new_int(1))
		rt.call_method(var_datetime_mutated, 'setTimestamp', [
			var_end_of_prev_month_timestamp.clone()])
	}
	return var_datetime_mutated.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_year_start(var_datetime rt.PhpVal, reversed bool) rt.PhpVal {
	mut var_datetime_mutated := var_datetime
	mut var_year_increment := rt.new_int(1)
	mut var_year := rt.new_int((rt.call_method(var_datetime_mutated, 'format', [
		rt.new_string('Y'),
	])).to_i64())
	mut var_month := rt.new_string('01')
	mut var_day := rt.new_string('01')
	if var_reversed {
		var_datetime_mutated = create_automattic_woocommerce_admin_api_reports_datetime(rt.new_string('${var_year.to_string()}-${var_month.to_string()}-${var_day.to_string()} 00:00:00'), create_automattic_woocommerce_admin_api_reports_datetimezone(rt.call_function('wc_timezone_string',
			[]rt.PhpVal{})))
		mut var_timestamp := rt.new_int((rt.call_method(var_datetime_mutated, 'format', [
			rt.new_string('U'),
		])).to_i64())
		mut var_end_of_prev_year_timestamp := rt.sub(var_timestamp, rt.new_int(1))
		rt.call_method(var_datetime_mutated, 'setTimestamp', [
			var_end_of_prev_year_timestamp.clone()])
	} else {
		var_year = rt.add(var_year, var_year_increment)
		var_datetime_mutated = create_automattic_woocommerce_admin_api_reports_datetime(rt.new_string('${var_year.to_string()}-${var_month.to_string()}-${var_day.to_string()} 00:00:00'), create_automattic_woocommerce_admin_api_reports_datetimezone(rt.call_function('wc_timezone_string',
			[]rt.PhpVal{})))
	}
	return var_datetime_mutated.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.iterate(var_datetime rt.PhpVal, var_time_interval rt.PhpVal, reversed bool) rt.PhpVal {
	mut var_datetime_mutated := var_datetime
	return rt.call_function('call_user_func', [
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'next_${var_time_interval.to_string()}_start' }]),
		var_datetime_mutated.clone(),
		rt.new_bool(reversed),
	])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.expected_intervals_on_page(var_expected_interval_count rt.PhpVal, var_items_per_page rt.PhpVal, var_page_no rt.PhpVal) i64 {
	mut var_total_pages := rt.new_int((rt.call_function('ceil', [
		rt.div(var_expected_interval_count, var_items_per_page),
	])).to_i64())
	if rt.is_true(rt.less(var_page_no, var_total_pages)) {
		return var_items_per_page.to_i64()
	} else if rt.is_true(rt.identical(var_page_no, var_total_pages)) {
		return (rt.sub(var_expected_interval_count, rt.mul(rt.sub(var_page_no, rt.new_int(1)),
			var_items_per_page))).to_i64()
	} else {
		return 0
	}
	return i64(0)
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.intervals_missing(var_expected_interval_count rt.PhpVal, var_db_records rt.PhpVal, var_items_per_page rt.PhpVal, var_page_no rt.PhpVal, var_order rt.PhpVal, var_order_by rt.PhpVal, var_intervals_count rt.PhpVal) bool {
	if rt.is_true(rt.less_equal(var_expected_interval_count, var_db_records)) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('date'), var_order_by)) {
		mut var_expected_intervals_on_page := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.expected_intervals_on_page(var_expected_interval_count.clone(),
			var_items_per_page.clone(), var_page_no.clone())
		return (rt.less(var_intervals_count, var_expected_intervals_on_page)).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('desc'), var_order)) {
		return (rt.greater(var_page_no, rt.call_function('floor', [
			rt.div(var_db_records, var_items_per_page),
		]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('asc'), var_order)) {
		return (rt.less_equal(var_page_no, rt.call_function('ceil', [
			rt.div(rt.sub(var_expected_interval_count, var_db_records), var_items_per_page),
		]))).to_bool()
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.normalize_between_params(var_request rt.PhpVal, var_param_names rt.PhpVal, var_is_date rt.PhpVal) rt.PhpVal {
	mut var_param_names_mutated := var_param_names
	if !(var_param_names_mutated.clone().is_array()) {
		var_param_names_mutated = rt.create_array([
			rt.ArrayItem{ key: none, val: var_param_names_mutated },
		])
	}
	mut var_normalized := rt.new_array()
	mut iter_1 := var_param_names_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_param_name := item_1.val
		if !(var_request.array_get(rt.new_string(var_param_name.str() + '_between')).is_array()) {
			continue
		}
		mut var_range := var_request.array_get(rt.new_string(var_param_name.str() + '_between'))
		if rt.is_true(rt.new_bool(2 != var_range.clone().array_count())) {
			continue
		}
		mut var_min :=
			rt.new_string((if rt.is_true(var_is_date) { '_after' } else { '_min' }).str())
		mut var_max :=
			rt.new_string((if rt.is_true(var_is_date) { '_before' } else { '_max' }).str())
		if rt.is_true(rt.less(var_range.array_get(rt.new_int(0)),
			var_range.array_get(rt.new_int(1))))
		{
			var_normalized.array_set(var_param_name.str() + var_min.str(),
				var_range.array_get(rt.new_int(0)))
			var_normalized.array_set(var_param_name.str() + var_max.str(),
				var_range.array_get(rt.new_int(1)))
		} else {
			var_normalized.array_set(var_param_name.str() + var_min.str(),
				var_range.array_get(rt.new_int(1)))
			var_normalized.array_set(var_param_name.str() + var_max.str(),
				var_range.array_get(rt.new_int(0)))
		}
	}
	return var_normalized.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.rest_validate_between_numeric_arg(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_numeric_array', [
		var_value.clone(),
	])))))
	{
		return (create_automattic_woocommerce_admin_api_reports_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('%1$s is not a numerically indexed array.'),
				rt.new_string('woocommerce'),
			]),
			var_param.clone(),
		]))).to_bool()
	}
	if !(var_value.clone().is_array())
		|| rt.is_true(rt.new_bool(2 != var_value.clone().array_count()))
		|| !(var_value.array_get(rt.new_int(0)).is_long()
		|| var_value.array_get(rt.new_int(0)).is_double())
		|| !(var_value.array_get(rt.new_int(1)).is_long()
		|| var_value.array_get(rt.new_int(1)).is_double()) {
		return (create_automattic_woocommerce_admin_api_reports_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s must contain 2 numbers.'),
				rt.new_string('woocommerce')]),
			var_param.clone(),
		]))).to_bool()
	}
	return true
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.rest_validate_between_date_arg(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_numeric_array', [
		var_value.clone(),
	])))))
	{
		return (create_automattic_woocommerce_admin_api_reports_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('%1$s is not a numerically indexed array.'),
				rt.new_string('woocommerce'),
			]),
			var_param.clone(),
		]))).to_bool()
	}
	if !(var_value.clone().is_array())
		|| rt.is_true(rt.new_bool(2 != var_value.clone().array_count()))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('rest_parse_date', [var_value.array_get(rt.new_int(0))])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('rest_parse_date', [var_value.array_get(rt.new_int(1))]))))) {
		return (create_automattic_woocommerce_admin_api_reports_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s must contain 2 valid dates.'),
				rt.new_string('woocommerce')]),
			var_param.clone(),
		]))).to_bool()
	}
	return true
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.get_timeframe_dates(var_timeframe rt.PhpVal, var_current_date rt.PhpVal) rt.PhpVal {
	mut var_current_date_mutated := var_current_date
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_date_mutated)))) {
		var_current_date_mutated = create_automattic_woocommerce_admin_api_reports_datetime()
	}
	mut var_current_year := var_current_date_mutated.format(rt.new_string('Y'))
	mut var_current_month := var_current_date_mutated.format(rt.new_string('m'))
	if rt.is_true(rt.identical(rt.new_string('last_week'), var_timeframe)) {
		return rt.create_array([
			rt.ArrayItem{ key: 'start', val: rt.call_method(var_current_date_mutated.modify(rt.new_string('last week monday')),
				'format', [rt.new_string('Y-m-d 00:00:00')]) },
			rt.ArrayItem{ key: 'end', val: rt.call_method(var_current_date_mutated.modify(rt.new_string('this sunday')),
				'format', [rt.new_string('Y-m-d 23:59:59')]) },
		])
	}
	if rt.is_true(rt.identical(rt.new_string('last_month'), var_timeframe)) {
		return rt.create_array([
			rt.ArrayItem{ key: 'start', val: rt.call_method(var_current_date_mutated.modify(rt.new_string('first day of previous month')),
				'format', [rt.new_string('Y-m-d 00:00:00')]) },
			rt.ArrayItem{ key: 'end', val: rt.call_method(var_current_date_mutated.modify(rt.new_string('last day of this month')),
				'format', [rt.new_string('Y-m-d 23:59:59')]) },
		])
	}
	if rt.is_true(rt.identical(rt.new_string('last_quarter'), var_timeframe)) {
		mut switch_val_4 := var_current_month
		if rt.is_true(rt.equal(switch_val_4, rt.new_bool(
			rt.is_true(rt.greater_equal(var_current_month, rt.new_int(1)))
			&& rt.is_true(rt.less_equal(var_current_month, rt.new_int(3))))))
		{
			return rt.create_array([
				rt.ArrayItem{ key: 'start', val: (rt.sub(var_current_year, rt.new_int(1))).str() +
					'-10-01 00:00:00' },
				rt.ArrayItem{ key: 'end', val: (rt.sub(var_current_year, rt.new_int(1))).str() +
					'-12-31 23:59:59' },
			])
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(
			rt.is_true(rt.greater_equal(var_current_month, rt.new_int(4)))
			&& rt.is_true(rt.less_equal(var_current_month, rt.new_int(6))))))
		{
			return rt.create_array([
				rt.ArrayItem{ key: 'start', val: var_current_year.str() + '-01-01 00:00:00' },
				rt.ArrayItem{ key: 'end', val: var_current_year.str() + '-03-31 23:59:59' },
			])
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(
			rt.is_true(rt.greater_equal(var_current_month, rt.new_int(7)))
			&& rt.is_true(rt.less_equal(var_current_month, rt.new_int(9))))))
		{
			return rt.create_array([
				rt.ArrayItem{ key: 'start', val: var_current_year.str() + '-04-01 00:00:00' },
				rt.ArrayItem{ key: 'end', val: var_current_year.str() + '-06-30 23:59:59' },
			])
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(
			rt.is_true(rt.greater_equal(var_current_month, rt.new_int(10)))
			&& rt.is_true(rt.less_equal(var_current_month, rt.new_int(12))))))
		{
			return rt.create_array([
				rt.ArrayItem{ key: 'start', val: var_current_year.str() + '-07-01 00:00:00' },
				rt.ArrayItem{ key: 'end', val: var_current_year.str() + '-09-31 23:59:59' },
			])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('last_6_months'), var_timeframe)) {
		if rt.is_true(rt.greater_equal(var_current_month, rt.new_int(1)))
			&& rt.is_true(rt.less_equal(var_current_month, rt.new_int(6))) {
			return rt.create_array([
				rt.ArrayItem{ key: 'start', val: (rt.sub(var_current_year, rt.new_int(1))).str() +
					'-07-01 00:00:00' },
				rt.ArrayItem{ key: 'end', val: (rt.sub(var_current_year, rt.new_int(1))).str() +
					'-12-31 23:59:59' },
			])
		}
		return rt.create_array([
			rt.ArrayItem{ key: 'start', val: var_current_year.str() + '-01-01 00:00:00' },
			rt.ArrayItem{ key: 'end', val: var_current_year.str() + '-06-30 23:59:59' },
		])
	}
	if rt.is_true(rt.identical(rt.new_string('last_year'), var_timeframe)) {
		return rt.create_array([
			rt.ArrayItem{ key: 'start', val: (rt.sub(var_current_year, rt.new_int(1))).str() +
				'-01-01 00:00:00' },
			rt.ArrayItem{ key: 'end', val: (rt.sub(var_current_year, rt.new_int(1))).str() +
				'-12-31 23:59:59' },
		])
	}
	return rt.new_bool(false)
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WC_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DateInterval {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_timeinterval(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datetimezone(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_wc_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_WC_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WC_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_dateinterval(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_DateInterval {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DateInterval{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'convert_local_datetime_to_gmt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.convert_local_datetime_to_gmt(dispatch_arg_0)
		}
		'default_before' {
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.default_before()
		}
		'default_after' {
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.default_after()
		}
		'db_datetime_format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.db_datetime_format(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'quarter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.quarter(dispatch_arg_0)
		}
		'simple_week_number' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.simple_week_number(dispatch_arg_0,
				dispatch_arg_1))
		}
		'week_number' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.week_number(dispatch_arg_0,
				dispatch_arg_1)
		}
		'time_interval_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.time_interval_id(dispatch_arg_0,
				dispatch_arg_1))
		}
		'intervals_between' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_int(Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.intervals_between(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'next_hour_start' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_hour_start(dispatch_arg_0,
				dispatch_arg_1)
		}
		'next_day_start' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_day_start(dispatch_arg_0,
				dispatch_arg_1)
		}
		'next_week_start' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_week_start(dispatch_arg_0,
				dispatch_arg_1)
		}
		'next_month_start' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_month_start(dispatch_arg_0,
				dispatch_arg_1)
		}
		'next_quarter_start' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_quarter_start(dispatch_arg_0,
				dispatch_arg_1)
		}
		'next_year_start' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.next_year_start(dispatch_arg_0,
				dispatch_arg_1)
		}
		'iterate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.iterate(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'expected_intervals_on_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_int(Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.expected_intervals_on_page(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'intervals_missing' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.intervals_missing(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5,
				dispatch_arg_6))
		}
		'normalize_between_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.normalize_between_params(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'rest_validate_between_numeric_arg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.rest_validate_between_numeric_arg(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'rest_validate_between_date_arg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.rest_validate_between_date_arg(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'get_timeframe_dates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval.get_timeframe_dates(dispatch_arg_0,
				dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_WC_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DateInterval) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_DateInterval) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DateInterval) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

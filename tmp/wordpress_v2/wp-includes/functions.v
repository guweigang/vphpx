import rt
import crypto.md5

fn mysql2date(format string, var_date rt.PhpVal, translate bool) bool {
	mut var_format := format
	mut var_translate := translate
	mut var_timezone := rt.new_null()
	mut var_datetime := rt.new_null()
	if !rt.is_true(var_date) {
		return false
	}
	var_timezone = wp_timezone()
	var_datetime = rt.call_function('date_create', [var_date.clone(), var_timezone.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_datetime)) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('G'), rt.new_string(format))) || rt.is_true(rt.identical(rt.new_string('U'), rt.new_string(format))) {
		return (rt.add(rt.call_method(var_datetime, 'getTimestamp', []rt.PhpVal{}), rt.call_method(var_datetime, 'getOffset', []rt.PhpVal{}))).to_bool()
	}
	if var_translate {
		return wp_date(format, rt.call_method(var_datetime, 'getTimestamp', []rt.PhpVal{}), var_timezone.clone())
	}
	return (rt.call_method(var_datetime, 'format', [rt.new_string(format)])).to_bool()
}

fn current_time(type string, gmt bool) rt.PhpVal {
	mut var_type := type
	mut var_gmt := gmt
	mut var_timezone := rt.new_null()
	mut var_datetime := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('timestamp'), rt.new_string((var_type).str()))) || rt.is_true(rt.identical(rt.new_string('U'), rt.new_string((var_type).str()))) {
		return if var_gmt { rt.call_function('time', []rt.PhpVal{}) } else { rt.add(rt.call_function('time', []rt.PhpVal{}), i64(rt.new_float((rt.call_function('get_option', [rt.new_string('gmt_offset')])).to_f64()) * rt.get_constant('HOUR_IN_SECONDS'))) }
	}
	if rt.is_true(rt.identical(rt.new_string('mysql'), rt.new_string((var_type).str()))) {
	var_type = 'Y-m-d H:i:s'
	}
	var_timezone = if var_gmt { create_datetimezone(rt.new_string('UTC')) } else { wp_timezone() }
	var_datetime = create_datetime(rt.new_string('now'), var_timezone.clone())
	return rt.call_method(var_datetime, 'format', [rt.new_string((var_type).str())])
}

fn current_datetime() rt.PhpVal {
	return rt.new_object('DateTimeImmutable', []string{}, create_datetimeimmutable(rt.new_string('now'), wp_timezone()))
}

fn wp_timezone_string() rt.PhpVal {
	mut var_timezone_string := rt.new_null()
	mut var_offset := rt.new_null()
	mut var_hours := rt.new_null()
	mut var_minutes := rt.new_null()
	mut var_sign := ''
	mut var_abs_hour := rt.new_null()
	mut var_abs_mins := rt.new_null()
	mut var_tz_offset := rt.new_null()
	var_timezone_string = rt.call_function('get_option', [rt.new_string('timezone_string')])
	if rt.is_true(var_timezone_string) {
		return var_timezone_string.clone()
	}
	var_offset = rt.new_float((rt.call_function('get_option', [rt.new_string('gmt_offset')])).to_f64())
	var_hours = rt.new_int((var_offset).to_i64())
	var_minutes = rt.sub(var_offset, var_hours)
	var_sign = if rt.is_true(rt.less(var_offset, rt.new_int(0))) { '-' } else { '+' }
	var_abs_hour = rt.call_function('abs', [var_hours.clone()])
	var_abs_mins = rt.call_function('abs', [rt.mul(var_minutes, rt.new_int(60))])
	var_tz_offset = rt.call_function('sprintf', [rt.new_string('%s%02d:%02d'), rt.new_string((var_sign).str()).clone(), var_abs_hour.clone(), var_abs_mins.clone()])
	return var_tz_offset.clone()
}

fn wp_timezone() rt.PhpVal {
	return rt.new_object('DateTimeZone', []string{}, create_datetimezone(wp_timezone_string()))
}

fn date_i18n(var_format rt.PhpVal, timestamp_with_offset bool, gmt bool) rt.PhpVal {
	mut var_timestamp_with_offset := timestamp_with_offset
	mut var_gmt := gmt
	mut var_timestamp := rt.new_null()
	mut var_date := rt.new_null()
	mut var_local_time := rt.new_null()
	mut var_timezone := rt.new_null()
	mut var_datetime := rt.new_null()
	var_timestamp = rt.new_bool(timestamp_with_offset)
	if !(var_timestamp.clone().is_long() || var_timestamp.clone().is_double()) {
	var_timestamp = current_time('timestamp', gmt)
	}
	if rt.is_true(rt.identical(rt.new_string('U'), var_format)) {
	var_date = var_timestamp.clone()
	} else if var_gmt && rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(timestamp_with_offset))) {
	var_date = rt.new_bool(wp_date(var_format.clone(), rt.new_null(), create_datetimezone(rt.new_string('UTC'))))
	} else if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(timestamp_with_offset))) {
	var_date = rt.new_bool(wp_date(var_format.clone(), rt.new_null(), rt.new_null()))
	} else {
	var_local_time = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), var_timestamp.clone()])
	var_timezone = wp_timezone()
	var_datetime = rt.call_function('date_create', [var_local_time.clone(), var_timezone.clone()])
	var_date = rt.new_bool(wp_date(var_format.clone(), rt.call_method(var_datetime, 'getTimestamp', []rt.PhpVal{}), var_timezone.clone()))
	}
	var_date = rt.call_function('apply_filters', [rt.new_string('date_i18n'), var_date.clone(), var_format.clone(), var_timestamp.clone(), rt.new_bool(gmt)])
	return var_date.clone()
}

fn wp_date(var_format_arg rt.PhpVal, var_timestamp_arg rt.PhpVal, var_timezone_arg rt.PhpVal) bool {
	mut var_format := var_format_arg
	mut var_timestamp := var_timestamp_arg
	mut var_timezone := var_timezone_arg
	mut var_wp_locale := rt.new_null()
	mut var_datetime := rt.new_null()
	mut var_date := rt.new_null()
	mut var_new_format := ''
	mut var_format_length := i64(0)
	mut var_month := rt.new_null()
	mut var_weekday := rt.new_null()
	mut var_i := i64(0)
	if rt.is_true(rt.identical(rt.new_null(), var_timestamp)) {
	var_timestamp = rt.call_function('time', []rt.PhpVal{})
	} else if !(var_timestamp.clone().is_long() || var_timestamp.clone().is_double()) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_timezone)))) {
	var_timezone = wp_timezone()
	}
	var_datetime = rt.call_function('date_create', [rt.new_string('@' + (var_timestamp).str())])
	rt.call_method(var_datetime, 'setTimezone', [var_timezone.clone()])
	if !rt.is_true(rt.get_property(var_wp_locale, 'month')) || !rt.is_true(rt.get_property(var_wp_locale, 'weekday')) {
	var_date = rt.call_method(var_datetime, 'format', [var_format.clone()])
	} else {
		var_format = rt.call_function('preg_replace', [rt.new_string('/(?<!\\\\)r/'), rt.get_constant('DATE_RFC2822'), var_format.clone()])
		var_new_format = ''
		var_format_length = var_format.clone().to_string().len
		var_month = rt.call_method(var_wp_locale, 'get_month', [rt.call_method(var_datetime, 'format', [rt.new_string('m')])])
		var_weekday = rt.call_method(var_wp_locale, 'get_weekday', [rt.call_method(var_datetime, 'format', [rt.new_string('w')])])
		var_i = 0
		for {
			if !(var_i < var_format_length) { break }
			mut switch_val_1 := var_format.array_get(rt.new_int(var_i))
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('D'))) {
				var_new_format = var_new_format + (rt.call_function('addcslashes', [rt.call_method(var_wp_locale, 'get_weekday_abbrev', [var_weekday.clone()]), rt.new_string('\\A..Za..z')])).str()
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('F'))) {
				var_new_format = var_new_format + (rt.call_function('addcslashes', [var_month.clone(), rt.new_string('\\A..Za..z')])).str()
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('l'))) {
				var_new_format = var_new_format + (rt.call_function('addcslashes', [var_weekday.clone(), rt.new_string('\\A..Za..z')])).str()
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('M'))) {
				var_new_format = var_new_format + (rt.call_function('addcslashes', [rt.call_method(var_wp_locale, 'get_month_abbrev', [var_month.clone()]), rt.new_string('\\A..Za..z')])).str()
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('a'))) {
				var_new_format = var_new_format + (rt.call_function('addcslashes', [rt.call_method(var_wp_locale, 'get_meridiem', [rt.call_method(var_datetime, 'format', [rt.new_string('a')])]), rt.new_string('\\A..Za..z')])).str()
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('A'))) {
				var_new_format = var_new_format + (rt.call_function('addcslashes', [rt.call_method(var_wp_locale, 'get_meridiem', [rt.call_method(var_datetime, 'format', [rt.new_string('A')])]), rt.new_string('\\A..Za..z')])).str()
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('\\'))) {
				var_new_format = var_new_format + (var_format.array_get(rt.new_int(var_i))).str()
				if var_i < var_format_length {
					var_new_format = var_new_format + (var_format.array_get(rt.pre_inc(rt.new_int(var_i)))).str()
				}
			} else {
				var_new_format = var_new_format + (var_format.array_get(rt.new_int(var_i))).str()
			}
			var_i += 1
		}
	var_date = rt.call_method(var_datetime, 'format', [rt.new_string((var_new_format).str()).clone()])
	var_date = wp_maybe_decline_date(var_date.clone(), var_format.clone())
	}
	var_date = rt.call_function('apply_filters', [rt.new_string('wp_date'), var_date.clone(), var_format.clone(), var_timestamp.clone(), var_timezone.clone()])
	return (var_date).to_bool()
}

fn wp_maybe_decline_date(var_date_arg rt.PhpVal, format string) rt.PhpVal {
	mut var_format := format
	mut var_date := var_date_arg
	mut var_wp_locale := rt.new_null()
	mut var_months := rt.new_null()
	mut var_months_genitive := rt.new_null()
	mut var_decline := rt.new_null()
	mut var_month := rt.new_null()
	mut var_key := rt.new_null()
	mut var_locale := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('_x')]))))) {
		return var_date.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('on'), rt.call_function('_x', [rt.new_string('off'), rt.new_string('decline months names: on or off')]))) {
		var_months = rt.get_property(var_wp_locale, 'month')
		var_months_genitive = rt.get_property(var_wp_locale, 'month_genitive')
		if var_format.len > 0 && var_format != '0' {
		var_decline = rt.call_function('preg_match', [rt.new_string('#[dj]\\.? F#'), rt.new_string(format)])
		} else {
		var_decline = rt.call_function('preg_match', [rt.new_string('#\\b\\d{1,2}\\.? [^\\d ]+\\b#u'), var_date.clone()])
		}
		if rt.is_true(var_decline) {
			mut iter_1 := var_months.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_month_shadow := item_1.val
				mut var_key_shadow := item_1.key
				var_months.array_set(var_key_shadow, '# ' + (rt.call_function('preg_quote', [var_month_shadow.clone(), rt.new_string('#')])).str() + '\\b#u')
			}
			mut iter_2 := var_months_genitive.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_month_shadow := item_2.val
				mut var_key_shadow := item_2.key
				var_months_genitive.array_set(var_key_shadow, ' ' + (var_month_shadow).str())
			}
		var_date = rt.call_function('preg_replace', [var_months.clone(), var_months_genitive.clone(), var_date.clone()])
		}
		if var_format.len > 0 && var_format != '0' {
		var_decline = rt.call_function('preg_match', [rt.new_string('#F [dj]#'), rt.new_string(format)])
		} else {
		var_decline = rt.call_function('preg_match', [rt.new_string('#\\b[^\\d ]+ \\d{1,2}(st|nd|rd|th)?\\b#u'), rt.new_string(var_date.clone().to_string().trim_space())])
		}
		if rt.is_true(var_decline) {
			mut iter_3 := var_months.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_month_shadow := item_3.val
				mut var_key_shadow := item_3.key
				var_months.array_set(var_key_shadow, '#\\b' + (rt.call_function('preg_quote', [var_month_shadow.clone(), rt.new_string('#')])).str() + ' (\\d{1,2})(st|nd|rd|th)?([-–]\\d{1,2})?(st|nd|rd|th)?\\b#u')
			}
			mut iter_4 := var_months_genitive.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_month_shadow := item_4.val
				mut var_key_shadow := item_4.key
				var_months_genitive.array_set(var_key_shadow, '$1$3 ' + (var_month_shadow).str())
			}
		var_date = rt.call_function('preg_replace', [var_months.clone(), var_months_genitive.clone(), var_date.clone()])
		}
	}
	var_locale = rt.call_function('get_locale', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('ca'), var_locale)) {
	var_date = rt.call_function('preg_replace', [rt.new_string('# de ([ao])#i'), rt.new_string(' d\'\\1'), var_date.clone()])
	}
	return var_date.clone()
}

fn number_format_i18n(var_number rt.PhpVal, decimals i64) rt.PhpVal {
	mut var_decimals := decimals
	mut var_wp_locale := rt.new_null()
	mut var_formatted := rt.new_null()
	if !(var_wp_locale).is_null() {
	var_formatted = rt.call_function('number_format', [var_number.clone(), rt.call_function('absint', [rt.new_int(decimals)]), rt.get_property(var_wp_locale, 'number_format').array_get(rt.new_string('decimal_point')), rt.get_property(var_wp_locale, 'number_format').array_get(rt.new_string('thousands_sep'))])
	} else {
	var_formatted = rt.call_function('number_format', [var_number.clone(), rt.call_function('absint', [rt.new_int(decimals)])])
	}
	return rt.call_function('apply_filters', [rt.new_string('number_format_i18n'), var_formatted.clone(), var_number.clone(), rt.new_int(decimals)])
}

fn size_format(var_bytes rt.PhpVal, decimals i64) rt.PhpVal {
	mut var_decimals := decimals
	mut var_quant := rt.new_null()
	mut var_mag := rt.new_null()
	mut var_unit := rt.new_null()
	var_quant = rt.create_array([rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('YB'), rt.new_string('unit symbol')]), val: rt.get_constant('YB_IN_BYTES') }, rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('ZB'), rt.new_string('unit symbol')]), val: rt.get_constant('ZB_IN_BYTES') }, rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('EB'), rt.new_string('unit symbol')]), val: rt.get_constant('EB_IN_BYTES') }, rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('PB'), rt.new_string('unit symbol')]), val: rt.get_constant('PB_IN_BYTES') }, rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('TB'), rt.new_string('unit symbol')]), val: rt.get_constant('TB_IN_BYTES') }, rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('GB'), rt.new_string('unit symbol')]), val: rt.get_constant('GB_IN_BYTES') }, rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('MB'), rt.new_string('unit symbol')]), val: rt.get_constant('MB_IN_BYTES') }, rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('KB'), rt.new_string('unit symbol')]), val: rt.get_constant('KB_IN_BYTES') }, rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('B'), rt.new_string('unit symbol')]), val: 1 }])
	if rt.is_true(rt.identical(rt.new_int(0), var_bytes)) {
		return rt.new_string((number_format_i18n(rt.new_int(0), decimals)).str() + ' ' + (rt.call_function('_x', [rt.new_string('B'), rt.new_string('unit symbol')])).str())
	}
	mut iter_5 := var_quant.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_mag_shadow := item_5.val
		mut var_unit_shadow := item_5.key
		if rt.is_true(rt.greater_equal(rt.new_float((var_bytes).to_f64()), var_mag_shadow)) {
			return rt.new_string((number_format_i18n(rt.div(var_bytes, var_mag_shadow), decimals)).str() + ' ' + (var_unit_shadow).str())
		}
	}
	return rt.new_bool(false)
}

fn human_readable_duration(duration string) bool {
	mut var_duration := duration
	mut var_duration_parts := rt.new_null()
	mut var_duration_count := i64(0)
	mut var_hour := rt.new_null()
	mut var_minute := rt.new_null()
	mut var_second := rt.new_null()
	mut var_human_readable_duration := []rt.PhpVal{}
	if var_duration == '' || !(rt.new_string((var_duration).str()).is_string()) {
		return false
	}
	var_duration = var_duration.trim_space()
	if rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_duration).str()), rt.new_string('-')])) {
	var_duration = (rt.call_function('substr', [rt.new_string((var_duration).str()), rt.new_int(1)])).str()
	}
	var_duration_parts = rt.call_function('array_reverse', [rt.call_function('explode', [rt.new_string(':'), rt.new_string((var_duration).str())])])
	var_duration_count = var_duration_parts.clone().array_count()
	var_hour = rt.new_null()
	var_minute = rt.new_null()
	var_second = rt.new_null()
	if 3 == var_duration_count {
		if rt.is_true(rt.new_bool(!(rt.is_true((rt.call_function('preg_match', [rt.new_string('/^([0-9]+):([0-5]?[0-9]):([0-5]?[0-9])$/'), rt.new_string((var_duration).str())])).to_bool())))) {
			return false
		}
		mut list_tmp_1 := var_duration_parts
		var_second = (list_tmp_1).array_get(0)
		var_minute = (list_tmp_1).array_get(1)
		var_hour = (list_tmp_1).array_get(2)
	} else if 2 == var_duration_count {
		if rt.is_true(rt.new_bool(!(rt.is_true((rt.call_function('preg_match', [rt.new_string('/^([0-5]?[0-9]):([0-5]?[0-9])$/'), rt.new_string((var_duration).str())])).to_bool())))) {
			return false
		}
		mut list_tmp_2 := var_duration_parts
		var_second = (list_tmp_2).array_get(0)
		var_minute = (list_tmp_2).array_get(1)
	} else {
		return false
	}
	var_human_readable_duration = []rt.PhpVal{}
	if rt.is_true(rt.new_bool(var_hour.clone().is_long() || var_hour.clone().is_double())) {
		var_human_readable_duration << rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s hour'), rt.new_string('%s hours'), var_hour.clone()]), rt.new_int((var_hour).to_i64())])
	}
	if rt.is_true(rt.new_bool(var_minute.clone().is_long() || var_minute.clone().is_double())) {
		var_human_readable_duration << rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s minute'), rt.new_string('%s minutes'), var_minute.clone()]), rt.new_int((var_minute).to_i64())])
	}
	if rt.is_true(rt.new_bool(var_second.clone().is_long() || var_second.clone().is_double())) {
		var_human_readable_duration << rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s second'), rt.new_string('%s seconds'), var_second.clone()]), rt.new_int((var_second).to_i64())])
	}
	return (rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_human_readable_duration)])).to_bool()
}

fn get_weekstartend(var_mysqlstring rt.PhpVal, start_of_week string) rt.PhpVal {
	mut var_start_of_week := start_of_week
	mut var_my := rt.new_null()
	mut var_mm := rt.new_null()
	mut var_md := rt.new_null()
	mut var_day := rt.new_null()
	mut var_weekday := rt.new_null()
	mut var_start := rt.new_null()
	mut var_end := rt.new_null()
	var_my = rt.call_function('substr', [var_mysqlstring.clone(), rt.new_int(0), rt.new_int(4)])
	var_mm = rt.call_function('substr', [var_mysqlstring.clone(), rt.new_int(8), rt.new_int(2)])
	var_md = rt.call_function('substr', [var_mysqlstring.clone(), rt.new_int(5), rt.new_int(2)])
	var_day = rt.call_function('mktime', [rt.new_int(0), rt.new_int(0), rt.new_int(0), var_md.clone(), var_mm.clone(), var_my.clone()])
	var_weekday = rt.new_int((rt.call_function('gmdate', [rt.new_string('w'), var_day.clone()])).to_i64())
	if !(rt.new_string((var_start_of_week).str()).is_long() || rt.new_string((var_start_of_week).str()).is_double()) {
	var_start_of_week = rt.new_int((rt.call_function('get_option', [rt.new_string('start_of_week')])).to_i64())
	}
	if rt.is_true(rt.less(var_weekday, rt.new_string((var_start_of_week).str()))) {
		var_weekday = rt.add(var_weekday, rt.new_int(7))
	}
	var_start = rt.sub(var_day, rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.sub(var_weekday, rt.new_string((var_start_of_week).str()))))
	var_end = rt.sub(rt.add(var_start, rt.get_constant('WEEK_IN_SECONDS')), rt.new_int(1))
	return rt.call_function('compact', [rt.new_string('start'), rt.new_string('end')])
}

fn maybe_serialize(var_data rt.PhpVal) rt.PhpVal {
	if var_data.clone().is_array() || var_data.clone().is_object() {
		return rt.call_function('serialize', [var_data.clone()])
	}
	if rt.is_true(rt.new_bool(is_serialized(var_data.clone(), false))) {
		return rt.call_function('serialize', [var_data.clone()])
	}
	return var_data.clone()
}

fn maybe_unserialize(var_data rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(is_serialized(var_data.clone(), false))) {
		return rt.call_function('unserialize', [rt.new_string(var_data.clone().to_string().trim_space())])
	}
	return var_data.clone()
}

fn is_serialized(var_data_arg rt.PhpVal, strict bool) bool {
	mut var_strict := strict
	mut var_data := var_data_arg
	mut var_lastc := rt.new_null()
	mut var_semicolon := rt.new_null()
	mut var_brace := rt.new_null()
	mut var_token := rt.new_null()
	mut var_end := rt.new_null()
	if !(rt.new_string((var_data).str()).clone().is_string()) {
		return false
	}
	var_data = var_data.trim_space()
	if rt.is_true(rt.identical(rt.new_string('N;'), rt.new_string((var_data).str()))) {
		return true
	}
	if var_data.len < 4 {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(':'), rt.new_string((var_data).str()).array_get(rt.new_int(1)))))) {
		return false
	}
	if var_strict {
		var_lastc = rt.call_function('substr', [rt.new_string((var_data).str()).clone(), rt.new_int(-1)])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(';'), var_lastc)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('}'), var_lastc)))) {
			return false
		}
	} else {
		var_semicolon = rt.call_function('strpos', [rt.new_string((var_data).str()).clone(), rt.new_string(';')])
		var_brace = rt.call_function('strpos', [rt.new_string((var_data).str()).clone(), rt.new_string('}')])
		if rt.is_true(rt.identical(rt.new_bool(false), var_semicolon)) && rt.is_true(rt.identical(rt.new_bool(false), var_brace)) {
			return false
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_semicolon)))) && rt.is_true(rt.less(var_semicolon, rt.new_int(3))) {
			return false
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_brace)))) && rt.is_true(rt.less(var_brace, rt.new_int(4))) {
			return false
		}
	}
	var_token = rt.new_string((var_data).str()).array_get(rt.new_int(0))
	mut switch_val_2 := var_token
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('s'))) {
		if var_strict {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('"'), rt.call_function('substr', [rt.new_string((var_data).str()).clone(), rt.new_int(-2), rt.new_int(1)]))))) {
				return false
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.new_string((var_data).str()).clone(), rt.new_string('"')]))))) {
			return false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('a'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('O'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('E'))) {
		return (rt.call_function('preg_match', [rt.new_string("/^${var_token.to_string()}:[0-9]+:/s"), rt.new_string((var_data).str()).clone()])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('b'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('i'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('d'))) {
		var_end = rt.new_string((if var_strict { '$' } else { '' }).str())
		return (rt.call_function('preg_match', [rt.new_string("/^${var_token.to_string()}:[0-9.E+-]+;${var_end.to_string()}/"), rt.new_string((var_data).str()).clone()])).to_bool()
	}
	return false
}

fn is_serialized_string(var_data_arg rt.PhpVal) bool {
	mut var_data := var_data_arg
	if !(rt.new_string((var_data).str()).clone().is_string()) {
		return false
	}
	var_data = var_data.trim_space()
	if var_data.len < 4 {
		return false
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(':'), rt.new_string((var_data).str()).array_get(rt.new_int(1)))))) {
		return false
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [rt.new_string((var_data).str()).clone(), rt.new_string(';')]))))) {
		return false
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('s'), rt.new_string((var_data).str()).array_get(rt.new_int(0)))))) {
		return false
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('"'), rt.call_function('substr', [rt.new_string((var_data).str()).clone(), rt.new_int(-2), rt.new_int(1)]))))) {
		return false
	} else {
		return true
	}
	return false
}

fn xmlrpc_getposttitle(var_content rt.PhpVal) rt.PhpVal {
	mut var_post_default_title := rt.new_null()
	mut var_matchtitle := []rt.PhpVal{}
	mut var_post_title := rt.new_null()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/<title>(.+?)<\\/title>/is'), var_content.clone(), rt.create_array_from_list(var_matchtitle)])) {
	var_post_title = var_matchtitle[1]
	} else {
	var_post_title = var_post_default_title
	}
	return var_post_title.clone()
}

fn xmlrpc_getpostcategory(var_content rt.PhpVal) rt.PhpVal {
	mut var_post_default_category := rt.new_null()
	mut var_matchcat := []rt.PhpVal{}
	mut var_post_category := rt.new_null()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/<category>(.+?)<\\/category>/is'), var_content.clone(), rt.create_array_from_list(var_matchcat)])) {
	var_post_category = rt.new_string(var_matchcat[1].to_string().trim_space())
	var_post_category = rt.call_function('explode', [rt.new_string(','), var_post_category.clone()])
	} else {
	var_post_category = var_post_default_category
	}
	return var_post_category.clone()
}

fn xmlrpc_removepostdata(var_content_arg rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	var_content = rt.call_function('preg_replace', [rt.new_string('/<title>(.+?)<\\/title>/si'), rt.new_string(''), var_content.clone()])
	var_content = rt.call_function('preg_replace', [rt.new_string('/<category>(.+?)<\\/category>/si'), rt.new_string(''), var_content.clone()])
	var_content = rt.new_string(var_content.clone().to_string().trim_space())
	return var_content.clone()
}

fn wp_extract_urls(var_content rt.PhpVal) rt.PhpVal {
	mut var_post_links := rt.new_null()
	rt.call_function('preg_match_all', [rt.new_string('#(["\']?)(' + '(?:([\\w-]+:)?//?)' + '[^\\s()<>]+' + '[.]' + '(?:' + '\\([\\w\\d]+\\)|' + '(?:' + '[^`!()\\[\\]{}:\'".,<>«»“”‘’\\s]|' + '(?:[:]\\d+)?/?' + ')+' + ')' + ')\\1#'), var_content.clone(), var_post_links.clone()])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_link := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_link = rt.call_function('html_entity_decode', [var_link.clone()])
		return rt.call_function('str_replace', [rt.new_string(';'), rt.new_string(''), var_link.clone()])
		}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_link := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_link = rt.call_function('html_entity_decode', [var_link.clone()])
		return rt.call_function('str_replace', [rt.new_string(';'), rt.new_string(''), var_link.clone()])
		}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_link := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_link = rt.call_function('html_entity_decode', [var_link.clone()])
		return rt.call_function('str_replace', [rt.new_string(';'), rt.new_string(''), var_link.clone()])
		}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_link := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_link = rt.call_function('html_entity_decode', [var_link.clone()])
		return rt.call_function('str_replace', [rt.new_string(';'), rt.new_string(''), var_link.clone()])
		}
	var_post_links = rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_post_links.array_get(rt.new_int(2))])])
	return rt.call_function('array_values', [var_post_links.clone()])
}

fn do_enclose(var_content_arg rt.PhpVal, var_post_arg rt.PhpVal) bool {
	mut var_content := var_content_arg
	mut var_post := var_post_arg
	mut var_wpdb := rt.new_null()
	mut var_post_links := rt.new_null()
	mut var_pung := rt.new_null()
	mut var_post_links_temp := rt.new_null()
	mut var_link_test := rt.new_null()
	mut var_mids := rt.new_null()
	mut var_mid := rt.new_null()
	mut var_test := rt.new_null()
	mut var_url := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_len := rt.new_null()
	mut var_type := rt.new_null()
	mut var_allowed_types := []rt.PhpVal{}
	mut var_url_parts := rt.new_null()
	mut var_extension := rt.new_null()
	mut var_mime := rt.new_null()
	mut var_exts := rt.new_null()
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-IXR.php', '4')
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_null(), var_content)) {
	var_content = rt.get_property(var_post, 'post_content')
	}
	var_post_links = []rt.PhpVal{}
	var_pung = rt.call_function('get_enclosed', [rt.get_property(var_post, 'ID')])
	var_post_links_temp = wp_extract_urls(var_content.clone())
	mut iter_6 := var_pung.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_link_test_shadow := item_6.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_link_test_shadow.clone(), var_post_links_temp.clone(), rt.new_bool(true)]))))) {
			var_mids = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT meta_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE post_id = %d AND meta_key = \'enclosure\' AND meta_value LIKE %s')), rt.get_property(var_post, 'ID'), rt.new_string((rt.call_method(var_wpdb, 'esc_like', [var_link_test_shadow.clone()])).str() + '%')])])
			mut iter_7 := var_mids.iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_mid_shadow := item_7.val
				rt.call_function('delete_metadata_by_mid', [rt.new_string('post'), var_mid_shadow.clone()])
			}
		}
	}
	mut iter_8 := rt.cast_array(var_post_links_temp).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_link_test_shadow := item_8.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_link_test_shadow.clone(), var_pung.clone(), rt.new_bool(true)]))))) {
			var_test = rt.call_function('parse_url', [var_link_test_shadow.clone()])
			if rt.is_true(rt.identical(rt.new_bool(false), var_test)) {
				continue
			}
			if var_test.array_isset(rt.new_string('query')) {
				var_post_links.array_push(var_link_test_shadow.clone())
			} else if var_test.array_isset(rt.new_string('path')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), var_test.array_get(rt.new_string('path')))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_test.array_get(rt.new_string('path')))))) {
				var_post_links.array_push(var_link_test_shadow.clone())
			}
		}
	}
	var_post_links = rt.call_function('apply_filters', [rt.new_string('enclosure_links'), var_post_links.clone(), rt.get_property(var_post, 'ID')])
	mut iter_9 := rt.cast_array(var_post_links).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_url_shadow := item_9.val
		var_url_shadow = rt.call_function('strip_fragment_from_url', [var_url_shadow.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_url_shadow)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE post_id = %d AND meta_key = \'enclosure\' AND meta_value LIKE %s')), rt.get_property(var_post, 'ID'), rt.new_string((rt.call_method(var_wpdb, 'esc_like', [var_url_shadow.clone()])).str() + '%')])]))))) {
			var_headers = rt.new_bool(wp_get_http_headers(var_url_shadow.clone(), false))
			if rt.is_true(var_headers) {
				var_len = rt.new_int((if !(var_headers.array_get(rt.new_string('Content-Length'))).is_null() { var_headers.array_get(rt.new_string('Content-Length')) } else { rt.new_int(0) }).to_i64())
				var_type = if !(var_headers.array_get(rt.new_string('Content-Type'))).is_null() { var_headers.array_get(rt.new_string('Content-Type')) } else { rt.new_string('') }
				var_allowed_types = ['video', 'audio']
				var_url_parts = rt.call_function('parse_url', [var_url_shadow.clone()])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_url_parts)))) && !(!rt.is_true(var_url_parts.array_get(rt.new_string('path')))) {
					var_extension = rt.call_function('pathinfo', [var_url_parts.array_get(rt.new_string('path')), rt.get_constant('PATHINFO_EXTENSION')])
					if !(!rt.is_true(var_extension)) {
						mut iter_10 := wp_get_mime_types().iterator()
						for {
							item_10 := iter_10.next() or { break }
							mut var_mime_shadow := item_10.val
							mut var_exts_shadow := item_10.key
							if rt.is_true(rt.call_function('preg_match', [rt.new_string('!^(' + (var_exts_shadow).str() + ')$!i'), var_extension.clone()])) {
								var_type = var_mime_shadow.clone()
								break
							}
						}
					}
				}
				if rt.is_true(rt.call_function('in_array', [rt.call_function('substr', [var_type.clone(), rt.new_int(0), rt.call_function('strpos', [var_type.clone(), rt.new_string('/')])]), rt.create_array_from_list(var_allowed_types), rt.new_bool(true)])) {
					rt.call_function('add_post_meta', [rt.get_property(var_post, 'ID'), rt.new_string('enclosure'), rt.new_string("${var_url.to_string()}\n${var_len.to_string()}\n${var_mime.to_string()}\n")])
				}
			}
		}
	}
	return false
}

fn wp_get_http_headers(var_url rt.PhpVal, deprecated bool) bool {
	mut var_deprecated := deprecated
	mut var_response := rt.new_null()
	if !(!(deprecated)) {
		_deprecated_argument(rt.new_string(@FN), '2.7.0', '')
	}
	var_response = rt.call_function('wp_safe_remote_head', [var_url.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return false
	}
	return (rt.call_function('wp_remote_retrieve_headers', [var_response.clone()])).to_bool()
}

fn is_new_day() i64 {
	mut var_currentday := rt.new_null()
	mut var_previousday := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_currentday, var_previousday)))) {
		return 1
	} else {
		return 0
	}
	return 0
}

fn build_query(var_data rt.PhpVal) rt.PhpVal {
	return _http_build_query(var_data.clone(), rt.new_null(), rt.new_string('&'), '', false)
}

fn _http_build_query(var_data rt.PhpVal, var_prefix rt.PhpVal, var_sep_arg rt.PhpVal, key string, urlencode bool) rt.PhpVal {
	mut var_key := key
	mut var_urlencode := urlencode
	mut var_sep := var_sep_arg
	mut var_ret := rt.new_null()
	mut var_v := ''
	mut var_k := rt.new_null()
	var_ret = []rt.PhpVal{}
	mut iter_11 := rt.cast_array(var_data).iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_v_shadow := item_11.val
		mut var_k_shadow := item_11.key
		if var_urlencode {
		var_k_shadow = rt.call_function('urlencode', [var_k_shadow.clone()])
		}
		if var_k_shadow.clone().is_long() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_prefix)))) {
		var_k_shadow = rt.new_string((var_prefix).str() + (var_k_shadow).str())
		}
		if !(key == '') {
		var_k_shadow = rt.new_string(key + '%5B' + (var_k_shadow).str() + '%5D')
		}
		if rt.is_true(rt.identical(rt.new_null(), var_v_shadow)) {
			continue
		} else if rt.is_true(rt.identical(rt.new_bool(false), var_v_shadow)) {
		var_v_shadow = rt.new_string('0')
		}
		if rt.new_string((var_v_shadow).str()).is_array() || rt.new_string((var_v_shadow).str()).is_object() {
			var_ret.clone().array_push(_http_build_query(rt.new_string((var_v_shadow).str()), rt.new_string(''), var_sep.clone(), var_k_shadow.clone(), urlencode))
		} else if var_urlencode {
			var_ret.clone().array_push(rt.new_string((var_k_shadow).str() + '=' + (rt.call_function('urlencode', [rt.new_string((var_v_shadow).str())])).str()))
		} else {
			var_ret.clone().array_push(rt.new_string((var_k_shadow).str() + '=' + var_v_shadow))
		}
	}
	if rt.is_true(rt.identical(rt.new_null(), var_sep)) {
	var_sep = rt.call_function('ini_get', [rt.new_string('arg_separator.output')])
	}
	return rt.call_function('implode', [var_sep.clone(), var_ret.clone()])
}

fn add_query_arg(var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_uri := rt.new_null()
	mut var_frag := rt.new_null()
	mut var_protocol := ''
	mut var_base := rt.new_null()
	mut var_query := rt.new_null()
	mut var_qs := rt.new_null()
	mut var_v := rt.new_null()
	mut var_k := rt.new_null()
	mut var_ret := rt.new_null()
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_int(0)).is_array())) {
		if var_args.clone().array_count() < 2 || rt.is_true(rt.identical(rt.new_bool(false), var_args.array_get(rt.new_int(1)))) {
		var_uri = rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))
		} else {
		var_uri = var_args.array_get(rt.new_int(1))
		}
	} else {
		if var_args.clone().array_count() < 3 || rt.is_true(rt.identical(rt.new_bool(false), var_args.array_get(rt.new_int(2)))) {
		var_uri = rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))
		} else {
		var_uri = var_args.array_get(rt.new_int(2))
		}
	}
	var_frag = rt.call_function('strstr', [var_uri.clone(), rt.new_string('#')])
	if rt.is_true(var_frag) {
	var_uri = rt.call_function('substr', [var_uri.clone(), rt.new_int(0), rt.new_int(-var_frag.clone().to_string().len)])
	} else {
	var_frag = rt.new_string('')
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [var_uri.clone(), rt.new_string('http://')]))) {
	var_protocol = 'http://'
	var_uri = rt.call_function('substr', [var_uri.clone(), rt.new_int(7)])
	} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [var_uri.clone(), rt.new_string('https://')]))) {
	var_protocol = 'https://'
	var_uri = rt.call_function('substr', [var_uri.clone(), rt.new_int(8)])
	} else {
	var_protocol = ''
	}
	if rt.is_true(rt.call_function('str_contains', [var_uri.clone(), rt.new_string('?')])) {
		mut list_tmp_3 := rt.call_function('explode', [rt.new_string('?'), var_uri.clone(), rt.new_int(2)])
		var_base = (list_tmp_3).array_get(0)
		var_query = (list_tmp_3).array_get(1)
		var_base = rt.concat(var_base, rt.new_string('?'))
	} else if (var_protocol.len > 0 && var_protocol != '0') || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_uri.clone(), rt.new_string('=')]))))) {
	var_base = rt.new_string((var_uri).str() + '?')
	var_query = rt.new_string('')
	} else {
	var_base = rt.new_string('')
	var_query = var_uri.clone()
	}
	rt.call_function('wp_parse_str', [var_query.clone(), var_qs.clone()])
	var_qs = rt.call_function('urlencode_deep', [var_qs.clone()])
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_int(0)).is_array())) {
		mut iter_12 := var_args.array_get(rt.new_int(0)).iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_v_shadow := item_12.val
			mut var_k_shadow := item_12.key
			var_qs.array_set(var_k_shadow, var_v_shadow.clone())
		}
	} else {
		var_qs.array_set(var_args.array_get(rt.new_int(0)), var_args.array_get(rt.new_int(1)))
	}
	mut iter_13 := var_qs.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_v_shadow := item_13.val
		mut var_k_shadow := item_13.key
		if rt.is_true(rt.identical(rt.new_bool(false), var_v_shadow)) {
			var_qs.array_unset(var_k_shadow)
		}
	}
	var_ret = build_query(var_qs.clone())
	var_ret = rt.new_string(var_ret.clone().to_string().trim_space())
	var_ret = rt.call_function('preg_replace', [rt.new_string('#=(&|$)#'), rt.new_string('$1'), var_ret.clone()])
	var_ret = rt.new_string((var_protocol + (var_base).str() + (var_ret).str() + (var_frag).str()).str())
	var_ret = rt.new_string(var_ret.clone().to_string().trim_right(' \t\n\r'))
	var_ret = rt.call_function('str_replace', [rt.new_string('?#'), rt.new_string('#'), var_ret.clone()])
	return var_ret.clone()
}

fn remove_query_arg(key string, query bool) rt.PhpVal {
	mut var_key := key
	mut var_query := query
	mut var_k := rt.new_null()
	if rt.is_true(rt.new_bool(rt.new_string(key).is_array())) {
		mut iter_14 := rt.new_string(key).iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_k_shadow := item_14.val
		var_query = (add_query_arg(var_k_shadow.clone(), rt.new_bool(false), rt.new_bool(var_query))).to_bool()
		}
		return rt.new_bool(var_query)
	}
	return add_query_arg(rt.new_string(key), rt.new_bool(false), rt.new_bool(var_query))
}

fn wp_removable_query_args() rt.PhpVal {
	mut var_removable_query_args := []rt.PhpVal{}
	var_removable_query_args = ['activate', 'activated', 'admin_email_remind_later', 'approved', 'core-major-auto-updates-saved', 'deactivate', 'delete_count', 'deleted', 'disabled', 'doing_wp_cron', 'enabled', 'error', 'hotkeys_highlight_first', 'hotkeys_highlight_last', 'ids', 'locked', 'message', 'same', 'saved', 'settings-updated', 'skipped', 'spammed', 'trashed', 'unspammed', 'untrashed', 'update', 'updated', 'wp-post-new-reload']
	return rt.call_function('apply_filters', [rt.new_string('removable_query_args'), rt.create_array_from_list(var_removable_query_args)])
}

fn add_magic_quotes(var_input_array rt.PhpVal) rt.PhpVal {
	mut var_v := rt.new_null()
	mut var_k := rt.new_null()
	mut iter_15 := rt.cast_array(var_input_array).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_v_shadow := item_15.val
		mut var_k_shadow := item_15.key
		if rt.is_true(rt.new_bool(var_v_shadow.clone().is_array())) {
			var_input_array.array_set(var_k_shadow, add_magic_quotes(var_v_shadow.clone()))
		} else if rt.is_true(rt.new_bool(var_v_shadow.clone().is_string())) {
			var_input_array.array_set(var_k_shadow, rt.call_function('addslashes', [var_v_shadow.clone()]))
		}
	}
	return var_input_array.clone()
}

fn wp_remote_fopen(var_uri rt.PhpVal) bool {
	mut var_parsed_url := rt.new_null()
	mut var_options := rt.new_null()
	mut var_response := rt.new_null()
	var_parsed_url = rt.call_function('parse_url', [var_uri.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_url)))) || !(var_parsed_url.clone().is_array()) {
		return false
	}
	var_options = []rt.PhpVal{}
	var_options.array_set('timeout', 10)
	var_response = rt.call_function('wp_safe_remote_get', [var_uri.clone(), var_options.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return false
	}
	return (rt.call_function('wp_remote_retrieve_body', [var_response.clone()])).to_bool()
}

fn wp(query_vars string) {
	mut var_query_vars := query_vars
	mut var_wp := rt.new_null()
	mut var_wp_query := rt.new_null()
	mut var_wp_the_query := rt.new_null()
	rt.call_method(var_wp, 'main', [rt.new_string(query_vars)])
	if !(!(var_wp_the_query).is_null()) {
	var_wp_the_query = var_wp_query
	}
}

fn get_status_header_desc(var_code_arg rt.PhpVal) string {
	mut var_code := var_code_arg
	mut var_wp_header_to_desc := rt.new_null()
	var_code = rt.call_function('absint', [var_code.clone()])
	if !(!(var_wp_header_to_desc).is_null()) {
	var_wp_header_to_desc = rt.create_array([rt.ArrayItem{ key: 100, val: 'Continue' }, rt.ArrayItem{ key: 101, val: 'Switching Protocols' }, rt.ArrayItem{ key: 102, val: 'Processing' }, rt.ArrayItem{ key: 103, val: 'Early Hints' }, rt.ArrayItem{ key: 200, val: 'OK' }, rt.ArrayItem{ key: 201, val: 'Created' }, rt.ArrayItem{ key: 202, val: 'Accepted' }, rt.ArrayItem{ key: 203, val: 'Non-Authoritative Information' }, rt.ArrayItem{ key: 204, val: 'No Content' }, rt.ArrayItem{ key: 205, val: 'Reset Content' }, rt.ArrayItem{ key: 206, val: 'Partial Content' }, rt.ArrayItem{ key: 207, val: 'Multi-Status' }, rt.ArrayItem{ key: 226, val: 'IM Used' }, rt.ArrayItem{ key: 300, val: 'Multiple Choices' }, rt.ArrayItem{ key: 301, val: 'Moved Permanently' }, rt.ArrayItem{ key: 302, val: 'Found' }, rt.ArrayItem{ key: 303, val: 'See Other' }, rt.ArrayItem{ key: 304, val: 'Not Modified' }, rt.ArrayItem{ key: 305, val: 'Use Proxy' }, rt.ArrayItem{ key: 306, val: 'Reserved' }, rt.ArrayItem{ key: 307, val: 'Temporary Redirect' }, rt.ArrayItem{ key: 308, val: 'Permanent Redirect' }, rt.ArrayItem{ key: 400, val: 'Bad Request' }, rt.ArrayItem{ key: 401, val: 'Unauthorized' }, rt.ArrayItem{ key: 402, val: 'Payment Required' }, rt.ArrayItem{ key: 403, val: 'Forbidden' }, rt.ArrayItem{ key: 404, val: 'Not Found' }, rt.ArrayItem{ key: 405, val: 'Method Not Allowed' }, rt.ArrayItem{ key: 406, val: 'Not Acceptable' }, rt.ArrayItem{ key: 407, val: 'Proxy Authentication Required' }, rt.ArrayItem{ key: 408, val: 'Request Timeout' }, rt.ArrayItem{ key: 409, val: 'Conflict' }, rt.ArrayItem{ key: 410, val: 'Gone' }, rt.ArrayItem{ key: 411, val: 'Length Required' }, rt.ArrayItem{ key: 412, val: 'Precondition Failed' }, rt.ArrayItem{ key: 413, val: 'Request Entity Too Large' }, rt.ArrayItem{ key: 414, val: 'Request-URI Too Long' }, rt.ArrayItem{ key: 415, val: 'Unsupported Media Type' }, rt.ArrayItem{ key: 416, val: 'Requested Range Not Satisfiable' }, rt.ArrayItem{ key: 417, val: 'Expectation Failed' }, rt.ArrayItem{ key: 418, val: 'I\'m a teapot' }, rt.ArrayItem{ key: 421, val: 'Misdirected Request' }, rt.ArrayItem{ key: 422, val: 'Unprocessable Entity' }, rt.ArrayItem{ key: 423, val: 'Locked' }, rt.ArrayItem{ key: 424, val: 'Failed Dependency' }, rt.ArrayItem{ key: 425, val: 'Too Early' }, rt.ArrayItem{ key: 426, val: 'Upgrade Required' }, rt.ArrayItem{ key: 428, val: 'Precondition Required' }, rt.ArrayItem{ key: 429, val: 'Too Many Requests' }, rt.ArrayItem{ key: 431, val: 'Request Header Fields Too Large' }, rt.ArrayItem{ key: 451, val: 'Unavailable For Legal Reasons' }, rt.ArrayItem{ key: 500, val: 'Internal Server Error' }, rt.ArrayItem{ key: 501, val: 'Not Implemented' }, rt.ArrayItem{ key: 502, val: 'Bad Gateway' }, rt.ArrayItem{ key: 503, val: 'Service Unavailable' }, rt.ArrayItem{ key: 504, val: 'Gateway Timeout' }, rt.ArrayItem{ key: 505, val: 'HTTP Version Not Supported' }, rt.ArrayItem{ key: 506, val: 'Variant Also Negotiates' }, rt.ArrayItem{ key: 507, val: 'Insufficient Storage' }, rt.ArrayItem{ key: 510, val: 'Not Extended' }, rt.ArrayItem{ key: 511, val: 'Network Authentication Required' }])
	}
	if var_wp_header_to_desc.array_isset(var_code) {
		return (var_wp_header_to_desc.array_get(var_code)).str()
	} else {
		return ''
	}
	return ''
}

fn status_header(var_code rt.PhpVal, description string) {
	mut var_description := description
	mut var_protocol := rt.new_null()
	mut var_status_header := rt.new_null()
	if !(var_description.len > 0 && var_description != '0') {
	var_description = get_status_header_desc(var_code.clone())
	}
	if var_description == '' {
		return
	}
	var_protocol = rt.call_function('wp_get_server_protocol', []rt.PhpVal{})
	var_status_header = rt.new_string("${var_protocol.to_string()} ${var_code.to_string()} ${var_description}")
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('apply_filters')])) {
	var_status_header = rt.call_function('apply_filters', [rt.new_string('status_header'), var_status_header.clone(), var_code.clone(), rt.new_string((var_description).str()), var_protocol.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('header', [var_status_header.clone(), rt.new_bool(true), var_code.clone()])
	}
}

fn wp_get_nocache_headers() rt.PhpVal {
	mut var_cache_control := ''
	mut var_headers := rt.new_null()
	var_cache_control = 'no-cache, must-revalidate, max-age=0, no-store, private'
	var_headers = rt.create_array([rt.ArrayItem{ key: 'Expires', val: 'Wed, 11 Jan 1984 05:00:00 GMT' }, rt.ArrayItem{ key: 'Cache-Control', val: var_cache_control }])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('apply_filters')])) {
	var_headers = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('nocache_headers'), var_headers.clone()]))
	}
	var_headers.array_set('Last-Modified', false)
	return var_headers.clone()
}

fn nocache_headers() {
	mut var_headers := rt.new_null()
	mut var_field_value := rt.new_null()
	mut var_name := rt.new_null()
	if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
		return
	}
	var_headers = wp_get_nocache_headers()
	var_headers.array_unset(rt.new_string('Last-Modified'))
	rt.call_function('header_remove', [rt.new_string('Last-Modified')])
	mut iter_16 := var_headers.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_field_value_shadow := item_16.val
		mut var_name_shadow := item_16.key
		rt.call_function('header', [rt.new_string("${var_name.to_string()}: ${var_field_value.to_string()}")])
	}
}

fn cache_javascript_headers() {
	mut var_expires_offset := rt.new_null()
	var_expires_offset = rt.mul(rt.new_int(10), rt.get_constant('DAY_IN_SECONDS'))
	rt.call_function('header', [rt.new_string('Content-Type: text/javascript; charset=' + (rt.call_function('get_bloginfo', [rt.new_string('charset')])).str())])
	rt.call_function('header', [rt.new_string('Vary: Accept-Encoding')])
	rt.call_function('header', [rt.new_string('Expires: ' + (rt.call_function('gmdate', [rt.new_string('D, d M Y H:i:s'), rt.add(rt.call_function('time', []rt.PhpVal{}), var_expires_offset)])).str() + ' GMT')])
}

fn get_num_queries() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.get_property(var_wpdb, 'num_queries')
}

fn bool_from_yn(var_yn rt.PhpVal) rt.PhpVal {
	return rt.identical(rt.new_string('y'), rt.new_string(var_yn.clone().to_string().to_lower()))
}

fn do_feed() {
	mut var_wp_query := rt.new_null()
	mut var_feed := rt.new_null()
	var_feed = rt.call_function('get_query_var', [rt.new_string('feed')])
	var_feed = rt.call_function('preg_replace', [rt.new_string('/^_+/'), rt.new_string(''), var_feed.clone()])
	if rt.is_true(rt.identical(rt.new_string(''), var_feed)) || rt.is_true(rt.identical(rt.new_string('feed'), var_feed)) {
	var_feed = rt.call_function('get_default_feed', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [rt.new_string("do_feed_${var_feed.to_string()}")]))))) {
		wp_die(rt.call_function('__', [rt.new_string('<strong>Error:</strong> This is not a valid feed template.')]), '', rt.create_array([rt.ArrayItem{ key: 'response', val: 404 }]))
	}
	rt.call_function('do_action', [rt.new_string("do_feed_${var_feed.to_string()}"), rt.get_property(var_wp_query, 'is_comment_feed'), var_feed.clone()])
}

fn do_feed_rdf() {
	rt.call_function('load_template', [rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/feed-rdf.php')])
}

fn do_feed_rss() {
	rt.call_function('load_template', [rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/feed-rss.php')])
}

fn do_feed_rss2(var_for_comments rt.PhpVal) {
	if rt.is_true(var_for_comments) {
		rt.call_function('load_template', [rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/feed-rss2-comments.php')])
	} else {
		rt.call_function('load_template', [rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/feed-rss2.php')])
	}
}

fn do_feed_atom(var_for_comments rt.PhpVal) {
	if rt.is_true(var_for_comments) {
		rt.call_function('load_template', [rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/feed-atom-comments.php')])
	} else {
		rt.call_function('load_template', [rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/feed-atom.php')])
	}
}

fn do_robots() {
	mut var_output := ''
	mut var_public := rt.new_null()
	mut var_site_url := rt.new_null()
	mut var_path := rt.new_null()
	rt.call_function('header', [rt.new_string('Content-Type: text/plain; charset=utf-8')])
	rt.call_function('do_action', [rt.new_string('do_robotstxt')])
	var_output = 'User-agent: *\n'
	var_public = rt.new_bool((rt.call_function('get_option', [rt.new_string('blog_public')])).to_bool())
	var_site_url = rt.call_function('parse_url', [rt.call_function('site_url', []rt.PhpVal{})])
	var_path = if !(!rt.is_true(var_site_url.array_get(rt.new_string('path')))) { var_site_url.array_get(rt.new_string('path')) } else { rt.new_string('') }
	var_output = var_output + "Disallow: ${var_path.to_string()}/wp-admin/\n"
	var_output = var_output + "Allow: ${var_path.to_string()}/wp-admin/admin-ajax.php\n"
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('robots_txt'), rt.new_string((var_output).str()).clone(), var_public.clone()]))
}

fn do_favicon() {
	rt.call_function('do_action', [rt.new_string('do_faviconico')])
	rt.call_function('wp_redirect', [rt.call_function('get_site_icon_url', [rt.new_int(32), rt.call_function('includes_url', [rt.new_string('images/w-logo-blue-white-bg.png')])])])
	exit(0)
}

fn is_blog_installed() bool {
	mut var_wpdb := rt.new_null()
	mut var_suppress := rt.new_null()
	mut var_alloptions := rt.new_null()
	mut var_installed := rt.new_null()
	mut var_wp_tables := rt.new_null()
	mut var_table := rt.new_null()
	mut var_described_table := rt.new_null()
	if rt.is_true(rt.call_function('wp_cache_get', [rt.new_string('is_blog_installed')])) {
		return true
	}
	var_suppress = rt.call_method(var_wpdb, 'suppress_errors', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
	var_alloptions = rt.call_function('wp_load_alloptions', []rt.PhpVal{})
	}
	if !(var_alloptions.array_isset(rt.new_string('siteurl'))) {
	var_installed = rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT option_value FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' WHERE option_name = \'siteurl\''))])
	} else {
	var_installed = var_alloptions.array_get(rt.new_string('siteurl'))
	}
	rt.call_method(var_wpdb, 'suppress_errors', [var_suppress.clone()])
	var_installed = rt.new_bool(!(!rt.is_true(var_installed)))
	rt.call_function('wp_cache_set', [rt.new_string('is_blog_installed'), var_installed.clone()])
	if rt.is_true(var_installed) {
		return true
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_REPAIRING')])) {
		return true
	}
	var_suppress = rt.call_method(var_wpdb, 'suppress_errors', []rt.PhpVal{})
	var_wp_tables = rt.call_method(var_wpdb, 'tables', []rt.PhpVal{})
	mut iter_17 := var_wp_tables.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_table_shadow := item_17.val
		if rt.is_true(rt.call_function('defined', [rt.new_string('CUSTOM_USER_TABLE')])) && rt.is_true(rt.identical(rt.get_constant('CUSTOM_USER_TABLE'), var_table_shadow)) {
			continue
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('CUSTOM_USER_META_TABLE')])) && rt.is_true(rt.identical(rt.get_constant('CUSTOM_USER_META_TABLE'), var_table_shadow)) {
			continue
		}
		var_described_table = rt.call_method(var_wpdb, 'get_results', [rt.new_string("DESCRIBE ${var_table.to_string()};")])
		if (rt.is_true(rt.new_bool(!(rt.is_true(var_described_table)))) && !rt.is_true(rt.get_property(var_wpdb, 'last_error'))) || (var_described_table.clone().is_array() && 0 == var_described_table.clone().array_count()) {
			continue
		}
		rt.call_function('wp_load_translations_early', []rt.PhpVal{})
		rt.set_property(var_wpdb, 'error', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('One or more database tables are unavailable. The database may need to be <a href="%s">repaired</a>.')]), rt.new_string('maint/repair.php?referrer=is_blog_installed')]))
		dead_db()
	}
	rt.call_method(var_wpdb, 'suppress_errors', [var_suppress.clone()])
	rt.call_function('wp_cache_set', [rt.new_string('is_blog_installed'), rt.new_bool(false)])
	return false
}

fn wp_nonce_url(var_actionurl_arg rt.PhpVal, var_action rt.PhpVal, name string) rt.PhpVal {
	mut var_name := name
	mut var_actionurl := var_actionurl_arg
	var_actionurl = rt.call_function('str_replace', [rt.new_string('&amp;'), rt.new_string('&'), var_actionurl.clone()])
	return rt.call_function('esc_html', [add_query_arg(rt.new_string(name), rt.call_function('wp_create_nonce', [var_action.clone()]), var_actionurl.clone())])
}

fn wp_nonce_field(var_action rt.PhpVal, name string, referer bool, display bool) rt.PhpVal {
	mut var_name := name
	mut var_referer := referer
	mut var_display := display
	mut var_nonce_field := rt.new_null()
	var_name = (rt.call_function('esc_attr', [rt.new_string((var_name).str())])).str()
	var_nonce_field = rt.new_string('<input type="hidden" id="' + var_name + '" name="' + var_name + '" value="' + (rt.call_function('wp_create_nonce', [var_action.clone()])).str() + '" />')
	if var_referer {
		var_nonce_field = rt.concat(var_nonce_field, wp_referer_field(false))
	}
	if var_display {
		rt.echo_val(var_nonce_field)
	}
	return var_nonce_field.clone()
}

fn wp_referer_field(display bool) rt.PhpVal {
	mut var_display := display
	mut var_request_url := rt.new_null()
	mut var_referer_field := rt.new_null()
	var_request_url = remove_query_arg('_wp_http_referer', false)
	var_referer_field = rt.new_string('<input type="hidden" name="_wp_http_referer" value="' + (rt.call_function('esc_url', [var_request_url.clone()])).str() + '" />')
	if var_display {
		rt.echo_val(var_referer_field)
	}
	return var_referer_field.clone()
}

fn wp_original_referer_field(display bool, jump_back_to string) rt.PhpVal {
	mut var_display := display
	mut var_jump_back_to := jump_back_to
	mut var_ref := rt.new_null()
	mut var_orig_referer_field := rt.new_null()
	var_ref = rt.new_bool(wp_get_original_referer())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ref)))) {
	var_ref = if rt.is_true(rt.identical(rt.new_string('previous'), rt.new_string(jump_back_to))) { rt.new_bool(wp_get_referer()) } else { rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]) }
	}
	var_orig_referer_field = rt.new_string('<input type="hidden" name="_wp_original_http_referer" value="' + (rt.call_function('esc_attr', [var_ref.clone()])).str() + '" />')
	if var_display {
		rt.echo_val(var_orig_referer_field)
	}
	return var_orig_referer_field.clone()
}

fn wp_get_referer() bool {
	mut var_ref := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_validate_redirect')]))))) {
		return false
	}
	var_ref = rt.new_bool(wp_get_raw_referer())
	if rt.is_true(var_ref) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]), var_ref)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical((rt.call_function('home_url', []rt.PhpVal{})).str() + (rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])).str(), var_ref)))) {
		return (rt.call_function('wp_validate_redirect', [var_ref.clone(), rt.new_bool(false)])).to_bool()
	}
	return false
}

fn wp_get_raw_referer() bool {
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_http_referer')))) && rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_http_referer')).is_string() {
		return (rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_http_referer'))])).to_bool()
	} else if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER')))) {
		return (rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER'))])).to_bool()
	}
	return false
}

fn wp_get_original_referer() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_validate_redirect')]))))) {
		return false
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_original_http_referer')))) {
		return (rt.call_function('wp_validate_redirect', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_original_http_referer'))]), rt.new_bool(false)])).to_bool()
	}
	return false
}

fn wp_mkdir_p(var_target_arg rt.PhpVal) bool {
	mut var_target := var_target_arg
	mut var_wrapper := rt.new_null()
	mut var_target_parent := rt.new_null()
	mut var_stat := rt.new_null()
	mut var_dir_perms := rt.new_null()
	mut var_folder_parts := rt.new_null()
	mut var_i := i64(0)
	mut var_c := i64(0)
	var_wrapper = rt.new_null()
	if rt.is_true(rt.new_bool(wp_is_stream(var_target.clone()))) {
		mut list_tmp_4 := rt.call_function('explode', [rt.new_string('://'), var_target.clone(), rt.new_int(2)])
		var_wrapper = (list_tmp_4).array_get(0)
		var_target = (list_tmp_4).array_get(1)
	}
	var_target = rt.call_function('str_replace', [rt.new_string('//'), rt.new_string('/'), var_target.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_wrapper)))) {
	var_target = rt.new_string((var_wrapper).str() + '://' + (var_target).str())
	}
	var_target = rt.new_string(var_target.clone().to_string().trim_right(' \t\n\r'))
	if !rt.is_true(var_target) {
	var_target = rt.new_string('/')
	}
	if rt.is_true(rt.call_function('file_exists', [var_target.clone()])) {
		return (rt.call_function('is_dir', [var_target.clone()])).to_bool()
	}
	if rt.is_true(rt.call_function('str_contains', [var_target.clone(), rt.new_string('../')])) || rt.is_true(rt.call_function('str_contains', [var_target.clone(), rt.new_string('..' + (rt.get_constant('DIRECTORY_SEPARATOR')).str())])) {
		return false
	}
	var_target_parent = rt.call_function('dirname', [var_target.clone()])
	for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('.'), var_target_parent)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_target_parent.clone()]))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('dirname', [var_target_parent.clone()]), var_target_parent)))) {
	var_target_parent = rt.call_function('dirname', [var_target_parent.clone()])
	}
	var_stat = rt.call_function('stat', [var_target_parent.clone()])
	if rt.is_true(var_stat) {
	var_dir_perms = rt.new_int(rt.bitwise_and(var_stat.array_get(rt.new_string('mode')), rt.new_int(4095)))
	} else {
	var_dir_perms = rt.new_int(511)
	}
	if rt.is_true(rt.call_function('mkdir', [var_target.clone(), var_dir_perms.clone(), rt.new_bool(true)])) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.bitwise_and(var_dir_perms, rt.bitwise_not(rt.call_function('umask', []rt.PhpVal{}))), var_dir_perms)))) {
			var_folder_parts = rt.call_function('explode', [rt.new_string('/'), rt.call_function('substr', [var_target.clone(), rt.new_int(var_target_parent.clone().to_string().len + 1)])])
			var_i = 1
			var_c = var_folder_parts.clone().array_count()
			for {
				if !(var_i <= var_c) { break }
				rt.call_function('chmod', [rt.new_string((var_target_parent).str() + '/' + (rt.call_function('implode', [rt.new_string('/'), rt.call_function('array_slice', [var_folder_parts.clone(), rt.new_int(0), rt.new_int(var_i).clone()])])).str()), var_dir_perms.clone()])
				var_i += 1
			}
		}
		return true
	}
	return false
}

fn path_is_absolute(var_path rt.PhpVal) bool {
	if wp_is_stream(var_path.clone()) && rt.is_true(rt.call_function('is_dir', [var_path.clone()])) || rt.is_true(rt.call_function('is_file', [var_path.clone()])) {
		return true
	}
	if rt.is_true(rt.identical(rt.call_function('realpath', [var_path.clone()]), var_path)) {
		return true
	}
	if var_path.clone().to_string().len == 0 || rt.is_true(rt.identical(rt.new_string('.'), var_path.array_get(rt.new_int(0)))) {
		return false
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^[a-zA-Z]:\\\\#'), var_path.clone()])) {
		return true
	}
	return rt.is_true(rt.identical(rt.new_string('/'), var_path.array_get(rt.new_int(0)))) || rt.is_true(rt.identical(rt.new_string('\\'), var_path.array_get(rt.new_int(0))))
}

fn path_join(var_base rt.PhpVal, var_path rt.PhpVal) string {
	if rt.is_true(rt.new_bool(path_is_absolute(var_path.clone()))) {
		return (var_path).str()
	}
	return var_base.clone().to_string().trim_right(' \t\n\r') + '/' + (var_path).str()
}

fn wp_normalize_path(var_path_arg rt.PhpVal) string {
	mut var_path := var_path_arg
	mut var_cache := rt.new_null()
	mut var_original_path := rt.new_null()
	mut var_wrapper := ''
	var_path = rt.new_string((var_path).str())
	if var_cache.array_isset(var_path) {
		return (var_cache.array_get(var_path)).str()
	}
	var_original_path = var_path.clone()
	var_wrapper = ''
	if rt.is_true(rt.new_bool(wp_is_stream(var_path.clone()))) {
		mut list_tmp_5 := rt.call_function('explode', [rt.new_string('://'), var_path.clone(), rt.new_int(2)])
		var_wrapper = (list_tmp_5).array_get(0)
		var_path = (list_tmp_5).array_get(1)
		var_wrapper = var_wrapper + '://'
	}
	var_path = rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_path.clone()])
	var_path = rt.new_string((rt.call_function('preg_replace', [rt.new_string('|(?<=.)/+|'), rt.new_string('/'), var_path.clone()])).str())
	if rt.is_true(rt.identical(rt.new_string(':'), rt.call_function('substr', [var_path.clone(), rt.new_int(1), rt.new_int(1)]))) {
	var_path = rt.call_function('ucfirst', [var_path.clone()])
	}
	var_cache.array_set(var_original_path, var_wrapper + (var_path).str())
	return (var_cache.array_get(var_original_path)).str()
}

fn get_temp_dir() string {
	mut var_temp := rt.new_null()
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_TEMP_DIR')])) {
		return (rt.call_function('trailingslashit', [rt.get_constant('WP_TEMP_DIR')])).str()
	}
	if rt.is_true(var_temp) {
		return (rt.call_function('trailingslashit', [var_temp.clone()])).str()
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('sys_get_temp_dir')])) {
		var_temp = rt.call_function('sys_get_temp_dir', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_dir', [var_temp.clone()])) && rt.is_true(wp_is_writable(var_temp.clone())) {
			return (rt.call_function('trailingslashit', [var_temp.clone()])).str()
		}
	}
	var_temp = rt.call_function('ini_get', [rt.new_string('upload_tmp_dir')])
	if rt.is_true(rt.call_function('is_dir', [var_temp.clone()])) && rt.is_true(wp_is_writable(var_temp.clone())) {
		return (rt.call_function('trailingslashit', [var_temp.clone()])).str()
	}
	var_temp = rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/')
	if rt.is_true(rt.call_function('is_dir', [var_temp.clone()])) && rt.is_true(wp_is_writable(var_temp.clone())) {
		return (var_temp).str()
	}
	return '/tmp/'
}

fn wp_is_writable(var_path rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('Windows'), rt.get_constant('PHP_OS_FAMILY'))) {
		return rt.new_bool(win_is_writable(var_path.clone()))
	}
	return rt.call_function('is_writable', [var_path.clone()])
}

fn win_is_writable(var_path rt.PhpVal) bool {
	mut var_should_delete_tmp_file := false
	mut var_f := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('/'), var_path.array_get(rt.new_int(var_path.clone().to_string().len - 1)))) {
		return win_is_writable((var_path).str() + (rt.call_function('uniqid', [rt.call_function('mt_rand', []rt.PhpVal{})])).str() + '.tmp')
	} else if rt.is_true(rt.call_function('is_dir', [var_path.clone()])) {
		return win_is_writable((var_path).str() + '/' + (rt.call_function('uniqid', [rt.call_function('mt_rand', []rt.PhpVal{})])).str() + '.tmp')
	}
	var_should_delete_tmp_file = !(rt.is_true(rt.call_function('file_exists', [var_path.clone()])))
	var_f = rt.call_function('fopen', [var_path.clone(), rt.new_string('a')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_f)) {
		return false
	}
	rt.call_function('fclose', [var_f.clone()])
	if var_should_delete_tmp_file {
		rt.call_function('unlink', [var_path.clone()])
	}
	return true
}

fn wp_get_upload_dir() rt.PhpVal {
	return wp_upload_dir(rt.new_null(), false, false)
}

fn wp_upload_dir(var_time rt.PhpVal, create_dir bool, refresh_cache bool) rt.PhpVal {
	mut var_create_dir := create_dir
	mut var_refresh_cache := refresh_cache
	mut var_cache := rt.new_null()
	mut var_tested_paths := rt.new_null()
	mut var_key := rt.new_null()
	mut var_uploads := rt.new_null()
	mut var_path := rt.new_null()
	mut var_error_path := rt.new_null()
	var_key = rt.call_function('sprintf', [rt.new_string('%d-%s'), rt.call_function('get_current_blog_id', []rt.PhpVal{}), rt.new_string((var_time).str())])
	if var_refresh_cache || !rt.is_true(var_cache.array_get(var_key)) {
		var_cache.array_set(var_key, _wp_upload_dir(var_time.clone()))
	}
	var_uploads = rt.call_function('apply_filters', [rt.new_string('upload_dir'), var_cache.array_get(var_key)])
	if var_create_dir {
		var_path = var_uploads.array_get(rt.new_string('path'))
		if rt.is_true(rt.new_bool(var_tested_paths.clone().array_isset(var_path.clone()))) {
			var_uploads.array_set('error', var_tested_paths.array_get(var_path))
		} else {
			if !(wp_mkdir_p(var_path.clone())) {
				if rt.is_true(rt.call_function('str_starts_with', [var_uploads.array_get(rt.new_string('basedir')), rt.get_constant('ABSPATH')])) {
				var_error_path = rt.new_string((rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), var_uploads.array_get(rt.new_string('basedir'))])).str() + (var_uploads.array_get(rt.new_string('subdir'))).str())
				} else {
				var_error_path = rt.new_string((rt.call_function('wp_basename', [var_uploads.array_get(rt.new_string('basedir'))])).str() + (var_uploads.array_get(rt.new_string('subdir'))).str())
				}
				var_uploads.array_set('error', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to create directory %s. Is its parent directory writable by the server?')]), rt.call_function('esc_html', [var_error_path.clone()])]))
			}
			var_tested_paths.array_set(var_path, var_uploads.array_get(rt.new_string('error')))
		}
	}
	return var_uploads.clone()
}

fn _wp_upload_dir(var_time_arg rt.PhpVal) rt.PhpVal {
	mut var_time := var_time_arg
	mut var_siteurl := rt.new_null()
	mut var_upload_path := ''
	mut var_dir := rt.new_null()
	mut var_url := rt.new_null()
	mut var_ms_dir := rt.new_null()
	mut var_basedir := rt.new_null()
	mut var_baseurl := rt.new_null()
	mut var_subdir := ''
	mut var_y := rt.new_null()
	mut var_m := rt.new_null()
	var_siteurl = rt.call_function('get_option', [rt.new_string('siteurl')])
	var_upload_path = rt.call_function('get_option', [rt.new_string('upload_path')]).to_string().trim_space()
	if var_upload_path == '' || rt.is_true(rt.identical(rt.new_string('wp-content/uploads'), rt.new_string((var_upload_path).str()))) {
	var_dir = rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/uploads')
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_upload_path).str()).clone(), rt.get_constant('ABSPATH')]))))) {
	var_dir = rt.new_string(path_join(rt.get_constant('ABSPATH'), rt.new_string((var_upload_path).str()).clone()))
	} else {
	var_dir = rt.new_string((var_upload_path).str()).clone()
	}
	var_url = rt.call_function('get_option', [rt.new_string('upload_url_path')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_url)))) {
		if var_upload_path == '' || rt.is_true(rt.identical(rt.new_string('wp-content/uploads'), rt.new_string((var_upload_path).str()))) || rt.is_true(rt.identical(rt.new_string((var_upload_path).str()), var_dir)) {
		var_url = rt.new_string((rt.get_constant('WP_CONTENT_URL')).str() + '/uploads')
		} else {
		var_url = rt.new_string((rt.call_function('trailingslashit', [var_siteurl.clone()])).str() + var_upload_path)
		}
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('UPLOADS')])) && !(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('get_site_option', [rt.new_string('ms_files_rewriting')]))) {
	var_dir = rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('UPLOADS')).str())
	var_url = rt.new_string((rt.call_function('trailingslashit', [var_siteurl.clone()])).str() + (rt.get_constant('UPLOADS')).str())
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && !(is_main_network() && is_main_site() && rt.is_true(rt.call_function('defined', [rt.new_string('MULTISITE')]))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_site_option', [rt.new_string('ms_files_rewriting')]))))) {
			if rt.is_true(rt.call_function('defined', [rt.new_string('MULTISITE')])) {
			var_ms_dir = rt.new_string('/sites/' + (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str())
			} else {
			var_ms_dir = rt.new_string('/' + (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str())
			}
			var_dir = rt.concat(var_dir, var_ms_dir)
			var_url = rt.concat(var_url, var_ms_dir)
		} else if rt.is_true(rt.call_function('defined', [rt.new_string('UPLOADS')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ms_is_switched', []rt.PhpVal{}))))) {
			if rt.is_true(rt.call_function('defined', [rt.new_string('BLOGUPLOADDIR')])) {
			var_dir = rt.call_function('untrailingslashit', [rt.get_constant('BLOGUPLOADDIR')])
			} else {
			var_dir = rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('UPLOADS')).str())
			}
		var_url = rt.new_string((rt.call_function('trailingslashit', [var_siteurl.clone()])).str() + 'files')
		}
	}
	var_basedir = var_dir.clone()
	var_baseurl = var_url.clone()
	var_subdir = ''
	if rt.is_true(rt.call_function('get_option', [rt.new_string('uploads_use_yearmonth_folders')])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_time)))) {
		var_time = current_time('mysql', false)
		}
	var_y = rt.call_function('substr', [var_time.clone(), rt.new_int(0), rt.new_int(4)])
	var_m = rt.call_function('substr', [var_time.clone(), rt.new_int(5), rt.new_int(2)])
	var_subdir = "/${var_y.to_string()}/${var_m.to_string()}"
	}
	var_dir = rt.concat(var_dir, rt.new_string((var_subdir).str()))
	var_url = rt.concat(var_url, rt.new_string((var_subdir).str()))
	return rt.create_array([rt.ArrayItem{ key: 'path', val: var_dir }, rt.ArrayItem{ key: 'url', val: var_url }, rt.ArrayItem{ key: 'subdir', val: var_subdir }, rt.ArrayItem{ key: 'basedir', val: var_basedir }, rt.ArrayItem{ key: 'baseurl', val: var_baseurl }, rt.ArrayItem{ key: 'error', val: false }])
}

fn wp_unique_filename(var_dir rt.PhpVal, var_filename_arg rt.PhpVal, var_unique_filename_callback rt.PhpVal) rt.PhpVal {
	mut var_filename := var_filename_arg
	mut var_number := rt.new_null()
	mut var_alt_filenames := rt.new_null()
	mut var_ext := rt.new_null()
	mut var_name := rt.new_null()
	mut var_fname := rt.new_null()
	mut var_file_type := rt.new_null()
	mut var_mime_type := rt.new_null()
	mut var_is_image := false
	mut var_upload_dir := rt.new_null()
	mut var_lc_filename := rt.new_null()
	mut var_lc_ext := ''
	mut var__dir := rt.new_null()
	mut var_new_number := rt.new_null()
	mut var_files := rt.new_null()
	mut var_count := i64(0)
	mut var_i := i64(0)
	mut var_output_formats := rt.new_null()
	mut var_alt_types := rt.new_null()
	mut var_alt_mime_type := rt.new_null()
	mut var_alt_type := rt.new_null()
	mut var_alt_ext := rt.new_null()
	mut var_alt_filename := rt.new_null()
	var_filename = rt.call_function('sanitize_file_name', [var_filename.clone()])
	var_number = rt.new_string('')
	var_alt_filenames = []rt.PhpVal{}
	var_ext = rt.call_function('pathinfo', [var_filename.clone(), rt.get_constant('PATHINFO_EXTENSION')])
	var_name = rt.call_function('pathinfo', [var_filename.clone(), rt.get_constant('PATHINFO_BASENAME')])
	if rt.is_true(var_ext) {
	var_ext = rt.new_string('.' + (var_ext).str())
	}
	if rt.is_true(rt.identical(var_name, var_ext)) {
	var_name = rt.new_string('')
	}
	if rt.is_true(var_unique_filename_callback) && rt.call_function('is_callable', [var_unique_filename_callback.clone()]) {
	var_filename = rt.call_function('call_user_func', [var_unique_filename_callback.clone(), var_dir.clone(), var_name.clone(), var_ext.clone()])
	} else {
		var_fname = rt.call_function('pathinfo', [var_filename.clone(), rt.get_constant('PATHINFO_FILENAME')])
		if rt.is_true(var_fname) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/-(?:\\d+x\\d+|scaled|rotated)$/'), var_fname.clone()])) {
		var_number = rt.new_int(1)
		var_filename = rt.call_function('str_replace', [rt.new_string("${var_fname.to_string()}${var_ext.to_string()}"), rt.new_string("${var_fname.to_string()}-${var_number.to_string()}${var_ext.to_string()}"), var_filename.clone()])
		}
		var_file_type = wp_check_filetype(var_filename.clone(), rt.new_null())
		var_mime_type = var_file_type.array_get(rt.new_string('type'))
		var_is_image = !(!rt.is_true(var_mime_type)) && rt.is_true(rt.call_function('str_starts_with', [var_mime_type.clone(), rt.new_string('image/')]))
		var_upload_dir = wp_get_upload_dir()
		var_lc_filename = rt.new_null()
		var_lc_ext = var_ext.clone().to_string().to_lower()
		var__dir = rt.call_function('trailingslashit', [var_dir.clone()])
		if rt.is_true(var_ext) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string((var_lc_ext).str()), var_ext)))) {
		var_lc_filename = rt.call_function('preg_replace', [rt.new_string('|' + (rt.call_function('preg_quote', [var_ext.clone()])).str() + '$|'), rt.new_string((var_lc_ext).str()).clone(), var_filename.clone()])
		}
		for rt.is_true(rt.call_function('file_exists', [rt.new_string((var__dir).str() + (var_filename).str())])) || (rt.is_true(var_lc_filename) && rt.is_true(rt.call_function('file_exists', [rt.new_string((var__dir).str() + (var_lc_filename).str())]))) {
			var_new_number = rt.new_int((var_number).to_i64()) + 1
			if rt.is_true(var_lc_filename) {
			var_lc_filename = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: "-${var_number.to_string()}${var_lc_ext}" }, rt.ArrayItem{ key: none, val: "${var_number.to_string()}${var_lc_ext}" }]), rt.new_string("-${var_new_number.to_string()}${var_lc_ext}"), var_lc_filename.clone()])
			}
			if rt.is_true(rt.identical(rt.new_string(''), rt.new_string("${var_number.to_string()}${var_ext.to_string()}"))) {
			var_filename = rt.new_string("${var_filename.to_string()}-${var_new_number.to_string()}")
			} else {
			var_filename = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: "-${var_number.to_string()}${var_ext.to_string()}" }, rt.ArrayItem{ key: none, val: "${var_number.to_string()}${var_ext.to_string()}" }]), rt.new_string("-${var_new_number.to_string()}${var_ext.to_string()}"), var_filename.clone()])
			}
		var_number = var_new_number.clone()
		}
		if rt.is_true(var_lc_filename) {
		var_filename = var_lc_filename.clone()
		}
		var_files = []rt.PhpVal{}
		var_count = 10000
		if rt.is_true(var_name) && rt.is_true(var_ext) && rt.is_true(rt.call_function('is_dir', [var_dir.clone()])) && rt.is_true(rt.call_function('str_contains', [var_dir.clone(), var_upload_dir.array_get(rt.new_string('basedir'))])) {
			var_files = rt.call_function('apply_filters', [rt.new_string('pre_wp_unique_filename_file_list'), rt.new_null(), var_dir.clone(), var_filename.clone()])
			if rt.is_true(rt.identical(rt.new_null(), var_files)) {
			var_files = rt.call_function('scandir', [var_dir.clone()])
			}
			if !(!rt.is_true(var_files)) {
			var_files = rt.call_function('array_diff', [var_files.clone(), rt.create_array([rt.ArrayItem{ key: none, val: '.' }, rt.ArrayItem{ key: none, val: '..' }])])
			}
			if !(!rt.is_true(var_files)) {
				var_count = var_files.clone().array_count()
				var_i = 0
				for var_i <= var_count && _wp_check_existing_file_names(var_filename.clone(), var_files.clone()) {
					var_new_number = rt.new_int((var_number).to_i64()) + 1
					var_filename = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: "-${var_number.to_string()}${var_lc_ext}" }, rt.ArrayItem{ key: none, val: "${var_number.to_string()}${var_lc_ext}" }]), rt.new_string("-${var_new_number.to_string()}${var_lc_ext}"), var_filename.clone()])
					var_number = var_new_number.clone()
					var_i += 1
				}
			}
		}
		if var_is_image {
			var_output_formats = rt.call_function('wp_get_image_editor_output_format', [rt.new_string((var__dir).str() + (var_filename).str()), var_mime_type.clone()])
			var_alt_types = []rt.PhpVal{}
			if !(!rt.is_true(var_output_formats.array_get(var_mime_type))) {
				var_alt_mime_type = var_output_formats.array_get(var_mime_type)
				var_alt_types = rt.func_array_keys(rt.call_function('array_intersect', [var_output_formats.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_mime_type }, rt.ArrayItem{ key: none, val: var_alt_mime_type }])]))
				var_alt_types.array_push(var_alt_mime_type.clone())
			} else if !(!rt.is_true(var_output_formats)) {
			var_alt_types = rt.func_array_keys(rt.call_function('array_intersect', [var_output_formats.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_mime_type }])]))
			}
			var_alt_types = rt.call_function('array_unique', [rt.call_function('array_diff', [var_alt_types.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_mime_type }])])])
			mut iter_18 := var_alt_types.iterator()
			for {
				item_18 := iter_18.next() or { break }
				mut var_alt_type_shadow := item_18.val
				var_alt_ext = rt.new_bool(wp_get_default_extension_for_mime_type(var_alt_type_shadow.clone()))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_alt_ext)))) {
					continue
				}
				var_alt_ext = rt.new_string(".${var_alt_ext.to_string()}")
				var_alt_filename = rt.call_function('preg_replace', [rt.new_string('|' + (rt.call_function('preg_quote', [rt.new_string((var_lc_ext).str()).clone()])).str() + '$|'), var_alt_ext.clone(), var_filename.clone()])
				var_alt_filenames.array_set(var_alt_ext, var_alt_filename.clone())
			}
			if !(!rt.is_true(var_alt_filenames)) {
				var_alt_filenames.array_set(var_lc_ext, var_filename.clone())
				var_i = 0
				for var_i <= var_count && _wp_check_alternate_file_names(var_alt_filenames.clone(), var__dir.clone(), var_files.clone()) {
					var_new_number = rt.new_int((var_number).to_i64()) + 1
					mut iter_19 := var_alt_filenames.iterator()
					for {
						item_19 := iter_19.next() or { break }
						mut var_alt_filename_shadow := item_19.val
						mut var_alt_ext_shadow := item_19.key
						var_alt_filenames.array_set(var_alt_ext_shadow, rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: "-${var_number.to_string()}${var_alt_ext.to_string()}" }, rt.ArrayItem{ key: none, val: "${var_number.to_string()}${var_alt_ext.to_string()}" }]), rt.new_string("-${var_new_number.to_string()}${var_alt_ext.to_string()}"), var_alt_filename_shadow.clone()]))
					}
					var_filename = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: "-${var_number.to_string()}${var_lc_ext}" }, rt.ArrayItem{ key: none, val: "${var_number.to_string()}${var_lc_ext}" }]), rt.new_string("-${var_new_number.to_string()}${var_lc_ext}"), var_filename.clone()])
					var_number = var_new_number.clone()
					var_i += 1
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_unique_filename'), var_filename.clone(), var_ext.clone(), var_dir.clone(), var_unique_filename_callback.clone(), var_alt_filenames.clone(), var_number.clone()])
}

fn _wp_check_alternate_file_names(var_filenames rt.PhpVal, var_dir rt.PhpVal, var_files rt.PhpVal) bool {
	mut var_filename := rt.new_null()
	mut iter_20 := var_filenames.iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_filename_shadow := item_20.val
		if rt.is_true(rt.call_function('file_exists', [rt.new_string((var_dir).str() + (var_filename_shadow).str())])) {
			return true
		}
		if !(!rt.is_true(var_files)) && _wp_check_existing_file_names(var_filename_shadow.clone(), var_files.clone()) {
			return true
		}
	}
	return false
}

fn _wp_check_existing_file_names(var_filename rt.PhpVal, var_files rt.PhpVal) bool {
	mut var_fname := rt.new_null()
	mut var_ext := rt.new_null()
	mut var_regex := rt.new_null()
	mut var_file := rt.new_null()
	var_fname = rt.call_function('pathinfo', [var_filename.clone(), rt.get_constant('PATHINFO_FILENAME')])
	var_ext = rt.call_function('pathinfo', [var_filename.clone(), rt.get_constant('PATHINFO_EXTENSION')])
	if !rt.is_true(var_fname) {
		return false
	}
	if rt.is_true(var_ext) {
	var_ext = rt.new_string(".${var_ext.to_string()}")
	}
	var_regex = rt.new_string('/^' + (rt.call_function('preg_quote', [var_fname.clone()])).str() + '-(?:\\d+x\\d+|scaled|rotated)' + (rt.call_function('preg_quote', [var_ext.clone()])).str() + '$/i')
	mut iter_21 := var_files.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_file_shadow := item_21.val
		if rt.is_true(rt.call_function('preg_match', [var_regex.clone(), var_file_shadow.clone()])) {
			return true
		}
	}
	return false
}

fn wp_upload_bits(var_name rt.PhpVal, var_deprecated rt.PhpVal, var_bits rt.PhpVal, var_time rt.PhpVal) rt.PhpVal {
	mut var_wp_filetype := rt.new_null()
	mut var_upload := rt.new_null()
	mut var_upload_bits_error := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_new_file := rt.new_null()
	mut var_error_path := rt.new_null()
	mut var_message := rt.new_null()
	mut var_ifp := rt.new_null()
	mut var_stat := rt.new_null()
	mut var_perms := rt.new_null()
	mut var_url := rt.new_null()
	if !(!rt.is_true(var_deprecated)) {
		_deprecated_argument(rt.new_string(@FN), '2.0.0', '')
	}
	if !rt.is_true(var_name) {
		return rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_function('__', [rt.new_string('Empty filename')]) }])
	}
	var_wp_filetype = wp_check_filetype(var_name.clone(), rt.new_null())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_filetype.array_get(rt.new_string('ext')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_upload')]))))) {
		return rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_function('__', [rt.new_string('Sorry, you are not allowed to upload this file type.')]) }])
	}
	var_upload = wp_upload_dir(var_time.clone(), false, false)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_upload.array_get(rt.new_string('error')))))) {
		return var_upload.clone()
	}
	var_upload_bits_error = rt.call_function('apply_filters', [rt.new_string('wp_upload_bits'), rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'bits', val: var_bits }, rt.ArrayItem{ key: 'time', val: var_time }])])
	if !(var_upload_bits_error.clone().is_array()) {
		var_upload.array_set('error', var_upload_bits_error.clone())
		return var_upload.clone()
	}
	var_filename = wp_unique_filename(var_upload.array_get(rt.new_string('path')), var_name.clone(), rt.new_null())
	var_new_file = rt.new_string((var_upload.array_get(rt.new_string('path'))).str() + "/${var_filename.to_string()}")
	if !(wp_mkdir_p(rt.call_function('dirname', [var_new_file.clone()]))) {
		if rt.is_true(rt.call_function('str_starts_with', [var_upload.array_get(rt.new_string('basedir')), rt.get_constant('ABSPATH')])) {
		var_error_path = rt.new_string((rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), var_upload.array_get(rt.new_string('basedir'))])).str() + (var_upload.array_get(rt.new_string('subdir'))).str())
		} else {
		var_error_path = rt.new_string((rt.call_function('wp_basename', [var_upload.array_get(rt.new_string('basedir'))])).str() + (var_upload.array_get(rt.new_string('subdir'))).str())
		}
		var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to create directory %s. Is its parent directory writable by the server?')]), var_error_path.clone()])
		return rt.create_array([rt.ArrayItem{ key: 'error', val: var_message }])
	}
	var_ifp = rt.call_function('fopen', [var_new_file.clone(), rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ifp)))) {
		return rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not write file %s')]), var_new_file.clone()]) }])
	}
	rt.call_function('fwrite', [var_ifp.clone(), var_bits.clone()])
	rt.call_function('fclose', [var_ifp.clone()])
	rt.call_function('clearstatcache', []rt.PhpVal{})
	var_stat = rt.call_function('stat', [rt.call_function('dirname', [var_new_file.clone()])])
	var_perms = rt.new_int(rt.bitwise_and(var_stat.array_get(rt.new_string('mode')), rt.new_int(4095)))
	var_perms = rt.new_int(rt.bitwise_and(var_perms, rt.new_int(438)))
	rt.call_function('chmod', [var_new_file.clone(), var_perms.clone()])
	rt.call_function('clearstatcache', []rt.PhpVal{})
	var_url = rt.new_string((var_upload.array_get(rt.new_string('url'))).str() + "/${var_filename.to_string()}")
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		clean_dirsize_cache(var_new_file.clone())
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_handle_upload'), rt.create_array([rt.ArrayItem{ key: 'file', val: var_new_file }, rt.ArrayItem{ key: 'url', val: var_url }, rt.ArrayItem{ key: 'type', val: var_wp_filetype.array_get(rt.new_string('type')) }, rt.ArrayItem{ key: 'error', val: false }]), rt.new_string('sideload')])
}

fn wp_ext2type(var_ext_arg rt.PhpVal) rt.PhpVal {
	mut var_ext := var_ext_arg
	mut var_ext2type := rt.new_null()
	mut var_exts := rt.new_null()
	mut var_type := rt.new_null()
	var_ext = var_ext.to_lower()
	var_ext2type = wp_get_ext_types()
	mut iter_22 := var_ext2type.iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_exts_shadow := item_22.val
		mut var_type_shadow := item_22.key
		if rt.is_true(rt.call_function('in_array', [rt.new_string((var_ext).str()).clone(), var_exts_shadow.clone(), rt.new_bool(true)])) {
			return var_type_shadow.clone()
		}
	}
	return rt.new_null()
}

fn wp_get_default_extension_for_mime_type(var_mime_type rt.PhpVal) bool {
	mut var_extensions := rt.new_null()
	var_extensions = rt.call_function('explode', [rt.new_string('|'), rt.call_function('array_search', [var_mime_type.clone(), wp_get_mime_types(), rt.new_bool(true)])])
	if !rt.is_true(var_extensions.array_get(rt.new_int(0))) {
		return false
	}
	return (var_extensions.array_get(rt.new_int(0))).to_bool()
}

fn wp_check_filetype(var_filename rt.PhpVal, var_mimes_arg rt.PhpVal) rt.PhpVal {
	mut var_mimes := var_mimes_arg
	mut var_ext_matches := []rt.PhpVal{}
	mut var_type := rt.new_null()
	mut var_ext := rt.new_null()
	mut var_mime_match := rt.new_null()
	mut var_ext_preg := rt.new_null()
	if !rt.is_true(var_mimes) {
	var_mimes = get_allowed_mime_types(rt.new_null())
	}
	var_type = rt.new_bool(false)
	var_ext = rt.new_bool(false)
	mut iter_23 := var_mimes.iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_mime_match_shadow := item_23.val
		mut var_ext_preg_shadow := item_23.key
		var_ext_preg_shadow = rt.new_string('!\\.(' + (var_ext_preg_shadow).str() + ')$!i')
		if rt.is_true(rt.call_function('preg_match', [var_ext_preg_shadow.clone(), var_filename.clone(), rt.create_array_from_list(var_ext_matches)])) {
			var_type = var_mime_match_shadow
			var_ext = var_ext_matches[1]
			break
		}
	}
	return rt.call_function('compact', [rt.new_string('ext'), rt.new_string('type')])
}

fn wp_check_filetype_and_ext(var_file rt.PhpVal, var_filename rt.PhpVal, var_mimes rt.PhpVal) rt.PhpVal {
	mut var_proper_filename := rt.new_null()
	mut var_wp_filetype := rt.new_null()
	mut var_ext := rt.new_null()
	mut var_type := rt.new_null()
	mut var_real_mime := rt.new_null()
	mut var_heic_images_extensions := []rt.PhpVal{}
	mut var_mime_to_ext := rt.new_null()
	mut var_filename_parts := rt.new_null()
	mut var_new_filename := rt.new_null()
	mut var_finfo := rt.new_null()
	mut var_google_docs_types := []rt.PhpVal{}
	mut var_google_docs_type := rt.new_null()
	mut var_nonspecific_types := []rt.PhpVal{}
	mut var_allowed := rt.new_null()
	var_proper_filename = rt.new_bool(false)
	var_wp_filetype = wp_check_filetype(var_filename.clone(), var_mimes.clone())
	var_ext = var_wp_filetype.array_get(rt.new_string('ext'))
	var_type = var_wp_filetype.array_get(rt.new_string('type'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_file.clone()]))))) {
		return rt.call_function('compact', [rt.new_string('ext'), rt.new_string('type'), rt.new_string('proper_filename')])
	}
	var_real_mime = rt.new_bool(false)
	if rt.is_true(var_type) && rt.is_true(rt.call_function('str_starts_with', [var_type.clone(), rt.new_string('image/')])) {
		var_real_mime = rt.new_bool(wp_get_image_mime(var_file.clone()))
		var_heic_images_extensions = ['heif', 'heics', 'heifs']
		if rt.is_true(var_real_mime) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_real_mime, var_type)))) || rt.is_true(rt.call_function('in_array', [var_ext.clone(), rt.create_array_from_list(var_heic_images_extensions), rt.new_bool(true)])) {
			var_mime_to_ext = rt.call_function('apply_filters', [rt.new_string('getimagesize_mimes_to_exts'), rt.create_array([rt.ArrayItem{ key: 'image/jpeg', val: 'jpg' }, rt.ArrayItem{ key: 'image/png', val: 'png' }, rt.ArrayItem{ key: 'image/gif', val: 'gif' }, rt.ArrayItem{ key: 'image/bmp', val: 'bmp' }, rt.ArrayItem{ key: 'image/tiff', val: 'tif' }, rt.ArrayItem{ key: 'image/webp', val: 'webp' }, rt.ArrayItem{ key: 'image/avif', val: 'avif' }, rt.ArrayItem{ key: 'image/heic', val: 'heic' }, rt.ArrayItem{ key: 'image/heif', val: 'heic' }, rt.ArrayItem{ key: 'image/heic-sequence', val: 'heic' }, rt.ArrayItem{ key: 'image/heif-sequence', val: 'heic' }])])
			if !(!rt.is_true(var_mime_to_ext.array_get(var_real_mime))) {
				var_filename_parts = rt.call_function('explode', [rt.new_string('.'), var_filename.clone()])
				rt.call_function('array_pop', [var_filename_parts.clone()])
				var_filename_parts.array_push(var_mime_to_ext.array_get(var_real_mime))
				var_new_filename = rt.call_function('implode', [rt.new_string('.'), var_filename_parts.clone()])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_filename, var_filename)))) {
				var_proper_filename = var_new_filename.clone()
				}
			var_wp_filetype = wp_check_filetype(var_new_filename.clone(), var_mimes.clone())
			var_ext = var_wp_filetype.array_get(rt.new_string('ext'))
			var_type = var_wp_filetype.array_get(rt.new_string('type'))
			} else {
			var_real_mime = rt.new_bool(false)
			}
		}
	}
	if rt.is_true(var_type) && rt.is_true(rt.new_bool(!(rt.is_true(var_real_mime)))) && rt.is_true(rt.call_function('extension_loaded', [rt.new_string('fileinfo')])) {
		var_finfo = rt.call_function('finfo_open', [rt.get_constant('FILEINFO_MIME_TYPE')])
		var_real_mime = rt.call_function('finfo_file', [var_finfo.clone(), var_file.clone()])
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80100))) {
			rt.call_function('finfo_close', [var_finfo.clone()])
		}
		var_google_docs_types = ['application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet']
		for var_google_docs_type_shadow in var_google_docs_types {
			if rt.is_true(rt.identical(rt.new_int(2), rt.call_function('substr_count', [var_real_mime.clone(), rt.new_string((var_google_docs_type_shadow).str()).clone()]))) {
			var_real_mime = rt.new_string((var_google_docs_type_shadow).str())
			}
		}
		var_nonspecific_types = ['application/octet-stream', 'application/encrypted', 'application/CDFV2-encrypted', 'application/zip']
		if rt.is_true(rt.call_function('in_array', [var_real_mime.clone(), rt.create_array_from_list(var_nonspecific_types), rt.new_bool(true)])) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_function('substr', [var_type.clone(), rt.new_int(0), rt.call_function('strcspn', [var_type.clone(), rt.new_string('/')])]), rt.create_array([rt.ArrayItem{ key: none, val: 'application' }, rt.ArrayItem{ key: none, val: 'video' }, rt.ArrayItem{ key: none, val: 'audio' }]), rt.new_bool(true)]))))) {
			var_type = rt.new_bool(false)
			var_ext = rt.new_bool(false)
			}
		} else if rt.is_true(rt.call_function('str_starts_with', [var_real_mime.clone(), rt.new_string('video/')])) || rt.is_true(rt.call_function('str_starts_with', [var_real_mime.clone(), rt.new_string('audio/')])) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('substr', [var_real_mime.clone(), rt.new_int(0), rt.call_function('strcspn', [var_real_mime.clone(), rt.new_string('/')])]), rt.call_function('substr', [var_type.clone(), rt.new_int(0), rt.call_function('strcspn', [var_type.clone(), rt.new_string('/')])]))))) {
			var_type = rt.new_bool(false)
			var_ext = rt.new_bool(false)
			}
		} else if rt.is_true(rt.identical(rt.new_string('text/plain'), var_real_mime)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_type.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'text/plain' }, rt.ArrayItem{ key: none, val: 'text/csv' }, rt.ArrayItem{ key: none, val: 'application/csv' }, rt.ArrayItem{ key: none, val: 'text/richtext' }, rt.ArrayItem{ key: none, val: 'text/tsv' }, rt.ArrayItem{ key: none, val: 'text/vtt' }]), rt.new_bool(true)]))))) {
			var_type = rt.new_bool(false)
			var_ext = rt.new_bool(false)
			}
		} else if rt.is_true(rt.identical(rt.new_string('application/csv'), var_real_mime)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_type.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'text/csv' }, rt.ArrayItem{ key: none, val: 'text/plain' }, rt.ArrayItem{ key: none, val: 'application/csv' }]), rt.new_bool(true)]))))) {
			var_type = rt.new_bool(false)
			var_ext = rt.new_bool(false)
			}
		} else if rt.is_true(rt.identical(rt.new_string('text/rtf'), var_real_mime)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_type.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'text/rtf' }, rt.ArrayItem{ key: none, val: 'text/plain' }, rt.ArrayItem{ key: none, val: 'application/rtf' }]), rt.new_bool(true)]))))) {
			var_type = rt.new_bool(false)
			var_ext = rt.new_bool(false)
			}
		} else {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_type, var_real_mime)))) {
			var_type = rt.new_bool(false)
			var_ext = rt.new_bool(false)
			}
		}
	}
	if rt.is_true(var_type) {
		var_allowed = get_allowed_mime_types(rt.new_null())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_type.clone(), var_allowed.clone(), rt.new_bool(true)]))))) {
		var_type = rt.new_bool(false)
		var_ext = rt.new_bool(false)
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_check_filetype_and_ext'), rt.call_function('compact', [rt.new_string('ext'), rt.new_string('type'), rt.new_string('proper_filename')]), var_file.clone(), var_filename.clone(), var_mimes.clone(), var_real_mime.clone()])
}

fn wp_get_image_mime(var_file rt.PhpVal) bool {
	mut var_imagetype := rt.new_null()
	mut var_mime := rt.new_null()
	mut var_imagesize := rt.new_null()
	mut var_magic := rt.new_null()
	mut var_fileinfo := rt.new_null()
	mut var_mime_type := rt.new_null()
	mut var_e := rt.new_null()
	if rt.is_true(rt.call_function('is_callable', [rt.new_string('exif_imagetype')])) {
		var_imagetype = rt.call_function('exif_imagetype', [var_file.clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_mime = if rt.is_true(var_imagetype) { rt.call_function('image_type_to_mime_type', [var_imagetype.clone()]) } else { rt.new_bool(false) }
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else if rt.is_true(rt.call_function('function_exists', [rt.new_string('getimagesize')])) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')])) && rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')]))))) {
			var_imagesize = rt.call_function('getimagesize', [var_file.clone()])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		} else {
			var_imagesize = rt.call_function('getimagesize', [var_file.clone()])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_mime = if !(var_imagesize.array_get(rt.new_string('mime'))).is_null() { var_imagesize.array_get(rt.new_string('mime')) } else { rt.new_bool(false) }
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		var_mime = rt.new_bool(false)
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_mime)))) {
		return (var_mime).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_magic = rt.call_function('file_get_contents', [var_file.clone(), rt.new_bool(false), rt.new_null(), rt.new_int(0), rt.new_int(12)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.identical(rt.new_bool(false), var_magic)) {
		return false
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_magic = rt.call_function('bin2hex', [var_magic.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('str_starts_with', [var_magic.clone(), rt.new_string('52494646')])) && rt.is_true(rt.identical(rt.new_int(16), rt.call_function('strpos', [var_magic.clone(), rt.new_string('57454250')]))) {
		var_mime = rt.new_string('image/webp')
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_magic = rt.call_function('str_split', [var_magic.clone(), rt.new_int(8)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if var_magic.array_isset(rt.new_int(1)) && var_magic.array_isset(rt.new_int(2)) && rt.is_true(rt.identical(rt.new_string('ftyp'), rt.call_function('hex2bin', [var_magic.array_get(rt.new_int(1))]))) {
		if rt.is_true(rt.identical(rt.new_string('avif'), rt.call_function('hex2bin', [var_magic.array_get(rt.new_int(2))]))) || rt.is_true(rt.identical(rt.new_string('avis'), rt.call_function('hex2bin', [var_magic.array_get(rt.new_int(2))]))) {
			var_mime = rt.new_string('image/avif')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		} else if rt.is_true(rt.identical(rt.new_string('heic'), rt.call_function('hex2bin', [var_magic.array_get(rt.new_int(2))]))) {
			var_mime = rt.new_string('image/heic')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		} else if rt.is_true(rt.identical(rt.new_string('heif'), rt.call_function('hex2bin', [var_magic.array_get(rt.new_int(2))]))) {
			var_mime = rt.new_string('image/heif')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		} else {
			if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('fileinfo')])) {
				var_fileinfo = rt.call_function('finfo_open', [rt.get_constant('FILEINFO_MIME_TYPE')])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				var_mime_type = rt.call_function('finfo_file', [var_fileinfo.clone(), var_file.clone()])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80100))) {
					rt.call_function('finfo_close', [var_fileinfo.clone()])
					if rt.has_exception() { unsafe { goto catch_label_1 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				if rt.is_true(wp_is_heic_image_mime_type(var_mime_type.clone())) {
					var_mime = var_mime_type.clone()
					if rt.has_exception() { unsafe { goto catch_label_1 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		var_e = var_e_1.clone()
		var_mime = rt.new_bool(false)
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return (var_mime).to_bool()
}

fn wp_get_mime_types() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('mime_types'), rt.create_array([rt.ArrayItem{ key: 'jpg|jpeg|jpe', val: 'image/jpeg' }, rt.ArrayItem{ key: 'gif', val: 'image/gif' }, rt.ArrayItem{ key: 'png', val: 'image/png' }, rt.ArrayItem{ key: 'bmp', val: 'image/bmp' }, rt.ArrayItem{ key: 'tiff|tif', val: 'image/tiff' }, rt.ArrayItem{ key: 'webp', val: 'image/webp' }, rt.ArrayItem{ key: 'avif', val: 'image/avif' }, rt.ArrayItem{ key: 'ico', val: 'image/x-icon' }, rt.ArrayItem{ key: 'heic', val: 'image/heic' }, rt.ArrayItem{ key: 'heif', val: 'image/heif' }, rt.ArrayItem{ key: 'heics', val: 'image/heic-sequence' }, rt.ArrayItem{ key: 'heifs', val: 'image/heif-sequence' }, rt.ArrayItem{ key: 'asf|asx', val: 'video/x-ms-asf' }, rt.ArrayItem{ key: 'wmv', val: 'video/x-ms-wmv' }, rt.ArrayItem{ key: 'wmx', val: 'video/x-ms-wmx' }, rt.ArrayItem{ key: 'wm', val: 'video/x-ms-wm' }, rt.ArrayItem{ key: 'avi', val: 'video/avi' }, rt.ArrayItem{ key: 'divx', val: 'video/divx' }, rt.ArrayItem{ key: 'flv', val: 'video/x-flv' }, rt.ArrayItem{ key: 'mov|qt', val: 'video/quicktime' }, rt.ArrayItem{ key: 'mpeg|mpg|mpe', val: 'video/mpeg' }, rt.ArrayItem{ key: 'mp4|m4v', val: 'video/mp4' }, rt.ArrayItem{ key: 'ogv', val: 'video/ogg' }, rt.ArrayItem{ key: 'webm', val: 'video/webm' }, rt.ArrayItem{ key: 'mkv', val: 'video/x-matroska' }, rt.ArrayItem{ key: '3gp|3gpp', val: 'video/3gpp' }, rt.ArrayItem{ key: '3g2|3gp2', val: 'video/3gpp2' }, rt.ArrayItem{ key: 'txt|asc|c|cc|h|srt', val: 'text/plain' }, rt.ArrayItem{ key: 'csv', val: 'text/csv' }, rt.ArrayItem{ key: 'tsv', val: 'text/tab-separated-values' }, rt.ArrayItem{ key: 'ics', val: 'text/calendar' }, rt.ArrayItem{ key: 'rtx', val: 'text/richtext' }, rt.ArrayItem{ key: 'css', val: 'text/css' }, rt.ArrayItem{ key: 'htm|html', val: 'text/html' }, rt.ArrayItem{ key: 'vtt', val: 'text/vtt' }, rt.ArrayItem{ key: 'dfxp', val: 'application/ttaf+xml' }, rt.ArrayItem{ key: 'mp3|m4a|m4b', val: 'audio/mpeg' }, rt.ArrayItem{ key: 'aac', val: 'audio/aac' }, rt.ArrayItem{ key: 'ra|ram', val: 'audio/x-realaudio' }, rt.ArrayItem{ key: 'wav|x-wav', val: 'audio/wav' }, rt.ArrayItem{ key: 'ogg|oga', val: 'audio/ogg' }, rt.ArrayItem{ key: 'flac', val: 'audio/flac' }, rt.ArrayItem{ key: 'mid|midi', val: 'audio/midi' }, rt.ArrayItem{ key: 'wma', val: 'audio/x-ms-wma' }, rt.ArrayItem{ key: 'wax', val: 'audio/x-ms-wax' }, rt.ArrayItem{ key: 'mka', val: 'audio/x-matroska' }, rt.ArrayItem{ key: 'rtf', val: 'application/rtf' }, rt.ArrayItem{ key: 'js', val: 'application/javascript' }, rt.ArrayItem{ key: 'pdf', val: 'application/pdf' }, rt.ArrayItem{ key: 'swf', val: 'application/x-shockwave-flash' }, rt.ArrayItem{ key: 'class', val: 'application/java' }, rt.ArrayItem{ key: 'tar', val: 'application/x-tar' }, rt.ArrayItem{ key: 'zip', val: 'application/zip' }, rt.ArrayItem{ key: 'gz|gzip', val: 'application/x-gzip' }, rt.ArrayItem{ key: 'rar', val: 'application/rar' }, rt.ArrayItem{ key: '7z', val: 'application/x-7z-compressed' }, rt.ArrayItem{ key: 'exe', val: 'application/x-msdownload' }, rt.ArrayItem{ key: 'psd', val: 'application/octet-stream' }, rt.ArrayItem{ key: 'xcf', val: 'application/octet-stream' }, rt.ArrayItem{ key: 'doc', val: 'application/msword' }, rt.ArrayItem{ key: 'pot|pps|ppt', val: 'application/vnd.ms-powerpoint' }, rt.ArrayItem{ key: 'wri', val: 'application/vnd.ms-write' }, rt.ArrayItem{ key: 'xla|xls|xlt|xlw', val: 'application/vnd.ms-excel' }, rt.ArrayItem{ key: 'mdb', val: 'application/vnd.ms-access' }, rt.ArrayItem{ key: 'mpp', val: 'application/vnd.ms-project' }, rt.ArrayItem{ key: 'docx', val: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' }, rt.ArrayItem{ key: 'docm', val: 'application/vnd.ms-word.document.macroEnabled.12' }, rt.ArrayItem{ key: 'dotx', val: 'application/vnd.openxmlformats-officedocument.wordprocessingml.template' }, rt.ArrayItem{ key: 'dotm', val: 'application/vnd.ms-word.template.macroEnabled.12' }, rt.ArrayItem{ key: 'xlsx', val: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' }, rt.ArrayItem{ key: 'xlsm', val: 'application/vnd.ms-excel.sheet.macroEnabled.12' }, rt.ArrayItem{ key: 'xlsb', val: 'application/vnd.ms-excel.sheet.binary.macroEnabled.12' }, rt.ArrayItem{ key: 'xltx', val: 'application/vnd.openxmlformats-officedocument.spreadsheetml.template' }, rt.ArrayItem{ key: 'xltm', val: 'application/vnd.ms-excel.template.macroEnabled.12' }, rt.ArrayItem{ key: 'xlam', val: 'application/vnd.ms-excel.addin.macroEnabled.12' }, rt.ArrayItem{ key: 'pptx', val: 'application/vnd.openxmlformats-officedocument.presentationml.presentation' }, rt.ArrayItem{ key: 'pptm', val: 'application/vnd.ms-powerpoint.presentation.macroEnabled.12' }, rt.ArrayItem{ key: 'ppsx', val: 'application/vnd.openxmlformats-officedocument.presentationml.slideshow' }, rt.ArrayItem{ key: 'ppsm', val: 'application/vnd.ms-powerpoint.slideshow.macroEnabled.12' }, rt.ArrayItem{ key: 'potx', val: 'application/vnd.openxmlformats-officedocument.presentationml.template' }, rt.ArrayItem{ key: 'potm', val: 'application/vnd.ms-powerpoint.template.macroEnabled.12' }, rt.ArrayItem{ key: 'ppam', val: 'application/vnd.ms-powerpoint.addin.macroEnabled.12' }, rt.ArrayItem{ key: 'sldx', val: 'application/vnd.openxmlformats-officedocument.presentationml.slide' }, rt.ArrayItem{ key: 'sldm', val: 'application/vnd.ms-powerpoint.slide.macroEnabled.12' }, rt.ArrayItem{ key: 'onetoc|onetoc2|onetmp|onepkg', val: 'application/onenote' }, rt.ArrayItem{ key: 'oxps', val: 'application/oxps' }, rt.ArrayItem{ key: 'xps', val: 'application/vnd.ms-xpsdocument' }, rt.ArrayItem{ key: 'odt', val: 'application/vnd.oasis.opendocument.text' }, rt.ArrayItem{ key: 'odp', val: 'application/vnd.oasis.opendocument.presentation' }, rt.ArrayItem{ key: 'ods', val: 'application/vnd.oasis.opendocument.spreadsheet' }, rt.ArrayItem{ key: 'odg', val: 'application/vnd.oasis.opendocument.graphics' }, rt.ArrayItem{ key: 'odc', val: 'application/vnd.oasis.opendocument.chart' }, rt.ArrayItem{ key: 'odb', val: 'application/vnd.oasis.opendocument.database' }, rt.ArrayItem{ key: 'odf', val: 'application/vnd.oasis.opendocument.formula' }, rt.ArrayItem{ key: 'wp|wpd', val: 'application/wordperfect' }, rt.ArrayItem{ key: 'key', val: 'application/vnd.apple.keynote' }, rt.ArrayItem{ key: 'numbers', val: 'application/vnd.apple.numbers' }, rt.ArrayItem{ key: 'pages', val: 'application/vnd.apple.pages' }])])
}

fn wp_get_ext_types() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('ext2type'), rt.create_array([rt.ArrayItem{ key: 'image', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jpg' }, rt.ArrayItem{ key: none, val: 'jpeg' }, rt.ArrayItem{ key: none, val: 'jpe' }, rt.ArrayItem{ key: none, val: 'gif' }, rt.ArrayItem{ key: none, val: 'png' }, rt.ArrayItem{ key: none, val: 'bmp' }, rt.ArrayItem{ key: none, val: 'tif' }, rt.ArrayItem{ key: none, val: 'tiff' }, rt.ArrayItem{ key: none, val: 'ico' }, rt.ArrayItem{ key: none, val: 'heic' }, rt.ArrayItem{ key: none, val: 'heif' }, rt.ArrayItem{ key: none, val: 'webp' }, rt.ArrayItem{ key: none, val: 'avif' }]) }, rt.ArrayItem{ key: 'audio', val: rt.create_array([rt.ArrayItem{ key: none, val: 'aac' }, rt.ArrayItem{ key: none, val: 'ac3' }, rt.ArrayItem{ key: none, val: 'aif' }, rt.ArrayItem{ key: none, val: 'aiff' }, rt.ArrayItem{ key: none, val: 'flac' }, rt.ArrayItem{ key: none, val: 'm3a' }, rt.ArrayItem{ key: none, val: 'm4a' }, rt.ArrayItem{ key: none, val: 'm4b' }, rt.ArrayItem{ key: none, val: 'mka' }, rt.ArrayItem{ key: none, val: 'mp1' }, rt.ArrayItem{ key: none, val: 'mp2' }, rt.ArrayItem{ key: none, val: 'mp3' }, rt.ArrayItem{ key: none, val: 'ogg' }, rt.ArrayItem{ key: none, val: 'oga' }, rt.ArrayItem{ key: none, val: 'ram' }, rt.ArrayItem{ key: none, val: 'wav' }, rt.ArrayItem{ key: none, val: 'wma' }]) }, rt.ArrayItem{ key: 'video', val: rt.create_array([rt.ArrayItem{ key: none, val: '3g2' }, rt.ArrayItem{ key: none, val: '3gp' }, rt.ArrayItem{ key: none, val: '3gpp' }, rt.ArrayItem{ key: none, val: 'asf' }, rt.ArrayItem{ key: none, val: 'avi' }, rt.ArrayItem{ key: none, val: 'divx' }, rt.ArrayItem{ key: none, val: 'dv' }, rt.ArrayItem{ key: none, val: 'flv' }, rt.ArrayItem{ key: none, val: 'm4v' }, rt.ArrayItem{ key: none, val: 'mkv' }, rt.ArrayItem{ key: none, val: 'mov' }, rt.ArrayItem{ key: none, val: 'mp4' }, rt.ArrayItem{ key: none, val: 'mpeg' }, rt.ArrayItem{ key: none, val: 'mpg' }, rt.ArrayItem{ key: none, val: 'mpv' }, rt.ArrayItem{ key: none, val: 'ogm' }, rt.ArrayItem{ key: none, val: 'ogv' }, rt.ArrayItem{ key: none, val: 'qt' }, rt.ArrayItem{ key: none, val: 'rm' }, rt.ArrayItem{ key: none, val: 'vob' }, rt.ArrayItem{ key: none, val: 'wmv' }]) }, rt.ArrayItem{ key: 'document', val: rt.create_array([rt.ArrayItem{ key: none, val: 'doc' }, rt.ArrayItem{ key: none, val: 'docx' }, rt.ArrayItem{ key: none, val: 'docm' }, rt.ArrayItem{ key: none, val: 'dotm' }, rt.ArrayItem{ key: none, val: 'odt' }, rt.ArrayItem{ key: none, val: 'pages' }, rt.ArrayItem{ key: none, val: 'pdf' }, rt.ArrayItem{ key: none, val: 'xps' }, rt.ArrayItem{ key: none, val: 'oxps' }, rt.ArrayItem{ key: none, val: 'rtf' }, rt.ArrayItem{ key: none, val: 'wp' }, rt.ArrayItem{ key: none, val: 'wpd' }, rt.ArrayItem{ key: none, val: 'psd' }, rt.ArrayItem{ key: none, val: 'xcf' }]) }, rt.ArrayItem{ key: 'spreadsheet', val: rt.create_array([rt.ArrayItem{ key: none, val: 'numbers' }, rt.ArrayItem{ key: none, val: 'ods' }, rt.ArrayItem{ key: none, val: 'xls' }, rt.ArrayItem{ key: none, val: 'xlsx' }, rt.ArrayItem{ key: none, val: 'xlsm' }, rt.ArrayItem{ key: none, val: 'xlsb' }]) }, rt.ArrayItem{ key: 'interactive', val: rt.create_array([rt.ArrayItem{ key: none, val: 'swf' }, rt.ArrayItem{ key: none, val: 'key' }, rt.ArrayItem{ key: none, val: 'ppt' }, rt.ArrayItem{ key: none, val: 'pptx' }, rt.ArrayItem{ key: none, val: 'pptm' }, rt.ArrayItem{ key: none, val: 'pps' }, rt.ArrayItem{ key: none, val: 'ppsx' }, rt.ArrayItem{ key: none, val: 'ppsm' }, rt.ArrayItem{ key: none, val: 'sldx' }, rt.ArrayItem{ key: none, val: 'sldm' }, rt.ArrayItem{ key: none, val: 'odp' }]) }, rt.ArrayItem{ key: 'text', val: rt.create_array([rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'csv' }, rt.ArrayItem{ key: none, val: 'tsv' }, rt.ArrayItem{ key: none, val: 'txt' }]) }, rt.ArrayItem{ key: 'archive', val: rt.create_array([rt.ArrayItem{ key: none, val: 'bz2' }, rt.ArrayItem{ key: none, val: 'cab' }, rt.ArrayItem{ key: none, val: 'dmg' }, rt.ArrayItem{ key: none, val: 'gz' }, rt.ArrayItem{ key: none, val: 'rar' }, rt.ArrayItem{ key: none, val: 'sea' }, rt.ArrayItem{ key: none, val: 'sit' }, rt.ArrayItem{ key: none, val: 'sqx' }, rt.ArrayItem{ key: none, val: 'tar' }, rt.ArrayItem{ key: none, val: 'tgz' }, rt.ArrayItem{ key: none, val: 'zip' }, rt.ArrayItem{ key: none, val: '7z' }]) }, rt.ArrayItem{ key: 'code', val: rt.create_array([rt.ArrayItem{ key: none, val: 'css' }, rt.ArrayItem{ key: none, val: 'htm' }, rt.ArrayItem{ key: none, val: 'html' }, rt.ArrayItem{ key: none, val: 'php' }, rt.ArrayItem{ key: none, val: 'js' }]) }])])
}

fn wp_filesize(var_path rt.PhpVal) i64 {
	mut var_size := rt.new_null()
	var_size = rt.call_function('apply_filters', [rt.new_string('pre_wp_filesize'), rt.new_null(), var_path.clone()])
	if rt.is_true(rt.new_bool(var_size.clone().is_long())) {
		return (var_size).to_i64()
	}
	var_size = rt.new_int(if rt.is_true(rt.call_function('file_exists', [var_path.clone()])) { rt.new_int((rt.call_function('filesize', [var_path.clone()])).to_i64()) } else { 0 })
	return rt.new_int((rt.call_function('apply_filters', [rt.new_string('wp_filesize'), var_size.clone(), var_path.clone()])).to_i64())
}

fn get_allowed_mime_types(var_user rt.PhpVal) rt.PhpVal {
	mut var_t := rt.new_null()
	mut var_unfiltered := rt.new_null()
	var_t = wp_get_mime_types()
	var_t.array_unset(rt.new_string('swf'))
	var_t.array_unset(rt.new_string('exe'))
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('current_user_can')])) {
	var_unfiltered = if rt.is_true(var_user) { rt.call_function('user_can', [var_user.clone(), rt.new_string('unfiltered_html')]) } else { rt.call_function('current_user_can', [rt.new_string('unfiltered_html')]) }
	}
	if !rt.is_true(var_unfiltered) {
		var_t.array_unset(rt.new_string('htm|html'))
		var_t.array_unset(rt.new_string('js'))
	}
	return rt.call_function('apply_filters', [rt.new_string('upload_mimes'), var_t.clone(), var_user.clone()])
}

fn wp_nonce_ays(var_action rt.PhpVal) {
	mut var_title := rt.new_null()
	mut var_response_code := i64(0)
	mut var_redirect_to := rt.new_null()
	mut var_html := rt.new_null()
	mut var_wp_http_referer := rt.new_null()
	var_title = rt.call_function('__', [rt.new_string('An error occurred.')])
	var_response_code = 403
	if rt.is_true(rt.identical(rt.new_string('log-out'), var_action)) {
		var_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You are attempting to log out of %s')]), rt.call_function('get_bloginfo', [rt.new_string('name')])])
		var_redirect_to = if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to'))).is_null() { rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to')) } else { rt.new_string('') }
		var_html = var_title.clone()
		var_html = rt.concat(var_html, rt.new_string('</p><p>'))
		var_html = rt.concat(var_html, rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Do you really want to <a href="%s">log out</a>?')]), rt.call_function('wp_logout_url', [var_redirect_to.clone()])]))
	} else {
		var_html = rt.call_function('__', [rt.new_string('The link you followed has expired.')])
		if rt.is_true(rt.new_bool(wp_get_referer())) {
			var_wp_http_referer = remove_query_arg('updated', wp_get_referer())
			var_wp_http_referer = rt.call_function('wp_validate_redirect', [rt.call_function('sanitize_url', [var_wp_http_referer.clone()])])
			var_html = rt.concat(var_html, rt.new_string('</p><p>'))
			var_html = rt.concat(var_html, rt.call_function('sprintf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [var_wp_http_referer.clone()]), rt.call_function('__', [rt.new_string('Please try again.')])]))
		}
	}
	wp_die(var_html.clone(), var_title.clone(), rt.new_int(var_response_code).clone())
}

fn wp_die(message string, title string, var_args_arg rt.PhpVal) {
	mut var_message := message
	mut var_title := title
	mut var_args := var_args_arg
	mut var_wp_query := rt.new_null()
	mut var_callback := rt.new_null()
	if rt.is_true(rt.new_bool(var_args.clone().is_long())) {
	var_args = rt.create_array([rt.ArrayItem{ key: 'response', val: var_args }])
	} else if rt.is_true(rt.new_bool(rt.new_string((var_title).str()).is_long())) {
	var_args = rt.create_array([rt.ArrayItem{ key: 'response', val: var_title }])
	var_title = ''
	}
	if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
	var_callback = rt.call_function('apply_filters', [rt.new_string('wp_die_ajax_handler'), rt.new_string('_ajax_wp_die_handler')])
	} else if rt.is_true(rt.call_function('wp_is_json_request', []rt.PhpVal{})) {
	var_callback = rt.call_function('apply_filters', [rt.new_string('wp_die_json_handler'), rt.new_string('_json_wp_die_handler')])
	} else if wp_is_serving_rest_request() && rt.is_true(rt.call_function('wp_is_jsonp_request', []rt.PhpVal{})) {
	var_callback = rt.call_function('apply_filters', [rt.new_string('wp_die_jsonp_handler'), rt.new_string('_jsonp_wp_die_handler')])
	} else if rt.is_true(rt.call_function('defined', [rt.new_string('XMLRPC_REQUEST')])) && rt.is_true(rt.get_constant('XMLRPC_REQUEST')) {
	var_callback = rt.call_function('apply_filters', [rt.new_string('wp_die_xmlrpc_handler'), rt.new_string('_xmlrpc_wp_die_handler')])
	} else if rt.is_true(rt.call_function('wp_is_xml_request', []rt.PhpVal{})) || (!(var_wp_query).is_null() && ((rt.is_true(rt.call_function('function_exists', [rt.new_string('is_feed')])) && rt.is_true(rt.call_function('is_feed', []rt.PhpVal{}))) || (rt.is_true(rt.call_function('function_exists', [rt.new_string('is_comment_feed')])) && rt.is_true(rt.call_function('is_comment_feed', []rt.PhpVal{})))) || (rt.is_true(rt.call_function('function_exists', [rt.new_string('is_trackback')])) && rt.is_true(rt.call_function('is_trackback', []rt.PhpVal{})))) {
	var_callback = rt.call_function('apply_filters', [rt.new_string('wp_die_xml_handler'), rt.new_string('_xml_wp_die_handler')])
	} else {
	var_callback = rt.call_function('apply_filters', [rt.new_string('wp_die_handler'), rt.new_string('_default_wp_die_handler')])
	}
	rt.call_function('call_user_func', [var_callback.clone(), rt.new_string(message), rt.new_string((var_title).str()), var_args.clone()])
}

fn _default_wp_die_handler(var_message_arg rt.PhpVal, title string, var_args rt.PhpVal) {
	mut var_title := title
	mut var_message := var_message_arg
	mut var_parsed_args := rt.new_null()
	mut var_have_gettext := rt.new_null()
	mut var_link_url := rt.new_null()
	mut var_link_text := rt.new_null()
	mut var_back_text := rt.new_null()
	mut var_text_direction := rt.new_null()
	mut var_dir_attr := rt.new_null()
	mut list_tmp_6 := _wp_die_process_input(var_message.clone(), var_title, var_args.clone())
	var_message = (list_tmp_6).array_get(0)
	var_title = (list_tmp_6).array_get(1)
	var_parsed_args = (list_tmp_6).array_get(2)
	if rt.is_true(rt.new_bool(var_message.clone().is_string())) {
		if !(!rt.is_true(var_parsed_args.array_get(rt.new_string('additional_errors')))) {
		var_message = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: var_message }]), wp_list_pluck(var_parsed_args.array_get(rt.new_string('additional_errors')), 'message', rt.new_null())])
		var_message = rt.new_string('<ul>\n\t\t<li>' + (rt.call_function('implode', [rt.new_string('</li>\n\t\t<li>'), var_message.clone()])).str() + '</li>\n\t</ul>')
		}
	var_message = rt.call_function('sprintf', [rt.new_string('<div class="wp-die-message">%s</div>'), var_message.clone()])
	}
	var_have_gettext = rt.call_function('function_exists', [rt.new_string('__')])
	if !(!rt.is_true(var_parsed_args.array_get(rt.new_string('link_url')))) && !(!rt.is_true(var_parsed_args.array_get(rt.new_string('link_text')))) {
		var_link_url = var_parsed_args.array_get(rt.new_string('link_url'))
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('esc_url')])) {
		var_link_url = rt.call_function('esc_url', [var_link_url.clone()])
		}
		var_link_text = var_parsed_args.array_get(rt.new_string('link_text'))
		var_message = rt.concat(var_message, rt.new_string("\n<p><a href='${var_link_url.to_string()}'>${var_link_text.to_string()}</a></p>"))
	}
	if var_parsed_args.array_isset(rt.new_string('back_link')) && rt.is_true(var_parsed_args.array_get(rt.new_string('back_link'))) {
		var_back_text = if rt.is_true(var_have_gettext) { rt.call_function('__', [rt.new_string('&laquo; Back')]) } else { rt.new_string('&laquo; Back') }
		var_message = rt.concat(var_message, rt.new_string("\n<p><a href='javascript:history.back()'>${var_back_text.to_string()}</a></p>"))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('admin_head')]))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
			rt.call_function('header', [rt.concat(rt.new_string('Content-Type: text/html; charset='), var_parsed_args.array_get(rt.new_string('charset')))])
			status_header(var_parsed_args.array_get(rt.new_string('response')), '')
			nocache_headers()
		}
		var_text_direction = var_parsed_args.array_get(rt.new_string('text_direction'))
		var_dir_attr = rt.new_string("dir='${var_text_direction.to_string()}'")
		if !rt.is_true(var_args.array_get(rt.new_string('text_direction'))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('language_attributes')])) && rt.is_true(rt.call_function('function_exists', [rt.new_string('is_rtl')])) {
		var_dir_attr = rt.call_function('get_language_attributes', []rt.PhpVal{})
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_dir_attr)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_parsed_args.array_get(rt.new_string('charset')))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_robots')])) && rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_robots_no_robots')])) && rt.is_true(rt.call_function('function_exists', [rt.new_string('add_filter')])) {
			rt.call_function('add_filter', [rt.new_string('wp_robots'), rt.new_string('wp_robots_no_robots')])
			rt.call_function('remove_filter', [rt.new_string('wp_robots'), rt.new_string('wp_robots_noindex_embeds')])
			rt.call_function('remove_filter', [rt.new_string('wp_robots'), rt.new_string('wp_robots_noindex_search')])
			rt.call_function('wp_robots', []rt.PhpVal{})
		}
		// unsupported statement: Stmt_InlineHTML
		print(var_title)
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('rtl'), var_text_direction)) {
			print('body { font-family: Tahoma, Arial; }')
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_message)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_parsed_args.array_get(rt.new_string('exit'))) {
		exit(0)
	}
}

fn _ajax_wp_die_handler(var_message_arg rt.PhpVal, title string, var_args_arg rt.PhpVal) {
	mut var_title := title
	mut var_message := var_message_arg
	mut var_args := var_args_arg
	mut var_parsed_args := rt.new_null()
	var_args = wp_parse_args(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'response', val: 200 }]))
	mut list_tmp_7 := _wp_die_process_input(var_message.clone(), var_title, var_args.clone())
	var_message = (list_tmp_7).array_get(0)
	var_title = (list_tmp_7).array_get(1)
	var_parsed_args = (list_tmp_7).array_get(2)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_args.array_get(rt.new_string('response')))))) {
			status_header(var_parsed_args.array_get(rt.new_string('response')), '')
		}
		nocache_headers()
	}
	if rt.is_true(rt.call_function('is_scalar', [var_message.clone()])) {
	var_message = rt.new_string((var_message).str())
	} else {
	var_message = rt.new_string('0')
	}
	if rt.is_true(var_parsed_args.array_get(rt.new_string('exit'))) {
		fn () { print((var_message).str()); exit(0) }()
	}
	rt.echo_val(var_message)
}

fn _json_wp_die_handler(var_message rt.PhpVal, title string, var_args rt.PhpVal) {
	mut var_title := title
	mut var_parsed_args := rt.new_null()
	mut var_data := rt.new_null()
	mut list_tmp_8 := _wp_die_process_input(var_message.clone(), var_title, var_args.clone())
	var_message = (list_tmp_8).array_get(0)
	var_title = (list_tmp_8).array_get(1)
	var_parsed_args = (list_tmp_8).array_get(2)
	var_data = rt.create_array([rt.ArrayItem{ key: 'code', val: var_parsed_args.array_get(rt.new_string('code')) }, rt.ArrayItem{ key: 'message', val: var_message }, rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'status', val: var_parsed_args.array_get(rt.new_string('response')) }]) }, rt.ArrayItem{ key: 'additional_errors', val: var_parsed_args.array_get(rt.new_string('additional_errors')) }])
	if var_parsed_args.array_isset(rt.new_string('error_data')) {
		var_data.array_get_mut('data').array_set('error', var_parsed_args.array_get(rt.new_string('error_data')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('header', [rt.concat(rt.new_string('Content-Type: application/json; charset='), var_parsed_args.array_get(rt.new_string('charset')))])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_parsed_args.array_get(rt.new_string('response')))))) {
			status_header(var_parsed_args.array_get(rt.new_string('response')), '')
		}
		nocache_headers()
	}
	rt.echo_val(wp_json_encode(var_data.clone(), 0, 0))
	if rt.is_true(var_parsed_args.array_get(rt.new_string('exit'))) {
		exit(0)
	}
}

fn _jsonp_wp_die_handler(var_message rt.PhpVal, title string, var_args rt.PhpVal) {
	mut var_title := title
	mut var_parsed_args := rt.new_null()
	mut var_data := rt.new_null()
	mut var_result := rt.new_null()
	mut var_jsonp_callback := rt.new_null()
	mut list_tmp_9 := _wp_die_process_input(var_message.clone(), var_title, var_args.clone())
	var_message = (list_tmp_9).array_get(0)
	var_title = (list_tmp_9).array_get(1)
	var_parsed_args = (list_tmp_9).array_get(2)
	var_data = rt.create_array([rt.ArrayItem{ key: 'code', val: var_parsed_args.array_get(rt.new_string('code')) }, rt.ArrayItem{ key: 'message', val: var_message }, rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'status', val: var_parsed_args.array_get(rt.new_string('response')) }]) }, rt.ArrayItem{ key: 'additional_errors', val: var_parsed_args.array_get(rt.new_string('additional_errors')) }])
	if var_parsed_args.array_isset(rt.new_string('error_data')) {
		var_data.array_get_mut('data').array_set('error', var_parsed_args.array_get(rt.new_string('error_data')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('header', [rt.concat(rt.new_string('Content-Type: application/javascript; charset='), var_parsed_args.array_get(rt.new_string('charset')))])
		rt.call_function('header', [rt.new_string('X-Content-Type-Options: nosniff')])
		rt.call_function('header', [rt.new_string('X-Robots-Tag: noindex')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_parsed_args.array_get(rt.new_string('response')))))) {
			status_header(var_parsed_args.array_get(rt.new_string('response')), '')
		}
		nocache_headers()
	}
	var_result = wp_json_encode(var_data.clone(), 0, 0)
	var_jsonp_callback = rt.get_superglobal('_GET').array_get(rt.new_string('_jsonp'))
	print('/**/' + (var_jsonp_callback).str() + '(' + (var_result).str() + ')')
	if rt.is_true(var_parsed_args.array_get(rt.new_string('exit'))) {
		exit(0)
	}
}

fn _xmlrpc_wp_die_handler(var_message rt.PhpVal, title string, var_args rt.PhpVal) {
	mut var_title := title
	mut var_wp_xmlrpc_server := rt.new_null()
	mut var_parsed_args := rt.new_null()
	mut var_error := rt.new_null()
	mut list_tmp_10 := _wp_die_process_input(var_message.clone(), var_title, var_args.clone())
	var_message = (list_tmp_10).array_get(0)
	var_title = (list_tmp_10).array_get(1)
	var_parsed_args = (list_tmp_10).array_get(2)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		nocache_headers()
	}
	if rt.is_true(var_wp_xmlrpc_server) {
		var_error = create_ixr_error(var_parsed_args.array_get(rt.new_string('response')), var_message.clone())
		rt.call_method(var_wp_xmlrpc_server, 'output', [var_error.getxml()])
	}
	if rt.is_true(var_parsed_args.array_get(rt.new_string('exit'))) {
		exit(0)
	}
}

fn _xml_wp_die_handler(var_message_arg rt.PhpVal, title string, var_args rt.PhpVal) {
	mut var_title := title
	mut var_message := var_message_arg
	mut var_parsed_args := rt.new_null()
	mut var_xml := ''
	mut list_tmp_11 := _wp_die_process_input(var_message.clone(), var_title, var_args.clone())
	var_message = (list_tmp_11).array_get(0)
	var_title = (list_tmp_11).array_get(1)
	var_parsed_args = (list_tmp_11).array_get(2)
	var_message = rt.call_function('htmlspecialchars', [var_message.clone()])
	var_title = (rt.call_function('htmlspecialchars', [rt.new_string((var_title).str())])).str()
	var_xml = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('<error>\n    <code>'), var_parsed_args.array_get(rt.new_string('code'))), rt.new_string('</code>\n    <title><![CDATA[')), rt.new_string((var_title).str())), rt.new_string(']]></title>\n    <message><![CDATA[')), var_message), rt.new_string(']]></message>\n    <data>\n        <status>')), var_parsed_args.array_get(rt.new_string('response'))), rt.new_string('</status>\n    </data>\n</error>\n'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('header', [rt.concat(rt.new_string('Content-Type: text/xml; charset='), var_parsed_args.array_get(rt.new_string('charset')))])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_parsed_args.array_get(rt.new_string('response')))))) {
			status_header(var_parsed_args.array_get(rt.new_string('response')), '')
		}
		nocache_headers()
	}
	print(var_xml)
	if rt.is_true(var_parsed_args.array_get(rt.new_string('exit'))) {
		exit(0)
	}
}

fn _scalar_wp_die_handler(message string, title string, var_args rt.PhpVal) {
	mut var_message := message
	mut var_title := title
	mut var_parsed_args := rt.new_null()
	mut list_tmp_12 := _wp_die_process_input(rt.new_string(message), var_title, var_args.clone())
	message = (list_tmp_12).array_get(0)
	var_title = (list_tmp_12).array_get(1)
	var_parsed_args = (list_tmp_12).array_get(2)
	if rt.is_true(var_parsed_args.array_get(rt.new_string('exit'))) {
		if rt.is_true(rt.call_function('is_scalar', [rt.new_string(message)])) {
			fn () { print((message).str()); exit(0) }()
		}
		exit(0)
	}
	if rt.is_true(rt.call_function('is_scalar', [rt.new_string(message)])) {
		print(message)
	}
}

fn _wp_die_process_input(var_message_arg rt.PhpVal, title string, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_title := title
	mut var_message := var_message_arg
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_errors := rt.new_null()
	mut var_error_messages := rt.new_null()
	mut var_error_code := rt.new_null()
	mut var_error_message := rt.new_null()
	mut var_have_gettext := rt.new_null()
	var_defaults = { 'response': rt.new_int(0), 'code': rt.new_string(''), 'exit': rt.new_bool(true), 'back_link': rt.new_bool(false), 'link_url': rt.new_string(''), 'link_text': rt.new_string(''), 'text_direction': rt.new_string(''), 'charset': rt.new_string('utf-8'), 'additional_errors': []rt.PhpVal{} }
	var_args = wp_parse_args(var_args.clone(), rt.create_array_from_native_map(var_defaults))
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_wp_error')])) && rt.is_true(rt.call_function('is_wp_error', [var_message.clone()])) {
		if !(!rt.is_true(rt.get_property(var_message, 'errors'))) {
			var_errors = []rt.PhpVal{}
			mut iter_24 := rt.cast_array(rt.get_property(var_message, 'errors')).iterator()
			for {
				item_24 := iter_24.next() or { break }
				mut var_error_messages_shadow := item_24.val
				mut var_error_code_shadow := item_24.key
				mut iter_25 := rt.cast_array(var_error_messages_shadow).iterator()
				for {
					item_25 := iter_25.next() or { break }
					mut var_error_message_shadow := item_25.val
					var_errors.array_push(rt.create_array([rt.ArrayItem{ key: 'code', val: var_error_code_shadow }, rt.ArrayItem{ key: 'message', val: var_error_message_shadow }, rt.ArrayItem{ key: 'data', val: rt.call_method(var_message, 'get_error_data', [var_error_code_shadow.clone()]) }]))
				}
			}
			var_message = var_errors.array_get(rt.new_int(0)).array_get(rt.new_string('message'))
			if !rt.is_true(var_args.array_get(rt.new_string('code'))) {
				var_args.array_set('code', var_errors.array_get(rt.new_int(0)).array_get(rt.new_string('code')))
			}
			if !rt.is_true(var_args.array_get(rt.new_string('response'))) && var_errors.array_get(rt.new_int(0)).array_get(rt.new_string('data')).is_array() && !(!rt.is_true(var_errors.array_get(rt.new_int(0)).array_get(rt.new_string('data')).array_get(rt.new_string('status')))) {
				var_args.array_set('response', var_errors.array_get(rt.new_int(0)).array_get(rt.new_string('data')).array_get(rt.new_string('status')))
			}
			if var_title == '' && var_errors.array_get(rt.new_int(0)).array_get(rt.new_string('data')).is_array() && !(!rt.is_true(var_errors.array_get(rt.new_int(0)).array_get(rt.new_string('data')).array_get(rt.new_string('title')))) {
			var_title = (var_errors.array_get(rt.new_int(0)).array_get(rt.new_string('data')).array_get(rt.new_string('title'))).str()
			}
			if rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY')) && var_errors.array_get(rt.new_int(0)).array_get(rt.new_string('data')).is_array() && !(!rt.is_true(var_errors.array_get(rt.new_int(0)).array_get(rt.new_string('data')).array_get(rt.new_string('error')))) {
				var_args.array_set('error_data', var_errors.array_get(rt.new_int(0)).array_get(rt.new_string('data')).array_get(rt.new_string('error')))
			}
			var_errors.array_unset(rt.new_int(0))
			var_args.array_set('additional_errors', rt.call_function('array_values', [var_errors.clone()]))
		} else {
		var_message = rt.new_string('')
		}
	}
	var_have_gettext = rt.call_function('function_exists', [rt.new_string('__')])
	if !rt.is_true(var_args.array_get(rt.new_string('code'))) {
		var_args.array_set('code', 'wp_die')
	}
	if !rt.is_true(var_args.array_get(rt.new_string('response'))) {
		var_args.array_set('response', 500)
	}
	if var_title == '' {
	var_title = (if rt.is_true(var_have_gettext) { rt.call_function('__', [rt.new_string('WordPress &rsaquo; Error')]) } else { rt.new_string('WordPress &rsaquo; Error') }).str()
	}
	if !rt.is_true(var_args.array_get(rt.new_string('text_direction'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('text_direction')), rt.create_array([rt.ArrayItem{ key: none, val: 'ltr' }, rt.ArrayItem{ key: none, val: 'rtl' }]), rt.new_bool(true)]))))) {
		var_args.array_set('text_direction', 'ltr')
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_rtl')])) && rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
			var_args.array_set('text_direction', 'rtl')
		}
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('charset')))) {
		var_args.array_set('charset', _canonical_charset(var_args.array_get(rt.new_string('charset'))))
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_message }, rt.ArrayItem{ key: none, val: var_title }, rt.ArrayItem{ key: none, val: var_args }])
}

fn wp_json_encode(var_value_arg rt.PhpVal, flags i64, depth i64) rt.PhpVal {
	mut var_flags := flags
	mut var_depth := depth
	mut var_value := var_value_arg
	mut var_json := ''
	mut var_e := rt.new_null()
	var_json = rt.json_encode(var_value.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.new_string((var_json).str()))))) {
		return rt.new_string((var_json).str())
	}
	var_value = _wp_json_sanity_check(var_value.clone(), rt.new_int(depth))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		var_e = var_e_2.clone()
		return rt.new_bool(false)
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_string((rt.json_encode(var_value.clone())).str())
}

fn _wp_json_sanity_check(var_value rt.PhpVal, var_depth rt.PhpVal) rt.PhpVal {
	mut var_output := rt.new_null()
	mut var_el := rt.new_null()
	mut var_id := rt.new_null()
	mut var_clean_id := rt.new_null()
	if rt.is_true(rt.less(var_depth, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('Reached depth limit'))))
	}
	if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
		var_output = []rt.PhpVal{}
		mut iter_26 := var_value.iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_el_shadow := item_26.val
			mut var_id_shadow := item_26.key
			if rt.is_true(rt.new_bool(var_id_shadow.clone().is_string())) {
			var_clean_id = _wp_json_convert_string(var_id_shadow.clone())
			} else {
			var_clean_id = var_id_shadow.clone()
			}
			if var_el_shadow.clone().is_array() || var_el_shadow.clone().is_object() {
				var_output.array_set(var_clean_id, _wp_json_sanity_check(var_el_shadow.clone(), rt.sub(var_depth, rt.new_int(1))))
			} else if rt.is_true(rt.new_bool(var_el_shadow.clone().is_string())) {
				var_output.array_set(var_clean_id, _wp_json_convert_string(var_el_shadow.clone()))
			} else {
				var_output.array_set(var_clean_id, var_el_shadow.clone())
			}
		}
	} else if rt.is_true(rt.new_bool(var_value.clone().is_object())) {
		var_output = create_stdclass()
		mut iter_27 := var_value.iterator()
		for {
			item_27 := iter_27.next() or { break }
			mut var_el_shadow := item_27.val
			mut var_id_shadow := item_27.key
			if rt.is_true(rt.new_bool(var_id_shadow.clone().is_string())) {
			var_clean_id = _wp_json_convert_string(var_id_shadow.clone())
			} else {
			var_clean_id = var_id_shadow.clone()
			}
			if var_el_shadow.clone().is_array() || var_el_shadow.clone().is_object() {
				rt.set_property(var_output, '{"nodeType":"Expr_Variable","line":4463,"name":"clean_id"}', _wp_json_sanity_check(var_el_shadow.clone(), rt.sub(var_depth, rt.new_int(1))))
			} else if rt.is_true(rt.new_bool(var_el_shadow.clone().is_string())) {
				rt.set_property(var_output, '{"nodeType":"Expr_Variable","line":4465,"name":"clean_id"}', _wp_json_convert_string(var_el_shadow.clone()))
			} else {
				rt.set_property(var_output, '{"nodeType":"Expr_Variable","line":4467,"name":"clean_id"}', var_el_shadow.clone())
			}
		}
	} else if rt.is_true(rt.new_bool(var_value.clone().is_string())) {
		return _wp_json_convert_string(var_value.clone())
	} else {
		return var_value.clone()
	}
	return var_output.clone()
}

fn _wp_json_convert_string(var_input_string rt.PhpVal) rt.PhpVal {
	mut var_use_mb := rt.new_null()
	mut var_encoding := rt.new_null()
	if rt.is_true(rt.new_bool(var_use_mb.clone().is_null())) {
	var_use_mb = rt.call_function('function_exists', [rt.new_string('mb_convert_encoding')])
	}
	if rt.is_true(var_use_mb) {
		var_encoding = rt.call_function('mb_detect_encoding', [var_input_string.clone(), rt.call_function('mb_detect_order', []rt.PhpVal{}), rt.new_bool(true)])
		if rt.is_true(var_encoding) {
			return rt.call_function('mb_convert_encoding', [var_input_string.clone(), rt.new_string('UTF-8'), var_encoding.clone()])
		} else {
			return rt.call_function('mb_convert_encoding', [var_input_string.clone(), rt.new_string('UTF-8'), rt.new_string('UTF-8')])
		}
	} else {
		return rt.call_function('wp_check_invalid_utf8', [var_input_string.clone(), rt.new_bool(true)])
	}
	return rt.new_null()
}

fn _wp_json_prepare_data(var_value rt.PhpVal) rt.PhpVal {
	_deprecated_function(rt.new_string(@FN), '5.3.0', '')
	return var_value.clone()
}

fn wp_send_json(var_response rt.PhpVal, var_status_code rt.PhpVal, flags i64) {
	mut var_flags := flags
	if rt.is_true(rt.new_bool(wp_is_serving_rest_request())) {
		_doing_it_wrong(rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Return a %1$s or %2$s object from your callback when using the REST API.')]), rt.new_string('WP_REST_Response'), rt.new_string('WP_Error')]), '5.5.0')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('header', [rt.new_string('Content-Type: application/json; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str())])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_status_code)))) {
			status_header(var_status_code.clone(), '')
		}
	}
	rt.echo_val(wp_json_encode(var_response.clone(), flags, 0))
	if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
		wp_die('', '', rt.create_array([rt.ArrayItem{ key: 'response', val: rt.new_null() }]))
	} else {
		exit(0)
	}
}

fn wp_send_json_success(var_value rt.PhpVal, var_status_code rt.PhpVal, flags i64) {
	mut var_flags := flags
	mut var_response := rt.new_null()
	var_response = rt.create_array([rt.ArrayItem{ key: 'success', val: true }])
	if !(var_value).is_null() {
		var_response.array_set('data', var_value.clone())
	}
	wp_send_json(var_response.clone(), var_status_code.clone(), flags)
}

fn wp_send_json_error(var_value rt.PhpVal, var_status_code rt.PhpVal, flags i64) {
	mut var_flags := flags
	mut var_response := rt.new_null()
	mut var_result := rt.new_null()
	mut var_messages := rt.new_null()
	mut var_code := rt.new_null()
	mut var_message := rt.new_null()
	var_response = rt.create_array([rt.ArrayItem{ key: 'success', val: false }])
	if !(var_value).is_null() {
		if rt.is_true(rt.call_function('is_wp_error', [var_value.clone()])) {
			var_result = []rt.PhpVal{}
			mut iter_28 := rt.get_property(var_value, 'errors').iterator()
			for {
				item_28 := iter_28.next() or { break }
				mut var_messages_shadow := item_28.val
				mut var_code_shadow := item_28.key
				mut iter_29 := var_messages_shadow.iterator()
				for {
					item_29 := iter_29.next() or { break }
					mut var_message_shadow := item_29.val
					var_result.array_push(rt.create_array([rt.ArrayItem{ key: 'code', val: var_code_shadow }, rt.ArrayItem{ key: 'message', val: var_message_shadow }]))
				}
			}
			var_response.array_set('data', var_result.clone())
		} else {
			var_response.array_set('data', var_value.clone())
		}
	}
	wp_send_json(var_response.clone(), var_status_code.clone(), flags)
}

fn wp_check_jsonp_callback(var_callback rt.PhpVal) bool {
	mut var_illegal_char_count := rt.new_null()
	if !(var_callback.clone().is_string()) {
		return false
	}
	rt.call_function('preg_replace', [rt.new_string('/[^\\w\\.]/'), rt.new_string(''), var_callback.clone(), rt.new_int(-1), var_illegal_char_count.clone()])
	return (rt.identical(rt.new_int(0), var_illegal_char_count)).to_bool()
}

fn wp_json_file_decode(var_filename_arg rt.PhpVal, var_options_arg rt.PhpVal) rt.PhpVal {
	mut var_filename := var_filename_arg
	mut var_options := var_options_arg
	mut var_result := rt.new_null()
	mut var_decoded_file := rt.new_null()
	var_result = rt.new_null()
	var_filename = wp_normalize_path(rt.call_function('realpath', [rt.new_string((var_filename).str()).clone()]))
	if !(var_filename.len > 0 && var_filename != '0') {
		wp_trigger_error(rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('File %s doesn\'t exist!')]), rt.new_string((var_filename).str()).clone()]), rt.new_null())
		return var_result.clone()
	}
	var_options = wp_parse_args(var_options.clone(), rt.create_array([rt.ArrayItem{ key: 'associative', val: false }]))
	var_decoded_file = rt.call_function('json_decode', [rt.call_function('file_get_contents', [rt.new_string((var_filename).str()).clone()]), var_options.array_get(rt.new_string('associative'))])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('JSON_ERROR_NONE'), rt.call_function('json_last_error', []rt.PhpVal{}))))) {
		wp_trigger_error(rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error when decoding a JSON file at path %1$s: %2$s')]), rt.new_string((var_filename).str()).clone(), rt.call_function('json_last_error_msg', []rt.PhpVal{})]), rt.new_null())
		return var_result.clone()
	}
	return var_decoded_file.clone()
}

fn _config_wp_home(url string) string {
	mut var_url := url
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_HOME')])) {
		return (rt.call_function('untrailingslashit', [rt.get_constant('WP_HOME')])).str()
	}
	return url
}

fn _config_wp_siteurl(url string) string {
	mut var_url := url
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_SITEURL')])) {
		return (rt.call_function('untrailingslashit', [rt.get_constant('WP_SITEURL')])).str()
	}
	return url
}

fn _delete_option_fresh_site() {
	rt.call_function('update_option', [rt.new_string('fresh_site'), rt.new_string('0'), rt.new_bool(false)])
}

fn _mce_set_direction(var_mce_init rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_mce_init['directionality'] = rt.new_string('rtl')
		var_mce_init['rtl_ui'] = rt.new_bool(true)
		if !(!rt.is_true(var_mce_init.array_get(rt.new_string('plugins')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_mce_init.array_get(rt.new_string('plugins')), rt.new_string('directionality')]))))) {
			var_mce_init.array_get(rt.new_string('plugins')) = rt.concat(var_mce_init.array_get(rt.new_string('plugins')), rt.new_string(',directionality'))
		}
		if !(!rt.is_true(var_mce_init.array_get(rt.new_string('toolbar1')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\bltr\\b/'), var_mce_init.array_get(rt.new_string('toolbar1'))]))))) {
			var_mce_init.array_get(rt.new_string('toolbar1')) = rt.concat(var_mce_init.array_get(rt.new_string('toolbar1')), rt.new_string(',ltr'))
		}
	}
	return var_mce_init.clone()
}

fn wp_is_serving_rest_request() bool {
	return rt.is_true(rt.call_function('defined', [rt.new_string('REST_REQUEST')])) && rt.is_true(rt.get_constant('REST_REQUEST'))
}

fn smilies_init() {
	mut var_wpsmiliestrans := rt.new_null()
	mut var_spaces := rt.new_null()
	mut var_wp_smiliessearch := rt.new_null()
	mut var_subchar := rt.new_null()
	mut var_img := rt.new_null()
	mut var_smiley := rt.new_null()
	mut var_firstchar := rt.new_null()
	mut var_rest := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('use_smilies')]))))) {
		return
	}
	if !(!(var_wpsmiliestrans).is_null()) {
	var_wpsmiliestrans = rt.create_array([rt.ArrayItem{ key: ':mrgreen:', val: 'mrgreen.png' }, rt.ArrayItem{ key: ':neutral:', val: '😐' }, rt.ArrayItem{ key: ':twisted:', val: '😈' }, rt.ArrayItem{ key: ':arrow:', val: '➡' }, rt.ArrayItem{ key: ':shock:', val: '😯' }, rt.ArrayItem{ key: ':smile:', val: '🙂' }, rt.ArrayItem{ key: ':???:', val: '😕' }, rt.ArrayItem{ key: ':cool:', val: '😎' }, rt.ArrayItem{ key: ':evil:', val: '👿' }, rt.ArrayItem{ key: ':grin:', val: '😀' }, rt.ArrayItem{ key: ':idea:', val: '💡' }, rt.ArrayItem{ key: ':oops:', val: '😳' }, rt.ArrayItem{ key: ':razz:', val: '😛' }, rt.ArrayItem{ key: ':roll:', val: '🙄' }, rt.ArrayItem{ key: ':wink:', val: '😉' }, rt.ArrayItem{ key: ':cry:', val: '😥' }, rt.ArrayItem{ key: ':eek:', val: '😮' }, rt.ArrayItem{ key: ':lol:', val: '😆' }, rt.ArrayItem{ key: ':mad:', val: '😡' }, rt.ArrayItem{ key: ':sad:', val: '🙁' }, rt.ArrayItem{ key: '8-)', val: '😎' }, rt.ArrayItem{ key: '8-O', val: '😯' }, rt.ArrayItem{ key: ':-(', val: '🙁' }, rt.ArrayItem{ key: ':-)', val: '🙂' }, rt.ArrayItem{ key: ':-?', val: '😕' }, rt.ArrayItem{ key: ':-D', val: '😀' }, rt.ArrayItem{ key: ':-P', val: '😛' }, rt.ArrayItem{ key: ':-o', val: '😮' }, rt.ArrayItem{ key: ':-x', val: '😡' }, rt.ArrayItem{ key: ':-|', val: '😐' }, rt.ArrayItem{ key: ';-)', val: '😉' }, rt.ArrayItem{ key: '8O', val: '😯' }, rt.ArrayItem{ key: ':(', val: '🙁' }, rt.ArrayItem{ key: ':)', val: '🙂' }, rt.ArrayItem{ key: ':?', val: '😕' }, rt.ArrayItem{ key: ':D', val: '😀' }, rt.ArrayItem{ key: ':P', val: '😛' }, rt.ArrayItem{ key: ':o', val: '😮' }, rt.ArrayItem{ key: ':x', val: '😡' }, rt.ArrayItem{ key: ':|', val: '😐' }, rt.ArrayItem{ key: ';)', val: '😉' }, rt.ArrayItem{ key: ':!:', val: '❗' }, rt.ArrayItem{ key: ':?:', val: '❓' }])
	}
	var_wpsmiliestrans = rt.call_function('apply_filters', [rt.new_string('smilies'), var_wpsmiliestrans.clone()])
	if var_wpsmiliestrans.clone().array_count() == 0 {
		return
	}
	rt.call_function('krsort', [var_wpsmiliestrans.clone()])
	var_spaces = rt.call_function('wp_spaces_regexp', []rt.PhpVal{})
	var_wp_smiliessearch = rt.new_string('/(?<=' + (var_spaces).str() + '|^)')
	var_subchar = rt.new_string('')
	mut iter_30 := rt.cast_array(var_wpsmiliestrans).iterator()
	for {
		item_30 := iter_30.next() or { break }
		mut var_img_shadow := item_30.val
		mut var_smiley_shadow := item_30.key
		var_firstchar = rt.call_function('substr', [var_smiley_shadow.clone(), rt.new_int(0), rt.new_int(1)])
		var_rest = rt.call_function('substr', [var_smiley_shadow.clone(), rt.new_int(1)])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_firstchar, var_subchar)))) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_subchar)))) {
				var_wp_smiliessearch = rt.concat(var_wp_smiliessearch, rt.new_string(')(?=' + (var_spaces).str() + '|$)'))
				var_wp_smiliessearch = rt.concat(var_wp_smiliessearch, rt.new_string('|(?<=' + (var_spaces).str() + '|^)'))
			}
			var_subchar = var_firstchar.clone()
			var_wp_smiliessearch = rt.concat(var_wp_smiliessearch, rt.new_string((rt.call_function('preg_quote', [var_firstchar.clone(), rt.new_string('/')])).str() + '(?:'))
		} else {
			var_wp_smiliessearch = rt.concat(var_wp_smiliessearch, rt.new_string('|'))
		}
		var_wp_smiliessearch = rt.concat(var_wp_smiliessearch, rt.call_function('preg_quote', [var_rest.clone(), rt.new_string('/')]))
	}
	var_wp_smiliessearch = rt.concat(var_wp_smiliessearch, rt.new_string(')(?=' + (var_spaces).str() + '|$)/m'))
}

fn wp_parse_args(var_args rt.PhpVal, var_defaults rt.PhpVal) rt.PhpVal {
	mut var_parsed_args := rt.new_null()
	if rt.is_true(rt.new_bool(var_args.clone().is_object())) {
	var_parsed_args = rt.call_function('get_object_vars', [var_args.clone()])
	} else if rt.is_true(rt.new_bool(var_args.clone().is_array())) {
		var_parsed_args = var_args
	} else {
		rt.call_function('wp_parse_str', [var_args.clone(), var_parsed_args.clone()])
	}
	if rt.create_array_from_native_map(var_defaults).is_array() && rt.is_true(var_defaults) {
		return rt.call_function('array_merge', [rt.create_array_from_native_map(var_defaults), var_parsed_args.clone()])
	}
	return var_parsed_args.clone()
}

fn wp_parse_list(var_input_list_arg rt.PhpVal) rt.PhpVal {
	mut var_input_list := var_input_list_arg
	if !(var_input_list.clone().is_array()) {
		return rt.call_function('preg_split', [rt.new_string('/[\\s,]+/'), var_input_list.clone(), rt.new_int(-1), rt.get_constant('PREG_SPLIT_NO_EMPTY')])
	}
	var_input_list = rt.call_function('array_filter', [var_input_list.clone(), rt.new_string('is_scalar')])
	return var_input_list.clone()
}

fn wp_parse_id_list(var_input_list_arg rt.PhpVal) rt.PhpVal {
	mut var_input_list := var_input_list_arg
	var_input_list = wp_parse_list(var_input_list.clone())
	return rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('absint'), var_input_list.clone()])])
}

fn wp_parse_slug_list(var_input_list_arg rt.PhpVal) rt.PhpVal {
	mut var_input_list := var_input_list_arg
	var_input_list = wp_parse_list(var_input_list.clone())
	return rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('sanitize_title'), var_input_list.clone()])])
}

fn wp_array_slice_assoc(var_input_array rt.PhpVal, var_keys rt.PhpVal) rt.PhpVal {
	mut var_slice := rt.new_null()
	mut var_key := rt.new_null()
	var_slice = []rt.PhpVal{}
	mut iter_31 := var_keys.iterator()
	for {
		item_31 := iter_31.next() or { break }
		mut var_key_shadow := item_31.val
		if var_input_array.array_isset(var_key_shadow) {
			var_slice.array_set(var_key_shadow, var_input_array.array_get(var_key_shadow))
		}
	}
	return var_slice.clone()
}

fn wp_recursive_ksort(var_input_array rt.PhpVal) {
	mut var_value := rt.new_null()
	mut iter_32 := var_input_array.iterator()
	for {
		item_32 := iter_32.next() or { break }
		mut var_value_shadow := item_32.val
		if rt.is_true(rt.new_bool(var_value_shadow.clone().is_array())) {
			wp_recursive_ksort(var_value_shadow.clone())
		}
	}
	rt.call_function('ksort', [var_input_array.clone()])
}

fn _wp_array_get(var_input_array_arg rt.PhpVal, var_path rt.PhpVal, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_input_array := var_input_array_arg
	mut var_path_element := rt.new_null()
	if !(var_path.clone().is_array()) || 0 == var_path.clone().array_count() {
		return var_default_value.clone()
	}
	mut iter_33 := var_path.iterator()
	for {
		item_33 := iter_33.next() or { break }
		mut var_path_element_shadow := item_33.val
		if !(var_input_array.clone().is_array()) {
			return var_default_value.clone()
		}
		if var_path_element_shadow.clone().is_string() || var_path_element_shadow.clone().is_long() || rt.is_true(rt.identical(rt.new_null(), var_path_element_shadow)) {
			if !(var_path_element_shadow).is_null() && var_input_array.array_isset(var_path_element_shadow) {
				var_input_array = var_input_array.array_get(var_path_element_shadow)
				continue
			}
			if !(var_path_element_shadow).is_null() && rt.is_true(rt.new_bool(var_input_array.clone().array_isset(var_path_element_shadow.clone()))) {
				var_input_array = var_input_array.array_get(var_path_element_shadow)
				continue
			}
		}
		return var_default_value.clone()
	}
	return var_input_array.clone()
}

fn _wp_array_set(var_input_array rt.PhpVal, var_path rt.PhpVal, var_value rt.PhpVal) {
	mut var_path_length := i64(0)
	mut var_path_element := rt.new_null()
	mut var_i := i64(0)
	if !(var_input_array.clone().is_array()) {
		return
	}
	if !(var_path.clone().is_array()) {
		return
	}
	var_path_length = var_path.clone().array_count()
	if 0 == var_path_length {
		return
	}
	mut iter_34 := var_path.iterator()
	for {
		item_34 := iter_34.next() or { break }
		mut var_path_element_shadow := item_34.val
		if !(var_path_element_shadow.clone().is_string()) && !(var_path_element_shadow.clone().is_long()) && !(var_path_element_shadow.clone().is_null()) {
			return
		}
	}
	var_i = 0
	for {
		if !(var_i < var_path_length - 1) { break }
		var_path_element = var_path.array_get(rt.new_int(var_i))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_input_array.clone().array_isset(var_path_element.clone())))))) || !(var_input_array.array_get(var_path_element).is_array()) {
			var_input_array.array_set(var_path_element, []rt.PhpVal{})
		}
		var_input_array = var_input_array.array_get(var_path_element)
		var_i += 1
	}
	var_input_array.array_set(var_path.array_get(rt.new_int(var_i)), var_value.clone())
}

fn _wp_to_kebab_case(var_input_string rt.PhpVal) string {
	mut var_matches := []rt.PhpVal{}
	mut var_rsLowerRange := ''
	mut var_rsNonCharRange := ''
	mut var_rsPunctuationRange := ''
	mut var_rsSpaceRange := ''
	mut var_rsUpperRange := ''
	mut var_rsBreakRange := rt.new_null()
	mut var_rsBreak := rt.new_null()
	mut var_rsDigits := ''
	mut var_rsLower := rt.new_null()
	mut var_rsMisc := rt.new_null()
	mut var_rsUpper := rt.new_null()
	mut var_rsMiscLower := rt.new_null()
	mut var_rsMiscUpper := rt.new_null()
	mut var_rsOrdLower := ''
	mut var_rsOrdUpper := ''
	mut var_regexp := rt.new_null()
	var_rsLowerRange = 'a-z\\xdf-\\xf6\\xf8-\\xff'
	var_rsNonCharRange = '\\x00-\\x2f\\x3a-\\x40\\x5b-\\x60\\x7b-\\xbf'
	var_rsPunctuationRange = '\\x{2000}-\\x{206f}'
	var_rsSpaceRange = ' \\t\\x0b\\f\\xa0\\x{feff}\\n\\r\\x{2028}\\x{2029}\\x{1680}\\x{180e}\\x{2000}\\x{2001}\\x{2002}\\x{2003}\\x{2004}\\x{2005}\\x{2006}\\x{2007}\\x{2008}\\x{2009}\\x{200a}\\x{202f}\\x{205f}\\x{3000}'
	var_rsUpperRange = 'A-Z\\xc0-\\xd6\\xd8-\\xde'
	var_rsBreakRange = rt.new_string((var_rsNonCharRange + var_rsPunctuationRange + var_rsSpaceRange).str())
	var_rsBreak = rt.new_string('[' + (var_rsBreakRange).str() + ']')
	var_rsDigits = '\\d+'
	var_rsLower = rt.new_string('[' + var_rsLowerRange + ']')
	var_rsMisc = rt.new_string('[^' + (var_rsBreakRange).str() + var_rsDigits + var_rsLowerRange + var_rsUpperRange + ']')
	var_rsUpper = rt.new_string('[' + var_rsUpperRange + ']')
	var_rsMiscLower = rt.new_string('(?:' + (var_rsLower).str() + '|' + (var_rsMisc).str() + ')')
	var_rsMiscUpper = rt.new_string('(?:' + (var_rsUpper).str() + '|' + (var_rsMisc).str() + ')')
	var_rsOrdLower = '\\d*(?:1st|2nd|3rd|(?![123])\\dth)(?=\\b|[A-Z_])'
	var_rsOrdUpper = '\\d*(?:1ST|2ND|3RD|(?![123])\\dTH)(?=\\b|[a-z_])'
	var_regexp = rt.new_string('/' + (rt.call_function('implode', [rt.new_string('|'), rt.create_array([rt.ArrayItem{ key: none, val: (var_rsUpper).str() + '?' + (var_rsLower).str() + '+' + '(?=' + (rt.call_function('implode', [rt.new_string('|'), rt.create_array([rt.ArrayItem{ key: none, val: var_rsBreak }, rt.ArrayItem{ key: none, val: var_rsUpper }, rt.ArrayItem{ key: none, val: '$' }])])).str() + ')' }, rt.ArrayItem{ key: none, val: (var_rsMiscUpper).str() + '+' + '(?=' + (rt.call_function('implode', [rt.new_string('|'), rt.create_array([rt.ArrayItem{ key: none, val: var_rsBreak }, rt.ArrayItem{ key: none, val: (var_rsUpper).str() + (var_rsMiscLower).str() }, rt.ArrayItem{ key: none, val: '$' }])])).str() + ')' }, rt.ArrayItem{ key: none, val: (var_rsUpper).str() + '?' + (var_rsMiscLower).str() + '+' }, rt.ArrayItem{ key: none, val: (var_rsUpper).str() + '+' }, rt.ArrayItem{ key: none, val: var_rsOrdUpper }, rt.ArrayItem{ key: none, val: var_rsOrdLower }, rt.ArrayItem{ key: none, val: var_rsDigits }])])).str() + '/u')
	rt.call_function('preg_match_all', [var_regexp.clone(), rt.call_function('str_replace', [rt.new_string('\''), rt.new_string(''), var_input_string.clone()]), rt.create_array_from_list(var_matches)])
	return rt.call_function('implode', [rt.new_string('-'), var_matches[0]]).to_string().to_lower()
	return ''
}

fn wp_is_numeric_array(var_data rt.PhpVal) bool {
	mut var_keys := rt.new_null()
	mut var_string_keys := rt.new_null()
	if !(var_data.clone().is_array()) {
		return false
	}
	var_keys = rt.func_array_keys(var_data.clone())
	var_string_keys = rt.call_function('array_filter', [var_keys.clone(), rt.new_string('is_string')])
	return rt.new_bool(var_string_keys.clone().array_count() == 0)
}

fn wp_filter_object_list(var_input_list rt.PhpVal, var_args rt.PhpVal, operator string, field bool) rt.PhpVal {
	mut var_operator := operator
	mut var_field := field
	mut var_util := rt.new_null()
	if !(var_input_list.clone().is_array()) {
		return []rt.PhpVal{}
	}
	var_util = create_wp_list_util(var_input_list.clone())
	var_util.filter(var_args.clone(), rt.new_string(operator))
	if var_field {
		var_util.pluck(rt.new_bool(field))
	}
	return var_util.get_output()
}

fn wp_list_filter(var_input_list rt.PhpVal, var_args rt.PhpVal, operator string) rt.PhpVal {
	mut var_operator := operator
	return wp_filter_object_list(var_input_list.clone(), var_args.clone(), operator, false)
}

fn wp_list_pluck(var_input_list rt.PhpVal, field string, var_index_key rt.PhpVal) rt.PhpVal {
	mut var_field := field
	mut var_util := rt.new_null()
	if !(var_input_list.clone().is_array()) {
		return []rt.PhpVal{}
	}
	var_util = create_wp_list_util(var_input_list.clone())
	return var_util.pluck(rt.new_string(field), var_index_key.clone())
}

fn wp_list_sort(var_input_list rt.PhpVal, var_orderby rt.PhpVal, order string, preserve_keys bool) rt.PhpVal {
	mut var_order := order
	mut var_preserve_keys := preserve_keys
	mut var_util := rt.new_null()
	if !(var_input_list.clone().is_array()) {
		return []rt.PhpVal{}
	}
	var_util = create_wp_list_util(var_input_list.clone())
	return var_util.sort(var_orderby.clone(), rt.new_string(order), rt.new_bool(preserve_keys))
}

fn wp_maybe_load_widgets() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('load_default_widgets'), rt.new_bool(true)]))))) {
		return
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/default-widgets.php', '4')
	rt.call_function('add_action', [rt.new_string('_admin_menu'), rt.new_string('wp_widgets_add_menu')])
}

fn wp_widgets_add_menu() {
	mut var_submenu := map[string]rt.PhpVal{}
	mut var_menu_name := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('widgets')]))))) {
		return
	}
	var_menu_name = rt.call_function('__', [rt.new_string('Widgets')])
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		var_submenu.array_get_mut('themes.php').array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_menu_name }, rt.ArrayItem{ key: none, val: 'edit_theme_options' }, rt.ArrayItem{ key: none, val: 'widgets.php' }]))
	} else {
		var_submenu.array_get_mut('themes.php').array_set(8, rt.create_array([rt.ArrayItem{ key: none, val: var_menu_name }, rt.ArrayItem{ key: none, val: 'edit_theme_options' }, rt.ArrayItem{ key: none, val: 'widgets.php' }]))
	}
	rt.call_function('ksort', [var_submenu['themes.php'], rt.get_constant('SORT_NUMERIC')])
}

fn wp_ob_end_flush_all() {
	mut var_levels := rt.new_null()
	mut var_i := i64(0)
	var_levels = rt.call_function('ob_get_level', []rt.PhpVal{})
	var_i = 0
	for {
		if !(rt.is_true(rt.less(rt.new_int(var_i), var_levels))) { break }
		rt.call_function('ob_end_flush', []rt.PhpVal{})
		var_i += 1
	}
}

fn dead_db() {
	mut var_wpdb := rt.new_null()
	rt.call_function('wp_load_translations_early', []rt.PhpVal{})
	if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/db-error.php')])) {
		rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/db-error.php', '4')
		exit(0)
	}
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) || rt.is_true(rt.call_function('defined', [rt.new_string('WP_ADMIN')])) {
		wp_die(rt.get_property(var_wpdb, 'error'), '', rt.new_null())
	}
	wp_die('<h1>' + (rt.call_function('__', [rt.new_string('Error establishing a database connection')])).str() + '</h1>', rt.call_function('__', [rt.new_string('Database Error')]), rt.new_null())
}

fn _deprecated_function(var_function_name rt.PhpVal, version string, replacement string) {
	mut var_version := version
	mut var_replacement := replacement
	mut var_message := rt.new_null()
	rt.call_function('do_action', [rt.new_string('deprecated_function_run'), var_function_name.clone(), rt.new_string(replacement), rt.new_string(version)])
	if rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('deprecated_function_trigger_error'), rt.new_bool(true)])) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('__')])) {
			if var_replacement.len > 0 && var_replacement != '0' {
			var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Function %1$s is <strong>deprecated</strong> since version %2$s! Use %3$s instead.')]), var_function_name.clone(), rt.new_string(version), rt.new_string(replacement)])
			} else {
			var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Function %1$s is <strong>deprecated</strong> since version %2$s with no alternative available.')]), var_function_name.clone(), rt.new_string(version)])
			}
		} else {
			if var_replacement.len > 0 && var_replacement != '0' {
			var_message = rt.call_function('sprintf', [rt.new_string('Function %1$s is <strong>deprecated</strong> since version %2$s! Use %3$s instead.'), var_function_name.clone(), rt.new_string(version), rt.new_string(replacement)])
			} else {
			var_message = rt.call_function('sprintf', [rt.new_string('Function %1$s is <strong>deprecated</strong> since version %2$s with no alternative available.'), var_function_name.clone(), rt.new_string(version)])
			}
		}
		wp_trigger_error(rt.new_string(''), var_message.clone(), rt.get_constant('E_USER_DEPRECATED'))
	}
}

fn _deprecated_constructor(var_class_name rt.PhpVal, var_version rt.PhpVal, parent_class string) {
	mut var_parent_class := parent_class
	mut var_message := rt.new_null()
	rt.call_function('do_action', [rt.new_string('deprecated_constructor_run'), var_class_name.clone(), var_version.clone(), rt.new_string(parent_class)])
	if rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('deprecated_constructor_trigger_error'), rt.new_bool(true)])) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('__')])) {
			if var_parent_class.len > 0 && var_parent_class != '0' {
			var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The called constructor method for %1$s class in %2$s is <strong>deprecated</strong> since version %3$s! Use %4$s instead.')]), var_class_name.clone(), rt.new_string(parent_class), var_version.clone(), rt.new_string('<code>__construct()</code>')])
			} else {
			var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The called constructor method for %1$s class is <strong>deprecated</strong> since version %2$s! Use %3$s instead.')]), var_class_name.clone(), var_version.clone(), rt.new_string('<code>__construct()</code>')])
			}
		} else {
			if var_parent_class.len > 0 && var_parent_class != '0' {
			var_message = rt.call_function('sprintf', [rt.new_string('The called constructor method for %1$s class in %2$s is <strong>deprecated</strong> since version %3$s! Use %4$s instead.'), var_class_name.clone(), rt.new_string(parent_class), var_version.clone(), rt.new_string('<code>__construct()</code>')])
			} else {
			var_message = rt.call_function('sprintf', [rt.new_string('The called constructor method for %1$s class is <strong>deprecated</strong> since version %2$s! Use %3$s instead.'), var_class_name.clone(), var_version.clone(), rt.new_string('<code>__construct()</code>')])
			}
		}
		wp_trigger_error(rt.new_string(''), var_message.clone(), rt.get_constant('E_USER_DEPRECATED'))
	}
}

fn _deprecated_class(var_class_name rt.PhpVal, var_version rt.PhpVal, replacement string) {
	mut var_replacement := replacement
	mut var_message := rt.new_null()
	rt.call_function('do_action', [rt.new_string('deprecated_class_run'), var_class_name.clone(), rt.new_string(replacement), var_version.clone()])
	if rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('deprecated_class_trigger_error'), rt.new_bool(true)])) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('__')])) {
			if var_replacement.len > 0 && var_replacement != '0' {
			var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Class %1$s is <strong>deprecated</strong> since version %2$s! Use %3$s instead.')]), var_class_name.clone(), var_version.clone(), rt.new_string(replacement)])
			} else {
			var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Class %1$s is <strong>deprecated</strong> since version %2$s with no alternative available.')]), var_class_name.clone(), var_version.clone()])
			}
		} else {
			if var_replacement.len > 0 && var_replacement != '0' {
			var_message = rt.call_function('sprintf', [rt.new_string('Class %1$s is <strong>deprecated</strong> since version %2$s! Use %3$s instead.'), var_class_name.clone(), var_version.clone(), rt.new_string(replacement)])
			} else {
			var_message = rt.call_function('sprintf', [rt.new_string('Class %1$s is <strong>deprecated</strong> since version %2$s with no alternative available.'), var_class_name.clone(), var_version.clone()])
			}
		}
		wp_trigger_error(rt.new_string(''), var_message.clone(), rt.get_constant('E_USER_DEPRECATED'))
	}
}

fn _deprecated_file(var_file rt.PhpVal, var_version rt.PhpVal, replacement string, message string) {
	mut var_replacement := replacement
	mut var_message := message
	rt.call_function('do_action', [rt.new_string('deprecated_file_included'), var_file.clone(), rt.new_string(replacement), var_version.clone(), rt.new_string((var_message).str())])
	if rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('deprecated_file_trigger_error'), rt.new_bool(true)])) {
		var_message = if var_message == '' { '' } else { ' ' + var_message }
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('__')])) {
			if var_replacement.len > 0 && var_replacement != '0' {
			var_message = (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('File %1$s is <strong>deprecated</strong> since version %2$s! Use %3$s instead.')]), var_file.clone(), var_version.clone(), rt.new_string(replacement)])).str() + var_message
			} else {
			var_message = (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('File %1$s is <strong>deprecated</strong> since version %2$s with no alternative available.')]), var_file.clone(), var_version.clone()])).str() + var_message
			}
		} else {
			if var_replacement.len > 0 && var_replacement != '0' {
			var_message = (rt.call_function('sprintf', [rt.new_string('File %1$s is <strong>deprecated</strong> since version %2$s! Use %3$s instead.'), var_file.clone(), var_version.clone(), rt.new_string(replacement)])).str()
			} else {
			var_message = (rt.call_function('sprintf', [rt.new_string('File %1$s is <strong>deprecated</strong> since version %2$s with no alternative available.'), var_file.clone(), var_version.clone()])).str() + var_message
			}
		}
		wp_trigger_error(rt.new_string(''), rt.new_string((var_message).str()), rt.get_constant('E_USER_DEPRECATED'))
	}
}

fn _deprecated_argument(var_function_name rt.PhpVal, version string, message string) {
	mut var_version := version
	mut var_message := message
	rt.call_function('do_action', [rt.new_string('deprecated_argument_run'), var_function_name.clone(), rt.new_string((var_message).str()), rt.new_string(version)])
	if rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('deprecated_argument_trigger_error'), rt.new_bool(true)])) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('__')])) {
			if var_message.len > 0 && var_message != '0' {
			var_message = (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Function %1$s was called with an argument that is <strong>deprecated</strong> since version %2$s! %3$s')]), var_function_name.clone(), rt.new_string(version), rt.new_string((var_message).str())])).str()
			} else {
			var_message = (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Function %1$s was called with an argument that is <strong>deprecated</strong> since version %2$s with no alternative available.')]), var_function_name.clone(), rt.new_string(version)])).str()
			}
		} else {
			if var_message.len > 0 && var_message != '0' {
			var_message = (rt.call_function('sprintf', [rt.new_string('Function %1$s was called with an argument that is <strong>deprecated</strong> since version %2$s! %3$s'), var_function_name.clone(), rt.new_string(version), rt.new_string((var_message).str())])).str()
			} else {
			var_message = (rt.call_function('sprintf', [rt.new_string('Function %1$s was called with an argument that is <strong>deprecated</strong> since version %2$s with no alternative available.'), var_function_name.clone(), rt.new_string(version)])).str()
			}
		}
		wp_trigger_error(rt.new_string(''), rt.new_string((var_message).str()), rt.get_constant('E_USER_DEPRECATED'))
	}
}

fn _deprecated_hook(var_hook rt.PhpVal, var_version rt.PhpVal, replacement string, message string) {
	mut var_replacement := replacement
	mut var_message := message
	rt.call_function('do_action', [rt.new_string('deprecated_hook_run'), var_hook.clone(), rt.new_string(replacement), var_version.clone(), rt.new_string((var_message).str())])
	if rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('deprecated_hook_trigger_error'), rt.new_bool(true)])) {
		var_message = if var_message == '' { '' } else { ' ' + var_message }
		if var_replacement.len > 0 && var_replacement != '0' {
		var_message = (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Hook %1$s is <strong>deprecated</strong> since version %2$s! Use %3$s instead.')]), var_hook.clone(), var_version.clone(), rt.new_string(replacement)])).str() + var_message
		} else {
		var_message = (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Hook %1$s is <strong>deprecated</strong> since version %2$s with no alternative available.')]), var_hook.clone(), var_version.clone()])).str() + var_message
		}
		wp_trigger_error(rt.new_string(''), rt.new_string((var_message).str()), rt.get_constant('E_USER_DEPRECATED'))
	}
}

fn _doing_it_wrong(var_function_name rt.PhpVal, var_message_arg rt.PhpVal, version string) {
	mut var_version := version
	mut var_message := var_message_arg
	rt.call_function('do_action', [rt.new_string('doing_it_wrong_run'), var_function_name.clone(), var_message.clone(), rt.new_string((var_version).str())])
	if rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('doing_it_wrong_trigger_error'), rt.new_bool(true), var_function_name.clone(), var_message.clone(), rt.new_string((var_version).str())])) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('__')])) {
			if var_version.len > 0 && var_version != '0' {
			var_version = (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(This message was added in version %s.)')]), rt.new_string((var_version).str())])).str()
			}
			var_message = rt.concat(var_message, rt.new_string(' ' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please see <a href="%s">Debugging in WordPress</a> for more information.')]), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/')])])).str()))
		var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Function %1$s was called <strong>incorrectly</strong>. %2$s %3$s')]), var_function_name.clone(), var_message.clone(), rt.new_string((var_version).str())])
		} else {
			if var_version.len > 0 && var_version != '0' {
			var_version = (rt.call_function('sprintf', [rt.new_string('(This message was added in version %s.)'), rt.new_string((var_version).str())])).str()
			}
			var_message = rt.concat(var_message, rt.call_function('sprintf', [rt.new_string(' Please see <a href="%s">Debugging in WordPress</a> for more information.'), rt.new_string('https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/')]))
		var_message = rt.call_function('sprintf', [rt.new_string('Function %1$s was called <strong>incorrectly</strong>. %2$s %3$s'), var_function_name.clone(), var_message.clone(), rt.new_string((var_version).str())])
		}
		wp_trigger_error(rt.new_string(''), var_message.clone(), rt.new_null())
	}
}

fn wp_trigger_error(var_function_name rt.PhpVal, var_message_arg rt.PhpVal, var_error_level rt.PhpVal) {
	mut var_message := var_message_arg
	rt.call_function('do_action', [rt.new_string('wp_trigger_error_always_run'), var_function_name.clone(), var_message.clone(), var_error_level.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('wp_trigger_error_trigger_error'), rt.new_bool(true), var_function_name.clone(), var_message.clone(), var_error_level.clone()]))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) {
		return
	}
	rt.call_function('do_action', [rt.new_string('wp_trigger_error_run'), var_function_name.clone(), var_message.clone(), var_error_level.clone()])
	if !(!rt.is_true(var_function_name)) {
	var_message = rt.call_function('sprintf', [rt.new_string('%s(): %s'), var_function_name.clone(), var_message.clone()])
	}
	var_message = rt.call_function('wp_kses', [var_message.clone(), rt.create_array([rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'href', val: true }]) }, rt.ArrayItem{ key: 'br', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'code', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'em', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'strong', val: []rt.PhpVal{} }]), rt.create_array([rt.ArrayItem{ key: none, val: 'http' }, rt.ArrayItem{ key: none, val: 'https' }])])
	if rt.is_true(rt.identical(rt.get_constant('E_USER_ERROR'), var_error_level)) {
		rt.throw_exception(rt.new_object('WP_Exception', []string{}, create_wp_exception(var_message.clone())))
	}
	rt.call_function('trigger_error', [var_message.clone(), var_error_level.clone()])
}

fn is_lighttpd_before_150() bool {
	mut var_server_parts := rt.new_null()
	var_server_parts = rt.call_function('explode', [rt.new_string('/'), if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')) } else { rt.new_string('') }])
	var_server_parts.array_set(1, if !(var_server_parts.array_get(rt.new_int(1))).is_null() { var_server_parts.array_get(rt.new_int(1)) } else { rt.new_string('') })
	return rt.is_true(rt.identical(rt.new_string('lighttpd'), var_server_parts.array_get(rt.new_int(0)))) && rt.is_true(rt.identical(-1, rt.call_function('version_compare', [var_server_parts.array_get(rt.new_int(1)), rt.new_string('1.5.0')])))
}

fn apache_mod_loaded(var_mod rt.PhpVal, default_value bool) bool {
	mut var_default_value := default_value
	mut var_is_apache := rt.new_null()
	mut var_loaded_mods := rt.new_null()
	mut var_phpinfo := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_apache)))) {
		return false
	}
	var_loaded_mods = []rt.PhpVal{}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('apache_get_modules')])) {
		var_loaded_mods = rt.call_function('apache_get_modules', []rt.PhpVal{})
		if rt.is_true(rt.call_function('in_array', [var_mod.clone(), var_loaded_mods.clone(), rt.new_bool(true)])) {
			return true
		}
	}
	if !rt.is_true(var_loaded_mods) && rt.is_true(rt.call_function('function_exists', [rt.new_string('phpinfo')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.call_function('ini_get', [rt.new_string('disable_functions')]), rt.new_string('phpinfo')]))))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('phpinfo', [rt.get_constant('INFO_MODULES')])
		var_phpinfo = rt.call_function('ob_get_clean', []rt.PhpVal{})
		if rt.is_true(rt.call_function('str_contains', [var_phpinfo.clone(), var_mod.clone()])) {
			return true
		}
	}
	return default_value
}

fn iis7_supports_permalinks() rt.PhpVal {
	mut var_is_iis7 := rt.new_null()
	mut var_supports_permalinks := false
	var_supports_permalinks = false
	if rt.is_true(var_is_iis7) {
	var_supports_permalinks = rt.is_true(rt.call_function('class_exists', [rt.new_string('DOMDocument'), rt.new_bool(false)])) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('IIS_UrlRewriteModule')) && rt.is_true(rt.identical(rt.new_string('cgi-fcgi'), rt.get_constant('PHP_SAPI')))
	}
	return rt.call_function('apply_filters', [rt.new_string('iis7_supports_permalinks'), rt.new_bool(var_supports_permalinks).clone()])
}

fn validate_file(var_file_arg rt.PhpVal, var_allowed_files_arg rt.PhpVal) i64 {
	mut var_file := var_file_arg
	mut var_allowed_files := var_allowed_files_arg
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [rt.new_string((var_file).str()).clone()]))))) || rt.is_true(rt.identical(rt.new_string(''), rt.new_string((var_file).str()))) {
		return 0
	}
	var_file = wp_normalize_path(var_file)
	var_allowed_files = rt.call_function('array_map', [rt.new_string('wp_normalize_path'), var_allowed_files.clone()])
	if rt.is_true(rt.identical(rt.new_string('../'), rt.new_string((var_file).str()))) {
		return 1
	}
	if rt.is_true(rt.call_function('preg_match_all', [rt.new_string('#\\.\\./#'), rt.new_string((var_file).str()).clone(), rt.create_array_from_list(var_matches), rt.get_constant('PREG_SET_ORDER')])) && var_matches.len > 1 {
		return 1
	}
	if rt.is_true(rt.call_function('str_contains', [rt.new_string((var_file).str()).clone(), rt.new_string('../')])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('../'), rt.call_function('mb_substr', [rt.new_string((var_file).str()).clone(), rt.new_int(-3), rt.new_int(3)]))))) {
		return 1
	}
	if !(!rt.is_true(var_allowed_files)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string((var_file).str()).clone(), var_allowed_files.clone(), rt.new_bool(true)]))))) {
		return 3
	}
	if rt.is_true(rt.identical(rt.new_string(':'), rt.call_function('substr', [rt.new_string((var_file).str()).clone(), rt.new_int(1), rt.new_int(1)]))) {
		return 2
	}
	return 0
}

fn force_ssl_admin(var_force rt.PhpVal) rt.PhpVal {
	mut var_old_forced := rt.new_null()
	mut var_forced := rt.new_null()
	if !(var_force.clone().is_null()) {
		var_old_forced = var_forced.clone()
		var_forced = rt.new_bool((var_force).to_bool())
		return var_old_forced.clone()
	}
	return var_forced.clone()
}

fn wp_guess_url() string {
	mut var_url := rt.new_null()
	mut var_abspath_fix := rt.new_null()
	mut var_script_filename_dir := rt.new_null()
	mut var_path := rt.new_null()
	mut var_directory := rt.new_null()
	mut var_subdirectory := rt.new_null()
	mut var_schema := ''
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_SITEURL')])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_constant('WP_SITEURL'))))) {
	var_url = rt.get_constant('WP_SITEURL')
	} else {
		var_abspath_fix = rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.get_constant('ABSPATH')])
		var_script_filename_dir = rt.call_function('dirname', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_FILENAME'))])
		if rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')), rt.new_string('wp-admin')])) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')), rt.new_string('wp-login.php')])) {
		var_path = rt.call_function('preg_replace', [rt.new_string('#/(wp-admin/?.*|wp-login\\.php.*)#i'), rt.new_string(''), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])
		} else if rt.is_true(rt.identical((var_script_filename_dir).str() + '/', var_abspath_fix)) {
		var_path = rt.call_function('preg_replace', [rt.new_string('#/[^/]*$#i'), rt.new_string(''), rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF'))])
		} else {
			if rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_FILENAME')), var_abspath_fix.clone()])) {
			var_directory = rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), var_script_filename_dir.clone()])
			var_path = rt.call_function('preg_replace', [rt.new_string('#/' + (rt.call_function('preg_quote', [var_directory.clone(), rt.new_string('#')])).str() + '/[^/]*$#i'), rt.new_string(''), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])
			} else if rt.is_true(rt.call_function('str_contains', [var_abspath_fix.clone(), var_script_filename_dir.clone()])) {
			var_subdirectory = rt.call_function('substr', [var_abspath_fix.clone(), rt.add(rt.call_function('strpos', [var_abspath_fix.clone(), var_script_filename_dir.clone()]), rt.new_int(var_script_filename_dir.clone().to_string().len))])
			var_path = rt.new_string((rt.call_function('preg_replace', [rt.new_string('#/[^/]*$#i'), rt.new_string(''), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])).str() + (var_subdirectory).str())
			} else {
			var_path = rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))
			}
		}
	var_schema = if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) { 'https://' } else { 'http://' }
	var_url = rt.new_string((var_schema + (rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() + (var_path).str()).str())
	}
	return var_url.clone().to_string().trim_right(' \t\n\r')
}

fn wp_suspend_cache_addition(var_suspend rt.PhpVal) rt.PhpVal {
	mut var__suspend := rt.new_null()
	if rt.is_true(rt.new_bool(var_suspend.clone().is_bool())) {
	var__suspend = var_suspend
	}
	return var__suspend.clone()
}

fn wp_suspend_cache_invalidation(suspend bool) rt.PhpVal {
	mut var_suspend := suspend
	mut var_current_suspend := rt.new_null()
	mut var__wp_suspend_cache_invalidation := false
	var_current_suspend = rt.new_bool(var__wp_suspend_cache_invalidation).clone()
	var__wp_suspend_cache_invalidation = suspend
	return var_current_suspend.clone()
}

fn is_main_site(var_site_id_arg rt.PhpVal, var_network_id rt.PhpVal) bool {
	mut var_site_id := var_site_id_arg
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_id)))) {
	var_site_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	var_site_id = rt.new_int((var_site_id).to_i64())
	return (rt.identical(rt.new_int(get_main_site_id(var_network_id.clone())), var_site_id)).to_bool()
}

fn get_main_site_id(var_network_id rt.PhpVal) i64 {
	mut var_network := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return (rt.call_function('get_current_blog_id', []rt.PhpVal{})).to_i64()
	}
	var_network = rt.call_function('get_network', [var_network_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_network)))) {
		return 0
	}
	return (rt.get_property(var_network, 'site_id')).to_i64()
}

fn is_main_network(var_network_id_arg rt.PhpVal) bool {
	mut var_network_id := var_network_id_arg
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_null(), var_network_id)) {
	var_network_id = rt.call_function('get_current_network_id', []rt.PhpVal{})
	}
	var_network_id = rt.new_int((var_network_id).to_i64())
	return (rt.identical(rt.new_int(get_main_network_id()), var_network_id)).to_bool()
}

fn get_main_network_id() i64 {
	mut var_current_network := rt.new_null()
	mut var_main_network_id := rt.new_null()
	mut var__networks := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return 1
	}
	var_current_network = rt.call_function('get_network', []rt.PhpVal{})
	if rt.is_true(rt.call_function('defined', [rt.new_string('PRIMARY_NETWORK_ID')])) {
	var_main_network_id = rt.get_constant('PRIMARY_NETWORK_ID')
	} else if !(rt.get_property(var_current_network, 'id')).is_null() && 1 == rt.new_int((rt.get_property(var_current_network, 'id')).to_i64()) {
	var_main_network_id = rt.new_int(1)
	} else {
	var__networks = rt.call_function('get_networks', [rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'number', val: 1 }])])
	var_main_network_id = rt.call_function('array_shift', [var__networks.clone()])
	}
	return rt.new_int((rt.call_function('apply_filters', [rt.new_string('get_main_network_id'), var_main_network_id.clone()])).to_i64())
}

fn is_site_meta_supported() bool {
	mut var_wpdb := rt.new_null()
	mut var_network_id := i64(0)
	mut var_supported := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return false
	}
	var_network_id = get_main_network_id()
	var_supported = rt.call_function('get_network_option', [rt.new_int(var_network_id).clone(), rt.new_string('site_meta_supported'), rt.new_bool(false)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_supported)) {
		var_supported = rt.new_int(if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW TABLES LIKE \''), rt.get_property(var_wpdb, 'blogmeta')), rt.new_string('\''))])) { 1 } else { 0 })
		rt.call_function('update_network_option', [rt.new_int(var_network_id).clone(), rt.new_string('site_meta_supported'), var_supported.clone()])
	}
	return (var_supported).to_bool()
}

fn wp_timezone_override_offset() bool {
	mut var_timezone_string := rt.new_null()
	mut var_timezone_object := rt.new_null()
	mut var_datetime_object := rt.new_null()
	var_timezone_string = rt.call_function('get_option', [rt.new_string('timezone_string')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_timezone_string)))) {
		return false
	}
	var_timezone_object = rt.call_function('timezone_open', [var_timezone_string.clone()])
	var_datetime_object = rt.call_function('date_create', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_timezone_object)) || rt.is_true(rt.identical(rt.new_bool(false), var_datetime_object)) {
		return false
	}
	return (rt.call_function('round', [rt.div(rt.call_function('timezone_offset_get', [var_timezone_object.clone(), var_datetime_object.clone()]), rt.get_constant('HOUR_IN_SECONDS')), rt.new_int(2)])).to_bool()
}

fn _wp_timezone_choice_usort_callback(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.identical(rt.new_string('Etc'), var_a.array_get(rt.new_string('continent')))) && rt.is_true(rt.identical(rt.new_string('Etc'), var_b.array_get(rt.new_string('continent')))) {
		if rt.is_true(rt.call_function('str_starts_with', [var_a.array_get(rt.new_string('city')), rt.new_string('GMT+')])) && rt.is_true(rt.call_function('str_starts_with', [var_b.array_get(rt.new_string('city')), rt.new_string('GMT+')])) {
			return (rt.mul(-1, rt.call_function('strnatcasecmp', [var_a.array_get(rt.new_string('city')), var_b.array_get(rt.new_string('city'))]))).to_i64()
		}
		if rt.is_true(rt.identical(rt.new_string('UTC'), var_a.array_get(rt.new_string('city')))) {
			if rt.is_true(rt.call_function('str_starts_with', [var_b.array_get(rt.new_string('city')), rt.new_string('GMT+')])) {
				return 1
			}
			return -1
		}
		if rt.is_true(rt.identical(rt.new_string('UTC'), var_b.array_get(rt.new_string('city')))) {
			if rt.is_true(rt.call_function('str_starts_with', [var_a.array_get(rt.new_string('city')), rt.new_string('GMT+')])) {
				return -1
			}
			return 1
		}
		return (rt.call_function('strnatcasecmp', [var_a.array_get(rt.new_string('city')), var_b.array_get(rt.new_string('city'))])).to_i64()
	}
	if rt.is_true(rt.identical(var_a.array_get(rt.new_string('t_continent')), var_b.array_get(rt.new_string('t_continent')))) {
		if rt.is_true(rt.identical(var_a.array_get(rt.new_string('t_city')), var_b.array_get(rt.new_string('t_city')))) {
			return (rt.call_function('strnatcasecmp', [var_a.array_get(rt.new_string('t_subcity')), var_b.array_get(rt.new_string('t_subcity'))])).to_i64()
		}
		return (rt.call_function('strnatcasecmp', [var_a.array_get(rt.new_string('t_city')), var_b.array_get(rt.new_string('t_city'))])).to_i64()
	} else {
		if rt.is_true(rt.identical(rt.new_string('Etc'), var_a.array_get(rt.new_string('continent')))) {
			return 1
		}
		if rt.is_true(rt.identical(rt.new_string('Etc'), var_b.array_get(rt.new_string('continent')))) {
			return -1
		}
		return (rt.call_function('strnatcasecmp', [var_a.array_get(rt.new_string('t_continent')), var_b.array_get(rt.new_string('t_continent'))])).to_i64()
	}
	return 0
}

fn wp_timezone_choice(var_selected_zone rt.PhpVal, var_locale rt.PhpVal) rt.PhpVal {
	mut var_continents := []rt.PhpVal{}
	mut var_locale_loaded := rt.new_null()
	mut var_mofile := rt.new_null()
	mut var_mo_loaded := false
	mut var_tz_identifiers := rt.new_null()
	mut var_zonen := rt.new_null()
	mut var_zone := rt.new_null()
	mut var_exists := []rt.PhpVal{}
	mut var_structure := []rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_value := rt.new_null()
	mut var_display := rt.new_null()
	mut var_label := rt.new_null()
	mut var_selected := ''
	mut var_offset_range := []rt.PhpVal{}
	mut var_offset := rt.new_null()
	mut var_offset_name := rt.new_null()
	mut var_offset_value := rt.new_null()
	var_continents = ['Africa', 'America', 'Antarctica', 'Arctic', 'Asia', 'Atlantic', 'Australia', 'Europe', 'Indian', 'Pacific']
	if !(var_mo_loaded) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_locale, var_locale_loaded)))) {
		var_locale_loaded = if rt.is_true(var_locale) { var_locale } else { rt.call_function('get_locale', []rt.PhpVal{}) }
		var_mofile = rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/continents-cities-' + (var_locale_loaded).str() + '.mo')
		rt.call_function('unload_textdomain', [rt.new_string('continents-cities'), rt.new_bool(true)])
		rt.call_function('load_textdomain', [rt.new_string('continents-cities'), var_mofile.clone(), var_locale_loaded.clone()])
	var_mo_loaded = true
	}
	var_tz_identifiers = rt.call_function('timezone_identifiers_list', []rt.PhpVal{})
	var_zonen = []rt.PhpVal{}
	mut iter_35 := var_tz_identifiers.iterator()
	for {
		item_35 := iter_35.next() or { break }
		mut var_zone_shadow := item_35.val
		var_zone_shadow = rt.call_function('explode', [rt.new_string('/'), var_zone_shadow.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_zone_shadow.array_get(rt.new_int(0)), rt.create_array_from_list(var_continents), rt.new_bool(true)]))))) {
			continue
		}
		var_exists = [var_zone_shadow.array_isset(rt.new_int(0)) && rt.is_true(var_zone_shadow.array_get(rt.new_int(0))), var_zone_shadow.array_isset(rt.new_int(1)) && rt.is_true(var_zone_shadow.array_get(rt.new_int(1))), var_zone_shadow.array_isset(rt.new_int(2)) && rt.is_true(var_zone_shadow.array_get(rt.new_int(2)))]
		var_exists[3] = rt.is_true(rt.new_bool(var_exists[0])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('Etc'), var_zone_shadow.array_get(rt.new_int(0))))))
		var_exists[4] = rt.is_true(rt.new_bool(var_exists[1])) && rt.is_true(rt.new_bool(var_exists[3]))
		var_exists[5] = rt.is_true(rt.new_bool(var_exists[2])) && rt.is_true(rt.new_bool(var_exists[3]))
		var_zonen.array_push(rt.create_array([rt.ArrayItem{ key: 'continent', val: if rt.is_true(rt.new_bool(var_exists[0])) { var_zone_shadow.array_get(rt.new_int(0)) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'city', val: if rt.is_true(rt.new_bool(var_exists[1])) { var_zone_shadow.array_get(rt.new_int(1)) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'subcity', val: if rt.is_true(rt.new_bool(var_exists[2])) { var_zone_shadow.array_get(rt.new_int(2)) } else { rt.new_string('') } }, rt.ArrayItem{ key: 't_continent', val: if rt.is_true(rt.new_bool(var_exists[3])) { rt.call_function('translate', [rt.call_function('str_replace', [rt.new_string('_'), rt.new_string(' '), var_zone_shadow.array_get(rt.new_int(0))]), rt.new_string('continents-cities')]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 't_city', val: if rt.is_true(rt.new_bool(var_exists[4])) { rt.call_function('translate', [rt.call_function('str_replace', [rt.new_string('_'), rt.new_string(' '), var_zone_shadow.array_get(rt.new_int(1))]), rt.new_string('continents-cities')]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 't_subcity', val: if rt.is_true(rt.new_bool(var_exists[5])) { rt.call_function('translate', [rt.call_function('str_replace', [rt.new_string('_'), rt.new_string(' '), var_zone_shadow.array_get(rt.new_int(2))]), rt.new_string('continents-cities')]) } else { rt.new_string('') } }]))
	}
	rt.call_function('usort', [var_zonen.clone(), rt.new_string('_wp_timezone_choice_usort_callback')])
	var_structure = []rt.PhpVal{}
	if !rt.is_true(var_selected_zone) {
		var_structure << '<option selected="selected" value="">' + (rt.call_function('__', [rt.new_string('Select a city')])).str() + '</option>'
	}
	if rt.is_true(rt.identical(rt.call_function('in_array', [var_selected_zone.clone(), var_tz_identifiers.clone(), rt.new_bool(true)]), rt.new_bool(false))) && rt.is_true(rt.call_function('in_array', [var_selected_zone.clone(), rt.call_function('timezone_identifiers_list', [Class_DateTimeZone.all_with_bc()]), rt.new_bool(true)])) {
		var_structure << '<option selected="selected" value="' + (rt.call_function('esc_attr', [var_selected_zone.clone()])).str() + '" dir="auto">' + (rt.call_function('esc_html', [var_selected_zone.clone()])).str() + '</option>'
	}
	mut iter_36 := var_zonen.iterator()
	for {
		item_36 := iter_36.next() or { break }
		mut var_zone_shadow := item_36.val
		mut var_key_shadow := item_36.key
		var_value = rt.create_array([rt.ArrayItem{ key: none, val: var_zone_shadow.array_get(rt.new_string('continent')) }])
		if !rt.is_true(var_zone_shadow.array_get(rt.new_string('city'))) {
		var_display = var_zone_shadow.array_get(rt.new_string('t_continent'))
		} else {
			if !(var_zonen.array_isset(rt.sub(var_key_shadow, rt.new_int(1)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_zonen.array_get(rt.sub(var_key_shadow, rt.new_int(1))).array_get(rt.new_string('continent')), var_zone_shadow.array_get(rt.new_string('continent')))))) {
				var_label = var_zone_shadow.array_get(rt.new_string('t_continent'))
				var_structure << '<optgroup label="' + (rt.call_function('esc_attr', [var_label.clone()])).str() + '" dir="auto">'
			}
			var_value.array_push(var_zone_shadow.array_get(rt.new_string('city')))
			var_display = var_zone_shadow.array_get(rt.new_string('t_city'))
			if !(!rt.is_true(var_zone_shadow.array_get(rt.new_string('subcity')))) {
				var_value.array_push(var_zone_shadow.array_get(rt.new_string('subcity')))
				var_display = rt.concat(var_display, rt.new_string(' - ' + (var_zone_shadow.array_get(rt.new_string('t_subcity'))).str()))
			}
		}
		var_value = rt.call_function('implode', [rt.new_string('/'), var_value.clone()])
		var_selected = ''
		if rt.is_true(rt.identical(var_value, var_selected_zone)) {
		var_selected = 'selected="selected" '
		}
		var_structure << '<option ' + var_selected + 'value="' + (rt.call_function('esc_attr', [var_value.clone()])).str() + '" dir="auto">' + (rt.call_function('esc_html', [var_display.clone()])).str() + '</option>'
		if !(!rt.is_true(var_zone_shadow.array_get(rt.new_string('city')))) && !(var_zonen.array_isset(rt.add(var_key_shadow, rt.new_int(1)))) || (var_zonen.array_isset(rt.add(var_key_shadow, rt.new_int(1))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_zonen.array_get(rt.add(var_key_shadow, rt.new_int(1))).array_get(rt.new_string('continent')), var_zone_shadow.array_get(rt.new_string('continent'))))))) {
			var_structure << '</optgroup>'
		}
	}
	var_structure << '<optgroup label="' + (rt.call_function('esc_attr__', [rt.new_string('UTC')])).str() + '" dir="auto">'
	var_selected = ''
	if rt.is_true(rt.identical(rt.new_string('UTC'), var_selected_zone)) {
	var_selected = 'selected="selected" '
	}
	var_structure << '<option ' + var_selected + 'value="' + (rt.call_function('esc_attr', [rt.new_string('UTC')])).str() + '" dir="auto">' + (rt.call_function('__', [rt.new_string('UTC')])).str() + '</option>'
	var_structure << '</optgroup>'
	var_structure << '<optgroup label="' + (rt.call_function('esc_attr__', [rt.new_string('Manual Offsets')])).str() + '" dir="auto">'
	var_offset_range = [-12, -11.5, -11, -10.5, -10, -9.5, -9, -8.5, -8, -7.5, -7, -6.5, -6, -5.5, -5, -4.5, -4, -3.5, -3, -2.5, -2, -1.5, -1, -0.5, rt.new_int(0), rt.new_float(0.5), rt.new_int(1), rt.new_float(1.5), rt.new_int(2), rt.new_float(2.5), rt.new_int(3), rt.new_float(3.5), rt.new_int(4), rt.new_float(4.5), rt.new_int(5), rt.new_float(5.5), rt.new_float(5.75), rt.new_int(6), rt.new_float(6.5), rt.new_int(7), rt.new_float(7.5), rt.new_int(8), rt.new_float(8.5), rt.new_float(8.75), rt.new_int(9), rt.new_float(9.5), rt.new_int(10), rt.new_float(10.5), rt.new_int(11), rt.new_float(11.5), rt.new_int(12), rt.new_float(12.75), rt.new_int(13), rt.new_float(13.75), rt.new_int(14)]
	for var_offset_shadow in var_offset_range {
		if rt.is_true(rt.less_equal(rt.new_int(0), var_offset_shadow)) {
		var_offset_name = rt.new_string('+' + (var_offset_shadow).str())
		} else {
		var_offset_name = rt.new_string((var_offset_shadow).str())
		}
		var_offset_value = var_offset_name.clone()
		var_offset_name = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '.25' }, rt.ArrayItem{ key: none, val: '.5' }, rt.ArrayItem{ key: none, val: '.75' }]), rt.create_array([rt.ArrayItem{ key: none, val: ':15' }, rt.ArrayItem{ key: none, val: ':30' }, rt.ArrayItem{ key: none, val: ':45' }]), var_offset_name.clone()])
		var_offset_name = rt.new_string('UTC' + (var_offset_name).str())
		var_offset_value = rt.new_string('UTC' + (var_offset_value).str())
		var_selected = ''
		if rt.is_true(rt.identical(var_offset_value, var_selected_zone)) {
		var_selected = 'selected="selected" '
		}
		var_structure << '<option ' + var_selected + 'value="' + (rt.call_function('esc_attr', [var_offset_value.clone()])).str() + '" dir="auto">' + (rt.call_function('esc_html', [var_offset_name.clone()])).str() + '</option>'
	}
	var_structure << '</optgroup>'
	return rt.call_function('implode', [rt.new_string('\n'), rt.create_array_from_list(var_structure)])
}

fn _cleanup_header_comment(var_str rt.PhpVal) string {
	return rt.call_function('preg_replace', [rt.new_string('/\\s*(?:\\*\\/|\\?>).*/'), rt.new_string(''), var_str.clone()]).to_string().trim_space()
}

fn wp_scheduled_delete() {
	mut var_wpdb := rt.new_null()
	mut var_delete_timestamp := rt.new_null()
	mut var_posts_to_delete := rt.new_null()
	mut var_post := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_del_post := rt.new_null()
	mut var_comments_to_delete := rt.new_null()
	mut var_comment := map[string]rt.PhpVal{}
	mut var_comment_id := rt.new_null()
	mut var_del_comment := rt.new_null()
	var_delete_timestamp = rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.get_constant('EMPTY_TRASH_DAYS')))
	var_posts_to_delete = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_wp_trash_meta_time\' AND meta_value < %d')), var_delete_timestamp.clone()]), rt.get_constant('ARRAY_A')])
	mut iter_37 := rt.cast_array(var_posts_to_delete).iterator()
	for {
		item_37 := iter_37.next() or { break }
		mut var_post_shadow := item_37.val
		var_post_id = rt.new_int((var_post_shadow.array_get(rt.new_string('post_id'))).to_i64())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
			continue
		}
		var_del_post = rt.call_function('get_post', [var_post_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_del_post)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_del_post, 'post_status'))))) {
			rt.call_function('delete_post_meta', [var_post_id.clone(), rt.new_string('_wp_trash_meta_status')])
			rt.call_function('delete_post_meta', [var_post_id.clone(), rt.new_string('_wp_trash_meta_time')])
		} else {
			rt.call_function('wp_delete_post', [var_post_id.clone()])
		}
	}
	var_comments_to_delete = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT comment_id FROM '), rt.get_property(var_wpdb, 'commentmeta')), rt.new_string(' WHERE meta_key = \'_wp_trash_meta_time\' AND meta_value < %d')), var_delete_timestamp.clone()]), rt.get_constant('ARRAY_A')])
	mut iter_38 := rt.cast_array(var_comments_to_delete).iterator()
	for {
		item_38 := iter_38.next() or { break }
		mut var_comment_shadow := item_38.val
		var_comment_id = rt.new_int((var_comment_shadow['comment_id']).to_i64())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_comment_id)))) {
			continue
		}
		var_del_comment = rt.call_function('get_comment', [var_comment_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_del_comment)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_del_comment, 'comment_approved'))))) {
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('_wp_trash_meta_time')])
			rt.call_function('delete_comment_meta', [var_comment_id.clone(), rt.new_string('_wp_trash_meta_status')])
		} else {
			rt.call_function('wp_delete_comment', [var_del_comment.clone()])
		}
	}
}

fn get_file_data(var_file rt.PhpVal, var_default_headers rt.PhpVal, context string) rt.PhpVal {
	mut var_context := context
	mut var_match := []rt.PhpVal{}
	mut var_file_data := rt.new_null()
	mut var_extra_headers := rt.new_null()
	mut var_all_headers := rt.new_null()
	mut var_regex := rt.new_null()
	mut var_field := rt.new_null()
	var_file_data = rt.call_function('file_get_contents', [var_file.clone(), rt.new_bool(false), rt.new_null(), rt.new_int(0), rt.mul(rt.new_int(8), rt.get_constant('KB_IN_BYTES'))])
	if rt.is_true(rt.identical(rt.new_bool(false), var_file_data)) {
	var_file_data = rt.new_string('')
	}
	var_file_data = rt.call_function('str_replace', [rt.new_string('\r'), rt.new_string('\n'), var_file_data.clone()])
	var_extra_headers = if var_context.len > 0 && var_context != '0' { rt.call_function('apply_filters', [rt.new_string("extra_${var_context}_headers"), []rt.PhpVal{}]) } else { []rt.PhpVal{} }
	if rt.is_true(var_extra_headers) {
	var_extra_headers = rt.call_function('array_combine', [var_extra_headers.clone(), var_extra_headers.clone()])
	var_all_headers = rt.call_function('array_merge', [var_extra_headers.clone(), rt.cast_array(var_default_headers)])
	} else {
	var_all_headers = var_default_headers
	}
	mut iter_39 := var_all_headers.iterator()
	for {
		item_39 := iter_39.next() or { break }
		mut var_regex_shadow := item_39.val
		mut var_field_shadow := item_39.key
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(?:[ \\t]*<\\?php)?[ \\t\\/*#@]*' + (rt.call_function('preg_quote', [var_regex_shadow.clone(), rt.new_string('/')])).str() + ':(.*)$/mi'), var_file_data.clone(), rt.create_array_from_list(var_match)])) && rt.is_true(var_match[1]) {
			var_all_headers.array_set(var_field_shadow, _cleanup_header_comment(var_match[1]))
		} else {
			var_all_headers.array_set(var_field_shadow, '')
		}
	}
	return var_all_headers.clone()
}

fn __return_true() bool {
	return true
}

fn __return_false() bool {
	return false
}

fn __return_zero() i64 {
	return 0
}

fn __return_empty_array() rt.PhpVal {
	return []rt.PhpVal{}
}

fn __return_null() rt.PhpVal {
	return rt.new_null()
}

fn __return_empty_string() string {
	return ''
}

fn send_nosniff_header() {
	rt.call_function('header', [rt.new_string('X-Content-Type-Options: nosniff')])
}

fn _wp_mysql_week(var_column rt.PhpVal) string {
	mut var_start_of_week := rt.new_null()
	var_start_of_week = rt.new_int((rt.call_function('get_option', [rt.new_string('start_of_week')])).to_i64())
	mut switch_val_3 := var_start_of_week
	if rt.is_true(rt.equal(switch_val_3, rt.new_int(1))) {
		return "WEEK( ${var_column.to_string()}, 1 )"
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(2))) || rt.is_true(rt.equal(switch_val_3, rt.new_int(3))) || rt.is_true(rt.equal(switch_val_3, rt.new_int(4))) || rt.is_true(rt.equal(switch_val_3, rt.new_int(5))) || rt.is_true(rt.equal(switch_val_3, rt.new_int(6))) {
		return "WEEK( DATE_SUB( ${var_column.to_string()}, INTERVAL ${var_start_of_week.to_string()} DAY ), 0 )"
	} else {
		return "WEEK( ${var_column.to_string()}, 0 )"
	}
	return ''
}

fn wp_find_hierarchy_loop(var_callback rt.PhpVal, var_start rt.PhpVal, var_start_parent rt.PhpVal, var_callback_args rt.PhpVal) rt.PhpVal {
	mut var_override := rt.new_null()
	mut var_arbitrary_loop_member := rt.new_null()
	var_override = if var_start_parent.clone().is_null() { []rt.PhpVal{} } else { rt.create_array([rt.ArrayItem{ key: var_start, val: var_start_parent }]) }
	var_arbitrary_loop_member = rt.new_bool(wp_find_hierarchy_loop_tortoise_hare(var_callback.clone(), var_start.clone(), var_override.clone(), var_callback_args.clone(), false))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_arbitrary_loop_member)))) {
		return []rt.PhpVal{}
	}
	return rt.new_bool(wp_find_hierarchy_loop_tortoise_hare(var_callback.clone(), var_arbitrary_loop_member.clone(), var_override.clone(), var_callback_args.clone(), true))
}

fn wp_find_hierarchy_loop_tortoise_hare(var_callback rt.PhpVal, var_start rt.PhpVal, var_override rt.PhpVal, var_callback_args rt.PhpVal, _return_loop bool) bool {
	mut var__return_loop := _return_loop
	mut var_tortoise := rt.new_null()
	mut var_hare := rt.new_null()
	mut var_evanescent_hare := rt.new_null()
	mut var_return := rt.new_null()
	var_tortoise = var_start.clone()
	var_hare = var_start.clone()
	var_evanescent_hare = var_start.clone()
	var_return = []rt.PhpVal{}
	var_evanescent_hare = if !(var_override.array_get(var_hare)).is_null() { var_override.array_get(var_hare) } else { rt.call_function('call_user_func_array', [var_callback.clone(), rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: var_hare }]), var_callback_args.clone()])]) }
	var_hare = if !(var_override.array_get(var_evanescent_hare)).is_null() { var_override.array_get(var_evanescent_hare) } else { rt.call_function('call_user_func_array', [var_callback.clone(), rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: var_evanescent_hare }]), var_callback_args.clone()])]) }
	for rt.is_true(var_tortoise) && rt.is_true(var_evanescent_hare) && rt.is_true(var_hare) {
		if var__return_loop {
			var_return.array_set(var_tortoise, true)
			var_return.array_set(var_evanescent_hare, true)
			var_return.array_set(var_hare, true)
		}
		if rt.is_true(rt.identical(var_tortoise, var_evanescent_hare)) || rt.is_true(rt.identical(var_tortoise, var_hare)) {
			return (if var__return_loop { var_return } else { var_tortoise }).to_bool()
		}
	var_tortoise = if !(var_override.array_get(var_tortoise)).is_null() { var_override.array_get(var_tortoise) } else { rt.call_function('call_user_func_array', [var_callback.clone(), rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: var_tortoise }]), var_callback_args.clone()])]) }
	}
	return false
}

fn send_frame_options_header() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('header', [rt.new_string('X-Frame-Options: SAMEORIGIN')])
		rt.call_function('header', [rt.new_string('Content-Security-Policy: frame-ancestors \'self\';')])
	}
}

fn wp_admin_headers() {
	mut var_policy := rt.new_null()
	var_policy = rt.new_string('strict-origin-when-cross-origin')
	var_policy = rt.call_function('apply_filters', [rt.new_string('admin_referrer_policy'), var_policy.clone()])
	rt.call_function('header', [rt.call_function('sprintf', [rt.new_string('Referrer-Policy: %s'), var_policy.clone()])])
}

fn wp_allowed_protocols() rt.PhpVal {
	mut var_protocols := rt.new_null()
	if !rt.is_true(var_protocols) {
	var_protocols = rt.create_array([rt.ArrayItem{ key: none, val: 'http' }, rt.ArrayItem{ key: none, val: 'https' }, rt.ArrayItem{ key: none, val: 'ftp' }, rt.ArrayItem{ key: none, val: 'ftps' }, rt.ArrayItem{ key: none, val: 'mailto' }, rt.ArrayItem{ key: none, val: 'news' }, rt.ArrayItem{ key: none, val: 'irc' }, rt.ArrayItem{ key: none, val: 'irc6' }, rt.ArrayItem{ key: none, val: 'ircs' }, rt.ArrayItem{ key: none, val: 'gopher' }, rt.ArrayItem{ key: none, val: 'nntp' }, rt.ArrayItem{ key: none, val: 'feed' }, rt.ArrayItem{ key: none, val: 'telnet' }, rt.ArrayItem{ key: none, val: 'mms' }, rt.ArrayItem{ key: none, val: 'rtsp' }, rt.ArrayItem{ key: none, val: 'sms' }, rt.ArrayItem{ key: none, val: 'svn' }, rt.ArrayItem{ key: none, val: 'tel' }, rt.ArrayItem{ key: none, val: 'fax' }, rt.ArrayItem{ key: none, val: 'xmpp' }, rt.ArrayItem{ key: none, val: 'webcal' }, rt.ArrayItem{ key: none, val: 'urn' }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp_loaded')]))))) {
	var_protocols = rt.call_function('array_unique', [rt.cast_array(rt.call_function('apply_filters', [rt.new_string('kses_allowed_protocols'), var_protocols.clone()]))])
	}
	return var_protocols.clone()
}

fn wp_debug_backtrace_summary(var_ignore_class rt.PhpVal, skip_frames i64, pretty bool) rt.PhpVal {
	mut var_skip_frames := skip_frames
	mut var_pretty := pretty
	mut var_trace := rt.new_null()
	mut var_caller := []rt.PhpVal{}
	mut var_check_class := false
	mut var_truncate_paths := []rt.PhpVal{}
	mut var_call := map[string]rt.PhpVal{}
	mut var_filename := rt.new_null()
	var_trace = rt.call_function('debug_backtrace', [rt.new_bool(false)])
	var_caller = []rt.PhpVal{}
	var_check_class = !(var_ignore_class.clone().is_null())
	var_skip_frames += 1
	if !(!(var_truncate_paths).is_null()) {
	var_truncate_paths = [wp_normalize_path(rt.get_constant('WP_CONTENT_DIR')), wp_normalize_path(rt.get_constant('ABSPATH'))]
	}
	mut iter_40 := var_trace.iterator()
	for {
		item_40 := iter_40.next() or { break }
		mut var_call_shadow := item_40.val
		if skip_frames > 0 {
			var_skip_frames -= 1
		} else if var_call_shadow.array_isset(rt.new_string('class')) {
			if var_check_class && rt.is_true(rt.identical(var_ignore_class, var_call_shadow['class'])) {
				continue
			}
			var_caller << rt.concat(rt.concat(var_call_shadow['class'], var_call_shadow['type']), var_call_shadow['function'])
		} else {
			if rt.is_true(rt.call_function('in_array', [var_call_shadow['function'], rt.create_array([rt.ArrayItem{ key: none, val: 'do_action' }, rt.ArrayItem{ key: none, val: 'apply_filters' }, rt.ArrayItem{ key: none, val: 'do_action_ref_array' }, rt.ArrayItem{ key: none, val: 'apply_filters_ref_array' }]), rt.new_bool(true)])) {
				var_caller << rt.concat(rt.concat(rt.concat(var_call_shadow['function'], rt.new_string('(\'')), var_call_shadow['args'].array_get(rt.new_int(0))), rt.new_string('\')'))
			} else if rt.is_true(rt.call_function('in_array', [var_call_shadow['function'], rt.create_array([rt.ArrayItem{ key: none, val: 'include' }, rt.ArrayItem{ key: none, val: 'include_once' }, rt.ArrayItem{ key: none, val: 'require' }, rt.ArrayItem{ key: none, val: 'require_once' }]), rt.new_bool(true)])) {
				var_filename = if !(var_call_shadow['args'].array_get(rt.new_int(0))).is_null() { var_call_shadow['args'].array_get(rt.new_int(0)) } else { rt.new_string('') }
				var_caller << (var_call_shadow['function']).str() + '(\'' + (rt.call_function('str_replace', [rt.create_array_from_list(var_truncate_paths), rt.new_string(''), rt.new_string(wp_normalize_path(var_filename.clone()))])).str() + '\')'
			} else {
				var_caller << var_call_shadow['function']
			}
		}
	}
	if var_pretty {
		return rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_reverse', [rt.create_array_from_list(var_caller)])])
	} else {
		return var_caller.clone()
	}
	return rt.new_null()
}

fn _get_non_cached_ids(var_object_ids_arg rt.PhpVal, var_cache_group rt.PhpVal) rt.PhpVal {
	mut var_object_ids := var_object_ids_arg
	mut var_non_cached_ids := []rt.PhpVal{}
	mut var_cache_values := rt.new_null()
	mut var_value := rt.new_null()
	mut var_id := rt.new_null()
	var_object_ids = rt.call_function('array_filter', [var_object_ids.clone(), rt.new_string('_validate_cache_id')])
	var_object_ids = rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('intval'), var_object_ids.clone()]), rt.get_constant('SORT_NUMERIC')])
	if !rt.is_true(var_object_ids) {
		return []rt.PhpVal{}
	}
	var_non_cached_ids = []rt.PhpVal{}
	var_cache_values = rt.call_function('wp_cache_get_multiple', [var_object_ids.clone(), var_cache_group.clone()])
	mut iter_41 := var_cache_values.iterator()
	for {
		item_41 := iter_41.next() or { break }
		mut var_value_shadow := item_41.val
		mut var_id_shadow := item_41.key
		if rt.is_true(rt.identical(rt.new_bool(false), var_value_shadow)) {
			var_non_cached_ids << rt.new_int((var_id_shadow).to_i64())
		}
	}
	return var_non_cached_ids.clone()
}

fn _validate_cache_id(var_object_id rt.PhpVal) bool {
	mut var_message := rt.new_null()
	if var_object_id.clone().is_long() || (var_object_id.clone().is_string() && rt.is_true(rt.identical(rt.new_int((var_object_id).to_i64()).str(), var_object_id))) {
		return true
	}
	var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Object ID must be an integer, %s given.')]), rt.call_function('gettype', [var_object_id.clone()])])
	_doing_it_wrong(rt.new_string('_get_non_cached_ids'), var_message.clone(), '6.3.0')
	return false
}

fn _device_can_upload() bool {
	mut var_version := rt.new_null()
	mut var_ua := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))))) {
		return true
	}
	var_ua = rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT'))
	if rt.is_true(rt.call_function('str_contains', [var_ua.clone(), rt.new_string('iPhone')])) || rt.is_true(rt.call_function('str_contains', [var_ua.clone(), rt.new_string('iPad')])) || rt.is_true(rt.call_function('str_contains', [var_ua.clone(), rt.new_string('iPod')])) {
		return rt.is_true(rt.call_function('preg_match', [rt.new_string('#OS ([\\d_]+) like Mac OS X#'), var_ua.clone(), var_version.clone()])) && rt.is_true(rt.call_function('version_compare', [var_version.array_get(rt.new_int(1)), rt.new_string('6'), rt.new_string('>=')]))
	}
	return true
}

fn wp_is_stream(var_path rt.PhpVal) bool {
	mut var_scheme_separator := rt.new_null()
	mut var_stream := rt.new_null()
	var_scheme_separator = rt.call_function('strpos', [var_path.clone(), rt.new_string('://')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_scheme_separator)) {
		return false
	}
	var_stream = rt.call_function('substr', [var_path.clone(), rt.new_int(0), var_scheme_separator.clone()])
	return (rt.call_function('in_array', [var_stream.clone(), rt.call_function('stream_get_wrappers', []rt.PhpVal{}), rt.new_bool(true)])).to_bool()
}

fn wp_checkdate(var_month rt.PhpVal, var_day rt.PhpVal, var_year rt.PhpVal, var_source_date rt.PhpVal) rt.PhpVal {
	mut var_checkdate := rt.new_null()
	var_checkdate = rt.new_bool(false)
	if var_month.clone().is_long() || var_month.clone().is_double() && var_day.clone().is_long() || var_day.clone().is_double() && var_year.clone().is_long() || var_year.clone().is_double() {
	var_checkdate = rt.call_function('checkdate', [rt.new_int((var_month).to_i64()), rt.new_int((var_day).to_i64()), rt.new_int((var_year).to_i64())])
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_checkdate'), var_checkdate.clone(), var_source_date.clone()])
}

fn wp_auth_check_load() {
	mut var_screen := rt.new_null()
	mut var_hidden := []rt.PhpVal{}
	mut var_show := false
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('IFRAME_REQUEST')])) {
		return
	}
	var_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	var_hidden = ['update', 'update-network', 'update-core', 'update-core-network', 'upgrade', 'upgrade-network', 'network']
	var_show = !(rt.is_true(rt.call_function('in_array', [rt.get_property(var_screen, 'id'), rt.create_array_from_list(var_hidden), rt.new_bool(true)])))
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('wp_auth_check_load'), rt.new_bool(var_show).clone(), var_screen.clone()])) {
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-auth-check')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-auth-check')])
		rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'), rt.new_string('wp_auth_check_html'), rt.new_int(5)])
		rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'), rt.new_string('wp_auth_check_html'), rt.new_int(5)])
	}
}

fn wp_auth_check_html() {
	mut var_login_url := rt.new_null()
	mut var_current_domain := rt.new_null()
	mut var_same_domain := rt.new_null()
	mut var_wrap_class := ''
	mut var_login_src := rt.new_null()
	var_login_url = rt.call_function('wp_login_url', []rt.PhpVal{})
	var_current_domain = rt.new_string((if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) { 'https://' } else { 'http://' } + (rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str()).str())
	var_same_domain = rt.call_function('str_starts_with', [var_login_url.clone(), var_current_domain.clone()])
	var_same_domain = rt.call_function('apply_filters', [rt.new_string('wp_auth_check_same_domain'), var_same_domain.clone()])
	var_wrap_class = if rt.is_true(var_same_domain) { 'hidden' } else { 'hidden fallback' }
	// unsupported statement: Stmt_InlineHTML
	print(var_wrap_class)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Close dialog')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_same_domain) {
		var_login_src = add_query_arg(rt.create_array([rt.ArrayItem{ key: 'interim-login', val: '1' }, rt.ArrayItem{ key: 'wp_lang', val: rt.call_function('get_user_locale', []rt.PhpVal{}) }]), var_login_url.clone())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_login_src.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Session expired')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_login_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Please log in again.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The login page will open in a new tab. After logging in you can close it and return to this page.')])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_auth_check(var_response rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	var_response.array_set('wp-auth-check', rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) && !rt.is_true(var_GLOBALS.array_get(rt.new_string('login_grace_period'))))
	return var_response.clone()
}

fn get_tag_regex(var_tag rt.PhpVal) string {
	if !rt.is_true(var_tag) {
		return ''
	}
	return (rt.call_function('sprintf', [rt.new_string('<%1$s[^<]*(?:>[\\s\\S]*<\\/%1$s>|\\s*\\/>)'), rt.call_function('tag_escape', [var_tag.clone()])])).str()
}

fn is_utf8_charset(var_blog_charset rt.PhpVal) rt.PhpVal {
	return rt.call_function('_is_utf8_charset', [if !(var_blog_charset).is_null() { var_blog_charset } else { rt.call_function('get_option', [rt.new_string('blog_charset')]) }])
}

fn _canonical_charset(var_charset rt.PhpVal) string {
	if rt.is_true(is_utf8_charset(var_charset.clone())) {
		return 'UTF-8'
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.new_string('iso-8859-1'), var_charset.clone()]))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.new_string('iso8859-1'), var_charset.clone()]))) {
		return 'ISO-8859-1'
	}
	return (var_charset).str()
}

fn mbstring_binary_safe_encoding(reset bool) {
	mut var_reset := reset
	mut var_encodings := rt.new_null()
	mut var_overloaded := false
	mut var_encoding := rt.new_null()
	if rt.is_true(rt.new_bool(rt.new_bool(var_overloaded).clone().is_null())) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_internal_encoding')])) && rt.is_true(rt.new_int((rt.call_function('ini_get', [rt.new_string('mbstring.func_overload')])).to_i64()) & 2) {
		var_overloaded = true
		} else {
		var_overloaded = false
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_overloaded))) {
		return
	}
	if !(var_reset) {
		var_encoding = rt.call_function('mb_internal_encoding', []rt.PhpVal{})
		var_encodings.clone().array_push(var_encoding.clone())
		rt.call_function('mb_internal_encoding', [rt.new_string('ISO-8859-1')])
	}
	if var_reset && rt.is_true(var_encodings) {
		var_encoding = rt.call_function('array_pop', [var_encodings.clone()])
		rt.call_function('mb_internal_encoding', [var_encoding.clone()])
	}
}

fn reset_mbstring_encoding() {
	mbstring_binary_safe_encoding(true)
}

fn wp_validate_boolean(var_value rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(var_value.clone().is_bool())) {
		return (var_value).to_bool()
	}
	if var_value.clone().is_string() && rt.is_true(rt.identical(rt.new_string('false'), rt.new_string(var_value.clone().to_string().to_lower()))) {
		return false
	}
	return (var_value).to_bool()
}

fn wp_delete_file(var_file rt.PhpVal) bool {
	mut var_delete := rt.new_null()
	var_delete = rt.call_function('apply_filters', [rt.new_string('wp_delete_file'), var_file.clone()])
	if !(!rt.is_true(var_delete)) {
		return (rt.call_function('unlink', [var_delete.clone()])).to_bool()
	}
	return false
}

fn wp_delete_file_from_directory(var_file rt.PhpVal, var_directory rt.PhpVal) bool {
	mut var_real_file := rt.new_null()
	mut var_real_directory := rt.new_null()
	if rt.is_true(rt.new_bool(wp_is_stream(var_file.clone()))) {
	var_real_file = var_file.clone()
	var_real_directory = var_directory.clone()
	} else {
	var_real_file = rt.call_function('realpath', [rt.new_string(wp_normalize_path(var_file.clone()))])
	var_real_directory = rt.call_function('realpath', [rt.new_string(wp_normalize_path(var_directory.clone()))])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_real_file)))) {
	var_real_file = rt.new_string(wp_normalize_path(var_real_file.clone()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_real_directory)))) {
	var_real_directory = rt.new_string(wp_normalize_path(var_real_directory.clone()))
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_real_file)) || rt.is_true(rt.identical(rt.new_bool(false), var_real_directory)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_real_file.clone(), rt.call_function('trailingslashit', [var_real_directory.clone()])]))))) {
		return false
	}
	return wp_delete_file(var_file.clone())
}

fn wp_post_preview_js() {
	mut var_post := rt.new_null()
	mut var_name := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_preview', []rt.PhpVal{}))))) || !rt.is_true(var_post) {
		return
	}
	var_name = rt.new_string('wp-preview-' + rt.new_int((rt.get_property(var_post, 'ID')).to_i64()).str())
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('rawurlencode', [rt.new_string(@FN)]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_inline_script_tag', [rt.call_function('wp_remove_surrounding_empty_script_tags', [rt.call_function('ob_get_clean', []rt.PhpVal{})])])
}

fn mysql_to_rfc3339(var_date_string rt.PhpVal) bool {
	return mysql2date('Y-m-d\\TH:i:s', var_date_string.clone(), false)
}

fn wp_raise_memory_limit(context string) bool {
	mut var_context := context
	mut var_current_limit := rt.new_null()
	mut var_current_limit_int := rt.new_null()
	mut var_wp_max_limit := rt.new_null()
	mut var_wp_max_limit_int := rt.new_null()
	mut var_filtered_limit := rt.new_null()
	mut var_filtered_limit_int := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_is_ini_value_changeable', [rt.new_string('memory_limit')]))) {
		return false
	}
	var_current_limit = rt.call_function('ini_get', [rt.new_string('memory_limit')])
	var_current_limit_int = rt.call_function('wp_convert_hr_to_bytes', [var_current_limit.clone()])
	if rt.is_true(rt.identical(-1, var_current_limit_int)) {
		return false
	}
	var_wp_max_limit = rt.get_constant('WP_MAX_MEMORY_LIMIT')
	var_wp_max_limit_int = rt.call_function('wp_convert_hr_to_bytes', [var_wp_max_limit.clone()])
	var_filtered_limit = var_wp_max_limit.clone()
	mut switch_val_4 := rt.new_string(context)
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('admin'))) {
	var_filtered_limit = rt.call_function('apply_filters', [rt.new_string('admin_memory_limit'), var_filtered_limit.clone()])
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('image'))) {
	var_filtered_limit = rt.call_function('apply_filters', [rt.new_string('image_memory_limit'), var_filtered_limit.clone()])
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('cron'))) {
	var_filtered_limit = rt.call_function('apply_filters', [rt.new_string('cron_memory_limit'), var_filtered_limit.clone()])
	} else {
	var_filtered_limit = rt.call_function('apply_filters', [rt.new_string("${var_context}_memory_limit"), var_filtered_limit.clone()])
	}
	var_filtered_limit_int = rt.call_function('wp_convert_hr_to_bytes', [var_filtered_limit.clone()])
	if rt.is_true(rt.identical(-1, var_filtered_limit_int)) || (rt.is_true(rt.greater(var_filtered_limit_int, var_wp_max_limit_int)) && rt.is_true(rt.greater(var_filtered_limit_int, var_current_limit_int))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('ini_set', [rt.new_string('memory_limit'), var_filtered_limit.clone()]))))) {
			return (var_filtered_limit).to_bool()
		} else {
			return false
		}
	} else if rt.is_true(rt.identical(-1, var_wp_max_limit_int)) || rt.is_true(rt.greater(var_wp_max_limit_int, var_current_limit_int)) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('ini_set', [rt.new_string('memory_limit'), var_wp_max_limit.clone()]))))) {
			return (var_wp_max_limit).to_bool()
		} else {
			return false
		}
	}
	return false
}

fn wp_generate_uuid4() rt.PhpVal {
	mut var_randomizer := rt.new_null()
	mut var_backup_randomizer := ''
	mut var_e := rt.new_null()
	var_randomizer = rt.new_string((if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_rand')])) { 'wp_rand' } else { var_backup_randomizer }).str())
	if rt.is_true(rt.identical(rt.new_bool(false), var_randomizer)) {
		rt.call_function('random_int', [rt.new_int(0), rt.new_int(15705)])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		var_backup_randomizer = 'random_int'
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		unsafe { goto end_label_3 }

catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'Exception') {
			var_e = var_e_3.clone()
			var_backup_randomizer = 'mt_rand'
			unsafe { goto end_label_3 }
		}
		else {
			rt.throw_exception(var_e_3)
			unsafe { goto end_label_3 }
		}

end_label_3:
	var_randomizer = rt.new_string((var_backup_randomizer).str()).clone()
	}
	return rt.call_function('sprintf', [rt.new_string('%04x%04x-%04x-%04x-%04x-%04x%04x%04x'), rt.call_callable(var_randomizer, [rt.new_int(0), rt.new_int(65535)]), rt.call_callable(var_randomizer, [rt.new_int(0), rt.new_int(65535)]), rt.call_callable(var_randomizer, [rt.new_int(0), rt.new_int(65535)]), rt.bitwise_or(rt.call_callable(var_randomizer, [rt.new_int(0), rt.new_int(4095)]), rt.new_int(16384)), rt.bitwise_or(rt.call_callable(var_randomizer, [rt.new_int(0), rt.new_int(16383)]), rt.new_int(32768)), rt.call_callable(var_randomizer, [rt.new_int(0), rt.new_int(65535)]), rt.call_callable(var_randomizer, [rt.new_int(0), rt.new_int(65535)]), rt.call_callable(var_randomizer, [rt.new_int(0), rt.new_int(65535)])])
}

fn wp_is_uuid(var_uuid rt.PhpVal, var_version rt.PhpVal) bool {
	mut var_regex := ''
	if !(var_uuid.clone().is_string()) {
		return false
	}
	if rt.is_true(rt.new_bool(var_version.clone().is_long() || var_version.clone().is_double())) {
		if rt.is_true(rt.new_bool(4 != rt.new_int((var_version).to_i64()))) {
			_doing_it_wrong(rt.new_string(@FN), rt.call_function('__', [rt.new_string('Only UUID V4 is supported at this time.')]), '4.9.0')
			return false
		}
	var_regex = '/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/'
	} else {
	var_regex = '/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/'
	}
	return (rt.call_function('preg_match', [rt.new_string((var_regex).str()).clone(), var_uuid.clone()])).to_bool()
}

fn wp_unique_id(prefix string) string {
	mut var_prefix := prefix
	mut var_id_counter := rt.new_null()
	return prefix + (rt.pre_inc(var_id_counter)).str()
}

fn wp_unique_prefixed_id(prefix string) string {
	mut var_prefix := prefix
	mut var_id_counters := rt.new_null()
	mut var_id := rt.new_null()
	if !(rt.new_string((var_prefix).str()).is_string()) {
		wp_trigger_error(rt.new_string(@FN), rt.call_function('sprintf', [rt.new_string('The prefix must be a string. "%s" data type given.'), rt.call_function('gettype', [rt.new_string((var_prefix).str())])]), rt.new_null())
	var_prefix = ''
	}
	if !(var_id_counters.array_isset(rt.new_string((var_prefix).str()))) {
		var_id_counters.array_set(var_prefix, 0)
	}
	var_id = rt.pre_inc(var_id_counters.array_get(rt.new_string((var_prefix).str())))
	return var_prefix + (var_id).str()
}

fn wp_unique_id_from_values(var_data rt.PhpVal, prefix string) string {
	mut var_prefix := prefix
	mut var_serialized := rt.new_null()
	mut var_hash := rt.new_null()
	if !rt.is_true(var_data) {
		_doing_it_wrong(rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s parameter must not be empty.')]), rt.new_string('$data')]), '6.8.0')
	}
	var_serialized = wp_json_encode(var_data.clone(), 0, 0)
	var_hash = rt.call_function('substr', [rt.new_string(md5.hexhash(var_serialized.clone().to_string())), rt.new_int(0), rt.new_int(8)])
	return var_prefix + (var_hash).str()
}

fn wp_cache_get_last_changed(var_group rt.PhpVal) rt.PhpVal {
	mut var_last_changed := rt.new_null()
	var_last_changed = rt.call_function('wp_cache_get', [rt.new_string('last_changed'), var_group.clone()])
	if rt.is_true(var_last_changed) {
		return var_last_changed.clone()
	}
	return wp_cache_set_last_changed(var_group.clone())
}

fn wp_cache_set_last_changed(var_group rt.PhpVal) rt.PhpVal {
	mut var_previous_time := rt.new_null()
	mut var_time := rt.new_null()
	var_previous_time = rt.call_function('wp_cache_get', [rt.new_string('last_changed'), var_group.clone()])
	var_time = rt.call_function('microtime', []rt.PhpVal{})
	rt.call_function('wp_cache_set', [rt.new_string('last_changed'), var_time.clone(), var_group.clone()])
	rt.call_function('do_action', [rt.new_string('wp_cache_set_last_changed'), var_group.clone(), var_time.clone(), var_previous_time.clone()])
	return var_time.clone()
}

fn wp_site_admin_email_change_notification(var_old_email rt.PhpVal, var_new_email rt.PhpVal, var_option_name rt.PhpVal) {
	mut var_send := rt.new_null()
	mut var_email_change_text := rt.new_null()
	mut var_email_change_email := rt.new_null()
	mut var_site_name := rt.new_null()
	var_send = rt.new_bool(true)
	if !rt.is_true(var_old_email) || rt.is_true(rt.identical(rt.new_string('you@example.com'), var_old_email)) {
	var_send = rt.new_bool(false)
	}
	var_send = rt.call_function('apply_filters', [rt.new_string('send_site_admin_email_change_email'), var_send.clone(), var_old_email.clone(), var_new_email.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_send)))) {
		return
	}
	var_email_change_text = rt.call_function('__', [rt.new_string('Hi,\n\nThis notice confirms that the admin email address was changed on ###SITENAME###.\n\nThe new admin email address is ###NEW_EMAIL###.\n\nThis email has been sent to ###OLD_EMAIL###\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###')])
	var_email_change_email = rt.create_array([rt.ArrayItem{ key: 'to', val: var_old_email }, rt.ArrayItem{ key: 'subject', val: rt.call_function('__', [rt.new_string('[%s] Admin Email Changed')]) }, rt.ArrayItem{ key: 'message', val: var_email_change_text }, rt.ArrayItem{ key: 'headers', val: '' }])
	var_site_name = rt.call_function('wp_specialchars_decode', [rt.call_function('get_option', [rt.new_string('blogname')]), rt.get_constant('ENT_QUOTES')])
	var_email_change_email = rt.call_function('apply_filters', [rt.new_string('site_admin_email_change_email'), var_email_change_email.clone(), var_old_email.clone(), var_new_email.clone()])
	var_email_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###OLD_EMAIL###'), var_old_email.clone(), var_email_change_email.array_get(rt.new_string('message'))]))
	var_email_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###NEW_EMAIL###'), var_new_email.clone(), var_email_change_email.array_get(rt.new_string('message'))]))
	var_email_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###SITENAME###'), var_site_name.clone(), var_email_change_email.array_get(rt.new_string('message'))]))
	var_email_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###SITEURL###'), rt.call_function('home_url', []rt.PhpVal{}), var_email_change_email.array_get(rt.new_string('message'))]))
	rt.call_function('wp_mail', [var_email_change_email.array_get(rt.new_string('to')), rt.call_function('sprintf', [var_email_change_email.array_get(rt.new_string('subject')), var_site_name.clone()]), var_email_change_email.array_get(rt.new_string('message')), var_email_change_email.array_get(rt.new_string('headers'))])
}

fn wp_privacy_anonymize_ip(var_ip_addr_arg rt.PhpVal, ipv6_fallback bool) string {
	mut var_ipv6_fallback := ipv6_fallback
	mut var_ip_addr := var_ip_addr_arg
	mut var_ip_prefix := ''
	mut var_is_ipv6 := false
	mut var_is_ipv4 := false
	mut var_left_bracket := rt.new_null()
	mut var_right_bracket := rt.new_null()
	mut var_percent := rt.new_null()
	mut var_netmask := ''
	mut var_last_octet_position := rt.new_null()
	if !rt.is_true(var_ip_addr) {
		return '0.0.0.0'
	}
	var_ip_prefix = ''
	var_is_ipv6 = (rt.greater(rt.call_function('substr_count', [var_ip_addr.clone(), rt.new_string(':')]), rt.new_int(1))).to_bool()
	var_is_ipv4 = (rt.identical(rt.new_int(3), rt.call_function('substr_count', [var_ip_addr.clone(), rt.new_string('.')]))).to_bool()
	if var_is_ipv6 && var_is_ipv4 {
	var_ip_prefix = '::ffff:'
	var_ip_addr = rt.call_function('preg_replace', [rt.new_string('/^\\[?[0-9a-f:]*:/i'), rt.new_string(''), var_ip_addr.clone()])
	var_ip_addr = rt.call_function('str_replace', [rt.new_string(']'), rt.new_string(''), var_ip_addr.clone()])
	var_is_ipv6 = false
	}
	if var_is_ipv6 {
		var_left_bracket = rt.call_function('strpos', [var_ip_addr.clone(), rt.new_string('[')])
		var_right_bracket = rt.call_function('strpos', [var_ip_addr.clone(), rt.new_string(']')])
		var_percent = rt.call_function('strpos', [var_ip_addr.clone(), rt.new_string('%')])
		var_netmask = 'ffff:ffff:ffff:ffff:0000:0000:0000:0000'
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_left_bracket)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_right_bracket)))) {
		var_ip_addr = rt.call_function('substr', [var_ip_addr.clone(), rt.add(var_left_bracket, rt.new_int(1)), rt.sub(rt.sub(var_right_bracket, var_left_bracket), rt.new_int(1))])
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_left_bracket)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_right_bracket)))) {
			return '::'
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_percent)))) {
		var_ip_addr = rt.call_function('substr', [var_ip_addr.clone(), rt.new_int(0), var_percent.clone()])
		}
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[^0-9a-f:]/i'), var_ip_addr.clone()])) {
			return '::'
		}
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('inet_pton')])) && rt.is_true(rt.call_function('function_exists', [rt.new_string('inet_ntop')])) {
			var_ip_addr = rt.call_function('inet_ntop', [rt.bitwise_and(rt.call_function('inet_pton', [var_ip_addr.clone()]), rt.call_function('inet_pton', [rt.new_string((var_netmask).str()).clone()]))])
			if rt.is_true(rt.identical(rt.new_bool(false), var_ip_addr)) {
				return '::'
			}
		} else if !(var_ipv6_fallback) {
			return '::'
		}
	} else if var_is_ipv4 {
	var_last_octet_position = rt.call_function('strrpos', [var_ip_addr.clone(), rt.new_string('.')])
	var_ip_addr = rt.new_string((rt.call_function('substr', [var_ip_addr.clone(), rt.new_int(0), var_last_octet_position.clone()])).str() + '.0')
	} else {
		return '0.0.0.0'
	}
	return var_ip_prefix + (var_ip_addr).str()
}

fn wp_privacy_anonymize_data(var_type rt.PhpVal, data string) rt.PhpVal {
	mut var_data := data
	mut var_anonymous := rt.new_null()
	mut switch_val_5 := var_type
	if rt.is_true(rt.equal(switch_val_5, rt.new_string('email'))) {
	var_anonymous = rt.new_string('deleted@site.invalid')
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('url'))) {
	var_anonymous = rt.new_string('https://site.invalid')
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('ip'))) {
	var_anonymous = rt.new_string(wp_privacy_anonymize_ip(rt.new_string(data), false))
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('date'))) {
	var_anonymous = rt.new_string('0000-00-00 00:00:00')
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('text'))) {
	var_anonymous = rt.call_function('__', [rt.new_string('[deleted]')])
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('longtext'))) {
	var_anonymous = rt.call_function('__', [rt.new_string('This content was deleted by the author.')])
	} else {
	var_anonymous = rt.new_string('')
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_privacy_anonymize_data'), var_anonymous.clone(), var_type.clone(), rt.new_string(data)])
}

fn wp_privacy_exports_dir() rt.PhpVal {
	mut var_upload_dir := rt.new_null()
	mut var_exports_dir := rt.new_null()
	var_upload_dir = wp_upload_dir(rt.new_null(), false, false)
	var_exports_dir = rt.new_string((rt.call_function('trailingslashit', [var_upload_dir.array_get(rt.new_string('basedir'))])).str() + 'wp-personal-data-exports/')
	return rt.call_function('apply_filters', [rt.new_string('wp_privacy_exports_dir'), var_exports_dir.clone()])
}

fn wp_privacy_exports_url() rt.PhpVal {
	mut var_upload_dir := rt.new_null()
	mut var_exports_url := rt.new_null()
	var_upload_dir = wp_upload_dir(rt.new_null(), false, false)
	var_exports_url = rt.new_string((rt.call_function('trailingslashit', [var_upload_dir.array_get(rt.new_string('baseurl'))])).str() + 'wp-personal-data-exports/')
	return rt.call_function('apply_filters', [rt.new_string('wp_privacy_exports_url'), var_exports_url.clone()])
}

fn wp_schedule_delete_old_privacy_export_files() {
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('wp_privacy_delete_old_export_files')]))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}), rt.new_string('hourly'), rt.new_string('wp_privacy_delete_old_export_files')])
	}
}

fn wp_privacy_delete_old_export_files() {
	mut var_exports_dir := rt.new_null()
	mut var_export_files := rt.new_null()
	mut var_expiration := rt.new_null()
	mut var_export_file := rt.new_null()
	mut var_file_age_in_seconds := rt.new_null()
	var_exports_dir = wp_privacy_exports_dir()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_exports_dir.clone()]))))) {
		return
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	var_export_files = rt.call_function('list_files', [var_exports_dir.clone(), rt.new_int(100), rt.create_array([rt.ArrayItem{ key: none, val: 'index.php' }])])
	var_expiration = rt.call_function('apply_filters', [rt.new_string('wp_privacy_export_expiration'), rt.mul(rt.new_int(3), rt.get_constant('DAY_IN_SECONDS'))])
	mut iter_42 := rt.cast_array(var_export_files).iterator()
	for {
		item_42 := iter_42.next() or { break }
		mut var_export_file_shadow := item_42.val
		var_file_age_in_seconds = rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.call_function('filemtime', [var_export_file_shadow.clone()]))
		if rt.is_true(rt.less(var_expiration, var_file_age_in_seconds)) {
			rt.call_function('unlink', [var_export_file_shadow.clone()])
		}
	}
}

fn wp_get_update_php_url() rt.PhpVal {
	mut var_default_url := rt.new_null()
	mut var_update_url := rt.new_null()
	var_default_url = wp_get_default_update_php_url()
	var_update_url = var_default_url.clone()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('getenv', [rt.new_string('WP_UPDATE_PHP_URL')]))))) {
	var_update_url = rt.call_function('getenv', [rt.new_string('WP_UPDATE_PHP_URL')])
	}
	var_update_url = rt.call_function('apply_filters', [rt.new_string('wp_update_php_url'), var_update_url.clone()])
	if !rt.is_true(var_update_url) {
	var_update_url = var_default_url.clone()
	}
	return var_update_url.clone()
}

fn wp_get_default_update_php_url() rt.PhpVal {
	return rt.call_function('_x', [rt.new_string('https://wordpress.org/support/update-php/'), rt.new_string('localized PHP upgrade information page')])
}

fn wp_update_php_annotation(before string, after string, display bool) string {
	mut var_before := before
	mut var_after := after
	mut var_display := display
	mut var_annotation := rt.new_null()
	var_annotation = rt.new_string(wp_get_update_php_annotation())
	if rt.is_true(var_annotation) {
		if var_display {
			print(before + (var_annotation).str() + after)
		} else {
			return before + (var_annotation).str() + after
		}
	}
	return ''
}

fn wp_get_update_php_annotation() string {
	mut var_update_url := rt.new_null()
	mut var_default_url := rt.new_null()
	mut var_annotation := rt.new_null()
	var_update_url = wp_get_update_php_url()
	var_default_url = wp_get_default_update_php_url()
	if rt.is_true(rt.identical(var_update_url, var_default_url)) {
		return ''
	}
	var_annotation = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This resource is provided by your web host, and is specific to your site. For more information, <a href="%s" target="_blank">see the official WordPress documentation</a>.')]), rt.call_function('esc_url', [var_default_url.clone()])])
	return (var_annotation).str()
}

fn wp_get_direct_php_update_url() rt.PhpVal {
	mut var_direct_update_url := rt.new_null()
	var_direct_update_url = rt.new_string('')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('getenv', [rt.new_string('WP_DIRECT_UPDATE_PHP_URL')]))))) {
	var_direct_update_url = rt.call_function('getenv', [rt.new_string('WP_DIRECT_UPDATE_PHP_URL')])
	}
	var_direct_update_url = rt.call_function('apply_filters', [rt.new_string('wp_direct_php_update_url'), var_direct_update_url.clone()])
	return var_direct_update_url.clone()
}

fn wp_direct_php_update_button() {
	mut var_direct_update_url := rt.new_null()
	var_direct_update_url = wp_get_direct_php_update_url()
	if !rt.is_true(var_direct_update_url) {
		return
	}
	print('<p class="button-container">')
	rt.call_function('printf', [rt.new_string('<a class="button button-primary" href="%1$s" target="_blank">%2$s<span class="screen-reader-text"> %3$s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a>'), rt.call_function('esc_url', [var_direct_update_url.clone()]), rt.call_function('__', [rt.new_string('Update PHP')]), rt.call_function('__', [rt.new_string('(opens in a new tab)')])])
	print('</p>')
}

fn wp_get_update_https_url() rt.PhpVal {
	mut var_default_url := rt.new_null()
	mut var_update_url := rt.new_null()
	var_default_url = wp_get_default_update_https_url()
	var_update_url = var_default_url.clone()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('getenv', [rt.new_string('WP_UPDATE_HTTPS_URL')]))))) {
	var_update_url = rt.call_function('getenv', [rt.new_string('WP_UPDATE_HTTPS_URL')])
	}
	var_update_url = rt.call_function('apply_filters', [rt.new_string('wp_update_https_url'), var_update_url.clone()])
	if !rt.is_true(var_update_url) {
	var_update_url = var_default_url.clone()
	}
	return var_update_url.clone()
}

fn wp_get_default_update_https_url() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/security/https/')])
}

fn wp_get_direct_update_https_url() rt.PhpVal {
	mut var_direct_update_url := rt.new_null()
	var_direct_update_url = rt.new_string('')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('getenv', [rt.new_string('WP_DIRECT_UPDATE_HTTPS_URL')]))))) {
	var_direct_update_url = rt.call_function('getenv', [rt.new_string('WP_DIRECT_UPDATE_HTTPS_URL')])
	}
	var_direct_update_url = rt.call_function('apply_filters', [rt.new_string('wp_direct_update_https_url'), var_direct_update_url.clone()])
	return var_direct_update_url.clone()
}

fn get_dirsize(var_directory rt.PhpVal, var_max_execution_time rt.PhpVal) rt.PhpVal {
	mut var_size := rt.new_null()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && is_main_site() {
	var_size = rt.new_bool(recurse_dirsize(var_directory.clone(), rt.new_string((var_directory).str() + '/sites'), var_max_execution_time.clone(), rt.new_null()))
	} else {
	var_size = rt.new_bool(recurse_dirsize(var_directory.clone(), rt.new_null(), var_max_execution_time.clone(), rt.new_null()))
	}
	return var_size.clone()
}

fn recurse_dirsize(var_directory_arg rt.PhpVal, var_exclude rt.PhpVal, var_max_execution_time_arg rt.PhpVal, var_directory_cache_arg rt.PhpVal) bool {
	mut var_directory := var_directory_arg
	mut var_max_execution_time := var_max_execution_time_arg
	mut var_directory_cache := var_directory_cache_arg
	mut var_save_cache := false
	mut var_size := rt.new_null()
	mut var_handle := rt.new_null()
	mut var_file := rt.new_null()
	mut var_path := rt.new_null()
	mut var_handlesize := rt.new_null()
	mut var_expiration := rt.new_null()
	var_directory = rt.call_function('untrailingslashit', [var_directory.clone()])
	var_save_cache = false
	if !(!(var_directory_cache).is_null()) {
	var_directory_cache = rt.call_function('get_transient', [rt.new_string('dirsize_cache')])
	var_save_cache = true
	}
	if var_directory_cache.array_isset(var_directory) && var_directory_cache.array_get(var_directory).is_long() {
		return (var_directory_cache.array_get(var_directory)).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_directory.clone()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_directory.clone()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [var_directory.clone()]))))) {
		return false
	}
	if (var_exclude.clone().is_string() && rt.is_true(rt.identical(var_directory, var_exclude))) || (var_exclude.clone().is_array() && rt.is_true(rt.call_function('in_array', [var_directory.clone(), var_exclude.clone(), rt.new_bool(true)]))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_null(), var_max_execution_time)) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('ini_get')])) {
		var_max_execution_time = rt.call_function('ini_get', [rt.new_string('max_execution_time')])
		} else {
		var_max_execution_time = rt.new_int(0)
		}
		if rt.is_true(rt.greater(var_max_execution_time, rt.new_int(10))) {
			var_max_execution_time = rt.sub(var_max_execution_time, rt.new_int(1))
		}
	}
	var_size = rt.call_function('apply_filters', [rt.new_string('pre_recurse_dirsize'), rt.new_bool(false), var_directory.clone(), var_exclude.clone(), var_max_execution_time.clone(), var_directory_cache.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_size)) {
		var_size = rt.new_int(0)
		var_handle = rt.call_function('opendir', [var_directory.clone()])
		if rt.is_true(var_handle) {
			var_file = rt.call_function('readdir', [var_handle.clone()])
			for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_file, rt.new_bool(false))))) {
				var_path = rt.new_string((var_directory).str() + '/' + (var_file).str())
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('.'), var_file)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('..'), var_file)))) {
					if rt.is_true(rt.call_function('is_file', [var_path.clone()])) {
						var_size = rt.add(var_size, rt.call_function('filesize', [var_path.clone()]))
					} else if rt.is_true(rt.call_function('is_dir', [var_path.clone()])) {
						var_handlesize = rt.new_bool(recurse_dirsize(var_path.clone(), var_exclude.clone(), var_max_execution_time.clone(), var_directory_cache.clone()))
						if rt.is_true(rt.greater(var_handlesize, rt.new_int(0))) {
							var_size = rt.add(var_size, var_handlesize)
						}
					}
					if rt.is_true(rt.greater(var_max_execution_time, rt.new_int(0))) && rt.is_true(rt.greater(rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), rt.get_constant('WP_START_TIMESTAMP')), var_max_execution_time)) {
						var_size = rt.new_null()
						break
					}
				}
			}
			rt.call_function('closedir', [var_handle.clone()])
		}
	}
	if !(var_directory_cache.clone().is_array()) {
	var_directory_cache = []rt.PhpVal{}
	}
	var_directory_cache.array_set(var_directory, var_size.clone())
	if var_save_cache {
		var_expiration = if rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{})) { rt.new_int(0) } else { rt.mul(rt.new_int(10), rt.get_constant('YEAR_IN_SECONDS')) }
		rt.call_function('set_transient', [rt.new_string('dirsize_cache'), var_directory_cache.clone(), var_expiration.clone()])
	}
	return (var_size).to_bool()
}

fn clean_dirsize_cache(var_path_arg rt.PhpVal) {
	mut var_path := var_path_arg
	mut var_directory_cache := rt.new_null()
	mut var_expiration := rt.new_null()
	mut var_last_path := rt.new_null()
	if !(var_path.clone().is_string()) || !rt.is_true(var_path) {
		wp_trigger_error(rt.new_string(''), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s only accepts a non-empty path string, received %2$s.')]), rt.new_string('<code>clean_dirsize_cache()</code>'), rt.new_string('<code>' + (rt.call_function('gettype', [var_path.clone()])).str() + '</code>')]), rt.new_null())
		return
	}
	var_directory_cache = rt.call_function('get_transient', [rt.new_string('dirsize_cache')])
	if !rt.is_true(var_directory_cache) {
		return
	}
	var_expiration = if rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{})) { rt.new_int(0) } else { rt.mul(rt.new_int(10), rt.get_constant('YEAR_IN_SECONDS')) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_path.clone(), rt.new_string('/')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_path.clone(), rt.new_string('\\')]))))) {
		var_directory_cache.array_unset(var_path)
		rt.call_function('set_transient', [rt.new_string('dirsize_cache'), var_directory_cache.clone(), var_expiration.clone()])
		return
	}
	var_last_path = rt.new_null()
	var_path = rt.call_function('untrailingslashit', [var_path.clone()])
	var_directory_cache.array_unset(var_path)
	for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_last_path, var_path)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('DIRECTORY_SEPARATOR'), var_path)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('.'), var_path)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('..'), var_path)))) {
		var_last_path = var_path.clone()
		var_path = rt.call_function('dirname', [var_path.clone()])
		var_directory_cache.array_unset(var_path)
	}
	rt.call_function('set_transient', [rt.new_string('dirsize_cache'), var_directory_cache.clone(), var_expiration.clone()])
}

fn wp_get_wp_version() rt.PhpVal {
	mut var_wp_version := rt.new_null()
	if !(!(var_wp_version).is_null()) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '3')
	}
	return var_wp_version.clone()
}

fn is_wp_version_compatible(var_required_arg rt.PhpVal) bool {
	mut var_required := var_required_arg
	mut var_GLOBALS := rt.new_null()
	mut var_version := rt.new_null()
	mut var_wp_version := rt.new_null()
	mut var_trimmed := ''
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')])) && rt.is_true(rt.get_constant('WP_RUN_CORE_TESTS')) && var_GLOBALS.array_isset(rt.new_string('_wp_tests_wp_version')) {
	var_wp_version = var_GLOBALS.array_get(rt.new_string('_wp_tests_wp_version'))
	} else {
	var_wp_version = wp_get_wp_version()
	}
	mut list_tmp_13 := rt.call_function('explode', [rt.new_string('-'), var_wp_version.clone()])
	var_version = (list_tmp_13).array_get(0)
	if rt.is_true(rt.new_bool(var_required.clone().is_string())) {
		var_trimmed = var_required.clone().to_string().trim_space()
		if rt.is_true(rt.greater(rt.call_function('substr_count', [rt.new_string((var_trimmed).str()).clone(), rt.new_string('.')]), rt.new_int(1))) && rt.is_true(rt.call_function('str_ends_with', [rt.new_string((var_trimmed).str()).clone(), rt.new_string('.0')])) {
		var_required = rt.call_function('substr', [rt.new_string((var_trimmed).str()).clone(), rt.new_int(0), rt.new_int(-2)])
		}
	}
	return !rt.is_true(var_required) || rt.is_true(rt.call_function('version_compare', [var_version.clone(), var_required.clone(), rt.new_string('>=')]))
}

fn is_php_version_compatible(var_required rt.PhpVal) bool {
	return !rt.is_true(var_required) || rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), var_required.clone(), rt.new_string('>=')]))
}

fn wp_fuzzy_number_match(var_expected rt.PhpVal, var_actual rt.PhpVal, precision i64) rt.PhpVal {
	mut var_precision := precision
	return rt.less_equal(rt.call_function('abs', [rt.new_float((var_expected).to_f64()) - rt.new_float((var_actual).to_f64())]), rt.new_int(precision))
}

fn wp_get_admin_notice(var_message_arg rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_message := var_message_arg
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_id := rt.new_null()
	mut var_classes := ''
	mut var_attributes := ''
	mut var_trimmed_id := ''
	mut var_type := ''
	mut var_val := rt.new_null()
	mut var_attr := rt.new_null()
	mut var_markup := rt.new_null()
	var_defaults = { 'type': rt.new_string(''), 'dismissible': rt.new_bool(false), 'id': rt.new_string(''), 'additional_classes': []rt.PhpVal{}, 'attributes': []rt.PhpVal{}, 'paragraph_wrap': rt.new_bool(true) }
	var_args = wp_parse_args(var_args.clone(), rt.create_array_from_native_map(var_defaults))
	var_args = rt.call_function('apply_filters', [rt.new_string('wp_admin_notice_args'), var_args.clone(), rt.new_string((var_message).str()).clone()])
	var_id = rt.new_string('')
	var_classes = 'notice'
	var_attributes = ''
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('id')).is_string())) {
		var_trimmed_id = var_args.array_get(rt.new_string('id')).to_string().trim_space()
		if rt.is_true(rt.new_bool('' != var_trimmed_id)) {
		var_id = rt.new_string('id="' + var_trimmed_id + '" ')
		}
	}
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('type')).is_string())) {
		var_type = var_args.array_get(rt.new_string('type')).to_string().trim_space()
		if rt.is_true(rt.call_function('str_contains', [rt.new_string((var_type).str()).clone(), rt.new_string(' ')])) {
			_doing_it_wrong(rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s key must be a string without spaces.')]), rt.new_string('<code>type</code>')]), '6.4.0')
		}
		if rt.is_true(rt.new_bool('' != var_type)) {
			var_classes = var_classes + ' notice-' + var_type
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_args.array_get(rt.new_string('dismissible')))) {
		var_classes = var_classes + ' is-dismissible'
	}
	if var_args.array_get(rt.new_string('additional_classes')).is_array() && !(!rt.is_true(var_args.array_get(rt.new_string('additional_classes')))) {
		var_classes = var_classes + ' ' + (rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('additional_classes'))])).str()
	}
	if var_args.array_get(rt.new_string('attributes')).is_array() && !(!rt.is_true(var_args.array_get(rt.new_string('attributes')))) {
		var_attributes = ''
		mut iter_43 := var_args.array_get(rt.new_string('attributes')).iterator()
		for {
			item_43 := iter_43.next() or { break }
			mut var_val_shadow := item_43.val
			mut var_attr_shadow := item_43.key
			if rt.is_true(rt.new_bool(var_val_shadow.clone().is_bool())) {
				var_attributes = var_attributes + if rt.is_true(var_val_shadow) { ' ' + (var_attr_shadow).str() } else { '' }
			} else if rt.is_true(rt.new_bool(var_attr_shadow.clone().is_long())) {
				var_attributes = var_attributes + ' ' + (rt.call_function('esc_attr', [rt.new_string(var_val_shadow.clone().to_string().trim_space())])).str()
			} else if rt.is_true(var_val_shadow) {
				var_attributes = var_attributes + ' ' + (var_attr_shadow).str() + '="' + (rt.call_function('esc_attr', [rt.new_string(var_val_shadow.clone().to_string().trim_space())])).str() + '"'
			}
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_args.array_get(rt.new_string('paragraph_wrap')))))) {
	var_message = "<p>${var_message}</p>"
	}
	var_markup = rt.call_function('sprintf', [rt.new_string('<div %1$sclass="%2$s"%3$s>%4$s</div>'), var_id.clone(), rt.new_string((var_classes).str()).clone(), rt.new_string((var_attributes).str()).clone(), rt.new_string((var_message).str()).clone()])
	return rt.call_function('apply_filters', [rt.new_string('wp_admin_notice_markup'), var_markup.clone(), rt.new_string((var_message).str()).clone(), var_args.clone()])
}

fn wp_admin_notice(var_message rt.PhpVal, var_args rt.PhpVal) {
	rt.call_function('do_action', [rt.new_string('wp_admin_notice'), var_message.clone(), var_args.clone()])
	rt.echo_val(rt.call_function('wp_kses_post', [wp_get_admin_notice(var_message.clone(), var_args.clone())]))
}

fn wp_is_heic_image_mime_type(var_mime_type rt.PhpVal) rt.PhpVal {
	mut var_heic_mime_types := []rt.PhpVal{}
	var_heic_mime_types = ['image/heic', 'image/heif', 'image/heic-sequence', 'image/heif-sequence']
	return rt.call_function('in_array', [var_mime_type.clone(), rt.create_array_from_list(var_heic_mime_types), rt.new_bool(true)])
}

fn wp_fast_hash(message string) string {
	mut var_message := message
	mut var_hashed := rt.new_null()
	var_hashed = rt.call_function('sodium_crypto_generichash', [rt.new_string((var_message).str()), rt.new_string('wp_fast_hash_6.8+'), rt.new_int(30)])
	return '$generic$' + (rt.call_function('sodium_bin2base64', [var_hashed.clone(), rt.get_constant('SODIUM_BASE64_VARIANT_URLSAFE_NO_PADDING')])).str()
}

fn wp_verify_fast_hash(message string, hash string) bool {
	mut var_message := message
	mut var_hash := hash
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [rt.new_string(hash), rt.new_string('$generic$')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-phpass.php', '4')
		return (rt.call_method(create_passwordhash(rt.new_int(8), rt.new_bool(true)), 'CheckPassword', [rt.new_string((var_message).str()), rt.new_string(hash)])).to_bool()
	}
	return (rt.call_function('hash_equals', [rt.new_string(hash), rt.new_string(wp_fast_hash(var_message))])).to_bool()
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeImmutable {
	rt.PhpObjectBase
}

struct Class_IXR_Error {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_List_Util {
	rt.PhpObjectBase
}

struct Class_WP_Exception {
	rt.PhpObjectBase
}

struct Class_PasswordHash {
	rt.PhpObjectBase
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimeimmutable(_args ...rt.PhpVal) &Class_DateTimeImmutable {
	mut obj := &Class_DateTimeImmutable{
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

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_list_util(_args ...rt.PhpVal) &Class_WP_List_Util {
	mut obj := &Class_WP_List_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_exception(_args ...rt.PhpVal) &Class_WP_Exception {
	mut obj := &Class_WP_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_passwordhash(_args ...rt.PhpVal) &Class_PasswordHash {
	mut obj := &Class_PasswordHash{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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


fn (mut this Class_DateTimeImmutable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeImmutable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeImmutable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_List_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_List_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_List_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_PasswordHash) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PasswordHash) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PasswordHash) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_func('mysql2date', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_bool(mysql2date(arg_0, arg_1, arg_2))
	})
	rt.register_func('current_time', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return current_time(arg_0, arg_1)
	})
	rt.register_func('current_datetime', fn(args []rt.PhpVal) rt.PhpVal {
		return current_datetime()
	})
	rt.register_func('wp_timezone_string', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_timezone_string()
	})
	rt.register_func('wp_timezone', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_timezone()
	})
	rt.register_func('date_i18n', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return date_i18n(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_date', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(wp_date(arg_0, arg_1, arg_2))
	})
	rt.register_func('wp_maybe_decline_date', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wp_maybe_decline_date(arg_0, arg_1)
	})
	rt.register_func('number_format_i18n', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return number_format_i18n(arg_0, arg_1)
	})
	rt.register_func('size_format', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return size_format(arg_0, arg_1)
	})
	rt.register_func('human_readable_duration', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return rt.new_bool(human_readable_duration(arg_0))
	})
	rt.register_func('get_weekstartend', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return get_weekstartend(arg_0, arg_1)
	})
	rt.register_func('maybe_serialize', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return maybe_serialize(arg_0)
	})
	rt.register_func('maybe_unserialize', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return maybe_unserialize(arg_0)
	})
	rt.register_func('is_serialized', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rt.new_bool(is_serialized(arg_0, arg_1))
	})
	rt.register_func('is_serialized_string', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(is_serialized_string(arg_0))
	})
	rt.register_func('xmlrpc_getposttitle', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return xmlrpc_getposttitle(arg_0)
	})
	rt.register_func('xmlrpc_getpostcategory', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return xmlrpc_getpostcategory(arg_0)
	})
	rt.register_func('xmlrpc_removepostdata', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return xmlrpc_removepostdata(arg_0)
	})
	rt.register_func('wp_extract_urls', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_extract_urls(arg_0)
	})
	rt.register_func('do_enclose', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(do_enclose(arg_0, arg_1))
	})
	rt.register_func('wp_get_http_headers', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rt.new_bool(wp_get_http_headers(arg_0, arg_1))
	})
	rt.register_func('is_new_day', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_int(is_new_day())
	})
	rt.register_func('build_query', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return build_query(arg_0)
	})
	rt.register_func('_http_build_query', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		return _http_build_query(arg_0, arg_1, arg_2, arg_3, arg_4)
	})
	rt.register_func('add_query_arg', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return add_query_arg(arg_0)
	})
	rt.register_func('remove_query_arg', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return remove_query_arg(arg_0, arg_1)
	})
	rt.register_func('wp_removable_query_args', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_removable_query_args()
	})
	rt.register_func('add_magic_quotes', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return add_magic_quotes(arg_0)
	})
	rt.register_func('wp_remote_fopen', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_remote_fopen(arg_0))
	})
	rt.register_func('wp', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return wp(arg_0)
	})
	rt.register_func('get_status_header_desc', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(get_status_header_desc(arg_0))
	})
	rt.register_func('status_header', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return status_header(arg_0, arg_1)
	})
	rt.register_func('wp_get_nocache_headers', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_nocache_headers()
	})
	rt.register_func('nocache_headers', fn(args []rt.PhpVal) rt.PhpVal {
		return nocache_headers()
	})
	rt.register_func('cache_javascript_headers', fn(args []rt.PhpVal) rt.PhpVal {
		return cache_javascript_headers()
	})
	rt.register_func('get_num_queries', fn(args []rt.PhpVal) rt.PhpVal {
		return get_num_queries()
	})
	rt.register_func('bool_from_yn', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return bool_from_yn(arg_0)
	})
	rt.register_func('do_feed', fn(args []rt.PhpVal) rt.PhpVal {
		return do_feed()
	})
	rt.register_func('do_feed_rdf', fn(args []rt.PhpVal) rt.PhpVal {
		return do_feed_rdf()
	})
	rt.register_func('do_feed_rss', fn(args []rt.PhpVal) rt.PhpVal {
		return do_feed_rss()
	})
	rt.register_func('do_feed_rss2', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return do_feed_rss2(arg_0)
	})
	rt.register_func('do_feed_atom', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return do_feed_atom(arg_0)
	})
	rt.register_func('do_robots', fn(args []rt.PhpVal) rt.PhpVal {
		return do_robots()
	})
	rt.register_func('do_favicon', fn(args []rt.PhpVal) rt.PhpVal {
		return do_favicon()
	})
	rt.register_func('is_blog_installed', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(is_blog_installed())
	})
	rt.register_func('wp_nonce_url', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return wp_nonce_url(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_nonce_field', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return wp_nonce_field(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('wp_referer_field', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		return wp_referer_field(arg_0)
	})
	rt.register_func('wp_original_referer_field', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wp_original_referer_field(arg_0, arg_1)
	})
	rt.register_func('wp_get_referer', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_get_referer())
	})
	rt.register_func('wp_get_raw_referer', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_get_raw_referer())
	})
	rt.register_func('wp_get_original_referer', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_get_original_referer())
	})
	rt.register_func('wp_mkdir_p', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_mkdir_p(arg_0))
	})
	rt.register_func('path_is_absolute', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(path_is_absolute(arg_0))
	})
	rt.register_func('path_join', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(path_join(arg_0, arg_1))
	})
	rt.register_func('wp_normalize_path', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(wp_normalize_path(arg_0))
	})
	rt.register_func('get_temp_dir', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(get_temp_dir())
	})
	rt.register_func('wp_is_writable', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_is_writable(arg_0)
	})
	rt.register_func('win_is_writable', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(win_is_writable(arg_0))
	})
	rt.register_func('wp_get_upload_dir', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_upload_dir()
	})
	rt.register_func('wp_upload_dir', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return wp_upload_dir(arg_0, arg_1, arg_2)
	})
	rt.register_func('_wp_upload_dir', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _wp_upload_dir(arg_0)
	})
	rt.register_func('wp_unique_filename', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_unique_filename(arg_0, arg_1, arg_2)
	})
	rt.register_func('_wp_check_alternate_file_names', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(_wp_check_alternate_file_names(arg_0, arg_1, arg_2))
	})
	rt.register_func('_wp_check_existing_file_names', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(_wp_check_existing_file_names(arg_0, arg_1))
	})
	rt.register_func('wp_upload_bits', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return wp_upload_bits(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('wp_ext2type', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ext2type(arg_0)
	})
	rt.register_func('wp_get_default_extension_for_mime_type', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_get_default_extension_for_mime_type(arg_0))
	})
	rt.register_func('wp_check_filetype', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_check_filetype(arg_0, arg_1)
	})
	rt.register_func('wp_check_filetype_and_ext', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_check_filetype_and_ext(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_get_image_mime', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_get_image_mime(arg_0))
	})
	rt.register_func('wp_get_mime_types', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_mime_types()
	})
	rt.register_func('wp_get_ext_types', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_ext_types()
	})
	rt.register_func('wp_filesize', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_int(wp_filesize(arg_0))
	})
	rt.register_func('get_allowed_mime_types', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_allowed_mime_types(arg_0)
	})
	rt.register_func('wp_nonce_ays', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_nonce_ays(arg_0)
	})
	rt.register_func('wp_die', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_die(arg_0, arg_1, arg_2)
	})
	rt.register_func('_default_wp_die_handler', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _default_wp_die_handler(arg_0, arg_1, arg_2)
	})
	rt.register_func('_ajax_wp_die_handler', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _ajax_wp_die_handler(arg_0, arg_1, arg_2)
	})
	rt.register_func('_json_wp_die_handler', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _json_wp_die_handler(arg_0, arg_1, arg_2)
	})
	rt.register_func('_jsonp_wp_die_handler', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _jsonp_wp_die_handler(arg_0, arg_1, arg_2)
	})
	rt.register_func('_xmlrpc_wp_die_handler', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _xmlrpc_wp_die_handler(arg_0, arg_1, arg_2)
	})
	rt.register_func('_xml_wp_die_handler', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _xml_wp_die_handler(arg_0, arg_1, arg_2)
	})
	rt.register_func('_scalar_wp_die_handler', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _scalar_wp_die_handler(arg_0, arg_1, arg_2)
	})
	rt.register_func('_wp_die_process_input', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _wp_die_process_input(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_json_encode', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return wp_json_encode(arg_0, arg_1, arg_2)
	})
	rt.register_func('_wp_json_sanity_check', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _wp_json_sanity_check(arg_0, arg_1)
	})
	rt.register_func('_wp_json_convert_string', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _wp_json_convert_string(arg_0)
	})
	rt.register_func('_wp_json_prepare_data', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _wp_json_prepare_data(arg_0)
	})
	rt.register_func('wp_send_json', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return wp_send_json(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_send_json_success', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return wp_send_json_success(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_send_json_error', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return wp_send_json_error(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_check_jsonp_callback', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_check_jsonp_callback(arg_0))
	})
	rt.register_func('wp_json_file_decode', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_json_file_decode(arg_0, arg_1)
	})
	rt.register_func('_config_wp_home', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return rt.new_string(_config_wp_home(arg_0))
	})
	rt.register_func('_config_wp_siteurl', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return rt.new_string(_config_wp_siteurl(arg_0))
	})
	rt.register_func('_delete_option_fresh_site', fn(args []rt.PhpVal) rt.PhpVal {
		return _delete_option_fresh_site()
	})
	rt.register_func('_mce_set_direction', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _mce_set_direction(arg_0)
	})
	rt.register_func('wp_is_serving_rest_request', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_is_serving_rest_request())
	})
	rt.register_func('smilies_init', fn(args []rt.PhpVal) rt.PhpVal {
		return smilies_init()
	})
	rt.register_func('wp_parse_args', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_parse_args(arg_0, arg_1)
	})
	rt.register_func('wp_parse_list', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_parse_list(arg_0)
	})
	rt.register_func('wp_parse_id_list', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_parse_id_list(arg_0)
	})
	rt.register_func('wp_parse_slug_list', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_parse_slug_list(arg_0)
	})
	rt.register_func('wp_array_slice_assoc', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_array_slice_assoc(arg_0, arg_1)
	})
	rt.register_func('wp_recursive_ksort', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_recursive_ksort(arg_0)
	})
	rt.register_func('_wp_array_get', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _wp_array_get(arg_0, arg_1, arg_2)
	})
	rt.register_func('_wp_array_set', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _wp_array_set(arg_0, arg_1, arg_2)
	})
	rt.register_func('_wp_to_kebab_case', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_wp_to_kebab_case(arg_0))
	})
	rt.register_func('wp_is_numeric_array', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_is_numeric_array(arg_0))
	})
	rt.register_func('wp_filter_object_list', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return wp_filter_object_list(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('wp_list_filter', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return wp_list_filter(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_list_pluck', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_list_pluck(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_list_sort', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return wp_list_sort(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('wp_maybe_load_widgets', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_maybe_load_widgets()
	})
	rt.register_func('wp_widgets_add_menu', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_widgets_add_menu()
	})
	rt.register_func('wp_ob_end_flush_all', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ob_end_flush_all()
	})
	rt.register_func('dead_db', fn(args []rt.PhpVal) rt.PhpVal {
		return dead_db()
	})
	rt.register_func('_deprecated_function', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return _deprecated_function(arg_0, arg_1, arg_2)
	})
	rt.register_func('_deprecated_constructor', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return _deprecated_constructor(arg_0, arg_1, arg_2)
	})
	rt.register_func('_deprecated_class', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return _deprecated_class(arg_0, arg_1, arg_2)
	})
	rt.register_func('_deprecated_file', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		return _deprecated_file(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('_deprecated_argument', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return _deprecated_argument(arg_0, arg_1, arg_2)
	})
	rt.register_func('_deprecated_hook', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		return _deprecated_hook(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('_doing_it_wrong', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return _doing_it_wrong(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_trigger_error', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_trigger_error(arg_0, arg_1, arg_2)
	})
	rt.register_func('is_lighttpd_before_150', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(is_lighttpd_before_150())
	})
	rt.register_func('apache_mod_loaded', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rt.new_bool(apache_mod_loaded(arg_0, arg_1))
	})
	rt.register_func('iis7_supports_permalinks', fn(args []rt.PhpVal) rt.PhpVal {
		return iis7_supports_permalinks()
	})
	rt.register_func('validate_file', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_int(validate_file(arg_0, arg_1))
	})
	rt.register_func('force_ssl_admin', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return force_ssl_admin(arg_0)
	})
	rt.register_func('wp_guess_url', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(wp_guess_url())
	})
	rt.register_func('wp_suspend_cache_addition', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_suspend_cache_addition(arg_0)
	})
	rt.register_func('wp_suspend_cache_invalidation', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		return wp_suspend_cache_invalidation(arg_0)
	})
	rt.register_func('is_main_site', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(is_main_site(arg_0, arg_1))
	})
	rt.register_func('get_main_site_id', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_int(get_main_site_id(arg_0))
	})
	rt.register_func('is_main_network', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(is_main_network(arg_0))
	})
	rt.register_func('get_main_network_id', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_int(get_main_network_id())
	})
	rt.register_func('is_site_meta_supported', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(is_site_meta_supported())
	})
	rt.register_func('wp_timezone_override_offset', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_timezone_override_offset())
	})
	rt.register_func('_wp_timezone_choice_usort_callback', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_int(_wp_timezone_choice_usort_callback(arg_0, arg_1))
	})
	rt.register_func('wp_timezone_choice', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_timezone_choice(arg_0, arg_1)
	})
	rt.register_func('_cleanup_header_comment', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_cleanup_header_comment(arg_0))
	})
	rt.register_func('wp_scheduled_delete', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_scheduled_delete()
	})
	rt.register_func('get_file_data', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return get_file_data(arg_0, arg_1, arg_2)
	})
	rt.register_func('__return_true', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(__return_true())
	})
	rt.register_func('__return_false', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(__return_false())
	})
	rt.register_func('__return_zero', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_int(__return_zero())
	})
	rt.register_func('__return_empty_array', fn(args []rt.PhpVal) rt.PhpVal {
		return __return_empty_array()
	})
	rt.register_func('__return_null', fn(args []rt.PhpVal) rt.PhpVal {
		return __return_null()
	})
	rt.register_func('__return_empty_string', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(__return_empty_string())
	})
	rt.register_func('send_nosniff_header', fn(args []rt.PhpVal) rt.PhpVal {
		return send_nosniff_header()
	})
	rt.register_func('_wp_mysql_week', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_wp_mysql_week(arg_0))
	})
	rt.register_func('wp_find_hierarchy_loop', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return wp_find_hierarchy_loop(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('wp_find_hierarchy_loop_tortoise_hare', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		return rt.new_bool(wp_find_hierarchy_loop_tortoise_hare(arg_0, arg_1, arg_2, arg_3, arg_4))
	})
	rt.register_func('send_frame_options_header', fn(args []rt.PhpVal) rt.PhpVal {
		return send_frame_options_header()
	})
	rt.register_func('wp_admin_headers', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_admin_headers()
	})
	rt.register_func('wp_allowed_protocols', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_allowed_protocols()
	})
	rt.register_func('wp_debug_backtrace_summary', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return wp_debug_backtrace_summary(arg_0, arg_1, arg_2)
	})
	rt.register_func('_get_non_cached_ids', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _get_non_cached_ids(arg_0, arg_1)
	})
	rt.register_func('_validate_cache_id', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(_validate_cache_id(arg_0))
	})
	rt.register_func('_device_can_upload', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(_device_can_upload())
	})
	rt.register_func('wp_is_stream', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_is_stream(arg_0))
	})
	rt.register_func('wp_checkdate', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return wp_checkdate(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('wp_auth_check_load', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_auth_check_load()
	})
	rt.register_func('wp_auth_check_html', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_auth_check_html()
	})
	rt.register_func('wp_auth_check', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_auth_check(arg_0)
	})
	rt.register_func('get_tag_regex', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(get_tag_regex(arg_0))
	})
	rt.register_func('is_utf8_charset', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return is_utf8_charset(arg_0)
	})
	rt.register_func('_canonical_charset', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_canonical_charset(arg_0))
	})
	rt.register_func('mbstring_binary_safe_encoding', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		return mbstring_binary_safe_encoding(arg_0)
	})
	rt.register_func('reset_mbstring_encoding', fn(args []rt.PhpVal) rt.PhpVal {
		return reset_mbstring_encoding()
	})
	rt.register_func('wp_validate_boolean', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_validate_boolean(arg_0))
	})
	rt.register_func('wp_delete_file', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_delete_file(arg_0))
	})
	rt.register_func('wp_delete_file_from_directory', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(wp_delete_file_from_directory(arg_0, arg_1))
	})
	rt.register_func('wp_post_preview_js', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_post_preview_js()
	})
	rt.register_func('mysql_to_rfc3339', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(mysql_to_rfc3339(arg_0))
	})
	rt.register_func('wp_raise_memory_limit', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return rt.new_bool(wp_raise_memory_limit(arg_0))
	})
	rt.register_func('wp_generate_uuid4', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_generate_uuid4()
	})
	rt.register_func('wp_is_uuid', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(wp_is_uuid(arg_0, arg_1))
	})
	rt.register_func('wp_unique_id', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return rt.new_string(wp_unique_id(arg_0))
	})
	rt.register_func('wp_unique_prefixed_id', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return rt.new_string(wp_unique_prefixed_id(arg_0))
	})
	rt.register_func('wp_unique_id_from_values', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return rt.new_string(wp_unique_id_from_values(arg_0, arg_1))
	})
	rt.register_func('wp_cache_get_last_changed', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_cache_get_last_changed(arg_0)
	})
	rt.register_func('wp_cache_set_last_changed', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_cache_set_last_changed(arg_0)
	})
	rt.register_func('wp_site_admin_email_change_notification', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_site_admin_email_change_notification(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_privacy_anonymize_ip', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rt.new_string(wp_privacy_anonymize_ip(arg_0, arg_1))
	})
	rt.register_func('wp_privacy_anonymize_data', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wp_privacy_anonymize_data(arg_0, arg_1)
	})
	rt.register_func('wp_privacy_exports_dir', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_privacy_exports_dir()
	})
	rt.register_func('wp_privacy_exports_url', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_privacy_exports_url()
	})
	rt.register_func('wp_schedule_delete_old_privacy_export_files', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_schedule_delete_old_privacy_export_files()
	})
	rt.register_func('wp_privacy_delete_old_export_files', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_privacy_delete_old_export_files()
	})
	rt.register_func('wp_get_update_php_url', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_update_php_url()
	})
	rt.register_func('wp_get_default_update_php_url', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_default_update_php_url()
	})
	rt.register_func('wp_update_php_annotation', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_string(wp_update_php_annotation(arg_0, arg_1, arg_2))
	})
	rt.register_func('wp_get_update_php_annotation', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(wp_get_update_php_annotation())
	})
	rt.register_func('wp_get_direct_php_update_url', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_direct_php_update_url()
	})
	rt.register_func('wp_direct_php_update_button', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_direct_php_update_button()
	})
	rt.register_func('wp_get_update_https_url', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_update_https_url()
	})
	rt.register_func('wp_get_default_update_https_url', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_default_update_https_url()
	})
	rt.register_func('wp_get_direct_update_https_url', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_direct_update_https_url()
	})
	rt.register_func('get_dirsize', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return get_dirsize(arg_0, arg_1)
	})
	rt.register_func('recurse_dirsize', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_bool(recurse_dirsize(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('clean_dirsize_cache', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return clean_dirsize_cache(arg_0)
	})
	rt.register_func('wp_get_wp_version', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_wp_version()
	})
	rt.register_func('is_wp_version_compatible', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(is_wp_version_compatible(arg_0))
	})
	rt.register_func('is_php_version_compatible', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(is_php_version_compatible(arg_0))
	})
	rt.register_func('wp_fuzzy_number_match', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return wp_fuzzy_number_match(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_get_admin_notice', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_get_admin_notice(arg_0, arg_1)
	})
	rt.register_func('wp_admin_notice', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_admin_notice(arg_0, arg_1)
	})
	rt.register_func('wp_is_heic_image_mime_type', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_is_heic_image_mime_type(arg_0)
	})
	rt.register_func('wp_fast_hash', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return rt.new_string(wp_fast_hash(arg_0))
	})
	rt.register_func('wp_verify_fast_hash', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return rt.new_bool(wp_verify_fast_hash(arg_0, arg_1))
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		fn () { print((rt.new_string('-1')).str()); exit(0) }()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/option.php', '3')
}

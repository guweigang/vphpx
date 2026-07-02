import rt

struct Class_WP_Locale {
	rt.PhpObjectBase
pub mut:
	weekday             rt.PhpVal = rt.new_array()
	weekday_initial     rt.PhpVal = rt.new_array()
	weekday_abbrev      rt.PhpVal = rt.new_array()
	month               rt.PhpVal = rt.new_array()
	month_genitive      rt.PhpVal = rt.new_array()
	month_abbrev        rt.PhpVal = rt.new_array()
	meridiem            rt.PhpVal = rt.new_array()
	text_direction      rt.PhpVal = rt.new_string('ltr')
	number_format       rt.PhpVal = rt.new_array()
	list_item_separator rt.PhpVal = rt.new_null()
	word_count_type     rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Locale) construct() {
	this.init()
	this.register_globals()
}

fn (mut this Class_WP_Locale) init() {
	mut var_GLOBALS := rt.new_null()
	this.weekday.array_set(0, rt.call_function('__', [rt.new_string('Sunday')]))
	this.weekday.array_set(1, rt.call_function('__', [rt.new_string('Monday')]))
	this.weekday.array_set(2, rt.call_function('__', [rt.new_string('Tuesday')]))
	this.weekday.array_set(3, rt.call_function('__', [rt.new_string('Wednesday')]))
	this.weekday.array_set(4, rt.call_function('__', [rt.new_string('Thursday')]))
	this.weekday.array_set(5, rt.call_function('__', [rt.new_string('Friday')]))
	this.weekday.array_set(6, rt.call_function('__', [rt.new_string('Saturday')]))
	this.weekday_initial.array_set(this.weekday.array_get(rt.new_int(0)), rt.call_function('_x', [
		rt.new_string('S'),
		rt.new_string('Sunday initial'),
	]))
	this.weekday_initial.array_set(this.weekday.array_get(rt.new_int(1)), rt.call_function('_x', [
		rt.new_string('M'),
		rt.new_string('Monday initial'),
	]))
	this.weekday_initial.array_set(this.weekday.array_get(rt.new_int(2)), rt.call_function('_x', [
		rt.new_string('T'),
		rt.new_string('Tuesday initial'),
	]))
	this.weekday_initial.array_set(this.weekday.array_get(rt.new_int(3)), rt.call_function('_x', [
		rt.new_string('W'),
		rt.new_string('Wednesday initial'),
	]))
	this.weekday_initial.array_set(this.weekday.array_get(rt.new_int(4)), rt.call_function('_x', [
		rt.new_string('T'),
		rt.new_string('Thursday initial'),
	]))
	this.weekday_initial.array_set(this.weekday.array_get(rt.new_int(5)), rt.call_function('_x', [
		rt.new_string('F'),
		rt.new_string('Friday initial'),
	]))
	this.weekday_initial.array_set(this.weekday.array_get(rt.new_int(6)), rt.call_function('_x', [
		rt.new_string('S'),
		rt.new_string('Saturday initial'),
	]))
	this.weekday_abbrev.array_set(this.weekday.array_get(rt.new_int(0)), rt.call_function('__', [
		rt.new_string('Sun'),
	]))
	this.weekday_abbrev.array_set(this.weekday.array_get(rt.new_int(1)), rt.call_function('__', [
		rt.new_string('Mon'),
	]))
	this.weekday_abbrev.array_set(this.weekday.array_get(rt.new_int(2)), rt.call_function('__', [
		rt.new_string('Tue'),
	]))
	this.weekday_abbrev.array_set(this.weekday.array_get(rt.new_int(3)), rt.call_function('__', [
		rt.new_string('Wed'),
	]))
	this.weekday_abbrev.array_set(this.weekday.array_get(rt.new_int(4)), rt.call_function('__', [
		rt.new_string('Thu'),
	]))
	this.weekday_abbrev.array_set(this.weekday.array_get(rt.new_int(5)), rt.call_function('__', [
		rt.new_string('Fri'),
	]))
	this.weekday_abbrev.array_set(this.weekday.array_get(rt.new_int(6)), rt.call_function('__', [
		rt.new_string('Sat'),
	]))
	this.month.array_set('01', rt.call_function('__', [rt.new_string('January')]))
	this.month.array_set('02', rt.call_function('__', [rt.new_string('February')]))
	this.month.array_set('03', rt.call_function('__', [rt.new_string('March')]))
	this.month.array_set('04', rt.call_function('__', [rt.new_string('April')]))
	this.month.array_set('05', rt.call_function('__', [rt.new_string('May')]))
	this.month.array_set('06', rt.call_function('__', [rt.new_string('June')]))
	this.month.array_set('07', rt.call_function('__', [rt.new_string('July')]))
	this.month.array_set('08', rt.call_function('__', [rt.new_string('August')]))
	this.month.array_set('09', rt.call_function('__', [rt.new_string('September')]))
	this.month.array_set('10', rt.call_function('__', [rt.new_string('October')]))
	this.month.array_set('11', rt.call_function('__', [rt.new_string('November')]))
	this.month.array_set('12', rt.call_function('__', [rt.new_string('December')]))
	this.month_genitive.array_set('01', rt.call_function('_x', [
		rt.new_string('January'), rt.new_string('genitive')]))
	this.month_genitive.array_set('02', rt.call_function('_x', [
		rt.new_string('February'),
		rt.new_string('genitive'),
	]))
	this.month_genitive.array_set('03', rt.call_function('_x', [
		rt.new_string('March'), rt.new_string('genitive')]))
	this.month_genitive.array_set('04', rt.call_function('_x', [
		rt.new_string('April'), rt.new_string('genitive')]))
	this.month_genitive.array_set('05', rt.call_function('_x', [
		rt.new_string('May'), rt.new_string('genitive')]))
	this.month_genitive.array_set('06', rt.call_function('_x', [
		rt.new_string('June'), rt.new_string('genitive')]))
	this.month_genitive.array_set('07', rt.call_function('_x', [
		rt.new_string('July'), rt.new_string('genitive')]))
	this.month_genitive.array_set('08', rt.call_function('_x', [
		rt.new_string('August'), rt.new_string('genitive')]))
	this.month_genitive.array_set('09', rt.call_function('_x', [
		rt.new_string('September'),
		rt.new_string('genitive'),
	]))
	this.month_genitive.array_set('10', rt.call_function('_x', [
		rt.new_string('October'), rt.new_string('genitive')]))
	this.month_genitive.array_set('11', rt.call_function('_x', [
		rt.new_string('November'),
		rt.new_string('genitive'),
	]))
	this.month_genitive.array_set('12', rt.call_function('_x', [
		rt.new_string('December'),
		rt.new_string('genitive'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('01')), rt.call_function('_x', [
		rt.new_string('Jan'),
		rt.new_string('January abbreviation'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('02')), rt.call_function('_x', [
		rt.new_string('Feb'),
		rt.new_string('February abbreviation'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('03')), rt.call_function('_x', [
		rt.new_string('Mar'),
		rt.new_string('March abbreviation'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('04')), rt.call_function('_x', [
		rt.new_string('Apr'),
		rt.new_string('April abbreviation'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('05')), rt.call_function('_x', [
		rt.new_string('May'),
		rt.new_string('May abbreviation'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('06')), rt.call_function('_x', [
		rt.new_string('Jun'),
		rt.new_string('June abbreviation'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('07')), rt.call_function('_x', [
		rt.new_string('Jul'),
		rt.new_string('July abbreviation'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('08')), rt.call_function('_x', [
		rt.new_string('Aug'),
		rt.new_string('August abbreviation'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('09')), rt.call_function('_x', [
		rt.new_string('Sep'),
		rt.new_string('September abbreviation'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('10')), rt.call_function('_x', [
		rt.new_string('Oct'),
		rt.new_string('October abbreviation'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('11')), rt.call_function('_x', [
		rt.new_string('Nov'),
		rt.new_string('November abbreviation'),
	]))
	this.month_abbrev.array_set(this.month.array_get(rt.new_string('12')), rt.call_function('_x', [
		rt.new_string('Dec'),
		rt.new_string('December abbreviation'),
	]))
	this.meridiem.array_set('am', rt.call_function('__', [rt.new_string('am')]))
	this.meridiem.array_set('pm', rt.call_function('__', [rt.new_string('pm')]))
	this.meridiem.array_set('AM', rt.call_function('__', [rt.new_string('AM')]))
	this.meridiem.array_set('PM', rt.call_function('__', [rt.new_string('PM')]))
	mut var_thousands_sep := rt.call_function('__', [
		rt.new_string('number_format_thousands_sep'),
	])
	var_thousands_sep = rt.call_function('str_replace', [rt.new_string(' '),
		rt.new_string('&nbsp;'), var_thousands_sep.clone()])
	this.number_format.array_set('thousands_sep', if rt.is_true(rt.identical(rt.new_string('number_format_thousands_sep'),
		var_thousands_sep))
	{
		rt.new_string(',')
	} else {
		var_thousands_sep
	})
	mut var_decimal_point := rt.call_function('__', [
		rt.new_string('number_format_decimal_point'),
	])
	this.number_format.array_set('decimal_point', if rt.is_true(rt.identical(rt.new_string('number_format_decimal_point'),
		var_decimal_point))
	{
		rt.new_string('.')
	} else {
		var_decimal_point
	})
	this.list_item_separator = rt.call_function('__', [rt.new_string(', ')])
	if var_GLOBALS.array_isset(rt.new_string('text_direction')) {
		this.text_direction = var_GLOBALS.array_get(rt.new_string('text_direction'))
	} else if rt.is_true(rt.identical(rt.new_string('rtl'), rt.call_function('_x', [
		rt.new_string('ltr'),
		rt.new_string('text direction'),
	])))
	{
		this.text_direction = rt.new_string('rtl')
	}
	this.word_count_type = this.get_word_count_type()
}

fn (mut this Class_WP_Locale) get_weekday(var_weekday_number rt.PhpVal) rt.PhpVal {
	return this.weekday.array_get(var_weekday_number)
}

fn (mut this Class_WP_Locale) get_weekday_initial(var_weekday_name rt.PhpVal) rt.PhpVal {
	return this.weekday_initial.array_get(var_weekday_name)
}

fn (mut this Class_WP_Locale) get_weekday_abbrev(var_weekday_name rt.PhpVal) rt.PhpVal {
	return this.weekday_abbrev.array_get(var_weekday_name)
}

fn (mut this Class_WP_Locale) get_month(var_month_number rt.PhpVal) string {
	mut var_month_number_mutated := var_month_number
	var_month_number_mutated = rt.call_function('zeroise', [var_month_number_mutated.clone(),
		rt.new_int(2)])
	if !(this.month.array_isset(var_month_number_mutated)) {
		return ''
	}
	return (this.month.array_get(var_month_number_mutated)).str()
}

fn (mut this Class_WP_Locale) get_month_abbrev(var_month_name rt.PhpVal) rt.PhpVal {
	return this.month_abbrev.array_get(var_month_name)
}

fn (mut this Class_WP_Locale) get_month_genitive(var_month_number rt.PhpVal) rt.PhpVal {
	mut var_month_number_mutated := var_month_number
	return this.month_genitive.array_get(rt.call_function('zeroise', [
		var_month_number_mutated.clone(), rt.new_int(2)]))
}

fn (mut this Class_WP_Locale) get_meridiem(var_meridiem rt.PhpVal) rt.PhpVal {
	return this.meridiem.array_get(var_meridiem)
}

fn (mut this Class_WP_Locale) register_globals() {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_set('weekday', this.weekday)
	var_GLOBALS.array_set('weekday_initial', this.weekday_initial)
	var_GLOBALS.array_set('weekday_abbrev', this.weekday_abbrev)
	var_GLOBALS.array_set('month', this.month)
	var_GLOBALS.array_set('month_abbrev', this.month_abbrev)
}

fn (mut this Class_WP_Locale) is_rtl() rt.PhpVal {
	return rt.identical(rt.new_string('rtl'), this.text_direction)
}

fn (mut this Class_WP_Locale) _strings_for_pot() {
	rt.call_function('__', [rt.new_string('F j, Y')])
	rt.call_function('__', [rt.new_string('g:i a')])
	rt.call_function('__', [rt.new_string('F j, Y g:i a')])
}

fn (mut this Class_WP_Locale) get_list_item_separator() rt.PhpVal {
	return this.list_item_separator
}

fn (mut this Class_WP_Locale) get_word_count_type() rt.PhpVal {
	mut var_word_count_type := if !(this.word_count_type).is_null() { this.word_count_type } else { rt.call_function('_x', [
			rt.new_string('words'),
			rt.new_string('Word count type. Do not translate!'),
		]) }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('characters_excluding_spaces'), var_word_count_type))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('characters_including_spaces'), var_word_count_type)))) {
		var_word_count_type = rt.new_string('words')
	}
	return var_word_count_type.clone()
}

fn create_wp_locale() &Class_WP_Locale {
	mut obj := &Class_WP_Locale{
		PhpObjectBase:       rt.PhpObjectBase{}
		weekday:             rt.new_array()
		weekday_initial:     rt.new_array()
		weekday_abbrev:      rt.new_array()
		month:               rt.new_array()
		month_genitive:      rt.new_array()
		month_abbrev:        rt.new_array()
		meridiem:            rt.new_array()
		text_direction:      rt.new_string('ltr')
		number_format:       rt.new_array()
		list_item_separator: rt.new_null()
		word_count_type:     rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WP_Locale) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_weekday' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_weekday(dispatch_arg_0)
		}
		'get_weekday_initial' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_weekday_initial(dispatch_arg_0)
		}
		'get_weekday_abbrev' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_weekday_abbrev(dispatch_arg_0)
		}
		'get_month' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_month(dispatch_arg_0))
		}
		'get_month_abbrev' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_month_abbrev(dispatch_arg_0)
		}
		'get_month_genitive' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_month_genitive(dispatch_arg_0)
		}
		'get_meridiem' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_meridiem(dispatch_arg_0)
		}
		'register_globals' {
			this.register_globals()
			return rt.new_null()
		}
		'is_rtl' {
			return this.is_rtl()
		}
		'_strings_for_pot' {
			this._strings_for_pot()
			return rt.new_null()
		}
		'get_list_item_separator' {
			return this.get_list_item_separator()
		}
		'get_word_count_type' {
			return this.get_word_count_type()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Locale) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'weekday' { return this.weekday }
		'weekday_initial' { return this.weekday_initial }
		'weekday_abbrev' { return this.weekday_abbrev }
		'month' { return this.month }
		'month_genitive' { return this.month_genitive }
		'month_abbrev' { return this.month_abbrev }
		'meridiem' { return this.meridiem }
		'text_direction' { return this.text_direction }
		'number_format' { return this.number_format }
		'list_item_separator' { return this.list_item_separator }
		'word_count_type' { return this.word_count_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Locale) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'weekday' {
			this.weekday = val
			return true
		}
		'weekday_initial' {
			this.weekday_initial = val
			return true
		}
		'weekday_abbrev' {
			this.weekday_abbrev = val
			return true
		}
		'month' {
			this.month = val
			return true
		}
		'month_genitive' {
			this.month_genitive = val
			return true
		}
		'month_abbrev' {
			this.month_abbrev = val
			return true
		}
		'meridiem' {
			this.meridiem = val
			return true
		}
		'text_direction' {
			this.text_direction = val
			return true
		}
		'number_format' {
			this.number_format = val
			return true
		}
		'list_item_separator' {
			this.list_item_separator = val
			return true
		}
		'word_count_type' {
			this.word_count_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

struct Class_PO {
	rt.PhpObjectBase
pub mut:
			comments_before_headers rt.PhpVal = rt.new_string('')
}

fn (mut this Class_PO) export_headers() string {
	mut var_header_string := rt.new_string('')
	mut iter_1 := rt.get_property(rt.new_object('PO', ['Gettext_Translations'], &this), 'headers').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_header := item_1.key
		var_header_string = rt.concat(var_header_string, rt.new_string("${var_header.to_string()}: ${var_value.to_string()}\n"))
	}
	mut var_poified := Class_PO.poify(var_header_string.clone())
	if rt.is_true(this.comments_before_headers) {
	mut var_before_headers := rt.new_string(this.prepend_each_line(rt.new_string(this.comments_before_headers.to_string().trim_right(' \t\n\r') + '\n'), '# '))
	} else {
	var_before_headers = rt.new_string('')
	}
	return "${var_before_headers.to_string()}msgid \"\"\nmsgstr ${var_poified.to_string()}".trim_right(' \t\n\r')
}

fn (mut this Class_PO) export_entries() rt.PhpVal {
	return rt.call_function('implode', [rt.new_string('\n\n'), rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: 'PO' }, rt.ArrayItem{ key: none, val: 'export_entry' }]), rt.get_property(rt.new_object('PO', ['Gettext_Translations'], &this), 'entries')])])
}

fn (mut this Class_PO) export(include_headers bool) rt.PhpVal {
	mut var_res := rt.new_string('')
	if var_include_headers {
		var_res = rt.concat(var_res, this.export_headers())
		var_res = rt.concat(var_res, rt.new_string('\n\n'))
	}
	var_res = rt.concat(var_res, this.export_entries())
	return var_res.clone()
}

fn (mut this Class_PO) export_to_file(var_filename rt.PhpVal, include_headers bool) bool {
	mut var_fh := rt.call_function('fopen', [var_filename.clone(), rt.new_string('w')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_fh)) {
		return false
	}
	mut var_export := this.export(include_headers)
	mut var_res := rt.call_function('fwrite', [var_fh.clone(), var_export.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_res)) {
		return false
	}
	return (rt.call_function('fclose', [var_fh.clone()])).to_bool()
}

fn (mut this Class_PO) set_comment_before_headers(var_text rt.PhpVal) {
	mut var_text_mutated := var_text
	this.comments_before_headers = var_text_mutated.clone()
}

fn Class_PO.poify(var_input_string rt.PhpVal) rt.PhpVal {
	mut var_input_string_mutated := var_input_string
	mut var_quote := rt.new_string('"')
	mut var_slash := rt.new_string('\\')
	mut var_newline := rt.new_string('\n')
	mut var_replaces := rt.create_array([rt.ArrayItem{ key: "${var_slash.to_string()}", val: "${var_slash.to_string()}${var_slash.to_string()}" }, rt.ArrayItem{ key: "${var_quote.to_string()}", val: "${var_slash.to_string()}${var_quote.to_string()}" }, rt.ArrayItem{ key: '\t', val: '\\t' }])
	var_input_string_mutated = rt.call_function('str_replace', [rt.func_array_keys(var_replaces.clone()), rt.call_function('array_values', [var_replaces.clone()]), var_input_string_mutated.clone()])
	mut var_po := rt.new_string((var_quote).str() + (rt.call_function('implode', [rt.new_string("${var_slash.to_string()}n${var_quote.to_string()}${var_newline.to_string()}${var_quote.to_string()}"), rt.call_function('explode', [var_newline.clone(), var_input_string_mutated.clone()])])).str() + (var_quote).str())
	if rt.is_true(rt.call_function('str_contains', [var_input_string_mutated.clone(), var_newline.clone()])) && rt.is_true(rt.greater(rt.call_function('substr_count', [var_input_string_mutated.clone(), var_newline.clone()]), rt.new_int(1))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('substr', [var_input_string_mutated.clone(), rt.new_int(-var_newline.clone().to_string().len)]), var_newline)))) {
	var_po = rt.new_string("${var_quote.to_string()}${var_quote.to_string()}${var_newline.to_string()}${var_po.to_string()}")
	}
	var_po = rt.call_function('str_replace', [rt.new_string("${var_newline.to_string()}${var_quote.to_string()}${var_quote.to_string()}"), rt.new_string(''), var_po.clone()])
	return var_po.clone()
}

fn Class_PO.unpoify(var_input_string rt.PhpVal) rt.PhpVal {
	mut var_input_string_mutated := var_input_string
	mut var_escapes := rt.create_array([rt.ArrayItem{ key: 't', val: '\t' }, rt.ArrayItem{ key: 'n', val: '\n' }, rt.ArrayItem{ key: 'r', val: '\r' }, rt.ArrayItem{ key: '\\', val: '\\' }])
	mut var_lines := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string('\n'), var_input_string_mutated.clone()])])
	var_lines = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: 'PO' }, rt.ArrayItem{ key: none, val: 'trim_quotes' }]), var_lines.clone()])
	mut var_unpoified := rt.new_string('')
	mut var_previous_is_backslash := rt.new_bool(false)
	mut iter_2 := var_lines.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_line := item_2.val
		rt.call_function('preg_match_all', [rt.new_string('/./u'), var_line.clone(), var_chars.clone()])
		mut var_chars := var_chars.array_get(rt.new_int(0))
		mut iter_3 := var_chars.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_char := item_3.val
			if rt.is_true(rt.new_bool(!(rt.is_true(var_previous_is_backslash)))) {
				if rt.is_true(rt.identical(rt.new_string('\\'), var_char)) {
				var_previous_is_backslash = rt.new_bool(true)
				} else {
					var_unpoified = rt.concat(var_unpoified, var_char)
				}
			} else {
				var_previous_is_backslash = rt.new_bool(false)
				var_unpoified = rt.concat(var_unpoified, if !(var_escapes.array_get(var_char)).is_null() { var_escapes.array_get(var_char) } else { var_char })
			}
		}
	}
	var_unpoified = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '\r\n' }, rt.ArrayItem{ key: none, val: '\r' }]), rt.new_string('\n'), var_unpoified.clone()])
	return var_unpoified.clone()
}

fn Class_PO.prepend_each_line(var_input_string rt.PhpVal, with string) string {
	mut var_input_string_mutated := var_input_string
	mut var_lines := rt.call_function('explode', [rt.new_string('\n'), var_input_string_mutated.clone()])
	mut var_append := rt.new_string('')
	if rt.is_true(rt.identical(rt.new_string('\n'), rt.call_function('substr', [var_input_string_mutated.clone(), rt.new_int(-1)]))) && rt.is_true(rt.identical(rt.new_string(''), rt.call_function('end', [var_lines.clone()]))) {
		rt.call_function('array_pop', [var_lines.clone()])
	var_append = rt.new_string('\n')
	}
	mut iter_4 := var_lines.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_line := item_4.val
	var_line = rt.new_string(with + (var_line).str())
	}
	var_line = rt.new_null()
	return (rt.call_function('implode', [rt.new_string('\n'), var_lines.clone()])).str() + (var_append).str()
}

fn Class_PO.comment_block(var_text rt.PhpVal, char string) rt.PhpVal {
	mut var_text_mutated := var_text
	var_text_mutated = rt.call_function('wordwrap', [var_text_mutated.clone(), rt.sub(rt.get_constant('PO_MAX_LINE_LEN'), rt.new_int(3))])
	return Class_PO.prepend_each_line((var_text_mutated).str(), rt.new_string("#${var_char} "))
}

fn Class_PO.export_entry(var_entry rt.PhpVal) bool {
	mut var_entry_mutated := var_entry
	if rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_entry_mutated, 'singular'))) || rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_entry_mutated, 'singular'))) {
		return false
	}
	mut var_po := rt.new_array()
	if !(!rt.is_true(rt.get_property(var_entry_mutated, 'translator_comments'))) {
		var_po.array_push(Class_PO.comment_block((rt.get_property(var_entry_mutated, 'translator_comments')).str()))
	}
	if !(!rt.is_true(rt.get_property(var_entry_mutated, 'extracted_comments'))) {
		var_po.array_push(Class_PO.comment_block((rt.get_property(var_entry_mutated, 'extracted_comments')).str(), rt.new_string('.')))
	}
	if !(!rt.is_true(rt.get_property(var_entry_mutated, 'references'))) {
		var_po.array_push(Class_PO.comment_block((rt.call_function('implode', [rt.new_string(' '), rt.get_property(var_entry_mutated, 'references')])).str(), rt.new_string(':')))
	}
	if !(!rt.is_true(rt.get_property(var_entry_mutated, 'flags'))) {
		var_po.array_push(Class_PO.comment_block((rt.call_function('implode', [rt.new_string(', '), rt.get_property(var_entry_mutated, 'flags')])).str(), rt.new_string(',')))
	}
	if rt.is_true(rt.get_property(var_entry_mutated, 'context')) {
		var_po.array_push('msgctxt ' + (Class_PO.poify(rt.get_property(var_entry_mutated, 'context'))).str())
	}
	var_po.array_push('msgid ' + (Class_PO.poify(rt.get_property(var_entry_mutated, 'singular'))).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_entry_mutated, 'is_plural'))))) {
		mut var_translation := if !rt.is_true(rt.get_property(var_entry_mutated, 'translations')) { rt.new_string('') } else { rt.get_property(var_entry_mutated, 'translations').array_get(rt.new_int(0)) }
		var_translation = Class_PO.match_begin_and_end_newlines(var_translation.clone(), rt.get_property(var_entry_mutated, 'singular'))
		var_po.array_push('msgstr ' + (Class_PO.poify(var_translation.clone())).str())
	} else {
		var_po.array_push('msgid_plural ' + (Class_PO.poify(rt.get_property(var_entry_mutated, 'plural'))).str())
		mut var_translations := if !rt.is_true(rt.get_property(var_entry_mutated, 'translations')) { rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: '' }]) } else { rt.get_property(var_entry_mutated, 'translations') }
		mut iter_5 := var_translations.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_translation_shadow := item_5.val
			mut var_i := item_5.key
			var_translation_shadow = Class_PO.match_begin_and_end_newlines(var_translation_shadow.clone(), rt.get_property(var_entry_mutated, 'plural'))
			var_po.array_push("msgstr[${var_i.to_string()}] " + (Class_PO.poify(var_translation_shadow.clone())).str())
		}
	}
	return (rt.call_function('implode', [rt.new_string('\n'), var_po.clone()])).to_bool()
}

fn Class_PO.match_begin_and_end_newlines(var_translation rt.PhpVal, var_original rt.PhpVal) rt.PhpVal {
	mut var_translation_mutated := var_translation
	if rt.is_true(rt.identical(rt.new_string(''), var_translation_mutated)) {
		return var_translation_mutated.clone()
	}
	mut var_original_begin := rt.identical(rt.new_string('\n'), rt.call_function('substr', [var_original.clone(), rt.new_int(0), rt.new_int(1)]))
	mut var_original_end := rt.identical(rt.new_string('\n'), rt.call_function('substr', [var_original.clone(), rt.new_int(-1)]))
	mut var_translation_begin := rt.identical(rt.new_string('\n'), rt.call_function('substr', [var_translation_mutated.clone(), rt.new_int(0), rt.new_int(1)]))
	mut var_translation_end := rt.identical(rt.new_string('\n'), rt.call_function('substr', [var_translation_mutated.clone(), rt.new_int(-1)]))
	if rt.is_true(var_original_begin) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_translation_begin)))) {
		var_translation_mutated = rt.new_string('\n' + (var_translation_mutated).str())
		}
	} else if rt.is_true(var_translation_begin) {
	var_translation_mutated = rt.new_string(var_translation_mutated.clone().to_string().trim_left(' \t\n\r'))
	}
	if rt.is_true(var_original_end) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_translation_end)))) {
			var_translation_mutated = rt.concat(var_translation_mutated, rt.new_string('\n'))
		}
	} else if rt.is_true(var_translation_end) {
	var_translation_mutated = rt.new_string(var_translation_mutated.clone().to_string().trim_right(' \t\n\r'))
	}
	return var_translation_mutated.clone()
}

fn (mut this Class_PO) import_from_file(var_filename rt.PhpVal) bool {
	mut var_f := rt.call_function('fopen', [var_filename.clone(), rt.new_string('r')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_f)))) {
		return false
	}
	mut var_lineno := rt.new_int(0)
	for true {
		mut var_res := this.read_entry(var_f.clone(), (var_lineno).to_i64())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_res)))) {
			break
		}
		if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_res.array_get(rt.new_string('entry')), 'singular'))) {
			this.set_headers(this.make_headers(rt.get_property(var_res.array_get(rt.new_string('entry')), 'translations').array_get(rt.new_int(0))))
		} else {
			this.add_entry(var_res.array_get(rt.new_string('entry')))
		}
	}
	mut iife_temp_0 := Class_PO{}
	mut iife_result_0 := iife_temp_0.read_line((var_f).str(), rt.new_string('clear'))
	if rt.is_true(rt.identical(rt.new_bool(false), var_res)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('PO', ['Gettext_Translations'], &this), 'headers'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('PO', ['Gettext_Translations'], &this), 'entries'))))) {
		return false
	}
	return true
}

fn Class_PO.is_final(var_context rt.PhpVal) bool {
	mut var_context_mutated := var_context
	return rt.is_true(rt.identical(rt.new_string('msgstr'), var_context_mutated)) || rt.is_true(rt.identical(rt.new_string('msgstr_plural'), var_context_mutated))
}

fn (mut this Class_PO) read_entry(var_f rt.PhpVal, lineno i64) rt.PhpVal {
	mut var_m := []rt.PhpVal{}
	mut var_f_mutated := var_f
	mut lineno_mutated := lineno
	mut var_entry := create_translation_entry()
	mut var_context := rt.new_string('')
	mut var_msgstr_index := rt.new_int(0)
	for true {
		rt.pre_inc(rt.new_int(lineno_mutated))
		mut iife_temp_1 := Class_PO{}
		mut iife_result_1 := iife_temp_1.read_line((var_f_mutated).str())
		mut var_line := iife_result_1
		if rt.is_true(rt.new_bool(!(rt.is_true(var_line)))) {
			if rt.is_true(rt.call_function('feof', [var_f_mutated.clone()])) {
				if rt.is_true(Class_PO.is_final(var_context.clone())) {
					break
				} else if rt.is_true(rt.new_bool(!(rt.is_true(var_context)))) {
					return rt.new_null()
				} else {
					return rt.new_bool(false)
				}
			} else {
				return rt.new_bool(false)
			}
		}
		if rt.is_true(rt.identical(rt.new_string('\n'), var_line)) {
			continue
		}
		var_line = rt.new_string(var_line.clone().to_string().trim_space())
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^#/'), var_line.clone(), rt.create_array_from_list(var_m)])) {
			if rt.is_true(Class_PO.is_final(var_context.clone())) {
				mut iife_temp_2 := Class_PO{}
				mut iife_result_2 := iife_temp_2.read_line((var_f_mutated).str(), rt.new_string('put-back'))
				rt.pre_dec(rt.new_int(lineno_mutated))
				break
			}
			if rt.is_true(var_context) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('comment'), var_context)))) {
				return rt.new_bool(false)
			}
			this.add_comment_to_entry(rt.new_object('Translation_Entry', []string{}, var_entry), var_line.clone())
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^msgctxt\\s+(".*")/'), var_line.clone(), rt.create_array_from_list(var_m)])) {
			if rt.is_true(Class_PO.is_final(var_context.clone())) {
				mut iife_temp_3 := Class_PO{}
				mut iife_result_3 := iife_temp_3.read_line((var_f_mutated).str(), rt.new_string('put-back'))
				rt.pre_dec(rt.new_int(lineno_mutated))
				break
			}
			if rt.is_true(var_context) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('comment'), var_context)))) {
				return rt.new_bool(false)
			}
			var_context = rt.new_string('msgctxt')
			rt.get_property(var_entry, 'context') = rt.concat(rt.get_property(var_entry, 'context'), Class_PO.unpoify(var_m.array_get(rt.new_int(1))))
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^msgid\\s+(".*")/'), var_line.clone(), rt.create_array_from_list(var_m)])) {
			if rt.is_true(Class_PO.is_final(var_context.clone())) {
				mut iife_temp_4 := Class_PO{}
				mut iife_result_4 := iife_temp_4.read_line((var_f_mutated).str(), rt.new_string('put-back'))
				rt.pre_dec(rt.new_int(lineno_mutated))
				break
			}
			if rt.is_true(var_context) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('msgctxt'), var_context)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('comment'), var_context)))) {
				return rt.new_bool(false)
			}
			var_context = rt.new_string('msgid')
			rt.get_property(var_entry, 'singular') = rt.concat(rt.get_property(var_entry, 'singular'), Class_PO.unpoify(var_m.array_get(rt.new_int(1))))
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^msgid_plural\\s+(".*")/'), var_line.clone(), rt.create_array_from_list(var_m)])) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('msgid'), var_context)))) {
				return rt.new_bool(false)
			}
			var_context = rt.new_string('msgid_plural')
			rt.set_property(var_entry, 'is_plural', rt.new_bool(true))
			rt.get_property(var_entry, 'plural') = rt.concat(rt.get_property(var_entry, 'plural'), Class_PO.unpoify(var_m.array_get(rt.new_int(1))))
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^msgstr\\s+(".*")/'), var_line.clone(), rt.create_array_from_list(var_m)])) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('msgid'), var_context)))) {
				return rt.new_bool(false)
			}
			var_context = rt.new_string('msgstr')
			rt.set_property(var_entry, 'translations', rt.create_array([rt.ArrayItem{ key: none, val: Class_PO.unpoify(var_m.array_get(rt.new_int(1))) }]))
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^msgstr\\[(\\d+)\\]\\s+(".*")/'), var_line.clone(), rt.create_array_from_list(var_m)])) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('msgid_plural'), var_context)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('msgstr_plural'), var_context)))) {
				return rt.new_bool(false)
			}
			var_context = rt.new_string('msgstr_plural')
			var_msgstr_index = var_m.array_get(rt.new_int(1))
			rt.get_property(var_entry, 'translations').array_set(var_m.array_get(rt.new_int(1)), Class_PO.unpoify(var_m.array_get(rt.new_int(2))))
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^".*"$/'), var_line.clone()])) {
			mut var_unpoified := Class_PO.unpoify(var_line.clone())
			mut switch_val_1 := var_context
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('msgid'))) {
				rt.get_property(var_entry, 'singular') = rt.concat(rt.get_property(var_entry, 'singular'), var_unpoified)
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('msgctxt'))) {
				rt.get_property(var_entry, 'context') = rt.concat(rt.get_property(var_entry, 'context'), var_unpoified)
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('msgid_plural'))) {
				rt.get_property(var_entry, 'plural') = rt.concat(rt.get_property(var_entry, 'plural'), var_unpoified)
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('msgstr'))) {
				rt.get_property(var_entry, 'translations').array_get(rt.new_int(0)) = rt.concat(rt.get_property(var_entry, 'translations').array_get(rt.new_int(0)), var_unpoified)
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('msgstr_plural'))) {
				rt.get_property(var_entry, 'translations').array_get(var_msgstr_index) = rt.concat(rt.get_property(var_entry, 'translations').array_get(var_msgstr_index), var_unpoified)
			} else {
				return rt.new_bool(false)
			}
		} else {
			return rt.new_bool(false)
		}
	}
	mut var_have_translations := rt.new_bool(false)
	mut iter_6 := rt.get_property(var_entry, 'translations').iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_t := item_6.val
		if rt.is_true(var_t) || rt.is_true(rt.identical(rt.new_string('0'), var_t)) {
			var_have_translations = rt.new_bool(true)
			break
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_have_translations)) {
		rt.set_property(var_entry, 'translations', rt.new_array())
	}
	return rt.create_array([rt.ArrayItem{ key: 'entry', val: var_entry }, rt.ArrayItem{ key: 'lineno', val: lineno_mutated }])
}

fn (mut this Class_PO) read_line(var_f rt.PhpVal, action string) bool {
	mut var_f_mutated := var_f
	mut var_last_line := ''
	mut var_use_last_line := false
	if rt.is_true(rt.identical(rt.new_string('clear'), rt.new_string(action))) {
		var_last_line = rt.new_string('')
		return true
	}
	if rt.is_true(rt.identical(rt.new_string('put-back'), rt.new_string(action))) {
		var_use_last_line = rt.new_bool(true)
		return true
	}
	if rt.is_true(var_use_last_line) {
	mut var_line := var_last_line.clone()
	} else {
		var_line = rt.call_function('fgets', [var_f_mutated.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_line)) {
			return (var_line).to_bool()
		}
		mut var_r := rt.call_function('strpos', [var_line.clone(), rt.new_string('\r')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_r)))) {
			if rt.is_true(rt.identical(rt.new_int(var_line.clone().to_string().len), rt.add(var_r, rt.new_int(1)))) && rt.is_true(rt.identical(rt.new_string('\r\n'), rt.call_function('substr', [var_line.clone(), var_r.clone()]))) {
			var_line = rt.new_string((var_line.clone().to_string().trim_right(' \t\n\r') + '\n').str())
			} else {
				mut var_rewind := rt.sub(rt.sub(rt.new_int(var_line.clone().to_string().len), var_r), rt.new_int(1))
				var_line = rt.new_string((rt.call_function('substr', [var_line.clone(), rt.new_int(0), var_r.clone()])).str() + '\n')
				rt.call_function('fseek', [var_f_mutated.clone(), rt.sub(rt.new_int(0), var_rewind), rt.get_constant('SEEK_CUR')])
			}
		}
	}
	var_last_line = var_line.clone()
	var_use_last_line = rt.new_bool(false)
	return (var_line).to_bool()
}

fn (mut this Class_PO) add_comment_to_entry(var_entry rt.PhpVal, var_po_comment_line rt.PhpVal) {
	mut var_entry_mutated := var_entry
	mut var_first_two := rt.call_function('substr', [var_po_comment_line.clone(), rt.new_int(0), rt.new_int(2)])
	mut var_comment := rt.new_string(rt.call_function('substr', [var_po_comment_line.clone(), rt.new_int(2)]).to_string().trim_space())
	if rt.is_true(rt.identical(rt.new_string('#:'), var_first_two)) {
		rt.set_property(var_entry_mutated, 'references', rt.call_function('array_merge', [rt.get_property(var_entry_mutated, 'references'), rt.call_function('preg_split', [rt.new_string('/\\s+/'), var_comment.clone()])]))
	} else if rt.is_true(rt.identical(rt.new_string('#.'), var_first_two)) {
		rt.set_property(var_entry_mutated, 'extracted_comments', rt.new_string((rt.get_property(var_entry_mutated, 'extracted_comments')).str() + '\n' + (var_comment).str().trim_space()))
	} else if rt.is_true(rt.identical(rt.new_string('#,'), var_first_two)) {
		rt.set_property(var_entry_mutated, 'flags', rt.call_function('array_merge', [rt.get_property(var_entry_mutated, 'flags'), rt.call_function('preg_split', [rt.new_string('/,\\s*/'), var_comment.clone()])]))
	} else {
		rt.set_property(var_entry_mutated, 'translator_comments', rt.new_string((rt.get_property(var_entry_mutated, 'translator_comments')).str() + '\n' + (var_comment).str().trim_space()))
	}
}

fn Class_PO.trim_quotes(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
	if rt.is_true(rt.call_function('str_starts_with', [var_s_mutated.clone(), rt.new_string('"')])) {
	var_s_mutated = rt.call_function('substr', [var_s_mutated.clone(), rt.new_int(1)])
	}
	if rt.is_true(rt.call_function('str_ends_with', [var_s_mutated.clone(), rt.new_string('"')])) {
	var_s_mutated = rt.call_function('substr', [var_s_mutated.clone(), rt.new_int(0), rt.new_int(-1)])
	}
	return var_s_mutated.clone()
}

struct Class_Gettext_Translations {
	rt.PhpObjectBase
}

struct Class_Translation_Entry {
	rt.PhpObjectBase
}

fn create_po(_args ...rt.PhpVal) &Class_PO {
	mut obj := &Class_PO{
		PhpObjectBase: rt.PhpObjectBase{}
		comments_before_headers: rt.new_string('')
	}
	return obj
}

fn create_gettext_translations(_args ...rt.PhpVal) &Class_Gettext_Translations {
	mut obj := &Class_Gettext_Translations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_translation_entry(_args ...rt.PhpVal) &Class_Translation_Entry {
	mut obj := &Class_Translation_Entry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_PO) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'export_headers' {
			return rt.new_string(this.export_headers())
		}
		'export_entries' {
			return this.export_entries()
		}
		'export' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.export(dispatch_arg_0)
		}
		'export_to_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.export_to_file(dispatch_arg_0, dispatch_arg_1))
		}
		'set_comment_before_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_comment_before_headers(dispatch_arg_0)
			return rt.new_null()
		}
		'poify' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_PO.poify(dispatch_arg_0)
		}
		'unpoify' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_PO.unpoify(dispatch_arg_0)
		}
		'prepend_each_line' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_PO.prepend_each_line(dispatch_arg_0, dispatch_arg_1))
		}
		'comment_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_PO.comment_block(dispatch_arg_0, dispatch_arg_1)
		}
		'export_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_PO.export_entry(dispatch_arg_0))
		}
		'match_begin_and_end_newlines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_PO.match_begin_and_end_newlines(dispatch_arg_0, dispatch_arg_1)
		}
		'import_from_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.import_from_file(dispatch_arg_0))
		}
		'is_final' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_PO.is_final(dispatch_arg_0))
		}
		'read_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.read_entry(dispatch_arg_0, dispatch_arg_1)
		}
		'read_line' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.read_line(dispatch_arg_0, dispatch_arg_1))
		}
		'add_comment_to_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_comment_to_entry(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'trim_quotes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_PO.trim_quotes(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_PO) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'comments_before_headers' { return this.comments_before_headers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_PO) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'comments_before_headers' { this.comments_before_headers = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Gettext_Translations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Gettext_Translations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Gettext_Translations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Translation_Entry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Translation_Entry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Translation_Entry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/translations.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('PO_MAX_LINE_LEN')]))))) {
		rt.call_function('define', [rt.new_string('PO_MAX_LINE_LEN'), rt.new_int(79)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('PO'), rt.new_bool(false)]))))) {
	}
}

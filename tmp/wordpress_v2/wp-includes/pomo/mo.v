import rt

struct Class_MO {
	rt.PhpObjectBase
pub mut:
	_nplurals rt.PhpVal = rt.new_int(2)
	filename  rt.PhpVal = rt.new_string('')
}

fn (mut this Class_MO) get_filename() rt.PhpVal {
	return this.filename
}

fn (mut this Class_MO) import_from_file(var_filename rt.PhpVal) bool {
	mut var_reader := create_pomo_filereader(var_filename.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_reader, 'is_resource', []rt.PhpVal{}))))) {
		return false
	}
	this.filename = var_filename.str()
	return this.import_from_reader(var_reader.clone())
}

fn (mut this Class_MO) export_to_file(var_filename rt.PhpVal) bool {
	mut var_fh := rt.call_function('fopen', [var_filename.clone(),
		rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fh)))) {
		return false
	}
	mut var_res := rt.new_bool(this.export_to_file_handle(var_fh.clone()))
	rt.call_function('fclose', [var_fh.clone()])
	return var_res.to_bool()
}

fn (mut this Class_MO) export() bool {
	mut var_tmp_fh := rt.call_function('fopen', [rt.new_string('php://temp'),
		rt.new_string('r+')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tmp_fh)))) {
		return false
	}
	this.export_to_file_handle(var_tmp_fh.clone())
	rt.call_function('rewind', [var_tmp_fh.clone()])
	return (rt.call_function('stream_get_contents', [var_tmp_fh.clone()])).to_bool()
}

fn (mut this Class_MO) is_entry_good_for_export(var_entry rt.PhpVal) bool {
	mut var_entry_mutated := var_entry
	if !rt.is_true(rt.get_property(var_entry_mutated, 'translations')) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_filter', [
		rt.get_property(var_entry_mutated, 'translations'),
	])))))
	{
		return false
	}
	return true
}

fn (mut this Class_MO) export_to_file_handle(var_fh rt.PhpVal) bool {
	mut var_fh_mutated := var_fh
	mut var_entries := rt.call_function('array_filter', [
		rt.get_property(rt.new_object('MO', ['Gettext_Translations'], &this), 'entries'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('MO', [
			'Gettext_Translations',
		], &this) }, rt.ArrayItem{ key: none, val: 'is_entry_good_for_export' }]),
	])
	rt.call_function('ksort', [var_entries.clone()])
	mut var_magic := rt.new_int(2500072158)
	mut var_revision := rt.new_int(0)
	mut var_total := rt.new_int(var_entries.clone().array_count() + 1)
	mut var_originals_lengths_addr := rt.new_int(28)
	mut var_translations_lengths_addr := rt.add(var_originals_lengths_addr, rt.mul(rt.new_int(8),
		var_total))
	mut var_size_of_hash := rt.new_int(0)
	mut var_hash_addr := rt.add(var_translations_lengths_addr, rt.mul(rt.new_int(8), var_total))
	mut var_current_addr := var_hash_addr.clone()
	rt.call_function('fwrite', [var_fh_mutated.clone(),
		rt.call_function('pack', [rt.new_string('V*'), var_magic.clone(),
			var_revision.clone(), var_total.clone(), var_originals_lengths_addr.clone(),
			var_translations_lengths_addr.clone(), var_size_of_hash.clone(),
			var_hash_addr.clone()])])
	rt.call_function('fseek', [var_fh_mutated.clone(), var_originals_lengths_addr.clone()])
	rt.call_function('fwrite', [var_fh_mutated.clone(),
		rt.call_function('pack', [rt.new_string('VV'), rt.new_int(0),
			var_current_addr.clone()])])
	rt.pre_inc(var_current_addr)
	mut var_originals_table := rt.new_string('')
	mut var_reader := create_pomo_reader()
	mut iter_1 := var_entries.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_entry := item_1.val
		var_originals_table = rt.concat(var_originals_table, rt.new_string(
			(this.export_original(var_entry.clone())).str() + ''))
		mut var_length := rt.call_method(var_reader, 'strlen', [
			this.export_original(var_entry.clone()),
		])
		rt.call_function('fwrite', [var_fh_mutated.clone(),
			rt.call_function('pack', [rt.new_string('VV'), var_length.clone(),
				var_current_addr.clone()])])
		var_current_addr = rt.add(var_current_addr, rt.add(var_length, rt.new_int(1)))
	}
	mut var_exported_headers := this.export_headers()
	rt.call_function('fwrite', [var_fh_mutated.clone(),
		rt.call_function('pack', [rt.new_string('VV'),
			rt.call_method(var_reader, 'strlen', [var_exported_headers.clone()]),
			var_current_addr.clone()])])
	var_current_addr = rt.add(var_current_addr, var_exported_headers.clone().to_string().len + 1)
	mut var_translations_table := rt.new_string(var_exported_headers.str() + '')
	mut iter_2 := var_entries.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_entry := item_2.val
		var_translations_table = rt.concat(var_translations_table, rt.new_string(
			(this.export_translations(var_entry.clone())).str() + ''))
		mut var_length := rt.call_method(var_reader, 'strlen', [
			this.export_translations(var_entry.clone()),
		])
		rt.call_function('fwrite', [var_fh_mutated.clone(),
			rt.call_function('pack', [rt.new_string('VV'), var_length.clone(),
				var_current_addr.clone()])])
		var_current_addr = rt.add(var_current_addr, rt.add(var_length, rt.new_int(1)))
	}
	rt.call_function('fwrite', [var_fh_mutated.clone(), var_originals_table.clone()])
	rt.call_function('fwrite', [var_fh_mutated.clone(), var_translations_table.clone()])
	return true
}

fn (mut this Class_MO) export_original(var_entry rt.PhpVal) rt.PhpVal {
	mut var_entry_mutated := var_entry
	mut var_exported := rt.get_property(var_entry_mutated, 'singular')
	if rt.is_true(rt.get_property(var_entry_mutated, 'is_plural')) {
		var_exported = rt.concat(var_exported, rt.new_string('' +
			(rt.get_property(var_entry_mutated, 'plural')).str()))
	}
	if rt.is_true(rt.get_property(var_entry_mutated, 'context')) {
		var_exported = rt.new_string((rt.get_property(var_entry_mutated, 'context')).str() + '' +
			var_exported.str())
	}
	return var_exported.clone()
}

fn (mut this Class_MO) export_translations(var_entry rt.PhpVal) rt.PhpVal {
	mut var_entry_mutated := var_entry
	return if rt.is_true(rt.get_property(var_entry_mutated, 'is_plural')) { rt.call_function('implode', [
			rt.new_string(''),
			rt.get_property(var_entry_mutated, 'translations'),
		]) } else { rt.get_property(var_entry_mutated, 'translations').array_get(rt.new_int(0)) }
}

fn (mut this Class_MO) export_headers() rt.PhpVal {
	mut var_exported := rt.new_string('')
	mut iter_3 :=
		rt.get_property(rt.new_object('MO', ['Gettext_Translations'], &this), 'headers').iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_header := item_3.key
		var_exported = rt.concat(var_exported,
			rt.new_string('${var_header.to_string()}: ${var_value.to_string()}\n'))
	}
	return var_exported.clone()
}

fn (mut this Class_MO) get_byteorder(var_magic rt.PhpVal) rt.PhpVal {
	mut var_magic_mutated := var_magic
	mut var_magic_little := rt.new_int(-1794895138)
	mut var_magic_little_64 := rt.new_int(2500072158)
	mut var_magic_big := rt.new_int(-569244523 & 4294967295)
	if rt.is_true(rt.identical(var_magic_little, var_magic_mutated))
		|| rt.is_true(rt.identical(var_magic_little_64, var_magic_mutated)) {
		return rt.new_string('little')
	} else if rt.is_true(rt.identical(var_magic_big, var_magic_mutated)) {
		return rt.new_string('big')
	} else {
		return rt.new_bool(false)
	}
	return rt.new_null()
}

fn (mut this Class_MO) import_from_reader(var_reader rt.PhpVal) bool {
	mut var_entry := rt.new_null()
	mut var_reader_mutated := var_reader
	mut iife_temp_0 := Class_MO{}
	mut iife_result_0 := iife_temp_0.get_byteorder(rt.call_method(var_reader_mutated, 'readint32',
		[]rt.PhpVal{}))
	mut var_endian_string := iife_result_0
	if rt.is_true(rt.identical(rt.new_bool(false), var_endian_string)) {
		return false
	}
	rt.call_method(var_reader_mutated, 'setEndian', [var_endian_string.clone()])
	mut var_endian := rt.new_string((if rt.is_true(rt.identical(rt.new_string('big'),
		var_endian_string))
	{
		'N'
	} else {
		'V'
	}).str())
	mut var_header := rt.call_method(var_reader_mutated, 'read', [
		rt.new_int(24)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_reader_mutated, 'strlen', [
		var_header.clone(),
	]), rt.new_int(24)))))
	{
		return false
	}
	var_header = rt.call_function('unpack', [
		rt.new_string('${var_endian.to_string()}revision/${var_endian.to_string()}total/${var_endian.to_string()}originals_lengths_addr/${var_endian.to_string()}translations_lengths_addr/${var_endian.to_string()}hash_length/${var_endian.to_string()}hash_addr'),
		var_header.clone(),
	])
	if !(var_header.clone().is_array()) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0),
		var_header.array_get(rt.new_string('revision'))))))
	{
		return false
	}
	rt.call_method(var_reader_mutated, 'seekto', [
		var_header.array_get(rt.new_string('originals_lengths_addr')),
	])
	mut var_originals_lengths_length := rt.sub(var_header.array_get(rt.new_string('translations_lengths_addr')),
		var_header.array_get(rt.new_string('originals_lengths_addr')))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_originals_lengths_length, rt.mul(var_header.array_get(rt.new_string('total')),
		rt.new_int(8))))))
	{
		return false
	}
	mut var_originals := rt.call_method(var_reader_mutated, 'read', [
		var_originals_lengths_length.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_reader_mutated, 'strlen', [
		var_originals.clone(),
	]), var_originals_lengths_length))))
	{
		return false
	}
	mut var_translations_lengths_length := rt.sub(var_header.array_get(rt.new_string('hash_addr')),
		var_header.array_get(rt.new_string('translations_lengths_addr')))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_translations_lengths_length, rt.mul(var_header.array_get(rt.new_string('total')),
		rt.new_int(8))))))
	{
		return false
	}
	mut var_translations := rt.call_method(var_reader_mutated, 'read', [
		var_translations_lengths_length.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_reader_mutated, 'strlen', [
		var_translations.clone(),
	]), var_translations_lengths_length))))
	{
		return false
	}
	var_originals = rt.call_method(var_reader_mutated, 'str_split', [
		var_originals.clone(), rt.new_int(8)])
	var_translations = rt.call_method(var_reader_mutated, 'str_split', [
		var_translations.clone(), rt.new_int(8)])
	mut var_strings_addr := rt.add(var_header.array_get(rt.new_string('hash_addr')), rt.mul(var_header.array_get(rt.new_string('hash_length')),
		rt.new_int(4)))
	rt.call_method(var_reader_mutated, 'seekto', [var_strings_addr.clone()])
	mut var_strings := rt.call_method(var_reader_mutated, 'read_all', []rt.PhpVal{})
	rt.call_method(var_reader_mutated, 'close', []rt.PhpVal{})
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_header.array_get(rt.new_string('total'))))) { break
		 }
		mut var_o := rt.call_function('unpack', [
			rt.new_string('${var_endian.to_string()}length/${var_endian.to_string()}pos'),
			var_originals.array_get(var_i),
		])
		mut var_t := rt.call_function('unpack', [
			rt.new_string('${var_endian.to_string()}length/${var_endian.to_string()}pos'),
			var_translations.array_get(var_i),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_o))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_t)))) {
			return false
		}
		var_o.array_get(rt.new_string('pos')) = rt.sub(var_o.array_get(rt.new_string('pos')),
			var_strings_addr)
		var_t.array_get(rt.new_string('pos')) = rt.sub(var_t.array_get(rt.new_string('pos')),
			var_strings_addr)
		mut var_original := rt.call_method(var_reader_mutated, 'substr', [
			var_strings.clone(), var_o.array_get(rt.new_string('pos')),
			var_o.array_get(rt.new_string('length'))])
		mut var_translation := rt.call_method(var_reader_mutated, 'substr', [
			var_strings.clone(), var_t.array_get(rt.new_string('pos')),
			var_t.array_get(rt.new_string('length'))])
		if rt.is_true(rt.identical(rt.new_string(''), var_original)) {
			this.set_headers(this.make_headers(var_translation.clone()))
		} else {
			var_entry = this.make_entry(var_original.clone(), var_translation.clone())
			rt.get_property(rt.new_object('MO', ['Gettext_Translations'], &this), 'entries').array_get(var_entry.key()) = var_entry
		}
		rt.post_inc(var_i)
	}
	return true
}

fn (mut this Class_MO) make_entry(var_original rt.PhpVal, var_translation rt.PhpVal) rt.PhpVal {
	mut var_original_mutated := var_original
	mut var_translation_mutated := var_translation
	mut var_entry := create_translation_entry()
	mut var_parts := rt.call_function('explode', [rt.new_string(''),
		var_original_mutated.clone()])
	if var_parts.array_isset(rt.new_int(1)) {
		var_original_mutated = var_parts.array_get(rt.new_int(1))
		rt.set_property(var_entry, 'context', var_parts.array_get(rt.new_int(0)))
	}
	var_parts = rt.call_function('explode', [rt.new_string(''),
		var_original_mutated.clone()])
	rt.set_property(var_entry, 'singular', var_parts.array_get(rt.new_int(0)))
	if var_parts.array_isset(rt.new_int(1)) {
		rt.set_property(var_entry, 'is_plural', rt.new_bool(true))
		rt.set_property(var_entry, 'plural', var_parts.array_get(rt.new_int(1)))
	}
	rt.set_property(var_entry, 'translations', rt.call_function('explode', [
		rt.new_string(''),
		var_translation_mutated.clone(),
	]))
	return mut var_entry
}

fn (mut this Class_MO) select_plural_form(var_count rt.PhpVal) rt.PhpVal {
	return this.gettext_select_plural_form(var_count.clone())
}

fn (mut this Class_MO) get_plural_forms_count() rt.PhpVal {
	return this._nplurals
}

struct Class_Gettext_Translations {
	rt.PhpObjectBase
}

struct Class_POMO_FileReader {
	rt.PhpObjectBase
}

struct Class_POMO_Reader {
	rt.PhpObjectBase
}

struct Class_Translation_Entry {
	rt.PhpObjectBase
}

fn create_mo(_args ...rt.PhpVal) &Class_MO {
	mut obj := &Class_MO{
		PhpObjectBase: rt.PhpObjectBase{}
		_nplurals:     rt.new_int(2)
		filename:      rt.new_string('')
	}
	return obj
}

fn create_gettext_translations(_args ...rt.PhpVal) &Class_Gettext_Translations {
	mut obj := &Class_Gettext_Translations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_pomo_filereader(_args ...rt.PhpVal) &Class_POMO_FileReader {
	mut obj := &Class_POMO_FileReader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_pomo_reader(_args ...rt.PhpVal) &Class_POMO_Reader {
	mut obj := &Class_POMO_Reader{
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

fn (mut this Class_MO) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_filename' {
			return this.get_filename()
		}
		'import_from_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.import_from_file(dispatch_arg_0))
		}
		'export_to_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.export_to_file(dispatch_arg_0))
		}
		'export' {
			return rt.new_bool(this.export())
		}
		'is_entry_good_for_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_entry_good_for_export(dispatch_arg_0))
		}
		'export_to_file_handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.export_to_file_handle(dispatch_arg_0))
		}
		'export_original' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.export_original(dispatch_arg_0)
		}
		'export_translations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.export_translations(dispatch_arg_0)
		}
		'export_headers' {
			return this.export_headers()
		}
		'get_byteorder' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_byteorder(dispatch_arg_0)
		}
		'import_from_reader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.import_from_reader(dispatch_arg_0))
		}
		'make_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.make_entry(dispatch_arg_0, dispatch_arg_1)
		}
		'select_plural_form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.select_plural_form(dispatch_arg_0)
		}
		'get_plural_forms_count' {
			return this.get_plural_forms_count()
		}
		else {
			return none
		}
	}
}

fn (this &Class_MO) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_nplurals' { return this._nplurals }
		'filename' { return this.filename }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_MO) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_nplurals' {
			this._nplurals = val
			return true
		}
		'filename' {
			this.filename = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_POMO_FileReader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_POMO_FileReader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_POMO_FileReader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_POMO_Reader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_POMO_Reader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_POMO_Reader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	rt.include_file(@DIR + '/streams.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('MO'),
		rt.new_bool(false),
	])))))
	{
	}
}

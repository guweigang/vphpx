import rt

struct Class_MO {
	rt.PhpObjectBase
pub mut:
			_nplurals rt.PhpVal = rt.new_int(2)
			filename rt.PhpVal = rt.new_string('')
}

fn (mut this Class_MO) get_filename() rt.PhpVal {
	return this.filename
}

fn (mut this Class_MO) import_from_file(var_filename rt.PhpVal) bool {
	mut var_reader := create_pomo_filereader(var_filename.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_reader, 'is_resource', []rt.PhpVal{}))))) {
		return false
	}
	this.filename = // unsupported expression: Expr_Cast_String
	return this.import_from_reader(var_reader.dup())
}

fn (mut this Class_MO) export_to_file(var_filename rt.PhpVal) bool {
	mut var_fh := rt.call_function('fopen', [var_filename.dup(), rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fh)))) {
		return false
	}
	mut var_res := rt.new_bool(this.export_to_file_handle(var_fh.dup()))
	rt.call_function('fclose', [var_fh.dup()])
	return (var_res).to_bool()
}

fn (mut this Class_MO) export() bool {
	mut var_tmp_fh := rt.call_function('fopen', [rt.new_string('php://temp'), rt.new_string('r+')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tmp_fh)))) {
		return false
	}
	this.export_to_file_handle(var_tmp_fh.dup())
	rt.call_function('rewind', [var_tmp_fh.dup()])
	return (rt.call_function('stream_get_contents', [var_tmp_fh.dup()])).to_bool()
}

fn (mut this Class_MO) is_entry_good_for_export(var_entry rt.PhpVal) bool {
	mut var_entry_mutated := var_entry
	if !rt.is_true(rt.get_property(var_entry_mutated, 'translations')) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_filter', [rt.get_property(var_entry_mutated, 'translations')]))))) {
		return false
	}
	return true
}

fn (mut this Class_MO) export_to_file_handle(var_fh rt.PhpVal) bool {
	mut var_fh_mutated := var_fh
	mut var_entries := rt.call_function('array_filter', [rt.get_property(rt.new_object('MO', ['Gettext_Translations'], &this), 'entries'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('MO', ['Gettext_Translations'], &this) }, rt.ArrayItem{ key: none, val: 'is_entry_good_for_export' }])])
	rt.call_function('ksort', [var_entries.dup()])
	mut var_magic := rt.new_int(rt.new_int(2500072158))
	mut var_revision := rt.new_int(rt.new_int(0))
	mut var_total := rt.new_int(var_entries.dup().array_count() + 1)
	mut var_originals_lengths_addr := rt.new_int(rt.new_int(28))
	mut var_translations_lengths_addr := rt.add(var_originals_lengths_addr, rt.mul(rt.new_int(8), var_total))
	mut var_size_of_hash := rt.new_int(rt.new_int(0))
	mut var_hash_addr := rt.add(var_translations_lengths_addr, rt.mul(rt.new_int(8), var_total))
	mut var_current_addr := var_hash_addr.dup()
	rt.call_function('fwrite', [var_fh_mutated.dup(), rt.call_function('pack', [rt.new_string('V*'), var_magic.dup(), var_revision.dup(), var_total.dup(), var_originals_lengths_addr.dup(), var_translations_lengths_addr.dup(), var_size_of_hash.dup(), var_hash_addr.dup()])])
	rt.call_function('fseek', [var_fh_mutated.dup(), var_originals_lengths_addr.dup()])
	rt.call_function('fwrite', [var_fh_mutated.dup(), rt.call_function('pack', [rt.new_string('VV'), rt.new_int(0), var_current_addr.dup()])])
	rt.pre_inc(var_current_addr)
	mut var_originals_table := rt.new_string(rt.new_string(''))
	mut var_reader := create_pomo_reader()
	{
		mut iter_1 := var_entries.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_entry := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
			mut var_length := rt.call_method(var_reader, 'strlen', [this.export_original(var_entry.dup())])
			rt.call_function('fwrite', [var_fh_mutated.dup(), rt.call_function('pack', [rt.new_string('VV'), var_length.dup(), var_current_addr.dup()])])
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported statement: Stmt_Nop
		}
	}
	mut var_exported_headers := this.export_headers()
	rt.call_function('fwrite', [var_fh_mutated.dup(), rt.call_function('pack', [rt.new_string('VV'), rt.call_method(var_reader, 'strlen', [var_exported_headers.dup()]), var_current_addr.dup()])])
	// unsupported expression: Expr_AssignOp_Plus
	mut var_translations_table := rt.new_string((var_exported_headers).str() + '')
	{
		mut iter_1 := var_entries.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_entry := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
			mut var_length := rt.call_method(var_reader, 'strlen', [this.export_translations(var_entry.dup())])
			rt.call_function('fwrite', [var_fh_mutated.dup(), rt.call_function('pack', [rt.new_string('VV'), var_length.dup(), var_current_addr.dup()])])
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	rt.call_function('fwrite', [var_fh_mutated.dup(), var_originals_table.dup()])
	rt.call_function('fwrite', [var_fh_mutated.dup(), var_translations_table.dup()])
	return true
}

fn (mut this Class_MO) export_original(var_entry rt.PhpVal) rt.PhpVal {
	mut var_entry_mutated := var_entry
	mut var_exported := rt.get_property(var_entry_mutated, 'singular')
	if rt.is_true(rt.get_property(var_entry_mutated, 'is_plural')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.get_property(var_entry_mutated, 'context')) {
		var_exported = rt.new_string((rt.get_property(var_entry_mutated, 'context')).str() + '' + (var_exported).str())
	}
	return var_exported.dup()
}

fn (mut this Class_MO) export_translations(var_entry rt.PhpVal) rt.PhpVal {
	mut var_entry_mutated := var_entry
	return if rt.is_true(rt.get_property(var_entry_mutated, 'is_plural')) { rt.call_function('implode', [rt.new_string(''), rt.get_property(var_entry_mutated, 'translations')]) } else { rt.get_property(var_entry_mutated, 'translations').array_get(0) }
}

fn (mut this Class_MO) export_headers() rt.PhpVal {
	mut var_exported := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := rt.get_property(rt.new_object('MO', ['Gettext_Translations'], &this), 'headers').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_header := item_1.key
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_exported.dup()
}

fn (mut this Class_MO) get_byteorder(var_magic rt.PhpVal) rt.PhpVal {
	mut var_magic_mutated := var_magic
	mut var_magic_little := // unsupported expression: Expr_Cast_Int
	mut var_magic_little_64 := // unsupported expression: Expr_Cast_Int
	mut var_magic_big := rt.new_int(rt.bitwise_and(// unsupported expression: Expr_Cast_Int, rt.new_int(4294967295)))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_magic_little, var_magic_mutated)) || rt.is_true(rt.identical(var_magic_little_64, var_magic_mutated)))) {
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
	mut var_endian_string := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_MO{}; return temp.get_byteorder(arg_0) }(rt.call_method(var_reader_mutated, 'readint32', []rt.PhpVal{}))
	if rt.is_true(rt.identical(rt.new_bool(false), var_endian_string)) {
		return false
	}
	rt.call_method(var_reader_mutated, 'setEndian', [var_endian_string.dup()])
	mut var_endian := rt.new_string(if rt.is_true(rt.identical(rt.new_string('big'), var_endian_string)) { rt.new_string('N') } else { rt.new_string('V') })
	mut var_header := rt.call_method(var_reader_mutated, 'read', [rt.new_int(24)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	var_header = rt.call_function('unpack', [rt.new_string("${var_endian.to_string()}revision/${var_endian.to_string()}total/${var_endian.to_string()}originals_lengths_addr/${var_endian.to_string()}translations_lengths_addr/${var_endian.to_string()}hash_length/${var_endian.to_string()}hash_addr"), var_header.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_header.dup().is_array()))))) {
		return false
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	rt.call_method(var_reader_mutated, 'seekto', [var_header.array_get('originals_lengths_addr')])
	mut var_originals_lengths_length := rt.sub(var_header.array_get('translations_lengths_addr'), var_header.array_get('originals_lengths_addr'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	mut var_originals := rt.call_method(var_reader_mutated, 'read', [var_originals_lengths_length.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	mut var_translations_lengths_length := rt.sub(var_header.array_get('hash_addr'), var_header.array_get('translations_lengths_addr'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	mut var_translations := rt.call_method(var_reader_mutated, 'read', [var_translations_lengths_length.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	var_originals = rt.call_method(var_reader_mutated, 'str_split', [var_originals.dup(), rt.new_int(8)])
	var_translations = rt.call_method(var_reader_mutated, 'str_split', [var_translations.dup(), rt.new_int(8)])
	mut var_strings_addr := rt.add(var_header.array_get('hash_addr'), rt.mul(var_header.array_get('hash_length'), rt.new_int(4)))
	rt.call_method(var_reader_mutated, 'seekto', [var_strings_addr.dup()])
	mut var_strings := rt.call_method(var_reader_mutated, 'read_all', []rt.PhpVal{})
	rt.call_method(var_reader_mutated, 'close', []rt.PhpVal{})
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_header.array_get('total')))) { break }
			mut var_o := rt.call_function('unpack', [rt.new_string("${var_endian.to_string()}length/${var_endian.to_string()}pos"), .array_get()])
			mut var_t := rt.call_function('unpack', [, ])
			if rt.is_true(rt.new_bool(rt.is_true() || rt.is_true())) {
				return 
			}
			
			
		}
	}
}

fn (mut this Class_MO) make_entry(var_original rt.PhpVal, var_translation rt.PhpVal) rt.PhpVal {
	mut var_original_mutated := var_original
	mut var_translation_mutated := var_translation
}

fn (mut this Class_MO) select_plural_form(var_count rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_MO) get_plural_forms_count() rt.PhpVal {
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

fn create_mo() &Class_MO {
	mut obj := &Class_MO{
		PhpObjectBase: rt.PhpObjectBase{}
		_nplurals: rt.new_int(2)
		filename: rt.new_string('')
	}
	return obj
}

fn create_gettext_translations() &Class_Gettext_Translations {
	mut obj := &Class_Gettext_Translations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_pomo_filereader() &Class_POMO_FileReader {
	mut obj := &Class_POMO_FileReader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_pomo_reader() &Class_POMO_Reader {
	mut obj := &Class_POMO_Reader{
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
		else { return none }
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
		'_nplurals' { this._nplurals = val; return true }
		'filename' { this.filename = val; return true }
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




pub fn init_wp_includes_pomo_mo_php() {
	rt.include_file(@DIR + '/translations.php', '4')
	rt.include_file(@DIR + '/streams.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('MO'), rt.new_bool(false)]))))) {
	}
}

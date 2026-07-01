import rt

pub fn Class_WP_Translation_File_MO.magic_marker() i64 {
	return 2500072158
}
struct Class_WP_Translation_File_MO {
	rt.PhpObjectBase
pub mut:
		uint32 rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WP_Translation_File_MO) detect_endian_and_validate_file(header string) rt.PhpVal {
	mut var_big := rt.call_function('unpack', [rt.new_string('N'), rt.new_string(header)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_big)) {
		return rt.new_bool(false)
	}
	var_big = rt.call_function('reset', [var_big.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_big)) {
		return rt.new_bool(false)
	}
	mut var_little := rt.call_function('unpack', [rt.new_string('V'), rt.new_string(header)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_little)) {
		return rt.new_bool(false)
	}
	var_little = rt.call_function('reset', [var_little.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_little)) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, var_big)) {
		return rt.new_string('N')
	}
	if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, var_little)) {
		return rt.new_string('V')
	}
	this.dispatch_set_prop('error', rt.new_string('Magic marker does not exist'))
	return rt.new_bool(false)
}

fn (mut this Class_WP_Translation_File_MO) parse_file() bool {
	mut var_name := rt.new_null()
	mut var_value := rt.new_null()
	this.dispatch_set_prop('parsed', rt.new_bool(true))
	mut var_file_contents := rt.call_function('file_get_contents', [rt.get_property(rt.new_object('WP_Translation_File_MO', ['WP_Translation_File'], &this), 'file')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_file_contents)) {
		return false
	}
	mut var_file_length := rt.new_int(rt.new_int(var_file_contents.dup().to_string().len))
	if rt.is_true(rt.less(var_file_length, rt.new_int(24))) {
		this.dispatch_set_prop('error', rt.new_string('Invalid data'))
		return false
	}
	this.uint32 = this.detect_endian_and_validate_file((rt.call_function('substr', [var_file_contents.dup(), rt.new_int(0), rt.new_int(4)])).str())
	if rt.is_true(rt.identical(rt.new_bool(false), this.uint32)) {
		return false
	}
	mut var_offsets := rt.call_function('substr', [var_file_contents.dup(), rt.new_int(4), rt.new_int(24)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_offsets)) {
		return false
	}
	var_offsets = rt.call_function('unpack', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(this.uint32, rt.new_string('rev/')), this.uint32), rt.new_string('total/')), this.uint32), rt.new_string('originals_addr/')), this.uint32), rt.new_string('translations_addr/')), this.uint32), rt.new_string('hash_length/')), this.uint32), rt.new_string('hash_addr')), var_offsets.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_offsets)) {
		return false
	}
	var_offsets.array_set('originals_length', rt.sub(var_offsets.array_get('translations_addr'), var_offsets.array_get('originals_addr')))
	var_offsets.array_set('translations_length', rt.sub(var_offsets.array_get('hash_addr'), var_offsets.array_get('translations_addr')))
	if rt.is_true(rt.greater(var_offsets.array_get('rev'), rt.new_int(0))) {
		this.dispatch_set_prop('error', rt.new_string('Unsupported revision'))
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_offsets.array_get('translations_addr'), var_file_length)) || rt.is_true(rt.greater(var_offsets.array_get('originals_addr'), var_file_length)))) {
		this.dispatch_set_prop('error', rt.new_string('Invalid data'))
		return false
	}
	mut var_original_data := rt.call_function('str_split', [rt.call_function('substr', [var_file_contents.dup(), var_offsets.array_get('originals_addr'), var_offsets.array_get('originals_length')]), rt.new_int(8)])
	mut var_translations_data := rt.call_function('str_split', [rt.call_function('substr', [var_file_contents.dup(), var_offsets.array_get('translations_addr'), var_offsets.array_get('translations_length')]), rt.new_int(8)])
	{
		mut iter_1 := rt.func_array_keys(var_original_data.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_i := item_1.val
			mut var_o := rt.call_function('unpack', [rt.concat(rt.concat(rt.concat(this.uint32, rt.new_string('length/')), this.uint32), rt.new_string('pos')), var_original_data.array_get(var_i)])
			mut var_t := rt.call_function('unpack', [rt.concat(rt.concat(rt.concat(this.uint32, rt.new_string('length/')), this.uint32), rt.new_string('pos')), var_translations_data.array_get(var_i)])
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_o)) || rt.is_true(rt.identical(rt.new_bool(false), var_t)))) {
				continue
			}
			mut var_original := rt.call_function('substr', [var_file_contents.dup(), var_o.array_get('pos'), var_o.array_get('length')])
			mut var_translation := rt.call_function('substr', [var_file_contents.dup(), var_t.array_get('pos'), var_t.array_get('length')])
			var_translation = rt.new_string(rt.new_string(var_translation.dup().to_string().trim_right(' \t\n\r')))
			if rt.is_true(rt.identical(rt.new_string(''), var_original)) {
				{
					mut iter_2 := rt.call_function('explode', [rt.new_string('\n'), var_translation.dup()]).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_meta_line := item_2.val
						if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_meta_line)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_meta_line.dup(), rt.new_string(':')]))))))) {
							continue
						}
						// unsupported assign target: Expr_List
						rt.get_property(rt.new_object('WP_Translation_File_MO', ['WP_Translation_File'], &this), 'headers').array_set(var_name.dup().to_string().to_lower(), var_value.dup())
					}
				}
			} else {
				mut var_parts := rt.call_function('explode', [rt.new_string(''), // unsupported expression: Expr_Cast_String])
				rt.get_property(rt.new_object('WP_Translation_File_MO', ['WP_Translation_File'], &this), 'entries').array_set(var_parts.array_get(0), var_translation.dup())
			}
		}
	}
	return true
}

fn (mut this Class_WP_Translation_File_MO) export() string {
	mut var_headers_string := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := rt.get_property(rt.new_object('WP_Translation_File_MO', ['WP_Translation_File'], &this), 'headers').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_header := item_1.key
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	mut var_entries := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: '', val: var_headers_string }]), rt.get_property(rt.new_object('WP_Translation_File_MO', ['WP_Translation_File'], &this), 'entries')])
	mut var_entry_count := rt.new_int(rt.new_int(var_entries.dup().array_count()))
	if rt.is_true(rt.identical(rt.new_bool(false), this.uint32)) {
		this.uint32 = rt.new_string('V')
	}
	mut var_bytes_for_entries := rt.mul(rt.mul(var_entry_count, rt.new_int(4)), rt.new_int(2))
	mut var_originals_addr := rt.new_int(rt.new_int(28))
	mut var_translations_addr := rt.add(var_originals_addr, var_bytes_for_entries)
	mut var_hash_addr := rt.add(var_translations_addr, var_bytes_for_entries)
	mut var_entry_offsets := var_hash_addr.dup()
	mut var_file_header := rt.call_function('pack', [(this.uint32).str() + '*', // unsupported expression: Expr_Cast_Int, rt.new_int(0), var_entry_count.dup(), var_originals_addr.dup(), var_translations_addr.dup(), rt.new_int(0), var_hash_addr.dup()])
	mut var_o_entries := rt.new_string(rt.new_string(''))
	mut var_t_entries := rt.new_string(rt.new_string(''))
	mut var_o_addr := rt.new_string(rt.new_string(''))
	mut var_t_addr := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := rt.func_array_keys(var_entries.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_original := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	{
		mut iter_1 := var_entries.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_translations := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return (var_file_header).str() + (var_o_addr).str() + (var_t_addr).str() + (var_o_entries).str() + (var_t_entries).str()
}

struct Class_WP_Translation_File {
	rt.PhpObjectBase
}

fn create_wp_translation_file_mo() &Class_WP_Translation_File_MO {
	mut obj := &Class_WP_Translation_File_MO{
		PhpObjectBase: rt.PhpObjectBase{}
		uint32: rt.new_bool(false)
	}
	return obj
}

fn create_wp_translation_file() &Class_WP_Translation_File {
	mut obj := &Class_WP_Translation_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Translation_File_MO) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'detect_endian_and_validate_file' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.detect_endian_and_validate_file(dispatch_arg_0)
		}
		'parse_file' {
			return rt.new_bool(this.parse_file())
		}
		'export' {
			return rt.new_string(this.export())
		}
		else { return none }
	}
}

fn (this &Class_WP_Translation_File_MO) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'uint32' { return this.uint32 }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Translation_File_MO) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'uint32' { this.uint32 = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Translation_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Translation_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Translation_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_l10n_class_wp_translation_file_mo_php() {
}

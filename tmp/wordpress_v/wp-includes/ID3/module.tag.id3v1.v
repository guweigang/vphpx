import rt

struct Class_getid3_id3v1 {
	rt.PhpObjectBase
}

fn (mut this Class_getid3_id3v1) analyze() bool {
	mut var_info := map[string]rt.PhpVal{}
	// unsupported expression: Expr_AssignRef
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.intvaluesupported(arg_0) }(var_info.array_get('filesize')))))) {
		this.warning(rt.new_string('Unable to check for ID3v1 because file is larger than ' + (rt.call_function('round', [rt.div(rt.get_constant('PHP_INT_MAX'), rt.new_int(1073741824))])).str() + 'GB'))
		return false
	} else if rt.is_true(rt.less(var_info.array_get('filesize'), rt.new_int(128))) {
		this.warning(rt.new_string('Unable to check for ID3v1 because file is too small'))
		return false
	}
	if rt.is_true(rt.less(var_info.array_get('filesize'), rt.new_int(256))) {
		this.fseek(// unsupported expression: Expr_UnaryMinus, rt.get_constant('SEEK_END'))
		mut var_preid3v1 := rt.new_string(rt.new_string(''))
		mut var_id3v1tag := this.fread(rt.new_int(128))
	} else {
		this.fseek(// unsupported expression: Expr_UnaryMinus, rt.get_constant('SEEK_END'))
		var_preid3v1 = this.fread(rt.new_int(128))
		var_id3v1tag = this.fread(rt.new_int(128))
	}
	if rt.is_true(rt.equal(rt.call_function('substr', [var_id3v1tag.dup(), rt.new_int(0), rt.new_int(3)]), rt.new_string('TAG'))) {
		var_info['avdataend'] = rt.sub(var_info.array_get('filesize'), rt.new_int(128))
		mut var_ParsedID3v1 := map[string]rt.PhpVal{}
		var_ParsedID3v1['title'] = this.cutfield(rt.call_function('substr', [var_id3v1tag.dup(), rt.new_int(3), rt.new_int(30)]))
		var_ParsedID3v1['artist'] = this.cutfield(rt.call_function('substr', [var_id3v1tag.dup(), rt.new_int(33), rt.new_int(30)]))
		var_ParsedID3v1['album'] = this.cutfield(rt.call_function('substr', [var_id3v1tag.dup(), rt.new_int(63), rt.new_int(30)]))
		var_ParsedID3v1['year'] = this.cutfield(rt.call_function('substr', [var_id3v1tag.dup(), rt.new_int(93), rt.new_int(4)]))
		var_ParsedID3v1['comment'] = rt.call_function('substr', [var_id3v1tag.dup(), rt.new_int(97), rt.new_int(30)])
		var_ParsedID3v1['genreid'] = rt.call_function('ord', [rt.call_function('substr', [var_id3v1tag.dup(), rt.new_int(127), rt.new_int(1)])])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_id3v1tag.array_get(125), rt.new_string(''))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_ParsedID3v1['track_number'] = rt.call_function('ord', [rt.call_function('substr', [var_ParsedID3v1.array_get('comment'), rt.new_int(29), rt.new_int(1)])])
			var_ParsedID3v1['comment'] = rt.call_function('substr', [var_ParsedID3v1.array_get('comment'), rt.new_int(0), rt.new_int(28)])
		}
		var_ParsedID3v1['comment'] = this.cutfield(var_ParsedID3v1.array_get('comment'))
		var_ParsedID3v1['genre'] = this.lookupgenrename(var_ParsedID3v1.array_get('genreid'), false)
		if !(!rt.is_true(var_ParsedID3v1.array_get('genre'))) {
			var_ParsedID3v1.delete('genreid')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(var_ParsedID3v1.array_get('genre')) || rt.is_true(rt.equal(var_ParsedID3v1.array_get('genre'), rt.new_string('Unknown'))))) {
			var_ParsedID3v1.delete('genre')
		}
		for var_key, var_value in var_ParsedID3v1 {
			var_ParsedID3v1.array_get_mut('comments').array_get_mut(key).array_set(0, var_value.dup())
		}
		mut var_ID3v1encoding := rt.get_property(rt.get_property(rt.new_object('getid3_id3v1', ['getid3_handler'], &this), 'getid3'), 'encoding_id3v1')
		if rt.is_true(rt.get_property(rt.get_property(rt.new_object('getid3_id3v1', ['getid3_handler'], &this), 'getid3'), 'encoding_id3v1_autodetect')) {
			{
				mut iter_1 := var_ParsedID3v1.array_get('comments').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_valuearray := item_1.val
					mut var_tag_key := item_1.key
					{
						mut iter_2 := var_valuearray.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_value := item_2.val
							mut var_key := item_2.key
							if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', [rt.new_string('#^[\\x00-\\x40\\x80-\\xFF]+$#'), var_value.dup()])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_digit', [// unsupported expression: Expr_Cast_String]))))))) {
								{
									mut iter_3 := rt.create_array([rt.ArrayItem{ key: none, val: 'Windows-1251' }, rt.ArrayItem{ key: none, val: 'KOI8-R' }]).iterator()
									for {
										item_3 := iter_3.next() or { break }
										mut var_id3v1_bad_encoding := item_3.val
										if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_convert_encoding')])) && rt.is_true(rt.identical(rt.call_function('mb_convert_encoding', [var_value.dup(), var_id3v1_bad_encoding.dup(), var_id3v1_bad_encoding.dup()]), var_value)))) {
											var_ID3v1encoding = var_id3v1_bad_encoding
											this.warning(rt.new_string('ID3v1 detected as ' + (var_id3v1_bad_encoding).str() + ' text encoding in ' + (var_tag_key).str()))
											break
										} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('iconv')])) && rt.is_true(rt.identical(rt.call_function('iconv', [var_id3v1_bad_encoding.dup(), var_id3v1_bad_encoding.dup(), var_value.dup()]), var_value)))) {
											var_ID3v1encoding = var_id3v1_bad_encoding
											this.warning(rt.new_string('ID3v1 detected as ' + (var_id3v1_bad_encoding).str() + ' text encoding in ' + (var_tag_key).str()))
											break
										}
									}
								}
							}
						}
					}
				}
			}
			// unsupported statement: Stmt_Nop
		}
		mut var_GoodFormatID3v1tag := this.generateid3v1tag(var_ParsedID3v1.array_get('title'), var_ParsedID3v1.array_get('artist'), var_ParsedID3v1.array_get('album'), var_ParsedID3v1.array_get('year'), rt.new_bool(if var_ParsedID3v1.array_isset(rt.new_string('genre')) { this.lookupgenreid(var_ParsedID3v1.array_get('genre'), false) } else { false }), var_ParsedID3v1.array_get('comment'), (if !(!rt.is_true(var_ParsedID3v1.array_get('track_number'))) { var_ParsedID3v1.array_get('track_number') } else { rt.new_string('') }).str())
		var_ParsedID3v1['padding_valid'] = rt.new_bool(true)
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_ParsedID3v1['padding_valid'] = rt.new_bool(false)
			this.warning(rt.new_string('Some ID3v1 fields do not use NULL characters for padding'))
		}
		var_ParsedID3v1['tag_offset_end'] = var_info.array_get('filesize')
		var_ParsedID3v1['tag_offset_start'] = rt.sub(var_ParsedID3v1.array_get('tag_offset_end'), rt.new_int(128))
		var_info['id3v1'] = var_ParsedID3v1.dup()
		var_info.array_get_mut('id3v1').array_set('encoding', var_ID3v1encoding.dup())
	}
	if rt.is_true(rt.equal(rt.call_function('substr', [var_preid3v1.dup(), rt.new_int(0), rt.new_int(3)]), rt.new_string('TAG'))) {
		if rt.is_true(rt.equal(rt.call_function('substr', [var_preid3v1.dup(), rt.new_int(96), rt.new_int(8)]), rt.new_string('APETAGEX'))) {
			// unsupported statement: Stmt_Nop
		} else if rt.is_true(rt.equal(rt.call_function('substr', [var_preid3v1.dup(), rt.new_int(119), rt.new_int(6)]), rt.new_string('LYRICS'))) {
			// unsupported statement: Stmt_Nop
		} else {
			this.warning(rt.new_string('Duplicate ID3v1 tag detected - this has been known to happen with iTunes'))
			// unsupported expression: Expr_AssignOp_Minus
		}
	}
	return true
}

fn Class_getid3_id3v1.cutfield(var_str rt.PhpVal) string {
	return rt.call_function('substr', [var_str.dup(), rt.new_int(0), rt.call_function('strcspn', [var_str.dup(), rt.new_string('')])]).to_string().trim_space()
}

fn Class_getid3_id3v1.arrayofgenres(allowSCMPXextended bool) rt.PhpVal {
	mut var_GenreLookup := rt.new_null()
	// unsupported statement: Stmt_Static
	// unsupported statement: Stmt_Static
	if var_allowSCMPXextended && !rt.is_true(var_GenreLookupSCMPX) {
		mut var_GenreLookupSCMPX := var_GenreLookup.dup()
		var_GenreLookupSCMPX.array_set(240, 'Sacred')
		var_GenreLookupSCMPX.array_set(241, 'Northern Europe')
		var_GenreLookupSCMPX.array_set(242, 'Irish & Scottish')
		var_GenreLookupSCMPX.array_set(243, 'Scotland')
		var_GenreLookupSCMPX.array_set(244, 'Ethnic Europe')
		var_GenreLookupSCMPX.array_set(245, 'Enka')
		var_GenreLookupSCMPX.array_set(246, 'Children\'s Song')
		var_GenreLookupSCMPX.array_set(247, 'Japanese Sky')
		var_GenreLookupSCMPX.array_set(248, 'Japanese Heavy Rock')
		var_GenreLookupSCMPX.array_set(249, 'Japanese Doom Rock')
		var_GenreLookupSCMPX.array_set(250, 'Japanese J-POP')
		var_GenreLookupSCMPX.array_set(251, 'Japanese Seiyu')
		var_GenreLookupSCMPX.array_set(252, 'Japanese Ambient Techno')
		var_GenreLookupSCMPX.array_set(253, 'Japanese Moemoe')
		var_GenreLookupSCMPX.array_set(254, 'Japanese Tokusatsu')
		// unsupported statement: Stmt_Nop
	}
	return if var_allowSCMPXextended { var_GenreLookupSCMPX } else { var_GenreLookup }
}

fn Class_getid3_id3v1.lookupgenrename(var_genreid rt.PhpVal, allowSCMPXextended bool) rt.PhpVal {
	mut var_genreid_mutated := var_genreid
	mut switch_val_1 := var_genreid_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('RX'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('CR'))) {
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_genreid_mutated.dup().is_long() || var_genreid_mutated.dup().is_double()))))) {
			return rt.new_bool(false)
		}
		var_genreid_mutated = rt.new_int(rt.new_int(var_genreid_mutated.dup().to_i64()))
	}
	mut var_GenreLookup := Class_getid3_id3v1.arrayofgenres(allowSCMPXextended)
	return if var_GenreLookup.array_isset(var_genreid_mutated) { var_GenreLookup.array_get(var_genreid_mutated) } else { rt.new_bool(false) }
}

fn Class_getid3_id3v1.lookupgenreid(var_genre rt.PhpVal, allowSCMPXextended bool) bool {
	mut var_GenreLookup := Class_getid3_id3v1.arrayofgenres(allowSCMPXextended)
	mut var_LowerCaseNoSpaceSearchTerm := rt.new_string(rt.new_string(rt.call_function('str_replace', [rt.new_string(' '), rt.new_string(''), var_genre.dup()]).to_string().to_lower()))
	{
		mut iter_1 := var_GenreLookup.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.equal(rt.new_string(rt.call_function('str_replace', [rt.new_string(' '), rt.new_string(''), var_value.dup()]).to_string().to_lower()), var_LowerCaseNoSpaceSearchTerm)) {
				return (var_key).to_bool()
			}
		}
	}
	return false
}

fn Class_getid3_id3v1.standardiseid3v1genrename(var_OriginalGenre rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return Class_getid3_id3v1.lookupgenrename((var_GenreID).to_bool())
	}
	return var_OriginalGenre.dup()
}

fn Class_getid3_id3v1.generateid3v1tag(var_title rt.PhpVal, var_artist rt.PhpVal, var_album rt.PhpVal, var_year rt.PhpVal, var_genreid rt.PhpVal, var_comment rt.PhpVal, track string) rt.PhpVal {
	mut var_genreid_mutated := var_genreid
	mut track_mutated := track
	mut var_ID3v1Tag := rt.new_string(rt.new_string('TAG'))
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(track_mutated == '') && rt.is_true(rt.greater(rt.new_string(track_mutated), rt.new_int(0))))) && rt.is_true(rt.less_equal(rt.new_string(track_mutated), rt.new_int(255))))) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		if rt.is_true(rt.equal(rt.call_function('gettype', [rt.new_string(track_mutated).dup()]), rt.new_string('string'))) {
			track_mutated = (// unsupported expression: Expr_Cast_Int).str()
		}
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_genreid_mutated, rt.new_int(0))) || rt.is_true(rt.greater(var_genreid_mutated, rt.new_int(147))))) {
		var_genreid_mutated = rt.new_int(rt.new_int(255))
		// unsupported statement: Stmt_Nop
	}
	mut switch_val_2 := rt.call_function('gettype', [.dup()])
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('string'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('integer'))) {
		
	} else {
	}
}

struct Class_getid3_handler {
	rt.PhpObjectBase
}

struct Class_getid3_lib {
	rt.PhpObjectBase
}

fn create_getid3_id3v1() &Class_getid3_id3v1 {
	mut obj := &Class_getid3_id3v1{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_getid3_handler() &Class_getid3_handler {
	mut obj := &Class_getid3_handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_getid3_lib() &Class_getid3_lib {
	mut obj := &Class_getid3_lib{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_getid3_id3v1) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'Analyze' {
			return rt.new_bool(this.analyze())
		}
		'cutfield' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_getid3_id3v1.cutfield(dispatch_arg_0))
		}
		'ArrayOfGenres' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_getid3_id3v1.arrayofgenres(dispatch_arg_0)
		}
		'LookupGenreName' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_getid3_id3v1.lookupgenrename(dispatch_arg_0, dispatch_arg_1)
		}
		'LookupGenreID' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(Class_getid3_id3v1.lookupgenreid(dispatch_arg_0, dispatch_arg_1))
		}
		'StandardiseID3v1GenreName' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_id3v1.standardiseid3v1genrename(dispatch_arg_0)
		}
		'GenerateID3v1Tag' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).str()
			return Class_getid3_id3v1.generateid3v1tag(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
		}
		else { return none }
	}
}

fn (this &Class_getid3_id3v1) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_getid3_id3v1) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_getid3_handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_getid3_handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_getid3_handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_getid3_lib) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_getid3_lib) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_getid3_lib) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_id3_module_tag_id3v1_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_INCLUDEPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}

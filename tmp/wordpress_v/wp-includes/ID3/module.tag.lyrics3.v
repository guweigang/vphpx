import rt

struct Class_getid3_lyrics3 {
	rt.PhpObjectBase
}

fn (mut this Class_getid3_lyrics3) analyze() bool {
	mut var_info := map[string]rt.PhpVal{}
	mut var_GETID3_ERRORARRAY := rt.new_null()
	// unsupported expression: Expr_AssignRef
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.intvaluesupported(arg_0) }(var_info.array_get('filesize')))))) {
		this.warning(rt.new_string('Unable to check for Lyrics3 because file is larger than ' + (rt.call_function('round', [rt.div(rt.get_constant('PHP_INT_MAX'), rt.new_int(1073741824))])).str() + 'GB'))
		return false
	}
	this.fseek(rt.new_int(0 - 128 - 9 - 6), rt.get_constant('SEEK_END'))
	mut var_lyrics3offset := rt.new_null()
	mut var_lyrics3version := rt.new_null()
	mut var_lyrics3size := rt.new_null()
	mut var_lyrics3_id3v1 := this.fread(rt.new_int(128 + 9 + 6))
	mut var_lyrics3lsz := // unsupported expression: Expr_Cast_Int
	mut var_lyrics3end := rt.call_function('substr', [var_lyrics3_id3v1.dup(), rt.new_int(6), rt.new_int(9)])
	mut var_id3v1tag := rt.call_function('substr', [var_lyrics3_id3v1.dup(), rt.new_int(15), rt.new_int(128)])
	if rt.is_true(rt.equal(var_lyrics3end, rt.new_string('LYRICSEND'))) {
		var_lyrics3size = rt.new_int(rt.new_int(5100))
		var_lyrics3offset = rt.sub(rt.sub(var_info.array_get('filesize'), rt.new_int(128)), var_lyrics3size)
		var_lyrics3version = rt.new_int(rt.new_int(1))
	} else if rt.is_true(rt.equal(var_lyrics3end, rt.new_string('LYRICS200'))) {
		var_lyrics3size = rt.add(rt.add(var_lyrics3lsz, rt.new_int(6)), rt.new_int('LYRICS200'.len))
		var_lyrics3offset = rt.sub(rt.sub(var_info.array_get('filesize'), rt.new_int(128)), var_lyrics3size)
		var_lyrics3version = rt.new_int(rt.new_int(2))
	} else if rt.is_true(rt.equal(rt.call_function('substr', [rt.call_function('strrev', [var_lyrics3_id3v1.dup()]), rt.new_int(0), rt.new_int(9)]), rt.call_function('strrev', [rt.new_string('LYRICSEND')]))) {
		var_lyrics3size = rt.new_int(rt.new_int(5100))
		var_lyrics3offset = rt.sub(var_info.array_get('filesize'), var_lyrics3size)
		var_lyrics3version = rt.new_int(rt.new_int(1))
		var_lyrics3offset = rt.sub(var_info.array_get('filesize'), var_lyrics3size)
	} else if rt.is_true(rt.equal(rt.call_function('substr', [rt.call_function('strrev', [var_lyrics3_id3v1.dup()]), rt.new_int(0), rt.new_int(9)]), rt.call_function('strrev', [rt.new_string('LYRICS200')]))) {
		var_lyrics3size = rt.add(rt.add(// unsupported expression: Expr_Cast_Int, rt.new_int(6)), rt.new_int('LYRICS200'.len))
		var_lyrics3offset = rt.sub(var_info.array_get('filesize'), var_lyrics3size)
		var_lyrics3version = rt.new_int(rt.new_int(2))
	} else {
		if rt.is_true(rt.new_bool(var_info.array_get('ape').array_isset(rt.new_string('tag_offset_start')) && rt.is_true(rt.greater(var_info.array_get('ape').array_get('tag_offset_start'), rt.new_int(15))))) {
			this.fseek(rt.sub(var_info.array_get('ape').array_get('tag_offset_start'), rt.new_int(15)))
			var_lyrics3lsz = this.fread(rt.new_int(6))
			var_lyrics3end = this.fread(rt.new_int(9))
			if rt.is_true(rt.equal(var_lyrics3end, rt.new_string('LYRICSEND'))) {
				var_lyrics3size = rt.new_int(rt.new_int(5100))
				var_lyrics3offset = rt.sub(var_info.array_get('ape').array_get('tag_offset_start'), var_lyrics3size)
				var_info['avdataend'] = var_lyrics3offset.dup()
				var_lyrics3version = rt.new_int(rt.new_int(1))
				this.warning(rt.new_string('APE tag located after Lyrics3, will probably break Lyrics3 compatability'))
			} else if rt.is_true(rt.equal(var_lyrics3end, rt.new_string('LYRICS200'))) {
				var_lyrics3size = rt.add(rt.add(var_lyrics3lsz, rt.new_int(6)), rt.new_int('LYRICS200'.len))
				var_lyrics3offset = rt.sub(var_info.array_get('ape').array_get('tag_offset_start'), var_lyrics3size)
				var_lyrics3version = rt.new_int(rt.new_int(2))
				this.warning(rt.new_string('APE tag located after Lyrics3, will probably break Lyrics3 compatability'))
			}
		}
	}
	if !(var_lyrics3offset).is_null() && !(var_lyrics3version).is_null() && !(var_lyrics3size).is_null() {
		var_info['avdataend'] = var_lyrics3offset.dup()
		this.getlyrics3data(var_lyrics3offset.dup(), var_lyrics3version.dup(), var_lyrics3size.dup())
		if !(var_info.array_isset(rt.new_string('ape'))) {
			if var_info.array_get('lyrics3').array_isset(rt.new_string('tag_offset_start')) {
				// unsupported expression: Expr_AssignRef
				if rt.is_true(rt.get_property(rt.get_property(rt.new_object('getid3_lyrics3', ['getid3_handler'], &this), 'getid3'), 'option_tag_apetag')) {
					fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.includedependency(arg_0, arg_1, arg_2) }(rt.new_string((rt.get_constant('GETID3_INCLUDEPATH')).str() + 'module.tag.apetag.php'), rt.new_string(@FILE), rt.new_bool(true))
					mut var_getid3_temp := create_getid3()
					var_getid3_temp.openfile(rt.get_property(rt.get_property(rt.new_object('getid3_lyrics3', ['getid3_handler'], &this), 'getid3'), 'filename'), rt.get_property(rt.get_property(rt.new_object('getid3_lyrics3', ['getid3_handler'], &this), 'getid3'), 'info').array_get('filesize'), rt.get_property(rt.get_property(rt.new_object('getid3_lyrics3', ['getid3_handler'], &this), 'getid3'), 'fp'))
					mut var_getid3_apetag := create_getid3_apetag(var_getid3_temp.dup())
					rt.set_property(var_getid3_apetag, 'overrideendoffset', var_info.array_get('lyrics3').array_get('tag_offset_start'))
					var_getid3_apetag.analyze()
					if !(!rt.is_true(rt.get_property(var_getid3_temp, 'info').array_get('ape'))) {
						var_info['ape'] = rt.get_property(var_getid3_temp, 'info').array_get('ape')
					}
					if !(!rt.is_true(rt.get_property(var_getid3_temp, 'info').array_get('replay_gain'))) {
						var_info['replay_gain'] = rt.get_property(var_getid3_temp, 'info').array_get('replay_gain')
					}
					var_getid3_temp = rt.new_null()
					var_getid3_apetag = rt.new_null()
				} else {
					this.warning(rt.new_string('Unable to check for Lyrics3 and APE tags interaction since option_tag_apetag=FALSE'))
				}
			} else {
				this.warning(rt.new_string('Lyrics3 and APE tags appear to have become entangled (most likely due to updating the APE tags with a non-Lyrics3-aware tagger)'))
			}
		}
	}
	return true
}

fn (mut this Class_getid3_lyrics3) getlyrics3data(var_endoffset rt.PhpVal, var_version rt.PhpVal, var_length rt.PhpVal) bool {
	mut var_info := map[string]rt.PhpVal{}
	mut var_length_mutated := var_length
	// unsupported expression: Expr_AssignRef
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.intvaluesupported(arg_0) }(var_endoffset.dup()))))) {
		this.warning(rt.new_string('Unable to check for Lyrics3 because file is larger than ' + (rt.call_function('round', [rt.div(rt.get_constant('PHP_INT_MAX'), rt.new_int(1073741824))])).str() + 'GB'))
		return false
	}
	this.fseek(var_endoffset.dup())
	if rt.is_true(rt.less_equal(var_length_mutated, rt.new_int(0))) {
		return false
	}
	mut var_rawdata := this.fread(var_length_mutated.dup())
	mut var_ParsedLyrics3 := map[string]rt.PhpVal{}
	var_ParsedLyrics3.array_get_mut('raw').array_set('lyrics3version', var_version.dup())
	var_ParsedLyrics3.array_get_mut('raw').array_set('lyrics3tagsize', var_length_mutated.dup())
	var_ParsedLyrics3['tag_offset_start'] = var_endoffset.dup()
	var_ParsedLyrics3['tag_offset_end'] = rt.sub(rt.add(var_endoffset, var_length_mutated), rt.new_int(1))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			this.warning(rt.new_string('"LYRICSBEGIN" expected at ' + (var_endoffset).str() + ' but actually found at ' + (rt.add(var_endoffset, rt.call_function('strpos', [var_rawdata.dup(), rt.new_string('LYRICSBEGIN')]))).str() + ' - this is invalid for Lyrics3 v' + (var_version).str()))
			var_info['avdataend'] = rt.add(var_endoffset, rt.call_function('strpos', [var_rawdata.dup(), rt.new_string('LYRICSBEGIN')]))
			var_rawdata = rt.call_function('substr', [var_rawdata.dup(), rt.call_function('strpos', [var_rawdata.dup(), rt.new_string('LYRICSBEGIN')])])
			var_length_mutated = rt.new_int(rt.new_int(var_rawdata.dup().to_string().len))
			var_ParsedLyrics3['tag_offset_start'] = var_info.array_get('avdataend')
			var_ParsedLyrics3.array_get_mut('raw').array_set('lyrics3tagsize', var_length_mutated.dup())
		} else {
			this.error(rt.new_string('"LYRICSBEGIN" expected at ' + (var_endoffset).str() + ' but found "' + (rt.call_function('substr', [var_rawdata.dup(), rt.new_int(0), rt.new_int(11)])).str() + '" instead'))
			return false
		}
	}
	mut switch_val_1 := var_version
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		if rt.is_true(rt.equal(rt.call_function('substr', [var_rawdata.dup(), var_rawdata.dup().to_string().len - 9, rt.new_int(9)]), rt.new_string('LYRICSEND'))) {
			var_ParsedLyrics3.array_get_mut('raw').array_set('LYR', rt.call_function('substr', [var_rawdata.dup(), rt.new_int(11), var_rawdata.dup().to_string().len - 11 - 9]).to_string().trim_space())
			this.lyrics3lyricstimestampparse(var_ParsedLyrics3.dup())
		} else {
			this.error(rt.new_string('"LYRICSEND" expected at ' + (rt.sub(rt.add(rt.sub(this.ftell(), rt.new_int(11)), var_length_mutated), rt.new_int(9))).str() + ' but found "' + (rt.call_function('substr', [var_rawdata.dup(), var_rawdata.dup().to_string().len - 9, rt.new_int(9)])).str() + '" instead'))
			return false
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
		if rt.is_true(rt.equal(rt.call_function('substr', [var_rawdata.dup(), var_rawdata.dup().to_string().len - 9, rt.new_int(9)]), rt.new_string('LYRICS200'))) {
			var_ParsedLyrics3.array_get_mut('raw').array_set('unparsed', rt.call_function('substr', [var_rawdata.dup(), rt.new_int(11), var_rawdata.dup().to_string().len - 11 - 9 - 6]))
			var_rawdata = var_ParsedLyrics3.array_get('raw').array_get('unparsed')
			for var_rawdata.dup().to_string().len > 0 {
				mut var_fieldname := rt.call_function('substr', [var_rawdata.dup(), rt.new_int(0), rt.new_int(3)])
				mut var_fieldsize := // unsupported expression: Expr_Cast_Int
				var_ParsedLyrics3.array_get_mut('raw').array_set(var_fieldname, rt.call_function('substr', [var_rawdata.dup(), rt.new_int(8), var_fieldsize.dup()]))
				var_rawdata = rt.call_function('substr', [var_rawdata.dup(), rt.add(3 + 5, var_fieldsize)])
			}
			if var_ParsedLyrics3.array_get('raw').array_isset(rt.new_string('IND')) {
				mut var_i := rt.new_int(rt.new_int(0))
				mut var_flagnames := rt.create_array([rt.ArrayItem{ key: none, val: 'lyrics' }, rt.ArrayItem{ key: none, val: 'timestamps' }, rt.ArrayItem{ key: none, val: 'inhibitrandom' }])
				{
					mut iter_1 := var_flagnames.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_flagname := item_1.val
						if rt.is_true(rt.greater(rt.new_int(var_ParsedLyrics3.array_get('raw').array_get('IND').to_string().len), rt.post_inc(var_i))) {
							var_ParsedLyrics3.array_get_mut('flags').array_set(var_flagname, this.intstring2bool(rt.call_function('substr', [var_ParsedLyrics3.array_get('raw').array_get('IND'), var_i.dup(), 1 - 1])))
						}
					}
				}
			}
			mut var_fieldnametranslation := rt.create_array([rt.ArrayItem{ key: 'ETT', val: 'title' }, rt.ArrayItem{ key: 'EAR', val: 'artist' }, rt.ArrayItem{ key: 'EAL', val: 'album' }, rt.ArrayItem{ key: 'INF', val: 'comment' }, rt.ArrayItem{ key: 'AUT', val: 'author' }])
			{
				mut iter_1 := var_fieldnametranslation.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_value := item_1.val
					mut var_key := item_1.key
					if var_ParsedLyrics3.array_get('raw').array_isset(var_key) {
						var_ParsedLyrics3.array_get_mut('comments').array_get_mut(var_value).array_push(var_ParsedLyrics3.array_get('raw').array_get(var_key).to_string().trim_space())
					}
				}
			}
			if var_ParsedLyrics3.array_get('raw').array_isset(rt.new_string('IMG')) {
				mut var_imagestrings := rt.call_function('explode', [rt.new_string('\r\n'), var_ParsedLyrics3.array_get('raw').array_get('IMG')])
				{
					mut iter_1 := var_imagestrings.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_imagestring := item_1.val
						mut var_key := item_1.key
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							mut var_imagearray := rt.call_function('explode', [rt.new_string('||'), var_imagestring.dup()])
							var_ParsedLyrics3.array_get_mut('images').array_get_mut(var_key).array_set('filename', .array_get())
							.array_get_mut().array_get_mut().array_set(, )
							
						}
					}
				}
			}
			if .array_get().array_isset(rt.new_string('LYR')) {
				
			}
		} else {
			
		}
	} else {
		
	}
}

fn (mut this Class_getid3_lyrics3) lyrics3timestamp2seconds(var_rawtimestamp rt.PhpVal) bool {
	mut var_regs := []rt.PhpVal{}
}

fn (mut this Class_getid3_lyrics3) lyrics3lyricstimestampparse(var_Lyrics3data rt.PhpVal) bool {
}

fn (mut this Class_getid3_lyrics3) intstring2bool(var_char rt.PhpVal) rt.PhpVal {
}

struct Class_getid3_handler {
	rt.PhpObjectBase
}

struct Class_getid3_lib {
	rt.PhpObjectBase
}

struct Class_getID3 {
	rt.PhpObjectBase
}

struct Class_getid3_apetag {
	rt.PhpObjectBase
}

fn create_getid3_lyrics3() &Class_getid3_lyrics3 {
	mut obj := &Class_getid3_lyrics3{
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

fn create_getid3() &Class_getID3 {
	mut obj := &Class_getID3{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_getid3_apetag() &Class_getid3_apetag {
	mut obj := &Class_getid3_apetag{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_getid3_lyrics3) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'Analyze' {
			return rt.new_bool(this.analyze())
		}
		'getLyrics3Data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.getlyrics3data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'Lyrics3Timestamp2Seconds' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.lyrics3timestamp2seconds(dispatch_arg_0))
		}
		'Lyrics3LyricsTimestampParse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.lyrics3lyricstimestampparse(dispatch_arg_0))
		}
		'IntString2Bool' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.intstring2bool(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_getid3_lyrics3) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_getid3_lyrics3) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_getID3) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_getID3) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_getID3) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_getid3_apetag) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_getid3_apetag) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_getid3_apetag) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_id3_module_tag_lyrics3_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_INCLUDEPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}

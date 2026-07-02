import rt

struct Class_getid3_lyrics3 {
	rt.PhpObjectBase
}

fn (mut this Class_getid3_lyrics3) analyze() bool {
	mut var_info := map[string]rt.PhpVal{}
	mut var_GETID3_ERRORARRAY := rt.new_null()
	var_info = rt.get_property(rt.get_property(rt.new_object('getid3_lyrics3', [
		'getid3_handler',
	], &this), 'getid3'), 'info')
	mut iife_temp_0 := Class_getid3_lib{}
	mut iife_result_0 :=
		iife_temp_0.intvaluesupported(var_info.array_get(rt.new_string('filesize')))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		this.warning(rt.new_string('Unable to check for Lyrics3 because file is larger than ' +
			(rt.call_function('round', [rt.div(rt.get_constant('PHP_INT_MAX'), rt.new_int(1073741824))])).str() +
			'GB'))
		return false
	}
	this.fseek(rt.new_int(0 - 128 - 9 - 6), rt.get_constant('SEEK_END'))
	mut var_lyrics3offset := rt.new_null()
	mut var_lyrics3version := rt.new_null()
	mut var_lyrics3size := rt.new_null()
	mut var_lyrics3_id3v1 := this.fread(rt.new_int(128 + 9 + 6))
	mut var_lyrics3lsz := rt.new_int((rt.call_function('substr', [
		var_lyrics3_id3v1.clone(), rt.new_int(0), rt.new_int(6)])).to_i64())
	mut var_lyrics3end := rt.call_function('substr', [var_lyrics3_id3v1.clone(),
		rt.new_int(6), rt.new_int(9)])
	mut var_id3v1tag := rt.call_function('substr', [var_lyrics3_id3v1.clone(),
		rt.new_int(15), rt.new_int(128)])
	if rt.is_true(rt.equal(var_lyrics3end, rt.new_string('LYRICSEND'))) {
		var_lyrics3size = rt.new_int(5100)
		var_lyrics3offset = rt.sub(rt.sub(var_info.array_get(rt.new_string('filesize')),
			rt.new_int(128)), var_lyrics3size)
		var_lyrics3version = rt.new_int(1)
	} else if rt.is_true(rt.equal(var_lyrics3end, rt.new_string('LYRICS200'))) {
		var_lyrics3size = rt.add(rt.add(var_lyrics3lsz, rt.new_int(6)), rt.new_int('LYRICS200'.len))
		var_lyrics3offset = rt.sub(rt.sub(var_info.array_get(rt.new_string('filesize')),
			rt.new_int(128)), var_lyrics3size)
		var_lyrics3version = rt.new_int(2)
	} else if rt.is_true(rt.equal(rt.call_function('substr', [
		rt.call_function('strrev', [var_lyrics3_id3v1.clone()]),
		rt.new_int(0),
		rt.new_int(9),
	]), rt.call_function('strrev', [rt.new_string('LYRICSEND')])))
	{
		var_lyrics3size = rt.new_int(5100)
		var_lyrics3offset = rt.sub(var_info.array_get(rt.new_string('filesize')), var_lyrics3size)
		var_lyrics3version = rt.new_int(1)
		var_lyrics3offset = rt.sub(var_info.array_get(rt.new_string('filesize')), var_lyrics3size)
	} else if rt.is_true(rt.equal(rt.call_function('substr', [
		rt.call_function('strrev', [var_lyrics3_id3v1.clone()]),
		rt.new_int(0),
		rt.new_int(9),
	]), rt.call_function('strrev', [rt.new_string('LYRICS200')])))
	{
		var_lyrics3size =
			rt.new_int((rt.call_function('strrev', [rt.call_function('substr', [rt.call_function('strrev', [var_lyrics3_id3v1.clone()]), rt.new_int(9), rt.new_int(6)])])).to_i64()) +
			6 + 'LYRICS200'.len
		var_lyrics3offset = rt.sub(var_info.array_get(rt.new_string('filesize')), var_lyrics3size)
		var_lyrics3version = rt.new_int(2)
	} else {
		if var_info.array_get(rt.new_string('ape')).array_isset(rt.new_string('tag_offset_start'))
			&& rt.is_true(rt.greater(var_info.array_get(rt.new_string('ape')).array_get(rt.new_string('tag_offset_start')), rt.new_int(15))) {
			this.fseek(rt.sub(var_info.array_get(rt.new_string('ape')).array_get(rt.new_string('tag_offset_start')),
				rt.new_int(15)))
			var_lyrics3lsz = this.fread(rt.new_int(6))
			var_lyrics3end = this.fread(rt.new_int(9))
			if rt.is_true(rt.equal(var_lyrics3end, rt.new_string('LYRICSEND'))) {
				var_lyrics3size = rt.new_int(5100)
				var_lyrics3offset = rt.sub(var_info.array_get(rt.new_string('ape')).array_get(rt.new_string('tag_offset_start')),
					var_lyrics3size)
				var_info['avdataend'] = var_lyrics3offset.clone()
				var_lyrics3version = rt.new_int(1)
				this.warning(rt.new_string('APE tag located after Lyrics3, will probably break Lyrics3 compatability'))
			} else if rt.is_true(rt.equal(var_lyrics3end, rt.new_string('LYRICS200'))) {
				var_lyrics3size = rt.add(rt.add(var_lyrics3lsz, rt.new_int(6)),
					rt.new_int('LYRICS200'.len))
				var_lyrics3offset = rt.sub(var_info.array_get(rt.new_string('ape')).array_get(rt.new_string('tag_offset_start')),
					var_lyrics3size)
				var_lyrics3version = rt.new_int(2)
				this.warning(rt.new_string('APE tag located after Lyrics3, will probably break Lyrics3 compatability'))
			}
		}
	}
	if !var_lyrics3offset.is_null() && !var_lyrics3version.is_null() && !var_lyrics3size.is_null() {
		var_info['avdataend'] = var_lyrics3offset.clone()
		this.getlyrics3data(var_lyrics3offset.clone(), var_lyrics3version.clone(),
			var_lyrics3size.clone())
		if !(var_info.array_isset(rt.new_string('ape'))) {
			if var_info.array_get(rt.new_string('lyrics3')).array_isset(rt.new_string('tag_offset_start')) {
				var_GETID3_ERRORARRAY = var_info.array_get(rt.new_string('warning'))
				if rt.is_true(rt.get_property(rt.get_property(rt.new_object('getid3_lyrics3', [
					'getid3_handler',
				], &this), 'getid3'), 'option_tag_apetag'))
				{
					mut iife_temp_1 := Class_getid3_lib{}
					mut iife_result_1 := iife_temp_1.includedependency(rt.new_string(
						(rt.get_constant('GETID3_INCLUDEPATH')).str() + 'module.tag.apetag.php'),
						rt.new_string(@FILE), rt.new_bool(true))
					mut var_getid3_temp := create_getid3()
					var_getid3_temp.openfile(rt.get_property(rt.get_property(rt.new_object('getid3_lyrics3', [
						'getid3_handler',
					], &this), 'getid3'), 'filename'), rt.get_property(rt.get_property(rt.new_object('getid3_lyrics3', [
						'getid3_handler',
					], &this), 'getid3'), 'info').array_get(rt.new_string('filesize')), rt.get_property(rt.get_property(rt.new_object('getid3_lyrics3', [
						'getid3_handler',
					], &this), 'getid3'), 'fp'))
					mut var_getid3_apetag := create_getid3_apetag(var_getid3_temp)
					rt.set_property(var_getid3_apetag, 'overrideendoffset',
						var_info.array_get(rt.new_string('lyrics3')).array_get(rt.new_string('tag_offset_start')))
					var_getid3_apetag.analyze()
					if !(!rt.is_true(rt.get_property(var_getid3_temp, 'info').array_get(rt.new_string('ape')))) {
						var_info['ape'] =
							rt.get_property(var_getid3_temp, 'info').array_get(rt.new_string('ape'))
					}
					if !(!rt.is_true(rt.get_property(var_getid3_temp, 'info').array_get(rt.new_string('replay_gain')))) {
						var_info['replay_gain'] =
							rt.get_property(var_getid3_temp, 'info').array_get(rt.new_string('replay_gain'))
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
	var_info = rt.get_property(rt.get_property(rt.new_object('getid3_lyrics3', [
		'getid3_handler',
	], &this), 'getid3'), 'info')
	mut iife_temp_2 := Class_getid3_lib{}
	mut iife_result_2 := iife_temp_2.intvaluesupported(var_endoffset.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
		this.warning(rt.new_string('Unable to check for Lyrics3 because file is larger than ' +
			(rt.call_function('round', [rt.div(rt.get_constant('PHP_INT_MAX'), rt.new_int(1073741824))])).str() +
			'GB'))
		return false
	}
	this.fseek(var_endoffset.clone())
	if rt.is_true(rt.less_equal(var_length_mutated, rt.new_int(0))) {
		return false
	}
	mut var_rawdata := this.fread(var_length_mutated.clone())
	mut var_ParsedLyrics3 := map[string]rt.PhpVal{}
	var_ParsedLyrics3.array_get_mut('raw').array_set('lyrics3version', var_version.clone())
	var_ParsedLyrics3.array_get_mut('raw').array_set('lyrics3tagsize', var_length_mutated.clone())
	var_ParsedLyrics3['tag_offset_start'] = var_endoffset.clone()
	var_ParsedLyrics3['tag_offset_end'] = rt.sub(rt.add(var_endoffset, var_length_mutated),
		rt.new_int(1))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('substr', [
		var_rawdata.clone(),
		rt.new_int(0),
		rt.new_int(11),
	]), rt.new_string('LYRICSBEGIN')))))
	{
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
			var_rawdata.clone(),
			rt.new_string('LYRICSBEGIN'),
		]), rt.new_bool(false)))))
		{
			this.warning(rt.new_string('"LYRICSBEGIN" expected at ' + var_endoffset.str() +
				' but actually found at ' +
				(rt.add(var_endoffset, rt.call_function('strpos', [var_rawdata.clone(), rt.new_string('LYRICSBEGIN')]))).str() +
				' - this is invalid for Lyrics3 v' + var_version.str()))
			var_info['avdataend'] = rt.add(var_endoffset, rt.call_function('strpos', [
				var_rawdata.clone(),
				rt.new_string('LYRICSBEGIN'),
			]))
			var_rawdata = rt.call_function('substr', [var_rawdata.clone(),
				rt.call_function('strpos', [var_rawdata.clone(),
					rt.new_string('LYRICSBEGIN')])])
			var_length_mutated = rt.new_int(var_rawdata.clone().to_string().len)
			var_ParsedLyrics3['tag_offset_start'] = var_info.array_get(rt.new_string('avdataend'))
			var_ParsedLyrics3.array_get_mut('raw').array_set('lyrics3tagsize',
				var_length_mutated.clone())
		} else {
			this.error(rt.new_string('"LYRICSBEGIN" expected at ' + var_endoffset.str() +
				' but found "' +
				(rt.call_function('substr', [var_rawdata.clone(), rt.new_int(0), rt.new_int(11)])).str() +
				'" instead'))
			return false
		}
	}
	mut switch_val_1 := var_version
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		if rt.is_true(rt.equal(rt.call_function('substr', [var_rawdata.clone(),
			rt.new_int(var_rawdata.clone().to_string().len - 9),
			rt.new_int(9)]), rt.new_string('LYRICSEND')))
		{
			var_ParsedLyrics3.array_get_mut('raw').array_set('LYR', rt.call_function('substr', [
				var_rawdata.clone(),
				rt.new_int(11),
				rt.new_int(var_rawdata.clone().to_string().len - 11 - 9),
			]).to_string().trim_space())
			this.lyrics3lyricstimestampparse(var_ParsedLyrics3.clone())
		} else {
			this.error(rt.new_string('"LYRICSEND" expected at ' +
				(rt.sub(rt.add(rt.sub(this.ftell(), rt.new_int(11)), var_length_mutated), rt.new_int(9))).str() +
				' but found "' +
				(rt.call_function('substr', [var_rawdata.clone(), rt.new_int(var_rawdata.clone().to_string().len - 9), rt.new_int(9)])).str() +
				'" instead'))
			return false
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
		if rt.is_true(rt.equal(rt.call_function('substr', [var_rawdata.clone(),
			rt.new_int(var_rawdata.clone().to_string().len - 9),
			rt.new_int(9)]), rt.new_string('LYRICS200')))
		{
			var_ParsedLyrics3.array_get_mut('raw').array_set('unparsed', rt.call_function('substr', [
				var_rawdata.clone(),
				rt.new_int(11),
				rt.new_int(var_rawdata.clone().to_string().len - 11 - 9 - 6),
			]))
			var_rawdata = var_ParsedLyrics3['raw'].array_get(rt.new_string('unparsed'))
			for var_rawdata.clone().to_string().len > 0 {
				mut var_fieldname := rt.call_function('substr', [
					var_rawdata.clone(), rt.new_int(0), rt.new_int(3)])
				mut var_fieldsize := rt.new_int((rt.call_function('substr', [
					var_rawdata.clone(), rt.new_int(3), rt.new_int(5)])).to_i64())
				var_ParsedLyrics3.array_get_mut('raw').array_set(var_fieldname, rt.call_function('substr', [
					var_rawdata.clone(),
					rt.new_int(8),
					var_fieldsize.clone(),
				]))
				var_rawdata = rt.call_function('substr', [var_rawdata.clone(),
					rt.add(3 + 5, var_fieldsize)])
			}
			if var_ParsedLyrics3['raw'].array_isset(rt.new_string('IND')) {
				mut var_i := rt.new_int(0)
				mut var_flagnames := rt.create_array([
					rt.ArrayItem{ key: none, val: 'lyrics' },
					rt.ArrayItem{ key: none, val: 'timestamps' },
					rt.ArrayItem{ key: none, val: 'inhibitrandom' },
				])
				mut iter_1 := var_flagnames.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_flagname := item_1.val
					if rt.is_true(rt.greater(rt.new_int(var_ParsedLyrics3['raw'].array_get(rt.new_string('IND')).to_string().len),
						rt.post_inc(var_i)))
					{
						var_ParsedLyrics3.array_get_mut('flags').array_set(var_flagname, this.intstring2bool(rt.call_function('substr', [
							var_ParsedLyrics3['raw'].array_get(rt.new_string('IND')),
							var_i.clone(),
							rt.new_int(1 - 1),
						])))
					}
				}
			}
			mut var_fieldnametranslation := rt.create_array([
				rt.ArrayItem{ key: 'ETT', val: 'title' },
				rt.ArrayItem{ key: 'EAR', val: 'artist' },
				rt.ArrayItem{ key: 'EAL', val: 'album' },
				rt.ArrayItem{ key: 'INF', val: 'comment' },
				rt.ArrayItem{ key: 'AUT', val: 'author' },
			])
			mut iter_2 := var_fieldnametranslation.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_value := item_2.val
				mut var_key := item_2.key
				if var_ParsedLyrics3['raw'].array_isset(var_key) {
					var_ParsedLyrics3.array_get_mut('comments').array_get_mut(var_value).array_push(var_ParsedLyrics3['raw'].array_get(var_key).to_string().trim_space())
				}
			}
			if var_ParsedLyrics3['raw'].array_isset(rt.new_string('IMG')) {
				mut var_imagestrings := rt.call_function('explode', [
					rt.new_string('\r\n'),
					var_ParsedLyrics3['raw'].array_get(rt.new_string('IMG')),
				])
				mut iter_3 := var_imagestrings.iterator()
				for {
					item_3 := iter_3.next() or { break }
					mut var_imagestring := item_3.val
					mut var_key := item_3.key
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
						var_imagestring.clone(),
						rt.new_string('||'),
					]), rt.new_bool(false)))))
					{
						mut var_imagearray := rt.call_function('explode', [
							rt.new_string('||'),
							var_imagestring.clone(),
						])
						var_ParsedLyrics3.array_get_mut('images').array_get_mut(var_key).array_set('filename',
							var_imagearray.array_get(rt.new_int(0)))
						var_ParsedLyrics3.array_get_mut('images').array_get_mut(var_key).array_set('description', if var_imagearray.array_isset(rt.new_int(1)) {
							var_imagearray.array_get(rt.new_int(1))
						} else {
							rt.new_string('')
						})
						var_ParsedLyrics3.array_get_mut('images').array_get_mut(var_key).array_set('timestamp', this.lyrics3timestamp2seconds(if var_imagearray.array_isset(rt.new_int(2)) {
							var_imagearray.array_get(rt.new_int(2))
						} else {
							rt.new_string('')
						}))
					}
				}
			}
			if var_ParsedLyrics3['raw'].array_isset(rt.new_string('LYR')) {
				this.lyrics3lyricstimestampparse(var_ParsedLyrics3.clone())
			}
		} else {
			this.error(rt.new_string('"LYRICS200" expected at ' +
				(rt.sub(rt.add(rt.sub(this.ftell(), rt.new_int(11)), var_length_mutated), rt.new_int(9))).str() +
				' but found "' +
				(rt.call_function('substr', [var_rawdata.clone(), rt.new_int(var_rawdata.clone().to_string().len - 9), rt.new_int(9)])).str() +
				'" instead'))
			return false
		}
	} else {
		this.error(rt.new_string('Cannot process Lyrics3 version ' + var_version.str() +
			' (only v1 and v2)'))
		return false
	}
	if var_info.array_get(rt.new_string('id3v1')).array_isset(rt.new_string('tag_offset_start'))
		&& rt.is_true(rt.less_equal(var_info.array_get(rt.new_string('id3v1')).array_get(rt.new_string('tag_offset_start')), var_ParsedLyrics3['tag_offset_end'])) {
		this.warning(rt.new_string('ID3v1 tag information ignored since it appears to be a false synch in Lyrics3 tag data'))
		var_info.delete('id3v1')
		mut iter_4 := var_info.array_get(rt.new_string('warning')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_value := item_4.val
			mut var_key := item_4.key
			if rt.is_true(rt.equal(var_value,
				rt.new_string('Some ID3v1 fields do not use NULL characters for padding')))
			{
				var_info.array_get(rt.new_string('warning')).array_unset(var_key)
				rt.call_function('sort', [var_info.array_get(rt.new_string('warning'))])
				break
			}
		}
	}
	var_info['lyrics3'] = var_ParsedLyrics3.clone()
	return true
}

fn (mut this Class_getid3_lyrics3) lyrics3timestamp2seconds(var_rawtimestamp rt.PhpVal) rt.PhpVal {
	mut var_regs := []rt.PhpVal{}
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('#^\\[([0-9]{2}):([0-9]{2})\\]$#'),
		var_rawtimestamp.clone(),
		rt.create_array_from_list(var_regs),
	]))
	{
		return rt.new_int((var_regs.array_get(rt.new_int(1))).to_i64()) * 60 +
			rt.new_int((var_regs.array_get(rt.new_int(2))).to_i64())
	}
	return rt.new_bool(false)
}

fn (mut this Class_getid3_lyrics3) lyrics3lyricstimestampparse(var_Lyrics3data rt.PhpVal) bool {
	mut var_lyricsarray := rt.call_function('explode', [rt.new_string('\r\n'),
		var_Lyrics3data.array_get(rt.new_string('raw')).array_get(rt.new_string('LYR'))])
	mut var_notimestamplyricsarray := map[string]rt.PhpVal{}
	mut iter_5 := var_lyricsarray.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_lyricline := item_5.val
		mut var_key := item_5.key
		mut var_regs := map[string]rt.PhpVal{}
		mut var_thislinetimestamps := map[string]rt.PhpVal{}
		for rt.is_true(rt.call_function('preg_match', [
			rt.new_string('#^(\\[[0-9]{2}:[0-9]{2}\\])#'),
			var_lyricline.clone(),
			rt.create_array_from_list(var_regs),
		])) {
			var_thislinetimestamps << this.lyrics3timestamp2seconds(var_regs[0])
			var_lyricline = rt.call_function('str_replace', [var_regs[0], rt.new_string(''),
				var_lyricline.clone()])
		}
		var_notimestamplyricsarray.array_set(var_key, var_lyricline.clone())
		if var_thislinetimestamps.len > 0 {
			rt.call_function('sort', [rt.create_array_from_list(var_thislinetimestamps)])
			for var_timestampkey, var_timestamp in var_thislinetimestamps {
				if var_Lyrics3data.array_get(rt.new_string('comments')).array_get(rt.new_string('synchedlyrics')).array_isset(var_timestamp) {
					var_Lyrics3data.array_get(rt.new_string('comments')).array_get(rt.new_string('synchedlyrics')).array_get(var_timestamp) = rt.concat(var_Lyrics3data.array_get(rt.new_string('comments')).array_get(rt.new_string('synchedlyrics')).array_get(var_timestamp), rt.new_string(
						'\r\n' + var_lyricline.str()))
				} else {
					var_Lyrics3data.array_get_mut('comments').array_get_mut('synchedlyrics').array_set(var_timestamp,
						var_lyricline.clone())
				}
			}
		}
	}
	var_Lyrics3data.array_get_mut('comments').array_get_mut('unsynchedlyrics').array_set(0, rt.call_function('implode', [
		rt.new_string('\r\n'),
		var_notimestamplyricsarray.clone(),
	]))
	if var_Lyrics3data.array_get(rt.new_string('comments')).array_isset(rt.new_string('synchedlyrics'))
		&& var_Lyrics3data.array_get(rt.new_string('comments')).array_get(rt.new_string('synchedlyrics')).is_array() {
		rt.call_function('ksort',
			[var_Lyrics3data.array_get(rt.new_string('comments')).array_get(rt.new_string('synchedlyrics'))])
	}
	return true
}

fn (mut this Class_getid3_lyrics3) intstring2bool(var_char rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.equal(var_char, rt.new_string('1'))) {
		return rt.new_bool(true)
	} else if rt.is_true(rt.equal(var_char, rt.new_string('0'))) {
		return rt.new_bool(false)
	}
	return rt.new_null()
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

fn create_getid3_lyrics3(_args ...rt.PhpVal) &Class_getid3_lyrics3 {
	mut obj := &Class_getid3_lyrics3{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_getid3_handler(_args ...rt.PhpVal) &Class_getid3_handler {
	mut obj := &Class_getid3_handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_getid3_lib(_args ...rt.PhpVal) &Class_getid3_lib {
	mut obj := &Class_getid3_lib{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_getid3(_args ...rt.PhpVal) &Class_getID3 {
	mut obj := &Class_getID3{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_getid3_apetag(_args ...rt.PhpVal) &Class_getid3_apetag {
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
			return this.lyrics3timestamp2seconds(dispatch_arg_0)
		}
		'Lyrics3LyricsTimestampParse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.lyrics3lyricstimestampparse(dispatch_arg_0))
		}
		'IntString2Bool' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.intstring2bool(dispatch_arg_0)
		}
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('GETID3_INCLUDEPATH'),
	])))))
	{
		exit(0)
	}
}

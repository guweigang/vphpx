import rt
import crypto.md5

struct Class_getid3_apetag {
	rt.PhpObjectBase
pub mut:
		inline_attachments rt.PhpVal = rt.new_bool(true)
		overrideendoffset rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_getid3_apetag) analyze() bool {
	mut var_info := map[string]rt.PhpVal{}
	mut var_thisfile_ape := map[string]rt.PhpVal{}
	mut var_thisfile_replaygain := rt.new_null()
	mut var_thisfile_ape_items_current := map[string]rt.PhpVal{}
	mut var_matches := rt.new_null()
	mut var_mp3gain_undo_left := rt.new_null()
	mut var_mp3gain_undo_right := rt.new_null()
	mut var_mp3gain_undo_wrap := rt.new_null()
	mut var_mp3gain_globalgain_min := rt.new_null()
	mut var_mp3gain_globalgain_max := rt.new_null()
	mut var_mp3gain_globalgain_album_min := rt.new_null()
	mut var_mp3gain_globalgain_album_max := rt.new_null()
	var_info = rt.get_property(rt.get_property(rt.new_object('getid3_apetag', ['getid3_handler'], &this), 'getid3'), 'info')
	mut iife_temp_0 := Class_getid3_lib{}
	mut iife_result_0 := iife_temp_0.intvaluesupported(var_info.array_get(rt.new_string('filesize')))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		this.warning(rt.new_string('Unable to check for APEtags because file is larger than ' + (rt.call_function('round', [rt.div(rt.get_constant('PHP_INT_MAX'), rt.new_int(1073741824))])).str() + 'GB'))
		return false
	}
	if rt.is_true(rt.equal(rt.get_constant('PHP_INT_MAX'), rt.new_int(2147483647))) {
		this.warning(rt.new_string('APEtag flags may not be parsed correctly on 32-bit PHP'))
	}
	mut var_id3v1tagsize := rt.new_int(128)
	mut var_apetagheadersize := rt.new_int(32)
	mut var_lyrics3tagsize := rt.new_int(10)
	if rt.is_true(rt.equal(this.overrideendoffset, rt.new_int(0))) {
		this.fseek(rt.sub(rt.sub(rt.sub(rt.new_int(0), var_id3v1tagsize), var_apetagheadersize), var_lyrics3tagsize), rt.get_constant('SEEK_END'))
		mut var_APEfooterID3v1 := this.fread(rt.add(rt.add(var_id3v1tagsize, var_apetagheadersize), var_lyrics3tagsize))
		if rt.is_true(rt.equal(rt.call_function('substr', [var_APEfooterID3v1.clone(), rt.sub(rt.sub(rt.new_int(var_APEfooterID3v1.clone().to_string().len), var_id3v1tagsize), var_apetagheadersize), rt.new_int(8)]), rt.new_string('APETAGEX'))) {
			var_info.array_get_mut('ape').array_set('tag_offset_end', rt.sub(var_info.array_get(rt.new_string('filesize')), var_id3v1tagsize))
		} else if rt.is_true(rt.equal(rt.call_function('substr', [var_APEfooterID3v1.clone(), rt.sub(rt.new_int(var_APEfooterID3v1.clone().to_string().len), var_apetagheadersize), rt.new_int(8)]), rt.new_string('APETAGEX'))) {
			var_info.array_get_mut('ape').array_set('tag_offset_end', var_info.array_get(rt.new_string('filesize')))
		}
	} else {
		this.fseek(rt.sub(this.overrideendoffset, var_apetagheadersize))
		if rt.is_true(rt.equal(this.fread(rt.new_int(8)), rt.new_string('APETAGEX'))) {
			var_info.array_get_mut('ape').array_set('tag_offset_end', this.overrideendoffset)
		}
	}
	if !(var_info.array_get(rt.new_string('ape')).array_isset(rt.new_string('tag_offset_end'))) {
		var_info.delete('ape')
		return false
	}
	var_thisfile_ape = var_info.array_get(rt.new_string('ape'))
	this.fseek(rt.sub(var_thisfile_ape.array_get(rt.new_string('tag_offset_end')), var_apetagheadersize))
	mut var_APEfooterData := this.fread(rt.new_int(32))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_thisfile_ape['footer'] = this.parseapeheaderfooter(var_APEfooterData.clone()))))) {
		this.error(rt.new_string('Error parsing APE footer at offset ' + (var_thisfile_ape.array_get(rt.new_string('tag_offset_end'))).str()))
		return false
	}
	if var_thisfile_ape.array_get(rt.new_string('footer')).array_get(rt.new_string('flags')).array_isset(rt.new_string('header')) && rt.is_true(var_thisfile_ape.array_get(rt.new_string('footer')).array_get(rt.new_string('flags')).array_get(rt.new_string('header'))) {
		this.fseek(rt.sub(rt.sub(var_thisfile_ape.array_get(rt.new_string('tag_offset_end')), var_thisfile_ape.array_get(rt.new_string('footer')).array_get(rt.new_string('raw')).array_get(rt.new_string('tagsize'))), var_apetagheadersize))
		var_thisfile_ape['tag_offset_start'] = this.ftell()
	mut var_APEtagData := this.fread(rt.add(var_thisfile_ape.array_get(rt.new_string('footer')).array_get(rt.new_string('raw')).array_get(rt.new_string('tagsize')), var_apetagheadersize))
	} else {
		var_thisfile_ape['tag_offset_start'] = rt.sub(var_thisfile_ape.array_get(rt.new_string('tag_offset_end')), var_thisfile_ape.array_get(rt.new_string('footer')).array_get(rt.new_string('raw')).array_get(rt.new_string('tagsize')))
		this.fseek(var_thisfile_ape.array_get(rt.new_string('tag_offset_start')))
	var_APEtagData = this.fread(var_thisfile_ape.array_get(rt.new_string('footer')).array_get(rt.new_string('raw')).array_get(rt.new_string('tagsize')))
	}
	var_info['avdataend'] = var_thisfile_ape.array_get(rt.new_string('tag_offset_start'))
	if var_info.array_get(rt.new_string('id3v1')).array_isset(rt.new_string('tag_offset_start')) && rt.is_true(rt.less(var_info.array_get(rt.new_string('id3v1')).array_get(rt.new_string('tag_offset_start')), var_thisfile_ape.array_get(rt.new_string('tag_offset_end')))) {
		this.warning(rt.new_string('ID3v1 tag information ignored since it appears to be a false synch in APEtag data'))
		var_info.delete('id3v1')
		mut iter_1 := var_info.array_get(rt.new_string('warning')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.equal(var_value, rt.new_string('Some ID3v1 fields do not use NULL characters for padding'))) {
				var_info.array_get(rt.new_string('warning')).array_unset(var_key)
				rt.call_function('sort', [var_info.array_get(rt.new_string('warning'))])
				break
			}
		}
	}
	mut var_offset := rt.new_int(0)
	if var_thisfile_ape.array_get(rt.new_string('footer')).array_get(rt.new_string('flags')).array_isset(rt.new_string('header')) && rt.is_true(var_thisfile_ape.array_get(rt.new_string('footer')).array_get(rt.new_string('flags')).array_get(rt.new_string('header'))) {
		if rt.is_true(var_thisfile_ape['header'] = this.parseapeheaderfooter(rt.call_function('substr', [var_APEtagData.clone(), rt.new_int(0), var_apetagheadersize.clone()]))) {
			var_offset = rt.add(var_offset, var_apetagheadersize)
		} else {
			this.error(rt.new_string('Error parsing APE header at offset ' + (var_thisfile_ape.array_get(rt.new_string('tag_offset_start'))).str()))
			return false
		}
	}
	var_info['replay_gain'] = rt.new_array()
	var_thisfile_replaygain = var_info.array_get(rt.new_string('replay_gain'))
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_thisfile_ape.array_get(rt.new_string('footer')).array_get(rt.new_string('raw')).array_get(rt.new_string('tag_items'))))) { break }
		mut iife_temp_1 := Class_getid3_lib{}
		mut iife_result_1 := iife_temp_1.littleendian2int(rt.call_function('substr', [var_APEtagData.clone(), var_offset.clone(), rt.new_int(4)]))
		mut var_value_size := iife_result_1
		var_offset = rt.add(var_offset, rt.new_int(4))
		mut iife_temp_2 := Class_getid3_lib{}
		mut iife_result_2 := iife_temp_2.littleendian2int(rt.call_function('substr', [var_APEtagData.clone(), var_offset.clone(), rt.new_int(4)]))
		mut var_item_flags := iife_result_2
		var_offset = rt.add(var_offset, rt.new_int(4))
		if rt.is_true(rt.identical(rt.call_function('strstr', [rt.call_function('substr', [var_APEtagData.clone(), var_offset.clone()]), rt.new_string('')]), rt.new_bool(false))) {
			this.error(rt.new_string('Cannot find null-byte (0x00) separator between ItemKey #' + (var_i).str() + ' and value. ItemKey starts ' + (var_offset).str() + ' bytes into the APE tag, at file offset ' + (rt.add(var_thisfile_ape.array_get(rt.new_string('tag_offset_start')), var_offset)).str()))
			return false
		}
		mut var_ItemKeyLength := rt.sub(rt.call_function('strpos', [var_APEtagData.clone(), rt.new_string(''), var_offset.clone()]), var_offset)
		mut var_item_key := rt.new_string(rt.call_function('substr', [var_APEtagData.clone(), var_offset.clone(), var_ItemKeyLength.clone()]).to_string().to_lower())
		var_thisfile_ape.array_get_mut('items').array_set(var_item_key, rt.new_array())
		var_thisfile_ape_items_current = var_thisfile_ape.array_get(rt.new_string('items')).array_get(var_item_key)
		var_thisfile_ape_items_current['offset'] = rt.add(var_thisfile_ape.array_get(rt.new_string('tag_offset_start')), var_offset)
		var_offset = rt.add(var_offset, rt.add(var_ItemKeyLength, rt.new_int(1)))
		var_thisfile_ape_items_current['data'] = rt.call_function('substr', [var_APEtagData.clone(), var_offset.clone(), var_value_size.clone()])
		var_offset = rt.add(var_offset, var_value_size)
		var_thisfile_ape_items_current['flags'] = this.parseapetagflags(var_item_flags.clone())
		mut switch_val_1 := var_thisfile_ape_items_current.array_get(rt.new_string('flags')).array_get(rt.new_string('item_contents_raw'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
			var_thisfile_ape_items_current['data'] = rt.call_function('explode', [rt.new_string(''), var_thisfile_ape_items_current.array_get(rt.new_string('data'))])
		} else {
		}
		mut switch_val_2 := rt.new_string(var_item_key.clone().to_string().to_lower())
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('replaygain_track_gain'))) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^([\\-\\+][0-9\\.,]{8})( dB)?$#'), var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0)), var_matches.clone()])) {
				var_thisfile_replaygain.array_get_mut('track').array_set('adjustment', rt.new_float((rt.call_function('str_replace', [rt.new_string(','), rt.new_string('.'), var_matches.array_get(rt.new_int(1))])).to_f64()))
				var_thisfile_replaygain.array_get_mut('track').array_set('originator', 'unspecified')
			} else {
				this.warning(rt.new_string('MP3gainTrackGain value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))).str() + '"'))
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('replaygain_track_peak'))) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^([0-9\\.,]{8})$#'), var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0)), var_matches.clone()])) {
				var_thisfile_replaygain.array_get_mut('track').array_set('peak', rt.new_float((rt.call_function('str_replace', [rt.new_string(','), rt.new_string('.'), var_matches.array_get(rt.new_int(1))])).to_f64()))
				var_thisfile_replaygain.array_get_mut('track').array_set('originator', 'unspecified')
				if rt.is_true(rt.less_equal(var_thisfile_replaygain.array_get(rt.new_string('track')).array_get(rt.new_string('peak')), rt.new_int(0))) {
					this.warning(rt.new_string('ReplayGain Track peak from APEtag appears invalid: ' + (var_thisfile_replaygain.array_get(rt.new_string('track')).array_get(rt.new_string('peak'))).str() + ' (original value = "' + (var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))).str() + '")'))
				}
			} else {
				this.warning(rt.new_string('MP3gainTrackPeak value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))).str() + '"'))
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('replaygain_album_gain'))) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^([\\-\\+][0-9\\.,]{8})( dB)?$#'), var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0)), var_matches.clone()])) {
				var_thisfile_replaygain.array_get_mut('album').array_set('adjustment', rt.new_float((rt.call_function('str_replace', [rt.new_string(','), rt.new_string('.'), var_matches.array_get(rt.new_int(1))])).to_f64()))
				var_thisfile_replaygain.array_get_mut('album').array_set('originator', 'unspecified')
			} else {
				this.warning(rt.new_string('MP3gainAlbumGain value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))).str() + '"'))
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('replaygain_album_peak'))) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^([0-9\\.,]{8})$#'), var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0)), var_matches.clone()])) {
				var_thisfile_replaygain.array_get_mut('album').array_set('peak', rt.new_float((rt.call_function('str_replace', [rt.new_string(','), rt.new_string('.'), var_matches.array_get(rt.new_int(1))])).to_f64()))
				var_thisfile_replaygain.array_get_mut('album').array_set('originator', 'unspecified')
				if rt.is_true(rt.less_equal(var_thisfile_replaygain.array_get(rt.new_string('album')).array_get(rt.new_string('peak')), rt.new_int(0))) {
					this.warning(rt.new_string('ReplayGain Album peak from APEtag appears invalid: ' + (var_thisfile_replaygain.array_get(rt.new_string('album')).array_get(rt.new_string('peak'))).str() + ' (original value = "' + (var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))).str() + '")'))
				}
			} else {
				this.warning(rt.new_string('MP3gainAlbumPeak value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))).str() + '"'))
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mp3gain_undo'))) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^[\\-\\+][0-9]{3},[\\-\\+][0-9]{3},[NW]$#'), var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))])) {
				mut list_tmp_1 := rt.call_function('explode', [rt.new_string(','), var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))])
				var_mp3gain_undo_left = (list_tmp_1).array_get(0)
				var_mp3gain_undo_right = (list_tmp_1).array_get(1)
				var_mp3gain_undo_wrap = (list_tmp_1).array_get(2)
				var_thisfile_replaygain.array_get_mut('mp3gain').array_set('undo_left', var_mp3gain_undo_left.clone().to_i64())
				var_thisfile_replaygain.array_get_mut('mp3gain').array_set('undo_right', var_mp3gain_undo_right.clone().to_i64())
				var_thisfile_replaygain.array_get_mut('mp3gain').array_set('undo_wrap', if rt.is_true(rt.equal(var_mp3gain_undo_wrap, rt.new_string('Y'))) { true } else { false })
			} else {
				this.warning(rt.new_string('MP3gainUndo value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))).str() + '"'))
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mp3gain_minmax'))) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^[0-9]{3},[0-9]{3}$#'), var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))])) {
				mut list_tmp_2 := rt.call_function('explode', [rt.new_string(','), var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))])
				var_mp3gain_globalgain_min = (list_tmp_2).array_get(0)
				var_mp3gain_globalgain_max = (list_tmp_2).array_get(1)
				var_thisfile_replaygain.array_get_mut('mp3gain').array_set('globalgain_track_min', var_mp3gain_globalgain_min.clone().to_i64())
				var_thisfile_replaygain.array_get_mut('mp3gain').array_set('globalgain_track_max', var_mp3gain_globalgain_max.clone().to_i64())
			} else {
				this.warning(rt.new_string('MP3gainMinMax value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))).str() + '"'))
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mp3gain_album_minmax'))) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^[0-9]{3},[0-9]{3}$#'), var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))])) {
				mut list_tmp_3 := rt.call_function('explode', [rt.new_string(','), var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))])
				var_mp3gain_globalgain_album_min = (list_tmp_3).array_get(0)
				var_mp3gain_globalgain_album_max = (list_tmp_3).array_get(1)
				var_thisfile_replaygain.array_get_mut('mp3gain').array_set('globalgain_album_min', var_mp3gain_globalgain_album_min.clone().to_i64())
				var_thisfile_replaygain.array_get_mut('mp3gain').array_set('globalgain_album_max', var_mp3gain_globalgain_album_max.clone().to_i64())
			} else {
				this.warning(rt.new_string('MP3gainAlbumMinMax value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get(rt.new_string('data')).array_get(rt.new_int(0))).str() + '"'))
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('tracknumber'))) {
			if rt.is_true(rt.new_bool(var_thisfile_ape_items_current.array_get(rt.new_string('data')).is_array())) {
				mut iter_2 := var_thisfile_ape_items_current.array_get(rt.new_string('data')).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_comment := item_2.val
					var_thisfile_ape.array_get_mut('comments').array_get_mut('track_number').array_push(var_comment.clone())
				}
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (artist)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (back)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (band logo)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (band)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (colored fish)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (composer)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (conductor)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (front)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (icon)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (illustration)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (lead)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (leaflet)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (lyricist)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (media)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (movie scene)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (other icon)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (other)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (performance)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (publisher logo)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (recording)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (studio)'))) {
			if rt.is_true(rt.new_bool(var_thisfile_ape_items_current.array_get(rt.new_string('data')).is_array())) {
				this.warning(rt.new_string('APEtag "' + (var_item_key).str() + '" should be flagged as Binary data, but was incorrectly flagged as UTF-8'))
				var_thisfile_ape_items_current['data'] = rt.call_function('implode', [rt.new_string(''), var_thisfile_ape_items_current.array_get(rt.new_string('data'))])
			}
			mut list_tmp_4 := rt.call_function('explode', [rt.new_string(''), var_thisfile_ape_items_current.array_get(rt.new_string('data')), rt.new_int(2)])
			var_thisfile_ape_items_current.array_get_mut('filename') = (list_tmp_4).array_get(0)
			var_thisfile_ape_items_current.array_get_mut('data') = (list_tmp_4).array_get(1)
			var_thisfile_ape_items_current['data_offset'] = rt.add(var_thisfile_ape_items_current.array_get(rt.new_string('offset')), rt.new_int((var_thisfile_ape_items_current.array_get(rt.new_string('filename'))).str() + ''.len))
			var_thisfile_ape_items_current['data_length'] = rt.new_int(var_thisfile_ape_items_current.array_get(rt.new_string('data')).to_string().len)
			for {
				var_thisfile_ape_items_current['image_mime'] = rt.new_string('')
				mut var_imageinfo := rt.new_array()
				mut iife_temp_3 := Class_getid3_lib{}
				mut iife_result_3 := iife_temp_3.getdataimagesize(var_thisfile_ape_items_current.array_get(rt.new_string('data')), var_imageinfo.clone())
				mut var_imagechunkcheck := iife_result_3
				if rt.is_true(rt.identical(var_imagechunkcheck, rt.new_bool(false))) || !(var_imagechunkcheck.array_isset(rt.new_int(2))) {
					this.warning(rt.new_string('APEtag "' + (var_item_key).str() + '" contains invalid image data'))
				}
				var_thisfile_ape_items_current['image_mime'] = rt.call_function('image_type_to_mime_type', [var_imagechunkcheck.array_get(rt.new_int(2))])
				if rt.is_true(rt.identical(this.inline_attachments, rt.new_bool(false))) {
					var_thisfile_ape_items_current.delete('data')
				}
				if rt.is_true(rt.identical(this.inline_attachments, rt.new_bool(true))) {
				} else if rt.is_true(rt.new_bool(this.inline_attachments.is_long())) {
					if rt.is_true(rt.less(this.inline_attachments, var_thisfile_ape_items_current.array_get(rt.new_string('data_length')))) {
						this.warning(rt.new_string('attachment at ' + (var_thisfile_ape_items_current.array_get(rt.new_string('offset'))).str() + ' is too large to process inline (' + (rt.call_function('number_format', [var_thisfile_ape_items_current.array_get(rt.new_string('data_length'))])).str() + ' bytes)'))
						var_thisfile_ape_items_current.delete('data')
					}
				} else if rt.is_true(rt.new_bool(this.inline_attachments.is_string())) {
					this.inline_attachments = rt.new_string(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '/' }, rt.ArrayItem{ key: none, val: '\\' }]), rt.get_constant('DIRECTORY_SEPARATOR'), this.inline_attachments]).to_string().trim_right(' \t\n\r'))
					mut iife_temp_4 := Class_getID3{}
					mut iife_result_4 := iife_temp_4.is_writable(this.inline_attachments)
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [this.inline_attachments]))))) || rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4)))) {
						this.warning(rt.new_string('attachment at ' + (var_thisfile_ape_items_current.array_get(rt.new_string('offset'))).str() + ' cannot be saved to "' + (this.inline_attachments).str() + '" (not writable)'))
						var_thisfile_ape_items_current.delete('data')
					}
				}
				if rt.is_true(rt.new_bool(this.inline_attachments.is_string())) {
					mut var_destination_filename := rt.new_string((this.inline_attachments).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + md5.hexhash(var_info.array_get(rt.new_string('filenamepath')).to_string()) + '_' + (var_thisfile_ape_items_current.array_get(rt.new_string('data_offset'))).str())
					mut iife_temp_5 := Class_getID3{}
					mut iife_result_5 := iife_temp_5.is_writable(var_destination_filename.clone())
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_destination_filename.clone()]))))) || rt.is_true(iife_result_5) {
						rt.call_function('file_put_contents', [var_destination_filename.clone(), var_thisfile_ape_items_current.array_get(rt.new_string('data'))])
					} else {
						this.warning(rt.new_string('attachment at ' + (var_thisfile_ape_items_current.array_get(rt.new_string('offset'))).str() + ' cannot be saved to "' + (var_destination_filename).str() + '" (not writable)'))
					}
					var_thisfile_ape_items_current['data_filename'] = var_destination_filename.clone()
					var_thisfile_ape_items_current.delete('data')
				} else {
					if !(var_info.array_get(rt.new_string('ape')).array_get(rt.new_string('comments')).array_isset(rt.new_string('picture'))) {
						var_info.array_get_mut('ape').array_get_mut('comments').array_set('picture', rt.new_array())
					}
					mut var_comments_picture_data := rt.new_array()
					mut iter_3 := rt.create_array([rt.ArrayItem{ key: none, val: 'data' }, rt.ArrayItem{ key: none, val: 'image_mime' }, rt.ArrayItem{ key: none, val: 'image_width' }, rt.ArrayItem{ key: none, val: 'image_height' }, rt.ArrayItem{ key: none, val: 'imagetype' }, rt.ArrayItem{ key: none, val: 'picturetype' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'datalength' }]).iterator()
					for {
						item_3 := iter_3.next() or { break }
						mut var_picture_key := item_3.val
						if var_thisfile_ape_items_current.array_isset(var_picture_key) {
							var_comments_picture_data.array_set(var_picture_key, var_thisfile_ape_items_current.array_get(var_picture_key))
						}
					}
					var_info.array_get_mut('ape').array_get_mut('comments').array_get_mut('picture').array_push(var_comments_picture_data.clone())
					var_comments_picture_data = rt.new_null()
				}
				if !(false) {
					break
				}
			}
		} else {
			if rt.is_true(rt.new_bool(var_thisfile_ape_items_current.array_get(rt.new_string('data')).is_array())) {
				mut iter_4 := var_thisfile_ape_items_current.array_get(rt.new_string('data')).iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_comment := item_4.val
					var_thisfile_ape.array_get_mut('comments').array_get_mut(var_item_key.clone().to_string().to_lower()).array_push(var_comment.clone())
				}
			}
		}
		rt.post_inc(var_i)
	}
	if !rt.is_true(var_thisfile_replaygain) {
		var_info.delete('replay_gain')
	}
	return true
}

fn (mut this Class_getid3_apetag) parseapeheaderfooter(var_APEheaderFooterData rt.PhpVal) rt.PhpVal {
	mut var_headerfooterinfo_raw := map[string]rt.PhpVal{}
	mut var_headerfooterinfo := rt.new_array()
	var_headerfooterinfo['raw'] = rt.new_array()
	var_headerfooterinfo_raw = var_headerfooterinfo['raw']
	var_headerfooterinfo_raw['footer_tag'] = rt.call_function('substr', [var_APEheaderFooterData.clone(), rt.new_int(0), rt.new_int(8)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_headerfooterinfo_raw.array_get(rt.new_string('footer_tag')), rt.new_string('APETAGEX'))))) {
		return rt.new_bool(false)
	}
	mut iife_temp_6 := Class_getid3_lib{}
	mut iife_result_6 := iife_temp_6.littleendian2int(rt.call_function('substr', [var_APEheaderFooterData.clone(), rt.new_int(8), rt.new_int(4)]))
	var_headerfooterinfo_raw['version'] = iife_result_6
	mut iife_temp_7 := Class_getid3_lib{}
	mut iife_result_7 := iife_temp_7.littleendian2int(rt.call_function('substr', [var_APEheaderFooterData.clone(), rt.new_int(12), rt.new_int(4)]))
	var_headerfooterinfo_raw['tagsize'] = iife_result_7
	mut iife_temp_8 := Class_getid3_lib{}
	mut iife_result_8 := iife_temp_8.littleendian2int(rt.call_function('substr', [var_APEheaderFooterData.clone(), rt.new_int(16), rt.new_int(4)]))
	var_headerfooterinfo_raw['tag_items'] = iife_result_8
	mut iife_temp_9 := Class_getid3_lib{}
	mut iife_result_9 := iife_temp_9.littleendian2int(rt.call_function('substr', [var_APEheaderFooterData.clone(), rt.new_int(20), rt.new_int(4)]))
	var_headerfooterinfo_raw['global_flags'] = iife_result_9
	var_headerfooterinfo_raw['reserved'] = rt.call_function('substr', [var_APEheaderFooterData.clone(), rt.new_int(24), rt.new_int(8)])
	var_headerfooterinfo['tag_version'] = rt.div(var_headerfooterinfo_raw.array_get(rt.new_string('version')), rt.new_int(1000))
	if rt.is_true(rt.greater_equal(var_headerfooterinfo['tag_version'], rt.new_int(2))) {
		var_headerfooterinfo['flags'] = this.parseapetagflags(var_headerfooterinfo_raw.array_get(rt.new_string('global_flags')))
	}
	return var_headerfooterinfo.clone()
}

fn (mut this Class_getid3_apetag) parseapetagflags(var_rawflagint rt.PhpVal) rt.PhpVal {
	mut var_flags := rt.new_array()
	var_flags['header'] = (rt.bitwise_and(var_rawflagint, rt.new_int(2147483648))).to_bool()
	var_flags['footer'] = (rt.bitwise_and(var_rawflagint, rt.new_int(1073741824))).to_bool()
	var_flags['this_is_header'] = (rt.bitwise_and(var_rawflagint, rt.new_int(536870912))).to_bool()
	var_flags['item_contents_raw'] = rt.bitwise_and(var_rawflagint, rt.new_int(6)) >> 1
	var_flags['read_only'] = (rt.bitwise_and(var_rawflagint, rt.new_int(1))).to_bool()
	var_flags['item_contents'] = this.apecontenttypeflaglookup(var_flags['item_contents_raw'])
	return var_flags.clone()
}

fn (mut this Class_getid3_apetag) apecontenttypeflaglookup(var_contenttypeid rt.PhpVal) rt.PhpVal {
	mut var_APEcontentTypeFlagLookup := rt.new_null()
	return if var_APEcontentTypeFlagLookup.array_isset(var_contenttypeid) { var_APEcontentTypeFlagLookup.array_get(var_contenttypeid) } else { rt.new_string('invalid') }
}

fn (mut this Class_getid3_apetag) apetagitemisutf8lookup(var_itemkey rt.PhpVal) rt.PhpVal {
	mut var_APEtagItemIsUTF8Lookup := rt.new_null()
	return rt.call_function('in_array', [rt.new_string(var_itemkey.clone().to_string().to_lower()), var_APEtagItemIsUTF8Lookup.clone()])
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

fn create_getid3_apetag(_args ...rt.PhpVal) &Class_getid3_apetag {
	mut obj := &Class_getid3_apetag{
		PhpObjectBase: rt.PhpObjectBase{}
		inline_attachments: rt.new_bool(true)
		overrideendoffset: rt.new_int(0)
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

fn (mut this Class_getid3_apetag) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'Analyze' {
			return rt.new_bool(this.analyze())
		}
		'parseAPEheaderFooter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parseapeheaderfooter(dispatch_arg_0)
		}
		'parseAPEtagFlags' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parseapetagflags(dispatch_arg_0)
		}
		'APEcontentTypeFlagLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.apecontenttypeflaglookup(dispatch_arg_0)
		}
		'APEtagItemIsUTF8Lookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.apetagitemisutf8lookup(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_getid3_apetag) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'inline_attachments' { return this.inline_attachments }
		'overrideendoffset' { return this.overrideendoffset }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_getid3_apetag) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'inline_attachments' { this.inline_attachments = val; return true }
		'overrideendoffset' { this.overrideendoffset = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_INCLUDEPATH')]))))) {
		exit(0)
	}
}

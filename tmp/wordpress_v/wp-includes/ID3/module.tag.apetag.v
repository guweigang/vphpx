import rt

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
	// unsupported expression: Expr_AssignRef
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.intvaluesupported(arg_0) }(var_info.array_get('filesize')))))) {
		this.warning(rt.new_string('Unable to check for APEtags because file is larger than ' + (rt.call_function('round', [rt.div(rt.get_constant('PHP_INT_MAX'), rt.new_int(1073741824))])).str() + 'GB'))
		return false
	}
	if rt.is_true(rt.equal(rt.get_constant('PHP_INT_MAX'), rt.new_int(2147483647))) {
		this.warning(rt.new_string('APEtag flags may not be parsed correctly on 32-bit PHP'))
	}
	mut var_id3v1tagsize := rt.new_int(rt.new_int(128))
	mut var_apetagheadersize := rt.new_int(rt.new_int(32))
	mut var_lyrics3tagsize := rt.new_int(rt.new_int(10))
	if rt.is_true(rt.equal(this.overrideendoffset, rt.new_int(0))) {
		this.fseek(rt.sub(rt.sub(rt.sub(rt.new_int(0), var_id3v1tagsize), var_apetagheadersize), var_lyrics3tagsize), rt.get_constant('SEEK_END'))
		mut var_APEfooterID3v1 := this.fread(rt.add(rt.add(var_id3v1tagsize, var_apetagheadersize), var_lyrics3tagsize))
		if rt.is_true(rt.equal(rt.call_function('substr', [var_APEfooterID3v1.dup(), rt.sub(rt.sub(rt.new_int(var_APEfooterID3v1.dup().to_string().len), var_id3v1tagsize), var_apetagheadersize), rt.new_int(8)]), rt.new_string('APETAGEX'))) {
			var_info.array_get_mut('ape').array_set('tag_offset_end', rt.sub(var_info.array_get('filesize'), var_id3v1tagsize))
			// unsupported statement: Stmt_Nop
		} else if rt.is_true(rt.equal(rt.call_function('substr', [var_APEfooterID3v1.dup(), rt.sub(rt.new_int(var_APEfooterID3v1.dup().to_string().len), var_apetagheadersize), rt.new_int(8)]), rt.new_string('APETAGEX'))) {
			var_info.array_get_mut('ape').array_set('tag_offset_end', var_info.array_get('filesize'))
		}
	} else {
		this.fseek(rt.sub(this.overrideendoffset, var_apetagheadersize))
		if rt.is_true(rt.equal(this.fread(rt.new_int(8)), rt.new_string('APETAGEX'))) {
			var_info.array_get_mut('ape').array_set('tag_offset_end', this.overrideendoffset)
		}
	}
	if !(var_info.array_get('ape').array_isset(rt.new_string('tag_offset_end'))) {
		var_info.delete('ape')
		return false
	}
	// unsupported expression: Expr_AssignRef
	this.fseek(rt.sub(var_thisfile_ape.array_get('tag_offset_end'), var_apetagheadersize))
	mut var_APEfooterData := this.fread(rt.new_int(32))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_thisfile_ape['footer'] = this.parseapeheaderfooter(var_APEfooterData.dup()))))) {
		this.error(rt.new_string('Error parsing APE footer at offset ' + (var_thisfile_ape.array_get('tag_offset_end')).str()))
		return false
	}
	if rt.is_true(rt.new_bool(var_thisfile_ape.array_get('footer').array_get('flags').array_isset(rt.new_string('header')) && rt.is_true(var_thisfile_ape.array_get('footer').array_get('flags').array_get('header')))) {
		this.fseek(rt.sub(rt.sub(var_thisfile_ape.array_get('tag_offset_end'), var_thisfile_ape.array_get('footer').array_get('raw').array_get('tagsize')), var_apetagheadersize))
		var_thisfile_ape['tag_offset_start'] = this.ftell()
		mut var_APEtagData := this.fread(rt.add(var_thisfile_ape.array_get('footer').array_get('raw').array_get('tagsize'), var_apetagheadersize))
	} else {
		var_thisfile_ape['tag_offset_start'] = rt.sub(var_thisfile_ape.array_get('tag_offset_end'), var_thisfile_ape.array_get('footer').array_get('raw').array_get('tagsize'))
		this.fseek(var_thisfile_ape.array_get('tag_offset_start'))
		var_APEtagData = this.fread(var_thisfile_ape.array_get('footer').array_get('raw').array_get('tagsize'))
	}
	var_info['avdataend'] = var_thisfile_ape.array_get('tag_offset_start')
	if rt.is_true(rt.new_bool(var_info.array_get('id3v1').array_isset(rt.new_string('tag_offset_start')) && rt.is_true(rt.less(var_info.array_get('id3v1').array_get('tag_offset_start'), var_thisfile_ape.array_get('tag_offset_end'))))) {
		this.warning(rt.new_string('ID3v1 tag information ignored since it appears to be a false synch in APEtag data'))
		var_info.delete('id3v1')
		{
			mut iter_1 := var_info.array_get('warning').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.equal(var_value, rt.new_string('Some ID3v1 fields do not use NULL characters for padding'))) {
					var_info.array_get('warning').array_unset(var_key)
					rt.call_function('sort', [var_info.array_get('warning')])
					break
				}
			}
		}
	}
	mut var_offset := rt.new_int(rt.new_int(0))
	if rt.is_true(rt.new_bool(var_thisfile_ape.array_get('footer').array_get('flags').array_isset(rt.new_string('header')) && rt.is_true(var_thisfile_ape.array_get('footer').array_get('flags').array_get('header')))) {
		if rt.is_true(var_thisfile_ape['header'] = this.parseapeheaderfooter(rt.call_function('substr', [var_APEtagData.dup(), rt.new_int(0), var_apetagheadersize.dup()]))) {
			// unsupported expression: Expr_AssignOp_Plus
		} else {
			this.error(rt.new_string('Error parsing APE header at offset ' + (var_thisfile_ape.array_get('tag_offset_start')).str()))
			return false
		}
	}
	var_info['replay_gain'] = rt.new_array()
	// unsupported expression: Expr_AssignRef
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_thisfile_ape.array_get('footer').array_get('raw').array_get('tag_items')))) { break }
			mut var_value_size := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_APEtagData.dup(), var_offset.dup(), rt.new_int(4)]))
			// unsupported expression: Expr_AssignOp_Plus
			mut var_item_flags := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_APEtagData.dup(), var_offset.dup(), rt.new_int(4)]))
			// unsupported expression: Expr_AssignOp_Plus
			if rt.is_true(rt.identical(rt.call_function('strstr', [rt.call_function('substr', [var_APEtagData.dup(), var_offset.dup()]), rt.new_string('')]), rt.new_bool(false))) {
				this.error(rt.new_string('Cannot find null-byte (0x00) separator between ItemKey #' + (var_i).str() + ' and value. ItemKey starts ' + (var_offset).str() + ' bytes into the APE tag, at file offset ' + (rt.add(var_thisfile_ape.array_get('tag_offset_start'), var_offset)).str()))
				return false
			}
			mut var_ItemKeyLength := rt.sub(rt.call_function('strpos', [var_APEtagData.dup(), rt.new_string(''), var_offset.dup()]), var_offset)
			mut var_item_key := rt.new_string(rt.new_string(rt.call_function('substr', [var_APEtagData.dup(), var_offset.dup(), var_ItemKeyLength.dup()]).to_string().to_lower()))
			var_thisfile_ape.array_get_mut('items').array_set(var_item_key, rt.new_array())
			// unsupported expression: Expr_AssignRef
			var_thisfile_ape_items_current['offset'] = rt.add(var_thisfile_ape.array_get('tag_offset_start'), var_offset)
			// unsupported expression: Expr_AssignOp_Plus
			var_thisfile_ape_items_current['data'] = rt.call_function('substr', [var_APEtagData.dup(), var_offset.dup(), var_value_size.dup()])
			// unsupported expression: Expr_AssignOp_Plus
			var_thisfile_ape_items_current['flags'] = this.parseapetagflags(var_item_flags.dup())
			mut switch_val_1 := var_thisfile_ape_items_current.array_get('flags').array_get('item_contents_raw')
			if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
				var_thisfile_ape_items_current['data'] = rt.call_function('explode', [rt.new_string(''), var_thisfile_ape_items_current.array_get('data')])
			} else {
			}
			mut switch_val_2 := rt.new_string(var_item_key.dup().to_string().to_lower())
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('replaygain_track_gain'))) {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^([\\-\\+][0-9\\.,]{8})( dB)?$#'), var_thisfile_ape_items_current.array_get('data').array_get(0), var_matches.dup()])) {
					var_thisfile_replaygain.array_get_mut('track').array_set('adjustment', // unsupported expression: Expr_Cast_Double)
					var_thisfile_replaygain.array_get_mut('track').array_set('originator', 'unspecified')
				} else {
					this.warning(rt.new_string('MP3gainTrackGain value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get('data').array_get(0)).str() + '"'))
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('replaygain_track_peak'))) {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^([0-9\\.,]{8})$#'), var_thisfile_ape_items_current.array_get('data').array_get(0), var_matches.dup()])) {
					var_thisfile_replaygain.array_get_mut('track').array_set('peak', // unsupported expression: Expr_Cast_Double)
					var_thisfile_replaygain.array_get_mut('track').array_set('originator', 'unspecified')
					if rt.is_true(rt.less_equal(var_thisfile_replaygain.array_get('track').array_get('peak'), rt.new_int(0))) {
						this.warning(rt.new_string('ReplayGain Track peak from APEtag appears invalid: ' + (var_thisfile_replaygain.array_get('track').array_get('peak')).str() + ' (original value = "' + (var_thisfile_ape_items_current.array_get('data').array_get(0)).str() + '")'))
					}
				} else {
					this.warning(rt.new_string('MP3gainTrackPeak value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get('data').array_get(0)).str() + '"'))
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('replaygain_album_gain'))) {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^([\\-\\+][0-9\\.,]{8})( dB)?$#'), var_thisfile_ape_items_current.array_get('data').array_get(0), var_matches.dup()])) {
					var_thisfile_replaygain.array_get_mut('album').array_set('adjustment', // unsupported expression: Expr_Cast_Double)
					var_thisfile_replaygain.array_get_mut('album').array_set('originator', 'unspecified')
				} else {
					this.warning(rt.new_string('MP3gainAlbumGain value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get('data').array_get(0)).str() + '"'))
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('replaygain_album_peak'))) {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^([0-9\\.,]{8})$#'), var_thisfile_ape_items_current.array_get('data').array_get(0), var_matches.dup()])) {
					var_thisfile_replaygain.array_get_mut('album').array_set('peak', // unsupported expression: Expr_Cast_Double)
					var_thisfile_replaygain.array_get_mut('album').array_set('originator', 'unspecified')
					if rt.is_true(rt.less_equal(var_thisfile_replaygain.array_get('album').array_get('peak'), rt.new_int(0))) {
						this.warning(rt.new_string('ReplayGain Album peak from APEtag appears invalid: ' + (var_thisfile_replaygain.array_get('album').array_get('peak')).str() + ' (original value = "' + (var_thisfile_ape_items_current.array_get('data').array_get(0)).str() + '")'))
					}
				} else {
					this.warning(rt.new_string('MP3gainAlbumPeak value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get('data').array_get(0)).str() + '"'))
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mp3gain_undo'))) {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^[\\-\\+][0-9]{3},[\\-\\+][0-9]{3},[NW]$#'), var_thisfile_ape_items_current.array_get('data').array_get(0)])) {
					// unsupported assign target: Expr_List
					var_thisfile_replaygain.array_get_mut('mp3gain').array_set('undo_left', var_mp3gain_undo_left.dup().to_i64())
					var_thisfile_replaygain.array_get_mut('mp3gain').array_set('undo_right', var_mp3gain_undo_right.dup().to_i64())
					var_thisfile_replaygain.array_get_mut('mp3gain').array_set('undo_wrap', if rt.is_true(rt.equal(var_mp3gain_undo_wrap, rt.new_string('Y'))) { true } else { false })
				} else {
					this.warning(rt.new_string('MP3gainUndo value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get('data').array_get(0)).str() + '"'))
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mp3gain_minmax'))) {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^[0-9]{3},[0-9]{3}$#'), var_thisfile_ape_items_current.array_get('data').array_get(0)])) {
					// unsupported assign target: Expr_List
					var_thisfile_replaygain.array_get_mut('mp3gain').array_set('globalgain_track_min', var_mp3gain_globalgain_min.dup().to_i64())
					var_thisfile_replaygain.array_get_mut('mp3gain').array_set('globalgain_track_max', var_mp3gain_globalgain_max.dup().to_i64())
				} else {
					this.warning(rt.new_string('MP3gainMinMax value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get('data').array_get(0)).str() + '"'))
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mp3gain_album_minmax'))) {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^[0-9]{3},[0-9]{3}$#'), var_thisfile_ape_items_current.array_get('data').array_get(0)])) {
					// unsupported assign target: Expr_List
					var_thisfile_replaygain.array_get_mut('mp3gain').array_set('globalgain_album_min', var_mp3gain_globalgain_album_min.dup().to_i64())
					var_thisfile_replaygain.array_get_mut('mp3gain').array_set('globalgain_album_max', var_mp3gain_globalgain_album_max.dup().to_i64())
				} else {
					this.warning(rt.new_string('MP3gainAlbumMinMax value in APEtag appears invalid: "' + (var_thisfile_ape_items_current.array_get('data').array_get(0)).str() + '"'))
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('tracknumber'))) {
				if rt.is_true(rt.new_bool(var_thisfile_ape_items_current.array_get('data').is_array())) {
					{
						mut iter_1 := var_thisfile_ape_items_current.array_get('data').iterator()
						for {
							item_1 := iter_1.next() or { break }
							mut var_comment := item_1.val
							var_thisfile_ape.array_get_mut('comments').array_get_mut('track_number').array_push(var_comment.dup())
						}
					}
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (artist)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (back)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (band logo)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (band)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (colored fish)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (composer)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (conductor)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (front)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (icon)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (illustration)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (lead)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (leaflet)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (lyricist)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (media)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (movie scene)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (other icon)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (other)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (performance)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (publisher logo)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (recording)'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cover art (studio)'))) {
				if rt.is_true(rt.new_bool(var_thisfile_ape_items_current.array_get('data').is_array())) {
					this.warning(rt.new_string('APEtag "' + (var_item_key).str() + '" should be flagged as Binary data, but was incorrectly flagged as UTF-8'))
					var_thisfile_ape_items_current['data'] = rt.call_function('implode', [rt.new_string(''), var_thisfile_ape_items_current.array_get('data')])
				}
				// unsupported assign target: Expr_List
				var_thisfile_ape_items_current['data_offset'] = rt.add(var_thisfile_ape_items_current.array_get('offset'), rt.new_int((var_thisfile_ape_items_current.array_get('filename')).str() + ''.len))
				var_thisfile_ape_items_current['data_length'] = rt.new_int(var_thisfile_ape_items_current.array_get('data').to_string().len)
				for {
					var_thisfile_ape_items_current['image_mime'] = rt.new_string('')
					mut var_imageinfo := rt.new_array()
					mut var_imagechunkcheck := 
					if rt.is_true() {
					}
					
					if !(false) {
						break
					}
				}
			} else {
			}
			
		}
	}
}

fn (mut this Class_getid3_apetag) parseapeheaderfooter(var_APEheaderFooterData rt.PhpVal) rt.PhpVal {
	mut var_headerfooterinfo_raw := map[string]rt.PhpVal{}
}

fn (mut this Class_getid3_apetag) parseapetagflags(var_rawflagint rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_getid3_apetag) apecontenttypeflaglookup(var_contenttypeid rt.PhpVal) rt.PhpVal {
	mut var_APEcontentTypeFlagLookup := rt.new_null()
}

fn (mut this Class_getid3_apetag) apetagitemisutf8lookup(var_itemkey rt.PhpVal) rt.PhpVal {
	mut var_APEtagItemIsUTF8Lookup := rt.new_null()
}

struct Class_getid3_handler {
	rt.PhpObjectBase
}

struct Class_getid3_lib {
	rt.PhpObjectBase
}

fn create_getid3_apetag() &Class_getid3_apetag {
	mut obj := &Class_getid3_apetag{
		PhpObjectBase: rt.PhpObjectBase{}
		inline_attachments: rt.new_bool(true)
		overrideendoffset: rt.new_int(0)
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




pub fn init_wp_includes_id3_module_tag_apetag_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_INCLUDEPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}

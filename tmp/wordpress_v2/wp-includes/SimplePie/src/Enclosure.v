import rt
import crypto.md5

struct Class_SimplePie_Enclosure {
	rt.PhpObjectBase
pub mut:
		bitrate rt.PhpVal = rt.new_null()
		captions rt.PhpVal = rt.new_null()
		categories rt.PhpVal = rt.new_null()
		channels rt.PhpVal = rt.new_null()
		copyright rt.PhpVal = rt.new_null()
		credits rt.PhpVal = rt.new_null()
		description rt.PhpVal = rt.new_null()
		duration rt.PhpVal = rt.new_null()
		expression rt.PhpVal = rt.new_null()
		framerate rt.PhpVal = rt.new_null()
		handler rt.PhpVal = rt.new_null()
		hashes rt.PhpVal = rt.new_null()
		height rt.PhpVal = rt.new_null()
		javascript rt.PhpVal = rt.new_null()
		keywords rt.PhpVal = rt.new_null()
		lang rt.PhpVal = rt.new_null()
		length rt.PhpVal = rt.new_null()
		link rt.PhpVal = rt.new_null()
		medium rt.PhpVal = rt.new_null()
		player rt.PhpVal = rt.new_null()
		ratings rt.PhpVal = rt.new_null()
		restrictions rt.PhpVal = rt.new_null()
		samplingrate rt.PhpVal = rt.new_null()
		thumbnails rt.PhpVal = rt.new_null()
		title rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_null()
		width rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) construct(mut var_link Class_SimplePie_?string, mut var_type Class_SimplePie_?string, mut var_length Class_SimplePie_?int, var_javascript rt.PhpVal, mut var_bitrate Class_SimplePie_?string, mut var_captions Class_SimplePie_?array, mut var_categories Class_SimplePie_?array, mut var_channels Class_SimplePie_?int, mut var_copyright Class_SimplePie_?Copyright, mut var_credits Class_SimplePie_?array, mut var_description Class_SimplePie_?string, mut var_duration Class_SimplePie_?int, mut var_expression Class_SimplePie_?string, mut var_framerate Class_SimplePie_?string, mut var_hashes Class_SimplePie_?array, mut var_height Class_SimplePie_?string, mut var_keywords Class_SimplePie_?array, mut var_lang Class_SimplePie_?string, mut var_medium Class_SimplePie_?string, mut var_player Class_SimplePie_?string, mut var_ratings Class_SimplePie_?array, mut var_restrictions Class_SimplePie_?array, mut var_samplingrate Class_SimplePie_?string, mut var_thumbnails Class_SimplePie_?array, mut var_title Class_SimplePie_?string, mut var_width Class_SimplePie_?string) {
	mut var_type_mutated := var_type
	mut var_length_mutated := var_length
	mut var_captions_mutated := var_captions
	mut var_categories_mutated := var_categories
	mut var_credits_mutated := var_credits
	mut var_hashes_mutated := var_hashes
	mut var_height_mutated := var_height
	mut var_keywords_mutated := var_keywords
	mut var_ratings_mutated := var_ratings
	mut var_restrictions_mutated := var_restrictions
	mut var_thumbnails_mutated := var_thumbnails
	mut var_width_mutated := var_width
	this.bitrate = var_bitrate
	this.captions = var_captions_mutated
	this.categories = var_categories_mutated
	this.channels = var_channels
	this.copyright = var_copyright
	this.credits = var_credits_mutated
	this.description = var_description
	this.duration = var_duration
	this.expression = var_expression
	this.framerate = var_framerate
	this.hashes = var_hashes_mutated
	this.height = var_height_mutated
	this.keywords = var_keywords_mutated
	this.lang = var_lang
	this.length = var_length_mutated
	this.link = var_link
	this.medium = var_medium
	this.player = var_player
	this.ratings = var_ratings_mutated
	this.restrictions = var_restrictions_mutated
	this.samplingrate = var_samplingrate
	this.thumbnails = var_thumbnails_mutated
	this.title = var_title
	this.prop_type = var_type_mutated
	this.width = var_width_mutated
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('idn_to_ascii')])) {
		mut iife_temp_0 := Class_SimplePie_SimplePie_Misc{}
		mut iife_result_0 := iife_temp_0.parse_url(if !(var_link).is_null() { var_link } else { rt.new_string('') })
		mut var_parsed := iife_result_0
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parsed.array_get(rt.new_string('authority')), rt.new_string(''))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_print', [var_parsed.array_get(rt.new_string('authority'))]))))) {
			mut var_authority := rt.new_string((rt.call_function('idn_to_ascii', [var_parsed.array_get(rt.new_string('authority')), rt.get_constant('IDNA_NONTRANSITIONAL_TO_ASCII'), rt.get_constant('INTL_IDNA_VARIANT_UTS46')])).str())
			mut iife_temp_1 := Class_SimplePie_SimplePie_Misc{}
			mut iife_result_1 := iife_temp_1.compress_parse_url(var_parsed.array_get(rt.new_string('scheme')), var_authority.clone(), var_parsed.array_get(rt.new_string('path')), var_parsed.array_get(rt.new_string('query')), var_parsed.array_get(rt.new_string('fragment')))
			this.link = iife_result_1
		}
	}
	this.handler = this.get_handler()
}

fn (mut this Class_SimplePie_Enclosure) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [rt.new_object('SimplePie_Enclosure', []string{}, &this)]).to_string())
}

fn (mut this Class_SimplePie_Enclosure) get_bitrate() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.bitrate, rt.new_null())))) {
		return this.bitrate
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_caption(key i64) rt.PhpVal {
	mut var_captions := this.get_captions()
	if var_captions.array_isset(rt.new_int(key)) {
		return var_captions.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_captions() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.captions, rt.new_null())))) {
		return this.captions
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_category(key i64) rt.PhpVal {
	mut var_categories := this.get_categories()
	if var_categories.array_isset(rt.new_int(key)) {
		return var_categories.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_categories() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.categories, rt.new_null())))) {
		return this.categories
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_channels() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.channels, rt.new_null())))) {
		return this.channels
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_copyright() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.copyright, rt.new_null())))) {
		return this.copyright
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_credit(key i64) rt.PhpVal {
	mut var_credits := this.get_credits()
	if var_credits.array_isset(rt.new_int(key)) {
		return var_credits.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_credits() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.credits, rt.new_null())))) {
		return this.credits
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_description() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.description, rt.new_null())))) {
		return this.description
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_duration(convert bool) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.duration, rt.new_null())))) {
		if var_convert {
			mut iife_temp_2 := Class_SimplePie_SimplePie_Misc{}
			mut iife_result_2 := iife_temp_2.time_hms(this.duration)
			mut var_time := iife_result_2
			return var_time.clone()
		}
		return this.duration
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_expression() string {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.expression, rt.new_null())))) {
		return (this.expression).str()
	}
	return 'full'
}

fn (mut this Class_SimplePie_Enclosure) get_extension() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.link, rt.new_null())))) {
		mut iife_temp_3 := Class_SimplePie_SimplePie_Misc{}
		mut iife_result_3 := iife_temp_3.parse_url(this.link)
		mut var_url := iife_result_3
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url.array_get(rt.new_string('path')), rt.new_string(''))))) {
			return rt.call_function('pathinfo', [var_url.array_get(rt.new_string('path')), rt.get_constant('PATHINFO_EXTENSION')])
		}
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_framerate() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.framerate, rt.new_null())))) {
		return this.framerate
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_handler() rt.PhpVal {
	return this.get_real_type(true)
}

fn (mut this Class_SimplePie_Enclosure) get_hash(key i64) rt.PhpVal {
	mut var_hashes := this.get_hashes()
	if var_hashes.array_isset(rt.new_int(key)) {
		return var_hashes.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_hashes() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.hashes, rt.new_null())))) {
		return this.hashes
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_height() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.height, rt.new_null())))) {
		return this.height
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_language() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.lang, rt.new_null())))) {
		return this.lang
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_keyword(key i64) rt.PhpVal {
	mut var_keywords := this.get_keywords()
	if var_keywords.array_isset(rt.new_int(key)) {
		return var_keywords.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_keywords() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.keywords, rt.new_null())))) {
		return this.keywords
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_length() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.length, rt.new_null())))) {
		return this.length
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_link() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.link, rt.new_null())))) {
		return this.link
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_medium() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.medium, rt.new_null())))) {
		return this.medium
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_player() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.player, rt.new_null())))) {
		return this.player
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_rating(key i64) rt.PhpVal {
	mut var_ratings := this.get_ratings()
	if var_ratings.array_isset(rt.new_int(key)) {
		return var_ratings.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_ratings() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.ratings, rt.new_null())))) {
		return this.ratings
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_restriction(key i64) rt.PhpVal {
	mut var_restrictions := this.get_restrictions()
	if var_restrictions.array_isset(rt.new_int(key)) {
		return var_restrictions.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_restrictions() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.restrictions, rt.new_null())))) {
		return this.restrictions
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_sampling_rate() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.samplingrate, rt.new_null())))) {
		return this.samplingrate
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_size() rt.PhpVal {
	mut var_length := this.get_length()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_length, rt.new_null())))) {
		return rt.call_function('round', [rt.div(var_length, rt.new_int(1048576)), rt.new_int(2)])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_thumbnail(key i64) rt.PhpVal {
	mut var_thumbnails := this.get_thumbnails()
	if var_thumbnails.array_isset(rt.new_int(key)) {
		return var_thumbnails.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_thumbnails() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.thumbnails, rt.new_null())))) {
		return this.thumbnails
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_title() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.title, rt.new_null())))) {
		return this.title
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_type() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.prop_type, rt.new_null())))) {
		return this.prop_type
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_width() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.width, rt.new_null())))) {
		return this.width
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) native_embed(options string) rt.PhpVal {
	mut options_mutated := options
	return this.embed(options_mutated, true)
}

fn (mut this Class_SimplePie_Enclosure) embed(options string, native bool) rt.PhpVal {
	mut options_mutated := options
	mut var_audio := rt.new_string('')
	mut var_video := rt.new_string('')
	mut var_alt := rt.new_string('')
	mut var_altclass := rt.new_string('')
	mut var_loop := rt.new_string('false')
	mut var_width := rt.new_string('auto')
	mut var_height := rt.new_string('auto')
	mut var_bgcolor := rt.new_string('#ffffff')
	mut var_mediaplayer := rt.new_string('')
	mut var_widescreen := rt.new_bool(false)
	mut var_handler := this.get_handler()
	mut var_type := this.get_real_type(false)
	mut var_placeholder := rt.new_string('')
	if rt.is_true(rt.new_bool(rt.new_string(options_mutated).clone().is_array())) {
		rt.call_function('extract', [rt.new_string(options_mutated).clone()])
	} else {
		options_mutated = (rt.call_function('explode', [rt.new_string(','), rt.new_string(options_mutated).clone()])).str()
		mut iter_1 := rt.new_string(options_mutated).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option := item_1.val
			mut var_opt := rt.call_function('explode', [rt.new_string(':'), var_option.clone(), rt.new_int(2)])
			if var_opt.array_isset(rt.new_int(0)) && var_opt.array_isset(rt.new_int(1)) {
				var_opt.array_set(0, var_opt.array_get(rt.new_int(0)).to_string().trim_space())
				var_opt.array_set(1, var_opt.array_get(rt.new_int(1)).to_string().trim_space())
				mut switch_val_1 := var_opt.array_get(rt.new_int(0))
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('audio'))) {
				var_audio = var_opt.array_get(rt.new_int(1))
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('video'))) {
				var_video = var_opt.array_get(rt.new_int(1))
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('alt'))) {
				var_alt = var_opt.array_get(rt.new_int(1))
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('altclass'))) {
				var_altclass = var_opt.array_get(rt.new_int(1))
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('loop'))) {
				var_loop = var_opt.array_get(rt.new_int(1))
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('width'))) {
				var_width = var_opt.array_get(rt.new_int(1))
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('height'))) {
				var_height = var_opt.array_get(rt.new_int(1))
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('bgcolor'))) {
				var_bgcolor = var_opt.array_get(rt.new_int(1))
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('mediaplayer'))) {
				var_mediaplayer = var_opt.array_get(rt.new_int(1))
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('widescreen'))) {
				var_widescreen = var_opt.array_get(rt.new_int(1))
				}
			}
		}
	}
	mut var_mime := rt.call_function('explode', [rt.new_string('/'), rt.new_string((var_type).str()), rt.new_int(2)])
	var_mime = var_mime.array_get(rt.new_int(0))
	if rt.is_true(rt.identical(var_width, rt.new_string('auto'))) {
		if rt.is_true(rt.identical(var_mime, rt.new_string('video'))) {
			if rt.is_true(rt.identical(var_height, rt.new_string('auto'))) {
			var_width = rt.new_int(480)
			} else if rt.is_true(var_widescreen) {
			var_width = rt.call_function('round', [rt.new_int(var_height.clone().to_i64() / 9 * 16)])
			} else {
			var_width = rt.call_function('round', [rt.new_int(var_height.clone().to_i64() / 3 * 4)])
			}
		} else {
		var_width = rt.new_string('100%')
		}
	}
	if rt.is_true(rt.identical(var_height, rt.new_string('auto'))) {
		if rt.is_true(rt.identical(var_mime, rt.new_string('audio'))) {
		var_height = rt.new_int(0)
		} else if rt.is_true(rt.identical(var_mime, rt.new_string('video'))) {
			if rt.is_true(rt.identical(var_width, rt.new_string('auto'))) {
				if rt.is_true(var_widescreen) {
				var_height = rt.new_int(270)
				} else {
				var_height = rt.new_int(360)
				}
			} else if rt.is_true(var_widescreen) {
			var_height = rt.call_function('round', [rt.new_int(var_width.clone().to_i64() / 16 * 9)])
			} else {
			var_height = rt.call_function('round', [rt.new_int(var_width.clone().to_i64() / 4 * 3)])
			}
		} else {
		var_height = rt.new_int(376)
		}
	} else if rt.is_true(rt.identical(var_mime, rt.new_string('audio'))) {
	var_height = rt.new_int(0)
	}
	if rt.is_true(rt.identical(var_mime, rt.new_string('audio'))) {
	var_placeholder = var_audio.clone()
	} else if rt.is_true(rt.identical(var_mime, rt.new_string('video'))) {
	var_placeholder = var_video.clone()
	}
	mut var_embed := rt.new_string('')
	if rt.is_true(rt.identical(var_handler, rt.new_string('flash'))) {
		if var_native {
			var_embed = rt.concat(var_embed, rt.new_string('<embed src="' + (this.get_link()).str() + "\" pluginspage=\"http://adobe.com/go/getflashplayer\" type=\"${var_type.to_string()}\" quality=\"high\" width=\"${var_width.to_string()}\" height=\"${var_height.to_string()}\" bgcolor=\"${var_bgcolor.to_string()}\" loop=\"${var_loop.to_string()}\"></embed>"))
		} else {
			var_embed = rt.concat(var_embed, rt.new_string("<script type='text/javascript'>embed_flash('${var_bgcolor.to_string()}', '${var_width.to_string()}', '${var_height.to_string()}', '" + (this.get_link()).str() + "', '${var_loop.to_string()}', '${var_type.to_string()}');</script>"))
		}
	} else if rt.is_true(rt.identical(var_handler, rt.new_string('fmedia'))) || (rt.is_true(rt.identical(var_handler, rt.new_string('mp3'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_mediaplayer, rt.new_string('')))))) {
		if rt.is_true(rt.new_bool(var_height.clone().is_long() || var_height.clone().is_double())) {
			var_height = rt.add(var_height, rt.new_int(20))
		}
		if var_native {
			var_embed = rt.concat(var_embed, rt.new_string("<embed src=\"${var_mediaplayer.to_string()}\" pluginspage=\"http://adobe.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" quality=\"high\" width=\"${var_width.to_string()}\" height=\"${var_height.to_string()}\" wmode=\"transparent\" flashvars=\"file=" + (rt.call_function('rawurlencode', [rt.new_string((this.get_link()).str() + '?file_extension=.' + (this.get_extension()).str())])).str() + "&autostart=false&repeat=${var_loop.to_string()}&showdigits=true&showfsbutton=false\"></embed>"))
		} else {
			var_embed = rt.concat(var_embed, rt.new_string("<script type='text/javascript'>embed_flv('${var_width.to_string()}', '${var_height.to_string()}', '" + (rt.call_function('rawurlencode', [rt.new_string((this.get_link()).str() + '?file_extension=.' + (this.get_extension()).str())])).str() + "', '${var_placeholder.to_string()}', '${var_loop.to_string()}', '${var_mediaplayer.to_string()}');</script>"))
		}
	} else if rt.is_true(rt.identical(var_handler, rt.new_string('quicktime'))) || (rt.is_true(rt.identical(var_handler, rt.new_string('mp3'))) && rt.is_true(rt.identical(var_mediaplayer, rt.new_string('')))) {
		if rt.is_true(rt.new_bool(var_height.clone().is_long() || var_height.clone().is_double())) {
			var_height = rt.add(var_height, rt.new_int(16))
		}
		if var_native {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_placeholder, rt.new_string(''))))) {
				var_embed = rt.concat(var_embed, rt.new_string("<embed type=\"${var_type.to_string()}\" style=\"cursor:hand; cursor:pointer;\" href=\"" + (this.get_link()).str() + "\" src=\"${var_placeholder.to_string()}\" width=\"${var_width.to_string()}\" height=\"${var_height.to_string()}\" autoplay=\"false\" target=\"myself\" controller=\"false\" loop=\"${var_loop.to_string()}\" scale=\"aspect\" bgcolor=\"${var_bgcolor.to_string()}\" pluginspage=\"http://apple.com/quicktime/download/\"></embed>"))
			} else {
				var_embed = rt.concat(var_embed, rt.new_string("<embed type=\"${var_type.to_string()}\" style=\"cursor:hand; cursor:pointer;\" src=\"" + (this.get_link()).str() + "\" width=\"${var_width.to_string()}\" height=\"${var_height.to_string()}\" autoplay=\"false\" target=\"myself\" controller=\"true\" loop=\"${var_loop.to_string()}\" scale=\"aspect\" bgcolor=\"${var_bgcolor.to_string()}\" pluginspage=\"http://apple.com/quicktime/download/\"></embed>"))
			}
		} else {
			var_embed = rt.concat(var_embed, rt.new_string("<script type='text/javascript'>embed_quicktime('${var_type.to_string()}', '${var_bgcolor.to_string()}', '${var_width.to_string()}', '${var_height.to_string()}', '" + (this.get_link()).str() + "', '${var_placeholder.to_string()}', '${var_loop.to_string()}');</script>"))
		}
	} else if rt.is_true(rt.identical(var_handler, rt.new_string('wmedia'))) {
		if rt.is_true(rt.new_bool(var_height.clone().is_long() || var_height.clone().is_double())) {
			var_height = rt.add(var_height, rt.new_int(45))
		}
		if var_native {
			var_embed = rt.concat(var_embed, rt.new_string('<embed type="application/x-mplayer2" src="' + (this.get_link()).str() + "\" autosize=\"1\" width=\"${var_width.to_string()}\" height=\"${var_height.to_string()}\" showcontrols=\"1\" showstatusbar=\"0\" showdisplay=\"0\" autostart=\"0\"></embed>"))
		} else {
			var_embed = rt.concat(var_embed, rt.new_string("<script type='text/javascript'>embed_wmedia('${var_width.to_string()}', '${var_height.to_string()}', '" + (this.get_link()).str() + '\');</script>'))
		}
	} else {
		var_embed = rt.concat(var_embed, rt.new_string('<a href="' + (this.get_link()).str() + '" class="' + (var_altclass).str() + '">' + (var_alt).str() + '</a>'))
	}
	return var_embed.clone()
}

fn (mut this Class_SimplePie_Enclosure) get_real_type(find_handler bool) rt.PhpVal {
	mut var_types_flash := rt.create_array([rt.ArrayItem{ key: none, val: 'application/x-shockwave-flash' }, rt.ArrayItem{ key: none, val: 'application/futuresplash' }])
	mut var_types_fmedia := rt.create_array([rt.ArrayItem{ key: none, val: 'video/flv' }, rt.ArrayItem{ key: none, val: 'video/x-flv' }, rt.ArrayItem{ key: none, val: 'flv-application/octet-stream' }])
	mut var_types_quicktime := rt.create_array([rt.ArrayItem{ key: none, val: 'audio/3gpp' }, rt.ArrayItem{ key: none, val: 'audio/3gpp2' }, rt.ArrayItem{ key: none, val: 'audio/aac' }, rt.ArrayItem{ key: none, val: 'audio/x-aac' }, rt.ArrayItem{ key: none, val: 'audio/aiff' }, rt.ArrayItem{ key: none, val: 'audio/x-aiff' }, rt.ArrayItem{ key: none, val: 'audio/mid' }, rt.ArrayItem{ key: none, val: 'audio/midi' }, rt.ArrayItem{ key: none, val: 'audio/x-midi' }, rt.ArrayItem{ key: none, val: 'audio/mp4' }, rt.ArrayItem{ key: none, val: 'audio/m4a' }, rt.ArrayItem{ key: none, val: 'audio/x-m4a' }, rt.ArrayItem{ key: none, val: 'audio/wav' }, rt.ArrayItem{ key: none, val: 'audio/x-wav' }, rt.ArrayItem{ key: none, val: 'video/3gpp' }, rt.ArrayItem{ key: none, val: 'video/3gpp2' }, rt.ArrayItem{ key: none, val: 'video/m4v' }, rt.ArrayItem{ key: none, val: 'video/x-m4v' }, rt.ArrayItem{ key: none, val: 'video/mp4' }, rt.ArrayItem{ key: none, val: 'video/mpeg' }, rt.ArrayItem{ key: none, val: 'video/x-mpeg' }, rt.ArrayItem{ key: none, val: 'video/quicktime' }, rt.ArrayItem{ key: none, val: 'video/sd-video' }])
	mut var_types_wmedia := rt.create_array([rt.ArrayItem{ key: none, val: 'application/asx' }, rt.ArrayItem{ key: none, val: 'application/x-mplayer2' }, rt.ArrayItem{ key: none, val: 'audio/x-ms-wma' }, rt.ArrayItem{ key: none, val: 'audio/x-ms-wax' }, rt.ArrayItem{ key: none, val: 'video/x-ms-asf-plugin' }, rt.ArrayItem{ key: none, val: 'video/x-ms-asf' }, rt.ArrayItem{ key: none, val: 'video/x-ms-wm' }, rt.ArrayItem{ key: none, val: 'video/x-ms-wmv' }, rt.ArrayItem{ key: none, val: 'video/x-ms-wvx' }])
	mut var_types_mp3 := rt.create_array([rt.ArrayItem{ key: none, val: 'audio/mp3' }, rt.ArrayItem{ key: none, val: 'audio/x-mp3' }, rt.ArrayItem{ key: none, val: 'audio/mpeg' }, rt.ArrayItem{ key: none, val: 'audio/x-mpeg' }])
	mut var_type := this.get_type()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_type, rt.new_null())))) {
	var_type = rt.new_string(var_type.clone().to_string().to_lower())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_type.clone(), rt.call_function('array_merge', [var_types_flash.clone(), var_types_fmedia.clone(), var_types_quicktime.clone(), var_types_wmedia.clone(), var_types_mp3.clone()])]))))) {
		mut var_extension := this.get_extension()
		if rt.is_true(rt.identical(var_extension, rt.new_null())) {
			return rt.new_null()
		}
		mut switch_val_2 := rt.new_string(var_extension.clone().to_string().to_lower())
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('aac'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('adts'))) {
		var_type = rt.new_string('audio/acc')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('aif'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('aifc'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('aiff'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('cdda'))) {
		var_type = rt.new_string('audio/aiff')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('bwf'))) {
		var_type = rt.new_string('audio/wav')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('kar'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('mid'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('midi'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('smf'))) {
		var_type = rt.new_string('audio/midi')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('m4a'))) {
		var_type = rt.new_string('audio/x-m4a')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mp3'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('swa'))) {
		var_type = rt.new_string('audio/mp3')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('wav'))) {
		var_type = rt.new_string('audio/wav')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('wax'))) {
		var_type = rt.new_string('audio/x-ms-wax')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('wma'))) {
		var_type = rt.new_string('audio/x-ms-wma')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('3gp'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('3gpp'))) {
		var_type = rt.new_string('video/3gpp')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('3g2'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('3gp2'))) {
		var_type = rt.new_string('video/3gpp2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('asf'))) {
		var_type = rt.new_string('video/x-ms-asf')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('flv'))) {
		var_type = rt.new_string('video/x-flv')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('m1a'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('m1s'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('m1v'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('m15'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('m75'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('mp2'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('mpa'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('mpeg'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('mpg'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('mpm'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('mpv'))) {
		var_type = rt.new_string('video/mpeg')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('m4v'))) {
		var_type = rt.new_string('video/x-m4v')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mov'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('qt'))) {
		var_type = rt.new_string('video/quicktime')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mp4'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('mpg4'))) {
		var_type = rt.new_string('video/mp4')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('sdv'))) {
		var_type = rt.new_string('video/sd-video')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('wm'))) {
		var_type = rt.new_string('video/x-ms-wm')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('wmv'))) {
		var_type = rt.new_string('video/x-ms-wmv')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('wvx'))) {
		var_type = rt.new_string('video/x-ms-wvx')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('spl'))) {
		var_type = rt.new_string('application/futuresplash')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('swf'))) {
		var_type = rt.new_string('application/x-shockwave-flash')
		}
	}
	if var_find_handler {
		if rt.is_true(rt.call_function('in_array', [var_type.clone(), var_types_flash.clone()])) {
			return rt.new_string('flash')
		} else if rt.is_true(rt.call_function('in_array', [var_type.clone(), var_types_fmedia.clone()])) {
			return rt.new_string('fmedia')
		} else if rt.is_true(rt.call_function('in_array', [var_type.clone(), var_types_quicktime.clone()])) {
			return rt.new_string('quicktime')
		} else if rt.is_true(rt.call_function('in_array', [var_type.clone(), var_types_wmedia.clone()])) {
			return rt.new_string('wmedia')
		} else if rt.is_true(rt.call_function('in_array', [var_type.clone(), var_types_mp3.clone()])) {
			return rt.new_string('mp3')
		}
		return rt.new_null()
	}
	return var_type.clone()
}

struct Class_SimplePie_SimplePie_Misc {
	rt.PhpObjectBase
}

fn create_simplepie_enclosure(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal, arg_6 rt.PhpVal, arg_7 rt.PhpVal, arg_8 rt.PhpVal, arg_9 rt.PhpVal, arg_10 rt.PhpVal, arg_11 rt.PhpVal, arg_12 rt.PhpVal, arg_13 rt.PhpVal, arg_14 rt.PhpVal, arg_15 rt.PhpVal, arg_16 rt.PhpVal, arg_17 rt.PhpVal, arg_18 rt.PhpVal, arg_19 rt.PhpVal, arg_20 rt.PhpVal, arg_21 rt.PhpVal, arg_22 rt.PhpVal, arg_23 rt.PhpVal, arg_24 rt.PhpVal, arg_25 rt.PhpVal) &Class_SimplePie_Enclosure {
	mut obj := &Class_SimplePie_Enclosure{
		PhpObjectBase: rt.PhpObjectBase{}
		bitrate: rt.new_null()
		captions: rt.new_null()
		categories: rt.new_null()
		channels: rt.new_null()
		copyright: rt.new_null()
		credits: rt.new_null()
		description: rt.new_null()
		duration: rt.new_null()
		expression: rt.new_null()
		framerate: rt.new_null()
		handler: rt.new_null()
		hashes: rt.new_null()
		height: rt.new_null()
		javascript: rt.new_null()
		keywords: rt.new_null()
		lang: rt.new_null()
		length: rt.new_null()
		link: rt.new_null()
		medium: rt.new_null()
		player: rt.new_null()
		ratings: rt.new_null()
		restrictions: rt.new_null()
		samplingrate: rt.new_null()
		thumbnails: rt.new_null()
		title: rt.new_null()
		prop_type: rt.new_null()
		width: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9, arg_10, arg_11, arg_12, arg_13, arg_14, arg_15, arg_16, arg_17, arg_18, arg_19, arg_20, arg_21, arg_22, arg_23, arg_24, arg_25)
	return obj
}

fn create_simplepie_simplepie_misc(_args ...rt.PhpVal) &Class_SimplePie_SimplePie_Misc {
	mut obj := &Class_SimplePie_SimplePie_Misc{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Enclosure) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_?int](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_SimplePie_?array](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_SimplePie_?array](if args.len > 6 { args[6] } else { rt.new_null() })
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_SimplePie_?int](if args.len > 7 { args[7] } else { rt.new_null() })
			mut dispatch_arg_8 := rt.cast_object_ptr[Class_SimplePie_?Copyright](if args.len > 8 { args[8] } else { rt.new_null() })
			mut dispatch_arg_9 := rt.cast_object_ptr[Class_SimplePie_?array](if args.len > 9 { args[9] } else { rt.new_null() })
			mut dispatch_arg_10 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 10 { args[10] } else { rt.new_null() })
			mut dispatch_arg_11 := rt.cast_object_ptr[Class_SimplePie_?int](if args.len > 11 { args[11] } else { rt.new_null() })
			mut dispatch_arg_12 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 12 { args[12] } else { rt.new_null() })
			mut dispatch_arg_13 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 13 { args[13] } else { rt.new_null() })
			mut dispatch_arg_14 := rt.cast_object_ptr[Class_SimplePie_?array](if args.len > 14 { args[14] } else { rt.new_null() })
			mut dispatch_arg_15 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 15 { args[15] } else { rt.new_null() })
			mut dispatch_arg_16 := rt.cast_object_ptr[Class_SimplePie_?array](if args.len > 16 { args[16] } else { rt.new_null() })
			mut dispatch_arg_17 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 17 { args[17] } else { rt.new_null() })
			mut dispatch_arg_18 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 18 { args[18] } else { rt.new_null() })
			mut dispatch_arg_19 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 19 { args[19] } else { rt.new_null() })
			mut dispatch_arg_20 := rt.cast_object_ptr[Class_SimplePie_?array](if args.len > 20 { args[20] } else { rt.new_null() })
			mut dispatch_arg_21 := rt.cast_object_ptr[Class_SimplePie_?array](if args.len > 21 { args[21] } else { rt.new_null() })
			mut dispatch_arg_22 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 22 { args[22] } else { rt.new_null() })
			mut dispatch_arg_23 := rt.cast_object_ptr[Class_SimplePie_?array](if args.len > 23 { args[23] } else { rt.new_null() })
			mut dispatch_arg_24 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 24 { args[24] } else { rt.new_null() })
			mut dispatch_arg_25 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 25 { args[25] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6, mut dispatch_arg_7, mut dispatch_arg_8, mut dispatch_arg_9, mut dispatch_arg_10, mut dispatch_arg_11, mut dispatch_arg_12, mut dispatch_arg_13, mut dispatch_arg_14, mut dispatch_arg_15, mut dispatch_arg_16, mut dispatch_arg_17, mut dispatch_arg_18, mut dispatch_arg_19, mut dispatch_arg_20, mut dispatch_arg_21, mut dispatch_arg_22, mut dispatch_arg_23, mut dispatch_arg_24, mut dispatch_arg_25)
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'get_bitrate' {
			return this.get_bitrate()
		}
		'get_caption' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_caption(dispatch_arg_0)
		}
		'get_captions' {
			return this.get_captions()
		}
		'get_category' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_category(dispatch_arg_0)
		}
		'get_categories' {
			return this.get_categories()
		}
		'get_channels' {
			return this.get_channels()
		}
		'get_copyright' {
			return this.get_copyright()
		}
		'get_credit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_credit(dispatch_arg_0)
		}
		'get_credits' {
			return this.get_credits()
		}
		'get_description' {
			return this.get_description()
		}
		'get_duration' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_duration(dispatch_arg_0)
		}
		'get_expression' {
			return rt.new_string(this.get_expression())
		}
		'get_extension' {
			return this.get_extension()
		}
		'get_framerate' {
			return this.get_framerate()
		}
		'get_handler' {
			return this.get_handler()
		}
		'get_hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_hash(dispatch_arg_0)
		}
		'get_hashes' {
			return this.get_hashes()
		}
		'get_height' {
			return this.get_height()
		}
		'get_language' {
			return this.get_language()
		}
		'get_keyword' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_keyword(dispatch_arg_0)
		}
		'get_keywords' {
			return this.get_keywords()
		}
		'get_length' {
			return this.get_length()
		}
		'get_link' {
			return this.get_link()
		}
		'get_medium' {
			return this.get_medium()
		}
		'get_player' {
			return this.get_player()
		}
		'get_rating' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_rating(dispatch_arg_0)
		}
		'get_ratings' {
			return this.get_ratings()
		}
		'get_restriction' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_restriction(dispatch_arg_0)
		}
		'get_restrictions' {
			return this.get_restrictions()
		}
		'get_sampling_rate' {
			return this.get_sampling_rate()
		}
		'get_size' {
			return this.get_size()
		}
		'get_thumbnail' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_thumbnail(dispatch_arg_0)
		}
		'get_thumbnails' {
			return this.get_thumbnails()
		}
		'get_title' {
			return this.get_title()
		}
		'get_type' {
			return this.get_type()
		}
		'get_width' {
			return this.get_width()
		}
		'native_embed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.native_embed(dispatch_arg_0)
		}
		'embed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.embed(dispatch_arg_0, dispatch_arg_1)
		}
		'get_real_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_real_type(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Enclosure) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'bitrate' { return this.bitrate }
		'captions' { return this.captions }
		'categories' { return this.categories }
		'channels' { return this.channels }
		'copyright' { return this.copyright }
		'credits' { return this.credits }
		'description' { return this.description }
		'duration' { return this.duration }
		'expression' { return this.expression }
		'framerate' { return this.framerate }
		'handler' { return this.handler }
		'hashes' { return this.hashes }
		'height' { return this.height }
		'javascript' { return this.javascript }
		'keywords' { return this.keywords }
		'lang' { return this.lang }
		'length' { return this.length }
		'link' { return this.link }
		'medium' { return this.medium }
		'player' { return this.player }
		'ratings' { return this.ratings }
		'restrictions' { return this.restrictions }
		'samplingrate' { return this.samplingrate }
		'thumbnails' { return this.thumbnails }
		'title' { return this.title }
		'type' { return this.prop_type }
		'width' { return this.width }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Enclosure) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'bitrate' { this.bitrate = val; return true }
		'captions' { this.captions = val; return true }
		'categories' { this.categories = val; return true }
		'channels' { this.channels = val; return true }
		'copyright' { this.copyright = val; return true }
		'credits' { this.credits = val; return true }
		'description' { this.description = val; return true }
		'duration' { this.duration = val; return true }
		'expression' { this.expression = val; return true }
		'framerate' { this.framerate = val; return true }
		'handler' { this.handler = val; return true }
		'hashes' { this.hashes = val; return true }
		'height' { this.height = val; return true }
		'javascript' { this.javascript = val; return true }
		'keywords' { this.keywords = val; return true }
		'lang' { this.lang = val; return true }
		'length' { this.length = val; return true }
		'link' { this.link = val; return true }
		'medium' { this.medium = val; return true }
		'player' { this.player = val; return true }
		'ratings' { this.ratings = val; return true }
		'restrictions' { this.restrictions = val; return true }
		'samplingrate' { this.samplingrate = val; return true }
		'thumbnails' { this.thumbnails = val; return true }
		'title' { this.title = val; return true }
		'type' { this.prop_type = val; return true }
		'width' { this.width = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_SimplePie_SimplePie_Misc) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_SimplePie_Misc) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_SimplePie_Misc) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Enclosure'), rt.new_string('SimplePie_Enclosure')])
}

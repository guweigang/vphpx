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

fn (mut this Class_SimplePie_Enclosure) construct(mut var_link Class_SimplePie_?string, mut var_type Class_SimplePie_?string, mut var_length Class_SimplePie_?int, var_javascript rt.PhpVal, mut var_bitrate Class_SimplePie_?string, mut var_captions Class_SimplePie_?array, mut var_categories Class_SimplePie_?array, mut var_channels Class_SimplePie_?int, mut var_copyright Class_SimplePie_?Copyright, mut var_credits Class_SimplePie_?array, mut var_description Class_SimplePie_?string, mut var_duration Class_SimplePie_?int, mut var_expression Class_SimplePie_?string, mut var_framerate Class_SimplePie_?string, mut var_hashes Class_SimplePie_?array, mut var_height Class_SimplePie_?string, mut var_keywords Class_SimplePie_?array, mut var_lang Class_SimplePie_?string, mut var_medium Class_SimplePie_?string, mut var_player Class_SimplePie_?string, mut var_ratings Class_SimplePie_?array, mut var_restrictions Class_SimplePie_?array, mut var_samplingrate Class_SimplePie_?string, mut var_thumbnails Class_SimplePie_?array, mut var_title Class_SimplePie_?string, mut var_width Class_SimplePie_?string)  {
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
	this.bitrate = var_bitrate.dup()
	this.captions = var_captions_mutated.dup()
	this.categories = var_categories_mutated.dup()
	this.channels = var_channels.dup()
	this.copyright = var_copyright.dup()
	this.credits = var_credits_mutated.dup()
	this.description = var_description.dup()
	this.duration = var_duration.dup()
	this.expression = var_expression.dup()
	this.framerate = var_framerate.dup()
	this.hashes = var_hashes_mutated.dup()
	this.height = var_height_mutated.dup()
	this.keywords = var_keywords_mutated.dup()
	this.lang = var_lang.dup()
	this.length = var_length_mutated.dup()
	this.link = var_link.dup()
	this.medium = var_medium.dup()
	this.player = var_player.dup()
	this.ratings = var_ratings_mutated.dup()
	this.restrictions = var_restrictions_mutated.dup()
	this.samplingrate = var_samplingrate.dup()
	this.thumbnails = var_thumbnails_mutated.dup()
	this.title = var_title.dup()
	this.prop_type = var_type_mutated.dup()
	this.width = var_width_mutated.dup()
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('idn_to_ascii')])) {
		mut var_parsed := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_SimplePie_Misc{}; return temp.parse_url(arg_0) }(if !(var_link).is_null() { var_link } else { rt.new_string('') })
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_print', [var_parsed.array_get('authority')]))))))) {
			mut var_authority := // unsupported expression: Expr_Cast_String
			this.link = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_SimplePie_Misc{}; return temp.compress_parse_url(arg_0, arg_1, arg_2, arg_3, arg_4) }(var_parsed.array_get('scheme'), var_authority.dup(), var_parsed.array_get('path'), var_parsed.array_get('query'), var_parsed.array_get('fragment'))
		}
	}
	this.handler = this.get_handler()
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_SimplePie_Enclosure) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [rt.new_object('SimplePie_Enclosure', []string{}, &this)]).to_string())
}

fn (mut this Class_SimplePie_Enclosure) get_bitrate() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.bitrate
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_caption(key i64) rt.PhpVal {
	mut var_captions := this.get_captions()
	if var_captions.array_isset(rt.new_int(key)) {
		return var_captions.array_get(key)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_captions() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.captions
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_category(key i64) rt.PhpVal {
	mut var_categories := this.get_categories()
	if var_categories.array_isset(rt.new_int(key)) {
		return var_categories.array_get(key)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_categories() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.categories
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_channels() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.channels
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_copyright() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.copyright
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_credit(key i64) rt.PhpVal {
	mut var_credits := this.get_credits()
	if var_credits.array_isset(rt.new_int(key)) {
		return var_credits.array_get(key)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_credits() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.credits
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_description() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.description
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_duration(convert bool) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if var_convert {
			mut var_time := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_SimplePie_Misc{}; return temp.time_hms(arg_0) }(this.duration)
			return var_time.dup()
		}
		return this.duration
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_expression() string {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (this.expression).str()
	}
	return 'full'
}

fn (mut this Class_SimplePie_Enclosure) get_extension() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_url := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_SimplePie_Misc{}; return temp.parse_url(arg_0) }(this.link)
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return rt.call_function('pathinfo', [var_url.array_get('path'), rt.get_constant('PATHINFO_EXTENSION')])
		}
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_framerate() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
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
		return var_hashes.array_get(key)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_hashes() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.hashes
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_height() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.height
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_language() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.lang
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_keyword(key i64) rt.PhpVal {
	mut var_keywords := this.get_keywords()
	if var_keywords.array_isset(rt.new_int(key)) {
		return var_keywords.array_get(key)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_keywords() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.keywords
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_length() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.length
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_link() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.link
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_medium() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.medium
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_player() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.player
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_rating(key i64) rt.PhpVal {
	mut var_ratings := this.get_ratings()
	if var_ratings.array_isset(rt.new_int(key)) {
		return var_ratings.array_get(key)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_ratings() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.ratings
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_restriction(key i64) rt.PhpVal {
	mut var_restrictions := this.get_restrictions()
	if var_restrictions.array_isset(rt.new_int(key)) {
		return .array_get()
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Enclosure) get_restrictions() rt.PhpVal {
	if rt.is_true() {
	}
	return 
}

fn (mut this Class_SimplePie_Enclosure) get_sampling_rate() rt.PhpVal {
}

fn (mut this Class_SimplePie_Enclosure) get_size() rt.PhpVal {
}

fn (mut this Class_SimplePie_Enclosure) get_thumbnail(key i64) rt.PhpVal {
}

fn (mut this Class_SimplePie_Enclosure) get_thumbnails() rt.PhpVal {
}

fn (mut this Class_SimplePie_Enclosure) get_title() rt.PhpVal {
}

fn (mut this Class_SimplePie_Enclosure) get_type() rt.PhpVal {
}

fn (mut this Class_SimplePie_Enclosure) get_width() rt.PhpVal {
}

fn (mut this Class_SimplePie_Enclosure) native_embed(options string) rt.PhpVal {
	mut options_mutated := options
}

fn (mut this Class_SimplePie_Enclosure) embed(options string, native bool) rt.PhpVal {
	mut options_mutated := options
}

fn (mut this Class_SimplePie_Enclosure) get_real_type(find_handler bool) rt.PhpVal {
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

fn create_simplepie_simplepie_misc() &Class_SimplePie_SimplePie_Misc {
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




pub fn init_wp_includes_simplepie_src_enclosure_php() {
	// unsupported statement: Stmt_Declare
}

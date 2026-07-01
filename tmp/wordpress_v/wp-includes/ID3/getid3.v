import rt

pub fn Class_getID3.version() string {
	return '1.9.25-202603080933'
}
pub fn Class_getID3.fread_buffer_size() i64 {
	return 32768
}
pub fn Class_getID3.attachments_none() bool {
	return false
}
pub fn Class_getID3.attachments_inline() bool {
	return true
}
struct Class_getID3 {
	rt.PhpObjectBase
pub mut:
		encoding rt.PhpVal = rt.new_string('UTF-8')
		encoding_id3v1 rt.PhpVal = rt.new_string('ISO-8859-1')
		encoding_id3v1_autodetect rt.PhpVal = rt.new_bool(false)
		option_tag_id3v1 rt.PhpVal = rt.new_bool(true)
		option_tag_id3v2 rt.PhpVal = rt.new_bool(true)
		option_tag_lyrics3 rt.PhpVal = rt.new_bool(true)
		option_tag_apetag rt.PhpVal = rt.new_bool(true)
		option_tags_process rt.PhpVal = rt.new_bool(true)
		option_tags_html rt.PhpVal = rt.new_bool(true)
		option_extra_info rt.PhpVal = rt.new_bool(true)
		option_save_attachments rt.PhpVal = rt.new_bool(true)
		option_md5_data rt.PhpVal = rt.new_bool(false)
		option_md5_data_source rt.PhpVal = rt.new_bool(false)
		option_sha1_data rt.PhpVal = rt.new_bool(false)
		option_max_2gb_check bool
		option_fread_buffer_size rt.PhpVal = rt.new_int(32768)
		options_archive_rar_use_php_rar_extension rt.PhpVal = rt.new_bool(true)
		options_archive_gzip_parse_contents rt.PhpVal = rt.new_bool(false)
		options_audio_midi_scanwholefile rt.PhpVal = rt.new_bool(true)
		options_audio_mp3_allow_bruteforce rt.PhpVal = rt.new_bool(false)
		options_audio_mp3_mp3_valid_check_frames rt.PhpVal = rt.new_int(50)
		options_audio_wavpack_quick_parsing rt.PhpVal = rt.new_bool(false)
		options_audiovideo_flv_max_frames rt.PhpVal = rt.new_int(100000)
		options_audiovideo_matroska_hide_clusters rt.PhpVal = rt.new_bool(true)
		options_audiovideo_matroska_parse_whole_file rt.PhpVal = rt.new_bool(false)
		options_audiovideo_quicktime_ReturnAtomData rt.PhpVal = rt.new_bool(false)
		options_audiovideo_quicktime_ParseAllPossibleAtoms rt.PhpVal = rt.new_bool(false)
		options_audiovideo_swf_ReturnAllTagData rt.PhpVal = rt.new_bool(false)
		options_graphic_bmp_ExtractPalette rt.PhpVal = rt.new_bool(false)
		options_graphic_bmp_ExtractData rt.PhpVal = rt.new_bool(false)
		options_graphic_png_max_data_bytes rt.PhpVal = rt.new_int(10000000)
		options_misc_pdf_returnXREF rt.PhpVal = rt.new_bool(false)
		options_misc_torrent_max_torrent_filesize rt.PhpVal = rt.new_int(1048576)
		filename rt.PhpVal = rt.new_null()
		fp rt.PhpVal = rt.new_null()
		info rt.PhpVal = rt.new_null()
		tempdir rt.PhpVal = rt.new_null()
		memory_limit rt.PhpVal = rt.new_int(0)
		startup_error rt.PhpVal = rt.new_string('')
		startup_warning rt.PhpVal = rt.new_string('')
}

fn (mut this Class_getID3) construct()  {
	mut var_matches := []rt.PhpVal{}
	mut var_dummy := rt.new_null()
	mut var_date := rt.new_null()
	mut var_time := rt.new_null()
	mut var_ampm := rt.new_null()
	mut var_filesize := rt.new_null()
	mut var_shortname := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_required_php_version := rt.new_string(rt.new_string('5.3.0'))
	if rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), var_required_php_version.dup(), rt.new_string('<')])) {
		// unsupported expression: Expr_AssignOp_Concat
		return
	}
	mut var_memoryLimit := rt.call_function('ini_get', [rt.new_string('memory_limit')])
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#([0-9]+) ?M#i'), var_memoryLimit.dup(), var_matches.dup()])) {
		var_memoryLimit = rt.mul(// unsupported expression: Expr_Cast_Int, rt.new_int(1048576))
	} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('#([0-9]+) ?G#i'), var_memoryLimit.dup(), var_matches.dup()])) {
		var_memoryLimit = rt.mul(// unsupported expression: Expr_Cast_Int, rt.new_int(1073741824))
	}
	this.memory_limit = var_memoryLimit.dup()
	if rt.is_true(rt.less_equal(this.memory_limit, rt.new_int(0))) {
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.less_equal(this.memory_limit, rt.new_int(4194304))) {
		// unsupported expression: Expr_AssignOp_Concat
	} else if rt.is_true(rt.less_equal(this.memory_limit, rt.new_int(12582912))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#(1|ON)#i'), rt.call_function('ini_get', [rt.new_string('safe_mode')])])) {
		this.warning(rt.new_string('WARNING: Safe mode is on, shorten support disabled, md5data/sha1data for ogg vorbis disabled, ogg vorbos/flac tag writing disabled.'))
	}
	if rt.is_true(rt.new_bool(rt.is_true(mut var_mbstring_func_overload := // unsupported expression: Expr_Cast_Int) && rt.is_true(rt.bitwise_and(var_mbstring_func_overload, rt.new_int(2))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), rt.new_string('5.4.0'), rt.new_string('<')])) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('get_magic_quotes_runtime')])) {
			if rt.is_true(rt.call_function('get_magic_quotes_runtime', []rt.PhpVal{})) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('get_magic_quotes_gpc')])) {
			if rt.is_true(rt.call_function('get_magic_quotes_gpc', []rt.PhpVal{})) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.include_file((rt.get_constant('GETID3_INCLUDEPATH')).str() + 'getid3.lib.php', '2'))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.identical(this.option_max_2gb_check, rt.new_null())) {
		this.option_max_2gb_check = rt.less_equal(rt.get_constant('PHP_INT_MAX'), rt.new_int(2147483647))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.get_constant('GETID3_OS_ISWINDOWS')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_HELPERAPPSDIR')]))))))) {
		mut var_helperappsdir := rt.new_string((rt.get_constant('GETID3_INCLUDEPATH')).str() + '..' + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + 'helperapps')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_helperappsdir.dup()]))))) {
			// unsupported expression: Expr_AssignOp_Concat
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_DirPieces := rt.call_function('explode', [rt.get_constant('DIRECTORY_SEPARATOR'), rt.call_function('realpath', [var_helperappsdir.dup()])])
			mut var_path_so_far := []rt.PhpVal{}
			{
				mut iter_1 := var_DirPieces.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_value := item_1.val
					mut var_key := item_1.key
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						if !(!rt.is_true(var_path_so_far)) {
							mut var_commandline := rt.new_string('dir /x ' + (rt.call_function('escapeshellarg', [rt.call_function('implode', [rt.get_constant('DIRECTORY_SEPARATOR'), var_path_so_far.dup()])])).str())
							mut var_dir_listing := rt.call_function('shell_exec', [var_commandline.dup()])
							mut var_lines := rt.call_function('explode', [rt.new_string('\n'), var_dir_listing.dup()])
							{
								mut iter_2 := var_lines.iterator()
								for {
									item_2 := iter_2.next() or { break }
									mut var_line := item_2.val
									var_line = rt.new_string(rt.new_string(var_line.dup().to_string().trim_space()))
									if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^([0-9/]{10}) +([0-9:]{4,5}( [AP]M)?) +(<DIR>|[0-9,]+) +([^ ]{0,11}) +(.+)$#'), var_line.dup(), var_matches.dup()])) {
										// unsupported assign target: Expr_List
										if rt.is_true(rt.new_bool(rt.is_true(rt.equal(rt.new_string(var_filesize.dup().to_string().to_upper()), rt.new_string('<DIR>'))) && rt.is_true(rt.equal(rt.new_string(var_filename.dup().to_string().to_lower()), rt.new_string(var_value.dup().to_string().to_lower()))))) {
											var_value = var_shortname
										}
									}
								}
							}
						} else {
							// unsupported expression: Expr_AssignOp_Concat
						}
					}
					var_path_so_far << var_value.dup()
				}
			}
			var_helperappsdir = rt.call_function('implode', [rt.get_constant('DIRECTORY_SEPARATOR'), var_path_so_far.dup()])
		}
		rt.call_function('define', [rt.new_string('GETID3_HELPERAPPSDIR'), rt.concat(var_helperappsdir, rt.get_constant('DIRECTORY_SEPARATOR'))])
	}
	if !(!rt.is_true(this.startup_error)) {
		rt.echo_val(this.startup_error)
		rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception(this.startup_error)))
	}
}

fn (mut this Class_getID3) version() string {
	return Class_getID3.version()
}

fn (mut this Class_getID3) fread_buffer_size() rt.PhpVal {
	return this.option_fread_buffer_size
}

fn (mut this Class_getID3) setoption(var_optArray rt.PhpVal) bool {
	if !rt.is_true(var_optArray) {
		return false
	}
	{
		mut iter_1 := var_optArray.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_val := item_1.val
			mut var_opt := item_1.key
			if rt.is_true(rt.identical(rt.new_bool(!(rt.get_property(rt.new_object('getID3', []string{}, &this), '{"nodeType":"Expr_Variable","line":536,"name":"opt"}')).is_null()), rt.new_bool(false))) {
				continue
			}
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":539,"name":"opt"}', var_val.dup())
		}
	}
	return true
}

fn (mut this Class_getID3) openfile(var_filename rt.PhpVal, var_filesize rt.PhpVal, var_fp rt.PhpVal) bool {
	mut var_filename_mutated := var_filename
	if !(!rt.is_true(this.startup_error)) {
		rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception(this.startup_error)))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(!rt.is_true(this.startup_warning)) {
		{
			mut iter_1 := rt.call_function('explode', [rt.new_string('\n'), this.startup_warning]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_startup_warning := item_1.val
				this.warning(var_startup_warning.dup())
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.filename = var_filename_mutated.dup()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info = []rt.PhpVal{}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('GETID3_VERSION', this.version())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('php_memory_limit', if rt.is_true(rt.greater(this.memory_limit, rt.new_int(0))) { this.memory_limit } else { rt.new_bool(false) })
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^(ht|f)tps?://#'), var_filename_mutated.dup()])) {
		rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception(rt.new_string('Remote files are not supported - please copy the file locally first'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_filename_mutated = rt.call_function('str_replace', [rt.new_string('/'), rt.get_constant('DIRECTORY_SEPARATOR'), var_filename_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) && rt.is_true(rt.new_bool(rt.is_true(rt.equal(rt.call_function('get_resource_type', [var_fp.dup()]), rt.new_string('file'))) || rt.is_true(rt.equal(rt.call_function('get_resource_type', [var_fp.dup()]), rt.new_string('stream'))))))) {
		this.fp = var_fp.dup()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_readable', [var_filename_mutated.dup()])) || rt.is_true(rt.call_function('file_exists', [var_filename_mutated.dup()])))) && rt.is_true(rt.call_function('is_file', [var_filename_mutated.dup()])))) && rt.is_true(this.fp = rt.call_function('fopen', [var_filename_mutated.dup(), rt.new_string('rb')])))) {
		// unsupported statement: Stmt_Nop
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		mut var_errormessagelist := []rt.PhpVal{}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [var_filename_mutated.dup()]))))) {
			var_errormessagelist.array_push('!is_readable')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [var_filename_mutated.dup()]))))) {
			var_errormessagelist.array_push('!is_file')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_filename_mutated.dup()]))))) {
			var_errormessagelist.array_push('!file_exists')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if !rt.is_true(var_errormessagelist) {
			var_errormessagelist.array_push('fopen failed')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception('Could not open "' + (var_filename_mutated).str() + '" (' + (rt.call_function('implode', [rt.new_string('; '), var_errormessagelist.dup()])).str() + ')')))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('filesize', if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_filesize.dup().is_null()))))) { var_filesize } else { rt.call_function('filesize', [var_filename_mutated.dup()]) })
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_filename_mutated = rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_filename_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('filepath', rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.call_function('realpath', [rt.call_function('dirname', [var_filename_mutated.dup()])])]))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('filename', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.mb_basename(arg_0) }(var_filename_mutated.dup()))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('filenamepath', (this.info.array_get('filepath')).str() + '/' + (this.info.array_get('filename')).str())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('avdataoffset', 0)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('avdataend', this.info.array_get('filesize'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('fileformat', '')
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_get_mut('audio').array_set('dataformat', '')
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_get_mut('video').array_set('dataformat', '')
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('tags', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('error', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('warning', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('comments', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('encoding', this.encoding)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(this.option_max_2gb_check) {
		
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return 
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn (mut this Class_getID3) analyze(var_filename rt.PhpVal, var_filesize rt.PhpVal, original_filename string, var_fp rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_dummy := rt.new_null()
	mut var_GOVmodule := rt.new_null()
	mut var_GOVsetting := rt.new_null()
	mut var_filename_mutated := var_filename
}

fn (mut this Class_getID3) error(var_message rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_getID3) warning(var_message rt.PhpVal) bool {
}

fn (mut this Class_getID3) cleanup() bool {
}

fn (mut this Class_getID3) getfileformatarray() rt.PhpVal {
}

fn (mut this Class_getID3) getfileformat(var_filedata rt.PhpVal, filename string) rt.PhpVal {
	mut filename_mutated := filename
}

fn (mut this Class_getID3) charconvert(var_array rt.PhpVal, var_encoding rt.PhpVal)  {
	mut var_array_mutated := var_array
}

fn (mut this Class_getID3) handlealltags() bool {
	mut var_tag_name := rt.new_null()
	mut var_encoding := rt.new_null()
}

fn (mut this Class_getID3) copytagstocomments(var_ThisFileInfo rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_getID3) gethashdata(var_algorithm rt.PhpVal) bool {
}

fn (mut this Class_getID3) channelsbitrateplaytimecalculations()  {
}

fn (mut this Class_getID3) calculatecompressionratiovideo() bool {
}

fn (mut this Class_getID3) calculatecompressionratioaudio() bool {
}

fn (mut this Class_getID3) calculatereplaygain() bool {
}

fn (mut this Class_getID3) processaudiostreams() bool {
}

fn (mut this Class_getID3) getid3_tempnam() rt.PhpVal {
}

fn (mut this Class_getID3) include_module(var_name rt.PhpVal) bool {
}

fn Class_getID3.is_writable(var_filename rt.PhpVal) rt.PhpVal {
	mut var_filename_mutated := var_filename
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_getid3_exception {
	rt.PhpObjectBase
}

struct Class_getid3_lib {
	rt.PhpObjectBase
}

fn create_getid3() &Class_getID3 {
	mut obj := &Class_getID3{
		PhpObjectBase: rt.PhpObjectBase{}
		encoding: rt.new_string('UTF-8')
		encoding_id3v1: rt.new_string('ISO-8859-1')
		encoding_id3v1_autodetect: rt.new_bool(false)
		option_tag_id3v1: rt.new_bool(true)
		option_tag_id3v2: rt.new_bool(true)
		option_tag_lyrics3: rt.new_bool(true)
		option_tag_apetag: rt.new_bool(true)
		option_tags_process: rt.new_bool(true)
		option_tags_html: rt.new_bool(true)
		option_extra_info: rt.new_bool(true)
		option_save_attachments: rt.new_bool(true)
		option_md5_data: rt.new_bool(false)
		option_md5_data_source: rt.new_bool(false)
		option_sha1_data: rt.new_bool(false)
		option_max_2gb_check: false
		option_fread_buffer_size: rt.new_int(32768)
		options_archive_rar_use_php_rar_extension: rt.new_bool(true)
		options_archive_gzip_parse_contents: rt.new_bool(false)
		options_audio_midi_scanwholefile: rt.new_bool(true)
		options_audio_mp3_allow_bruteforce: rt.new_bool(false)
		options_audio_mp3_mp3_valid_check_frames: rt.new_int(50)
		options_audio_wavpack_quick_parsing: rt.new_bool(false)
		options_audiovideo_flv_max_frames: rt.new_int(100000)
		options_audiovideo_matroska_hide_clusters: rt.new_bool(true)
		options_audiovideo_matroska_parse_whole_file: rt.new_bool(false)
		options_audiovideo_quicktime_ReturnAtomData: rt.new_bool(false)
		options_audiovideo_quicktime_ParseAllPossibleAtoms: rt.new_bool(false)
		options_audiovideo_swf_ReturnAllTagData: rt.new_bool(false)
		options_graphic_bmp_ExtractPalette: rt.new_bool(false)
		options_graphic_bmp_ExtractData: rt.new_bool(false)
		options_graphic_png_max_data_bytes: rt.new_int(10000000)
		options_misc_pdf_returnXREF: rt.new_bool(false)
		options_misc_torrent_max_torrent_filesize: rt.new_int(1048576)
		filename: rt.new_null()
		fp: rt.new_null()
		info: rt.new_null()
		tempdir: rt.new_null()
		memory_limit: rt.new_int(0)
		startup_error: rt.new_string('')
		startup_warning: rt.new_string('')
	}
	obj.construct()
	return obj
}

fn create_getid3_handler() &Class_getid3_handler {
	mut obj := &Class_getid3_handler{
		PhpObjectBase: rt.PhpObjectBase{}
		getid3: rt.new_null()
		data_string_flag: rt.new_bool(false)
		data_string: rt.new_string('')
		data_string_position: rt.new_int(0)
		data_string_length: rt.new_int(0)
		dependency_to: rt.new_null()
	}
	return obj
}

fn create_getid3_exception() &Class_getid3_exception {
	mut obj := &Class_getid3_exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_getid3_lib() &Class_getid3_lib {
	mut obj := &Class_getid3_lib{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_getID3) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'version' {
			return rt.new_string(this.version())
		}
		'fread_buffer_size' {
			return this.fread_buffer_size()
		}
		'setOption' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.setoption(dispatch_arg_0))
		}
		'openfile' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.openfile(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'analyze' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.analyze(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.error(dispatch_arg_0)
		}
		'warning' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.warning(dispatch_arg_0))
		}
		'CleanUp' {
			return rt.new_bool(this.cleanup())
		}
		'GetFileFormatArray' {
			return this.getfileformatarray()
		}
		'GetFileFormat' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.getfileformat(dispatch_arg_0, dispatch_arg_1)
		}
		'CharConvert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.charconvert(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'HandleAllTags' {
			return rt.new_bool(this.handlealltags())
		}
		'CopyTagsToComments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.copytagstocomments(dispatch_arg_0)
		}
		'getHashdata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.gethashdata(dispatch_arg_0))
		}
		'ChannelsBitratePlaytimeCalculations' {
			this.channelsbitrateplaytimecalculations()
			return rt.new_null()
		}
		'CalculateCompressionRatioVideo' {
			return rt.new_bool(this.calculatecompressionratiovideo())
		}
		'CalculateCompressionRatioAudio' {
			return rt.new_bool(this.calculatecompressionratioaudio())
		}
		'CalculateReplayGain' {
			return rt.new_bool(this.calculatereplaygain())
		}
		'ProcessAudioStreams' {
			return rt.new_bool(this.processaudiostreams())
		}
		'getid3_tempnam' {
			return this.getid3_tempnam()
		}
		'include_module' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.include_module(dispatch_arg_0))
		}
		'is_writable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getID3.is_writable(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_getID3) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'encoding' { return this.encoding }
		'encoding_id3v1' { return this.encoding_id3v1 }
		'encoding_id3v1_autodetect' { return this.encoding_id3v1_autodetect }
		'option_tag_id3v1' { return this.option_tag_id3v1 }
		'option_tag_id3v2' { return this.option_tag_id3v2 }
		'option_tag_lyrics3' { return this.option_tag_lyrics3 }
		'option_tag_apetag' { return this.option_tag_apetag }
		'option_tags_process' { return this.option_tags_process }
		'option_tags_html' { return this.option_tags_html }
		'option_extra_info' { return this.option_extra_info }
		'option_save_attachments' { return this.option_save_attachments }
		'option_md5_data' { return this.option_md5_data }
		'option_md5_data_source' { return this.option_md5_data_source }
		'option_sha1_data' { return this.option_sha1_data }
		'option_max_2gb_check' { return rt.new_bool(this.option_max_2gb_check) }
		'option_fread_buffer_size' { return this.option_fread_buffer_size }
		'options_archive_rar_use_php_rar_extension' { return this.options_archive_rar_use_php_rar_extension }
		'options_archive_gzip_parse_contents' { return this.options_archive_gzip_parse_contents }
		'options_audio_midi_scanwholefile' { return this.options_audio_midi_scanwholefile }
		'options_audio_mp3_allow_bruteforce' { return this.options_audio_mp3_allow_bruteforce }
		'options_audio_mp3_mp3_valid_check_frames' { return this.options_audio_mp3_mp3_valid_check_frames }
		'options_audio_wavpack_quick_parsing' { return this.options_audio_wavpack_quick_parsing }
		'options_audiovideo_flv_max_frames' { return this.options_audiovideo_flv_max_frames }
		'options_audiovideo_matroska_hide_clusters' { return this.options_audiovideo_matroska_hide_clusters }
		'options_audiovideo_matroska_parse_whole_file' { return this.options_audiovideo_matroska_parse_whole_file }
		'options_audiovideo_quicktime_ReturnAtomData' { return this.options_audiovideo_quicktime_ReturnAtomData }
		'options_audiovideo_quicktime_ParseAllPossibleAtoms' { return this.options_audiovideo_quicktime_ParseAllPossibleAtoms }
		'options_audiovideo_swf_ReturnAllTagData' { return this.options_audiovideo_swf_ReturnAllTagData }
		'options_graphic_bmp_ExtractPalette' { return this.options_graphic_bmp_ExtractPalette }
		'options_graphic_bmp_ExtractData' { return this.options_graphic_bmp_ExtractData }
		'options_graphic_png_max_data_bytes' { return this.options_graphic_png_max_data_bytes }
		'options_misc_pdf_returnXREF' { return this.options_misc_pdf_returnXREF }
		'options_misc_torrent_max_torrent_filesize' { return this.options_misc_torrent_max_torrent_filesize }
		'filename' { return this.filename }
		'fp' { return this.fp }
		'info' { return this.info }
		'tempdir' { return this.tempdir }
		'memory_limit' { return this.memory_limit }
		'startup_error' { return this.startup_error }
		'startup_warning' { return this.startup_warning }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_getID3) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'encoding' { this.encoding = val; return true }
		'encoding_id3v1' { this.encoding_id3v1 = val; return true }
		'encoding_id3v1_autodetect' { this.encoding_id3v1_autodetect = val; return true }
		'option_tag_id3v1' { this.option_tag_id3v1 = val; return true }
		'option_tag_id3v2' { this.option_tag_id3v2 = val; return true }
		'option_tag_lyrics3' { this.option_tag_lyrics3 = val; return true }
		'option_tag_apetag' { this.option_tag_apetag = val; return true }
		'option_tags_process' { this.option_tags_process = val; return true }
		'option_tags_html' { this.option_tags_html = val; return true }
		'option_extra_info' { this.option_extra_info = val; return true }
		'option_save_attachments' { this.option_save_attachments = val; return true }
		'option_md5_data' { this.option_md5_data = val; return true }
		'option_md5_data_source' { this.option_md5_data_source = val; return true }
		'option_sha1_data' { this.option_sha1_data = val; return true }
		'option_max_2gb_check' { this.option_max_2gb_check = (val).to_bool(); return true }
		'option_fread_buffer_size' { this.option_fread_buffer_size = val; return true }
		'options_archive_rar_use_php_rar_extension' { this.options_archive_rar_use_php_rar_extension = val; return true }
		'options_archive_gzip_parse_contents' { this.options_archive_gzip_parse_contents = val; return true }
		'options_audio_midi_scanwholefile' { this.options_audio_midi_scanwholefile = val; return true }
		'options_audio_mp3_allow_bruteforce' { this.options_audio_mp3_allow_bruteforce = val; return true }
		'options_audio_mp3_mp3_valid_check_frames' { this.options_audio_mp3_mp3_valid_check_frames = val; return true }
		'options_audio_wavpack_quick_parsing' { this.options_audio_wavpack_quick_parsing = val; return true }
		'options_audiovideo_flv_max_frames' { this.options_audiovideo_flv_max_frames = val; return true }
		'options_audiovideo_matroska_hide_clusters' { this.options_audiovideo_matroska_hide_clusters = val; return true }
		'options_audiovideo_matroska_parse_whole_file' { this.options_audiovideo_matroska_parse_whole_file = val; return true }
		'options_audiovideo_quicktime_ReturnAtomData' { this.options_audiovideo_quicktime_ReturnAtomData = val; return true }
		'options_audiovideo_quicktime_ParseAllPossibleAtoms' { this.options_audiovideo_quicktime_ParseAllPossibleAtoms = val; return true }
		'options_audiovideo_swf_ReturnAllTagData' { this.options_audiovideo_swf_ReturnAllTagData = val; return true }
		'options_graphic_bmp_ExtractPalette' { this.options_graphic_bmp_ExtractPalette = val; return true }
		'options_graphic_bmp_ExtractData' { this.options_graphic_bmp_ExtractData = val; return true }
		'options_graphic_png_max_data_bytes' { this.options_graphic_png_max_data_bytes = val; return true }
		'options_misc_pdf_returnXREF' { this.options_misc_pdf_returnXREF = val; return true }
		'options_misc_torrent_max_torrent_filesize' { this.options_misc_torrent_max_torrent_filesize = val; return true }
		'filename' { this.filename = val; return true }
		'fp' { this.fp = val; return true }
		'info' { this.info = val; return true }
		'tempdir' { this.tempdir = val; return true }
		'memory_limit' { this.memory_limit = val; return true }
		'startup_error' { this.startup_error = val; return true }
		'startup_warning' { this.startup_warning = val; return true }
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


fn (mut this Class_getid3_exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_getid3_exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_getid3_exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn init_registry() {
	rt.register_class_factory('getID3', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_getid3()
		return rt.new_object('getID3', []string{}, obj)
	})
	rt.register_class_factory('getid3_handler', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_getid3_handler()
		return rt.new_object('getid3_handler', []string{}, obj)
	})
	rt.register_class_factory('getid3_exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_getid3_exception()
		return rt.new_object('getid3_exception', ['Exception'], obj)
	})
	rt.register_class_factory('Exception', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
	rt.register_class_factory('getid3_lib', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_getid3_lib()
		return rt.new_object('getid3_lib', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_id3_getid3_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_OS_ISWINDOWS')]))))) {
		rt.call_function('define', [rt.new_string('GETID3_OS_ISWINDOWS'), rt.identical(rt.call_function('stripos', [rt.get_constant('PHP_OS'), rt.new_string('WIN')]), rt.new_int(0))])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_INCLUDEPATH')]))))) {
		rt.call_function('define', [rt.new_string('GETID3_INCLUDEPATH'), rt.concat(rt.call_function('dirname', [rt.new_string(@FILE)]), rt.get_constant('DIRECTORY_SEPARATOR'))])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ENT_SUBSTITUTE')]))))) {
		rt.call_function('define', [rt.new_string('ENT_SUBSTITUTE'), if rt.is_true(rt.call_function('defined', [rt.new_string('ENT_IGNORE')])) { rt.get_constant('ENT_IGNORE') } else { rt.new_int(8) }])
	}
	mut var_temp_dir := rt.call_function('ini_get', [rt.new_string('upload_tmp_dir')])
	if rt.is_true(rt.new_bool(rt.is_true(var_temp_dir) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_temp_dir.dup()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [var_temp_dir.dup()]))))))))) {
		var_temp_dir = rt.new_string(rt.new_string(''))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_temp_dir)))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('sys_get_temp_dir')])))) {
		var_temp_dir = rt.call_function('sys_get_temp_dir', []rt.PhpVal{})
	}
	var_temp_dir = rt.call_function('realpath', [var_temp_dir.dup()])
	mut var_open_basedir := rt.call_function('ini_get', [rt.new_string('open_basedir')])
	if rt.is_true(var_open_basedir) {
		var_temp_dir = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '/' }, rt.ArrayItem{ key: none, val: '\\' }]), rt.get_constant('DIRECTORY_SEPARATOR'), var_temp_dir.dup()])
		var_open_basedir = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '/' }, rt.ArrayItem{ key: none, val: '\\' }]), rt.get_constant('DIRECTORY_SEPARATOR'), var_open_basedir.dup()])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		mut var_found_valid_tempdir := false
		mut var_open_basedirs := rt.call_function('explode', [rt.get_constant('PATH_SEPARATOR'), var_open_basedir.dup()])
		{
			mut iter_1 := var_open_basedirs.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_basedir := item_1.val
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				if rt.is_true(rt.identical(rt.call_function('strpos', [var_temp_dir.dup(), var_basedir.dup()]), rt.new_int(0))) {
					var_found_valid_tempdir = true
					break
				}
			}
		}
		if !(var_found_valid_tempdir) {
			var_temp_dir = rt.new_string(rt.new_string(''))
		}
		var_open_basedirs = rt.new_null()
		var_found_valid_tempdir = false
		var_basedir = rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_temp_dir)))) {
		var_temp_dir = rt.new_string(rt.new_string('*'))
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_TEMP_DIR')]))))) {
		rt.call_function('define', [rt.new_string('GETID3_TEMP_DIR'), var_temp_dir.dup()])
	}
	var_open_basedir = rt.new_null()
	var_temp_dir = rt.new_null()
}

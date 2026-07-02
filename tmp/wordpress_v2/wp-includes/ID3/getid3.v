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

fn (mut this Class_getID3) construct() {
	mut var_matches := []rt.PhpVal{}
	mut var_dummy := rt.new_null()
	mut var_date := rt.new_null()
	mut var_time := rt.new_null()
	mut var_ampm := rt.new_null()
	mut var_filesize := rt.new_null()
	mut var_shortname := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_required_php_version := rt.new_string('5.3.0')
	if rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), var_required_php_version.clone(), rt.new_string('<')])) {
		this.startup_error = rt.concat(this.startup_error, rt.new_string('getID3() requires PHP v' + (var_required_php_version).str() + ' or higher - you are running v' + (rt.get_constant('PHP_VERSION')).str() + '\n'))
		return
	}
	mut var_memoryLimit := rt.call_function('ini_get', [rt.new_string('memory_limit')])
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#([0-9]+) ?M#i'), var_memoryLimit.clone(), rt.create_array_from_list(var_matches)])) {
	var_memoryLimit = rt.new_int((var_matches.array_get(rt.new_int(1))).to_i64()) * 1048576
	} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('#([0-9]+) ?G#i'), var_memoryLimit.clone(), rt.create_array_from_list(var_matches)])) {
	var_memoryLimit = rt.new_int((var_matches.array_get(rt.new_int(1))).to_i64()) * 1073741824
	}
	this.memory_limit = var_memoryLimit.clone()
	if rt.is_true(rt.less_equal(this.memory_limit, rt.new_int(0))) {
	} else if rt.is_true(rt.less_equal(this.memory_limit, rt.new_int(4194304))) {
		this.startup_error = rt.concat(this.startup_error, rt.new_string('PHP has less than 4MB available memory and will very likely run out. Increase memory_limit in php.ini' + '\n'))
	} else if rt.is_true(rt.less_equal(this.memory_limit, rt.new_int(12582912))) {
		this.startup_warning = rt.concat(this.startup_warning, rt.new_string('PHP has less than 12MB available memory and might run out if all modules are loaded. Increase memory_limit in php.ini' + '\n'))
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#(1|ON)#i'), rt.call_function('ini_get', [rt.new_string('safe_mode')])])) {
		this.warning(rt.new_string('WARNING: Safe mode is on, shorten support disabled, md5data/sha1data for ogg vorbis disabled, ogg vorbos/flac tag writing disabled.'))
	}
	mut var_mbstring_func_overload := rt.new_int((rt.call_function('ini_get', [rt.new_string('mbstring.func_overload')])).to_i64())
	if rt.is_true(var_mbstring_func_overload) && rt.is_true(rt.bitwise_and(var_mbstring_func_overload, rt.new_int(2))) {
		this.startup_error = rt.concat(this.startup_error, rt.new_string('WARNING: php.ini contains "mbstring.func_overload = ' + (rt.call_function('ini_get', [rt.new_string('mbstring.func_overload')])).str() + '", getID3 cannot run with this setting (bitmask 2 (string functions) cannot be set). Recommended to disable entirely.' + '\n'))
	}
	if rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), rt.new_string('5.4.0'), rt.new_string('<')])) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('get_magic_quotes_runtime')])) {
			if rt.is_true(rt.call_function('get_magic_quotes_runtime', []rt.PhpVal{})) {
				this.startup_error = rt.concat(this.startup_error, rt.new_string('magic_quotes_runtime must be disabled before running getID3(). Surround getid3 block by set_magic_quotes_runtime(0) and set_magic_quotes_runtime(1).' + '\n'))
			}
		}
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('get_magic_quotes_gpc')])) {
			if rt.is_true(rt.call_function('get_magic_quotes_gpc', []rt.PhpVal{})) {
				this.startup_error = rt.concat(this.startup_error, rt.new_string('magic_quotes_gpc must be disabled before running getID3(). Surround getid3 block by set_magic_quotes_gpc(0) and set_magic_quotes_gpc(1).' + '\n'))
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.include_file((rt.get_constant('GETID3_INCLUDEPATH')).str() + 'getid3.lib.php', '2'))))) {
		this.startup_error = rt.concat(this.startup_error, rt.new_string('getid3.lib.php is missing or corrupt' + '\n'))
	}
	if rt.is_true(rt.identical(this.option_max_2gb_check, rt.new_null())) {
		this.option_max_2gb_check = rt.less_equal(rt.get_constant('PHP_INT_MAX'), rt.new_int(2147483647))
	}
	if rt.is_true(rt.get_constant('GETID3_OS_ISWINDOWS')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_HELPERAPPSDIR')]))))) {
		mut var_helperappsdir := rt.new_string((rt.get_constant('GETID3_INCLUDEPATH')).str() + '..' + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + 'helperapps')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_helperappsdir.clone()]))))) {
			this.startup_warning = rt.concat(this.startup_warning, rt.new_string('"' + (var_helperappsdir).str() + '" cannot be defined as GETID3_HELPERAPPSDIR because it does not exist' + '\n'))
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.call_function('realpath', [var_helperappsdir.clone()]), rt.new_string(' ')]), rt.new_bool(false))))) {
			mut var_DirPieces := rt.call_function('explode', [rt.get_constant('DIRECTORY_SEPARATOR'), rt.call_function('realpath', [var_helperappsdir.clone()])])
			mut var_path_so_far := []rt.PhpVal{}
			mut iter_2 := var_DirPieces.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_value := item_2.val
				mut var_key := item_2.key
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_value.clone(), rt.new_string(' ')]), rt.new_bool(false))))) {
					if !(!rt.is_true(var_path_so_far)) {
						mut var_commandline := rt.new_string('dir /x ' + (rt.call_function('escapeshellarg', [rt.call_function('implode', [rt.get_constant('DIRECTORY_SEPARATOR'), rt.create_array_from_list(var_path_so_far)])])).str())
						mut var_dir_listing := rt.call_function('shell_exec', [var_commandline.clone()])
						mut var_lines := rt.call_function('explode', [rt.new_string('\n'), var_dir_listing.clone()])
						mut iter_3 := var_lines.iterator()
						for {
							item_3 := iter_3.next() or { break }
							mut var_line := item_3.val
							var_line = rt.new_string(var_line.clone().to_string().trim_space())
							if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^([0-9/]{10}) +([0-9:]{4,5}( [AP]M)?) +(<DIR>|[0-9,]+) +([^ ]{0,11}) +(.+)$#'), var_line.clone(), rt.create_array_from_list(var_matches)])) {
								mut list_tmp_1 := var_matches
								var_dummy = (list_tmp_1).array_get(0)
								var_date = (list_tmp_1).array_get(1)
								var_time = (list_tmp_1).array_get(2)
								var_ampm = (list_tmp_1).array_get(3)
								var_filesize = (list_tmp_1).array_get(4)
								var_shortname = (list_tmp_1).array_get(5)
								var_filename = (list_tmp_1).array_get(6)
								if rt.is_true(rt.equal(rt.new_string(var_filesize.clone().to_string().to_upper()), rt.new_string('<DIR>'))) && rt.is_true(rt.equal(rt.new_string(var_filename.clone().to_string().to_lower()), rt.new_string(var_value.clone().to_string().to_lower()))) {
								var_value = var_shortname
								}
							}
						}
					} else {
						this.startup_warning = rt.concat(this.startup_warning, rt.new_string('GETID3_HELPERAPPSDIR must not have any spaces in it - use 8dot3 naming convention if neccesary. You can run "dir /x" from the commandline to see the correct 8.3-style names.' + '\n'))
					}
				}
				var_path_so_far << var_value.clone()
			}
		var_helperappsdir = rt.call_function('implode', [rt.get_constant('DIRECTORY_SEPARATOR'), rt.create_array_from_list(var_path_so_far)])
		}
		rt.call_function('define', [rt.new_string('GETID3_HELPERAPPSDIR'), rt.new_string((var_helperappsdir).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str())])
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
	mut iter_4 := var_optArray.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_val := item_4.val
		mut var_opt := item_4.key
		if rt.is_true(rt.identical(rt.new_bool(!(rt.get_property(rt.new_object('getID3', []string{}, &this), '{"nodeType":"Expr_Variable","line":536,"name":"opt"}')).is_null()), rt.new_bool(false))) {
			continue
		}
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":539,"name":"opt"}', var_val.clone())
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
		mut iter_5 := rt.call_function('explode', [rt.new_string('\n'), this.startup_warning]).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_startup_warning := item_5.val
			this.warning(var_startup_warning.clone())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.filename = var_filename_mutated.clone()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info = []rt.PhpVal{}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('GETID3_VERSION', this.version())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('php_memory_limit', if rt.is_true(rt.greater(this.memory_limit, rt.new_int(0))) { this.memory_limit } else { rt.new_bool(false) })
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^(ht|f)tps?://#'), var_filename_mutated.clone()])) {
		rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception(rt.new_string('Remote files are not supported - please copy the file locally first'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_filename_mutated = rt.call_function('str_replace', [rt.new_string('/'), rt.get_constant('DIRECTORY_SEPARATOR'), var_filename_mutated.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_fp, rt.new_null())))) && rt.is_true(rt.equal(rt.call_function('get_resource_type', [var_fp.clone()]), rt.new_string('file'))) || rt.is_true(rt.equal(rt.call_function('get_resource_type', [var_fp.clone()]), rt.new_string('stream'))) {
		this.fp = var_fp.clone()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else if rt.is_true(rt.call_function('is_readable', [var_filename_mutated.clone()])) || rt.is_true(rt.call_function('file_exists', [var_filename_mutated.clone()])) && rt.is_true(rt.call_function('is_file', [var_filename_mutated.clone()])) && rt.is_true(this.fp = rt.call_function('fopen', [var_filename_mutated.clone(), rt.new_string('rb')])) {
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		mut var_errormessagelist := []rt.PhpVal{}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [var_filename_mutated.clone()]))))) {
			var_errormessagelist.array_push('!is_readable')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [var_filename_mutated.clone()]))))) {
			var_errormessagelist.array_push('!is_file')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_filename_mutated.clone()]))))) {
			var_errormessagelist.array_push('!file_exists')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if !rt.is_true(var_errormessagelist) {
			var_errormessagelist.array_push('fopen failed')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception('Could not open "' + (var_filename_mutated).str() + '" (' + (rt.call_function('implode', [rt.new_string('; '), var_errormessagelist.clone()])).str() + ')')))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('filesize', if !(var_filesize.clone().is_null()) { var_filesize } else { rt.call_function('filesize', [var_filename_mutated.clone()]) })
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_filename_mutated = rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_filename_mutated.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('filepath', rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.call_function('realpath', [rt.call_function('dirname', [var_filename_mutated.clone()])])]))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut iife_temp_0 := Class_getid3_lib{}
	mut iife_result_0 := iife_temp_0.mb_basename(var_filename_mutated.clone())
	this.info.array_set('filename', iife_result_0)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('filenamepath', (this.info.array_get(rt.new_string('filepath'))).str() + '/' + (this.info.array_get(rt.new_string('filename'))).str())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('avdataoffset', 0)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.info.array_set('avdataend', this.info.array_get(rt.new_string('filesize')))
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
	if this.option_max_2gb_check {
		mut var_fseek := rt.call_function('fseek', [this.fp, rt.new_int(0), rt.get_constant('SEEK_END')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if ((rt.is_true(rt.less(var_fseek, rt.new_int(0))) || (rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this.info.array_get(rt.new_string('filesize')), rt.new_int(0))))) && rt.is_true(rt.equal(rt.call_function('ftell', [this.fp]), rt.new_int(0))))) || rt.is_true(rt.less(this.info.array_get(rt.new_string('filesize')), rt.new_int(0)))) || rt.is_true(rt.less(rt.call_function('ftell', [this.fp]), rt.new_int(0))) {
			mut iife_temp_1 := Class_getid3_lib{}
			mut iife_result_1 := iife_temp_1.getfilesizesyscall(this.info.array_get(rt.new_string('filenamepath')))
			mut var_real_filesize := iife_result_1
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.identical(var_real_filesize, rt.new_bool(false))) {
				this.info.array_unset(rt.new_string('filesize'))
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				rt.call_function('fclose', [this.fp])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception('Unable to determine actual filesize. File is most likely larger than ' + (rt.call_function('round', [rt.div(rt.get_constant('PHP_INT_MAX'), rt.new_int(1073741824))])).str() + 'GB and is not supported by PHP.')))
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut iife_temp_2 := Class_getid3_lib{}
			mut iife_result_2 := iife_temp_2.intvaluesupported(var_real_filesize.clone())
			} else if rt.is_true(iife_result_2) {
				this.info.array_unset(rt.new_string('filesize'))
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				rt.call_function('fclose', [this.fp])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception('PHP seems to think the file is larger than ' + (rt.call_function('round', [rt.div(rt.get_constant('PHP_INT_MAX'), rt.new_int(1073741824))])).str() + 'GB, but filesystem reports it as ' + (rt.call_function('number_format', [rt.div(var_real_filesize, rt.new_int(1073741824)), rt.new_int(3)])).str() + 'GB, please report to info@getid3.org')))
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			this.info.array_set('filesize', var_real_filesize.clone())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			this.warning(rt.new_string('File is larger than ' + (rt.call_function('round', [rt.div(rt.get_constant('PHP_INT_MAX'), rt.new_int(1073741824))])).str() + 'GB (filesystem reports it as ' + (rt.call_function('number_format', [rt.div(var_real_filesize, rt.new_int(1073741824)), rt.new_int(3)])).str() + 'GB) and is not properly supported by PHP.'))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return true
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		this.error(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return false
}

fn (mut this Class_getID3) analyze(var_filename rt.PhpVal, var_filesize rt.PhpVal, original_filename string, var_fp rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_dummy := rt.new_null()
	mut var_GOVmodule := rt.new_null()
	mut var_GOVsetting := rt.new_null()
	mut var_filename_mutated := var_filename
	if !(this.openfile(var_filename_mutated.clone(), var_filesize.clone(), var_fp.clone())) {
		return this.info
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut iter_6 := rt.create_array([rt.ArrayItem{ key: 'id3v2', val: 'id3v2' }, rt.ArrayItem{ key: 'id3v1', val: 'id3v1' }, rt.ArrayItem{ key: 'apetag', val: 'ape' }, rt.ArrayItem{ key: 'lyrics3', val: 'lyrics3' }]).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_tag_key := item_6.val
		mut var_tag_name := item_6.key
		mut var_option_tag := rt.new_string('option_tag_' + (var_tag_name).str())
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.get_property(rt.new_object('getID3', []string{}, &this), '{"nodeType":"Expr_Variable","line":673,"name":"option_tag"}')) {
			this.include_module(rt.new_string('tag.' + (var_tag_name).str()))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			mut var_tag_class := rt.new_string('getid3_' + (var_tag_name).str())
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			mut var_tag := rt.create_object_dynamically(var_tag_class, [rt.new_object('getID3', []string{}, &this)])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			rt.call_method(var_tag, 'Analyze', []rt.PhpVal{})
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			unsafe { goto end_label_3 }

catch_label_3:
			mut var_e_3 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_3, 'getid3_exception') {
				mut var_e := var_e_3.clone()
				rt.throw_exception(var_e)
				if rt.has_exception() { unsafe { goto catch_label_2 } }
				unsafe { goto end_label_3 }
			}
			else {
				rt.throw_exception(var_e_3)
				unsafe { goto end_label_3 }
			}

end_label_3:
		} else {
			this.warning(rt.new_string('skipping check for ' + (var_tag_name).str() + ' tags since option_tag_' + (var_tag_name).str() + '=FALSE'))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if this.info.array_get(rt.new_string('id3v2')).array_isset(rt.new_string('tag_offset_start')) {
		this.info.array_set('avdataoffset', rt.call_function('max', [this.info.array_get(rt.new_string('avdataoffset')), this.info.array_get(rt.new_string('id3v2')).array_get(rt.new_string('tag_offset_end'))]))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut iter_7 := rt.create_array([rt.ArrayItem{ key: 'id3v1', val: 'id3v1' }, rt.ArrayItem{ key: 'apetag', val: 'ape' }, rt.ArrayItem{ key: 'lyrics3', val: 'lyrics3' }]).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_tag_key := item_7.val
		mut var_tag_name := item_7.key
		if this.info.array_get(var_tag_key).array_isset(rt.new_string('tag_offset_start')) {
			this.info.array_set('avdataend', rt.call_function('min', [this.info.array_get(rt.new_string('avdataend')), this.info.array_get(var_tag_key).array_get(rt.new_string('tag_offset_start'))]))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(this.option_tag_id3v2)))) {
		rt.call_function('fseek', [this.fp, rt.new_int(0)])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		mut var_header := rt.call_function('fread', [this.fp, rt.new_int(10)])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.equal(rt.call_function('substr', [var_header.clone(), rt.new_int(0), rt.new_int(3)]), rt.new_string('ID3'))) && var_header.clone().to_string().len == 10 {
			this.info.array_get_mut('id3v2').array_set('header', true)
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			this.info.array_get_mut('id3v2').array_set('majorversion', rt.call_function('ord', [var_header.array_get(rt.new_int(3))]))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			this.info.array_get_mut('id3v2').array_set('minorversion', rt.call_function('ord', [var_header.array_get(rt.new_int(4))]))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			mut iife_temp_3 := Class_getid3_lib{}
			mut iife_result_3 := iife_temp_3.bigendian2int(rt.call_function('substr', [var_header.clone(), rt.new_int(6), rt.new_int(4)]), rt.new_int(1))
			this.info.array_get(rt.new_string('avdataoffset')) = rt.add(this.info.array_get(rt.new_string('avdataoffset')), rt.add(iife_result_3, rt.new_int(10)))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('fseek', [this.fp, this.info.array_get(rt.new_string('avdataoffset'))])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_formattest := rt.call_function('fread', [this.fp, rt.new_int(32774)])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_determined_format := this.getfileformat(var_formattest.clone(), (if var_original_filename.len > 0 && var_original_filename != '0' { rt.new_string(original_filename) } else { var_filename_mutated }).str())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_determined_format)))) {
		rt.call_function('fclose', [this.fp])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		return this.error(rt.new_string('unable to determine file format'))
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if var_determined_format.array_isset(rt.new_string('fail_id3')) && rt.is_true(rt.call_function('in_array', [rt.new_string('id3v1'), this.info.array_get(rt.new_string('tags'))])) || rt.is_true(rt.call_function('in_array', [rt.new_string('id3v2'), this.info.array_get(rt.new_string('tags'))])) {
		if rt.is_true(rt.identical(var_determined_format.array_get(rt.new_string('fail_id3')), rt.new_string('ERROR'))) {
			rt.call_function('fclose', [this.fp])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			return this.error(rt.new_string('ID3 tags not allowed on this file type.'))
		} else if rt.is_true(rt.identical(var_determined_format.array_get(rt.new_string('fail_id3')), rt.new_string('WARNING'))) {
			this.warning(rt.new_string('ID3 tags not allowed on this file type.'))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if var_determined_format.array_isset(rt.new_string('fail_ape')) && rt.is_true(rt.call_function('in_array', [rt.new_string('ape'), this.info.array_get(rt.new_string('tags'))])) {
		if rt.is_true(rt.identical(var_determined_format.array_get(rt.new_string('fail_ape')), rt.new_string('ERROR'))) {
			rt.call_function('fclose', [this.fp])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			return this.error(rt.new_string('APE tags not allowed on this file type.'))
		} else if rt.is_true(rt.identical(var_determined_format.array_get(rt.new_string('fail_ape')), rt.new_string('WARNING'))) {
			this.warning(rt.new_string('APE tags not allowed on this file type.'))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	this.info.array_set('mime_type', var_determined_format.array_get(rt.new_string('mime_type')))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('GETID3_INCLUDEPATH')).str() + (var_determined_format.array_get(rt.new_string('include'))).str())]))))) {
		rt.call_function('fclose', [this.fp])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		return this.error(rt.new_string('Format not supported, module "' + (var_determined_format.array_get(rt.new_string('include'))).str() + '" was removed.'))
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if !(!rt.is_true(var_determined_format.array_get(rt.new_string('iconv_req')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_convert_encoding')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('iconv')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.encoding, rt.create_array([rt.ArrayItem{ key: none, val: 'ISO-8859-1' }, rt.ArrayItem{ key: none, val: 'UTF-8' }, rt.ArrayItem{ key: none, val: 'UTF-16LE' }, rt.ArrayItem{ key: none, val: 'UTF-16BE' }, rt.ArrayItem{ key: none, val: 'UTF-16' }])]))))) {
		mut var_errormessage := rt.new_string('mb_convert_encoding() or iconv() support is required for this module (' + (var_determined_format.array_get(rt.new_string('include'))).str() + ') for encodings other than ISO-8859-1, UTF-8, UTF-16LE, UTF16-BE, UTF-16. ')
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.get_constant('GETID3_OS_ISWINDOWS')) {
			var_errormessage = rt.concat(var_errormessage, rt.new_string('PHP does not have mb_convert_encoding() or iconv() support. Please enable php_mbstring.dll / php_iconv.dll in php.ini, and copy php_mbstring.dll / iconv.dll from c:/php/dlls to c:/windows/system32'))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		} else {
			var_errormessage = rt.concat(var_errormessage, rt.new_string('PHP is not compiled with mb_convert_encoding() or iconv() support. Please recompile with the --enable-mbstring / --with-iconv switch'))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		return this.error(var_errormessage.clone())
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.include_file((rt.get_constant('GETID3_INCLUDEPATH')).str() + (var_determined_format.array_get(rt.new_string('include'))).str(), '2')
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_class_name := rt.new_string('getid3_' + (var_determined_format.array_get(rt.new_string('module'))).str())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_class_name.clone()]))))) {
		return this.error(rt.new_string('Format not supported, module "' + (var_determined_format.array_get(rt.new_string('include'))).str() + '" is corrupt.'))
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_class := rt.create_object_dynamically(var_class_name, [rt.new_object('getID3', []string{}, &this)])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut iter_8 := rt.call_function('get_object_vars', [rt.new_object('getID3', []string{}, &this)]).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_getid3_object_vars_value := item_8.val
		mut var_getid3_object_vars_key := item_8.key
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^options_([^_]+)_([^_]+)_(.+)$#i'), var_getid3_object_vars_key.clone(), rt.create_array_from_list(var_matches)])) {
			mut list_tmp_2 := var_matches
			var_dummy = (list_tmp_2).array_get(0)
			mut var_GOVgroup := (list_tmp_2).array_get(1)
			var_GOVmodule = (list_tmp_2).array_get(2)
			var_GOVsetting = (list_tmp_2).array_get(3)
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_GOVgroup = if rt.is_true(rt.equal(var_GOVgroup, rt.new_string('audiovideo'))) { rt.new_string('audio-video') } else { var_GOVgroup }
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			if rt.is_true(rt.equal(var_GOVgroup, var_determined_format.array_get(rt.new_string('group')))) && rt.is_true(rt.equal(var_GOVmodule, var_determined_format.array_get(rt.new_string('module')))) {
				rt.set_property(var_class, '{"nodeType":"Expr_Variable","line":778,"name":"GOVsetting"}', var_getid3_object_vars_value.clone())
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(var_class, 'Analyze', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_class = rt.new_null()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('fclose', [this.fp])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(this.option_tags_process) {
		this.handlealltags()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(this.option_extra_info) {
		this.channelsbitrateplaytimecalculations()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		this.calculatecompressionratiovideo()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		this.calculatecompressionratioaudio()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		this.calculatereplaygain()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		this.processaudiostreams()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(this.option_md5_data) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.option_md5_data_source)))) || !rt.is_true(this.info.array_get(rt.new_string('md5_data_source'))) {
			this.gethashdata(rt.new_string('md5'))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(this.option_sha1_data) {
		this.gethashdata(rt.new_string('sha1'))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	this.cleanup()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		this.error(rt.new_string('Caught exception: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return this.info
}

fn (mut this Class_getID3) error(var_message rt.PhpVal) rt.PhpVal {
	this.cleanup()
	if !(this.info.array_isset(rt.new_string('error'))) {
		this.info.array_set('error', []rt.PhpVal{})
	}
	this.info.array_get_mut('error').array_push(var_message.clone())
	return this.info
}

fn (mut this Class_getID3) warning(var_message rt.PhpVal) bool {
	this.info.array_get_mut('warning').array_push(var_message.clone())
	return true
}

fn (mut this Class_getID3) cleanup() bool {
	mut var_AVpossibleEmptyKeys := ['dataformat', 'bits_per_sample', 'encoder_options', 'streams', 'bitrate']
	for var_dummy, var_key in var_AVpossibleEmptyKeys {
		if !rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string(key))) && this.info.array_get(rt.new_string('audio')).array_isset(rt.new_string(key)) {
			this.info.array_get(rt.new_string('audio')).array_unset(rt.new_string(key))
		}
		if !rt.is_true(this.info.array_get(rt.new_string('video')).array_get(rt.new_string(key))) && this.info.array_get(rt.new_string('video')).array_isset(rt.new_string(key)) {
			this.info.array_get(rt.new_string('video')).array_unset(rt.new_string(key))
		}
	}
	if !(!rt.is_true(this.info)) {
		mut iter_9 := this.info.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_value := item_9.val
			mut var_key := item_9.key
			if !rt.is_true(this.info.array_get(var_key)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.info.array_get(var_key), rt.new_int(0))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.info.array_get(var_key), rt.new_string('0'))))) {
				this.info.array_unset(var_key)
			}
		}
	}
	if !rt.is_true(this.info.array_get(rt.new_string('fileformat'))) {
		if this.info.array_isset(rt.new_string('avdataoffset')) {
			this.info.array_unset(rt.new_string('avdataoffset'))
		}
		if this.info.array_isset(rt.new_string('avdataend')) {
			this.info.array_unset(rt.new_string('avdataend'))
		}
	}
	if !(!rt.is_true(this.info.array_get(rt.new_string('error')))) {
		this.info.array_set('error', rt.call_function('array_values', [rt.call_function('array_unique', [this.info.array_get(rt.new_string('error'))])]))
	}
	if !(!rt.is_true(this.info.array_get(rt.new_string('warning')))) {
		this.info.array_set('warning', rt.call_function('array_values', [rt.call_function('array_unique', [this.info.array_get(rt.new_string('warning'))])]))
	}
	this.info.array_unset(rt.new_string('php_memory_limit'))
	return true
}

fn (mut this Class_getID3) getfileformatarray() rt.PhpVal {
	mut var_format_info := []rt.PhpVal{}
	if !rt.is_true(var_format_info) {
	var_format_info = { 'ac3': { 'pattern': rt.new_string('^\\x0B\\x77'), 'group': rt.new_string('audio'), 'module': rt.new_string('ac3'), 'mime_type': rt.new_string('audio/ac3') }, 'adif': { 'pattern': rt.new_string('^ADIF'), 'group': rt.new_string('audio'), 'module': rt.new_string('aac'), 'mime_type': rt.new_string('audio/aac'), 'fail_ape': rt.new_string('WARNING') }, 'adts': { 'pattern': rt.new_string('^\\xFF[\\xF0-\\xF1\\xF8-\\xF9]'), 'group': rt.new_string('audio'), 'module': rt.new_string('aac'), 'mime_type': rt.new_string('audio/aac'), 'fail_ape': rt.new_string('WARNING') }, 'au': { 'pattern': rt.new_string('^\\.snd'), 'group': rt.new_string('audio'), 'module': rt.new_string('au'), 'mime_type': rt.new_string('audio/basic') }, 'amr': { 'pattern': rt.new_string('^\\x23\\x21AMR\\x0A'), 'group': rt.new_string('audio'), 'module': rt.new_string('amr'), 'mime_type': rt.new_string('audio/amr') }, 'avr': { 'pattern': rt.new_string('^2BIT'), 'group': rt.new_string('audio'), 'module': rt.new_string('avr'), 'mime_type': rt.new_string('application/octet-stream') }, 'bonk': { 'pattern': rt.new_string('^\\x00(BONK|INFO|META| ID3)'), 'group': rt.new_string('audio'), 'module': rt.new_string('bonk'), 'mime_type': rt.new_string('audio/xmms-bonk') }, 'dsf': { 'pattern': rt.new_string('^DSD '), 'group': rt.new_string('audio'), 'module': rt.new_string('dsf'), 'mime_type': rt.new_string('audio/dsd') }, 'dss': { 'pattern': rt.new_string('^[\\x02-\\x08]ds[s2]'), 'group': rt.new_string('audio'), 'module': rt.new_string('dss'), 'mime_type': rt.new_string('application/octet-stream') }, 'dsdiff': { 'pattern': rt.new_string('^FRM8'), 'group': rt.new_string('audio'), 'module': rt.new_string('dsdiff'), 'mime_type': rt.new_string('audio/dsd') }, 'dts': { 'pattern': rt.new_string('^\\x7F\\xFE\\x80\\x01'), 'group': rt.new_string('audio'), 'module': rt.new_string('dts'), 'mime_type': rt.new_string('audio/dts') }, 'flac': { 'pattern': rt.new_string('^fLaC'), 'group': rt.new_string('audio'), 'module': rt.new_string('flac'), 'mime_type': rt.new_string('audio/flac') }, 'la': { 'pattern': rt.new_string('^LA0[2-4]'), 'group': rt.new_string('audio'), 'module': rt.new_string('la'), 'mime_type': rt.new_string('application/octet-stream') }, 'lpac': { 'pattern': rt.new_string('^LPAC'), 'group': rt.new_string('audio'), 'module': rt.new_string('lpac'), 'mime_type': rt.new_string('application/octet-stream') }, 'midi': { 'pattern': rt.new_string('^MThd'), 'group': rt.new_string('audio'), 'module': rt.new_string('midi'), 'mime_type': rt.new_string('audio/midi') }, 'mac': { 'pattern': rt.new_string('^MAC '), 'group': rt.new_string('audio'), 'module': rt.new_string('monkey'), 'mime_type': rt.new_string('audio/x-monkeys-audio') }, 'mod': { 'pattern': rt.new_string('^.{1080}(M\\.K\\.)'), 'group': rt.new_string('audio'), 'module': rt.new_string('mod'), 'option': rt.new_string('mod'), 'mime_type': rt.new_string('audio/mod') }, 'it': { 'pattern': rt.new_string('^IMPM'), 'group': rt.new_string('audio'), 'module': rt.new_string('mod'), 'mime_type': rt.new_string('audio/it') }, 'xm': { 'pattern': rt.new_string('^Extended Module'), 'group': rt.new_string('audio'), 'module': rt.new_string('mod'), 'mime_type': rt.new_string('audio/xm') }, 's3m': { 'pattern': rt.new_string('^.{44}SCRM'), 'group': rt.new_string('audio'), 'module': rt.new_string('mod'), 'mime_type': rt.new_string('audio/s3m') }, 'mpc': { 'pattern': rt.new_string('^(MPCK|MP\\+)'), 'group': rt.new_string('audio'), 'module': rt.new_string('mpc'), 'mime_type': rt.new_string('audio/x-musepack') }, 'mp3': { 'pattern': rt.new_string('^\\xFF[\\xE2-\\xE7\\xF2-\\xF7\\xFA-\\xFF][\\x00-\\x0B\\x10-\\x1B\\x20-\\x2B\\x30-\\x3B\\x40-\\x4B\\x50-\\x5B\\x60-\\x6B\\x70-\\x7B\\x80-\\x8B\\x90-\\x9B\\xA0-\\xAB\\xB0-\\xBB\\xC0-\\xCB\\xD0-\\xDB\\xE0-\\xEB\\xF0-\\xFB]'), 'group': rt.new_string('audio'), 'module': rt.new_string('mp3'), 'mime_type': rt.new_string('audio/mpeg') }, 'ofr': { 'pattern': rt.new_string('^(\\*RIFF|OFR)'), 'group': rt.new_string('audio'), 'module': rt.new_string('optimfrog'), 'mime_type': rt.new_string('application/octet-stream') }, 'rkau': { 'pattern': rt.new_string('^RKA'), 'group': rt.new_string('audio'), 'module': rt.new_string('rkau'), 'mime_type': rt.new_string('application/octet-stream') }, 'shn': { 'pattern': rt.new_string('^ajkg'), 'group': rt.new_string('audio'), 'module': rt.new_string('shorten'), 'mime_type': rt.new_string('audio/xmms-shn'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'tak': { 'pattern': rt.new_string('^tBaK'), 'group': rt.new_string('audio'), 'module': rt.new_string('tak'), 'mime_type': rt.new_string('application/octet-stream') }, 'tta': { 'pattern': rt.new_string('^TTA'), 'group': rt.new_string('audio'), 'module': rt.new_string('tta'), 'mime_type': rt.new_string('application/octet-stream') }, 'voc': { 'pattern': rt.new_string('^Creative Voice File'), 'group': rt.new_string('audio'), 'module': rt.new_string('voc'), 'mime_type': rt.new_string('audio/voc') }, 'vqf': { 'pattern': rt.new_string('^TWIN'), 'group': rt.new_string('audio'), 'module': rt.new_string('vqf'), 'mime_type': rt.new_string('application/octet-stream') }, 'wv': { 'pattern': rt.new_string('^wvpk'), 'group': rt.new_string('audio'), 'module': rt.new_string('wavpack'), 'mime_type': rt.new_string('application/octet-stream') }, 'asf': { 'pattern': rt.new_string('^\\x30\\x26\\xB2\\x75\\x8E\\x66\\xCF\\x11\\xA6\\xD9\\x00\\xAA\\x00\\x62\\xCE\\x6C'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('asf'), 'mime_type': rt.new_string('video/x-ms-asf'), 'iconv_req': rt.new_bool(false) }, 'bink': { 'pattern': rt.new_string('^(BIK|SMK)'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('bink'), 'mime_type': rt.new_string('application/octet-stream') }, 'flv': { 'pattern': rt.new_string('^FLV[\\x01]'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('flv'), 'mime_type': rt.new_string('video/x-flv') }, 'ivf': { 'pattern': rt.new_string('^DKIF'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('ivf'), 'mime_type': rt.new_string('video/x-ivf') }, 'matroska': { 'pattern': rt.new_string('^\\x1A\\x45\\xDF\\xA3'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('matroska'), 'mime_type': rt.new_string('video/x-matroska') }, 'mpeg': { 'pattern': rt.new_string('^\\x00\\x00\\x01[\\xB3\\xBA]'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('mpeg'), 'mime_type': rt.new_string('video/mpeg') }, 'nsv': { 'pattern': rt.new_string('^NSV[sf]'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('nsv'), 'mime_type': rt.new_string('application/octet-stream') }, 'ogg': { 'pattern': rt.new_string('^OggS'), 'group': rt.new_string('audio'), 'module': rt.new_string('ogg'), 'mime_type': rt.new_string('application/ogg'), 'fail_id3': rt.new_string('WARNING'), 'fail_ape': rt.new_string('WARNING') }, 'quicktime': { 'pattern': rt.new_string('^.{4}(cmov|free|ftyp|mdat|moov|pnot|skip|wide)'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('quicktime'), 'mime_type': rt.new_string('video/quicktime') }, 'riff': { 'pattern': rt.new_string('^(RIFF|SDSS|FORM)'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('riff'), 'mime_type': rt.new_string('audio/wav'), 'fail_ape': rt.new_string('WARNING') }, 'real': { 'pattern': rt.new_string('^\\.(RMF|ra)'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('real'), 'mime_type': rt.new_string('audio/x-realaudio') }, 'swf': { 'pattern': rt.new_string('^(F|C)WS'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('swf'), 'mime_type': rt.new_string('application/x-shockwave-flash') }, 'ts': { 'pattern': rt.new_string('^(\\x47.{187}){10,}'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('ts'), 'mime_type': rt.new_string('video/MP2T') }, 'wtv': { 'pattern': rt.new_string('^\\xB7\\xD8\\x00\\x20\\x37\\x49\\xDA\\x11\\xA6\\x4E\\x00\\x07\\xE9\\x5E\\xAD\\x8D'), 'group': rt.new_string('audio-video'), 'module': rt.new_string('wtv'), 'mime_type': rt.new_string('video/x-ms-wtv') }, 'bmp': { 'pattern': rt.new_string('^BM'), 'group': rt.new_string('graphic'), 'module': rt.new_string('bmp'), 'mime_type': rt.new_string('image/bmp'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'gif': { 'pattern': rt.new_string('^GIF'), 'group': rt.new_string('graphic'), 'module': rt.new_string('gif'), 'mime_type': rt.new_string('image/gif'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'jpg': { 'pattern': rt.new_string('^\\xFF\\xD8\\xFF'), 'group': rt.new_string('graphic'), 'module': rt.new_string('jpg'), 'mime_type': rt.new_string('image/jpeg'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'pcd': { 'pattern': rt.new_string('^.{2048}PCD_IPI\\x00'), 'group': rt.new_string('graphic'), 'module': rt.new_string('pcd'), 'mime_type': rt.new_string('image/x-photo-cd'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'png': { 'pattern': rt.new_string('^\\x89\\x50\\x4E\\x47\\x0D\\x0A\\x1A\\x0A'), 'group': rt.new_string('graphic'), 'module': rt.new_string('png'), 'mime_type': rt.new_string('image/png'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'svg': { 'pattern': rt.new_string('(<!DOCTYPE svg PUBLIC |xmlns="http://www\\.w3\\.org/2000/svg")'), 'group': rt.new_string('graphic'), 'module': rt.new_string('svg'), 'mime_type': rt.new_string('image/svg+xml'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'tiff': { 'pattern': rt.new_string('^(II\\x2A\\x00|MM\\x00\\x2A)'), 'group': rt.new_string('graphic'), 'module': rt.new_string('tiff'), 'mime_type': rt.new_string('image/tiff'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'efax': { 'pattern': rt.new_string('^\\xDC\\xFE'), 'group': rt.new_string('graphic'), 'module': rt.new_string('efax'), 'mime_type': rt.new_string('image/efax'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'iso': { 'pattern': rt.new_string('^.{32769}CD001'), 'group': rt.new_string('misc'), 'module': rt.new_string('iso'), 'mime_type': rt.new_string('application/octet-stream'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR'), 'iconv_req': rt.new_bool(false) }, 'hpk': { 'pattern': rt.new_string('^BPUL'), 'group': rt.new_string('archive'), 'module': rt.new_string('hpk'), 'mime_type': rt.new_string('application/octet-stream'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'rar': { 'pattern': rt.new_string('^Rar\\!'), 'group': rt.new_string('archive'), 'module': rt.new_string('rar'), 'mime_type': rt.new_string('application/vnd.rar'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'szip': { 'pattern': rt.new_string('^SZ\\x0A\\x04'), 'group': rt.new_string('archive'), 'module': rt.new_string('szip'), 'mime_type': rt.new_string('application/octet-stream'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'tar': { 'pattern': rt.new_string('^.{100}[0-9\\x20]{7}\\x00[0-9\\x20]{7}\\x00[0-9\\x20]{7}\\x00[0-9\\x20\\x00]{12}[0-9\\x20\\x00]{12}'), 'group': rt.new_string('archive'), 'module': rt.new_string('tar'), 'mime_type': rt.new_string('application/x-tar'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'gz': { 'pattern': rt.new_string('^\\x1F\\x8B\\x08'), 'group': rt.new_string('archive'), 'module': rt.new_string('gzip'), 'mime_type': rt.new_string('application/gzip'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'zip': { 'pattern': rt.new_string('^PK\\x03\\x04'), 'group': rt.new_string('archive'), 'module': rt.new_string('zip'), 'mime_type': rt.new_string('application/zip'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'xz': { 'pattern': rt.new_string('^\\xFD7zXZ\\x00'), 'group': rt.new_string('archive'), 'module': rt.new_string('xz'), 'mime_type': rt.new_string('application/x-xz'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, '7zip': { 'pattern': rt.new_string('^7z\\xBC\\xAF\\x27\\x1C'), 'group': rt.new_string('archive'), 'module': rt.new_string('7zip'), 'mime_type': rt.new_string('application/x-7z-compressed'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'gpx': { 'pattern': rt.new_string('^<\\?xml [^>]+>[\\s]*<gpx '), 'group': rt.new_string('misc'), 'module': rt.new_string('gpx'), 'mime_type': rt.new_string('application/gpx+xml'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'par2': { 'pattern': rt.new_string('^PAR2\\x00PKT'), 'group': rt.new_string('misc'), 'module': rt.new_string('par2'), 'mime_type': rt.new_string('application/octet-stream'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'pdf': { 'pattern': rt.new_string('^\\x25PDF'), 'group': rt.new_string('misc'), 'module': rt.new_string('pdf'), 'mime_type': rt.new_string('application/pdf'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'msoffice': { 'pattern': rt.new_string('^\\xD0\\xCF\\x11\\xE0\\xA1\\xB1\\x1A\\xE1'), 'group': rt.new_string('misc'), 'module': rt.new_string('msoffice'), 'mime_type': rt.new_string('application/octet-stream'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'torrent': { 'pattern': rt.new_string('^(d8\\:announce|d7\\:comment)'), 'group': rt.new_string('misc'), 'module': rt.new_string('torrent'), 'mime_type': rt.new_string('application/x-bittorrent'), 'fail_id3': rt.new_string('ERROR'), 'fail_ape': rt.new_string('ERROR') }, 'cue': { 'pattern': rt.new_string(''), 'group': rt.new_string('misc'), 'module': rt.new_string('cue'), 'mime_type': rt.new_string('application/octet-stream') } }
	}
	return var_format_info.clone()
}

fn (mut this Class_getID3) getfileformat(var_filedata rt.PhpVal, filename string) rt.PhpVal {
	mut filename_mutated := filename
	for var_format_name, var_info in this.getfileformatarray() {
		if !(!rt.is_true(var_info.array_get(rt.new_string('pattern')))) && rt.is_true(rt.call_function('preg_match', [rt.new_string('#' + (var_info.array_get(rt.new_string('pattern'))).str() + '#s'), var_filedata.clone()])) {
			var_info.array_set('include', 'module.' + (var_info.array_get(rt.new_string('group'))).str() + '.' + (var_info.array_get(rt.new_string('module'))).str() + '.php')
			return var_info.clone()
		}
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#\\.mp[123a]$#i'), rt.new_string(filename_mutated).clone()])) {
		mut var_GetFileFormatArray := this.getfileformatarray()
		mut var_info := var_GetFileFormatArray.array_get(rt.new_string('mp3'))
		var_info.array_set('include', 'module.' + (var_info.array_get(rt.new_string('group'))).str() + '.' + (var_info.array_get(rt.new_string('module'))).str() + '.php')
		return var_info.clone()
	} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('#\\.mp[cp\\+]$#i'), rt.new_string(filename_mutated).clone()])) && rt.is_true(rt.call_function('preg_match', [rt.new_string('#[\\x00\\x01\\x10\\x11\\x40\\x41\\x50\\x51\\x80\\x81\\x90\\x91\\xC0\\xC1\\xD0\\xD1][\\x20-37][\\x00\\x20\\x40\\x60\\x80\\xA0\\xC0\\xE0]#s'), var_filedata.clone()])) {
		var_GetFileFormatArray = this.getfileformatarray()
		var_info = var_GetFileFormatArray.array_get(rt.new_string('mpc'))
		var_info.array_set('include', 'module.' + (var_info.array_get(rt.new_string('group'))).str() + '.' + (var_info.array_get(rt.new_string('module'))).str() + '.php')
		return var_info.clone()
	} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('#\\.cue$#i'), rt.new_string(filename_mutated).clone()])) && rt.is_true(rt.call_function('preg_match', [rt.new_string('#FILE "[^"]+" (BINARY|MOTOROLA|AIFF|WAVE|MP3)#'), var_filedata.clone()])) {
		var_GetFileFormatArray = this.getfileformatarray()
		var_info = var_GetFileFormatArray.array_get(rt.new_string('cue'))
		var_info.array_set('include', 'module.' + (var_info.array_get(rt.new_string('group'))).str() + '.' + (var_info.array_get(rt.new_string('module'))).str() + '.php')
		return var_info.clone()
	}
	return rt.new_bool(false)
}

fn (mut this Class_getID3) charconvert(var_array rt.PhpVal, var_encoding rt.PhpVal) {
	mut var_array_mutated := var_array
	if rt.is_true(rt.equal(var_encoding, this.encoding)) {
		return
	}
	mut iter_10 := var_array_mutated.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_value := item_10.val
		mut var_key := item_10.key
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			this.charconvert(var_array_mutated.array_get(var_key), var_encoding.clone())
		} else if rt.is_true(rt.new_bool(var_value.clone().is_string())) {
			mut iife_temp_4 := Class_getid3_lib{}
			mut iife_result_4 := iife_temp_4.iconv_fallback(var_encoding.clone(), this.encoding, var_value.clone())
			mut iife_temp_5 := Class_getid3_lib{}
			mut iife_result_5 := iife_temp_5.iconv_fallback(var_encoding.clone(), this.encoding, var_value.clone())
			var_array_mutated.array_set(var_key, iife_result_5.to_string().trim_space())
		}
	}
}

fn (mut this Class_getID3) handlealltags() bool {
	mut var_tag_name := rt.new_null()
	mut var_encoding := rt.new_null()
	mut var_tags := rt.new_null()
	if !rt.is_true(var_tags) {
	var_tags = { 'asf': map[string]rt.PhpVal{}, 'midi': map[string]rt.PhpVal{}, 'nsv': map[string]rt.PhpVal{}, 'ogg': map[string]rt.PhpVal{}, 'png': map[string]rt.PhpVal{}, 'tiff': map[string]rt.PhpVal{}, 'quicktime': map[string]rt.PhpVal{}, 'real': map[string]rt.PhpVal{}, 'vqf': map[string]rt.PhpVal{}, 'zip': map[string]rt.PhpVal{}, 'riff': map[string]rt.PhpVal{}, 'lyrics3': map[string]rt.PhpVal{}, 'id3v1': map[string]rt.PhpVal{}, 'id3v2': map[string]rt.PhpVal{}, 'ape': map[string]rt.PhpVal{}, 'cue': map[string]rt.PhpVal{}, 'matroska': map[string]rt.PhpVal{}, 'flac': map[string]rt.PhpVal{}, 'divxtag': map[string]rt.PhpVal{}, 'iptc': map[string]rt.PhpVal{}, 'dsdiff': map[string]rt.PhpVal{} }
	}
	for var_comment_name, var_tagname_encoding_array in var_tags {
		mut list_tmp_3 := var_tagname_encoding_array
		var_tag_name = (list_tmp_3).array_get(0)
		var_encoding = (list_tmp_3).array_get(1)
		if this.info.array_isset(rt.new_string(comment_name)) && !(this.info.array_get(rt.new_string(comment_name)).array_isset(rt.new_string('encoding'))) {
			this.info.array_get_mut(comment_name).array_set('encoding', var_encoding.clone())
		}
		if !(!rt.is_true(this.info.array_get(rt.new_string(comment_name)).array_get(rt.new_string('comments')))) {
			mut iter_11 := this.info.array_get(rt.new_string(comment_name)).array_get(rt.new_string('comments')).iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_valuearray := item_11.val
				mut var_tag_key := item_11.key
				mut iter_12 := var_valuearray.iterator()
				for {
					item_12 := iter_12.next() or { break }
					mut var_value := item_12.val
					mut var_key := item_12.key
					if rt.is_true(rt.new_bool(var_value.clone().is_string())) {
					var_value = rt.new_string(var_value.clone().to_string().trim_space())
					}
					if !(var_value).is_null() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value, rt.new_string(''))))) {
						if !(var_key.clone().is_long() || var_key.clone().is_double()) {
							this.info.array_get_mut('tags').array_get_mut(var_tag_name.clone().to_string().trim_space()).array_get_mut(var_tag_key.clone().to_string().trim_space()).array_set(var_key, var_value.clone())
						} else {
							this.info.array_get_mut('tags').array_get_mut(var_tag_name.clone().to_string().trim_space()).array_get_mut(var_tag_key.clone().to_string().trim_space()).array_push(var_value.clone())
						}
					}
				}
				if rt.is_true(rt.equal(var_tag_key, rt.new_string('picture'))) {
					this.info.array_get(rt.new_string(comment_name)).array_get(rt.new_string('comments')).array_unset(var_tag_key)
				}
			}
			if !(this.info.array_get(rt.new_string('tags')).array_isset(var_tag_name)) {
				continue
			}
			this.charconvert(this.info.array_get(rt.new_string('tags')).array_get(var_tag_name), this.info.array_get(rt.new_string(comment_name)).array_get(rt.new_string('encoding')))
			if rt.is_true(this.option_tags_html) {
				mut iter_13 := this.info.array_get(rt.new_string('tags')).array_get(var_tag_name).iterator()
				for {
					item_13 := iter_13.next() or { break }
					mut var_valuearray := item_13.val
					mut var_tag_key := item_13.key
					if rt.is_true(rt.equal(var_tag_key, rt.new_string('picture'))) {
						continue
					}
					mut iife_temp_6 := Class_getid3_lib{}
					mut iife_result_6 := iife_temp_6.recursivemultibytecharstring2html(var_valuearray.clone(), this.info.array_get(rt.new_string(comment_name)).array_get(rt.new_string('encoding')))
					this.info.array_get_mut('tags_html').array_get_mut(var_tag_name).array_set(var_tag_key, iife_result_6)
				}
			}
		}
	}
	if !(!rt.is_true(this.info.array_get(rt.new_string('tags')))) {
		mut var_unset_keys := ['tags', 'tags_html']
		mut iter_14 := this.info.array_get(rt.new_string('tags')).iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_tagarray := item_14.val
			mut var_tagtype := item_14.key
			mut iter_15 := var_tagarray.iterator()
			for {
				item_15 := iter_15.next() or { break }
				mut var_tagdata := item_15.val
				mut var_tagname := item_15.key
				if rt.is_true(rt.equal(var_tagname, rt.new_string('picture'))) {
					mut iter_16 := var_tagdata.iterator()
					for {
						item_16 := iter_16.next() or { break }
						mut var_tagarray_shadow := item_16.val
						mut var_key := item_16.key
						this.info.array_get_mut('comments').array_get_mut('picture').array_push(var_tagarray_shadow.clone())
						if var_tagarray_shadow.array_isset(rt.new_string('data')) && var_tagarray_shadow.array_isset(rt.new_string('image_mime')) {
							if this.info.array_get(rt.new_string('tags')).array_get(var_tagtype).array_get(var_tagname).array_isset(var_key) {
								this.info.array_get(rt.new_string('tags')).array_get(var_tagtype).array_get(var_tagname).array_unset(var_key)
							}
							if this.info.array_get(rt.new_string('tags_html')).array_get(var_tagtype).array_get(var_tagname).array_isset(var_key) {
								this.info.array_get(rt.new_string('tags_html')).array_get(var_tagtype).array_get(var_tagname).array_unset(var_key)
							}
						}
					}
				}
			}
			for var_unset_key in var_unset_keys {
				if !rt.is_true(this.info.array_get(rt.new_string(unset_key)).array_get(var_tagtype).array_get(rt.new_string('picture'))) {
					this.info.array_get(rt.new_string(unset_key)).array_get(var_tagtype).array_unset(rt.new_string('picture'))
				}
				if !rt.is_true(this.info.array_get(rt.new_string(unset_key)).array_get(var_tagtype)) {
					this.info.array_get(rt.new_string(unset_key)).array_unset(var_tagtype)
				}
				if !rt.is_true(this.info.array_get(rt.new_string(unset_key))) {
					this.info.array_unset(rt.new_string(unset_key))
				}
			}
			if this.info.array_get(var_tagtype).array_get(rt.new_string('comments')).array_isset(rt.new_string('picture')) {
				this.info.array_get(var_tagtype).array_get(rt.new_string('comments')).array_unset(rt.new_string('picture'))
			}
			if !rt.is_true(this.info.array_get(var_tagtype).array_get(rt.new_string('comments'))) {
				this.info.array_get(var_tagtype).array_unset(rt.new_string('comments'))
			}
			if !rt.is_true(this.info.array_get(var_tagtype)) {
				this.info.array_unset(var_tagtype)
			}
		}
	}
	return true
}

fn (mut this Class_getID3) copytagstocomments(var_ThisFileInfo rt.PhpVal) rt.PhpVal {
	mut iife_temp_7 := Class_getid3_lib{}
	mut iife_result_7 := iife_temp_7.copytagstocomments(var_ThisFileInfo.clone(), this.option_tags_html)
	return iife_result_7
}

fn (mut this Class_getID3) gethashdata(var_algorithm rt.PhpVal) bool {
	mut switch_val_1 := var_algorithm
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('md5'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('sha1'))) {
	} else {
		return (this.error(rt.new_string('bad algorithm "' + (var_algorithm).str() + '" in getHashdata()'))).to_bool()
	}
	if !(!rt.is_true(this.info.array_get(rt.new_string('fileformat')))) && !(!rt.is_true(this.info.array_get(rt.new_string('dataformat')))) && rt.is_true(rt.equal(this.info.array_get(rt.new_string('fileformat')), rt.new_string('ogg'))) && rt.is_true(rt.equal(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('dataformat')), rt.new_string('vorbis'))) {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('#(1|ON)#i'), rt.call_function('ini_get', [rt.new_string('safe_mode')])])) {
			this.warning(rt.new_string('Failed making system call to vorbiscomment.exe - ' + (var_algorithm).str() + '_data is incorrect - error returned: PHP running in Safe Mode (backtick operator not available)'))
			this.info.array_set((var_algorithm).str() + '_data', false)
		} else {
			mut var_old_abort := rt.call_function('ignore_user_abort', [rt.new_bool(true)])
			mut var_empty := rt.call_function('tempnam', [rt.get_constant('GETID3_TEMP_DIR'), rt.new_string('getID3')])
			rt.call_function('touch', [var_empty.clone()])
			mut var_temp := rt.call_function('tempnam', [rt.get_constant('GETID3_TEMP_DIR'), rt.new_string('getID3')])
			mut var_file := this.info.array_get(rt.new_string('filenamepath'))
			if rt.is_true(rt.get_constant('GETID3_OS_ISWINDOWS')) {
				if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('GETID3_HELPERAPPSDIR')).str() + 'vorbiscomment.exe')])) {
				mut var_commandline := rt.new_string('"' + (rt.get_constant('GETID3_HELPERAPPSDIR')).str() + 'vorbiscomment.exe" -w -c "' + (var_empty).str() + '" "' + (var_file).str() + '" "' + (var_temp).str() + '"')
				mut var_VorbisCommentError := rt.call_function('shell_exec', [var_commandline.clone()])
				} else {
				var_VorbisCommentError = rt.new_string('vorbiscomment.exe not found in ' + (rt.get_constant('GETID3_HELPERAPPSDIR')).str())
				}
			} else {
			var_commandline = rt.new_string('vorbiscomment -w -c ' + (rt.call_function('escapeshellarg', [var_empty.clone()])).str() + ' ' + (rt.call_function('escapeshellarg', [var_file.clone()])).str() + ' ' + (rt.call_function('escapeshellarg', [var_temp.clone()])).str() + ' 2>&1')
			var_VorbisCommentError = rt.call_function('shell_exec', [var_commandline.clone()])
			}
			if !(!rt.is_true(var_VorbisCommentError)) {
				this.warning(rt.new_string('Failed making system call to vorbiscomment(.exe) - ' + (var_algorithm).str() + '_data will be incorrect. If vorbiscomment is unavailable, please download from http://www.vorbis.com/download.psp and put in the getID3() directory. Error returned: ' + (var_VorbisCommentError).str()))
				this.info.array_set((var_algorithm).str() + '_data', false)
			} else {
				mut switch_val_2 := var_algorithm
				if rt.is_true(rt.equal(switch_val_2, rt.new_string('md5'))) {
					this.info.array_set((var_algorithm).str() + '_data', rt.call_function('md5_file', [var_temp.clone()]))
				} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('sha1'))) {
					this.info.array_set((var_algorithm).str() + '_data', rt.call_function('sha1_file', [var_temp.clone()]))
				}
			}
			rt.call_function('unlink', [var_empty.clone()])
			rt.call_function('unlink', [var_temp.clone()])
			rt.call_function('ignore_user_abort', [var_old_abort.clone()])
		}
	} else {
		if !(!rt.is_true(this.info.array_get(rt.new_string('avdataoffset')))) || (this.info.array_isset(rt.new_string('avdataend')) && rt.is_true(rt.less(this.info.array_get(rt.new_string('avdataend')), this.info.array_get(rt.new_string('filesize'))))) {
			mut iife_temp_8 := Class_getid3_lib{}
			mut iife_result_8 := iife_temp_8.hash_data(this.info.array_get(rt.new_string('filenamepath')), this.info.array_get(rt.new_string('avdataoffset')), this.info.array_get(rt.new_string('avdataend')), var_algorithm.clone())
			this.info.array_set((var_algorithm).str() + '_data', iife_result_8)
		} else {
			mut switch_val_3 := var_algorithm
			if rt.is_true(rt.equal(switch_val_3, rt.new_string('md5'))) {
				this.info.array_set((var_algorithm).str() + '_data', rt.call_function('md5_file', [this.info.array_get(rt.new_string('filenamepath'))]))
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('sha1'))) {
				this.info.array_set((var_algorithm).str() + '_data', rt.call_function('sha1_file', [this.info.array_get(rt.new_string('filenamepath'))]))
			}
		}
	}
	return true
}

fn (mut this Class_getID3) channelsbitrateplaytimecalculations() {
	if !(!rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('channelmode')))) || !(this.info.array_get(rt.new_string('audio')).array_isset(rt.new_string('channels'))) {
	} else if rt.is_true(rt.equal(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('channels')), rt.new_int(1))) {
		this.info.array_get_mut('audio').array_set('channelmode', 'mono')
	} else if rt.is_true(rt.equal(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('channels')), rt.new_int(2))) {
		this.info.array_get_mut('audio').array_set('channelmode', 'stereo')
	}
	mut var_CombinedBitrate := rt.new_int(0)
	var_CombinedBitrate = rt.add(var_CombinedBitrate, if this.info.array_get(rt.new_string('audio')).array_isset(rt.new_string('bitrate')) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bitrate')), rt.new_string('free'))))) { this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bitrate')) } else { rt.new_int(0) })
	var_CombinedBitrate = rt.add(var_CombinedBitrate, if this.info.array_get(rt.new_string('video')).array_isset(rt.new_string('bitrate')) { this.info.array_get(rt.new_string('video')).array_get(rt.new_string('bitrate')) } else { rt.new_int(0) })
	if rt.is_true(rt.greater(var_CombinedBitrate, rt.new_int(0))) && !rt.is_true(this.info.array_get(rt.new_string('bitrate'))) {
		this.info.array_set('bitrate', var_CombinedBitrate.clone())
	}
	if this.info.array_get(rt.new_string('video')).array_isset(rt.new_string('dataformat')) && rt.is_true(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('dataformat'))) && !(this.info.array_get(rt.new_string('video')).array_isset(rt.new_string('bitrate'))) || rt.is_true(rt.equal(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('bitrate')), rt.new_int(0))) {
		if this.info.array_get(rt.new_string('audio')).array_isset(rt.new_string('bitrate')) && rt.is_true(rt.greater(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bitrate')), rt.new_int(0))) && rt.is_true(rt.equal(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bitrate')), this.info.array_get(rt.new_string('bitrate')))) {
			if this.info.array_isset(rt.new_string('playtime_seconds')) && rt.is_true(rt.greater(this.info.array_get(rt.new_string('playtime_seconds')), rt.new_int(0))) {
				if this.info.array_isset(rt.new_string('avdataend')) && this.info.array_isset(rt.new_string('avdataoffset')) {
					this.info.array_set('bitrate', rt.call_function('round', [rt.div(rt.mul(rt.sub(this.info.array_get(rt.new_string('avdataend')), this.info.array_get(rt.new_string('avdataoffset'))), rt.new_int(8)), this.info.array_get(rt.new_string('playtime_seconds')))]))
					this.info.array_get_mut('video').array_set('bitrate', rt.sub(this.info.array_get(rt.new_string('bitrate')), this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bitrate'))))
				}
			}
		}
	}
	if !(this.info.array_isset(rt.new_string('playtime_seconds'))) || rt.is_true(rt.less_equal(this.info.array_get(rt.new_string('playtime_seconds')), rt.new_int(0))) && !(!rt.is_true(this.info.array_get(rt.new_string('bitrate')))) {
		this.info.array_set('playtime_seconds', rt.div(rt.mul(rt.sub(this.info.array_get(rt.new_string('avdataend')), this.info.array_get(rt.new_string('avdataoffset'))), rt.new_int(8)), this.info.array_get(rt.new_string('bitrate'))))
	}
	if !(this.info.array_isset(rt.new_string('bitrate'))) && !(!rt.is_true(this.info.array_get(rt.new_string('playtime_seconds')))) {
		this.info.array_set('bitrate', rt.div(rt.mul(rt.sub(this.info.array_get(rt.new_string('avdataend')), this.info.array_get(rt.new_string('avdataoffset'))), rt.new_int(8)), this.info.array_get(rt.new_string('playtime_seconds'))))
	}
	if this.info.array_isset(rt.new_string('bitrate')) && !rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bitrate'))) && !rt.is_true(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('bitrate'))) {
		if this.info.array_get(rt.new_string('audio')).array_isset(rt.new_string('dataformat')) && !rt.is_true(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('resolution_x'))) {
			this.info.array_get_mut('audio').array_set('bitrate', this.info.array_get(rt.new_string('bitrate')))
		} else if this.info.array_get(rt.new_string('video')).array_isset(rt.new_string('resolution_x')) && !rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('dataformat'))) {
			this.info.array_get_mut('video').array_set('bitrate', this.info.array_get(rt.new_string('bitrate')))
		}
	}
	if !(!rt.is_true(this.info.array_get(rt.new_string('playtime_seconds')))) && !rt.is_true(this.info.array_get(rt.new_string('playtime_string'))) {
		mut iife_temp_9 := Class_getid3_lib{}
		mut iife_result_9 := iife_temp_9.playtimestring(this.info.array_get(rt.new_string('playtime_seconds')))
		this.info.array_set('playtime_string', iife_result_9)
	}
	if !(!rt.is_true(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('fourcc')))) && !(this.info.array_get(rt.new_string('video')).array_isset(rt.new_string('codec'))) {
		this.include_module(rt.new_string('audio-video.riff'))
		mut iife_temp_10 := Class_getid3_riff{}
		mut iife_result_10 := iife_temp_10.fourcclookup(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('fourcc')))
		this.info.array_get_mut('video').array_set('codec', iife_result_10)
	}
}

fn (mut this Class_getID3) calculatecompressionratiovideo() bool {
	if !rt.is_true(this.info.array_get(rt.new_string('video'))) {
		return false
	}
	if !rt.is_true(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('resolution_x'))) || !rt.is_true(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('resolution_y'))) {
		return false
	}
	if !rt.is_true(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('bits_per_sample'))) {
		return false
	}
	mut switch_val_4 := this.info.array_get(rt.new_string('video')).array_get(rt.new_string('dataformat'))
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('bmp'))) || rt.is_true(rt.equal(switch_val_4, rt.new_string('gif'))) || rt.is_true(rt.equal(switch_val_4, rt.new_string('jpeg'))) || rt.is_true(rt.equal(switch_val_4, rt.new_string('jpg'))) || rt.is_true(rt.equal(switch_val_4, rt.new_string('png'))) || rt.is_true(rt.equal(switch_val_4, rt.new_string('tiff'))) {
	mut var_FrameRate := rt.new_int(1)
	mut var_PlaytimeSeconds := rt.new_int(1)
	mut var_BitrateCompressed := rt.mul(this.info.array_get(rt.new_string('filesize')), rt.new_int(8))
	} else {
		if !(!rt.is_true(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('frame_rate')))) {
		var_FrameRate = this.info.array_get(rt.new_string('video')).array_get(rt.new_string('frame_rate'))
		} else {
			return false
		}
		if !(!rt.is_true(this.info.array_get(rt.new_string('playtime_seconds')))) {
		var_PlaytimeSeconds = this.info.array_get(rt.new_string('playtime_seconds'))
		} else {
			return false
		}
		if !(!rt.is_true(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('bitrate')))) {
		var_BitrateCompressed = this.info.array_get(rt.new_string('video')).array_get(rt.new_string('bitrate'))
		} else {
			return false
		}
	}
	mut var_BitrateUncompressed := rt.mul(rt.mul(rt.mul(this.info.array_get(rt.new_string('video')).array_get(rt.new_string('resolution_x')), this.info.array_get(rt.new_string('video')).array_get(rt.new_string('resolution_y'))), this.info.array_get(rt.new_string('video')).array_get(rt.new_string('bits_per_sample'))), var_FrameRate)
	mut iife_temp_11 := Class_getid3_lib{}
	mut iife_result_11 := iife_temp_11.safediv(var_BitrateCompressed.clone(), var_BitrateUncompressed.clone(), rt.new_int(1))
	this.info.array_get_mut('video').array_set('compression_ratio', iife_result_11)
	return true
}

fn (mut this Class_getID3) calculatecompressionratioaudio() bool {
	if !rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bitrate'))) || !rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('channels'))) || !rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('sample_rate'))) || !(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('sample_rate')).is_long() || this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('sample_rate')).is_double()) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bitrate')), rt.new_string('free'))))) {
		this.info.array_get_mut('audio').array_set('compression_ratio', rt.div(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bitrate')), rt.mul(rt.mul(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('channels')), this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('sample_rate'))), if !(!rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bits_per_sample')))) { this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bits_per_sample')) } else { rt.new_int(16) })))
	}
	if !(!rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('streams')))) {
		mut iter_17 := this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('streams')).iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_streamdata := item_17.val
			mut var_streamnumber := item_17.key
			if !(!rt.is_true(var_streamdata.array_get(rt.new_string('bitrate')))) && !(!rt.is_true(var_streamdata.array_get(rt.new_string('channels')))) && !(!rt.is_true(var_streamdata.array_get(rt.new_string('sample_rate')))) {
				this.info.array_get_mut('audio').array_get_mut('streams').array_get_mut(var_streamnumber).array_set('compression_ratio', rt.div(var_streamdata.array_get(rt.new_string('bitrate')), rt.mul(rt.mul(var_streamdata.array_get(rt.new_string('channels')), var_streamdata.array_get(rt.new_string('sample_rate'))), if !(!rt.is_true(var_streamdata.array_get(rt.new_string('bits_per_sample')))) { var_streamdata.array_get(rt.new_string('bits_per_sample')) } else { rt.new_int(16) })))
			}
		}
	}
	return true
}

fn (mut this Class_getID3) calculatereplaygain() bool {
	if this.info.array_isset(rt.new_string('replay_gain')) {
		if !(this.info.array_get(rt.new_string('replay_gain')).array_isset(rt.new_string('reference_volume'))) {
			this.info.array_get_mut('replay_gain').array_set('reference_volume', 89)
		}
		if this.info.array_get(rt.new_string('replay_gain')).array_get(rt.new_string('track')).array_isset(rt.new_string('adjustment')) {
			this.info.array_get_mut('replay_gain').array_get_mut('track').array_set('volume', rt.sub(this.info.array_get(rt.new_string('replay_gain')).array_get(rt.new_string('reference_volume')), this.info.array_get(rt.new_string('replay_gain')).array_get(rt.new_string('track')).array_get(rt.new_string('adjustment'))))
		}
		if this.info.array_get(rt.new_string('replay_gain')).array_get(rt.new_string('album')).array_isset(rt.new_string('adjustment')) {
			this.info.array_get_mut('replay_gain').array_get_mut('album').array_set('volume', rt.sub(this.info.array_get(rt.new_string('replay_gain')).array_get(rt.new_string('reference_volume')), this.info.array_get(rt.new_string('replay_gain')).array_get(rt.new_string('album')).array_get(rt.new_string('adjustment'))))
		}
		if this.info.array_get(rt.new_string('replay_gain')).array_get(rt.new_string('track')).array_isset(rt.new_string('peak')) {
			mut iife_temp_12 := Class_getid3_lib{}
			mut iife_result_12 := iife_temp_12.rgadamplitude2db(this.info.array_get(rt.new_string('replay_gain')).array_get(rt.new_string('track')).array_get(rt.new_string('peak')))
			this.info.array_get_mut('replay_gain').array_get_mut('track').array_set('max_noclip_gain', rt.sub(rt.new_int(0), iife_result_12))
		}
		if this.info.array_get(rt.new_string('replay_gain')).array_get(rt.new_string('album')).array_isset(rt.new_string('peak')) {
			mut iife_temp_13 := Class_getid3_lib{}
			mut iife_result_13 := iife_temp_13.rgadamplitude2db(this.info.array_get(rt.new_string('replay_gain')).array_get(rt.new_string('album')).array_get(rt.new_string('peak')))
			this.info.array_get_mut('replay_gain').array_get_mut('album').array_set('max_noclip_gain', rt.sub(rt.new_int(0), iife_result_13))
		}
	}
	return true
}

fn (mut this Class_getID3) processaudiostreams() bool {
	if !(!rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('bitrate')))) || !(!rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('channels')))) || !(!rt.is_true(this.info.array_get(rt.new_string('audio')).array_get(rt.new_string('sample_rate')))) {
		if !(this.info.array_get(rt.new_string('audio')).array_isset(rt.new_string('streams'))) {
			mut iter_18 := this.info.array_get(rt.new_string('audio')).iterator()
			for {
				item_18 := iter_18.next() or { break }
				mut var_value := item_18.val
				mut var_key := item_18.key
				if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_key, rt.new_string('streams'))))) {
					this.info.array_get_mut('audio').array_get_mut('streams').array_get_mut(0).array_set(var_key, var_value.clone())
				}
			}
		}
	}
	return true
}

fn (mut this Class_getID3) getid3_tempnam() rt.PhpVal {
	return rt.call_function('tempnam', [this.tempdir, rt.new_string('gI3')])
}

fn (mut this Class_getID3) include_module(var_name rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('GETID3_INCLUDEPATH')).str() + 'module.' + (var_name).str() + '.php')]))))) {
		rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception('Required module.' + (var_name).str() + '.php is missing.')))
	}
	rt.include_file((rt.get_constant('GETID3_INCLUDEPATH')).str() + 'module.' + (var_name).str() + '.php', '2')
	return true
}

fn Class_getID3.is_writable(var_filename rt.PhpVal) rt.PhpVal {
	mut var_filename_mutated := var_filename
	mut var_ret := rt.call_function('is_writable', [var_filename_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ret)))) {
	mut var_perms := rt.call_function('fileperms', [var_filename_mutated.clone()])
	var_ret = rt.new_bool(rt.is_true(rt.bitwise_and(var_perms, rt.new_int(128))) || rt.is_true(rt.bitwise_and(var_perms, rt.new_int(16))) || rt.is_true(rt.bitwise_and(var_perms, rt.new_int(2))))
	}
	return var_ret.clone()
}

struct Class_getid3_handler {
	rt.PhpObjectBase
pub mut:
		getid3 rt.PhpVal = rt.new_null()
		data_string_flag bool
		data_string rt.PhpVal = rt.new_string('')
		data_string_position rt.PhpVal = rt.new_int(0)
		data_string_length i64
		dependency_to rt.PhpVal = rt.new_null()
}

fn (mut this Class_getid3_handler) construct(mut var_getid3 Class_getID3, var_call_module rt.PhpVal) {
	this.getid3 = var_getid3
	if rt.is_true(var_call_module) {
		this.dependency_to = rt.call_function('str_replace', [rt.new_string('getid3_'), rt.new_string(''), var_call_module.clone()])
	}
}

fn (mut this Class_getid3_handler) analyze() {
}

fn (mut this Class_getid3_handler) analyzestring(var_string rt.PhpVal) {
	this.setstringmode(var_string.clone())
	mut var_saved_avdataoffset := rt.get_property(this.getid3, 'info').array_get(rt.new_string('avdataoffset'))
	mut var_saved_avdataend := rt.get_property(this.getid3, 'info').array_get(rt.new_string('avdataend'))
	mut var_saved_filesize := if rt.get_property(this.getid3, 'info').array_isset(rt.new_string('filesize')) { rt.get_property(this.getid3, 'info').array_get(rt.new_string('filesize')) } else { rt.new_null() }
	rt.get_property(this.getid3, 'info').array_set('avdataoffset', 0)
	rt.get_property(this.getid3, 'info').array_set('avdataend', rt.get_property(this.getid3, 'info').array_set('filesize', this.data_string_length))
	this.analyze()
	rt.get_property(this.getid3, 'info').array_set('avdataoffset', var_saved_avdataoffset.clone())
	rt.get_property(this.getid3, 'info').array_set('avdataend', var_saved_avdataend.clone())
	rt.get_property(this.getid3, 'info').array_set('filesize', var_saved_filesize.clone())
	this.data_string_flag = false
}

fn (mut this Class_getid3_handler) setstringmode(var_string rt.PhpVal) {
	this.data_string_flag = true
	this.data_string = var_string.clone()
	this.data_string_length = var_string.clone().to_string().len
}

fn (mut this Class_getid3_handler) ftell() rt.PhpVal {
	if this.data_string_flag {
		return this.data_string_position
	}
	return rt.call_function('ftell', [rt.get_property(this.getid3, 'fp')])
}

fn (mut this Class_getid3_handler) fread(var_bytes rt.PhpVal) string {
	if this.data_string_flag {
		this.data_string_position = rt.add(this.data_string_position, var_bytes)
		return (rt.call_function('substr', [this.data_string, rt.sub(this.data_string_position, var_bytes), var_bytes.clone()])).str()
	}
	if rt.is_true(rt.equal(var_bytes, rt.new_int(0))) {
		return ''
	} else if rt.is_true(rt.less(var_bytes, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception('cannot fread(' + (var_bytes).str() + ' from ' + (this.ftell()).str() + ')', rt.new_int(10))))
	}
	mut var_pos := rt.add(this.ftell(), var_bytes)
	mut iife_temp_14 := Class_getid3_lib{}
	mut iife_result_14 := iife_temp_14.intvaluesupported(var_pos.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_14)))) {
		rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception('cannot fread(' + (var_bytes).str() + ' from ' + (this.ftell()).str() + ') because beyond PHP filesystem limit', rt.new_int(10))))
	}
	mut var_contents := rt.new_string('')
	for {
		if rt.is_true(rt.greater(rt.get_property(this.getid3, 'memory_limit'), rt.new_int(0))) && rt.is_true(rt.greater(rt.div(var_bytes, rt.get_property(this.getid3, 'memory_limit')), rt.new_float(0.99))) {
			rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception('cannot fread(' + (var_bytes).str() + ' from ' + (this.ftell()).str() + ') that is more than available PHP memory (' + (rt.get_property(this.getid3, 'memory_limit')).str() + ')', rt.new_int(10))))
		}
		mut var_part := rt.call_function('fread', [rt.get_property(this.getid3, 'fp'), var_bytes.clone()])
		mut var_partLength := rt.new_int(var_part.clone().to_string().len)
		var_bytes = rt.sub(var_bytes, var_partLength)
		var_contents = rt.concat(var_contents, var_part)
		if !(rt.is_true(rt.greater(var_bytes, rt.new_int(0))) && rt.is_true(rt.greater(var_partLength, rt.new_int(0)))) {
			break
		}
	}
	return (var_contents).str()
}

fn (mut this Class_getid3_handler) fseek(var_bytes rt.PhpVal, var_whence rt.PhpVal) i64 {
	if this.data_string_flag {
		mut switch_val_5 := var_whence
		if rt.is_true(rt.equal(switch_val_5, rt.get_constant('SEEK_SET'))) {
			this.data_string_position = var_bytes.clone()
		} else if rt.is_true(rt.equal(switch_val_5, rt.get_constant('SEEK_CUR'))) {
			this.data_string_position = rt.add(this.data_string_position, var_bytes)
		} else if rt.is_true(rt.equal(switch_val_5, rt.get_constant('SEEK_END'))) {
			this.data_string_position = rt.add(this.data_string_length, var_bytes)
		}
		return 0
	}
	mut var_pos := var_bytes
	if rt.is_true(rt.equal(var_whence, rt.get_constant('SEEK_CUR'))) {
	var_pos = rt.add(this.ftell(), var_bytes)
	} else if rt.is_true(rt.equal(var_whence, rt.get_constant('SEEK_END'))) {
	var_pos = rt.add(rt.get_property(this.getid3, 'info').array_get(rt.new_string('filesize')), var_bytes)
	}
	mut iife_temp_15 := Class_getid3_lib{}
	mut iife_result_15 := iife_temp_15.intvaluesupported(var_pos.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_15)))) {
		rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception('cannot fseek(' + (var_pos).str() + ') because beyond PHP filesystem limit', rt.new_int(10))))
	}
	mut var_result := rt.call_function('fseek', [rt.get_property(this.getid3, 'fp'), var_bytes.clone(), var_whence.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_result, rt.new_int(0))))) {
		rt.throw_exception(rt.new_object('getid3_exception', ['Exception'], create_getid3_exception('cannot fseek(' + (var_pos).str() + '). resource/stream does not appear to support seeking', rt.new_int(10))))
	}
	return (var_result).to_i64()
}

fn (mut this Class_getid3_handler) fgets() rt.PhpVal {
	mut var_buffer := rt.new_string('')
	mut var_prevchar := rt.new_string('')
	if this.data_string_flag {
		for true {
			mut var_thischar := rt.call_function('substr', [this.data_string, rt.post_inc(this.data_string_position), rt.new_int(1)])
			if rt.is_true(rt.equal(var_prevchar, rt.new_string('\r'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_thischar, rt.new_string('\n'))))) {
				rt.post_dec(this.data_string_position)
				break
			}
			var_buffer = rt.concat(var_buffer, var_thischar)
			if rt.is_true(rt.equal(var_thischar, rt.new_string('\n'))) {
				break
			}
			if rt.is_true(rt.greater_equal(this.data_string_position, this.data_string_length)) {
				break
			}
		var_prevchar = var_thischar.clone()
		}
	} else {
		for true {
			var_thischar = rt.call_function('fgetc', [rt.get_property(this.getid3, 'fp')])
			if rt.is_true(rt.equal(var_prevchar, rt.new_string('\r'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_thischar, rt.new_string('\n'))))) {
				rt.call_function('fseek', [rt.get_property(this.getid3, 'fp'), rt.new_int(-1), rt.get_constant('SEEK_CUR')])
				break
			}
			var_buffer = rt.concat(var_buffer, var_thischar)
			if rt.is_true(rt.equal(var_thischar, rt.new_string('\n'))) {
				break
			}
			if rt.is_true(rt.call_function('feof', [rt.get_property(this.getid3, 'fp')])) {
				break
			}
		var_prevchar = var_thischar.clone()
		}
	}
	return var_buffer.clone()
}

fn (mut this Class_getid3_handler) feof() rt.PhpVal {
	if this.data_string_flag {
		return rt.greater_equal(this.data_string_position, this.data_string_length)
	}
	return rt.call_function('feof', [rt.get_property(this.getid3, 'fp')])
}

fn (mut this Class_getid3_handler) isdependencyfor(var_module rt.PhpVal) rt.PhpVal {
	return rt.equal(this.dependency_to, var_module)
}

fn (mut this Class_getid3_handler) error(var_text rt.PhpVal) bool {
	rt.get_property(this.getid3, 'info').array_get_mut('error').array_push(var_text.clone())
	return false
}

fn (mut this Class_getid3_handler) warning(var_text rt.PhpVal) rt.PhpVal {
	return rt.call_method(this.getid3, 'warning', [var_text.clone()])
}

fn (mut this Class_getid3_handler) notice(var_text rt.PhpVal) {
}

fn (mut this Class_getid3_handler) saveattachment(var_name rt.PhpVal, var_offset rt.PhpVal, var_length rt.PhpVal, var_image_mime rt.PhpVal) rt.PhpVal {
	mut var_fp_dest := rt.new_null()
	mut var_dest := rt.new_null()
	if rt.is_true(rt.identical(rt.get_property(this.getid3, 'option_save_attachments'), Class_getID3.attachments_none())) {
		mut var_attachment := rt.new_null()
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	} else if rt.is_true(rt.identical(rt.get_property(this.getid3, 'option_save_attachments'), Class_getID3.attachments_inline())) {
		this.fseek(var_offset.clone(), rt.new_null())
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		var_attachment = rt.new_string(this.fread(var_length.clone()))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.is_true(rt.identical(var_attachment, rt.new_bool(false))) || rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_int(var_attachment.clone().to_string().len), var_length)))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('failed to read attachment data'))))
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	} else {
		mut var_dir := rt.new_string(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '/' }, rt.ArrayItem{ key: none, val: '\\' }]), rt.get_constant('DIRECTORY_SEPARATOR'), rt.get_property(this.getid3, 'option_save_attachments')]).to_string().trim_right(' \t\n\r'))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_dir.clone()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(Class_getID3.is_writable(var_dir.clone()))))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('supplied path (' + (var_dir).str() + ') does not exist, or is not writable')))
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut iife_temp_16 := Class_getid3_lib{}
		mut iife_result_16 := iife_temp_16.imageextfrommime(var_image_mime.clone())
		var_dest = rt.new_string((var_dir).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (var_name).str() + if rt.is_true(var_image_mime) { '.' + (iife_result_16).str() } else { '' })
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		var_fp_dest = rt.call_function('fopen', [var_dest.clone(), rt.new_string('wb')])
		if rt.is_true(rt.equal(var_fp_dest, rt.new_bool(false))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('failed to create file ' + (var_dest).str())))
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		this.fseek(var_offset.clone(), rt.new_null())
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut var_buffersize := if this.data_string_flag { var_length } else { rt.call_method(this.getid3, 'fread_buffer_size', []rt.PhpVal{}) }
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut var_bytesleft := var_length
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		for rt.is_true(rt.greater(var_bytesleft, rt.new_int(0))) {
			mut var_buffer := rt.new_string(this.fread(rt.call_function('min', [var_buffersize.clone(), var_bytesleft.clone()])))
			mut var_byteswritten := rt.call_function('fwrite', [var_fp_dest.clone(), var_buffer.clone()])
			if rt.is_true(rt.identical(var_buffer, rt.new_bool(false))) || rt.is_true(rt.identical(var_byteswritten, rt.new_bool(false))) || rt.is_true(rt.identical(var_byteswritten, rt.new_int(0))) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(if rt.is_true(rt.identical(var_buffer, rt.new_bool(false))) { 'not enough data to read' } else { 'failed to write to destination file, may be not enough disk space' })))
				if rt.has_exception() { unsafe { goto catch_label_4 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_4 } }
			var_bytesleft = rt.sub(var_bytesleft, var_byteswritten)
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		rt.call_function('fclose', [var_fp_dest.clone()])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		var_attachment = var_dest.clone()
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.clone()
		if !(var_fp_dest).is_null() && rt.is_true(rt.call_function('is_resource', [var_fp_dest.clone()])) {
			rt.call_function('fclose', [var_fp_dest.clone()])
		}
		if !(var_dest).is_null() && rt.is_true(rt.call_function('file_exists', [var_dest.clone()])) {
			rt.call_function('unlink', [var_dest.clone()])
		}
		var_attachment = rt.new_null()
		this.warning(rt.new_string('Failed to extract attachment ' + (var_name).str() + ': ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()))
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	this.fseek(rt.add(var_offset, var_length), rt.new_null())
	return var_attachment.clone()
}

struct Class_getid3_exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

	fn (mut this Class_getid3_exception) construct(var_message rt.PhpVal) {
		this.message = var_message.to_string()
	}

	fn (mut this Class_getid3_exception) getmessage() string {
		return this.message
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

struct Class_getid3_lib {
	rt.PhpObjectBase
}

struct Class_getid3_riff {
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

fn create_getid3_handler(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_getid3_handler {
	mut obj := &Class_getid3_handler{
		PhpObjectBase: rt.PhpObjectBase{}
		getid3: rt.new_null()
		data_string_flag: false
		data_string: rt.new_string('')
		data_string_position: rt.new_int(0)
		data_string_length: i64(0)
		dependency_to: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_getid3_exception(arg_0 rt.PhpVal) &Class_getid3_exception {
	mut obj := &Class_getid3_exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
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

fn create_getid3_lib(_args ...rt.PhpVal) &Class_getid3_lib {
	mut obj := &Class_getid3_lib{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_getid3_riff(_args ...rt.PhpVal) &Class_getid3_riff {
	mut obj := &Class_getid3_riff{
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
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_getID3](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'Analyze' {
			this.analyze()
			return rt.new_null()
		}
		'AnalyzeString' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.analyzestring(dispatch_arg_0)
			return rt.new_null()
		}
		'setStringMode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setstringmode(dispatch_arg_0)
			return rt.new_null()
		}
		'ftell' {
			return this.ftell()
		}
		'fread' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.fread(dispatch_arg_0))
		}
		'fseek' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.fseek(dispatch_arg_0, dispatch_arg_1))
		}
		'fgets' {
			return this.fgets()
		}
		'feof' {
			return this.feof()
		}
		'isDependencyFor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.isdependencyfor(dispatch_arg_0)
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.error(dispatch_arg_0))
		}
		'warning' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.warning(dispatch_arg_0)
		}
		'notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.notice(dispatch_arg_0)
			return rt.new_null()
		}
		'saveAttachment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.saveattachment(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_getid3_handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'getid3' { return this.getid3 }
		'data_string_flag' { return rt.new_bool(this.data_string_flag) }
		'data_string' { return this.data_string }
		'data_string_position' { return this.data_string_position }
		'data_string_length' { return rt.new_int(this.data_string_length) }
		'dependency_to' { return this.dependency_to }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_getid3_handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'getid3' { this.getid3 = val; return true }
		'data_string_flag' { this.data_string_flag = (val).to_bool(); return true }
		'data_string' { this.data_string = val; return true }
		'data_string_position' { this.data_string_position = val; return true }
		'data_string_length' { this.data_string_length = (val).to_i64(); return true }
		'dependency_to' { this.dependency_to = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_getid3_exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_getid3_exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_getid3_exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_getid3_riff) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_getid3_riff) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_getid3_riff) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('getID3', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_getid3()
		return rt.new_object('getID3', []string{}, obj)
	})
	rt.register_class_factory('getid3_handler', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		obj := create_getid3_handler(c_arg_0, c_arg_1)
		return rt.new_object('getid3_handler', []string{}, obj)
	})
	rt.register_class_factory('getid3_exception', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_getid3_exception(c_arg_0)
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
	rt.register_class_factory('getid3_riff', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_getid3_riff()
		return rt.new_object('getid3_riff', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_OS_ISWINDOWS')]))))) {
		rt.call_function('define', [rt.new_string('GETID3_OS_ISWINDOWS'), rt.identical(rt.call_function('stripos', [rt.get_constant('PHP_OS'), rt.new_string('WIN')]), rt.new_int(0))])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_INCLUDEPATH')]))))) {
		rt.call_function('define', [rt.new_string('GETID3_INCLUDEPATH'), rt.new_string((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str())])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ENT_SUBSTITUTE')]))))) {
		rt.call_function('define', [rt.new_string('ENT_SUBSTITUTE'), if rt.is_true(rt.call_function('defined', [rt.new_string('ENT_IGNORE')])) { rt.get_constant('ENT_IGNORE') } else { rt.new_int(8) }])
	}
	mut var_temp_dir := rt.call_function('ini_get', [rt.new_string('upload_tmp_dir')])
	if rt.is_true(var_temp_dir) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_temp_dir.clone()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [var_temp_dir.clone()]))))) {
	var_temp_dir = rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_temp_dir)))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('sys_get_temp_dir')])) {
	var_temp_dir = rt.call_function('sys_get_temp_dir', []rt.PhpVal{})
	}
	var_temp_dir = rt.call_function('realpath', [var_temp_dir.clone()])
	mut var_open_basedir := rt.call_function('ini_get', [rt.new_string('open_basedir')])
	if rt.is_true(var_open_basedir) {
		var_temp_dir = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '/' }, rt.ArrayItem{ key: none, val: '\\' }]), rt.get_constant('DIRECTORY_SEPARATOR'), var_temp_dir.clone()])
		var_open_basedir = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '/' }, rt.ArrayItem{ key: none, val: '\\' }]), rt.get_constant('DIRECTORY_SEPARATOR'), var_open_basedir.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('substr', [var_temp_dir.clone(), rt.new_int(-1), rt.new_int(1)]), rt.get_constant('DIRECTORY_SEPARATOR'))))) {
			var_temp_dir = rt.concat(var_temp_dir, rt.get_constant('DIRECTORY_SEPARATOR'))
		}
		mut var_found_valid_tempdir := false
		mut var_open_basedirs := rt.call_function('explode', [rt.get_constant('PATH_SEPARATOR'), var_open_basedir.clone()])
		mut iter_1 := var_open_basedirs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_basedir := item_1.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('substr', [var_basedir.clone(), rt.new_int(-1), rt.new_int(1)]), rt.get_constant('DIRECTORY_SEPARATOR'))))) {
				var_basedir = rt.concat(var_basedir, rt.get_constant('DIRECTORY_SEPARATOR'))
			}
			if rt.is_true(rt.identical(rt.call_function('strpos', [var_temp_dir.clone(), var_basedir.clone()]), rt.new_int(0))) {
				var_found_valid_tempdir = true
				break
			}
		}
		if !(var_found_valid_tempdir) {
		var_temp_dir = rt.new_string('')
		}
		var_open_basedirs = rt.new_null()
		var_found_valid_tempdir = false
		var_basedir = rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_temp_dir)))) {
	var_temp_dir = rt.new_string('*')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_TEMP_DIR')]))))) {
		rt.call_function('define', [rt.new_string('GETID3_TEMP_DIR'), var_temp_dir.clone()])
	}
	var_open_basedir = rt.new_null()
	var_temp_dir = rt.new_null()
}

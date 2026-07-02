import rt

struct Class_WP_Filesystem_Base {
	rt.PhpObjectBase
pub mut:
	verbose rt.PhpVal = rt.new_bool(false)
	cache   rt.PhpVal = rt.new_array()
	method  rt.PhpVal = rt.new_string('')
	errors  rt.PhpVal = rt.new_null()
	options rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Filesystem_Base) abspath() rt.PhpVal {
	mut var_folder := this.find_folder(rt.get_constant('ABSPATH'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_folder))))
		&& this.is_dir(rt.new_string('/' + (rt.get_constant('WPINC')).str())) {
		var_folder = rt.new_string('/')
	}
	return var_folder.clone()
}

fn (mut this Class_WP_Filesystem_Base) wp_content_dir() rt.PhpVal {
	return this.find_folder(rt.get_constant('WP_CONTENT_DIR'))
}

fn (mut this Class_WP_Filesystem_Base) wp_plugins_dir() rt.PhpVal {
	return this.find_folder(rt.get_constant('WP_PLUGIN_DIR'))
}

fn (mut this Class_WP_Filesystem_Base) wp_themes_dir(theme bool) rt.PhpVal {
	mut var_theme_root := rt.call_function('get_theme_root', [
		rt.new_bool(theme)])
	if rt.is_true(rt.identical(rt.new_string('/themes'), var_theme_root))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_theme_root.clone()]))))) {
		var_theme_root = rt.new_string(
			(rt.get_constant('WP_CONTENT_DIR')).str() + var_theme_root.str())
	}
	return this.find_folder(var_theme_root.clone())
}

fn (mut this Class_WP_Filesystem_Base) wp_lang_dir() rt.PhpVal {
	return this.find_folder(rt.get_constant('WP_LANG_DIR'))
}

fn (mut this Class_WP_Filesystem_Base) find_base_dir(base string, verbose bool) rt.PhpVal {
	mut base_mutated := base
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.7.0'),
		rt.new_string('WP_Filesystem_Base::abspath() or WP_Filesystem_Base::wp_*_dir()')])
	this.verbose = rt.new_bool(verbose)
	return this.abspath()
}

fn (mut this Class_WP_Filesystem_Base) get_base_dir(base string, verbose bool) rt.PhpVal {
	mut base_mutated := base
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.7.0'),
		rt.new_string('WP_Filesystem_Base::abspath() or WP_Filesystem_Base::wp_*_dir()')])
	this.verbose = rt.new_bool(verbose)
	return this.abspath()
}

fn (mut this Class_WP_Filesystem_Base) find_folder(var_folder rt.PhpVal) rt.PhpVal {
	mut var_folder_mutated := var_folder
	if this.cache.array_isset(var_folder_mutated) {
		return this.cache.array_get(var_folder_mutated)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [
		this.method,
		rt.new_string('ftp'),
	]), rt.new_bool(false)))))
	{
		mut var_constant_overrides := {
			'FTP_BASE':        rt.get_constant('ABSPATH')
			'FTP_CONTENT_DIR': rt.get_constant('WP_CONTENT_DIR')
			'FTP_PLUGIN_DIR':  rt.get_constant('WP_PLUGIN_DIR')
			'FTP_LANG_DIR':    rt.get_constant('WP_LANG_DIR')
		}
		for var_constant, var_dir in var_constant_overrides {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
				rt.new_string(constant),
			])))))
			{
				continue
			}
			if rt.is_true(rt.identical(var_folder_mutated, var_dir)) {
				return rt.call_function('trailingslashit', [
					rt.call_function('constant', [rt.new_string(constant)]),
				])
			}
		}
		for var_constant, var_dir in var_constant_overrides {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
				rt.new_string(constant),
			])))))
			{
				continue
			}
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [
				var_folder_mutated.clone(),
				var_dir.clone(),
			])))
			{
				mut var_potential_folder := rt.call_function('preg_replace', [
					rt.new_string('#^' +
						(rt.call_function('preg_quote', [var_dir.clone(), rt.new_string('#')])).str() +
						'/#i'),
					rt.call_function('trailingslashit', [
						rt.call_function('constant', [rt.new_string(constant)]),
					]),
					var_folder_mutated.clone(),
				])
				var_potential_folder = rt.call_function('trailingslashit', [
					var_potential_folder.clone()])
				if this.is_dir(var_potential_folder.clone()) {
					this.cache.array_set(var_folder_mutated, var_potential_folder.clone())
					return var_potential_folder.clone()
				}
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('direct'), this.method)) {
		var_folder_mutated = rt.call_function('str_replace', [
			rt.new_string('\\'), rt.new_string('/'), var_folder_mutated.clone()])
		return rt.call_function('trailingslashit', [var_folder_mutated.clone()])
	}
	var_folder_mutated = rt.call_function('preg_replace', [
		rt.new_string('|^([a-z]{1}):|i'),
		rt.new_string(''),
		var_folder_mutated.clone(),
	])
	var_folder_mutated = rt.call_function('str_replace', [rt.new_string('\\'),
		rt.new_string('/'), var_folder_mutated.clone()])
	if this.cache.array_isset(var_folder_mutated) {
		return this.cache.array_get(var_folder_mutated)
	}
	if this.exists(var_folder_mutated.clone()) {
		var_folder_mutated = rt.call_function('trailingslashit', [
			var_folder_mutated.clone()])
		this.cache.array_set(var_folder_mutated, var_folder_mutated.clone())
		return var_folder_mutated.clone()
	}
	mut var_return := rt.new_bool(this.search_for_folder(var_folder_mutated.clone(), '', false))
	if rt.is_true(var_return) {
		this.cache.array_set(var_folder_mutated, var_return.clone())
	}
	return var_return.clone()
}

fn (mut this Class_WP_Filesystem_Base) search_for_folder(var_folder rt.PhpVal, base string, loop bool) bool {
	mut var_folder_mutated := var_folder
	mut base_mutated := base
	if base_mutated == ''
		|| rt.is_true(rt.identical(rt.new_string('.'), rt.new_string(base_mutated))) {
		base_mutated = (rt.call_function('trailingslashit', [
			rt.new_bool(this.cwd())])).str()
	}
	var_folder_mutated = rt.call_function('untrailingslashit', [
		var_folder_mutated.clone()])
	if rt.is_true(this.verbose) {
		rt.call_function('printf', [
			rt.new_string('\n' +
				(rt.call_function('__', [rt.new_string('Looking for %1$s in %2$s')])).str() +
				'<br />\n'),
			var_folder_mutated.clone(),
			rt.new_string(base_mutated).clone(),
		])
	}
	mut var_folder_parts := rt.call_function('explode', [rt.new_string('/'),
		var_folder_mutated.clone()])
	mut var_folder_part_keys := rt.func_array_keys(var_folder_parts.clone())
	mut var_last_index := rt.call_function('array_pop', [var_folder_part_keys.clone()])
	mut var_last_path := var_folder_parts.array_get(var_last_index)
	mut var_files := rt.new_bool(this.dirlist(rt.new_string(base_mutated), false, false))
	mut iter_1 := var_folder_parts.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		mut var_index := item_1.key
		if rt.is_true(rt.identical(var_index, var_last_index)) {
			continue
		}
		if var_files.array_isset(var_key) {
			mut var_newdir := rt.call_function('trailingslashit', [
				rt.call_function('path_join', [rt.new_string(base_mutated).clone(),
					var_key.clone()]),
			])
			if rt.is_true(this.verbose) {
				rt.call_function('printf', [
					rt.new_string('\n' +
						(rt.call_function('__', [rt.new_string('Changing to %s')])).str() +
						'<br />\n'),
					var_newdir.clone(),
				])
			}
			mut var_newfolder := rt.call_function('implode', [
				rt.new_string('/'),
				rt.call_function('array_slice', [
					var_folder_parts.clone(), rt.add(var_index, rt.new_int(1))])])
			mut var_ret := rt.new_bool(this.search_for_folder(var_newfolder.clone(),
				var_newdir.str(), loop))
			if rt.is_true(var_ret) {
				return var_ret.to_bool()
			}
		}
	}
	if var_files.array_isset(var_last_path) {
		if rt.is_true(this.verbose) {
			rt.call_function('printf', [
				rt.new_string('\n' + (rt.call_function('__', [rt.new_string('Found %s')])).str() +
					'<br />\n'),
				rt.new_string(base_mutated + var_last_path.str()),
			])
		}
		return (rt.call_function('trailingslashit', [
			rt.new_string(base_mutated + var_last_path.str()),
		])).to_bool()
	}
	if var_loop || rt.is_true(rt.identical(rt.new_string('/'), rt.new_string(base_mutated))) {
		return false
	}
	return this.search_for_folder(var_folder_mutated.clone(), '/', true)
}

fn (mut this Class_WP_Filesystem_Base) gethchmod(var_file rt.PhpVal) rt.PhpVal {
	mut var_perms := rt.new_int(rt.new_string(this.getchmod(var_file.clone())).to_i64())
	if rt.bitwise_and(var_perms, rt.new_int(49152)) == 49152 {
		mut var_info := rt.new_string('s')
	} else if rt.bitwise_and(var_perms, rt.new_int(40960)) == 40960 {
		var_info = rt.new_string('l')
	} else if rt.bitwise_and(var_perms, rt.new_int(32768)) == 32768 {
		var_info = rt.new_string('-')
	} else if rt.bitwise_and(var_perms, rt.new_int(24576)) == 24576 {
		var_info = rt.new_string('b')
	} else if rt.bitwise_and(var_perms, rt.new_int(16384)) == 16384 {
		var_info = rt.new_string('d')
	} else if rt.bitwise_and(var_perms, rt.new_int(8192)) == 8192 {
		var_info = rt.new_string('c')
	} else if rt.bitwise_and(var_perms, rt.new_int(4096)) == 4096 {
		var_info = rt.new_string('p')
	} else {
		var_info = rt.new_string('u')
	}
	var_info = rt.concat(var_info, if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(256))) {
		'r'
	} else {
		'-'
	})
	var_info = rt.concat(var_info, if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(128))) {
		'w'
	} else {
		'-'
	})
	var_info = rt.concat(var_info, if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(64))) {
		if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(2048))) { 's' } else { 'x' }
	} else {
		if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(2048))) { 'S' } else { '-' }
	})
	var_info = rt.concat(var_info, if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(32))) {
		'r'
	} else {
		'-'
	})
	var_info = rt.concat(var_info, if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(16))) {
		'w'
	} else {
		'-'
	})
	var_info = rt.concat(var_info, if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(8))) {
		if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(1024))) { 's' } else { 'x' }
	} else {
		if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(1024))) { 'S' } else { '-' }
	})
	var_info = rt.concat(var_info, if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(4))) {
		'r'
	} else {
		'-'
	})
	var_info = rt.concat(var_info, if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(2))) {
		'w'
	} else {
		'-'
	})
	var_info = rt.concat(var_info, if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(1))) {
		if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(512))) { 't' } else { 'x' }
	} else {
		if rt.is_true(rt.bitwise_and(var_perms, rt.new_int(512))) { 'T' } else { '-' }
	})
	return var_info.clone()
}

fn (mut this Class_WP_Filesystem_Base) getchmod(var_file rt.PhpVal) string {
	return '777'
}

fn (mut this Class_WP_Filesystem_Base) getnumchmodfromh(var_mode rt.PhpVal) rt.PhpVal {
	mut var_mode_mutated := var_mode
	mut var_realmode := rt.new_string('')
	mut var_legal := rt.create_array([rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'w' }, rt.ArrayItem{ key: none, val: 'r' },
		rt.ArrayItem{ key: none, val: 'x' }, rt.ArrayItem{ key: none, val: '-' }])
	mut var_attarray := rt.call_function('preg_split', [rt.new_string('//'),
		var_mode_mutated.clone()])
	mut var_i := rt.new_int(0)
	mut var_c := rt.new_int(var_attarray.clone().array_count())
	for {
		if !(rt.is_true(rt.less(var_i, var_c))) { break
		 }
		mut var_key := rt.call_function('array_search', [var_attarray.array_get(var_i),
			var_legal.clone(), rt.new_bool(true)])
		if rt.is_true(var_key) {
			var_realmode = rt.concat(var_realmode, var_legal.array_get(var_key))
		}
		rt.post_inc(var_i)
	}
	var_mode_mutated = rt.call_function('str_pad', [var_realmode.clone(),
		rt.new_int(10), rt.new_string('-'), rt.get_constant('STR_PAD_LEFT')])
	mut var_trans := {
		'-': '0'
		'r': '4'
		'w': '2'
		'x': '1'
	}
	var_mode_mutated = rt.call_function('strtr', [var_mode_mutated.clone(),
		rt.create_array_from_native_map(var_trans)])
	mut var_newmode := var_mode_mutated.array_get(rt.new_int(0))
	var_newmode = rt.concat(var_newmode, rt.add(rt.add(var_mode_mutated.array_get(rt.new_int(1)),
		var_mode_mutated.array_get(rt.new_int(2))), var_mode_mutated.array_get(rt.new_int(3))))
	var_newmode = rt.concat(var_newmode, rt.add(rt.add(var_mode_mutated.array_get(rt.new_int(4)),
		var_mode_mutated.array_get(rt.new_int(5))), var_mode_mutated.array_get(rt.new_int(6))))
	var_newmode = rt.concat(var_newmode, rt.add(rt.add(var_mode_mutated.array_get(rt.new_int(7)),
		var_mode_mutated.array_get(rt.new_int(8))), var_mode_mutated.array_get(rt.new_int(9))))
	return var_newmode.clone()
}

fn (mut this Class_WP_Filesystem_Base) is_binary(var_text rt.PhpVal) bool {
	return (rt.call_function('preg_match', [rt.new_string('|[^\\x20-\\x7E]|'),
		var_text.clone()])).to_bool()
	return false
}

fn (mut this Class_WP_Filesystem_Base) chown(var_file rt.PhpVal, var_owner rt.PhpVal, recursive bool) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) connect() bool {
	return true
}

fn (mut this Class_WP_Filesystem_Base) get_contents(var_file rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) get_contents_array(var_file rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) put_contents(var_file rt.PhpVal, var_contents rt.PhpVal, mode bool) bool {
	mut mode_mutated := mode
	return false
}

fn (mut this Class_WP_Filesystem_Base) cwd() bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) chdir(var_dir rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) chgrp(var_file rt.PhpVal, var_group rt.PhpVal, recursive bool) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) chmod(var_file rt.PhpVal, mode bool, recursive bool) bool {
	mut mode_mutated := mode
	return false
}

fn (mut this Class_WP_Filesystem_Base) owner(var_file rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) group(var_file rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) copy(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool, mode bool) bool {
	mut mode_mutated := mode
	return false
}

fn (mut this Class_WP_Filesystem_Base) move(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) delete(var_file rt.PhpVal, recursive bool, type bool) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) exists(var_path rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) is_file(var_file rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) is_dir(var_path rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) is_readable(var_file rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) is_writable(var_path rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) atime(var_file rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) mtime(var_file rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) size(var_file rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) touch(var_file rt.PhpVal, time i64, atime i64) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) mkdir(var_path rt.PhpVal, chmod bool, chown bool, chgrp bool) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) rmdir(var_path rt.PhpVal, recursive bool) bool {
	return false
}

fn (mut this Class_WP_Filesystem_Base) dirlist(var_path rt.PhpVal, include_hidden bool, recursive bool) bool {
	return false
}

fn create_wp_filesystem_base(_args ...rt.PhpVal) &Class_WP_Filesystem_Base {
	mut obj := &Class_WP_Filesystem_Base{
		PhpObjectBase: rt.PhpObjectBase{}
		verbose:       rt.new_bool(false)
		cache:         rt.new_array()
		method:        rt.new_string('')
		errors:        rt.new_null()
		options:       rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_Filesystem_Base) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'abspath' {
			return this.abspath()
		}
		'wp_content_dir' {
			return this.wp_content_dir()
		}
		'wp_plugins_dir' {
			return this.wp_plugins_dir()
		}
		'wp_themes_dir' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.wp_themes_dir(dispatch_arg_0)
		}
		'wp_lang_dir' {
			return this.wp_lang_dir()
		}
		'find_base_dir' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.find_base_dir(dispatch_arg_0, dispatch_arg_1)
		}
		'get_base_dir' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_base_dir(dispatch_arg_0, dispatch_arg_1)
		}
		'find_folder' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.find_folder(dispatch_arg_0)
		}
		'search_for_folder' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.search_for_folder(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'gethchmod' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.gethchmod(dispatch_arg_0)
		}
		'getchmod' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.getchmod(dispatch_arg_0))
		}
		'getnumchmodfromh' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getnumchmodfromh(dispatch_arg_0)
		}
		'is_binary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_binary(dispatch_arg_0))
		}
		'chown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.chown(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'connect' {
			return rt.new_bool(this.connect())
		}
		'get_contents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_contents(dispatch_arg_0))
		}
		'get_contents_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_contents_array(dispatch_arg_0))
		}
		'put_contents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.put_contents(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'cwd' {
			return rt.new_bool(this.cwd())
		}
		'chdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.chdir(dispatch_arg_0))
		}
		'chgrp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.chgrp(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'chmod' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.chmod(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'owner' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.owner(dispatch_arg_0))
		}
		'group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.group(dispatch_arg_0))
		}
		'copy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.copy(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
		}
		'move' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.move(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.delete(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.exists(dispatch_arg_0))
		}
		'is_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_file(dispatch_arg_0))
		}
		'is_dir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_dir(dispatch_arg_0))
		}
		'is_readable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_readable(dispatch_arg_0))
		}
		'is_writable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_writable(dispatch_arg_0))
		}
		'atime' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.atime(dispatch_arg_0))
		}
		'mtime' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.mtime(dispatch_arg_0))
		}
		'size' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.size(dispatch_arg_0))
		}
		'touch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.touch(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'mkdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.mkdir(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
		}
		'rmdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.rmdir(dispatch_arg_0, dispatch_arg_1))
		}
		'dirlist' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.dirlist(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Filesystem_Base) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'verbose' { return this.verbose }
		'cache' { return this.cache }
		'method' { return this.method }
		'errors' { return this.errors }
		'options' { return this.options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Filesystem_Base) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'verbose' {
			this.verbose = val
			return true
		}
		'cache' {
			this.cache = val
			return true
		}
		'method' {
			this.method = val
			return true
		}
		'errors' {
			this.errors = val
			return true
		}
		'options' {
			this.options = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

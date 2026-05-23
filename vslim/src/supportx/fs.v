module supportx

import pathutil
import vphp

pub fn is_file(path string) bool {
	mut path_arg := vphp.PhpString.of(path)
	defer {
		path_arg.release()
	}
	return vphp.PhpFunction.named('is_file').result_bool(path_arg)
}

pub fn is_dir(path string) bool {
	mut path_arg := vphp.PhpString.of(path)
	defer {
		path_arg.release()
	}
	return vphp.PhpFunction.named('is_dir').result_bool(path_arg)
}

pub fn glob_paths(pattern string) []string {
	mut frame := vphp.PhpScope.frame()
	defer {
		frame.release()
	}
	return vphp.PhpFunction.named('glob').with_result[vphp.PhpArray, []string](fn (result vphp.PhpArray) []string {
		mut out := []string{}
		for item in result.to_string_list() {
			path := item.trim_space()
			if path != '' {
				out << path
			}
		}
		out.sort()
		return out
	}, frame.string(pattern)) or { []string{} }
}

pub fn scandir_names(path string) []string {
	mut path_arg := vphp.PhpString.of(path)
	defer {
		path_arg.release()
	}
	return vphp.PhpFunction.named('scandir').with_result[vphp.PhpArray, []string](fn (result vphp.PhpArray) []string {
		mut out := []string{}
		for item in result.to_string_list() {
			name := item.trim_space()
			if name == '' || name == '.' || name == '..' {
				continue
			}
			out << name
		}
		out.sort()
		return out
	}, path_arg) or { []string{} }
}

pub fn include_once_file(path string) vphp.PhpValue {
	return vphp.PhpIncludeFile.at(path).load_once()
}

pub fn class_exists(class_name string) bool {
	if class_name.trim_space() == '' {
		return false
	}
	mut class_arg := vphp.PhpString.of(class_name)
	mut autoload_arg := vphp.PhpBool.of(true)
	defer {
		class_arg.release()
		autoload_arg.release()
	}
	return vphp.PhpFunction.named('class_exists').result_bool(class_arg, autoload_arg)
}

pub fn is_windows_drive_root_path(path string) bool {
	return pathutil.is_windows_drive_root_path(path)
}

pub fn normalize_dir_path(path string) string {
	return pathutil.normalize_bootstrap_dir_path(path)
}

pub fn join_path(base string, child string) string {
	return pathutil.path_join(base, child)
}

pub fn dirname(path string) string {
	return pathutil.path_dirname(path)
}

pub fn file_stem(path string) string {
	return pathutil.path_file_stem(path)
}

pub fn is_bootstrap_dir_path(path string) bool {
	return pathutil.is_bootstrap_dir_path(path)
}

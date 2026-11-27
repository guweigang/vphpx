module compiler

import os
import v.cmdexec

pub struct PhpLinkFlags {
pub:
	includes []string
	ldflags  []string
	libs     []string
}

// php_link_flags reads the compiler flags for a PHP development installation.
pub fn php_link_flags(php_config string) !PhpLinkFlags {
	includes := php_config_args(php_config, '--includes')!
	ldflags := php_config_args(php_config, '--ldflags')!
	libs := php_config_args(php_config, '--libs')!
	return PhpLinkFlags{
		includes: includes
		ldflags:  ldflags.filter(!it.starts_with('-L') || it.len == 2 || os.exists(it[2..]))
		libs:     libs.filter(it != '-lzip')
	}
}

fn php_config_args(php_config string, option string) ![]string {
	result := os.exec([php_config, option])
	if result.exit_code != 0 {
		return error('${php_config} ${option} failed: ${result.output.trim_space()}')
	}
	return os.split_args(result.output)
}

// V emits some of its runtime support as separate native objects.
pub fn native_link_inputs(flags_path string) ![]string {
	mut inputs := []string{}
	for line in os.read_lines(flags_path)! {
		// The dump also contains C compiler and linker flags. The PHP extension
		// supplies its own flags and only adds V's separate object files.
		spelling := line.trim_space().trim('"')
		if !spelling.ends_with('.o') && !spelling.ends_with('.obj') {
			continue
		}
		args := cmdexec.split_args(line)!
		if args.len == 1 && os.is_abs_path(args[0]) {
			inputs << args[0]
		}
	}
	return inputs
}

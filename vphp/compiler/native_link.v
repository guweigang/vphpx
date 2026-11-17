module compiler

import os
import v.cmdexec

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

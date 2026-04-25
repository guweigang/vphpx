module main

import vphp

@[php_class: 'VSlim\\Cli\\App']
@[heap]
struct VSlimCliApp {
mut:
	core_app_ref      &VSlimApp = unsafe { nil } @[php_ignore]
	core_app_zref     vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	command_handlers  map[string]vphp.PersistentOwnedZBox @[php_ignore]
	command_order     []string @[php_ignore]
	command_aliases   map[string][]string @[php_ignore]
	command_hidden    map[string]bool @[php_ignore]
	command_canonical map[string]string @[php_ignore]
	project_root      string @[php_prop: projectRoot]
	last_command_name string @[php_ignore]
	last_raw_args     []string @[php_ignore]
	last_arguments    map[string]vphp.DynValue @[php_ignore]
	last_options      map[string]vphp.DynValue @[php_ignore]
	last_option_seen  map[string]bool @[php_ignore]
	last_warnings     []string @[php_ignore]
	last_input_parsed bool @[php_ignore]
	last_show_help    bool @[php_ignore]
	last_show_list    bool @[php_ignore]
	last_show_version bool @[php_ignore]
	current_trace     string @[php_ignore]
}

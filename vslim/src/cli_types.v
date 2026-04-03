module main

import vphp

@[php_class: 'VSlim\\Cli\\App']
@[heap]
struct VSlimCliApp {
mut:
	core_app_ref      &VSlimApp = unsafe { nil }
	core_app_zref     vphp.PersistentOwnedZVal = vphp.PersistentOwnedZVal.new_null()
	command_handlers  map[string]vphp.PersistentOwnedZVal
	command_order     []string
	command_aliases   map[string][]string
	command_hidden    map[string]bool
	command_canonical map[string]string
	project_root      string
	last_command_name string
	last_raw_args     []string
	last_arguments    map[string]vphp.DynValue
	last_options      map[string]vphp.DynValue
	last_option_seen  map[string]bool
	last_warnings     []string
	last_input_parsed bool
	current_trace     string
}

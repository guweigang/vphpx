module clix

import appx
import supportx
import vphp

@[php_class: 'VSlim\\Cli\\App']
@[heap]
pub struct VSlimCliApp {
mut:
	core_app_ref      &appx.VSlimApp = unsafe { nil } @[php_ignore]
	command_handlers  map[string]vphp.PhpValue @[php_ignore]
	command_order     []string @[php_ignore]
	command_aliases   map[string][]string @[php_ignore]
	command_hidden    map[string]bool @[php_ignore]
	command_canonical map[string]string @[php_ignore]
	bootstrap_progress map[string]&supportx.BootstrapProgress @[php_ignore]
	project_root      string @[php_prop: projectRoot]
	command_context  &CliCommandContext = &CliCommandContext{} @[php_ignore]
	invocation_depth int @[php_ignore]
}

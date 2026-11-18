module clix

import appx
import supportx
import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Cli\\App')]
@[heap]
pub struct VSlimCliApp {
mut:
	core_app_ref       &appx.VSlimApp = unsafe { nil }        @[vphp.PhpIgnoreField]
	command_handlers   map[string]vphp.PhpValue               @[vphp.PhpIgnoreField]
	command_order      []string                               @[vphp.PhpIgnoreField]
	command_aliases    map[string][]string                    @[vphp.PhpIgnoreField]
	command_hidden     map[string]bool                        @[vphp.PhpIgnoreField]
	command_canonical  map[string]string                      @[vphp.PhpIgnoreField]
	bootstrap_progress map[string]&supportx.BootstrapProgress @[vphp.PhpIgnoreField]
	project_root       string @[vphp.PhpProperty; vphp.PhpProperty_name: 'projectRoot']
	command_context    &CliCommandContext = &CliCommandContext{} @[vphp.PhpIgnoreField]
	invocation_depth   int @[vphp.PhpIgnoreField]
}

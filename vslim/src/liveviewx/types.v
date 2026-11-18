module liveviewx

import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Live\\View')]
@[heap]
pub struct VSlimLiveView {
mut:
	host    VSlimViewHost
	root_id string @[vphp.PhpProperty; vphp.PhpProperty_name: 'rootId']
	sockets map[string]&VSlimLiveSocket
}

@[vphp.PhpExportClass(name: 'VSlim\\Live\\Component')]
@[heap]
pub struct VSlimLiveComponent {
mut:
	host       VSlimViewHost
	id         string
	assigns    map[string]string
	socket_ref &VSlimLiveSocket = unsafe { nil } @[vphp.PhpIgnoreField]
}

@[vphp.PhpExportClass(name: 'VSlim\\Live\\ComponentState')]
@[heap]
pub struct VSlimLiveComponentState {
mut:
	component_id string @[vphp.PhpProperty; vphp.PhpProperty_name: 'componentId']
	socket_ref   &VSlimLiveSocket = unsafe { nil } @[vphp.PhpIgnoreField]
}

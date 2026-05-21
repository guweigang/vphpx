module liveviewx

@[php_class: 'VSlim\\Live\\View']
@[heap]
pub struct VSlimLiveView {
mut:
	host    VSlimViewHost
	root_id string @[php_prop: rootId]
	sockets map[string]&VSlimLiveSocket
}

@[php_class: 'VSlim\\Live\\Component']
@[heap]
pub struct VSlimLiveComponent {
mut:
	host       VSlimViewHost
	id         string
	assigns    map[string]string
	socket_ref &VSlimLiveSocket = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Live\\ComponentState']
@[heap]
pub struct VSlimLiveComponentState {
mut:
	component_id string           @[php_prop: componentId]
	socket_ref   &VSlimLiveSocket = unsafe { nil } @[php_ignore]
}

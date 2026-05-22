module mcpx

import vphp

#include "php_bridge.h"

__global C.vslim__mcp__app_ce &C.zend_class_entry

@[export: 'vslim_mcp_app_new_raw']
pub fn vslim_mcp_app_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimMcpApp]()
}
@[export: 'vslim_mcp_app_free_raw']
pub fn vslim_mcp_app_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimMcpApp](ptr)
}
@[export: 'vslim_mcp_app_cleanup_raw']
pub fn vslim_mcp_app_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimMcpApp(ptr)
        obj.cleanup()
    }
}
@[export: 'vslim_mcp_app_get_prop']
pub fn vslim_mcp_app_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_mcp_app_set_prop']
pub fn vslim_mcp_app_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_mcp_app_sync_props']
pub fn vslim_mcp_app_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_mcp_app_construct']
pub fn vphp_wrap_vslim_mcp_app_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'serverInfo', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'serverCapabilities', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'serverInfo').array()
    arg_1 := php_args.at_named_or_index(1, 'serverCapabilities').array()
    res := recv.construct(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_mcp_app_server_info']
pub fn vphp_wrap_vslim_mcp_app_server_info(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'info', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'info').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.server_info(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_mcp_app_capability']
pub fn vphp_wrap_vslim_mcp_app_capability(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'definition', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'definition').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := recv.capability(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_mcp_app_capabilities']
pub fn vphp_wrap_vslim_mcp_app_capabilities(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'definitions', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'definitions').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.capabilities(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_mcp_app_register']
pub fn vphp_wrap_vslim_mcp_app_register(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'method').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').callable() or {
        vphp.throw_exception('argument 1 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.register(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_mcp_app_tool']
pub fn vphp_wrap_vslim_mcp_app_tool(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'description', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'inputSchema', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'description').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'inputSchema').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return unsafe { nil }
    }
    arg_3 := php_args.at_named_or_index(3, 'handler').callable() or {
        vphp.throw_exception('argument 3 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.tool(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_mcp_app_resource']
pub fn vphp_wrap_vslim_mcp_app_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uri', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'description', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'mimeType', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'uri').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'name').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'description').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'mimeType').as_v[string]()
    arg_4 := php_args.at_named_or_index(4, 'handler').callable() or {
        vphp.throw_exception('argument 4 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.resource(arg_0, arg_1, arg_2, arg_3, arg_4)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_mcp_app_prompt']
pub fn vphp_wrap_vslim_mcp_app_prompt(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'description', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'arguments', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'description').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'arguments').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return unsafe { nil }
    }
    arg_3 := php_args.at_named_or_index(3, 'handler').callable() or {
        vphp.throw_exception('argument 3 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.prompt(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_mcp_app_notification']
pub fn vphp_wrap_vslim_mcp_app_notification(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'method').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return
    }
    res := VSlimMcpApp.notification(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_request']
pub fn vphp_wrap_vslim_mcp_app_request(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'method', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').value
    arg_1 := php_args.at_named_or_index(1, 'method').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'params').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return
    }
    res := VSlimMcpApp.request(arg_0, arg_1, arg_2)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_sampling_request']
pub fn vphp_wrap_vslim_mcp_app_sampling_request(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'messages', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'modelPreferences', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'systemPrompt', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'maxTokens', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'temperature', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 6, name: 'tools', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 7, name: 'toolChoice', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').value
    arg_1 := php_args.at_named_or_index(1, 'messages').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return
    }
    arg_2 := php_args.at_named_or_index(2, 'modelPreferences').value
    arg_3 := php_args.at_named_or_index(3, 'systemPrompt').as_v[string]()
    arg_4 := php_args.at_named_or_index(4, 'maxTokens').as_v[int]()
    arg_5 := php_args.at_named_or_index(5, 'temperature').value
    arg_6 := php_args.at_named_or_index(6, 'tools').value
    arg_7 := php_args.at_named_or_index(7, 'toolChoice').value
    res := VSlimMcpApp.sampling_request(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_queued_result']
pub fn vphp_wrap_vslim_mcp_app_queued_result(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'result', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'notifications', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'protocolVersion', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'sessionId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 6, name: 'headers', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').value
    arg_1 := php_args.at_named_or_index(1, 'result').value
    arg_2 := php_args.at_named_or_index(2, 'notifications').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return
    }
    arg_3 := php_args.at_named_or_index(3, 'status').as_v[int]()
    arg_4 := php_args.at_named_or_index(4, 'protocolVersion').as_v[string]()
    arg_5 := php_args.at_named_or_index(5, 'sessionId').as_v[string]()
    arg_6 := php_args.at_named_or_index(6, 'headers').array() or {
        vphp.throw_exception('argument 6 must be array', 0)
        return
    }
    res := VSlimMcpApp.queued_result(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_queue_messages']
pub fn vphp_wrap_vslim_mcp_app_queue_messages(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'result', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'messages', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'protocolVersion', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'sessionId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 6, name: 'headers', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').value
    arg_1 := php_args.at_named_or_index(1, 'result').value
    arg_2 := php_args.at_named_or_index(2, 'messages').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return
    }
    arg_3 := php_args.at_named_or_index(3, 'status').as_v[int]()
    arg_4 := php_args.at_named_or_index(4, 'protocolVersion').as_v[string]()
    arg_5 := php_args.at_named_or_index(5, 'sessionId').as_v[string]()
    arg_6 := php_args.at_named_or_index(6, 'headers').array() or {
        vphp.throw_exception('argument 6 must be array', 0)
        return
    }
    res := VSlimMcpApp.queue_messages(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_notify']
pub fn vphp_wrap_vslim_mcp_app_notify(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'method', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'params', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'sessionId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'protocolVersion', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'result', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 6, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 7, name: 'headers', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').value
    arg_1 := php_args.at_named_or_index(1, 'method').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'params').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return
    }
    arg_3 := php_args.at_named_or_index(3, 'sessionId').as_v[string]()
    arg_4 := php_args.at_named_or_index(4, 'protocolVersion').as_v[string]()
    arg_5 := if php_args.has_named_or_index(5, 'result') { ?vphp.PhpValue(php_args.at_named_or_index(5, 'result').value) } else { none }
    arg_6 := if php_args.has_named_or_index(6, 'status') { php_args.at_named_or_index(6, 'status').as_v[int]() } else { 200 }
    arg_7 := php_args.at_named_or_index(7, 'headers').array()
    res := VSlimMcpApp.notify(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_queue_notification']
pub fn vphp_wrap_vslim_mcp_app_queue_notification(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'method', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'params', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'sessionId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'protocolVersion', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').value
    arg_1 := php_args.at_named_or_index(1, 'method').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'params').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return
    }
    arg_3 := php_args.at_named_or_index(3, 'sessionId').as_v[string]()
    arg_4 := php_args.at_named_or_index(4, 'protocolVersion').as_v[string]()
    res := VSlimMcpApp.queue_notification(arg_0, arg_1, arg_2, arg_3, arg_4)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_queue_request']
pub fn vphp_wrap_vslim_mcp_app_queue_request(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'responseId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'requestId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'method', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'params', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'sessionId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'protocolVersion', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'responseId').value
    arg_1 := php_args.at_named_or_index(1, 'requestId').value
    arg_2 := php_args.at_named_or_index(2, 'method').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'params').array() or {
        vphp.throw_exception('argument 3 must be array', 0)
        return
    }
    arg_4 := php_args.at_named_or_index(4, 'sessionId').as_v[string]()
    arg_5 := php_args.at_named_or_index(5, 'protocolVersion').as_v[string]()
    res := VSlimMcpApp.queue_request(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_queue_progress']
pub fn vphp_wrap_vslim_mcp_app_queue_progress(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'progressToken', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'progress', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'total', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'sessionId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 6, name: 'protocolVersion', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').value
    arg_1 := php_args.at_named_or_index(1, 'progressToken').value
    arg_2 := php_args.at_named_or_index(2, 'progress').value
    arg_3 := php_args.at_named_or_index(3, 'total').value
    arg_4 := php_args.at_named_or_index(4, 'message').as_v[string]()
    arg_5 := php_args.at_named_or_index(5, 'sessionId').as_v[string]()
    arg_6 := php_args.at_named_or_index(6, 'protocolVersion').as_v[string]()
    res := VSlimMcpApp.queue_progress(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_queue_log']
pub fn vphp_wrap_vslim_mcp_app_queue_log(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'level', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'data', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'logger', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'sessionId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 6, name: 'protocolVersion', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').value
    arg_1 := php_args.at_named_or_index(1, 'level').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'message').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'data').value
    arg_4 := php_args.at_named_or_index(4, 'logger').as_v[string]()
    arg_5 := php_args.at_named_or_index(5, 'sessionId').as_v[string]()
    arg_6 := php_args.at_named_or_index(6, 'protocolVersion').as_v[string]()
    res := VSlimMcpApp.queue_log(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_queue_sampling']
pub fn vphp_wrap_vslim_mcp_app_queue_sampling(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'responseId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'samplingId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'messages', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'sessionId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'protocolVersion', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'modelPreferences', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 6, name: 'systemPrompt', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 7, name: 'maxTokens', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'responseId').value
    arg_1 := php_args.at_named_or_index(1, 'samplingId').value
    arg_2 := php_args.at_named_or_index(2, 'messages').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return
    }
    arg_3 := php_args.at_named_or_index(3, 'sessionId').as_v[string]()
    arg_4 := php_args.at_named_or_index(4, 'protocolVersion').as_v[string]()
    arg_5 := php_args.at_named_or_index(5, 'modelPreferences').value
    arg_6 := php_args.at_named_or_index(6, 'systemPrompt').as_v[string]()
    arg_7 := php_args.at_named_or_index(7, 'maxTokens').as_v[int]()
    res := VSlimMcpApp.queue_sampling(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_client_capabilities']
pub fn vphp_wrap_vslim_mcp_app_client_capabilities(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'frame').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := VSlimMcpApp.client_capabilities(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_client_supports']
pub fn vphp_wrap_vslim_mcp_app_client_supports(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'frame').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'name').as_v[string]()
    res := VSlimMcpApp.client_supports(arg_0, arg_1)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_capability_error']
pub fn vphp_wrap_vslim_mcp_app_capability_error(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'frame').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'message').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'status').as_v[int]()
    res := VSlimMcpApp.capability_error(arg_0, arg_1, arg_2)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_require_capability']
pub fn vphp_wrap_vslim_mcp_app_require_capability(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'frame').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'name').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'message').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'status').as_v[int]()
    res := VSlimMcpApp.require_capability(arg_0, arg_1, arg_2, arg_3)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_handle_mcp_dispatch']
pub fn vphp_wrap_vslim_mcp_app_handle_mcp_dispatch(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'frame').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := recv.handle_mcp_dispatch(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_handle']
pub fn vphp_wrap_vslim_mcp_app_handle(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'frame').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := recv.handle(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_mcp_app_handle_mcp']
pub fn vphp_wrap_vslim_mcp_app_handle_mcp(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'frame').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := recv.handle_mcp(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vslim_mcp_app_handlers']
pub fn vslim_mcp_app_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_mcp_app_get_prop),
        write_handler: voidptr(vslim_mcp_app_set_prop),
        sync_handler: voidptr(vslim_mcp_app_sync_props),
        new_raw: voidptr(vslim_mcp_app_new_raw),
        cleanup_raw: voidptr(vslim_mcp_app_cleanup_raw),
        free_raw: voidptr(vslim_mcp_app_free_raw)
    )
}
pub fn VSlimMcpApp.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__mcp__app_ce)
}

pub fn VSlimMcpApp.php_object_handlers() voidptr {
    return vslim_mcp_app_handlers()
}

pub fn VSlimMcpApp.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimMcpApp](v_ptr, ownership)
}

pub fn (obj &VSlimMcpApp) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimMcpApp](obj)
}

pub fn (obj &VSlimMcpApp) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimMcpApp](obj)
}

pub fn (obj &VSlimMcpApp) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimMcpApp](obj)
}

pub fn (obj &VSlimMcpApp) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimMcpApp](obj)
}


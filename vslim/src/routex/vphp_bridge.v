module routex

import vphp

#include "php_bridge.h"

__global C.vslim__routegroup_ce &C.zend_class_entry

@[export: 'route_group_new_raw']
pub fn route_group_new_raw() voidptr {
    return vphp.generic_new_raw[RouteGroup]()
}
@[export: 'route_group_free_raw']
pub fn route_group_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[RouteGroup](ptr)
}
@[export: 'route_group_cleanup_raw']
pub fn route_group_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &RouteGroup(ptr)
        obj.cleanup()
    }
}
@[export: 'route_group_get_prop']
pub fn route_group_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'route_group_set_prop']
pub fn route_group_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'route_group_sync_props']
pub fn route_group_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_route_group_group']
pub fn vphp_wrap_route_group_group(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'prefix').as_v[string]()
    res := recv.group(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_middleware']
pub fn vphp_wrap_route_group_middleware(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'handler').value
    res := recv.middleware(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_before']
pub fn vphp_wrap_route_group_before(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'handler').value
    res := recv.before(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_after']
pub fn vphp_wrap_route_group_after(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'handler').value
    res := recv.after(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_get']
pub fn vphp_wrap_route_group_get(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.get(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_post']
pub fn vphp_wrap_route_group_post(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.post(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_put']
pub fn vphp_wrap_route_group_put(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.put(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_head']
pub fn vphp_wrap_route_group_head(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.head(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_options']
pub fn vphp_wrap_route_group_options(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.options(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_patch']
pub fn vphp_wrap_route_group_patch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.patch(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_delete']
pub fn vphp_wrap_route_group_delete(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.delete(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_any']
pub fn vphp_wrap_route_group_any(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.any(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_live']
pub fn vphp_wrap_route_group_live(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.live(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_websocket']
pub fn vphp_wrap_route_group_websocket(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.websocket(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_map']
pub fn vphp_wrap_route_group_map(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'methods', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'methods').value
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.map(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_get_named']
pub fn vphp_wrap_route_group_get_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.get_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_post_named']
pub fn vphp_wrap_route_group_post_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.post_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_put_named']
pub fn vphp_wrap_route_group_put_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.put_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_head_named']
pub fn vphp_wrap_route_group_head_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.head_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_options_named']
pub fn vphp_wrap_route_group_options_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.options_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_patch_named']
pub fn vphp_wrap_route_group_patch_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.patch_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_delete_named']
pub fn vphp_wrap_route_group_delete_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.delete_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_any_named']
pub fn vphp_wrap_route_group_any_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.any_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_websocket_named']
pub fn vphp_wrap_route_group_websocket_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.websocket_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_map_named']
pub fn vphp_wrap_route_group_map_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'methods', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'methods').value
    arg_1 := php_args.at_named_or_index(1, 'name').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'pattern').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'handler').value
    res := recv.map_named(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_resource']
pub fn vphp_wrap_route_group_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    res := recv.resource(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_api_resource']
pub fn vphp_wrap_route_group_api_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    res := recv.api_resource(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_singleton']
pub fn vphp_wrap_route_group_singleton(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    res := recv.singleton(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_api_singleton']
pub fn vphp_wrap_route_group_api_singleton(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    res := recv.api_singleton(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_resource_opts']
pub fn vphp_wrap_route_group_resource_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'options', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'options').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return unsafe { nil }
    }
    res := recv.resource_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_api_resource_opts']
pub fn vphp_wrap_route_group_api_resource_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'options', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'options').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return unsafe { nil }
    }
    res := recv.api_resource_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_singleton_opts']
pub fn vphp_wrap_route_group_singleton_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'options', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'options').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return unsafe { nil }
    }
    res := recv.singleton_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_route_group_api_singleton_opts']
pub fn vphp_wrap_route_group_api_singleton_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'options', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'options').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return unsafe { nil }
    }
    res := recv.api_singleton_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'route_group_handlers']
pub fn route_group_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(route_group_get_prop),
        write_handler: voidptr(route_group_set_prop),
        sync_handler: voidptr(route_group_sync_props),
        new_raw: voidptr(route_group_new_raw),
        cleanup_raw: voidptr(route_group_cleanup_raw),
        free_raw: voidptr(route_group_free_raw)
    )
}
pub fn RouteGroup.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__routegroup_ce)
}

pub fn RouteGroup.php_object_handlers() voidptr {
    return route_group_handlers()
}

pub fn RouteGroup.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[RouteGroup](v_ptr, ownership)
}

pub fn (obj &RouteGroup) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[RouteGroup](obj)
}

pub fn (obj &RouteGroup) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[RouteGroup](obj)
}

pub fn (obj &RouteGroup) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[RouteGroup](obj)
}

pub fn (obj &RouteGroup) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[RouteGroup](obj)
}


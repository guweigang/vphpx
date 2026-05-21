module controllerx

import vphp

import httpx
import viewx

#include "php_bridge.h"

__global C.vslim__controller_ce &C.zend_class_entry

@[export: 'VSlimController_new_raw']
pub fn vslimcontroller_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimController]()
}
@[export: 'VSlimController_free_raw']
pub fn vslimcontroller_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimController](ptr)
}
@[export: 'VSlimController_cleanup_raw']
pub fn vslimcontroller_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimController_get_prop']
pub fn vslimcontroller_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimController_set_prop']
pub fn vslimcontroller_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimController_sync_props']
pub fn vslimcontroller_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimController_construct']
pub fn vphp_wrap_vslimcontroller_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'app', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'app').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    res := recv.construct(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_set_app']
pub fn vphp_wrap_vslimcontroller_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'app', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'app').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_set_view']
pub fn vphp_wrap_vslimcontroller_set_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'view', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &viewx.VSlimView(php_args.at_named_or_index(0, 'view').raw_obj()) }
    res := recv.set_view(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_app']
pub fn vphp_wrap_vslimcontroller_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.app()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'vphp_wrap_VSlimController_view']
pub fn vphp_wrap_vslimcontroller_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.view()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_render']
pub fn vphp_wrap_vslimcontroller_render(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'data').value
    res := recv.render(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_render_with_layout']
pub fn vphp_wrap_vslimcontroller_render_with_layout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'layout', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'layout').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'data').value
    res := recv.render_with_layout(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_url_for']
pub fn vphp_wrap_vslimcontroller_url_for(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    res := recv.url_for(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimController_url_for_query']
pub fn vphp_wrap_vslimcontroller_url_for_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'query', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    arg_2 := php_args.at_named_or_index(2, 'query').value
    res := recv.url_for_query(arg_0, arg_1, arg_2)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimController_text']
pub fn vphp_wrap_vslimcontroller_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'body', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'body').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'status').as_v[int]()
    res := recv.text(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_json']
pub fn vphp_wrap_vslimcontroller_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'body', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'body').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'status').as_v[int]()
    res := recv.json(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_redirect']
pub fn vphp_wrap_vslimcontroller_redirect(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'location', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'location').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'status').as_v[int]()
    res := recv.redirect(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_redirect_to']
pub fn vphp_wrap_vslimcontroller_redirect_to(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    arg_2 := php_args.at_named_or_index(2, 'status').as_v[int]()
    res := recv.redirect_to(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_redirect_to_query']
pub fn vphp_wrap_vslimcontroller_redirect_to_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'query', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    arg_2 := php_args.at_named_or_index(2, 'query').value
    arg_3 := php_args.at_named_or_index(3, 'status').as_v[int]()
    res := recv.redirect_to_query(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'VSlimController_handlers']
pub fn vslimcontroller_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimcontroller_get_prop),
        write_handler: voidptr(vslimcontroller_set_prop),
        sync_handler: voidptr(vslimcontroller_sync_props),
        new_raw: voidptr(vslimcontroller_new_raw),
        cleanup_raw: voidptr(vslimcontroller_cleanup_raw),
        free_raw: voidptr(vslimcontroller_free_raw)
    )
}
pub fn VSlimController.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__controller_ce)
}

pub fn VSlimController.php_object_handlers() voidptr {
    return vslimcontroller_handlers()
}

pub fn VSlimController.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimController](v_ptr, ownership)
}

pub fn (obj &VSlimController) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimController](obj)
}

pub fn (obj &VSlimController) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimController](obj)
}

pub fn (obj &VSlimController) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimController](obj)
}

pub fn (obj &VSlimController) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimController](obj)
}


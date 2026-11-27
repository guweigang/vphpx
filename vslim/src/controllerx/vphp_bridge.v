module controllerx

import vphp
import vphp.object

import httpx
import viewx

#include "php_bridge.h"

__global C.vslim__controller_ce &C.zend_class_entry

@[export: 'vslim_controller_new_raw']
pub fn vslim_controller_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimController]()
}
@[export: 'vslim_controller_free_raw']
pub fn vslim_controller_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimController](ptr)
}
@[export: 'vslim_controller_cleanup_raw']
pub fn vslim_controller_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_controller_get_prop']
pub fn vslim_controller_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_controller_set_prop']
pub fn vslim_controller_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_controller_sync_props']
pub fn vslim_controller_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_controller_construct']
pub fn vphp_wrap_vslim_controller_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'app' },
    ])
    arg_0 := php_args.at(0).object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.construct(arg_0)
    ctx.return().return_v_object[VSlimController](res, .borrowed)
}
@[export: 'vphp_wrap_vslim_controller_set_app']
pub fn vphp_wrap_vslim_controller_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'app' },
    ])
    arg_0 := php_args.at(0).object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_controller_set_view']
pub fn vphp_wrap_vslim_controller_set_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'view' },
    ])
    arg_0 := if !php_args.at(0).is_present() || php_args.at(0).zval().is_null() {
        ?&viewx.VSlimView(none)
    } else {
        bound_value := php_args.at(0).bound_v_object[viewx.VSlimView]() or {
            vphp.PhpException.raise_class('TypeError', err.msg(), 0)
            return unsafe { nil }
        }
        ?&viewx.VSlimView(bound_value)
    }
    res := recv.set_view(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_controller_app']
pub fn vphp_wrap_vslim_controller_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.app()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'vphp_wrap_vslim_controller_view']
pub fn vphp_wrap_vslim_controller_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.view()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_controller_render']
pub fn vphp_wrap_vslim_controller_render(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template' },
        vphp.PhpArgMeta{ index: 1, name: 'data' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    res := recv.render(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_controller_render_with_layout']
pub fn vphp_wrap_vslim_controller_render_with_layout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template' },
        vphp.PhpArgMeta{ index: 1, name: 'layout' },
        vphp.PhpArgMeta{ index: 2, name: 'data' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).value
    res := recv.render_with_layout(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_controller_url_for']
pub fn vphp_wrap_vslim_controller_url_for(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name' },
        vphp.PhpArgMeta{ index: 1, name: 'params' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    res := recv.url_for(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_controller_url_for_query']
pub fn vphp_wrap_vslim_controller_url_for_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name' },
        vphp.PhpArgMeta{ index: 1, name: 'params' },
        vphp.PhpArgMeta{ index: 2, name: 'query' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    arg_2 := php_args.at(2).value
    res := recv.url_for_query(arg_0, arg_1, arg_2)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_controller_text']
pub fn vphp_wrap_vslim_controller_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'body' },
        vphp.PhpArgMeta{ index: 1, name: 'status' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[int]()
    res := recv.text(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_controller_json']
pub fn vphp_wrap_vslim_controller_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'body' },
        vphp.PhpArgMeta{ index: 1, name: 'status' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[int]()
    res := recv.json(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_controller_redirect']
pub fn vphp_wrap_vslim_controller_redirect(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'location' },
        vphp.PhpArgMeta{ index: 1, name: 'status', use_php_default: true },
    ]) or {
        return unsafe { nil }
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[int]()
    res := recv.redirect(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_controller_redirect_to']
pub fn vphp_wrap_vslim_controller_redirect_to(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'name' },
        vphp.PhpArgMeta{ index: 1, name: 'params' },
        vphp.PhpArgMeta{ index: 2, name: 'status', use_php_default: true },
    ]) or {
        return unsafe { nil }
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    arg_2 := php_args.at(2).as_v[int]()
    res := recv.redirect_to(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_controller_redirect_to_query']
pub fn vphp_wrap_vslim_controller_redirect_to_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'name' },
        vphp.PhpArgMeta{ index: 1, name: 'params' },
        vphp.PhpArgMeta{ index: 2, name: 'query' },
        vphp.PhpArgMeta{ index: 3, name: 'status', use_php_default: true },
    ]) or {
        return unsafe { nil }
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    arg_2 := php_args.at(2).value
    arg_3 := php_args.at(3).as_v[int]()
    res := recv.redirect_to_query(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vslim_controller_handlers']
pub fn vslim_controller_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_controller_get_prop,
        write_handler: vslim_controller_set_prop,
        sync_handler: vslim_controller_sync_props,
        new_raw: vslim_controller_new_raw,
        cleanup_raw: vslim_controller_cleanup_raw,
        free_raw: vslim_controller_free_raw
    )
}
pub fn VSlimController.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__controller_ce)
}

pub fn VSlimController.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_controller_handlers())
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

pub fn (val VSlimController) php_class_name() string {
    return 'VSlim\\Controller'
}


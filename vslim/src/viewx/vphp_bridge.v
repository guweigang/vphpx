module viewx

import vphp

import httpx

#include "php_bridge.h"

__global C.vslim__view_ce &C.zend_class_entry

@[export: 'vslim_view_new_raw']
pub fn vslim_view_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimView]()
}
@[export: 'vslim_view_free_raw']
pub fn vslim_view_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimView](ptr)
}
@[export: 'vslim_view_cleanup_raw']
pub fn vslim_view_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimView(ptr)
        obj.cleanup()
    }
}
@[export: 'vslim_view_get_prop']
pub fn vslim_view_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimView(ptr)
        if name == 'basePath' {
            ret.v[string](obj.base_path)
            return
        }
        if name == 'assetsPrefix' {
            ret.v[string](obj.assets_prefix)
            return
        }
        if name == 'cacheEnabled' {
            ret.v[bool](obj.cache_enabled)
            return
        }
    }
}
@[export: 'vslim_view_set_prop']
pub fn vslim_view_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimView(ptr)
        if name == 'basePath' {
            obj.base_path = arg.get_string()
            return
        }
        if name == 'assetsPrefix' {
            obj.assets_prefix = arg.get_string()
            return
        }
        if name == 'cacheEnabled' {
            obj.cache_enabled = arg.get_bool()
            return
        }
    }
}
@[export: 'vslim_view_sync_props']
pub fn vslim_view_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimView(ptr)
        out.add_property_string('basePath', obj.base_path)
        out.add_property_string('assetsPrefix', obj.assets_prefix)
        out.add_property_bool('cacheEnabled', obj.cache_enabled)
    }
}
@[export: 'vphp_wrap_vslim_view_render_response']
pub fn vphp_wrap_vslim_view_render_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'data').value
    res := recv.render_response(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_view_render_response_with_layout']
pub fn vphp_wrap_vslim_view_render_response_with_layout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
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
    res := recv.render_response_with_layout(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_view_construct']
pub fn vphp_wrap_vslim_view_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'basePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'assetsPrefix', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'basePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'assetsPrefix').as_v[string]()
    res := recv.construct(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_view_set_base_path']
pub fn vphp_wrap_vslim_view_set_base_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'basePath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'basePath').as_v[string]()
    res := recv.set_base_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_view_base_path']
pub fn vphp_wrap_vslim_view_base_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.base_path()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_view_set_assets_prefix']
pub fn vphp_wrap_vslim_view_set_assets_prefix(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'prefix').as_v[string]()
    res := recv.set_assets_prefix(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_view_assets_prefix']
pub fn vphp_wrap_vslim_view_assets_prefix(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.assets_prefix()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_view_set_cache_enabled']
pub fn vphp_wrap_vslim_view_set_cache_enabled(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'enabled', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'enabled').as_v[bool]()
    res := recv.set_cache_enabled(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_view_cache_enabled']
pub fn vphp_wrap_vslim_view_cache_enabled(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.cache_enabled()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_view_clear_cache']
pub fn vphp_wrap_vslim_view_clear_cache(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_cache()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_view_helper']
pub fn vphp_wrap_vslim_view_helper(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').callable() or {
        vphp.throw_exception('argument 1 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.helper(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_view_asset']
pub fn vphp_wrap_vslim_view_asset(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.asset(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_view_render']
pub fn vphp_wrap_vslim_view_render(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'data').value
    res := recv.render(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_view_render_with_layout']
pub fn vphp_wrap_vslim_view_render_with_layout(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
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
    ctx.return().v[string](res)
}
@[export: 'vslim_view_handlers']
pub fn vslim_view_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_view_get_prop),
        write_handler: voidptr(vslim_view_set_prop),
        sync_handler: voidptr(vslim_view_sync_props),
        new_raw: voidptr(vslim_view_new_raw),
        cleanup_raw: voidptr(vslim_view_cleanup_raw),
        free_raw: voidptr(vslim_view_free_raw)
    )
}
pub fn VSlimView.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__view_ce)
}

pub fn VSlimView.php_object_handlers() voidptr {
    return vslim_view_handlers()
}

pub fn VSlimView.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimView](v_ptr, ownership)
}

pub fn (obj &VSlimView) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimView](obj)
}

pub fn (obj &VSlimView) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimView](obj)
}

pub fn (obj &VSlimView) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimView](obj)
}

pub fn (obj &VSlimView) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimView](obj)
}


module supportx

import vphp

#include "php_bridge.h"

__global C.vslim__support__serviceprovider_ce &C.zend_class_entry
__global C.vslim__support__module_ce &C.zend_class_entry

@[export: 'VSlimServiceProvider_new_raw']
pub fn vslimserviceprovider_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimServiceProvider]()
}
@[export: 'VSlimServiceProvider_free_raw']
pub fn vslimserviceprovider_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimServiceProvider](ptr)
}
@[export: 'VSlimServiceProvider_cleanup_raw']
pub fn vslimserviceprovider_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimServiceProvider(ptr)
        obj.cleanup()
    }
}
@[export: 'VSlimServiceProvider_get_prop']
pub fn vslimserviceprovider_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimServiceProvider_set_prop']
pub fn vslimserviceprovider_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimServiceProvider_sync_props']
pub fn vslimserviceprovider_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimServiceProvider_construct']
pub fn vphp_wrap_vslimserviceprovider_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimServiceProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimServiceProvider_set_app']
pub fn vphp_wrap_vslimserviceprovider_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimServiceProvider(ptr) }
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
@[export: 'vphp_wrap_VSlimServiceProvider_has_app']
pub fn vphp_wrap_vslimserviceprovider_has_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimServiceProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_app()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimServiceProvider_app']
pub fn vphp_wrap_vslimserviceprovider_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimServiceProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.app()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'VSlimServiceProvider_handlers']
pub fn vslimserviceprovider_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimserviceprovider_get_prop),
        write_handler: voidptr(vslimserviceprovider_set_prop),
        sync_handler: voidptr(vslimserviceprovider_sync_props),
        new_raw: voidptr(vslimserviceprovider_new_raw),
        cleanup_raw: voidptr(vslimserviceprovider_cleanup_raw),
        free_raw: voidptr(vslimserviceprovider_free_raw)
    )
}
pub fn VSlimServiceProvider.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__support__serviceprovider_ce)
}

pub fn VSlimServiceProvider.php_object_handlers() voidptr {
    return vslimserviceprovider_handlers()
}

pub fn VSlimServiceProvider.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimServiceProvider](v_ptr, ownership)
}

pub fn (obj &VSlimServiceProvider) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimServiceProvider](obj)
}

pub fn (obj &VSlimServiceProvider) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimServiceProvider](obj)
}

pub fn (obj &VSlimServiceProvider) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimServiceProvider](obj)
}

pub fn (obj &VSlimServiceProvider) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimServiceProvider](obj)
}

@[export: 'VSlimModule_new_raw']
pub fn vslimmodule_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimModule]()
}
@[export: 'VSlimModule_free_raw']
pub fn vslimmodule_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimModule](ptr)
}
@[export: 'VSlimModule_cleanup_raw']
pub fn vslimmodule_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimModule(ptr)
        obj.cleanup()
    }
}
@[export: 'VSlimModule_get_prop']
pub fn vslimmodule_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimModule_set_prop']
pub fn vslimmodule_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimModule_sync_props']
pub fn vslimmodule_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimModule_construct']
pub fn vphp_wrap_vslimmodule_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimModule(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimModule_set_app']
pub fn vphp_wrap_vslimmodule_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimModule(ptr) }
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
@[export: 'vphp_wrap_VSlimModule_has_app']
pub fn vphp_wrap_vslimmodule_has_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModule(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_app()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimModule_app']
pub fn vphp_wrap_vslimmodule_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModule(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.app()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'VSlimModule_handlers']
pub fn vslimmodule_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimmodule_get_prop),
        write_handler: voidptr(vslimmodule_set_prop),
        sync_handler: voidptr(vslimmodule_sync_props),
        new_raw: voidptr(vslimmodule_new_raw),
        cleanup_raw: voidptr(vslimmodule_cleanup_raw),
        free_raw: voidptr(vslimmodule_free_raw)
    )
}
pub fn VSlimModule.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__support__module_ce)
}

pub fn VSlimModule.php_object_handlers() voidptr {
    return vslimmodule_handlers()
}

pub fn VSlimModule.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimModule](v_ptr, ownership)
}

pub fn (obj &VSlimModule) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimModule](obj)
}

pub fn (obj &VSlimModule) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimModule](obj)
}

pub fn (obj &VSlimModule) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimModule](obj)
}

pub fn (obj &VSlimModule) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimModule](obj)
}


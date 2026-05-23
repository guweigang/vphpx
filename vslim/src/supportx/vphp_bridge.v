module supportx

import vphp

#include "php_bridge.h"

__global C.vslim__psr20__clock_ce &C.zend_class_entry
__global C.vslim__support__serviceprovider_ce &C.zend_class_entry
__global C.vslim__support__module_ce &C.zend_class_entry
__global C.vslim__envloader_ce &C.zend_class_entry

@[export: 'vslim_psr20_clock_new_raw']
pub fn vslim_psr20_clock_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr20Clock]()
}
@[export: 'vslim_psr20_clock_free_raw']
pub fn vslim_psr20_clock_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr20Clock](ptr)
}
@[export: 'vslim_psr20_clock_cleanup_raw']
pub fn vslim_psr20_clock_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_psr20_clock_get_prop']
pub fn vslim_psr20_clock_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr20_clock_set_prop']
pub fn vslim_psr20_clock_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr20_clock_sync_props']
pub fn vslim_psr20_clock_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_psr20_clock_construct']
pub fn vphp_wrap_vslim_psr20_clock_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr20Clock(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr20_clock_now']
pub fn vphp_wrap_vslim_psr20_clock_now(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr20Clock(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.now()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'vslim_psr20_clock_handlers']
pub fn vslim_psr20_clock_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr20_clock_get_prop),
        write_handler: voidptr(vslim_psr20_clock_set_prop),
        sync_handler: voidptr(vslim_psr20_clock_sync_props),
        new_raw: voidptr(vslim_psr20_clock_new_raw),
        cleanup_raw: voidptr(vslim_psr20_clock_cleanup_raw),
        free_raw: voidptr(vslim_psr20_clock_free_raw)
    )
}
pub fn VSlimPsr20Clock.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr20__clock_ce)
}

pub fn VSlimPsr20Clock.php_object_handlers() voidptr {
    return vslim_psr20_clock_handlers()
}

pub fn VSlimPsr20Clock.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr20Clock](v_ptr, ownership)
}

pub fn (obj &VSlimPsr20Clock) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr20Clock](obj)
}

pub fn (obj &VSlimPsr20Clock) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr20Clock](obj)
}

pub fn (obj &VSlimPsr20Clock) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr20Clock](obj)
}

pub fn (obj &VSlimPsr20Clock) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr20Clock](obj)
}

@[export: 'vslim_service_provider_new_raw']
pub fn vslim_service_provider_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimServiceProvider]()
}
@[export: 'vslim_service_provider_free_raw']
pub fn vslim_service_provider_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimServiceProvider](ptr)
}
@[export: 'vslim_service_provider_cleanup_raw']
pub fn vslim_service_provider_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimServiceProvider(ptr)
        obj.cleanup()
    }
}
@[export: 'vslim_service_provider_get_prop']
pub fn vslim_service_provider_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_service_provider_set_prop']
pub fn vslim_service_provider_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_service_provider_sync_props']
pub fn vslim_service_provider_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_service_provider_construct']
pub fn vphp_wrap_vslim_service_provider_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimServiceProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_service_provider_set_app']
pub fn vphp_wrap_vslim_service_provider_set_app(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_service_provider_has_app']
pub fn vphp_wrap_vslim_service_provider_has_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimServiceProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_app()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_service_provider_app']
pub fn vphp_wrap_vslim_service_provider_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimServiceProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.app()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'vslim_service_provider_handlers']
pub fn vslim_service_provider_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_service_provider_get_prop),
        write_handler: voidptr(vslim_service_provider_set_prop),
        sync_handler: voidptr(vslim_service_provider_sync_props),
        new_raw: voidptr(vslim_service_provider_new_raw),
        cleanup_raw: voidptr(vslim_service_provider_cleanup_raw),
        free_raw: voidptr(vslim_service_provider_free_raw)
    )
}
pub fn VSlimServiceProvider.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__support__serviceprovider_ce)
}

pub fn VSlimServiceProvider.php_object_handlers() voidptr {
    return vslim_service_provider_handlers()
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

@[export: 'vslim_module_new_raw']
pub fn vslim_module_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimModule]()
}
@[export: 'vslim_module_free_raw']
pub fn vslim_module_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimModule](ptr)
}
@[export: 'vslim_module_cleanup_raw']
pub fn vslim_module_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimModule(ptr)
        obj.cleanup()
    }
}
@[export: 'vslim_module_get_prop']
pub fn vslim_module_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_module_set_prop']
pub fn vslim_module_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_module_sync_props']
pub fn vslim_module_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_module_construct']
pub fn vphp_wrap_vslim_module_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimModule(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_module_set_app']
pub fn vphp_wrap_vslim_module_set_app(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_module_has_app']
pub fn vphp_wrap_vslim_module_has_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModule(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_app()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_module_app']
pub fn vphp_wrap_vslim_module_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModule(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.app()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'vslim_module_handlers']
pub fn vslim_module_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_module_get_prop),
        write_handler: voidptr(vslim_module_set_prop),
        sync_handler: voidptr(vslim_module_sync_props),
        new_raw: voidptr(vslim_module_new_raw),
        cleanup_raw: voidptr(vslim_module_cleanup_raw),
        free_raw: voidptr(vslim_module_free_raw)
    )
}
pub fn VSlimModule.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__support__module_ce)
}

pub fn VSlimModule.php_object_handlers() voidptr {
    return vslim_module_handlers()
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

@[export: 'vslim_env_loader_new_raw']
pub fn vslim_env_loader_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimEnvLoader]()
}
@[export: 'vslim_env_loader_free_raw']
pub fn vslim_env_loader_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimEnvLoader](ptr)
}
@[export: 'vslim_env_loader_cleanup_raw']
pub fn vslim_env_loader_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_env_loader_get_prop']
pub fn vslim_env_loader_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_env_loader_set_prop']
pub fn vslim_env_loader_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_env_loader_sync_props']
pub fn vslim_env_loader_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_env_loader_bootstrap']
pub fn vphp_wrap_vslim_env_loader_bootstrap(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'root', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'root').as_v[string]()
    res := VSlimEnvLoader.bootstrap(arg_0)
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_vslim_env_loader_load']
pub fn vphp_wrap_vslim_env_loader_load(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := VSlimEnvLoader.load(arg_0)
    ctx.return().v[map[string]string](res)
}
@[export: 'vslim_env_loader_handlers']
pub fn vslim_env_loader_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_env_loader_get_prop),
        write_handler: voidptr(vslim_env_loader_set_prop),
        sync_handler: voidptr(vslim_env_loader_sync_props),
        new_raw: voidptr(vslim_env_loader_new_raw),
        cleanup_raw: voidptr(vslim_env_loader_cleanup_raw),
        free_raw: voidptr(vslim_env_loader_free_raw)
    )
}
pub fn VSlimEnvLoader.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__envloader_ce)
}

pub fn VSlimEnvLoader.php_object_handlers() voidptr {
    return vslim_env_loader_handlers()
}

pub fn VSlimEnvLoader.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimEnvLoader](v_ptr, ownership)
}

pub fn (obj &VSlimEnvLoader) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimEnvLoader](obj)
}

pub fn (obj &VSlimEnvLoader) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimEnvLoader](obj)
}

pub fn (obj &VSlimEnvLoader) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimEnvLoader](obj)
}

pub fn (obj &VSlimEnvLoader) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimEnvLoader](obj)
}


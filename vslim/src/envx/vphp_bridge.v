module envx

import vphp

#include "php_bridge.h"

__global C.vslim__envloader_ce &C.zend_class_entry

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


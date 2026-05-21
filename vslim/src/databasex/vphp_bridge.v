module databasex

import vphp

import vhttpdx

#include "php_bridge.h"

__global C.vslim__database__config_ce &C.zend_class_entry
__global C.vslim__database__manager_ce &C.zend_class_entry
__global C.vslim__database__pendingresult_ce &C.zend_class_entry
__global C.vslim__database__query_ce &C.zend_class_entry
__global C.vslim__database__model_ce &C.zend_class_entry
__global C.vslim__database__migration_ce &C.zend_class_entry
__global C.vslim__database__seeder_ce &C.zend_class_entry
__global C.vslim__database__migrator_ce &C.zend_class_entry

@[export: 'VSlimDatabaseConfig_new_raw']
pub fn vslimdatabaseconfig_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseConfig]()
}
@[export: 'VSlimDatabaseConfig_free_raw']
pub fn vslimdatabaseconfig_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseConfig](ptr)
}
@[export: 'VSlimDatabaseConfig_cleanup_raw']
pub fn vslimdatabaseconfig_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimDatabaseConfig_get_prop']
pub fn vslimdatabaseconfig_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimDatabaseConfig_set_prop']
pub fn vslimdatabaseconfig_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimDatabaseConfig_sync_props']
pub fn vslimdatabaseconfig_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_construct']
pub fn vphp_wrap_vslimdatabaseconfig_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_set_driver']
pub fn vphp_wrap_vslimdatabaseconfig_set_driver(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'driver', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'driver').as_v[string]()
    res := recv.set_driver(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_driver']
pub fn vphp_wrap_vslimdatabaseconfig_driver(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.driver()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_set_transport']
pub fn vphp_wrap_vslimdatabaseconfig_set_transport(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'transport', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'transport').as_v[string]()
    res := recv.set_transport(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_transport']
pub fn vphp_wrap_vslimdatabaseconfig_transport(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.transport()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_set_host']
pub fn vphp_wrap_vslimdatabaseconfig_set_host(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'host', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'host').as_v[string]()
    res := recv.set_host(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_host']
pub fn vphp_wrap_vslimdatabaseconfig_host(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.host()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_set_port']
pub fn vphp_wrap_vslimdatabaseconfig_set_port(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'port', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'port').as_v[int]()
    res := recv.set_port(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_port']
pub fn vphp_wrap_vslimdatabaseconfig_port(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.port()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_set_username']
pub fn vphp_wrap_vslimdatabaseconfig_set_username(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'username', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'username').as_v[string]()
    res := recv.set_username(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_username']
pub fn vphp_wrap_vslimdatabaseconfig_username(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.username()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_set_password']
pub fn vphp_wrap_vslimdatabaseconfig_set_password(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'password', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'password').as_v[string]()
    res := recv.set_password(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_password']
pub fn vphp_wrap_vslimdatabaseconfig_password(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.password()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_set_database']
pub fn vphp_wrap_vslimdatabaseconfig_set_database(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.set_database(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_database']
pub fn vphp_wrap_vslimdatabaseconfig_database(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.database()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_set_pool_size']
pub fn vphp_wrap_vslimdatabaseconfig_set_pool_size(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'size', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'size').as_v[int]()
    res := recv.set_pool_size(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_pool_size_value']
pub fn vphp_wrap_vslimdatabaseconfig_pool_size_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.pool_size_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_set_pool_name']
pub fn vphp_wrap_vslimdatabaseconfig_set_pool_name(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.set_pool_name(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_pool_name_value']
pub fn vphp_wrap_vslimdatabaseconfig_pool_name_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.pool_name_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_set_timeout_ms']
pub fn vphp_wrap_vslimdatabaseconfig_set_timeout_ms(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'timeoutMs', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'timeoutMs').as_v[int]()
    res := recv.set_timeout_ms(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_timeout_ms_value']
pub fn vphp_wrap_vslimdatabaseconfig_timeout_ms_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.timeout_ms_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_set_upstream_socket']
pub fn vphp_wrap_vslimdatabaseconfig_set_upstream_socket(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socketPath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'socketPath').as_v[string]()
    res := recv.set_upstream_socket(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_upstream_socket_value']
pub fn vphp_wrap_vslimdatabaseconfig_upstream_socket_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.upstream_socket_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseConfig_to_json']
pub fn vphp_wrap_vslimdatabaseconfig_to_json(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.to_json()
    ctx.return().v[string](res)
}
@[export: 'VSlimDatabaseConfig_handlers']
pub fn vslimdatabaseconfig_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimdatabaseconfig_get_prop),
        write_handler: voidptr(vslimdatabaseconfig_set_prop),
        sync_handler: voidptr(vslimdatabaseconfig_sync_props),
        new_raw: voidptr(vslimdatabaseconfig_new_raw),
        cleanup_raw: voidptr(vslimdatabaseconfig_cleanup_raw),
        free_raw: voidptr(vslimdatabaseconfig_free_raw)
    )
}
pub fn VSlimDatabaseConfig.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__config_ce)
}

pub fn VSlimDatabaseConfig.php_object_handlers() voidptr {
    return vslimdatabaseconfig_handlers()
}

pub fn VSlimDatabaseConfig.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimDatabaseConfig](v_ptr, ownership)
}

pub fn (obj &VSlimDatabaseConfig) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimDatabaseConfig](obj)
}

pub fn (obj &VSlimDatabaseConfig) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimDatabaseConfig](obj)
}

pub fn (obj &VSlimDatabaseConfig) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimDatabaseConfig](obj)
}

pub fn (obj &VSlimDatabaseConfig) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimDatabaseConfig](obj)
}

@[export: 'VSlimDatabaseManager_new_raw']
pub fn vslimdatabasemanager_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseManager]()
}
@[export: 'VSlimDatabaseManager_free_raw']
pub fn vslimdatabasemanager_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseManager](ptr)
}
@[export: 'VSlimDatabaseManager_cleanup_raw']
pub fn vslimdatabasemanager_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimDatabaseManager(ptr)
        obj.free()
    }
}
@[export: 'VSlimDatabaseManager_get_prop']
pub fn vslimdatabasemanager_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimDatabaseManager_set_prop']
pub fn vslimdatabasemanager_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimDatabaseManager_sync_props']
pub fn vslimdatabasemanager_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimDatabaseManager_connect']
pub fn vphp_wrap_vslimdatabasemanager_connect(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.connect()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_disconnect']
pub fn vphp_wrap_vslimdatabasemanager_disconnect(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.disconnect()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_ping']
pub fn vphp_wrap_vslimdatabasemanager_ping(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.ping()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_execute']
pub fn vphp_wrap_vslimdatabasemanager_execute(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').as_v[string]()
    res := recv.execute(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_execute_async']
pub fn vphp_wrap_vslimdatabasemanager_execute_async(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').as_v[string]()
    res := recv.execute_async(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_execute_params']
pub fn vphp_wrap_vslimdatabasemanager_execute_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    res := recv.execute_params(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_execute_params_async']
pub fn vphp_wrap_vslimdatabasemanager_execute_params_async(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    res := recv.execute_params_async(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_query']
pub fn vphp_wrap_vslimdatabasemanager_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').as_v[string]()
    res := recv.query(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_query_async']
pub fn vphp_wrap_vslimdatabasemanager_query_async(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').as_v[string]()
    res := recv.query_async(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_query_params']
pub fn vphp_wrap_vslimdatabasemanager_query_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    res := recv.query_params(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_query_params_async']
pub fn vphp_wrap_vslimdatabasemanager_query_params_async(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    res := recv.query_params_async(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_query_one']
pub fn vphp_wrap_vslimdatabasemanager_query_one(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').as_v[string]()
    res := recv.query_one(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_query_one_params']
pub fn vphp_wrap_vslimdatabasemanager_query_one_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    res := recv.query_one_params(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_begin_transaction']
pub fn vphp_wrap_vslimdatabasemanager_begin_transaction(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.begin_transaction()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_commit']
pub fn vphp_wrap_vslimdatabasemanager_commit(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.commit()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_rollback']
pub fn vphp_wrap_vslimdatabasemanager_rollback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.rollback()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_construct']
pub fn vphp_wrap_vslimdatabasemanager_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_set_config']
pub fn vphp_wrap_vslimdatabasemanager_set_config(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'config', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &databasex.VSlimDatabaseConfig(php_args.at_named_or_index(0, 'config').raw_obj()) }
    res := recv.set_config(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_config']
pub fn vphp_wrap_vslimdatabasemanager_config(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.config()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_driver']
pub fn vphp_wrap_vslimdatabasemanager_driver(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.driver()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_transport']
pub fn vphp_wrap_vslimdatabasemanager_transport(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.transport()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_vhttpd_client']
pub fn vphp_wrap_vslimdatabasemanager_vhttpd_client(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.vhttpd_client()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_pool_size_value']
pub fn vphp_wrap_vslimdatabasemanager_pool_size_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.pool_size_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_is_connected']
pub fn vphp_wrap_vslimdatabasemanager_is_connected(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_connected()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_last_error_message']
pub fn vphp_wrap_vslimdatabasemanager_last_error_message(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.last_error_message()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_affected_rows_value']
pub fn vphp_wrap_vslimdatabasemanager_affected_rows_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.affected_rows_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_last_insert_id_value']
pub fn vphp_wrap_vslimdatabasemanager_last_insert_id_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.last_insert_id_value()
    ctx.return().v[i64](res)
}
@[export: 'vphp_wrap_VSlimDatabaseManager_table_query']
pub fn vphp_wrap_vslimdatabasemanager_table_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.table_query(arg_0)
    return voidptr(res)
}
@[export: 'VSlimDatabaseManager_handlers']
pub fn vslimdatabasemanager_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimdatabasemanager_get_prop),
        write_handler: voidptr(vslimdatabasemanager_set_prop),
        sync_handler: voidptr(vslimdatabasemanager_sync_props),
        new_raw: voidptr(vslimdatabasemanager_new_raw),
        cleanup_raw: voidptr(vslimdatabasemanager_cleanup_raw),
        free_raw: voidptr(vslimdatabasemanager_free_raw)
    )
}
pub fn VSlimDatabaseManager.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__manager_ce)
}

pub fn VSlimDatabaseManager.php_object_handlers() voidptr {
    return vslimdatabasemanager_handlers()
}

pub fn VSlimDatabaseManager.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimDatabaseManager](v_ptr, ownership)
}

pub fn (obj &VSlimDatabaseManager) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimDatabaseManager](obj)
}

pub fn (obj &VSlimDatabaseManager) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimDatabaseManager](obj)
}

pub fn (obj &VSlimDatabaseManager) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimDatabaseManager](obj)
}

pub fn (obj &VSlimDatabaseManager) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimDatabaseManager](obj)
}

@[export: 'VSlimDatabasePendingResult_new_raw']
pub fn vslimdatabasependingresult_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabasePendingResult]()
}
@[export: 'VSlimDatabasePendingResult_free_raw']
pub fn vslimdatabasependingresult_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabasePendingResult](ptr)
}
@[export: 'VSlimDatabasePendingResult_cleanup_raw']
pub fn vslimdatabasependingresult_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimDatabasePendingResult(ptr)
        obj.cleanup()
    }
}
@[export: 'VSlimDatabasePendingResult_get_prop']
pub fn vslimdatabasependingresult_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimDatabasePendingResult_set_prop']
pub fn vslimdatabasependingresult_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimDatabasePendingResult_sync_props']
pub fn vslimdatabasependingresult_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimDatabasePendingResult_resolved']
pub fn vphp_wrap_vslimdatabasependingresult_resolved(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabasePendingResult(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.resolved()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimDatabasePendingResult_last_error_message']
pub fn vphp_wrap_vslimdatabasependingresult_last_error_message(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabasePendingResult(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.last_error_message()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabasePendingResult_affected_rows_value']
pub fn vphp_wrap_vslimdatabasependingresult_affected_rows_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabasePendingResult(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.affected_rows_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimDatabasePendingResult_last_insert_id_value']
pub fn vphp_wrap_vslimdatabasependingresult_last_insert_id_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabasePendingResult(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.last_insert_id_value()
    ctx.return().v[i64](res)
}
@[export: 'vphp_wrap_VSlimDatabasePendingResult_wait']
pub fn vphp_wrap_vslimdatabasependingresult_wait(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabasePendingResult(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.wait()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'VSlimDatabasePendingResult_handlers']
pub fn vslimdatabasependingresult_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimdatabasependingresult_get_prop),
        write_handler: voidptr(vslimdatabasependingresult_set_prop),
        sync_handler: voidptr(vslimdatabasependingresult_sync_props),
        new_raw: voidptr(vslimdatabasependingresult_new_raw),
        cleanup_raw: voidptr(vslimdatabasependingresult_cleanup_raw),
        free_raw: voidptr(vslimdatabasependingresult_free_raw)
    )
}
pub fn VSlimDatabasePendingResult.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__pendingresult_ce)
}

pub fn VSlimDatabasePendingResult.php_object_handlers() voidptr {
    return vslimdatabasependingresult_handlers()
}

pub fn VSlimDatabasePendingResult.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimDatabasePendingResult](v_ptr, ownership)
}

pub fn (obj &VSlimDatabasePendingResult) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimDatabasePendingResult](obj)
}

pub fn (obj &VSlimDatabasePendingResult) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimDatabasePendingResult](obj)
}

pub fn (obj &VSlimDatabasePendingResult) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimDatabasePendingResult](obj)
}

pub fn (obj &VSlimDatabasePendingResult) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimDatabasePendingResult](obj)
}

@[export: 'VSlimDatabaseQuery_new_raw']
pub fn vslimdatabasequery_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseQuery]()
}
@[export: 'VSlimDatabaseQuery_free_raw']
pub fn vslimdatabasequery_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseQuery](ptr)
}
@[export: 'VSlimDatabaseQuery_cleanup_raw']
pub fn vslimdatabasequery_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimDatabaseQuery_get_prop']
pub fn vslimdatabasequery_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimDatabaseQuery_set_prop']
pub fn vslimdatabasequery_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimDatabaseQuery_sync_props']
pub fn vslimdatabasequery_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_construct']
pub fn vphp_wrap_vslimdatabasequery_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_set_manager']
pub fn vphp_wrap_vslimdatabasequery_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'manager', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &databasex.VSlimDatabaseManager(php_args.at_named_or_index(0, 'manager').raw_obj()) }
    res := recv.set_manager(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_manager']
pub fn vphp_wrap_vslimdatabasequery_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.manager()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_reset']
pub fn vphp_wrap_vslimdatabasequery_reset(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.reset()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_table']
pub fn vphp_wrap_vslimdatabasequery_table(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.table(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_select']
pub fn vphp_wrap_vslimdatabasequery_select(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'columns', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'columns').value
    res := recv.@select(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_where_eq']
pub fn vphp_wrap_vslimdatabasequery_where_eq(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'column', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'column').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.where_eq(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_where_op']
pub fn vphp_wrap_vslimdatabasequery_where_op(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'column', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'op', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'column').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'op').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'value').value
    res := recv.where_op(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_order_by']
pub fn vphp_wrap_vslimdatabasequery_order_by(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'column', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'direction', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'column').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'direction').as_v[string]()
    res := recv.order_by(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_limit']
pub fn vphp_wrap_vslimdatabasequery_limit(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'limit', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'limit').as_v[int]()
    res := recv.limit(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_offset']
pub fn vphp_wrap_vslimdatabasequery_offset(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'offset', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'offset').as_v[int]()
    res := recv.offset(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_insert']
pub fn vphp_wrap_vslimdatabasequery_insert(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').value
    res := recv.insert(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_update']
pub fn vphp_wrap_vslimdatabasequery_update(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').value
    res := recv.update(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_delete_query']
pub fn vphp_wrap_vslimdatabasequery_delete_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.delete_query()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_to_sql']
pub fn vphp_wrap_vslimdatabasequery_to_sql(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.to_sql()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_params']
pub fn vphp_wrap_vslimdatabasequery_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.params()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_get']
pub fn vphp_wrap_vslimdatabasequery_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_first']
pub fn vphp_wrap_vslimdatabasequery_first(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.first()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_run']
pub fn vphp_wrap_vslimdatabasequery_run(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.run()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseQuery_insert_get_id']
pub fn vphp_wrap_vslimdatabasequery_insert_get_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.insert_get_id()
    ctx.return().v[i64](res)
}
@[export: 'VSlimDatabaseQuery_handlers']
pub fn vslimdatabasequery_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimdatabasequery_get_prop),
        write_handler: voidptr(vslimdatabasequery_set_prop),
        sync_handler: voidptr(vslimdatabasequery_sync_props),
        new_raw: voidptr(vslimdatabasequery_new_raw),
        cleanup_raw: voidptr(vslimdatabasequery_cleanup_raw),
        free_raw: voidptr(vslimdatabasequery_free_raw)
    )
}
pub fn VSlimDatabaseQuery.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__query_ce)
}

pub fn VSlimDatabaseQuery.php_object_handlers() voidptr {
    return vslimdatabasequery_handlers()
}

pub fn VSlimDatabaseQuery.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimDatabaseQuery](v_ptr, ownership)
}

pub fn (obj &VSlimDatabaseQuery) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimDatabaseQuery](obj)
}

pub fn (obj &VSlimDatabaseQuery) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimDatabaseQuery](obj)
}

pub fn (obj &VSlimDatabaseQuery) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimDatabaseQuery](obj)
}

pub fn (obj &VSlimDatabaseQuery) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimDatabaseQuery](obj)
}

@[export: 'VSlimDatabaseModel_new_raw']
pub fn vslimdatabasemodel_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseModel]()
}
@[export: 'VSlimDatabaseModel_free_raw']
pub fn vslimdatabasemodel_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseModel](ptr)
}
@[export: 'VSlimDatabaseModel_cleanup_raw']
pub fn vslimdatabasemodel_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimDatabaseModel_get_prop']
pub fn vslimdatabasemodel_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimDatabaseModel_set_prop']
pub fn vslimdatabasemodel_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimDatabaseModel_sync_props']
pub fn vslimdatabasemodel_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimDatabaseModel_construct']
pub fn vphp_wrap_vslimdatabasemodel_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_set_manager']
pub fn vphp_wrap_vslimdatabasemodel_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'manager', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &databasex.VSlimDatabaseManager(php_args.at_named_or_index(0, 'manager').raw_obj()) }
    res := recv.set_manager(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_manager']
pub fn vphp_wrap_vslimdatabasemodel_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.manager()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_set_table']
pub fn vphp_wrap_vslimdatabasemodel_set_table(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.set_table(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_table']
pub fn vphp_wrap_vslimdatabasemodel_table(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.table()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_set_primary_key']
pub fn vphp_wrap_vslimdatabasemodel_set_primary_key(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.set_primary_key(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_primary_key_name']
pub fn vphp_wrap_vslimdatabasemodel_primary_key_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.primary_key_name()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_fill']
pub fn vphp_wrap_vslimdatabasemodel_fill(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').value
    res := recv.fill(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_attributes']
pub fn vphp_wrap_vslimdatabasemodel_attributes(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.attributes()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_get']
pub fn vphp_wrap_vslimdatabasemodel_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'defaultValue').value
    res := recv.get(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_set_attr']
pub fn vphp_wrap_vslimdatabasemodel_set_attr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.set_attr(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_exists_in_database']
pub fn vphp_wrap_vslimdatabasemodel_exists_in_database(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.exists_in_database()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_new_query']
pub fn vphp_wrap_vslimdatabasemodel_new_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.new_query()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_all_query']
pub fn vphp_wrap_vslimdatabasemodel_all_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.all_query()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_find_query']
pub fn vphp_wrap_vslimdatabasemodel_find_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').value
    res := recv.find_query(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_save_query']
pub fn vphp_wrap_vslimdatabasemodel_save_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.save_query()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_delete_query']
pub fn vphp_wrap_vslimdatabasemodel_delete_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.delete_query()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_all']
pub fn vphp_wrap_vslimdatabasemodel_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.all()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_find']
pub fn vphp_wrap_vslimdatabasemodel_find(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').value
    res := recv.find(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_save']
pub fn vphp_wrap_vslimdatabasemodel_save(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.save()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseModel_delete_model']
pub fn vphp_wrap_vslimdatabasemodel_delete_model(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.delete_model()
    ctx.return().v[bool](res)
}
@[export: 'VSlimDatabaseModel_handlers']
pub fn vslimdatabasemodel_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimdatabasemodel_get_prop),
        write_handler: voidptr(vslimdatabasemodel_set_prop),
        sync_handler: voidptr(vslimdatabasemodel_sync_props),
        new_raw: voidptr(vslimdatabasemodel_new_raw),
        cleanup_raw: voidptr(vslimdatabasemodel_cleanup_raw),
        free_raw: voidptr(vslimdatabasemodel_free_raw)
    )
}
pub fn VSlimDatabaseModel.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__model_ce)
}

pub fn VSlimDatabaseModel.php_object_handlers() voidptr {
    return vslimdatabasemodel_handlers()
}

pub fn VSlimDatabaseModel.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimDatabaseModel](v_ptr, ownership)
}

pub fn (obj &VSlimDatabaseModel) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimDatabaseModel](obj)
}

pub fn (obj &VSlimDatabaseModel) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimDatabaseModel](obj)
}

pub fn (obj &VSlimDatabaseModel) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimDatabaseModel](obj)
}

pub fn (obj &VSlimDatabaseModel) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimDatabaseModel](obj)
}

@[export: 'VSlimDatabaseMigration_new_raw']
pub fn vslimdatabasemigration_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseMigration]()
}
@[export: 'VSlimDatabaseMigration_free_raw']
pub fn vslimdatabasemigration_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseMigration](ptr)
}
@[export: 'VSlimDatabaseMigration_cleanup_raw']
pub fn vslimdatabasemigration_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimDatabaseMigration_get_prop']
pub fn vslimdatabasemigration_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimDatabaseMigration_set_prop']
pub fn vslimdatabasemigration_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimDatabaseMigration_sync_props']
pub fn vslimdatabasemigration_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_construct']
pub fn vphp_wrap_vslimdatabasemigration_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_set_manager']
pub fn vphp_wrap_vslimdatabasemigration_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'manager', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &databasex.VSlimDatabaseManager(php_args.at_named_or_index(0, 'manager').raw_obj()) }
    res := recv.set_manager(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_manager']
pub fn vphp_wrap_vslimdatabasemigration_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.manager()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_db']
pub fn vphp_wrap_vslimdatabasemigration_db(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.db()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_set_name']
pub fn vphp_wrap_vslimdatabasemigration_set_name(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.set_name(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_name']
pub fn vphp_wrap_vslimdatabasemigration_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.name()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_up']
pub fn vphp_wrap_vslimdatabasemigration_up(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.up()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_down']
pub fn vphp_wrap_vslimdatabasemigration_down(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.down()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_create_table_sql']
pub fn vphp_wrap_vslimdatabasemigration_create_table_sql(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'tableName', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'columns', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'tableName').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'columns').as_v[[]string]()
    res := recv.create_table_sql(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_drop_table_sql']
pub fn vphp_wrap_vslimdatabasemigration_drop_table_sql(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'tableName', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'tableName').as_v[string]()
    res := recv.drop_table_sql(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_add_column_sql']
pub fn vphp_wrap_vslimdatabasemigration_add_column_sql(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'tableName', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'columnDef', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'tableName').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'columnDef').as_v[string]()
    res := recv.add_column_sql(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_drop_column_sql']
pub fn vphp_wrap_vslimdatabasemigration_drop_column_sql(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'tableName', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'columnName', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'tableName').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'columnName').as_v[string]()
    res := recv.drop_column_sql(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_create_table']
pub fn vphp_wrap_vslimdatabasemigration_create_table(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'tableName', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'columns', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'tableName').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'columns').as_v[[]string]()
    res := recv.create_table(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_drop_table']
pub fn vphp_wrap_vslimdatabasemigration_drop_table(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'tableName', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'tableName').as_v[string]()
    res := recv.drop_table(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_add_column']
pub fn vphp_wrap_vslimdatabasemigration_add_column(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'tableName', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'columnDef', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'tableName').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'columnDef').as_v[string]()
    res := recv.add_column(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_drop_column']
pub fn vphp_wrap_vslimdatabasemigration_drop_column(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'tableName', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'columnName', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'tableName').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'columnName').as_v[string]()
    res := recv.drop_column(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_execute']
pub fn vphp_wrap_vslimdatabasemigration_execute(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'statement', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'statement').as_v[string]()
    res := recv.execute(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_execute_params']
pub fn vphp_wrap_vslimdatabasemigration_execute_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'statement', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'statement').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    res := recv.execute_params(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_query']
pub fn vphp_wrap_vslimdatabasemigration_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'statement', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'statement').as_v[string]()
    res := recv.query(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigration_query_params']
pub fn vphp_wrap_vslimdatabasemigration_query_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'statement', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'statement').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    res := recv.query_params(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'VSlimDatabaseMigration_handlers']
pub fn vslimdatabasemigration_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimdatabasemigration_get_prop),
        write_handler: voidptr(vslimdatabasemigration_set_prop),
        sync_handler: voidptr(vslimdatabasemigration_sync_props),
        new_raw: voidptr(vslimdatabasemigration_new_raw),
        cleanup_raw: voidptr(vslimdatabasemigration_cleanup_raw),
        free_raw: voidptr(vslimdatabasemigration_free_raw)
    )
}
pub fn VSlimDatabaseMigration.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__migration_ce)
}

pub fn VSlimDatabaseMigration.php_object_handlers() voidptr {
    return vslimdatabasemigration_handlers()
}

pub fn VSlimDatabaseMigration.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimDatabaseMigration](v_ptr, ownership)
}

pub fn (obj &VSlimDatabaseMigration) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimDatabaseMigration](obj)
}

pub fn (obj &VSlimDatabaseMigration) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimDatabaseMigration](obj)
}

pub fn (obj &VSlimDatabaseMigration) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimDatabaseMigration](obj)
}

pub fn (obj &VSlimDatabaseMigration) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimDatabaseMigration](obj)
}

@[export: 'VSlimDatabaseSeeder_new_raw']
pub fn vslimdatabaseseeder_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseSeeder]()
}
@[export: 'VSlimDatabaseSeeder_free_raw']
pub fn vslimdatabaseseeder_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseSeeder](ptr)
}
@[export: 'VSlimDatabaseSeeder_cleanup_raw']
pub fn vslimdatabaseseeder_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimDatabaseSeeder_get_prop']
pub fn vslimdatabaseseeder_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimDatabaseSeeder_set_prop']
pub fn vslimdatabaseseeder_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimDatabaseSeeder_sync_props']
pub fn vslimdatabaseseeder_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimDatabaseSeeder_construct']
pub fn vphp_wrap_vslimdatabaseseeder_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseSeeder_set_manager']
pub fn vphp_wrap_vslimdatabaseseeder_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'manager', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &databasex.VSlimDatabaseManager(php_args.at_named_or_index(0, 'manager').raw_obj()) }
    res := recv.set_manager(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseSeeder_manager']
pub fn vphp_wrap_vslimdatabaseseeder_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.manager()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseSeeder_db']
pub fn vphp_wrap_vslimdatabaseseeder_db(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.db()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseSeeder_set_name']
pub fn vphp_wrap_vslimdatabaseseeder_set_name(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.set_name(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseSeeder_name']
pub fn vphp_wrap_vslimdatabaseseeder_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.name()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseSeeder_run']
pub fn vphp_wrap_vslimdatabaseseeder_run(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.run()
    ctx.return().v[bool](res)
}
@[export: 'VSlimDatabaseSeeder_handlers']
pub fn vslimdatabaseseeder_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimdatabaseseeder_get_prop),
        write_handler: voidptr(vslimdatabaseseeder_set_prop),
        sync_handler: voidptr(vslimdatabaseseeder_sync_props),
        new_raw: voidptr(vslimdatabaseseeder_new_raw),
        cleanup_raw: voidptr(vslimdatabaseseeder_cleanup_raw),
        free_raw: voidptr(vslimdatabaseseeder_free_raw)
    )
}
pub fn VSlimDatabaseSeeder.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__seeder_ce)
}

pub fn VSlimDatabaseSeeder.php_object_handlers() voidptr {
    return vslimdatabaseseeder_handlers()
}

pub fn VSlimDatabaseSeeder.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimDatabaseSeeder](v_ptr, ownership)
}

pub fn (obj &VSlimDatabaseSeeder) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimDatabaseSeeder](obj)
}

pub fn (obj &VSlimDatabaseSeeder) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimDatabaseSeeder](obj)
}

pub fn (obj &VSlimDatabaseSeeder) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimDatabaseSeeder](obj)
}

pub fn (obj &VSlimDatabaseSeeder) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimDatabaseSeeder](obj)
}

@[export: 'VSlimDatabaseMigrator_new_raw']
pub fn vslimdatabasemigrator_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseMigrator]()
}
@[export: 'VSlimDatabaseMigrator_free_raw']
pub fn vslimdatabasemigrator_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseMigrator](ptr)
}
@[export: 'VSlimDatabaseMigrator_cleanup_raw']
pub fn vslimdatabasemigrator_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimDatabaseMigrator_get_prop']
pub fn vslimdatabasemigrator_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimDatabaseMigrator_set_prop']
pub fn vslimdatabasemigrator_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimDatabaseMigrator_sync_props']
pub fn vslimdatabasemigrator_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_construct']
pub fn vphp_wrap_vslimdatabasemigrator_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_set_manager']
pub fn vphp_wrap_vslimdatabasemigrator_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'manager', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &databasex.VSlimDatabaseManager(php_args.at_named_or_index(0, 'manager').raw_obj()) }
    res := recv.set_manager(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_manager']
pub fn vphp_wrap_vslimdatabasemigrator_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.manager()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_set_migrations_path']
pub fn vphp_wrap_vslimdatabasemigrator_set_migrations_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.set_migrations_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_migrations_path_value']
pub fn vphp_wrap_vslimdatabasemigrator_migrations_path_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.migrations_path_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_set_seeds_path']
pub fn vphp_wrap_vslimdatabasemigrator_set_seeds_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.set_seeds_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_seeds_path_value']
pub fn vphp_wrap_vslimdatabasemigrator_seeds_path_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.seeds_path_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_set_table']
pub fn vphp_wrap_vslimdatabasemigrator_set_table(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'tableName', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'tableName').as_v[string]()
    res := recv.set_table(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_table_name_value']
pub fn vphp_wrap_vslimdatabasemigrator_table_name_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.table_name_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_migration_files']
pub fn vphp_wrap_vslimdatabasemigrator_migration_files(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.migration_files()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_seed_files']
pub fn vphp_wrap_vslimdatabasemigrator_seed_files(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.seed_files()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_load_migration']
pub fn vphp_wrap_vslimdatabasemigrator_load_migration(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'file', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'file').as_v[string]()
    res := recv.load_migration(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_load_seeder']
pub fn vphp_wrap_vslimdatabasemigrator_load_seeder(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'file', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'file').as_v[string]()
    res := recv.load_seeder(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_migrate']
pub fn vphp_wrap_vslimdatabasemigrator_migrate(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.migrate()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_rollback']
pub fn vphp_wrap_vslimdatabasemigrator_rollback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.rollback()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_status']
pub fn vphp_wrap_vslimdatabasemigrator_status(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.status()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDatabaseMigrator_seed']
pub fn vphp_wrap_vslimdatabasemigrator_seed(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'name') { php_args.at_named_or_index(0, 'name').as_v[string]() } else { '' }
    res := recv.seed(arg_0)
    ctx.return().v[int](res)
}
@[export: 'VSlimDatabaseMigrator_handlers']
pub fn vslimdatabasemigrator_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimdatabasemigrator_get_prop),
        write_handler: voidptr(vslimdatabasemigrator_set_prop),
        sync_handler: voidptr(vslimdatabasemigrator_sync_props),
        new_raw: voidptr(vslimdatabasemigrator_new_raw),
        cleanup_raw: voidptr(vslimdatabasemigrator_cleanup_raw),
        free_raw: voidptr(vslimdatabasemigrator_free_raw)
    )
}
pub fn VSlimDatabaseMigrator.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__migrator_ce)
}

pub fn VSlimDatabaseMigrator.php_object_handlers() voidptr {
    return vslimdatabasemigrator_handlers()
}

pub fn VSlimDatabaseMigrator.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimDatabaseMigrator](v_ptr, ownership)
}

pub fn (obj &VSlimDatabaseMigrator) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimDatabaseMigrator](obj)
}

pub fn (obj &VSlimDatabaseMigrator) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimDatabaseMigrator](obj)
}

pub fn (obj &VSlimDatabaseMigrator) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimDatabaseMigrator](obj)
}

pub fn (obj &VSlimDatabaseMigrator) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimDatabaseMigrator](obj)
}


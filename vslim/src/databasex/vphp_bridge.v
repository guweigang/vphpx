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

@[export: 'vslim_database_config_new_raw']
pub fn vslim_database_config_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseConfig]()
}
@[export: 'vslim_database_config_free_raw']
pub fn vslim_database_config_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseConfig](ptr)
}
@[export: 'vslim_database_config_cleanup_raw']
pub fn vslim_database_config_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_database_config_get_prop']
pub fn vslim_database_config_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_database_config_set_prop']
pub fn vslim_database_config_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_database_config_sync_props']
pub fn vslim_database_config_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_database_config_construct']
pub fn vphp_wrap_vslim_database_config_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_config_set_driver']
pub fn vphp_wrap_vslim_database_config_set_driver(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_config_driver']
pub fn vphp_wrap_vslim_database_config_driver(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.driver()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_config_set_transport']
pub fn vphp_wrap_vslim_database_config_set_transport(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_config_transport']
pub fn vphp_wrap_vslim_database_config_transport(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.transport()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_config_set_host']
pub fn vphp_wrap_vslim_database_config_set_host(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_config_host']
pub fn vphp_wrap_vslim_database_config_host(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.host()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_config_set_port']
pub fn vphp_wrap_vslim_database_config_set_port(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_config_port']
pub fn vphp_wrap_vslim_database_config_port(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.port()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_database_config_set_username']
pub fn vphp_wrap_vslim_database_config_set_username(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_config_username']
pub fn vphp_wrap_vslim_database_config_username(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.username()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_config_set_password']
pub fn vphp_wrap_vslim_database_config_set_password(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_config_password']
pub fn vphp_wrap_vslim_database_config_password(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.password()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_config_set_database']
pub fn vphp_wrap_vslim_database_config_set_database(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_config_database']
pub fn vphp_wrap_vslim_database_config_database(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.database()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_config_set_pool_size']
pub fn vphp_wrap_vslim_database_config_set_pool_size(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_config_pool_size_value']
pub fn vphp_wrap_vslim_database_config_pool_size_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.pool_size_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_database_config_set_pool_name']
pub fn vphp_wrap_vslim_database_config_set_pool_name(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_config_pool_name_value']
pub fn vphp_wrap_vslim_database_config_pool_name_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.pool_name_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_config_set_timeout_ms']
pub fn vphp_wrap_vslim_database_config_set_timeout_ms(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_config_timeout_ms_value']
pub fn vphp_wrap_vslim_database_config_timeout_ms_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.timeout_ms_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_database_config_set_upstream_socket']
pub fn vphp_wrap_vslim_database_config_set_upstream_socket(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_config_upstream_socket_value']
pub fn vphp_wrap_vslim_database_config_upstream_socket_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.upstream_socket_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_config_to_json']
pub fn vphp_wrap_vslim_database_config_to_json(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.to_json()
    ctx.return().v[string](res)
}
@[export: 'vslim_database_config_handlers']
pub fn vslim_database_config_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_database_config_get_prop),
        write_handler: voidptr(vslim_database_config_set_prop),
        sync_handler: voidptr(vslim_database_config_sync_props),
        new_raw: voidptr(vslim_database_config_new_raw),
        cleanup_raw: voidptr(vslim_database_config_cleanup_raw),
        free_raw: voidptr(vslim_database_config_free_raw)
    )
}
pub fn VSlimDatabaseConfig.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__config_ce)
}

pub fn VSlimDatabaseConfig.php_object_handlers() voidptr {
    return vslim_database_config_handlers()
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

pub fn (val VSlimDatabaseConfig) php_class_name() string {
    return 'VSlim\\Database\\Config'
}

@[export: 'vslim_database_manager_new_raw']
pub fn vslim_database_manager_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseManager]()
}
@[export: 'vslim_database_manager_free_raw']
pub fn vslim_database_manager_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseManager](ptr)
}
@[export: 'vslim_database_manager_cleanup_raw']
pub fn vslim_database_manager_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimDatabaseManager(ptr)
        obj.free()
    }
}
@[export: 'vslim_database_manager_get_prop']
pub fn vslim_database_manager_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_database_manager_set_prop']
pub fn vslim_database_manager_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_database_manager_sync_props']
pub fn vslim_database_manager_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_database_manager_connect']
pub fn vphp_wrap_vslim_database_manager_connect(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.connect()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_database_manager_disconnect']
pub fn vphp_wrap_vslim_database_manager_disconnect(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.disconnect()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_manager_ping']
pub fn vphp_wrap_vslim_database_manager_ping(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.ping()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_database_manager_execute']
pub fn vphp_wrap_vslim_database_manager_execute(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_manager_execute_async']
pub fn vphp_wrap_vslim_database_manager_execute_async(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_manager_execute_params']
pub fn vphp_wrap_vslim_database_manager_execute_params(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_manager_execute_params_async']
pub fn vphp_wrap_vslim_database_manager_execute_params_async(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_manager_query']
pub fn vphp_wrap_vslim_database_manager_query(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_manager_query_async']
pub fn vphp_wrap_vslim_database_manager_query_async(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_manager_query_params']
pub fn vphp_wrap_vslim_database_manager_query_params(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_manager_query_params_async']
pub fn vphp_wrap_vslim_database_manager_query_params_async(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_manager_query_one']
pub fn vphp_wrap_vslim_database_manager_query_one(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_manager_query_one_params']
pub fn vphp_wrap_vslim_database_manager_query_one_params(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_manager_begin_transaction']
pub fn vphp_wrap_vslim_database_manager_begin_transaction(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.begin_transaction()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_database_manager_commit']
pub fn vphp_wrap_vslim_database_manager_commit(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.commit()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_database_manager_rollback']
pub fn vphp_wrap_vslim_database_manager_rollback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.rollback()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_database_manager_construct']
pub fn vphp_wrap_vslim_database_manager_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_manager_set_config']
pub fn vphp_wrap_vslim_database_manager_set_config(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_manager_config']
pub fn vphp_wrap_vslim_database_manager_config(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.config()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_manager_driver']
pub fn vphp_wrap_vslim_database_manager_driver(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.driver()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_manager_transport']
pub fn vphp_wrap_vslim_database_manager_transport(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.transport()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_manager_vhttpd_client']
pub fn vphp_wrap_vslim_database_manager_vhttpd_client(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.vhttpd_client()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_manager_pool_size_value']
pub fn vphp_wrap_vslim_database_manager_pool_size_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.pool_size_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_database_manager_is_connected']
pub fn vphp_wrap_vslim_database_manager_is_connected(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_connected()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_database_manager_last_error_message']
pub fn vphp_wrap_vslim_database_manager_last_error_message(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.last_error_message()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_manager_affected_rows_value']
pub fn vphp_wrap_vslim_database_manager_affected_rows_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.affected_rows_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_database_manager_last_insert_id_value']
pub fn vphp_wrap_vslim_database_manager_last_insert_id_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseManager(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.last_insert_id_value()
    ctx.return().v[i64](res)
}
@[export: 'vphp_wrap_vslim_database_manager_table_query']
pub fn vphp_wrap_vslim_database_manager_table_query(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vslim_database_manager_handlers']
pub fn vslim_database_manager_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_database_manager_get_prop),
        write_handler: voidptr(vslim_database_manager_set_prop),
        sync_handler: voidptr(vslim_database_manager_sync_props),
        new_raw: voidptr(vslim_database_manager_new_raw),
        cleanup_raw: voidptr(vslim_database_manager_cleanup_raw),
        free_raw: voidptr(vslim_database_manager_free_raw)
    )
}
pub fn VSlimDatabaseManager.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__manager_ce)
}

pub fn VSlimDatabaseManager.php_object_handlers() voidptr {
    return vslim_database_manager_handlers()
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

pub fn (val VSlimDatabaseManager) php_class_name() string {
    return 'VSlim\\Database\\Manager'
}

@[export: 'vslim_database_pending_result_new_raw']
pub fn vslim_database_pending_result_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabasePendingResult]()
}
@[export: 'vslim_database_pending_result_free_raw']
pub fn vslim_database_pending_result_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabasePendingResult](ptr)
}
@[export: 'vslim_database_pending_result_cleanup_raw']
pub fn vslim_database_pending_result_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimDatabasePendingResult(ptr)
        obj.cleanup()
    }
}
@[export: 'vslim_database_pending_result_get_prop']
pub fn vslim_database_pending_result_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_database_pending_result_set_prop']
pub fn vslim_database_pending_result_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_database_pending_result_sync_props']
pub fn vslim_database_pending_result_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_database_pending_result_resolved']
pub fn vphp_wrap_vslim_database_pending_result_resolved(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabasePendingResult(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.resolved()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_database_pending_result_last_error_message']
pub fn vphp_wrap_vslim_database_pending_result_last_error_message(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabasePendingResult(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.last_error_message()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_pending_result_affected_rows_value']
pub fn vphp_wrap_vslim_database_pending_result_affected_rows_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabasePendingResult(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.affected_rows_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_database_pending_result_last_insert_id_value']
pub fn vphp_wrap_vslim_database_pending_result_last_insert_id_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabasePendingResult(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.last_insert_id_value()
    ctx.return().v[i64](res)
}
@[export: 'vphp_wrap_vslim_database_pending_result_wait']
pub fn vphp_wrap_vslim_database_pending_result_wait(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabasePendingResult(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.wait()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vslim_database_pending_result_handlers']
pub fn vslim_database_pending_result_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_database_pending_result_get_prop),
        write_handler: voidptr(vslim_database_pending_result_set_prop),
        sync_handler: voidptr(vslim_database_pending_result_sync_props),
        new_raw: voidptr(vslim_database_pending_result_new_raw),
        cleanup_raw: voidptr(vslim_database_pending_result_cleanup_raw),
        free_raw: voidptr(vslim_database_pending_result_free_raw)
    )
}
pub fn VSlimDatabasePendingResult.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__pendingresult_ce)
}

pub fn VSlimDatabasePendingResult.php_object_handlers() voidptr {
    return vslim_database_pending_result_handlers()
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

pub fn (val VSlimDatabasePendingResult) php_class_name() string {
    return 'VSlim\\Database\\PendingResult'
}

@[export: 'vslim_database_query_new_raw']
pub fn vslim_database_query_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseQuery]()
}
@[export: 'vslim_database_query_free_raw']
pub fn vslim_database_query_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseQuery](ptr)
}
@[export: 'vslim_database_query_cleanup_raw']
pub fn vslim_database_query_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_database_query_get_prop']
pub fn vslim_database_query_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_database_query_set_prop']
pub fn vslim_database_query_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_database_query_sync_props']
pub fn vslim_database_query_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_database_query_construct']
pub fn vphp_wrap_vslim_database_query_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_query_set_manager']
pub fn vphp_wrap_vslim_database_query_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_query_manager']
pub fn vphp_wrap_vslim_database_query_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.manager()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_query_reset']
pub fn vphp_wrap_vslim_database_query_reset(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.reset()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_query_table']
pub fn vphp_wrap_vslim_database_query_table(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_query_select']
pub fn vphp_wrap_vslim_database_query_select(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_query_where_eq']
pub fn vphp_wrap_vslim_database_query_where_eq(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_query_where_op']
pub fn vphp_wrap_vslim_database_query_where_op(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_query_order_by']
pub fn vphp_wrap_vslim_database_query_order_by(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_query_limit']
pub fn vphp_wrap_vslim_database_query_limit(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_query_offset']
pub fn vphp_wrap_vslim_database_query_offset(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_query_insert']
pub fn vphp_wrap_vslim_database_query_insert(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_query_update']
pub fn vphp_wrap_vslim_database_query_update(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_query_delete_query']
pub fn vphp_wrap_vslim_database_query_delete_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.delete_query()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_query_to_sql']
pub fn vphp_wrap_vslim_database_query_to_sql(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.to_sql()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_query_params']
pub fn vphp_wrap_vslim_database_query_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.params()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_database_query_get']
pub fn vphp_wrap_vslim_database_query_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_database_query_first']
pub fn vphp_wrap_vslim_database_query_first(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.first()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_database_query_run']
pub fn vphp_wrap_vslim_database_query_run(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.run()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_database_query_insert_get_id']
pub fn vphp_wrap_vslim_database_query_insert_get_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseQuery(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.insert_get_id()
    ctx.return().v[i64](res)
}
@[export: 'vslim_database_query_handlers']
pub fn vslim_database_query_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_database_query_get_prop),
        write_handler: voidptr(vslim_database_query_set_prop),
        sync_handler: voidptr(vslim_database_query_sync_props),
        new_raw: voidptr(vslim_database_query_new_raw),
        cleanup_raw: voidptr(vslim_database_query_cleanup_raw),
        free_raw: voidptr(vslim_database_query_free_raw)
    )
}
pub fn VSlimDatabaseQuery.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__query_ce)
}

pub fn VSlimDatabaseQuery.php_object_handlers() voidptr {
    return vslim_database_query_handlers()
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

pub fn (val VSlimDatabaseQuery) php_class_name() string {
    return 'VSlim\\Database\\Query'
}

@[export: 'vslim_database_model_new_raw']
pub fn vslim_database_model_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseModel]()
}
@[export: 'vslim_database_model_free_raw']
pub fn vslim_database_model_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseModel](ptr)
}
@[export: 'vslim_database_model_cleanup_raw']
pub fn vslim_database_model_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_database_model_get_prop']
pub fn vslim_database_model_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_database_model_set_prop']
pub fn vslim_database_model_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_database_model_sync_props']
pub fn vslim_database_model_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_database_model_construct']
pub fn vphp_wrap_vslim_database_model_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_model_set_manager']
pub fn vphp_wrap_vslim_database_model_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_model_manager']
pub fn vphp_wrap_vslim_database_model_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.manager()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_model_set_table']
pub fn vphp_wrap_vslim_database_model_set_table(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_model_table']
pub fn vphp_wrap_vslim_database_model_table(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.table()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_model_set_primary_key']
pub fn vphp_wrap_vslim_database_model_set_primary_key(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_model_primary_key_name']
pub fn vphp_wrap_vslim_database_model_primary_key_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.primary_key_name()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_model_fill']
pub fn vphp_wrap_vslim_database_model_fill(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_model_attributes']
pub fn vphp_wrap_vslim_database_model_attributes(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.attributes()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_database_model_get']
pub fn vphp_wrap_vslim_database_model_get(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_model_set_attr']
pub fn vphp_wrap_vslim_database_model_set_attr(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_model_exists_in_database']
pub fn vphp_wrap_vslim_database_model_exists_in_database(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.exists_in_database()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_database_model_new_query']
pub fn vphp_wrap_vslim_database_model_new_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.new_query()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_model_all_query']
pub fn vphp_wrap_vslim_database_model_all_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.all_query()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_model_find_query']
pub fn vphp_wrap_vslim_database_model_find_query(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_model_save_query']
pub fn vphp_wrap_vslim_database_model_save_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.save_query()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_model_delete_query']
pub fn vphp_wrap_vslim_database_model_delete_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.delete_query()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_model_all']
pub fn vphp_wrap_vslim_database_model_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.all()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_database_model_find']
pub fn vphp_wrap_vslim_database_model_find(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_model_save']
pub fn vphp_wrap_vslim_database_model_save(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.save()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_model_delete_model']
pub fn vphp_wrap_vslim_database_model_delete_model(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseModel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.delete_model()
    ctx.return().v[bool](res)
}
@[export: 'vslim_database_model_handlers']
pub fn vslim_database_model_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_database_model_get_prop),
        write_handler: voidptr(vslim_database_model_set_prop),
        sync_handler: voidptr(vslim_database_model_sync_props),
        new_raw: voidptr(vslim_database_model_new_raw),
        cleanup_raw: voidptr(vslim_database_model_cleanup_raw),
        free_raw: voidptr(vslim_database_model_free_raw)
    )
}
pub fn VSlimDatabaseModel.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__model_ce)
}

pub fn VSlimDatabaseModel.php_object_handlers() voidptr {
    return vslim_database_model_handlers()
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

pub fn (val VSlimDatabaseModel) php_class_name() string {
    return 'VSlim\\Database\\Model'
}

@[export: 'vslim_database_migration_new_raw']
pub fn vslim_database_migration_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseMigration]()
}
@[export: 'vslim_database_migration_free_raw']
pub fn vslim_database_migration_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseMigration](ptr)
}
@[export: 'vslim_database_migration_cleanup_raw']
pub fn vslim_database_migration_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_database_migration_get_prop']
pub fn vslim_database_migration_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_database_migration_set_prop']
pub fn vslim_database_migration_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_database_migration_sync_props']
pub fn vslim_database_migration_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_database_migration_construct']
pub fn vphp_wrap_vslim_database_migration_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_migration_set_manager']
pub fn vphp_wrap_vslim_database_migration_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_migration_manager']
pub fn vphp_wrap_vslim_database_migration_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.manager()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_migration_db']
pub fn vphp_wrap_vslim_database_migration_db(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.db()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_migration_set_name']
pub fn vphp_wrap_vslim_database_migration_set_name(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_migration_name']
pub fn vphp_wrap_vslim_database_migration_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.name()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_migration_up']
pub fn vphp_wrap_vslim_database_migration_up(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.up()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_database_migration_down']
pub fn vphp_wrap_vslim_database_migration_down(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigration(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.down()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_database_migration_create_table_sql']
pub fn vphp_wrap_vslim_database_migration_create_table_sql(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migration_drop_table_sql']
pub fn vphp_wrap_vslim_database_migration_drop_table_sql(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migration_add_column_sql']
pub fn vphp_wrap_vslim_database_migration_add_column_sql(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migration_drop_column_sql']
pub fn vphp_wrap_vslim_database_migration_drop_column_sql(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migration_create_table']
pub fn vphp_wrap_vslim_database_migration_create_table(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migration_drop_table']
pub fn vphp_wrap_vslim_database_migration_drop_table(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migration_add_column']
pub fn vphp_wrap_vslim_database_migration_add_column(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migration_drop_column']
pub fn vphp_wrap_vslim_database_migration_drop_column(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migration_execute']
pub fn vphp_wrap_vslim_database_migration_execute(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migration_execute_params']
pub fn vphp_wrap_vslim_database_migration_execute_params(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migration_query']
pub fn vphp_wrap_vslim_database_migration_query(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migration_query_params']
pub fn vphp_wrap_vslim_database_migration_query_params(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vslim_database_migration_handlers']
pub fn vslim_database_migration_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_database_migration_get_prop),
        write_handler: voidptr(vslim_database_migration_set_prop),
        sync_handler: voidptr(vslim_database_migration_sync_props),
        new_raw: voidptr(vslim_database_migration_new_raw),
        cleanup_raw: voidptr(vslim_database_migration_cleanup_raw),
        free_raw: voidptr(vslim_database_migration_free_raw)
    )
}
pub fn VSlimDatabaseMigration.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__migration_ce)
}

pub fn VSlimDatabaseMigration.php_object_handlers() voidptr {
    return vslim_database_migration_handlers()
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

pub fn (val VSlimDatabaseMigration) php_class_name() string {
    return 'VSlim\\Database\\Migration'
}

@[export: 'vslim_database_seeder_new_raw']
pub fn vslim_database_seeder_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseSeeder]()
}
@[export: 'vslim_database_seeder_free_raw']
pub fn vslim_database_seeder_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseSeeder](ptr)
}
@[export: 'vslim_database_seeder_cleanup_raw']
pub fn vslim_database_seeder_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_database_seeder_get_prop']
pub fn vslim_database_seeder_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_database_seeder_set_prop']
pub fn vslim_database_seeder_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_database_seeder_sync_props']
pub fn vslim_database_seeder_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_database_seeder_construct']
pub fn vphp_wrap_vslim_database_seeder_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_seeder_set_manager']
pub fn vphp_wrap_vslim_database_seeder_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_seeder_manager']
pub fn vphp_wrap_vslim_database_seeder_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.manager()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_seeder_db']
pub fn vphp_wrap_vslim_database_seeder_db(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.db()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_seeder_set_name']
pub fn vphp_wrap_vslim_database_seeder_set_name(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_seeder_name']
pub fn vphp_wrap_vslim_database_seeder_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.name()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_seeder_run']
pub fn vphp_wrap_vslim_database_seeder_run(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseSeeder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.run()
    ctx.return().v[bool](res)
}
@[export: 'vslim_database_seeder_handlers']
pub fn vslim_database_seeder_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_database_seeder_get_prop),
        write_handler: voidptr(vslim_database_seeder_set_prop),
        sync_handler: voidptr(vslim_database_seeder_sync_props),
        new_raw: voidptr(vslim_database_seeder_new_raw),
        cleanup_raw: voidptr(vslim_database_seeder_cleanup_raw),
        free_raw: voidptr(vslim_database_seeder_free_raw)
    )
}
pub fn VSlimDatabaseSeeder.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__seeder_ce)
}

pub fn VSlimDatabaseSeeder.php_object_handlers() voidptr {
    return vslim_database_seeder_handlers()
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

pub fn (val VSlimDatabaseSeeder) php_class_name() string {
    return 'VSlim\\Database\\Seeder'
}

@[export: 'vslim_database_migrator_new_raw']
pub fn vslim_database_migrator_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDatabaseMigrator]()
}
@[export: 'vslim_database_migrator_free_raw']
pub fn vslim_database_migrator_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDatabaseMigrator](ptr)
}
@[export: 'vslim_database_migrator_cleanup_raw']
pub fn vslim_database_migrator_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_database_migrator_get_prop']
pub fn vslim_database_migrator_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_database_migrator_set_prop']
pub fn vslim_database_migrator_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_database_migrator_sync_props']
pub fn vslim_database_migrator_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_database_migrator_construct']
pub fn vphp_wrap_vslim_database_migrator_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_migrator_set_manager']
pub fn vphp_wrap_vslim_database_migrator_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_migrator_manager']
pub fn vphp_wrap_vslim_database_migrator_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.manager()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_database_migrator_set_migrations_path']
pub fn vphp_wrap_vslim_database_migrator_set_migrations_path(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_migrator_migrations_path_value']
pub fn vphp_wrap_vslim_database_migrator_migrations_path_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.migrations_path_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_migrator_set_seeds_path']
pub fn vphp_wrap_vslim_database_migrator_set_seeds_path(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_migrator_seeds_path_value']
pub fn vphp_wrap_vslim_database_migrator_seeds_path_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.seeds_path_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_migrator_set_table']
pub fn vphp_wrap_vslim_database_migrator_set_table(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_database_migrator_table_name_value']
pub fn vphp_wrap_vslim_database_migrator_table_name_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.table_name_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_database_migrator_migration_files']
pub fn vphp_wrap_vslim_database_migrator_migration_files(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.migration_files()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_database_migrator_seed_files']
pub fn vphp_wrap_vslim_database_migrator_seed_files(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.seed_files()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_database_migrator_load_migration']
pub fn vphp_wrap_vslim_database_migrator_load_migration(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migrator_load_seeder']
pub fn vphp_wrap_vslim_database_migrator_load_seeder(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_database_migrator_migrate']
pub fn vphp_wrap_vslim_database_migrator_migrate(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.migrate()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_database_migrator_rollback']
pub fn vphp_wrap_vslim_database_migrator_rollback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.rollback()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_database_migrator_status']
pub fn vphp_wrap_vslim_database_migrator_status(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimDatabaseMigrator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.status()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_database_migrator_seed']
pub fn vphp_wrap_vslim_database_migrator_seed(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vslim_database_migrator_handlers']
pub fn vslim_database_migrator_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_database_migrator_get_prop),
        write_handler: voidptr(vslim_database_migrator_set_prop),
        sync_handler: voidptr(vslim_database_migrator_sync_props),
        new_raw: voidptr(vslim_database_migrator_new_raw),
        cleanup_raw: voidptr(vslim_database_migrator_cleanup_raw),
        free_raw: voidptr(vslim_database_migrator_free_raw)
    )
}
pub fn VSlimDatabaseMigrator.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__database__migrator_ce)
}

pub fn VSlimDatabaseMigrator.php_object_handlers() voidptr {
    return vslim_database_migrator_handlers()
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

pub fn (val VSlimDatabaseMigrator) php_class_name() string {
    return 'VSlim\\Database\\Migrator'
}


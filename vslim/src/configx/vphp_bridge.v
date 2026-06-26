module configx

import vphp
import vphp.object

#include "php_bridge.h"

__global C.vslim__config_ce &C.zend_class_entry

@[export: 'vslim_config_new_raw']
pub fn vslim_config_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimConfig]()
}
@[export: 'vslim_config_free_raw']
pub fn vslim_config_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimConfig](ptr)
}
@[export: 'vslim_config_cleanup_raw']
pub fn vslim_config_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimConfig(ptr)
        obj.free()
    }
}
@[export: 'vslim_config_get_prop']
pub fn vslim_config_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_config_set_prop']
pub fn vslim_config_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_config_sync_props']
pub fn vslim_config_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_config_construct']
pub fn vphp_wrap_vslim_config_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_config_load']
pub fn vphp_wrap_vslim_config_load(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.load(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_config_load_dir']
pub fn vphp_wrap_vslim_config_load_dir(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.load_dir(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_config_load_text']
pub fn vphp_wrap_vslim_config_load_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'text', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'text').as_v[string]()
    res := recv.load_text(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_config_merge_file']
pub fn vphp_wrap_vslim_config_merge_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.merge_file(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_config_merge_dir']
pub fn vphp_wrap_vslim_config_merge_dir(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.merge_dir(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_config_merge_text']
pub fn vphp_wrap_vslim_config_merge_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'text', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'text').as_v[string]()
    res := recv.merge_text(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_config_is_loaded']
pub fn vphp_wrap_vslim_config_is_loaded(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_loaded()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_config_path']
pub fn vphp_wrap_vslim_config_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.path()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_config_has']
pub fn vphp_wrap_vslim_config_has(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.has(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_config_get_string']
pub fn vphp_wrap_vslim_config_get_string(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { php_args.at_named_or_index(1, 'defaultValue').as_v[string]() } else { '' }
    res := recv.get_string(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_config_get_int']
pub fn vphp_wrap_vslim_config_get_int(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { php_args.at_named_or_index(1, 'defaultValue').as_v[int]() } else { 0 }
    res := recv.get_int(arg_0, arg_1)
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_config_get_bool']
pub fn vphp_wrap_vslim_config_get_bool(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { php_args.at_named_or_index(1, 'defaultValue').as_v[bool]() } else { false }
    res := recv.get_bool(arg_0, arg_1)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_config_get_float']
pub fn vphp_wrap_vslim_config_get_float(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { php_args.at_named_or_index(1, 'defaultValue').as_v[f64]() } else { 0.0 }
    res := recv.get_float(arg_0, arg_1)
    ctx.return().v[f64](res)
}
@[export: 'vphp_wrap_vslim_config_get_string_list']
pub fn vphp_wrap_vslim_config_get_string_list(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.get_string_list(arg_0)
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_config_get_json']
pub fn vphp_wrap_vslim_config_get_json(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultJson', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultJson') { php_args.at_named_or_index(1, 'defaultJson').as_v[string]() } else { '' }
    res := recv.get_json(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_config_get']
pub fn vphp_wrap_vslim_config_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
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
@[export: 'vphp_wrap_vslim_config_get_map']
pub fn vphp_wrap_vslim_config_get_map(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'defaultValue').value
    res := recv.get_map(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_config_get_list']
pub fn vphp_wrap_vslim_config_get_list(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'defaultValue').value
    res := recv.get_list(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_config_all_json']
pub fn vphp_wrap_vslim_config_all_json(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.all_json()
    ctx.return().v[string](res)
}
@[export: 'vslim_config_handlers']
pub fn vslim_config_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_config_get_prop),
        write_handler: voidptr(vslim_config_set_prop),
        sync_handler: voidptr(vslim_config_sync_props),
        new_raw: voidptr(vslim_config_new_raw),
        cleanup_raw: voidptr(vslim_config_cleanup_raw),
        free_raw: voidptr(vslim_config_free_raw)
    )
}
pub fn VSlimConfig.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__config_ce)
}

pub fn VSlimConfig.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_config_handlers())
}

pub fn VSlimConfig.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimConfig](v_ptr, ownership)
}

pub fn (obj &VSlimConfig) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimConfig](obj)
}

pub fn (obj &VSlimConfig) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimConfig](obj)
}

pub fn (obj &VSlimConfig) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimConfig](obj)
}

pub fn (obj &VSlimConfig) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimConfig](obj)
}

pub fn (val VSlimConfig) php_class_name() string {
    return 'VSlim\\Config'
}


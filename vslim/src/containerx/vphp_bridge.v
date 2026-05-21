module containerx

import vphp

#include "php_bridge.h"

__global C.vslim__container__containerexception_ce &C.zend_class_entry
__global C.vslim__container__notfoundexception_ce &C.zend_class_entry
__global C.vslim__container_ce &C.zend_class_entry

@[export: 'VSlimContainerException_new_raw']
pub fn vslimcontainerexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimContainerException]()
}
@[export: 'VSlimContainerException_free_raw']
pub fn vslimcontainerexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimContainerException](ptr)
}
@[export: 'VSlimContainerException_cleanup_raw']
pub fn vslimcontainerexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimcontainerexception_load_from_php(php_obj vphp.ZendObject) VSlimContainerException {
    mut recv := VSlimContainerException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn vslimcontainerexception_sync_to_php(php_obj vphp.ZendObject, recv VSlimContainerException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'VSlimContainerException_get_prop']
pub fn vslimcontainerexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimContainerException_set_prop']
pub fn vslimcontainerexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimContainerException_sync_props']
pub fn vslimcontainerexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'VSlimContainerException_handlers']
pub fn vslimcontainerexception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimcontainerexception_get_prop),
        write_handler: voidptr(vslimcontainerexception_set_prop),
        sync_handler: voidptr(vslimcontainerexception_sync_props),
        new_raw: voidptr(vslimcontainerexception_new_raw),
        cleanup_raw: voidptr(vslimcontainerexception_cleanup_raw),
        free_raw: voidptr(vslimcontainerexception_free_raw)
    )
}
pub fn VSlimContainerException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__container__containerexception_ce)
}

pub fn VSlimContainerException.php_object_handlers() voidptr {
    return vslimcontainerexception_handlers()
}

pub fn VSlimContainerException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimContainerException](v_ptr, ownership)
}

pub fn (obj &VSlimContainerException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimContainerException](obj)
}

pub fn (obj &VSlimContainerException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimContainerException](obj)
}

pub fn (obj &VSlimContainerException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimContainerException](obj)
}

pub fn (obj &VSlimContainerException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimContainerException](obj)
}

@[export: 'VSlimContainerNotFoundException_new_raw']
pub fn vslimcontainernotfoundexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimContainerNotFoundException]()
}
@[export: 'VSlimContainerNotFoundException_free_raw']
pub fn vslimcontainernotfoundexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimContainerNotFoundException](ptr)
}
@[export: 'VSlimContainerNotFoundException_cleanup_raw']
pub fn vslimcontainernotfoundexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimcontainernotfoundexception_load_from_php(php_obj vphp.ZendObject) VSlimContainerNotFoundException {
    mut recv := VSlimContainerNotFoundException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn vslimcontainernotfoundexception_sync_to_php(php_obj vphp.ZendObject, recv VSlimContainerNotFoundException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'VSlimContainerNotFoundException_get_prop']
pub fn vslimcontainernotfoundexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimContainerNotFoundException_set_prop']
pub fn vslimcontainernotfoundexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimContainerNotFoundException_sync_props']
pub fn vslimcontainernotfoundexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'VSlimContainerNotFoundException_handlers']
pub fn vslimcontainernotfoundexception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimcontainernotfoundexception_get_prop),
        write_handler: voidptr(vslimcontainernotfoundexception_set_prop),
        sync_handler: voidptr(vslimcontainernotfoundexception_sync_props),
        new_raw: voidptr(vslimcontainernotfoundexception_new_raw),
        cleanup_raw: voidptr(vslimcontainernotfoundexception_cleanup_raw),
        free_raw: voidptr(vslimcontainernotfoundexception_free_raw)
    )
}
pub fn VSlimContainerNotFoundException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__container__notfoundexception_ce)
}

pub fn VSlimContainerNotFoundException.php_object_handlers() voidptr {
    return vslimcontainernotfoundexception_handlers()
}

pub fn VSlimContainerNotFoundException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimContainerNotFoundException](v_ptr, ownership)
}

pub fn (obj &VSlimContainerNotFoundException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimContainerNotFoundException](obj)
}

pub fn (obj &VSlimContainerNotFoundException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimContainerNotFoundException](obj)
}

pub fn (obj &VSlimContainerNotFoundException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimContainerNotFoundException](obj)
}

pub fn (obj &VSlimContainerNotFoundException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimContainerNotFoundException](obj)
}

@[export: 'VSlimContainer_new_raw']
pub fn vslimcontainer_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimContainer]()
}
@[export: 'VSlimContainer_free_raw']
pub fn vslimcontainer_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimContainer](ptr)
}
@[export: 'VSlimContainer_cleanup_raw']
pub fn vslimcontainer_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimContainer_get_prop']
pub fn vslimcontainer_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimContainer_set_prop']
pub fn vslimcontainer_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimContainer_sync_props']
pub fn vslimcontainer_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimContainer_construct']
pub fn vphp_wrap_vslimcontainer_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimContainer(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimContainer_set']
pub fn vphp_wrap_vslimcontainer_set(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimContainer(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.set(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimContainer_factory']
pub fn vphp_wrap_vslimcontainer_factory(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimContainer(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'callable', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'callable').callable() or {
        vphp.throw_exception('argument 1 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.factory(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimContainer_has']
pub fn vphp_wrap_vslimcontainer_has(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimContainer(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').as_v[string]()
    res := recv.has(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimContainer_get']
pub fn vphp_wrap_vslimcontainer_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimContainer(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').as_v[string]()
    res := recv.get(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'VSlimContainer_handlers']
pub fn vslimcontainer_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimcontainer_get_prop),
        write_handler: voidptr(vslimcontainer_set_prop),
        sync_handler: voidptr(vslimcontainer_sync_props),
        new_raw: voidptr(vslimcontainer_new_raw),
        cleanup_raw: voidptr(vslimcontainer_cleanup_raw),
        free_raw: voidptr(vslimcontainer_free_raw)
    )
}
pub fn VSlimContainer.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__container_ce)
}

pub fn VSlimContainer.php_object_handlers() voidptr {
    return vslimcontainer_handlers()
}

pub fn VSlimContainer.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimContainer](v_ptr, ownership)
}

pub fn (obj &VSlimContainer) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimContainer](obj)
}

pub fn (obj &VSlimContainer) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimContainer](obj)
}

pub fn (obj &VSlimContainer) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimContainer](obj)
}

pub fn (obj &VSlimContainer) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimContainer](obj)
}


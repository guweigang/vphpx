module containerx

import vphp
import vphp.object

#include "php_bridge.h"

__global C.vslim__container__containerexception_ce &C.zend_class_entry
__global C.vslim__container__notfoundexception_ce &C.zend_class_entry
__global C.vslim__container_ce &C.zend_class_entry

@[export: 'vslim_container_exception_new_raw']
pub fn vslim_container_exception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimContainerException]()
}
@[export: 'vslim_container_exception_free_raw']
pub fn vslim_container_exception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimContainerException](ptr)
}
@[export: 'vslim_container_exception_cleanup_raw']
pub fn vslim_container_exception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslim_container_exception_load_from_php(php_obj vphp.ZendObject) VSlimContainerException {
    mut recv := VSlimContainerException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn vslim_container_exception_sync_to_php(php_obj vphp.ZendObject, recv VSlimContainerException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'vslim_container_exception_get_prop']
pub fn vslim_container_exception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_container_exception_set_prop']
pub fn vslim_container_exception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_container_exception_sync_props']
pub fn vslim_container_exception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vslim_container_exception_handlers']
pub fn vslim_container_exception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_container_exception_get_prop),
        write_handler: voidptr(vslim_container_exception_set_prop),
        sync_handler: voidptr(vslim_container_exception_sync_props),
        new_raw: voidptr(vslim_container_exception_new_raw),
        cleanup_raw: voidptr(vslim_container_exception_cleanup_raw),
        free_raw: voidptr(vslim_container_exception_free_raw)
    )
}
pub fn VSlimContainerException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__container__containerexception_ce)
}

pub fn VSlimContainerException.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_container_exception_handlers())
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

pub fn (val VSlimContainerException) php_class_name() string {
    return 'VSlim\\Container\\ContainerException'
}

@[export: 'vslim_container_not_found_exception_new_raw']
pub fn vslim_container_not_found_exception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimContainerNotFoundException]()
}
@[export: 'vslim_container_not_found_exception_free_raw']
pub fn vslim_container_not_found_exception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimContainerNotFoundException](ptr)
}
@[export: 'vslim_container_not_found_exception_cleanup_raw']
pub fn vslim_container_not_found_exception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslim_container_not_found_exception_load_from_php(php_obj vphp.ZendObject) VSlimContainerNotFoundException {
    mut recv := VSlimContainerNotFoundException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn vslim_container_not_found_exception_sync_to_php(php_obj vphp.ZendObject, recv VSlimContainerNotFoundException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'vslim_container_not_found_exception_get_prop']
pub fn vslim_container_not_found_exception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_container_not_found_exception_set_prop']
pub fn vslim_container_not_found_exception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_container_not_found_exception_sync_props']
pub fn vslim_container_not_found_exception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vslim_container_not_found_exception_handlers']
pub fn vslim_container_not_found_exception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_container_not_found_exception_get_prop),
        write_handler: voidptr(vslim_container_not_found_exception_set_prop),
        sync_handler: voidptr(vslim_container_not_found_exception_sync_props),
        new_raw: voidptr(vslim_container_not_found_exception_new_raw),
        cleanup_raw: voidptr(vslim_container_not_found_exception_cleanup_raw),
        free_raw: voidptr(vslim_container_not_found_exception_free_raw)
    )
}
pub fn VSlimContainerNotFoundException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__container__notfoundexception_ce)
}

pub fn VSlimContainerNotFoundException.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_container_not_found_exception_handlers())
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

pub fn (val VSlimContainerNotFoundException) php_class_name() string {
    return 'VSlim\\Container\\NotFoundException'
}

@[export: 'vslim_container_new_raw']
pub fn vslim_container_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimContainer]()
}
@[export: 'vslim_container_free_raw']
pub fn vslim_container_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimContainer](ptr)
}
@[export: 'vslim_container_cleanup_raw']
pub fn vslim_container_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_container_get_prop']
pub fn vslim_container_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_container_set_prop']
pub fn vslim_container_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_container_sync_props']
pub fn vslim_container_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_container_construct']
pub fn vphp_wrap_vslim_container_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimContainer(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_container_set']
pub fn vphp_wrap_vslim_container_set(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_container_factory']
pub fn vphp_wrap_vslim_container_factory(ptr voidptr, ctx vphp.Context) voidptr {
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
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.factory(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_container_has']
pub fn vphp_wrap_vslim_container_has(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_container_get']
pub fn vphp_wrap_vslim_container_get(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vslim_container_handlers']
pub fn vslim_container_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_container_get_prop),
        write_handler: voidptr(vslim_container_set_prop),
        sync_handler: voidptr(vslim_container_sync_props),
        new_raw: voidptr(vslim_container_new_raw),
        cleanup_raw: voidptr(vslim_container_cleanup_raw),
        free_raw: voidptr(vslim_container_free_raw)
    )
}
pub fn VSlimContainer.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__container_ce)
}

pub fn VSlimContainer.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_container_handlers())
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

pub fn (val VSlimContainer) php_class_name() string {
    return 'VSlim\\Container'
}


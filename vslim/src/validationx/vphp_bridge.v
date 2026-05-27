module validationx

import vphp

#include "php_bridge.h"

__global C.vslim__validate__validator_ce &C.zend_class_entry

@[export: 'vslim_validator_new_raw']
pub fn vslim_validator_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimValidator]()
}
@[export: 'vslim_validator_free_raw']
pub fn vslim_validator_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimValidator](ptr)
}
@[export: 'vslim_validator_cleanup_raw']
pub fn vslim_validator_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_validator_get_prop']
pub fn vslim_validator_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_validator_set_prop']
pub fn vslim_validator_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_validator_sync_props']
pub fn vslim_validator_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_validator_make']
pub fn vphp_wrap_vslim_validator_make(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'data', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'rules', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'data').value
    arg_1 := php_args.at_named_or_index(1, 'rules').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := VSlimValidator.make(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_validator_construct']
pub fn vphp_wrap_vslim_validator_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimValidator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_validator_set_data']
pub fn vphp_wrap_vslim_validator_set_data(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimValidator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'data').value
    res := recv.set_data(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_validator_set_rules']
pub fn vphp_wrap_vslim_validator_set_rules(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimValidator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rules', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'rules').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.set_rules(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_validator_validate']
pub fn vphp_wrap_vslim_validator_validate(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimValidator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.validate()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_validator_passes']
pub fn vphp_wrap_vslim_validator_passes(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimValidator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.passes()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_validator_fails']
pub fn vphp_wrap_vslim_validator_fails(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimValidator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fails()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_validator_errors']
pub fn vphp_wrap_vslim_validator_errors(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimValidator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.errors()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_validator_validated']
pub fn vphp_wrap_vslim_validator_validated(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimValidator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.validated()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_validator_data']
pub fn vphp_wrap_vslim_validator_data(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimValidator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.data()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vslim_validator_handlers']
pub fn vslim_validator_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_validator_get_prop),
        write_handler: voidptr(vslim_validator_set_prop),
        sync_handler: voidptr(vslim_validator_sync_props),
        new_raw: voidptr(vslim_validator_new_raw),
        cleanup_raw: voidptr(vslim_validator_cleanup_raw),
        free_raw: voidptr(vslim_validator_free_raw)
    )
}
pub fn VSlimValidator.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__validate__validator_ce)
}

pub fn VSlimValidator.php_object_handlers() voidptr {
    return vslim_validator_handlers()
}

pub fn VSlimValidator.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimValidator](v_ptr, ownership)
}

pub fn (obj &VSlimValidator) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimValidator](obj)
}

pub fn (obj &VSlimValidator) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimValidator](obj)
}

pub fn (obj &VSlimValidator) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimValidator](obj)
}

pub fn (obj &VSlimValidator) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimValidator](obj)
}

pub fn (val VSlimValidator) php_class_name() string {
    return 'VSlim\\Validate\\Validator'
}


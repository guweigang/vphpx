#ifndef VPHP_BRIDGE_COMPAT_H
#define VPHP_BRIDGE_COMPAT_H

#include <php.h>
#include <Zend/zend_attributes.h>
#include <Zend/zend_closures.h>
#include <Zend/zend_exceptions.h>
#include <Zend/zend_inheritance.h>
#include <Zend/zend_list.h>

#if PHP_VERSION_ID < 80200
# error "vphp requires PHP 8.2 or newer"
#endif

#if PHP_VERSION_ID >= 80300
# define VPHP_ACC_TRAIT_FINAL ZEND_ACC_FINAL
#else
# define VPHP_ACC_TRAIT_FINAL 0
#endif

#if PHP_VERSION_ID >= 80400
# define VPHP_ZEND_RAW_FENTRY(name, handler, arg_info, flags) \
  ZEND_RAW_FENTRY(name, handler, arg_info, flags, NULL, NULL)
#else
# define VPHP_ZEND_RAW_FENTRY(name, handler, arg_info, flags) \
  ZEND_RAW_FENTRY(name, handler, arg_info, flags)
#endif

static inline zend_class_name *vphp_zend_trait_names(zend_class_name *names,
                                                       uint32_t count) {
#if PHP_VERSION_ID >= 80600
  zend_class_name *owned = pemalloc(count * sizeof(*owned), 1);
  memcpy(owned, names, count * sizeof(*owned));
  return owned;
#else
  (void)count;
  return names;
#endif
}

static inline zend_trait_alias **vphp_zend_trait_aliases(zend_trait_alias **aliases) {
#if PHP_VERSION_ID >= 80600
  size_t count = 0;
  while (aliases[count] != NULL) {
    count++;
  }
  zend_trait_alias **owned = pecalloc(count + 1, sizeof(*owned), 1);
  for (size_t i = 0; i < count; i++) {
    owned[i] = pemalloc(sizeof(*owned[i]), 1);
    *owned[i] = *aliases[i];
  }
  return owned;
#else
  return aliases;
#endif
}

#ifndef ZEND_TYPE_HAS_LITERAL_NAME
# define ZEND_TYPE_HAS_LITERAL_NAME(type) (0)
#endif

#ifndef ZEND_TYPE_LITERAL_NAME
# define ZEND_TYPE_LITERAL_NAME(type) NULL
#endif

/*
 * Keep direct Zend API touch-points centralized here so future PHP version
 * compatibility work stays in one place instead of leaking across the whole
 * bridge implementation.
 *
 * Prefer PHP/Zend's public extension macros where they already provide a
 * stable extension-facing API, for example REGISTER_*_CONSTANT and
 * ZEND_BEGIN_ARG_* macros. Add compat helpers here when vphp calls lower-level
 * Zend C functions directly and their signatures or return values differ
 * across supported PHP 8 minors.
 */
static inline zend_class_entry *
vphp_zend_get_called_scope(zend_execute_data *execute_data) {
  return zend_get_called_scope(execute_data);
}

static inline zend_class_entry *vphp_zend_lookup_class(zend_string *name) {
  return zend_lookup_class(name);
}

static inline zend_class_entry *vphp_zend_lookup_class_ex(zend_string *name) {
  return zend_lookup_class_ex(name, NULL, 0);
}

static inline bool vphp_zend_verify_scalar_type_hint(uint32_t mask, zval *value,
                                                     bool strict) {
  return zend_verify_scalar_type_hint(mask, value, strict, 1);
}

static inline void vphp_zend_wrong_parameters_count_error(uint32_t min_args,
                                                          uint32_t max_args) {
  zend_wrong_parameters_count_error(min_args, max_args);
}

static inline void vphp_zend_verify_arg_error(const zend_function *func,
                                              const zend_arg_info *arg_info,
                                              uint32_t arg_num, zval *value) {
  zend_verify_arg_error(func, arg_info, arg_num, value);
}

static inline void
vphp_zend_verify_return_error(const zend_function *func, zval *value) {
  zend_verify_return_error(func, value);
}

static inline void
vphp_zend_verify_never_error(const zend_function *func) {
  zend_verify_never_error(func);
}

static inline bool vphp_zend_check_user_type_slow(zend_type *type, zval *value,
                                                  zend_reference *ref,
                                                  bool is_return_type) {
#if PHP_VERSION_ID >= 80500
  return zend_check_user_type_slow(type, value, ref, is_return_type) != 0;
#else
  return zend_check_user_type_slow(type, value, ref, NULL, is_return_type) != 0;
#endif
}

static inline bool vphp_zend_is_true(zval *value) {
  return zend_is_true(value) != 0;
}

static inline zend_result vphp_zend_execute_scripts(int type, zval *retval,
                                                    int file_count,
                                                    zend_file_handle *file) {
  return zend_execute_scripts(type, retval, file_count, file);
}

static inline zend_result
vphp_zend_fcall_info_init(zval *callable, zend_object *receiver,
                         zend_fcall_info *fci, zend_fcall_info_cache *fcc,
                         char **error) {
  if (!zend_is_callable_ex(callable, receiver, 0, NULL, fcc, error)) {
    return FAILURE;
  }
  memset(fci, 0, sizeof(*fci));
  fci->size = sizeof(*fci);
  fci->object = fcc->object;
  ZVAL_COPY_VALUE(&fci->function_name, callable);
  return SUCCESS;
}

static inline zend_result vphp_zend_call_function(zend_fcall_info *fci,
                                                  zend_fcall_info_cache *fcc) {
  return zend_call_function(fci, fcc);
}

static inline zend_result
vphp_zend_init_with_constructor(zval *value, zend_class_entry *ce,
                                uint32_t count, zval *args,
                                HashTable *named_args) {
#if PHP_VERSION_ID >= 80400
  // Handle constructor visibility and constructor-less argument lists here.
  // Early PHP 8.6 builds can fault in the native helper's named-key lookup
  // for classes without a constructor.
  if (ce->constructor && (ce->constructor->common.fn_flags & ZEND_ACC_PUBLIC)) {
    return object_init_with_constructor(value, ce, count, args, named_args);
  }
#endif
  if (object_init_ex(value, ce) == FAILURE) {
    return FAILURE;
  }
  zend_object *object = Z_OBJ_P(value);
  zend_function *ctor = object->handlers->get_constructor(object);
  if (ctor) {
    zval result;
    ZVAL_UNDEF(&result);
    zend_call_known_function(ctor, object, ce, &result, count, args, named_args);
    zval_ptr_dtor(&result);
  } else if (named_args && !EG(exception)) {
    // A class without a constructor accepts positional arguments.
    zend_string *name;
    ZEND_HASH_FOREACH_STR_KEY(named_args, name) {
      if (name) {
        zend_throw_error(NULL, "Unknown named parameter $%s", ZSTR_VAL(name));
        break;
      }
    } ZEND_HASH_FOREACH_END();
  }
  if (!EG(exception)) {
    return SUCCESS;
  }
  zend_object_store_ctor_failed(object);
  zval_ptr_dtor(value);
  ZVAL_UNDEF(value);
  return FAILURE;
}

static inline void vphp_zend_create_closure(zval *zv, zend_function *func) {
  zend_create_closure(zv, func, NULL, NULL, NULL);
}

static inline zend_attribute *
vphp_zend_add_class_attribute(zend_class_entry *ce, zend_string *name,
                              uint32_t argc) {
  return zend_add_class_attribute(ce, name, argc);
}

static inline zend_attribute *
vphp_zend_add_parameter_attribute(zend_function *func, uint32_t offset,
                                  zend_string *name, uint32_t argc) {
  return zend_add_parameter_attribute(func, offset, name, argc);
}

/* The generated attribute owns aligned static storage for this AST. Its
 * strings are interned, and Zend evaluates a copy of the zval on demand. */
static inline char *vphp_begin_attribute_ast(zval *value, unsigned char *storage) {
  zend_ast_ref *reference = (zend_ast_ref *)storage;
  GC_SET_REFCOUNT(reference, 1);
  GC_TYPE_INFO(reference) = GC_CONSTANT_AST | GC_PERSISTENT | GC_IMMUTABLE;
  Z_TYPE_INFO_P(value) = IS_CONSTANT_AST;
  Z_AST_P(value) = reference;
  return (char *)GC_AST(reference);
}

static inline zend_ast *vphp_attribute_ast_node(char **cursor, zend_ast_kind kind,
                                                zend_ast_attr attr, uint32_t children) {
  zend_ast *node = (zend_ast *)*cursor;
  *cursor += zend_ast_size(children);
  node->kind = kind;
  node->attr = attr;
  node->lineno = 0;
  return node;
}

static inline zend_ast_zval *vphp_attribute_ast_literal(char **cursor) {
  zend_ast_zval *node = (zend_ast_zval *)*cursor;
  *cursor += sizeof(*node);
  node->kind = ZEND_AST_ZVAL;
  node->attr = 0;
  Z_LINENO(node->val) = 0;
  return node;
}

static inline zend_ast_list *vphp_attribute_ast_array(char **cursor, uint32_t count) {
  zend_ast_list *list = (zend_ast_list *)*cursor;
  *cursor += offsetof(zend_ast_list, child) + count * sizeof(zend_ast *);
  list->kind = ZEND_AST_ARRAY;
  list->attr = 0;
  list->lineno = 0;
  list->children = count;
  return list;
}

static inline zend_ast *vphp_attribute_ast_class_constant(char **cursor,
                                                            const char *class_name,
                                                            const char *constant_name) {
  zend_ast *node = vphp_attribute_ast_node(cursor, ZEND_AST_CLASS_CONST,
                                            ZEND_FETCH_CLASS_EXCEPTION, 2);
  zend_ast_zval *class_value = vphp_attribute_ast_literal(cursor);
  zend_ast_zval *constant_value = vphp_attribute_ast_literal(cursor);
  ZVAL_STR(&class_value->val, zend_string_init_interned(class_name, strlen(class_name), 1));
  ZVAL_STR(&constant_value->val, zend_string_init_interned(constant_name, strlen(constant_name), 1));
  node->child[0] = (zend_ast *)class_value;
  node->child[1] = (zend_ast *)constant_value;
  return node;
}

typedef struct vphp_attribute_array {
  HashTable table;
  struct vphp_attribute_array *next;
} vphp_attribute_array;

static vphp_attribute_array *vphp_attribute_arrays;

static inline HashTable *vphp_new_attribute_array(uint32_t size) {
  vphp_attribute_array *entry = pemalloc(sizeof(*entry), 1);
  zend_hash_init(&entry->table, size, NULL, ZVAL_PTR_DTOR, 1);
  entry->next = vphp_attribute_arrays;
  vphp_attribute_arrays = entry;
  return &entry->table;
}

static inline void vphp_set_attribute_array(zval *value, HashTable *table) {
  /* Internal attributes and property defaults need non-refcounted zvals.
   * Share an immutable table and let PHP copy it on writes.
   * Only interned strings and immutable nested arrays may be stored in it. */
  GC_ADD_FLAGS(table, GC_IMMUTABLE);
  GC_SET_REFCOUNT(table, 2);
  Z_ARR_P(value) = table;
  Z_TYPE_INFO_P(value) = IS_ARRAY;
}

static inline void vphp_release_attribute_arrays(void) {
  while (vphp_attribute_arrays) {
    vphp_attribute_array *entry = vphp_attribute_arrays;
    vphp_attribute_arrays = entry->next;
    GC_DEL_FLAGS(&entry->table, GC_IMMUTABLE);
    GC_SET_REFCOUNT(&entry->table, 1);
    zend_hash_destroy(&entry->table);
    pefree(entry, 1);
  }
}

typedef struct vphp_enum_case_alias {
  zend_class_constant *constant;
  struct vphp_enum_case_alias *next;
} vphp_enum_case_alias;

static vphp_enum_case_alias *vphp_enum_case_aliases;

static inline void vphp_track_enum_case_alias(zend_class_constant *constant) {
  vphp_enum_case_alias *entry = pemalloc(sizeof(*entry), 1);
  entry->constant = constant;
  entry->next = vphp_enum_case_aliases;
  vphp_enum_case_aliases = entry;
}

static inline void vphp_release_enum_case_aliases(void) {
  while (vphp_enum_case_aliases) {
    vphp_enum_case_alias *entry = vphp_enum_case_aliases;
    vphp_enum_case_aliases = entry->next;
    zval *value = &entry->constant->value;
    if (Z_TYPE_P(value) == IS_CONSTANT_AST) {
      /* Zend's internal-class destructor expects only native case ASTs. */
      pefree(Z_AST_P(value), 1);
      ZVAL_NULL(value);
    }
    pefree(entry, 1);
  }
}

static inline void vphp_prepare_class_constant_cache(zend_class_entry *ce) {
  /* Inheritance propagates the AST flag without allocating a request cache. */
  if (ce->type == ZEND_INTERNAL_CLASS &&
      (ce->ce_flags & ZEND_ACC_HAS_AST_CONSTANTS) &&
      !ZEND_MAP_PTR(ce->mutable_data)) {
    ZEND_MAP_PTR_NEW(ce->mutable_data);
  }
}

static inline zend_object *
vphp_zend_throw_exception(zend_class_entry *exception_ce, const char *message,
                          zend_long code) {
  return zend_throw_exception(exception_ce, message, code);
}

static inline void vphp_zend_throw_exception_object(zval *exception) {
  zend_throw_exception_object(exception);
}

static inline void vphp_zend_clear_exception(void) {
  zend_clear_exception();
}

static inline int
vphp_zend_register_list_destructors_ex(rsrc_dtor_func_t ld,
                                       rsrc_dtor_func_t pld,
                                       const char *type_name,
                                       int module_number) {
  return zend_register_list_destructors_ex(ld, pld, type_name, module_number);
}

static inline zend_resource *vphp_zend_register_resource(void *rsrc_pointer,
                                                         int rsrc_type) {
  return zend_register_resource(rsrc_pointer, rsrc_type);
}

static inline void *vphp_zend_fetch_resource(zend_resource *res,
                                             const char *resource_type_name,
                                             int resource_type) {
  return zend_fetch_resource(res, resource_type_name, resource_type);
}

static inline bool vphp_zend_is_callable(zval *value) {
  return zend_is_callable(value, 0, NULL) != 0;
}

static inline bool vphp_zend_is_iterable(zval *value) {
  return zend_is_iterable(value) != 0;
}

static inline int
vphp_zend_class_implements_interface(zend_class_entry *class_ce,
                                     zend_class_entry *iface_ce) {
  return zend_class_implements_interface(class_ce, iface_ce);
}

static inline void vphp_zend_do_implement_interface(zend_class_entry *class_ce,
                                                    zend_class_entry *iface_ce) {
  zend_do_implement_interface(class_ce, iface_ce);
  vphp_prepare_class_constant_cache(class_ce);
}

static inline zval *vphp_zend_read_static_property(zend_class_entry *ce,
                                                   const char *name,
                                                   size_t name_len) {
  return zend_read_static_property(ce, name, name_len, 1);
}

static inline zval *vphp_zend_read_property(zend_class_entry *scope,
                                            zend_object *object,
                                            const char *name,
                                            size_t name_len, bool silent,
                                            zval *rv) {
  return zend_read_property(scope, object, name, name_len, silent, rv);
}

static inline void vphp_zend_update_static_property(zend_class_entry *ce,
                                                    const char *name,
                                                    size_t name_len,
                                                    zval *value) {
  zend_update_static_property(ce, name, name_len, value);
}

static inline void
vphp_zend_update_static_property_long(zend_class_entry *ce, const char *name,
                                      size_t name_len, zend_long value) {
  zend_update_static_property_long(ce, name, name_len, value);
}

static inline void
vphp_zend_update_static_property_string(zend_class_entry *ce, const char *name,
                                        size_t name_len, const char *value,
                                        size_t value_len) {
  zend_update_static_property_stringl(ce, name, name_len, value, value_len);
}

static inline void
vphp_zend_update_static_property_bool(zend_class_entry *ce, const char *name,
                                      size_t name_len, bool value) {
  zend_update_static_property_bool(ce, name, name_len, value ? 1 : 0);
}

static inline zval *vphp_zend_get_class_constant(zend_string *class_name,
                                                 zend_string *const_name) {
  return zend_get_class_constant_ex(class_name, const_name, NULL, 0);
}

static inline void
vphp_zend_readonly_property_modification_error(zend_object *object,
                                               zend_string *member,
                                               zend_property_info *prop_info) {
#if PHP_VERSION_ID >= 80400
  zend_readonly_property_modification_error_ex(ZSTR_VAL(object->ce->name),
                                               ZSTR_VAL(member));
#else
  if (prop_info != NULL && prop_info != ZEND_WRONG_PROPERTY_INFO) {
    zend_readonly_property_modification_error(prop_info);
    return;
  }
  zend_throw_error(NULL, "Cannot modify readonly property %s::$%s",
                   ZSTR_VAL(object->ce->name), ZSTR_VAL(member));
#endif
}

#endif

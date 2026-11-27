#if PHP_VERSION_ID >= 80600
#include <main/php_poll.h>
#elif !defined(PHP_WIN32)
#include <poll.h>
#endif
#include <errno.h>
#include <main/php_network.h>

ZEND_TLS zend_object *vphp_running_task_fiber = NULL;
ZEND_TLS void *vphp_running_task_group = NULL;

void *vphp_task_enter_fiber(void *raw) {
  zval *value = raw;
  zend_object *previous = vphp_running_task_fiber;
  vphp_running_task_fiber = Z_OBJ_P(value);
  vphp_task_attach_fiber_gc(vphp_running_task_fiber);
  return previous;
}

void vphp_task_restore_fiber(void *previous) {
  vphp_running_task_fiber = previous;
}

bool vphp_task_can_suspend(void) {
  return EG(active_fiber) && vphp_running_task_fiber == &EG(active_fiber)->std;
}

void *vphp_task_swap_group(void *group) {
  void *previous = vphp_running_task_group;
  vphp_running_task_group = group;
  return previous;
}

void *vphp_task_current_group(void) {
  return vphp_task_can_suspend() ? vphp_running_task_group : NULL;
}

/* Status bits shared with the V scheduler. A hangup also wakes the waiter so
 * the caller can read EOF or observe the write error. */
#define VPHP_TASK_READ 1
#define VPHP_TASK_WRITE 2

static php_stream *vphp_task_stream(void *raw) {
  zval *value = raw;
  if (!value) return NULL;
  ZVAL_DEREF(value);
  if (Z_TYPE_P(value) != IS_RESOURCE) return NULL;
  zend_resource *resource = Z_RES_P(value);
  if (resource->type != php_file_le_stream() && resource->type != php_file_le_pstream()) {
    return NULL;
  }
  return resource->ptr;
}

bool vphp_task_stream_is_open(void *raw) {
  return vphp_task_stream(raw) != NULL;
}

bool vphp_task_stream_same(void *first, void *second) {
  php_stream *stream = vphp_task_stream(first);
  return stream && stream == vphp_task_stream(second);
}

bool vphp_task_socket_open(const char *address, size_t length, bool listen,
                           zval *context_value, zval *result, zval *failure) {
  ZVAL_UNDEF(result);
  ZVAL_UNDEF(failure);
  if (EG(exception)) return false;
  if (memchr(address, '\0', length)) {
    zend_value_error("Socket address must not contain null bytes");
    return false;
  }
  zend_string *error = NULL;
  int error_code = 0;
  vphp_static_sync *sync = vphp_suspend_static_sync();
  php_stream_context *context = php_stream_context_from_zval(context_value, 0);
  php_stream *stream = NULL;
  if (!EG(exception) && (!context_value || context)) {
    int flags = listen ? STREAM_XPORT_SERVER | STREAM_XPORT_BIND | STREAM_XPORT_LISTEN
        : STREAM_XPORT_CLIENT | STREAM_XPORT_CONNECT | STREAM_XPORT_CONNECT_ASYNC;
    stream = php_stream_xport_create(address, length, 0, flags, NULL, NULL, context,
                                    &error, &error_code);
  }
  /* Socket transports can return the previous blocking mode on success. */
  if (stream && php_stream_set_option(stream, PHP_STREAM_OPTION_BLOCKING, 0, NULL) < 0) {
    php_stream_close(stream);
    stream = NULL;
    if (!error) error = zend_string_init("Unable to set nonblocking mode",
        sizeof("Unable to set nonblocking mode") - 1, 0);
  }
  if (stream) {
    /* Older PHP transports do not record the protocol of socket listeners. */
    if (listen && !stream->orig_path) stream->orig_path = estrndup(address, length);
    php_stream_to_zval(stream, result);
  }
  vphp_resume_static_sync(sync);
  if (error) {
    if (stream && !EG(exception)) zend_string_release(error);
    else ZVAL_STR(failure, error);
  }
  return stream && !EG(exception);
}

int vphp_task_stream_descriptor(void *raw, uintptr_t *descriptor, bool *buffered) {
  php_stream *stream = vphp_task_stream(raw);
  if (!stream || EG(exception)) return FAILURE;
  php_socket_t fd;
  /* Polling borrows the descriptor while PHP keeps its read buffer. */
  vphp_static_sync *sync = vphp_suspend_static_sync();
  int result = EG(exception) ? FAILURE
      : php_stream_cast(stream, PHP_STREAM_AS_FD_FOR_SELECT | PHP_STREAM_CAST_INTERNAL,
                        (void **)&fd, 0);
  vphp_resume_static_sync(sync);
  if (result != SUCCESS || EG(exception) || vphp_task_stream(raw) != stream) {
    return FAILURE;
  }
  *descriptor = (uintptr_t)fd;
  *buffered = stream->writepos > stream->readpos || stream->eof;
  return SUCCESS;
}

static void vphp_task_socket_failure(zval *failure, int code) {
  char message[256];
  const char *text = php_socket_strerror(code, message, sizeof(message));
  ZVAL_STRING(failure, text ? text : "Socket operation failed");
}

bool vphp_task_socket_connected(void *raw, zval *failure) {
  ZVAL_UNDEF(failure);
  uintptr_t descriptor;
  bool buffered;
  if (vphp_task_stream_descriptor(raw, &descriptor, &buffered) != SUCCESS) return false;
  int code = 0;
  socklen_t size = sizeof(code);
  if (getsockopt((php_socket_t)descriptor, SOL_SOCKET, SO_ERROR, (char *)&code, &size) != 0) {
    code = php_socket_errno();
  }
  if (code != 0) {
    vphp_task_socket_failure(failure, code);
    return false;
  }
  php_stream *stream = vphp_task_stream(raw);
  zend_string *peer = NULL;
  bool connected = stream && php_stream_xport_get_name(stream, 1, &peer, NULL, NULL) == 0;
  if (peer) zend_string_release(peer);
  if (connected) return true;
  ZVAL_STRING(failure, "Socket has no connected peer");
  return false;
}

/* Return 0 when another accept or a transient failure leaves no client. */
int vphp_task_socket_accept(void *raw, zval *result, zval *failure) {
  ZVAL_UNDEF(result);
  ZVAL_UNDEF(failure);
  php_stream *listener = vphp_task_stream(raw);
  if (!listener || !listener->orig_path ||
      (strncmp(listener->orig_path, "tcp://", 6) != 0 &&
       strncmp(listener->orig_path, "unix://", 7) != 0)) {
    ZVAL_STRING(failure, "Expected a plain TCP or Unix socket listener");
    return -1;
  }
  uintptr_t descriptor;
  bool buffered;
  if (vphp_task_stream_descriptor(raw, &descriptor, &buffered) != SUCCESS) return -1;

  /* Check just before accept. Another Fiber may change the mode while waiting. */
  zval metadata;
  array_init(&metadata);
  bool populated = php_stream_populate_meta_data(listener, &metadata);
  zval *blocked = zend_hash_str_find(Z_ARRVAL(metadata), "blocked", sizeof("blocked") - 1);
  bool nonblocking = populated && blocked && Z_TYPE_P(blocked) == IS_FALSE;
  zval_ptr_dtor(&metadata);
  if (!nonblocking) {
    ZVAL_STRING(failure, "Accepting requires a nonblocking PHP socket listener");
    return -1;
  }

  /* accept validates the listening state, including on Darwin where
   * getsockopt(SO_ACCEPTCONN) is unavailable. */
  php_socket_t client = accept((php_socket_t)descriptor, NULL, NULL);
  if (client == SOCK_ERR) {
    int code = php_socket_errno();
#ifdef PHP_WIN32
    if (PHP_IS_TRANSIENT_ERROR(code) || code == WSAEINTR || code == WSAECONNABORTED) return 0;
#else
    if (PHP_IS_TRANSIENT_ERROR(code) || code == EINTR || code == ECONNABORTED) return 0;
#endif
    vphp_task_socket_failure(failure, code);
    return -1;
  }
  php_stream *stream = php_stream_sock_open_from_socket(client, NULL);
  if (!stream) {
    closesocket(client);
    ZVAL_STRING(failure, "Could not wrap the accepted socket");
    return -1;
  }
  if (php_stream_set_option(stream, PHP_STREAM_OPTION_BLOCKING, 0, NULL) < 0) {
    php_stream_close(stream);
    ZVAL_STRING(failure, "Unable to set nonblocking mode");
    return -1;
  }
  if (PHP_STREAM_CONTEXT(listener)) {
    php_stream_context_set(stream, PHP_STREAM_CONTEXT(listener));
  }
  php_stream_to_zval(stream, result);
  return 1;
}

int vphp_task_poll_wait(const uintptr_t *fds, const int *interests,
                        int *ready, int count, int milliseconds) {
#if PHP_VERSION_ID >= 80600
  php_poll_ctx *context = php_poll_create(PHP_POLL_BACKEND_AUTO, 0);
  if (!context) return -1;
  int result = -1;
  if (php_poll_init(context) == SUCCESS) {
    bool registered = true;
    for (int i = 0; i < count; i++) {
      uint32_t events = 0;
      if (interests[i] & VPHP_TASK_READ) events |= PHP_POLL_READ;
      if (interests[i] & VPHP_TASK_WRITE) events |= PHP_POLL_WRITE;
      if (php_poll_add(context, (int)fds[i], events,
                       (void *)(uintptr_t)(i + 1)) != SUCCESS) {
        registered = false;
        break;
      }
    }
    if (registered) {
      php_poll_event *events = safe_emalloc(count, sizeof(*events), 0);
      struct timespec timeout = {milliseconds / 1000, (milliseconds % 1000) * 1000000L};
      result = php_poll_wait(context, events, count, milliseconds < 0 ? NULL : &timeout);
      for (int i = 0; i < result; i++) {
        int index = (int)(uintptr_t)events[i].data - 1;
        if (index < 0 || index >= count) continue;
        if (events[i].revents & PHP_POLL_READ) ready[index] |= VPHP_TASK_READ;
        if (events[i].revents & PHP_POLL_WRITE) ready[index] |= VPHP_TASK_WRITE;
        if (events[i].revents & (PHP_POLL_ERROR | PHP_POLL_HUP | PHP_POLL_RDHUP)) {
          ready[index] |= interests[index];
        }
      }
      if (result < 0 && php_poll_get_error(context) == PHP_POLL_ERR_INTERRUPTED) result = 0;
      efree(events);
    }
  }
  php_poll_destroy(context);
  return result;
#else
#ifdef PHP_WIN32
  WSAPOLLFD *events = safe_emalloc(count, sizeof(*events), 0);
#else
  struct pollfd *events = safe_emalloc(count, sizeof(*events), 0);
#endif
  for (int i = 0; i < count; i++) {
    events[i].fd = (php_socket_t)fds[i];
    events[i].events = 0;
    events[i].revents = 0;
    if (interests[i] & VPHP_TASK_READ) events[i].events |= POLLIN;
    if (interests[i] & VPHP_TASK_WRITE) events[i].events |= POLLOUT;
  }
#ifdef PHP_WIN32
  int result = WSAPoll(events, (ULONG)count, milliseconds);
  if (result < 0 && WSAGetLastError() == WSAEINTR) result = 0;
#else
  int result = poll(events, (nfds_t)count, milliseconds);
  if (result < 0 && errno == EINTR) result = 0;
#endif
  if (result > 0) {
    for (int i = 0; i < count; i++) {
      if (events[i].revents & POLLIN) ready[i] |= VPHP_TASK_READ;
      if (events[i].revents & POLLOUT) ready[i] |= VPHP_TASK_WRITE;
      if (events[i].revents & (POLLERR | POLLHUP | POLLNVAL)) ready[i] |= interests[i];
    }
  }
  efree(events);
  return result;
#endif
}

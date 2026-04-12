(function () {
  function readRoot() {
    return document.querySelector("[data-vphp-live]");
  }

  function wsUrl(endpoint) {
    const url = new URL(endpoint, window.location.href);
    if (url.protocol === "http:") {
      url.protocol = "ws:";
    } else if (url.protocol === "https:") {
      url.protocol = "wss:";
    }
    return url.toString();
  }

  function payloadValue(value) {
    if (value == null) {
      return "";
    }
    if (typeof value === "string") {
      return value;
    }
    if (typeof value === "number" || typeof value === "boolean") {
      return value;
    }
    return String(value);
  }

  function collectValueAttrs(element) {
    const out = {};
    for (const attr of Array.from(element.attributes || [])) {
      if (!attr.name.startsWith("vphp-value-")) {
        continue;
      }
      const key = attr.name.slice("vphp-value-".length).trim();
      if (!key) {
        continue;
      }
      out[key] = payloadValue(attr.value);
    }
    return out;
  }

  function elementTarget(element) {
    if (!(element instanceof Element)) {
      return "";
    }
    return (element.getAttribute("vphp-target") || "").trim();
  }

  function serializeForm(form) {
    const out = {};
    const data = new FormData(form);
    for (const [key, value] of data.entries()) {
      if (key in out) {
        if (Array.isArray(out[key])) {
          out[key].push(value);
        } else {
          out[key] = [out[key], value];
        }
        continue;
      }
      out[key] = value;
    }
    return out;
  }

  function isPreservedNode(node) {
    return node instanceof Element && node.hasAttribute("data-vphp-preserve");
  }

  function hasPreservedDescendant(node) {
    return node instanceof Element && node.querySelector("[data-vphp-preserve]") !== null;
  }

  function dispatchPatched(ops) {
    window.dispatchEvent(
      new CustomEvent("vphp:live:patched", {
        detail: {
          ops: Array.isArray(ops) ? ops : [],
        },
      })
    );
  }

  function applyPatch(payload, hooks) {
    const ops = Array.isArray(payload.ops) ? payload.ops : [];
    for (const op of ops) {
      const id = op && typeof op.id === "string" ? op.id : "";
      if (!id) {
        continue;
      }
      const target = document.getElementById(id);
      if (!target) {
        continue;
      }
      if (op.op === "remove") {
        if (isPreservedNode(target)) {
          continue;
        }
        target.remove();
        continue;
      }
      if (op.op === "append" && typeof op.html === "string") {
        if (isPreservedNode(target)) {
          continue;
        }
        target.insertAdjacentHTML("beforeend", op.html);
        continue;
      }
      if (op.op === "prepend" && typeof op.html === "string") {
        if (isPreservedNode(target)) {
          continue;
        }
        target.insertAdjacentHTML("afterbegin", op.html);
        continue;
      }
      if (op.op === "set_text" && typeof op.text === "string") {
        target.textContent = op.text;
        continue;
      }
      if (op.op === "set_attr" && typeof op.name === "string") {
        target.setAttribute(op.name, typeof op.value === "string" ? op.value : "");
        continue;
      }
      if (op.op === "set_props" && op.props && typeof op.props === "object") {
        Object.keys(op.props).forEach(function (key) {
          target[key] = op.props[key];
        });
        window.dispatchEvent(
          new CustomEvent("vphp:live:props", {
            detail: {
              id: id,
              props: op.props,
            },
          })
        );
        continue;
      }
      if (op.op === "replace" && typeof op.html === "string") {
        if (isPreservedNode(target) || hasPreservedDescendant(target)) {
          continue;
        }
        target.outerHTML = op.html;
      }
    }
    dispatchPatched(ops);
    const flashes = Array.isArray(payload.flash) ? payload.flash : [];
    for (const item of flashes) {
      if (!item || typeof item.message !== "string" || !item.message) {
        continue;
      }
      const kind = typeof item.kind === "string" && item.kind ? item.kind : "info";
      document.querySelectorAll('[data-vphp-flash="' + kind + '"]').forEach(function (node) {
        node.textContent = item.message;
        node.dataset.vphpFlashState = "visible";
        if (node._vphpFlashTimer) {
          window.clearTimeout(node._vphpFlashTimer);
        }
        const delay = Number(node.getAttribute("data-vphp-flash-timeout") || "2400");
        node._vphpFlashTimer = window.setTimeout(function () {
          node.textContent = "";
          node.dataset.vphpFlashState = "idle";
        }, Number.isFinite(delay) && delay >= 0 ? delay : 2400);
      });
      window.dispatchEvent(
        new CustomEvent("vphp:live:flash", {
          detail: {
            kind: kind,
            message: item.message,
          },
        })
      );
    }
    if (typeof payload.redirect_to === "string" && payload.redirect_to) {
      window.location.assign(payload.redirect_to);
      return;
    }
    if (typeof payload.navigate_to === "string" && payload.navigate_to && hooks && typeof hooks.navigate === "function") {
      hooks.navigate(payload.navigate_to);
      return;
    }
    const events = Array.isArray(payload.events) ? payload.events : [];
    for (const event of events) {
      if (!event || typeof event.event !== "string" || !event.event) {
        continue;
      }
      window.dispatchEvent(
        new CustomEvent("vphp:live:" + event.event, {
          detail: event.payload ?? null,
        })
      );
    }
  }

  function connect(root) {
    const endpoint = root.dataset.vphpLiveEndpoint || "/live";
    const path = root.dataset.vphpLivePath || (window.location.pathname + window.location.search);
    const rootId = root.dataset.vphpLiveRoot || root.id || "live-root";
    let socket = null;
    let heartbeatTimer = null;
    let reconnectTimer = null;
    let reconnectAttempts = 0;
    let unloading = false;
    const pendingMessages = [];
    const debounceTimers = new WeakMap();
    const throttleState = new WeakMap();
    const loadingCleanups = [];

    function pushCleanup(fn) {
      if (typeof fn === "function") {
        loadingCleanups.push(fn);
      }
    }

    function parseLoadingAttrs(raw) {
      const entries = [];
      if (typeof raw !== "string" || !raw.trim()) {
        return entries;
      }
      raw.split(",").forEach(function (chunk) {
        const part = chunk.trim();
        if (!part) {
          return;
        }
        const idx = part.indexOf("=");
        if (idx === -1) {
          entries.push({ name: part, value: "true" });
          return;
        }
        const name = part.slice(0, idx).trim();
        const value = part.slice(idx + 1).trim();
        if (!name) {
          return;
        }
        entries.push({ name: name, value: value });
      });
      return entries;
    }

    function loadingTargets(source) {
      if (!(source instanceof Element)) {
        return [];
      }
      const raw = (source.getAttribute("vphp-loading-target") || "").trim();
      if (!raw) {
        return [source];
      }
      const targets = [];
      raw.split(",").forEach(function (selector) {
        const token = selector.trim();
        if (!token) {
          return;
        }
        if (token === "self") {
          targets.push(source);
          return;
        }
        if (token === "root") {
          targets.push(root);
          return;
        }
        if (token === "form") {
          const form = source.closest ? source.closest("form") : null;
          if (form instanceof HTMLFormElement) {
            targets.push(form);
          }
          return;
        }
        document.querySelectorAll(token).forEach(function (node) {
          if (node instanceof Element) {
            targets.push(node);
          }
        });
      });
      return Array.from(new Set(targets));
    }

    function setLoading(active) {
      root.classList.toggle("vphp-loading", !!active);
    }

    function rememberDisableWith(element) {
      if (!(element instanceof Element)) {
        return;
      }
      const text = (element.getAttribute("vphp-disable-with") || "").trim();
      if (!text) {
        return;
      }
      if (!element.hasAttribute("data-vphp-disable-original")) {
        element.setAttribute("data-vphp-disable-original", element.textContent || "");
      }
      element.textContent = text;
    }

    function restoreDisableWith(scope) {
      const nodes = scope && typeof scope.querySelectorAll === "function"
        ? scope.querySelectorAll("[data-vphp-disable-original]")
        : document.querySelectorAll("[data-vphp-disable-original]");
      nodes.forEach(function (node) {
        node.textContent = node.getAttribute("data-vphp-disable-original") || "";
        node.removeAttribute("data-vphp-disable-original");
      });
    }

    function markLoading(source, kind) {
      const phaseClass = kind ? "vphp-" + kind + "-loading" : "";
      setLoading(true);
      if (phaseClass) {
        root.classList.add(phaseClass);
        pushCleanup(function () {
          root.classList.remove(phaseClass);
        });
      }
      if (source instanceof Element) {
        source.classList.add("vphp-loading");
        if (phaseClass) {
          source.classList.add(phaseClass);
        }
        if ("disabled" in source) {
          source.disabled = true;
        }
        rememberDisableWith(source);
        pushCleanup(function () {
          source.classList.remove("vphp-loading");
          if (phaseClass) {
            source.classList.remove(phaseClass);
          }
          if ("disabled" in source) {
            source.disabled = false;
          }
        });
      }
      const form = source instanceof Element && source.closest ? source.closest("form") : null;
      if (form instanceof HTMLFormElement) {
        form.classList.add("vphp-loading");
        if (phaseClass) {
          form.classList.add(phaseClass);
        }
        pushCleanup(function () {
          form.classList.remove("vphp-loading");
          if (phaseClass) {
            form.classList.remove(phaseClass);
          }
        });
      }
      const targetClass = source instanceof Element ? (source.getAttribute("vphp-loading-class") || "").trim() : "";
      const targetAttrs = source instanceof Element ? parseLoadingAttrs(source.getAttribute("vphp-loading-attr") || "") : [];
      loadingTargets(source).forEach(function (node) {
        node.classList.add("vphp-loading");
        if (phaseClass) {
          node.classList.add(phaseClass);
        }
        if (targetClass) {
          targetClass.split(/\s+/).forEach(function (name) {
            if (name) {
              node.classList.add(name);
            }
          });
        }
        targetAttrs.forEach(function (entry) {
          node.setAttribute(entry.name, entry.value);
        });
        pushCleanup(function () {
          node.classList.remove("vphp-loading");
          if (phaseClass) {
            node.classList.remove(phaseClass);
          }
          if (targetClass) {
            targetClass.split(/\s+/).forEach(function (name) {
              if (name) {
                node.classList.remove(name);
              }
            });
          }
          targetAttrs.forEach(function (entry) {
            node.removeAttribute(entry.name);
          });
        });
      });
    }

    function clearLoading() {
      setLoading(false);
      while (loadingCleanups.length > 0) {
        const cleanup = loadingCleanups.pop();
        cleanup();
      }
      restoreDisableWith(document);
    }

    function debounceDelay(element) {
      if (!(element instanceof Element)) {
        return 0;
      }
      const raw = (element.getAttribute("vphp-debounce") || "").trim();
      if (!raw) {
        return 0;
      }
      if (raw === "blur") {
        return -1;
      }
      const value = Number(raw);
      return Number.isFinite(value) && value > 0 ? value : 0;
    }

    function throttleDelay(element) {
      if (!(element instanceof Element)) {
        return 0;
      }
      const raw = (element.getAttribute("vphp-throttle") || "").trim();
      if (!raw) {
        return 0;
      }
      const value = Number(raw);
      return Number.isFinite(value) && value > 0 ? value : 0;
    }

    function scheduleDebounced(element, callback) {
      const delay = debounceDelay(element);
      if (delay === -1) {
        return false;
      }
      if (delay <= 0) {
        callback();
        return true;
      }
      const existing = debounceTimers.get(element);
      if (existing) {
        window.clearTimeout(existing);
      }
      const timer = window.setTimeout(function () {
        debounceTimers.delete(element);
        callback();
      }, delay);
      debounceTimers.set(element, timer);
      return true;
    }

    function scheduleThrottled(element, callback) {
      const delay = throttleDelay(element);
      if (delay <= 0) {
        callback();
        return true;
      }
      const now = Date.now();
      const state = throttleState.get(element) || { lastRun: 0, timer: null };
      const remaining = delay - (now - state.lastRun);
      if (remaining <= 0) {
        if (state.timer) {
          window.clearTimeout(state.timer);
          state.timer = null;
        }
        state.lastRun = now;
        throttleState.set(element, state);
        callback();
        return true;
      }
      if (state.timer) {
        return true;
      }
      state.timer = window.setTimeout(function () {
        state.lastRun = Date.now();
        state.timer = null;
        throttleState.set(element, state);
        callback();
      }, remaining);
      throttleState.set(element, state);
      return true;
    }

    function scheduleChangeEvent(element, callback) {
      const debounce = debounceDelay(element);
      if (debounce === -1) {
        return false;
      }
      if (debounce > 0) {
        return scheduleDebounced(element, callback);
      }
      const throttle = throttleDelay(element);
      if (throttle > 0) {
        return scheduleThrottled(element, callback);
      }
      callback();
      return true;
    }

    function setStatus(status) {
      root.classList.remove("vphp-connected", "vphp-connecting", "vphp-reconnecting", "vphp-closed", "vphp-error");
      if (status) {
        root.classList.add("vphp-" + status);
      }
      window.dispatchEvent(
        new CustomEvent("vphp:live:status", {
          detail: {
            status: status,
            attempts: reconnectAttempts,
          },
        })
      );
    }

    function clearHeartbeat() {
      if (heartbeatTimer !== null) {
        window.clearInterval(heartbeatTimer);
        heartbeatTimer = null;
      }
    }

    function clearReconnect() {
      if (reconnectTimer !== null) {
        window.clearTimeout(reconnectTimer);
        reconnectTimer = null;
      }
    }

    function enqueue(message) {
      pendingMessages.push(message);
    }

    function flushPending() {
      while (pendingMessages.length > 0) {
        const message = pendingMessages.shift();
        if (!message) {
          continue;
        }
        if (!send(message, false)) {
          pendingMessages.unshift(message);
          break;
        }
      }
    }

    function scheduleReconnect() {
      if (unloading || reconnectTimer !== null) {
        return;
      }
      reconnectAttempts += 1;
      setStatus("reconnecting");
      const delay = Math.min(500 * Math.pow(2, reconnectAttempts - 1), 5000);
      reconnectTimer = window.setTimeout(function () {
        reconnectTimer = null;
        openSocket();
      }, delay);
    }

    function send(message, allowQueue) {
      if (socket && socket.readyState === WebSocket.OPEN) {
        socket.send(JSON.stringify(message));
        return true;
      }
      if (allowQueue !== false) {
        enqueue(message);
      }
      if (!unloading) {
        scheduleReconnect();
      }
      return false;
    }

    function joinPath(nextPath) {
      const joinedPath = typeof nextPath === "string" && nextPath ? nextPath : (root.dataset.vphpLivePath || (window.location.pathname + window.location.search));
      root.dataset.vphpLivePath = joinedPath;
      send({
        type: "join",
        path: joinedPath,
        root_id: root.dataset.vphpLiveRoot || rootId,
      }, false);
    }

    function navigate(nextPath) {
      const current = root.dataset.vphpLivePath || (window.location.pathname + window.location.search);
      if (typeof nextPath !== "string" || !nextPath || nextPath === current) {
        return;
      }
      window.history.pushState({}, "", nextPath);
      joinPath(nextPath);
    }

    function openSocket() {
      clearReconnect();
      clearHeartbeat();
      if (socket && (socket.readyState === WebSocket.OPEN || socket.readyState === WebSocket.CONNECTING)) {
        return;
      }
      setStatus("connecting");
      socket = new WebSocket(wsUrl(endpoint));

      socket.addEventListener("open", function () {
        reconnectAttempts = 0;
        setStatus("connected");
        joinPath(path);
        flushPending();
        heartbeatTimer = window.setInterval(function () {
          send({ type: "heartbeat" }, false);
        }, 15000);
      });

      socket.addEventListener("message", function (event) {
        let payload = null;
        try {
          payload = JSON.parse(event.data);
        } catch (_error) {
          return;
        }
        if (!payload || payload.type === "heartbeat") {
          return;
        }
        if (payload.type !== "patch") {
          return;
        }
        clearLoading();
        applyPatch(payload, { navigate: navigate });
      });

      socket.addEventListener("close", function () {
        clearHeartbeat();
        clearLoading();
        socket = null;
        if (!unloading) {
          scheduleReconnect();
        } else {
          setStatus("closed");
        }
      });

      socket.addEventListener("error", function () {
        clearLoading();
        setStatus("error");
      });
    }

    window.addEventListener("beforeunload", function () {
      unloading = true;
      clearHeartbeat();
      clearReconnect();
      if (socket) {
        socket.close();
      }
    });

    window.addEventListener("popstate", function () {
      if (!socket || socket.readyState !== WebSocket.OPEN) {
        return;
      }
      joinPath(window.location.pathname + window.location.search);
    });

    document.addEventListener("click", function (event) {
      const target = event.target instanceof Element ? event.target.closest("[vphp-click]") : null;
      if (!target || !document.documentElement.contains(target)) {
        return;
      }
      const eventName = target.getAttribute("vphp-click");
      if (!eventName) {
        return;
      }
      event.preventDefault();
      const payload = collectValueAttrs(target);
      const componentTarget = elementTarget(target);
      if (componentTarget) {
        payload.target = componentTarget;
      }
      markLoading(target, "click");
      send({
        type: "event",
        event: eventName,
        payload: payload,
      });
    });

    document.addEventListener("submit", function (event) {
      const form = event.target instanceof HTMLFormElement ? event.target : null;
      if (!form || !form.hasAttribute("vphp-submit")) {
        return;
      }
      const eventName = form.getAttribute("vphp-submit");
      if (!eventName) {
        return;
      }
      event.preventDefault();
      const payload = serializeForm(form);
      const componentTarget = elementTarget(form);
      if (componentTarget) {
        payload.target = componentTarget;
      }
      markLoading(form, "submit");
      send({
        type: "event",
        event: eventName,
        payload: payload,
      });
    });

    document.addEventListener("change", function (event) {
      const field = event.target instanceof Element ? event.target.closest("[vphp-change]") : null;
      if (!field) {
        return;
      }
      const eventName = field.getAttribute("vphp-change");
      if (!eventName) {
        return;
      }
      if (event.type === "change" && debounceDelay(field) === -1) {
        return;
      }
      const form = field.form instanceof HTMLFormElement ? field.form : null;
      const payload = form ? serializeForm(form) : collectValueAttrs(field);
      const componentTarget = elementTarget(field);
      if (componentTarget) {
        payload.target = componentTarget;
      }
      scheduleChangeEvent(field, function () {
        markLoading(field, "change");
        send({
          type: "event",
          event: eventName,
          payload: payload,
        });
      });
    });

    document.addEventListener("blur", function (event) {
      const field = event.target instanceof Element ? event.target.closest("[vphp-change][vphp-debounce=\"blur\"]") : null;
      if (!field) {
        return;
      }
      const eventName = field.getAttribute("vphp-change");
      if (!eventName) {
        return;
      }
      const form = field.form instanceof HTMLFormElement ? field.form : null;
      const payload = form ? serializeForm(form) : collectValueAttrs(field);
      const componentTarget = elementTarget(field);
      if (componentTarget) {
        payload.target = componentTarget;
      }
      markLoading(field, "change");
      send({
        type: "event",
        event: eventName,
        payload: payload,
      });
    }, true);

    openSocket();
  }

  const root = readRoot();
  if (!root) {
    return;
  }
  connect(root);
})();

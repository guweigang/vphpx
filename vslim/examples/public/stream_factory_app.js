(() => {
  const root = document.querySelector('[data-stream-factory-demo="1"]');
  if (!root) {
    return;
  }

  const topicEl = document.getElementById('topic');
  const promptEl = document.getElementById('prompt');
  const modelEl = document.getElementById('model');
  const outputEl = document.getElementById('output');
  const statusEl = document.getElementById('status');

  const plainTextBtn = document.getElementById('run-text');
  const plainSseBtn = document.getElementById('run-sse');
  const ollamaTextBtn = document.getElementById('run-ollama-text');
  const ollamaSseBtn = document.getElementById('run-ollama-sse');
  const clearBtn = document.getElementById('clear-output');

  let activeController = null;
  let activeSource = null;

  function setStatus(message) {
    statusEl.textContent = message;
  }

  function appendOutput(chunk) {
    outputEl.value += chunk;
    outputEl.scrollTop = outputEl.scrollHeight;
  }

  function resetActive() {
    if (activeController) {
      activeController.abort();
      activeController = null;
    }
    if (activeSource) {
      activeSource.close();
      activeSource = null;
    }
  }

  function clearOutput() {
    resetActive();
    outputEl.value = '';
    setStatus('Cleared.');
  }

  function buildPlainUrl(base) {
    return `${base}?topic=${encodeURIComponent(topicEl.value.trim())}`;
  }

  function buildOllamaUrl(base) {
    return `${base}?prompt=${encodeURIComponent(promptEl.value.trim())}&model=${encodeURIComponent(modelEl.value.trim())}`;
  }

  async function runText(url, label) {
    resetActive();
    outputEl.value = '';
    setStatus(`Connecting to ${label} ...`);

    const controller = new AbortController();
    activeController = controller;

    try {
      const res = await fetch(url, { signal: controller.signal });
      if (!res.ok || !res.body) {
        throw new Error(`HTTP ${res.status}`);
      }
      setStatus(`Streaming from ${label}`);

      const reader = res.body.getReader();
      const decoder = new TextDecoder();
      while (true) {
        const { value, done } = await reader.read();
        if (done) {
          break;
        }
        appendOutput(decoder.decode(value, { stream: true }));
      }
      setStatus(`Completed ${label}.`);
    } catch (err) {
      if (err.name === 'AbortError') {
        setStatus(`${label} aborted.`);
      } else {
        setStatus(`${label} failed: ${err.message}`);
      }
    } finally {
      activeController = null;
    }
  }

  function runSse(url, label, extractor) {
    resetActive();
    outputEl.value = '';
    setStatus(`Connecting to ${label} ...`);

    const source = new EventSource(url);
    activeSource = source;

    source.addEventListener('token', (event) => {
      try {
        const payload = JSON.parse(event.data);
        appendOutput(extractor(payload, event.data));
      } catch {
        appendOutput(event.data);
      }
      setStatus(`Receiving ${label}`);
    });

    source.addEventListener('done', (event) => {
      appendOutput('\n');
      setStatus(`Completed ${label}: ${event.data}`);
      source.close();
      activeSource = null;
    });

    source.onerror = () => {
      setStatus(`${label} closed or failed.`);
      source.close();
      activeSource = null;
    };
  }

  plainTextBtn.addEventListener('click', () => {
    void runText(buildPlainUrl('/stream/text'), '/stream/text');
  });

  plainSseBtn.addEventListener('click', () => {
    runSse(buildPlainUrl('/stream/sse'), '/stream/sse', (payload, fallback) => payload.token ?? fallback);
  });

  ollamaTextBtn.addEventListener('click', () => {
    void runText(buildOllamaUrl('/ollama/text'), '/ollama/text');
  });

  ollamaSseBtn.addEventListener('click', () => {
    runSse(buildOllamaUrl('/ollama/sse'), '/ollama/sse', (payload, fallback) => payload.token ?? fallback);
  });

  clearBtn.addEventListener('click', clearOutput);
})();

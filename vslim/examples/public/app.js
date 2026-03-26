(() => {
  const root = document.querySelector('[data-ollama-demo="1"]');
  if (!root) {
    console.log('vslim demo assets loaded');
    return;
  }

  const promptEl = document.getElementById('prompt');
  const modelEl = document.getElementById('model');
  const outputEl = document.getElementById('output');
  const statusEl = document.getElementById('status');
  const textBtn = document.getElementById('run-text');
  const sseBtn = document.getElementById('run-sse');
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

  function buildUrl(base) {
    const prompt = encodeURIComponent(promptEl.value.trim());
    const model = encodeURIComponent(modelEl.value.trim());
    return `${base}?prompt=${prompt}&model=${model}`;
  }

  async function runText() {
    resetActive();
    outputEl.value = '';
    setStatus('Connecting to /ollama/text ...');

    const controller = new AbortController();
    activeController = controller;

    try {
      const res = await fetch(buildUrl('/ollama/text'), { signal: controller.signal });
      if (!res.ok || !res.body) {
        throw new Error(`HTTP ${res.status}`);
      }
      setStatus('Streaming text from /ollama/text');

      const reader = res.body.getReader();
      const decoder = new TextDecoder();
      while (true) {
        const { value, done } = await reader.read();
        if (done) {
          break;
        }
        appendOutput(decoder.decode(value, { stream: true }));
      }
      setStatus('Completed text stream.');
    } catch (err) {
      if (err.name === 'AbortError') {
        setStatus('Text stream aborted.');
      } else {
        setStatus(`Text stream failed: ${err.message}`);
      }
    } finally {
      activeController = null;
    }
  }

  function runSse() {
    resetActive();
    outputEl.value = '';
    setStatus('Connecting to /ollama/sse ...');

    const source = new EventSource(buildUrl('/ollama/sse'));
    activeSource = source;

    source.addEventListener('token', (event) => {
      try {
        const payload = JSON.parse(event.data);
        appendOutput(payload.token ?? '');
      } catch {
        appendOutput(event.data);
      }
      setStatus('Receiving SSE tokens from /ollama/sse');
    });

    source.addEventListener('done', (event) => {
      appendOutput('\n');
      setStatus(`SSE completed: ${event.data}`);
      source.close();
      activeSource = null;
    });

    source.onerror = () => {
      setStatus('SSE stream closed or failed.');
      source.close();
      activeSource = null;
    };
  }

  textBtn.addEventListener('click', () => {
    void runText();
  });
  sseBtn.addEventListener('click', runSse);
  clearBtn.addEventListener('click', () => {
    resetActive();
    outputEl.value = '';
    setStatus('Cleared.');
  });
})();

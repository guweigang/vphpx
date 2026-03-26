(function () {
  const root = document.querySelector('[data-vslim-websocket-demo]');
  if (!root) {
    return;
  }

  const urlInput = document.getElementById('ws-url');
  const roomInput = document.getElementById('ws-room');
  const userInput = document.getElementById('ws-user');
  const messageInput = document.getElementById('ws-message');
  const log = document.getElementById('ws-log');
  const status = document.getElementById('ws-status');
  const connectBtn = document.getElementById('ws-connect');
  const sendBtn = document.getElementById('ws-send');
  const byeBtn = document.getElementById('ws-bye');
  const disconnectBtn = document.getElementById('ws-disconnect');
  const clearBtn = document.getElementById('ws-clear');

  let socket = null;

  function write(line) {
    const stamp = new Date().toLocaleTimeString('en-GB', { hour12: false });
    log.value += `[${stamp}] ${line}\n`;
    log.scrollTop = log.scrollHeight;
  }

  function setStatus(text) {
    status.textContent = text;
  }

  function websocketUrl() {
    const base = urlInput.value.trim();
    const room = roomInput.value.trim() || 'lobby';
    const user = userInput.value.trim() || 'guest';
    const url = new URL(base);
    url.searchParams.set('room', room);
    url.searchParams.set('user', user);
    return url.toString();
  }

  function renderMessage(payload) {
    if (!payload || typeof payload !== 'object') {
      return null;
    }
    const prefix = payload.type === 'system' ? '[system]' : `[${payload.room || 'room'}]`;
    const author = payload.user ? `${payload.user}: ` : '';
    const tail = payload.self ? ' (self)' : '';
    return `${prefix} ${author}${payload.text || ''}${tail}`.trim();
  }

  function connect() {
    if (socket && socket.readyState === WebSocket.OPEN) {
      return;
    }
    const url = websocketUrl();
    write(`CONNECT ${url}`);
    socket = new WebSocket(url);

    socket.addEventListener('open', () => {
      write('OPEN');
      setStatus('Connected.');
    });
    socket.addEventListener('message', (event) => {
      try {
        const payload = JSON.parse(event.data);
        write(`RECV ${renderMessage(payload) || event.data}`);
      } catch {
        write(`RECV ${event.data}`);
      }
    });
    socket.addEventListener('close', (event) => {
      write(`CLOSE code=${event.code} reason=${event.reason}`);
      setStatus('Closed.');
    });
    socket.addEventListener('error', () => {
      write('ERROR');
      setStatus('Error.');
    });
  }

  connectBtn.addEventListener('click', connect);
  sendBtn.addEventListener('click', () => {
    if (!socket || socket.readyState !== WebSocket.OPEN) {
      write('SEND skipped (not connected)');
      return;
    }
    const message = messageInput.value;
    const payload = {
      room: roomInput.value.trim() || 'lobby',
      user: userInput.value.trim() || 'guest',
      text: message,
    };
    write(`SEND ${payload.text}`);
    socket.send(JSON.stringify(payload));
  });
  byeBtn.addEventListener('click', () => {
    if (!socket || socket.readyState !== WebSocket.OPEN) {
      write('SEND skipped (not connected)');
      return;
    }
    write('SEND bye');
    socket.send('bye');
  });
  disconnectBtn.addEventListener('click', () => {
    if (!socket) {
      return;
    }
    write('DISCONNECT');
    socket.close(1000, 'client disconnect');
  });
  clearBtn.addEventListener('click', () => {
    log.value = '';
  });
})();

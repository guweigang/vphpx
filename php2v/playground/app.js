/* -------------------------------------------------------------
 * PHP to V Playground App Logic
 * ------------------------------------------------------------- */

document.addEventListener('DOMContentLoaded', () => {
    // 1. 错误捕获诊断系统 (Diagnostic Error Console Overlay)
    const debugConsoleEl = document.getElementById('debug-console');
    
    function logDiagnosticError(message) {
        if (!debugConsoleEl) return;
        debugConsoleEl.style.display = 'block';
        const errorLine = document.createElement('div');
        errorLine.style.marginBottom = '6px';
        errorLine.style.borderBottom = '1px dashed rgba(255,82,82,0.2)';
        errorLine.style.paddingBottom = '4px';
        errorLine.textContent = `[${new Date().toLocaleTimeString()}] ${message}`;
        debugConsoleEl.appendChild(errorLine);
        debugConsoleEl.scrollTop = debugConsoleEl.scrollHeight;
    }

    window.addEventListener('error', (e) => {
        logDiagnosticError(`Runtime Error: ${e.message} at ${e.filename}:${e.lineno}`);
    });

    window.addEventListener('unhandledrejection', (e) => {
        logDiagnosticError(`Unhandled Rejection: ${e.reason}`);
    });

    // 2. 检查 Playground 核心数据
    if (!window.PLAYGROUND_DATA || !Array.isArray(window.PLAYGROUND_DATA)) {
        logDiagnosticError('Critical Error: window.PLAYGROUND_DATA is missing or empty. Please run "make playground" to generate it.');
        alert('无法加载测试用例数据，请确认 docs/data.js 已正确生成。');
        return;
    }

    const data = window.PLAYGROUND_DATA;

    // 3. DOM 元素缓存 (除会被销毁的代码 code 盒子外)
    const fixturesListEl = document.getElementById('fixtures-list');
    const searchInputEl = document.getElementById('search-input');
    const phpFilenameEl = document.getElementById('php-filename');
    const outputFilenameEl = document.getElementById('output-filename');
    const astTreeContainerEl = document.getElementById('ast-tree-container');
    const btnCollapseAst = document.getElementById('btn-collapse-ast');
    
    // Tab Elements
    const tabBtns = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-content');

    // 4. 应用状态
    let currentFixtureIndex = 0;
    let filteredData = [...data];
    let activeTabId = 'tab-v-code';
    let astDepth = 2; // 默认展开层数
    let isAstFullyExpanded = false;

    // 5. 检查 Prism 和组件加载状态，对非正常加载情况进行报警
    if (!window.Prism) {
        logDiagnosticError('Warning: PrismJS core library was not detected. Syntax highlighting will be disabled.');
    } else {
        if (!Prism.languages.php) {
            logDiagnosticError('Warning: Prism PHP language component not loaded. PHP code will fall back to plain text.');
        }
        if (!Prism.languages.v) {
            logDiagnosticError('Warning: Prism V language component not loaded. V code will fall back to plain text.');
        }
    }

    // 6. 渲染测试用例列表
    function renderFixturesList() {
        fixturesListEl.innerHTML = '';
        
        if (filteredData.length === 0) {
            fixturesListEl.innerHTML = '<div class="no-results" style="padding: 16px; color: var(--text-muted); font-size: 14px; text-align: center;">没有找到匹配的用例</div>';
            return;
        }

        filteredData.forEach((fixture) => {
            const item = document.createElement('div');
            item.className = 'fixture-item';
            
            // 如果这个用例是当前选中的，加上 active
            const originalIndex = data.findIndex(d => d.key === fixture.key);
            if (originalIndex === currentFixtureIndex) {
                item.classList.add('active');
            }

            item.innerHTML = `
                <span class="fixture-title">${fixture.title}</span>
                <span class="fixture-filename">${fixture.filename}</span>
            `;

            item.addEventListener('click', () => {
                const realIndex = data.findIndex(d => d.key === fixture.key);
                selectFixture(realIndex);
            });

            fixturesListEl.appendChild(item);
        });
    }

    // 7. 选中测试用例并更新 UI
    function selectFixture(index) {
        if (index < 0 || index >= data.length) return;
        currentFixtureIndex = index;
        const fixture = data[index];

        // 更新列表中的 Active 状态
        document.querySelectorAll('.fixture-item').forEach((item) => {
            item.classList.remove('active');
        });
        
        const filteredIndex = filteredData.findIndex(d => d.key === fixture.key);
        if (filteredIndex !== -1) {
            const items = fixturesListEl.querySelectorAll('.fixture-item');
            if (items[filteredIndex]) {
                items[filteredIndex].classList.add('active');
            }
        }

        // 渲染 PHP 源码 - 重塑 DOM 避免 Prism 渲染残留及缓存导致的高亮失效
        phpFilenameEl.textContent = fixture.filename;
        const phpPre = document.querySelector('#panel-php-source pre');
        if (phpPre) {
            phpPre.innerHTML = `<code id="php-code-box" class="language-php"></code>`;
            const phpCodeBox = document.getElementById('php-code-box');
            phpCodeBox.textContent = fixture.php;
            
            try {
                if (window.Prism && Prism.languages.php) {
                    Prism.highlightElement(phpCodeBox);
                }
            } catch (e) {
                logDiagnosticError(`Prism PHP highlighting failed: ${e.message}`);
            }
        }

        // 渲染 V 源码 - 重塑 DOM 避免 Prism 渲染残留及缓存导致的高亮失效
        outputFilenameEl.textContent = fixture.key + '.v';
        const vPre = document.querySelector('#tab-v-code pre');
        if (vPre) {
            vPre.innerHTML = `<code id="v-code-box" class="language-v"></code>`;
            const vCodeBox = document.getElementById('v-code-box');
            vCodeBox.textContent = fixture.v;
            
            try {
                if (window.Prism && Prism.languages.v) {
                    Prism.highlightElement(vCodeBox);
                }
            } catch (e) {
                logDiagnosticError(`Prism V highlighting failed: ${e.message}`);
            }
        }

        // 渲染 AST 树
        renderAstTree(fixture.ast);
    }

    // 8. 渲染 AST 树视图
    function renderAstTree(astObj) {
        astTreeContainerEl.innerHTML = '';
        
        if (!astObj || (typeof astObj === 'object' && Object.keys(astObj).length === 0)) {
            astTreeContainerEl.innerHTML = '<div style="color: var(--text-muted); font-style: italic;">AST 为空或解析失败。</div>';
            return;
        }

        try {
            // 使用 JSON Formatter JS 渲染
            const formatter = new JSONFormatter(astObj, astDepth, {
                hoverPreviewEnabled: true,
                hoverPreviewArrayCount: 5,
                hoverPreviewFieldCount: 5,
                animateOpen: true,
                animateClose: true
            });

            const renderedDom = formatter.render();
            renderedDom.classList.add('json-formatter-dark');
            astTreeContainerEl.appendChild(renderedDom);
        } catch (e) {
            logDiagnosticError(`JSON Tree rendering failed: ${e.message}`);
            astTreeContainerEl.textContent = JSON.stringify(astObj, null, 2);
        }
    }

    // 9. Tab 切换逻辑
    tabBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const targetTab = btn.getAttribute('data-tab');
            activeTabId = targetTab;

            tabBtns.forEach(b => b.classList.remove('active'));
            tabContents.forEach(c => c.classList.remove('active'));

            btn.classList.add('active');
            document.getElementById(targetTab).classList.add('active');
        });
    });

    // 10. 搜索过滤逻辑
    searchInputEl.addEventListener('input', (e) => {
        const query = e.target.value.toLowerCase().trim();
        
        filteredData = data.filter(fixture => {
            return fixture.filename.toLowerCase().includes(query) || 
                   fixture.title.toLowerCase().includes(query);
        });

        renderFixturesList();
        
        if (filteredData.length > 0) {
            const isCurrentInFiltered = filteredData.some(d => d.key === data[currentFixtureIndex].key);
            if (!isCurrentInFiltered) {
                const firstFilteredOriginalIndex = data.findIndex(d => d.key === filteredData[0].key);
                selectFixture(firstFilteredOriginalIndex);
            } else {
                selectFixture(currentFixtureIndex);
            }
        }
    });

    // 11. 折叠/展开 AST 控制按钮
    btnCollapseAst.addEventListener('click', () => {
        if (isAstFullyExpanded) {
            astDepth = 2;
            isAstFullyExpanded = false;
            btnCollapseAst.innerHTML = `
                <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M4 12h16M4 6h16M4 18h16" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                展开 AST
            `;
        } else {
            astDepth = 100;
            isAstFullyExpanded = true;
            btnCollapseAst.innerHTML = `
                <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M4 12h16M4 6h16M4 18h16" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                折叠 AST
            `;
        }
        
        if (data[currentFixtureIndex]) {
            renderAstTree(data[currentFixtureIndex].ast);
        }
    });

    // 12. 初始化应用
    renderFixturesList();
    if (data.length > 0) {
        selectFixture(0);
    }
});

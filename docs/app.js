/* -------------------------------------------------------------
 * PHP to V Playground App Logic
 * ------------------------------------------------------------- */

document.addEventListener('DOMContentLoaded', () => {
    // 1. 检查数据是否存在
    if (!window.PLAYGROUND_DATA || !Array.isArray(window.PLAYGROUND_DATA)) {
        console.error('Error: PLAYGROUND_DATA is missing or corrupted.');
        alert('无法加载测试用例数据，请确认 data.js 已正确生成。');
        return;
    }

    const data = window.PLAYGROUND_DATA;

    // 2. DOM 元素缓存
    const fixturesListEl = document.getElementById('fixtures-list');
    const searchInputEl = document.getElementById('search-input');
    const phpFilenameEl = document.getElementById('php-filename');
    const phpCodeBoxEl = document.getElementById('php-code-box');
    const outputFilenameEl = document.getElementById('output-filename');
    const vCodeBoxEl = document.getElementById('v-code-box');
    const astTreeContainerEl = document.getElementById('ast-tree-container');
    const btnCollapseAst = document.getElementById('btn-collapse-ast');
    
    // Tab Elements
    const tabBtns = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-content');

    // 3. 应用状态
    let currentFixtureIndex = 0;
    let filteredData = [...data];
    let activeTabId = 'tab-v-code';
    let astDepth = 2; // 默认展开层数
    let isAstFullyExpanded = false;

    // 4. 渲染测试用例列表
    function renderFixturesList() {
        fixturesListEl.innerHTML = '';
        
        if (filteredData.length === 0) {
            fixturesListEl.innerHTML = '<div class="no-results" style="padding: 16px; color: var(--text-muted); font-size: 14px; text-align: center;">没有找到匹配的用例</div>';
            return;
        }

        filteredData.forEach((fixture, index) => {
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
                // 根据原始数组中的索引来选中
                const realIndex = data.findIndex(d => d.key === fixture.key);
                selectFixture(realIndex);
            });

            fixturesListEl.appendChild(item);
        });
    }

    // 5. 选中测试用例并更新 UI
    function selectFixture(index) {
        if (index < 0 || index >= data.length) return;
        currentFixtureIndex = index;
        const fixture = data[index];

        // 更新列表中的 Active 状态
        document.querySelectorAll('.fixture-item').forEach((item) => {
            item.classList.remove('active');
        });
        
        // 在当前过滤列表里找到对应的 DOM 并加上 active 属性
        const filteredIndex = filteredData.findIndex(d => d.key === fixture.key);
        if (filteredIndex !== -1) {
            const items = fixturesListEl.querySelectorAll('.fixture-item');
            if (items[filteredIndex]) {
                items[filteredIndex].classList.add('active');
            }
        }

        // 渲染 PHP 源码
        phpFilenameEl.textContent = fixture.filename;
        phpCodeBoxEl.textContent = fixture.php;
        try {
            if (window.Prism) {
                Prism.highlightElement(phpCodeBoxEl);
            }
        } catch (e) {
            console.error("Prism PHP highlighting failed:", e);
        }

        // 渲染 V 源码
        outputFilenameEl.textContent = fixture.key + '.v';
        vCodeBoxEl.textContent = fixture.v;
        try {
            if (window.Prism) {
                Prism.highlightElement(vCodeBoxEl);
            }
        } catch (e) {
            console.error("Prism V highlighting failed:", e);
        }

        // 渲染 AST 树
        renderAstTree(fixture.ast);
    }

    // 6. 渲染 AST 树视图
    function renderAstTree(astObj) {
        astTreeContainerEl.innerHTML = '';
        
        if (!astObj || (typeof astObj === 'object' && Object.keys(astObj).length === 0)) {
            astTreeContainerEl.innerHTML = '<div style="color: var(--text-muted); font-style: italic;">AST 为空或解析失败。</div>';
            return;
        }

        // 使用 JSON Formatter JS 渲染
        // JSONFormatter(object, openAtDepth, config)
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
    }

    // 7. Tab 切换逻辑
    tabBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            const targetTab = btn.getAttribute('data-tab');
            activeTabId = targetTab;

            tabBtns.forEach(b => b.classList.remove('active'));
            tabContents.forEach(c => c.classList.remove('active'));

            btn.classList.add('active');
            document.getElementById(targetTab).classList.add('active');
        });
    });

    // 8. 搜索过滤逻辑
    searchInputEl.addEventListener('input', (e) => {
        const query = e.target.value.toLowerCase().trim();
        
        filteredData = data.filter(fixture => {
            return fixture.filename.toLowerCase().includes(query) || 
                   fixture.title.toLowerCase().includes(query);
        });

        renderFixturesList();
        
        // 过滤后，如果当前选中的项目不在过滤结果中，自动选中过滤结果的第一个
        if (filteredData.length > 0) {
            const isCurrentInFiltered = filteredData.some(d => d.key === data[currentFixtureIndex].key);
            if (!isCurrentInFiltered) {
                const firstFilteredOriginalIndex = data.findIndex(d => d.key === filteredData[0].key);
                selectFixture(firstFilteredOriginalIndex);
            } else {
                // 如果在，只需重置当前 active 状态即可（selectFixture 会处理）
                selectFixture(currentFixtureIndex);
            }
        }
    });

    // 9. 折叠/展开 AST 控制按钮
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
            astDepth = 100; // 展开到极深层级
            isAstFullyExpanded = true;
            btnCollapseAst.innerHTML = `
                <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M4 12h16M4 6h16M4 18h16" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                折叠 AST
            `;
        }
        
        // 重新渲染当前选中的 AST Tree
        if (data[currentFixtureIndex]) {
            renderAstTree(data[currentFixtureIndex].ast);
        }
    });

    // 10. 初始化应用
    renderFixturesList();
    if (data.length > 0) {
        selectFixture(0);
    }
});

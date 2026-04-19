const ESCAPE_LOOKUP: Record<string, string> = {
  "&": "&amp;",
  "<": "&lt;",
  ">": "&gt;",
  '"': "&quot;",
  "'": "&#39;"
};

function escapeHtml(value: string): string {
  return value.replace(/[&<>"']/g, (char) => ESCAPE_LOOKUP[char] ?? char);
}

function highlightInlineMarkdown(source: string): string {
  let html = escapeHtml(source);

  html = html.replace(
    /(`[^`]+`)/g,
    '<span class="ks-md-syntax-code">$1</span>'
  );
  html = html.replace(
    /(\[[^\]]+\]\([^)]+\))/g,
    '<span class="ks-md-syntax-link">$1</span>'
  );
  html = html.replace(
    /(\*\*[^*]+\*\*)/g,
    '<span class="ks-md-syntax-strong">$1</span>'
  );
  html = html.replace(
    /(^|[\s(])(\*[^*\n]+\*|_[^_\n]+_)(?=[\s).,!?]|$)/g,
    '$1<span class="ks-md-syntax-em">$2</span>'
  );

  return html;
}

export function renderHighlightedMarkdown(markdown: string): string {
  const lines = markdown.split("\n");
  const rendered: string[] = [];
  let inFence = false;

  for (const line of lines) {
    if (/^\s*```/.test(line)) {
      inFence = !inFence;
      rendered.push(`<span class="ks-md-syntax-fence">${escapeHtml(line)}</span>`);
      continue;
    }

    if (inFence) {
      rendered.push(`<span class="ks-md-syntax-codeblock">${escapeHtml(line)}</span>`);
      continue;
    }

    const headingMatch = line.match(/^(\s{0,3}#{1,6})(\s+)(.*)$/);
    if (headingMatch) {
      const [, marker, gap, rest] = headingMatch;
      rendered.push(
        `<span class="ks-md-syntax-heading-marker">${escapeHtml(marker)}</span>${escapeHtml(gap)}<span class="ks-md-syntax-heading-text">${highlightInlineMarkdown(rest)}</span>`
      );
      continue;
    }

    const quoteMatch = line.match(/^(\s{0,3}(?:>\s?)+)(.*)$/);
    if (quoteMatch) {
      const [, marker, rest] = quoteMatch;
      rendered.push(
        `<span class="ks-md-syntax-quote-marker">${escapeHtml(marker)}</span><span class="ks-md-syntax-quote-text">${highlightInlineMarkdown(rest)}</span>`
      );
      continue;
    }

    const orderedMatch = line.match(/^(\s{0,3}\d+\.\s+)(.*)$/);
    if (orderedMatch) {
      const [, marker, rest] = orderedMatch;
      rendered.push(
        `<span class="ks-md-syntax-list-marker">${escapeHtml(marker)}</span><span class="ks-md-syntax-list-text">${highlightInlineMarkdown(rest)}</span>`
      );
      continue;
    }

    const bulletMatch = line.match(/^(\s{0,3}[-*+]\s+)(.*)$/);
    if (bulletMatch) {
      const [, marker, rest] = bulletMatch;
      rendered.push(
        `<span class="ks-md-syntax-list-marker">${escapeHtml(marker)}</span><span class="ks-md-syntax-list-text">${highlightInlineMarkdown(rest)}</span>`
      );
      continue;
    }

    rendered.push(highlightInlineMarkdown(line));
  }

  return rendered.join("\n");
}

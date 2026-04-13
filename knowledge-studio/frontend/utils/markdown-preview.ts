const escapeHtml = (value: string): string =>
  value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");

const renderInline = (value: string): string => {
  let escaped = escapeHtml(value);
  escaped = escaped.replace(/\*\*(.+?)\*\*/gs, "<strong>$1</strong>");
  escaped = escaped.replace(/`(.+?)`/gs, "<code>$1</code>");
  return escaped;
};

export const renderMarkdownPreview = (markdown: string): string => {
  const source = markdown.replace(/\r\n/g, "\n").replace(/\r/g, "\n").trim();
  if (source === "") {
    return "<p>暂无内容。</p>";
  }

  const html: string[] = [];
  const lines = source.split("\n");
  let paragraph: string[] = [];
  let quote: string[] = [];
  let listType: "ul" | "ol" | null = null;
  let listItems: string[] = [];

  const flushParagraph = () => {
    if (paragraph.length === 0) return;
    html.push(`<p>${renderInline(paragraph.map((line) => line.trim()).join(" "))}</p>`);
    paragraph = [];
  };

  const flushQuote = () => {
    if (quote.length === 0) return;
    html.push(`<blockquote><p>${renderInline(quote.map((line) => line.trim()).join("\n")).replaceAll("\n", "<br>")}</p></blockquote>`);
    quote = [];
  };

  const flushList = () => {
    if (!listType || listItems.length === 0) {
      listType = null;
      listItems = [];
      return;
    }
    html.push(
      `<${listType}>${listItems.map((item) => `<li>${renderInline(item.trim())}</li>`).join("")}</${listType}>`
    );
    listType = null;
    listItems = [];
  };

  for (const line of lines) {
    const trimmed = line.trim();
    if (trimmed === "") {
      flushParagraph();
      flushQuote();
      flushList();
      continue;
    }

    const heading = /^(#{1,3})\s+(.*)$/.exec(trimmed);
    if (heading) {
      flushParagraph();
      flushQuote();
      flushList();
      const level = heading[1].length;
      html.push(`<h${level}>${renderInline(heading[2])}</h${level}>`);
      continue;
    }

    const blockquote = /^>\s?(.*)$/.exec(trimmed);
    if (blockquote) {
      flushParagraph();
      flushList();
      quote.push(blockquote[1]);
      continue;
    }

    const ul = /^[-*]\s+(.*)$/.exec(trimmed);
    if (ul) {
      flushParagraph();
      flushQuote();
      if (listType !== "ul") {
        flushList();
        listType = "ul";
      }
      listItems.push(ul[1]);
      continue;
    }

    const ol = /^\d+\.\s+(.*)$/.exec(trimmed);
    if (ol) {
      flushParagraph();
      flushQuote();
      if (listType !== "ol") {
        flushList();
        listType = "ol";
      }
      listItems.push(ol[1]);
      continue;
    }

    flushList();
    flushQuote();
    paragraph.push(trimmed);
  }

  flushParagraph();
  flushQuote();
  flushList();

  return html.join("");
};

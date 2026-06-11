import { Controller } from "@hotwired/stimulus"

// Markdown body editor with a toolbar and a debounced server-rendered live
// preview. The preview is fetched from the admin posts#preview endpoint so the
// HTML matches exactly what readers see (same renderer, same syntax theme).
export default class extends Controller {
  static targets = ["textarea", "preview"]
  static values = { previewUrl: String }

  connect() {
    this.refresh()
  }

  // --- Toolbar actions -----------------------------------------------------

  bold() {
    this.wrap("**", "**", "bold text")
  }

  italic() {
    this.wrap("_", "_", "italic text")
  }

  heading() {
    this.prefixLine("## ", "Heading")
  }

  code() {
    this.wrap("`", "`", "code")
  }

  codeFence() {
    this.wrap("```\n", "\n```", "code")
  }

  link() {
    this.wrap("[", "](https://)", "link text")
  }

  unorderedList() {
    this.prefixLine("- ", "List item")
  }

  // --- Editing primitives --------------------------------------------------

  // Wrap the current selection (or a placeholder) with before/after strings.
  wrap(before, after, placeholder) {
    const ta = this.textareaTarget
    const { selectionStart: start, selectionEnd: end } = ta
    const selected = ta.value.slice(start, end) || placeholder
    const replacement = `${before}${selected}${after}`

    ta.setRangeText(replacement, start, end, "end")
    ta.focus()
    this.requestPreview()
  }

  // Prefix the line containing the caret with the given marker.
  prefixLine(marker, placeholder) {
    const ta = this.textareaTarget
    const { selectionStart: start, selectionEnd: end } = ta
    const lineStart = ta.value.lastIndexOf("\n", start - 1) + 1
    const hadSelection = end > start
    const insert = `${marker}${hadSelection ? "" : placeholder}`

    ta.setRangeText(insert, lineStart, lineStart, "end")
    if (!hadSelection) {
      ta.setSelectionRange(lineStart + marker.length, lineStart + insert.length)
    }
    ta.focus()
    this.requestPreview()
  }

  // --- Live preview --------------------------------------------------------

  // Debounced handler wired to the textarea's input event.
  refresh() {
    clearTimeout(this.debounce)
    this.debounce = setTimeout(() => this.requestPreview(), 300)
  }

  async requestPreview() {
    if (!this.hasPreviewTarget || !this.previewUrlValue) return

    try {
      const response = await fetch(this.previewUrlValue, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "text/html",
          "X-CSRF-Token": this.csrfToken
        },
        body: JSON.stringify({ body: this.textareaTarget.value })
      })
      this.previewTarget.innerHTML = await response.text()
    } catch (error) {
      // Network hiccup — leave the last good preview in place.
    }
  }

  get csrfToken() {
    return document.querySelector('meta[name="csrf-token"]')?.content
  }
}

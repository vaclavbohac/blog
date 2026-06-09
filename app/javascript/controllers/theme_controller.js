import { Controller } from "@hotwired/stimulus"

// Toggles class-based dark mode on <html> and persists the choice.
// The no-flash script in the application layout applies it on first paint.
export default class extends Controller {
  toggle() {
    const isDark = document.documentElement.classList.toggle("dark")
    try {
      localStorage.setItem("theme", isDark ? "dark" : "light")
    } catch (e) {}
  }
}

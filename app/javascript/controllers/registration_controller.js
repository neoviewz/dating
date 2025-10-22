import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="registration"
export default class extends Controller {
  static targets = ["username", "email", "usernameFeedback", "emailFeedback", "password", "toggle"]
  static values = { usernameUrl: String, emailUrl: String }

  connect() {
    this.debounceTimers = {}
  }

  validateUsername() {
    this._debounce('username', async () => {
      if (!this.hasUsernameTarget || !this.hasUsernameFeedbackTarget) return
      const value = this.usernameTarget.value.trim()
      if (!value) {
        this.usernameFeedbackTarget.textContent = ''
        return
      }
      // determine url: prefer Stimulus value, fallback to data attribute on element, else default
      const urlBase = this.usernameUrlValue || this.element.dataset.registrationUsernameUrlValue || '/validate/username'
      const url = `${urlBase}?value=${encodeURIComponent(value)}`
      console.debug('[registration] validateUsername ->', value, 'url=', url)
      try {
        const res = await fetch(url, { headers: { 'Accept': 'application/json' } })
        if (!res.ok) throw new Error('Network response was not ok')
        const json = await res.json()
        this._setFeedback(this.usernameFeedbackTarget, json.available)
      } catch (err) {
        this.usernameFeedbackTarget.textContent = 'Erreur de validation'
        this.usernameFeedbackTarget.className = 'text-yellow-600 text-sm'
      }
    })
  }

  validateEmail() {
    this._debounce('email', async () => {
      if (!this.hasEmailTarget || !this.hasEmailFeedbackTarget) return
      const value = this.emailTarget.value.trim()
      if (!value) {
        this.emailFeedbackTarget.textContent = ''
        return
      }
      const urlBase = this.emailUrlValue || this.element.dataset.registrationEmailUrlValue || '/validate/email'
      const url = `${urlBase}?value=${encodeURIComponent(value)}`
      console.debug('[registration] validateEmail ->', value, 'url=', url)
      try {
        const res = await fetch(url, { headers: { 'Accept': 'application/json' } })
        if (!res.ok) throw new Error('Network response was not ok')
        const json = await res.json()
        this._setFeedback(this.emailFeedbackTarget, json.available)
      } catch (err) {
        this.emailFeedbackTarget.textContent = 'Erreur de validation'
        this.emailFeedbackTarget.className = 'text-yellow-600 text-sm'
      }
    })
  }

  togglePassword() {
    const input = this.passwordTarget
    input.type = input.type === 'password' ? 'text' : 'password'
    this.toggleTarget.classList.toggle('opacity-50')
  }

  _setFeedback(el, available) {
    el.textContent = available ? 'Disponible' : 'Déjà pris'
    el.className = available ? 'text-green-600 text-sm' : 'text-red-600 text-sm'
  }

  _debounce(key, fn, wait = 300) {
    clearTimeout(this.debounceTimers[key])
    this.debounceTimers[key] = setTimeout(fn, wait)
  }
}

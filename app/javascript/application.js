import { Application } from "@hotwired/stimulus"
import RegistrationController from "./controllers/registration_controller"

const application = Application.start()
application.register("registration", RegistrationController)

export { application }

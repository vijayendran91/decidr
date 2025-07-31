import "bootstrap"
import "bootstrap/dist/css/bootstrap.min.css"
// Entry point for the build script in your package.json
import { sayHello } from "./hello"
import "./sort_controller"
sayHello("TypeScript + Rails 8")
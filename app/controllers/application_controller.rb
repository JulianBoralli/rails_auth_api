class ApplicationController < ActionController::API
  include JamViolation
  include Response
  include ExceptionHandler
  include Authentication
end

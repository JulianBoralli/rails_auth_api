class ApplicationController < ActionController::API
  include JamViolation
  include Response
  include ExceptionHandler
end

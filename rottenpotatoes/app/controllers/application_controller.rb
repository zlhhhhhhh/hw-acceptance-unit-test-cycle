class ApplicationController < ActionController::Base
  protect_from_forgery
  add_flash_types :info,:warning
end

class PagesController < ApplicationController
  skip_before_action :require_login

  def usage_instructions; end
end

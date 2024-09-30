# frozen_string_literal: true

# FlightsControllerは、フライト情報を表示するためのコントローラーです。

class FlightsController < ApplicationController
  before_action :require_login

  def index; end
end

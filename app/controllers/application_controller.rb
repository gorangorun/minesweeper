# frozen_string_literal: true

class ApplicationController < ActionController::Base
  around_action :render_http_error

  def render_http_error
    yield
  rescue Pagy::OverflowError
    render404
  end

  def render404
    expires_now
    render file: 'public/404.html', status: :not_found, layout: false
  end
end

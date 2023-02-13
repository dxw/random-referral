class ApplicationController < ActionController::Base

  private def no_method_error
    render "pages/page_not_found", status: :not_found
  end
end

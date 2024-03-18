class ApplicationController < ActionController::Base
  before_action :authenticate_user!
   #protect_from_forgery with::exception
  # def not_found_method
  #   render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  # end
  private

  def render_turbo_stream(action, target, partial = nil, locals = {})
    respond_to do |format|
      format.turbo_stream do 
        case action
        when 'replace'
          render turbo_stream: turbo_stream.replace(target, partial: partial, locals: locals)
        when 'append'
          render turbo_stream: turbo_stream.append(target, partial: partial, locals: locals)
        when 'remove'
          render turbo_stream: turbo_stream.remove(target)
        end
      end
    end
  end

end

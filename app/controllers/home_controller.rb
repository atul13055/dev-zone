class HomeController < ApplicationController
  def index
    # Fetch users with eager loading
    @users = Rails.cache.fetch('users_index_page', expires_in: 1.hour) do
      @q = User.includes(:work_experiences).ransack(params[:q])
      @q.result.order(:created_at)
    end
  end
end

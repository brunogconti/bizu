class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[index show]

  def index
  end

  def show
  end
end

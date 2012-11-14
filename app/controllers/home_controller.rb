class HomeController < ApplicationController
  def index
    @politicians = Politician.all
  end
end
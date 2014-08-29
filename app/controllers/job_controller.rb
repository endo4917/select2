class JobController < ApplicationController
  respond_to :html, :json
  def index
    @people = Kensa.all
    @kensas = @people
    respond_with @kensas
  end
  def selpar
  end
end

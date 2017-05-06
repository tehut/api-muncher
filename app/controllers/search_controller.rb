
class SearchController < ApplicationController
  require 'edamam'
  def index
   @search =Edamam.new
   @searches = @search.all(params[:query], params[:from])
   @search_object = @search.hit_array
  end

  def show
  @search = Edamam.new.find(params[:uri], params[:from])

  end


end

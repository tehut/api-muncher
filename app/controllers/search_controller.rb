
class SearchController < ApplicationController
  require 'edamam'
  def index
   @search =Edamam.new
   @searches = @search.lookup(params[:query])
   @search_object = @search.hit_array
  end

  def show
  @search = Edamam.new.single_lookup(params[:uri], params[:from])

  end


end

require 'httparty'



class Edamam
  BASE_URL = 'https://api.edamam.com/'

  class EdamamException <  StandardError
  end

  attr_reader :recipe_uri, :from, :hit_array

  def initialize(uri = "", from = 0)
    @hit_array = []
    @recipe_uri = uri
    @from = from
  end



  def lookup(query)
    url = "#{BASE_URL}search?"
    query_params = {
      "app_key" => ENV["API_KEY"],
      "app_id"=>  ENV["API_ID"],
      "q" => query
    }

    response = HTTParty.get(url, query:query_params).parsed_response
    @hits = self.clean(response)
    @from = response["from"]

    if response["count"] > 0
      puts "everythings awesome"
    elsif response["count"] == 0
      puts "Your search returned no results"
    else
      puts "Uhoh, there was an error! #{response}"
      raise EdamamException.new(response["error"])
    end



    @hits.each do |number, recipe|
      @hit_array << (number = Hash.new(

      "r" => recipe["uri"],
      "from" => self.from
        )
      )


    end

  end

  def clean(response)
    if response.length > 1
    hash = {}

    response["hits"].each_with_index do |item, i|
      hash[i+1] = item["recipe"]
    end
    return hash

  else
    flash[:message] = "Your search could not be executed"
    return flash[:message]
  end

  def single_lookup(r,from)

    url = "#{BASE_URL}search?"
    query_params = {
      "r" => r,
      "from" => from
    }
    response = HTTParty.get(url, query:query_params).parsed_response
  return response
  end



end

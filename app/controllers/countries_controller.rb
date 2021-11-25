class CountriesController < ApplicationController
  def fetch_cities
    @cities = City.by_country(params[:country_id])
    render partial: 'cities', object: @cities, layout: false
  end
end
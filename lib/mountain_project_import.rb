require 'http'
require 'byebug'

class MountainProjectImport

  TICKS_BASE_URL = 'https://www.mountainproject.com/data/get-ticks'
  ROUTES_BASE_URL = 'https://www.mountainproject.com/data/get-routes'

  attr_accessor :ticks_url, :routes_url, :user_id, :api_key

  def initialize(user_id, user_mp_email, api_key)
    # TODO email may or not match our users and their MP account
    # @user_mp_email = user_mp_email
    # TODO this is unique and sensitive key per user.
    @api_key = api_key
    @ticks_url = TICKS_BASE_URL + "?email=#{user_mp_email}" + "&key=#{api_key}"
  end

  def pull_data
    json = query_for_ticks
    extract_data_from_ticks(json)
  end

  def query_for_ticks
    resp = HTTP.get(ticks_url)
    parse_response(resp)
  end

  def extract_data_from_ticks(json)
    # TODO add some validations to this payload
    # Where can particular stats be saved?
    mp_hardest = json['hardest']
    mp_average = json['average']
    mp_ticks = json['ticks']

    ids = []
    # iterate through ticks to extract ids
    mp_ticks.each do |tick|
      break if ids.count > 100 # TODO API limit to perhaps consider
      ids.push(tick['routeId'])
    end

    query_for_route_grades(ids)
  end

  def query_for_route_grades(route_ids_array)
    # remove array characters so we have a query parameter
    cleaned_ids = route_ids_array.to_s.delete("[] ")
    final_routes_url = ROUTES_BASE_URL + "?routeIds=#{cleaned_ids}" + "&key=#{api_key}"

    resp = HTTP.get(final_routes_url)
    json = parse_response(resp)
    extract_data_from_routes(json)
  end

  def extract_data_from_routes(json)
    json['routes'].each do |route|
      route_grade = route['rating'] # 5.6
      route_type = route['type'] # Sport
      
      # TODO MOCK THIS OUT
      grade = Grade.where(string_value: route_grade).first
      Climb.create(user_id: user_id, grade: grade)
      # could do a climb
      # to set performance, we need data from the first query to come together
    end
  end

  # @param Http::Response
  # @return JSON
  def parse_response(resp)
    # TODO handle non-200 response codes
    JSON.parse(resp.body.to_s)
  end
end 
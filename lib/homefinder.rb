class Homefinder
  include HTTParty

  base_uri 'http://services.homefinder.com/listingServices'

  API_KEY = 'csufcr586cjtpsjzzjbr5765'

  def self.search(terms = nil)
    terms ||= {}
    terms.merge!(apikey: API_KEY)

    response = get("/search", query: terms)

    # detect bad user credentials or network connectivity problems
    unless response.success?
      raise response.response
    end

    # Homefinder returns 200 http status codes even for empty results or
    # bad requests, so make sure we have a real 200
    status_code = response["status"]["code"]

    unless status_code == 200
      raise "Bad response from Homefinder #{status_code}"
    end

    data = response["data"]

    unless data.present?
      raise "No data from Homefinder"
    end

    [ data["listings"], data["meta"] ]
  end

end

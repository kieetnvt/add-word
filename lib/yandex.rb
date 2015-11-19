module Yandex
  class API
    attr_reader :api_key
    attr_reader :api_url

    def initialize
      @api_key = ENV["yandex_key_production"]
      @api_url = ENV["yandex_url"]
    end

    # GET https://translate.yandex.net/api/v1.5/tr.json/getLangs?key=APIkey&ui=uk
    def get_langs
      request_url = @api_url + "getLangs?key=" + @api_key + "&ui=uk"
      response = Net::HTTP.get(URI(request_url))
      JSON.parse(response)
    end

    # GET https://translate.yandex.net/api/v1.5/tr/detect?key=APIkey&text=Hello+world
    def detect_langs(query_strings)
      request_url = @api_url + "detect?key=" + @api_key + "&text=" + query_strings
      response = Net::HTTP.get(URI(request_url))
      JSON.parse(response)
    end

    # GET https://translate.yandex.net/api/v1.5/tr.json/translate?key=APIkey&lang=en-ru&text=To+be,+or+not+to+be%3F&text=That+is+the+question.
    def translate_langs(query_strings, language = "en-vi")
      request_url = @api_url + "translate?key=" + @api_key + "&lang=" + language + "&text=" + query_strings
      response = Net::HTTP.get(URI(request_url))
      JSON.parse(response)
    end
  end
end
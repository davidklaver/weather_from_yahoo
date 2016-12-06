class ForecastsController < ApplicationController
	def index
		if params["city"]
			@weather = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{params["city"]}%2C%20#{params["state"]}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body["query"]["results"]["channel"]
		else
			@weather = Unirest.get('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22monsey%2C%20ny%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys').body["query"]["results"]["channel"]
		end
		@city = @weather["location"]["city"]
		@state = @weather["location"]["region"]
		@current_temp = @weather["item"]["condition"]["temp"]
	end
end

require 'httparty'

namespace :import_earthquake_data do
    desc "Import earthquake data from USGS API for the past 30 days."
    task :earthquake_data => :environment do
        apiUrl = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
        response = HTTParty.get(apiUrl)
    
        # If the response is successful, parse the JSON data
        if response.code == 200
            # data contains the recived JSON data from the API
            data = JSON.parse(response.body)

            # features contains the array of earthquake data
            features = data['features']
    
            features.each do |feature|
            
                # Extract the properties and geometry from the feature object
                properties = feature['properties']
                geometry = feature['geometry']
    
                # Validate the data before creating a new Feature instance in the database
                # Skip the data if the external_id already exists in the database to avoid duplicates
                next if feature['id'].nil? || Datum.exists?(external_id: feature['id'])
                next if properties['title'].nil? && properties['url'].nil? && properties['place'].nil? && properties['magType'].nil?
                next if properties['mag'] < -1.0 || properties['mag'] > 10.0
                next if geometry['coordinates'][1] < -90.0 || geometry['coordinates'][1] > 90.0
                next if geometry['coordinates'][0] < -180.0 || geometry['coordinates'][0] > 180.0
        
                # Create a new Datum instance with the parsed data from the API only if the data passes validation
                Datum.create(
                    external_id: feature['id'],
                    magnitude: properties['mag'],
                    place: properties['place'],
                    time: properties['time'],
                    tsunami: properties['tsunami'],
                    mag_type: properties['magType'],
                    title: properties['title'],
                    longitude: geometry['coordinates'][0],
                    latitude: geometry['coordinates'][1],
                    url: properties['url']
                )
                end
    
            puts "Data imported successfully!"
        else
            puts "Failed to fetch earthquake data from the API."
        end
    end
end

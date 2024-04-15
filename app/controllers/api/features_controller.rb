class Api::FeaturesController < ApplicationController
    
    def index
        # Fetch all the data from the database
        features = Datum.all
    
        # Paginate the data with a default of 1000 records per page
        per_page = params[:per_page].to_i
        per_page = 1000 if per_page <= 0 || per_page > 1000
        features = features.page(params[:page]).per(per_page)
    
        # Return the paginated data as JSON
        render json: {
            data: features.map { |datum| serialize_feature(datum) },
            pagination: {
                current_page: features.current_page,
                total: features.total_count,
                per_page: per_page
            }
        }
    end
    
    private
    
    # Serialize the data to JSON format for the API response
    def serialize_feature(datum)
        {
            id: datum.id,
            type: "feature",
            attributes: {
                external_id: datum.external_id,
                magnitude: datum.magnitude,
                place: datum.place,
                time: datum.time,
                tsunami: datum.tsunami,
                mag_type: datum.mag_type,
                title: datum.title,
                coordinates: {
                    longitude: datum.longitude,
                    latitude: datum.latitude
                }
            },
            links: {
                external_url: datum.url
            }
        }
    end
end

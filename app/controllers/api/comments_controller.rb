# Description: This controller is responsible for handling the API requests for the comments endpoint.

class Api::CommentsController < ApplicationController
    def create
        feature = Datum.find(params[:external_id])
    
        # Validates boby is not empty
        if params[:body].blank?
            render json: { error: "El cuerpo del comentario no puede estar vacío" }, status: :unprocessable_entity
            return
        end
    
        # Create a new comment for the feature
        comment = feature.comments.build(body: params[:body])
    
        if comment.save
            render json: comment, status: :created
        else
            render json: { error: "No se pudo crear el comentario" }, status: :unprocessable_entity
        end
    end
end
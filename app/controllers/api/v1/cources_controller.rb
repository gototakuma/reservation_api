module Api
  module V1
    class  CourcesController < ApplicationController

      def index
      	cources = Cource.all
      	
      	render :json => cources
      end

    end
  end
end
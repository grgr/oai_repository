module OaiRepository
  class ServicesController < ApplicationController
    require 'oai_provider'

    def show

      options = oai_params.delete_if { |k,v| %w{controller action}.include?(k) }
      response = get_provider.process_request(options.to_h)
      render :xml => response
      
    end

    def get_provider
      @provider ||= OAIProvider::provider.new
    end

    private

    def oai_params        
      params.permit(:verb, :identifier, :metadataPrefix, :set, :from, :until, :resumptionToken)        
    end        

  end
end

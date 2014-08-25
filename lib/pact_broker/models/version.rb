require 'pact_broker/db'
require 'pact_broker/models/order_versions'

module PactBroker

  module Models

    class Version < Sequel::Model

      set_primary_key :id
      one_to_many :pacts
      associate(:many_to_one, :pacticipant, :class => "PactBroker::Models::Pacticipant", :key => :pacticipant_id, :primary_key => :id)
      one_to_many :tags, :reciprocal => :version

      def after_create
        OrderVersions.(self.pacticipant_id)
      end

      def to_s
        "Version: number=#{number}, pacticipant=#{pacticipant_id}"
      end
    end

    Version.plugin :timestamps, :update_on_create=>true
  end
end
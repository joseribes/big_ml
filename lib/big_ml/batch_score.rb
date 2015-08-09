require 'big_ml/base'

module BigML
  class BatchScore < Base
    BATCH_SCORE_PROPERTIES = [
      :all_fields, :anomaly, :anomaly_status, :anomaly_type, :category, :code,
      :created, :credits, :dataset, :dataset_status, :description, :dev,
      :fields_map, :header, :locale, :name, :output_dateset,
      :output_dataset_resource, :output_dataset_status, :output_fields,
      :private, :project, :resource, :rows, :score_name, :separator, :shared,
      :size, :status, :subscription, :tags, :type, :updated
    ]

    attr_reader *BATCH_SCORE_PROPERTIES

    class << self
      def create(anomaly, dataset, options = {})
        arguments = { dataset: dataset }
        if anomaly.start_with? 'anomaly'
          arguments[:anomaly] = anomaly
        else
          raise ArgumentError, "Expected anomaly, got #{anomaly}"
        end
        response = client.post("/#{resource_name}", {}, arguments.merge(options))
        self.new(response) if response.success?
      end

      def download(id)
        response = client.get("/#{resource_name}/#{id}/download")
        response.body if response.success?
      end
    end

    def download
      self.class.download(id)
    end

  end
end

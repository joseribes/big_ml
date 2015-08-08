require 'big_ml/base'

module BigML
  class BatchCentroid < Base
    BATCH_CENTROID_PROPERTIES = [
      :category, :code, :created, :credits, :dataset, :dataset_status,
      :description, :fields, :dataset, :cluster, :model_status, :name,
      :objective_fields, :prediction, :prediction_path, :private, :resource,
      :source, :source_status, :status, :tags, :updated
    ]

    attr_reader *BATCH_CENTROID_PROPERTIES

    class << self
      def create(cluster, dataset, options = {})
        arguments = { dataset: dataset }
        if cluster.start_with? 'cluster'
          arguments[:cluster] = cluster
        else
          raise ArgumentError, "Expected cluster, got #{cluster}"
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

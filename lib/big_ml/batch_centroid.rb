require 'big_ml/base'

module BigML
  class BatchCentroid < Base
    BATCH_CENTROID_PROPERTIES = [
      :all_fields, :category, :centroid_name, :code, :cluster, :cluster_status,
      :created, :credits, :dataset, :dataset_status, :description, :dev,
      :distance, :distance_name, :fields_map, :header, :locale, :name, 
      :output_dateset, :output_dataset_resource, :output_dataset_status,
      :output_fields, :private, :project, :resource, :rows, :separator,
      :shared, :size, :status, :subscription, :tags, :type, :updated
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

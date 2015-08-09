require 'big_ml/base'

module BigML
  class BatchPrediction < Base
    BATCH_PREDICTION_PROPERTIES = [
      :all_fields, :category, :code, :combiner, :confidence, :confidence_name,
      :confidence_threshold, :created, :credits, :dataset, :dataset_status,
      :description, :dev, :ensemble, :fields_map, :header, :locale,
      :missing_stratgy, :model, :model_status, :model_type, :name,
      :negative_class, :negative_class_confidence, :number_of_models,
      :objective_field, :output_dataset, :output_dataset_resource,
      :output_dataset_status, :output_fields, :positive_class,
      :prediction_name, :private, :project, :resource, :rows, :separator,
      :shared, :size, :status, :subscription, :tags, :threshold, :type,
      :updated
    ]

    attr_reader *BATCH_PREDICTION_PROPERTIES

    class << self
      def create(model_or_ensemble, dataset, options = {})
        arguments = { dataset: dataset }
        if model_or_ensemble.start_with? 'model'
          arguments[:model] = model_or_ensemble
        elsif model_or_ensemble.start_with? 'ensemble'
          arguments[:ensemble] = model_or_ensemble
        else
          raise ArgumentError, "Expected model or ensemble, got #{model_or_ensemble}"
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

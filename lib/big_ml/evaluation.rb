require 'big_ml/base'

module BigML
  class Evaluation < Base
    EVALUATION_PROPERTIES = [
      :category, :code, :combiner, :confidence_threshold, :created, :credits,
      :dataset, :dataset_status, :description, :dev, :ensemble, :fields_map,
      :locale, :max_rows, :missing_strategy, :model, :model_status,
      :model_type, :name, :negative_class, :number_of_models, :ordering,
      :out_of_bag, :positive_class, :private, :project, :range, :replacement,
      :resource, :result, :rows, :sample_rate, :shared, :shared_hash,
      :sharing_key, :size, :status, :subscription, :tags, :threshold, :type,
      :updated
    ]

    attr_reader *EVALUATION_PROPERTIES

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
    end
  end
end

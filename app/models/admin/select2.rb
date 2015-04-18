module Admin::Select2
  module_function

  def query scope, attribute, q
    q.present? ? scope.where("#{attribute} ILIKE ?", "%#{q}%") : scope
  end
end
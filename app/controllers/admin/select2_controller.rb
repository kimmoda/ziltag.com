class Admin::Select2Controller < ApplicationController
  def query
    querier = Admin::Select2Querier.new(params[:plural])
    scope = querier.query(params[:q]).page(params[:page])
    instance_variable_set "@#{querier.plural}", scope
    render querier.plural << '.json'
  end

end

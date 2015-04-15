class Select2Input < SimpleForm::Inputs::CollectionSelectInput
  def input(wrapper_options = nil)
    label_method, value_method = detect_collection_methods
    input_html_options.deep_merge! data: {select2_resource: @reflection.table_name}
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    @builder.collection_select(
      attribute_name, Array(object.send(@reflection.name)), value_method, label_method,
      input_options, merged_input_options
    )
  end
end

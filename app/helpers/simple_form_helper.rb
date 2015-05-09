module SimpleFormHelper
  def vertical_form resource, options = {}, &block
    options[:wrapper] = :vertical_form
    options[:html].reverse_merge! class: nil
    options[:wrapper_mappings] = {
      check_boxes: :vertical_radio_and_checkboxes,
      radio_buttons: :vertical_radio_and_checkboxes,
      file: :vertical_file_input,
      boolean: :vertical_boolean
    }
    simple_form_for resource, options, &block
  end
end

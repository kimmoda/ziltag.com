class ImagePreviewInput < SimpleForm::Inputs::FileInput
  def input wrapper_options = nil
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    out = ActiveSupport::SafeBuffer.new
    if object.send("#{attribute_name}?")
      out << template.image_tag(object.send(attribute_name).thumb.url)
      unless required_field?
        out << template.tag(:br)
        out << @builder.check_box("remove_#{attribute_name}") << ' ' << object.class.human_attribute_name("remove_#{attribute_name}")
      end
      out << @builder.hidden_field("#{attribute_name}_cache")
    end
    out << @builder.file_field(attribute_name, merged_input_options)
  end
end
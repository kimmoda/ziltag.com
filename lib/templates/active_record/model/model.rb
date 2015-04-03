<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
  # scopes

  # constants

  # attributes
<% if attributes.any?(&:password_digest?) -%>
  has_secure_password
<% end -%>

  # associations
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %><%= ', required: true' if attribute.required? %>
<% end -%>

  # validations

  # callbacks

  # other

end
<% end -%>

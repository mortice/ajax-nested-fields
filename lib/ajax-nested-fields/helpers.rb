module AjaxNestedFields
  module Helpers
    def link_to_remove_fields(name, f, container)
      f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this, '#{container}')")
    end

    def link_to_new_child(f, association, text=nil, html_options={})
      link_text = text || "Add #{association}"
      object = f.object.class.reflect_on_association(association.to_sym).klass.new

      fields = f.fields_for(association, object, :child_index => "new_#{association.singularize}") do |builder|
        render("#{association.singularize}_fields", :f => builder)
      end

      link_to_function link_text, raw("add_child_field('#{association}', 'new_#{association.singularize}', \"#{escape_javascript(fields)}\")"), html_options
    end
  end
end

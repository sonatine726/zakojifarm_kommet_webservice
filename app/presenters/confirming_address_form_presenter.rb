class ConfirmingAddressFormPresenter < ConfirmingFormPresenter
  def postal_code_block(name, label_text, options)
    markup(:div, class: options[:class_top_div]) do |m|
      m << decorated_label(name, label_text, options)
      m.div(object.send(name), class: 'field-value')
      m << hidden_field(name, options)
    end
  end
end

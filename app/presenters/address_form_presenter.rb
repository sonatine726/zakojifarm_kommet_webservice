class AddressFormPresenter < FormPresenter
  def postal_code_block(name, label_text, options)
    markup(:div, class: options[:class_top_div]) do |m|
      m << decorated_label(name, label_text, options)
      m.div(class: options[:class_between_label_and_text]) do |m|
        m << text_field(name, class: options[:class_textf], size: options[:textf_size])
        markup(:small, class: 'notes') do |m|
          m.span '(7桁の半角数字で入力してください。)', class: 'mark'
        end
      end
      m << error_messages_for(name)
    end
  end
end

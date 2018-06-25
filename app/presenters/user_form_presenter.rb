class UserFormPresenter < FormPresenter
  def password_field_block(name, label_text, **options)
    if object.new_record?
      super(name, label_text, options)
    else
      markup(:div, class: options[:class_top_div]) do |m|
        m << decorated_label(name, label_text, options.merge(required: false))
        m.div(class: options[:class_between_label_and_password]) do |m|
          m << password_field(name, class: options[:class_passwordf], size: options[:passwordf_size], disabled: true)
        end
        m.button('変更する', type: 'button', id: 'enable-password-field', class: 'mt-3')
        m.button('変更しない', type: 'button', id: 'disable-password-field', style: 'display: none', class: 'mt-3')
        m << error_messages_for(name)
      end
    end
  end

  def full_name_block(name1, name2, label_text, **options)
    markup(:div, class: options[:class_top_div]) do |m|
      m << decorated_label(name1, label_text, options)
      m.div(class: options[:class_between_label_and_text]) do |m|
        m << text_field(name1, class: options[:class_textf_1], size: options[:textf_size])
        m << text_field(name2, class: options[:class_textf_2], size: options[:textf_size])
      end
      m << error_messages_for(name1)
      m << error_messages_for(name2)
    end
  end
end

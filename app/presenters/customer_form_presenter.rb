class CustomerFormPresenter < UserFormPresenter
  def birthday_field_block(name, label_text, options = {})
    markup(:div, class: options[:class_top_div]) do |m|
      m << decorated_label(name, label_text, options)
      m.div(class: options[:class_between_label_and_text]) do |m|
        if options[:class_textf].kind_of?(String)
          classes = options[:class_textf].strip.split + ['birthday-picker']
          options[:class_textf] = classes.uniq.join(' ')
        else
          options[:class_textf] = 'birthday-picker'
        end
        m << text_field(name, class: options[:class_textf], size: options[:textf_size])
      end
      m << error_messages_for(name)
    end
  end

  def gender_field_block
    markup(:div, class: options[:class_top_div]) do |m|
      m.div(class: options[:class_before_checkbox]) do |m|
        m << decorated_label(:gender, '性別')
        m.div(class: options[:class_between_label_and_text]) do |m|
          m.radio_button(:gender, 'male')
          m << label(:gender_male, '男性')
          m.radio_button(:gender, 'femail')
          m << label(:gender_femail, '女性')
        end
      end
    end
  end
end

class ProgramFormPresenter < FormPresenter
  def description
    markup(:div, class: 'form-group') do |m|
      m << decorated_label(:description, '詳細', required: true)
      m << text_area(:description, rows: 6, style: 'width: 454px', class: 'form-control')
      m.span '(800文字以内)', class: 'instruction'
      m << error_messages_for(:description)
    end
  end

  def datetime_field_block(name, label_text, **options)
    instruction = options.delete(:instruction)
    if object.errors.include?("#{name}_time".to_sym)
      html_class = "#{options[:class_top_div]} with-errors"
    else
      html_class = options[:class_top_div]
    end

    markup(:div, class: html_class) do |m|
      m << decorated_label("#{name}_datename", label_text, options)
      m.div(class: options[:class_between_label_and_text]) do |m|
        if options[:class].kind_of?(String)
          classes = options[:class].strip.split + ['datepicker']
          options[:class] = classes.uniq.join(' ')
        else
          options[:class] = 'datepicker'
        end

        m << text_field("#{name}_date", class: "#{options[:class_textf]} datepicker", size: options[:textf_size], required: options[:required] ? true : false)
        m.span class: 'mx-1'
        m << form_builder.select("#{name}_hour", ('00'..'23').to_a)
        m.span class: 'mx-1'
        m << ':'
        m.span class: 'mx-1'
        m << form_builder.select("#{name}_minute", ('00'..'59').to_a, class: 'mx-1')

        m.span "#{instruction}", class: 'instruction' if instruction
      end
      m << error_messages_for("#{name}_time".to_sym)
      m << error_messages_for("#{name}_date".to_sym)
    end
  end
end

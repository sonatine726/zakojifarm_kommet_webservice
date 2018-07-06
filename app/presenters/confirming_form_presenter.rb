class ConfirmingFormPresenter
  include HtmlBuilder

  attr_reader :form_builder, :view_context
  delegate :label, :hidden_field, :object, to: :form_builder

  def initialize(form_builder, view_context)
    @form_builder = form_builder
    @view_context = view_context
  end

  def text_field_block(name, label_text, **options)
    markup(:div, class: options[:class_top_div]) do |m|
      m << decorated_label(name, label_text, options)
      m.div(class: options[:class_between_label_and_text]) do |m|
        m << text_field(name, class: options[:class_textf], size: options[:textf_size],
          disabled: options[:disabled])
        if options[:maxlength]
          m.span "(#{options[:maxlength]}文字以内)", class: 'instruction'
        end
      end
      m << error_messages_for(name)
    end
  end

  def number_field_block(name, label_text, **options)
    markup(:div, class: options[:class_top_div]) do |m|
      m << decorated_label(name, label_text, options)
      m.div(class: options[:class_between_label_and_text]) do |m|
        m << form_builder.number_field(name, class: options[:class_textf], size: options[:textf_size], max: options[:max])
        if options[:max]
          max = view_context.number_with_delimiter(options[:max].to_i)
          m.span "(最大値:#{max})", class: 'instruction'
        end
      end
      m << error_messages_for(name)
    end
  end

  def password_field_block(name, label_text, **options)
    markup(:div, class: options[:class_top_div]) do |m|
      m << decorated_label(name, label_text, options)
      m.div(class: options[:class_between_label_and_password]) do |m|
        m << password_field(name, class: options[:class_passwordf], size: options[:passwordf_size], required: options[:required] ? true : false)
      end
      m << error_messages_for(name)
    end
  end

  def date_field_block(name, label_text, **options)
    markup(:div, class: options[:class_top_div]) do |m|
      m << decorated_label(name, label_text, options)
      m.div(class: options[:class_between_label_and_text]) do |m|
        if options[:class_textf].kind_of?(String)
          classes = options[:class_textf].strip.split + ['datepicker']
          options[:class_textf] = classes.uniq.join(' ')
        else
          options[:class_textf] = 'datepicker'
        end
        m << text_field(name, class: options[:class_textf], size: options[:textf_size])
      end
      m << error_messages_for(name)
    end
  end

  def drop_down_list_block(name, label_text, choices, options={})
    markup(:div, class: options[:class_top_div]) do |m|
      m << decorated_label(name, label_text, options)
      m.div(class: options[:class_between_label_and_select]) do |m|
        m << form_builder.select(name, choices, {include_blank: true }, options)
      end
      m << error_messages_for(name)
    end
  end

  def error_messages_for(name)
    markup do |m|
      object.errors.full_messages_for(name).each do |message|
        m.div(class: 'error-message') do |m|
          m.text message
        end
      end
    end
  end

  def decorated_label(name, label_text, **options)
    label(name, label_text, class: "#{options[:required] ? 'required' : nil} #{options[:class_label]}")
  end
end

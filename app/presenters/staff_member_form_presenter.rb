class StaffMemberFormPresenter < FormPresenter
  def full_name_block(name1, name2, label_text, **options)
    markup do |m|
      m.div(class: options[:class_top_div]) do |m|
        m << label(name1, label_text, class: "#{options[:required] ? 'required' : nil}, #{options[:class_label]}")
        m.div(class: options[:class_between_label_and_text]) do |m|
          m << text_field(name1, class: options[:class_textf_1], size: options[:textf_size])
          m << text_field(name2, class: options[:class_textf_2], size: options[:textf_size])
        end
      end
    end
  end
end

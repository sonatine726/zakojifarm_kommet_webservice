class StaffMemberFormPresenter < UserFormPresenter
  def check_boxes(name, label_text, **options)
    markup(:div, class: options[:class_top_div]) do |m|
      m.div(class: options[:class_before_checkbox]) do |m|
        m << check_box(name, class: options[:class_checkbox])
        m << label(name, label_text)
      end
    end
  end
end

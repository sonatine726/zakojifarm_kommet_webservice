class StaffMemberPresenter < ModelPresenter
  delegate :suspended?, to: :object

  def suspended_mark
    object.suspended? ? raw('&#x2611;') : raw('&#x2610;')
  end
end

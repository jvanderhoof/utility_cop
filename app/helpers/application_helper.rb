module ApplicationHelper

  def select_or_label(check_for, select, hidden, name)
    if check_for.present?
      [hidden.to_s, name.to_s].join
    else
      ['<br />', select.to_s].join
    end
  end

  def submit_button_message(obj)
    obj.send(:id).present? ? 'Update' : 'Create'
  end

end

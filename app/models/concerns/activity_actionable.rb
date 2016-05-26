module ActivityActionable
  def create_activity user_id, target_id, actiontype
    Activity.create user_id: user_id, target_id: target_id, actiontype: actiontype
  end
end

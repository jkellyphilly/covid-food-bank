class UserValidator < ActiveModel::Validator

  def validate(record)
    unless(!!record.community_member ^ !!record.volunteer)
      record.errors[:id] << "can only belong to one user"
    end
  end

end

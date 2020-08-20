class UserValidator < ActiveModel::Validator

  # Ensure that the record (in this case, a comment) can
  # only belong to either a community member or a volunteer,
  # but not both
  def validate(record)
    unless(!!record.community_member ^ !!record.volunteer)
      record.errors[:id] << "can only belong to one user"
    end
  end

end

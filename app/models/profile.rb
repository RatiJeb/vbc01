class Profile < ApplicationRecord
  belongs_to :user

  def full_name
    person.full_name
  end

  def person
    Person.new(
      email: self.user.email,
      first_name: self.first_name,
      last_name: self.last_name,
      dob: self.birth_date
    )
  end
end
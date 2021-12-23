class Person
  include Comparable

  attr_reader :email, :first_name, :last_name, :dob

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
  end

  def initialize(email:, first_name:, last_name:, dob:)
    @email = email
    @first_name = first_name
    @last_name = last_name
    @dob = dob
  end

  def ==(other)
    email == other.email &&
    first_name == other.first_name &&
    last_name == other.last_name &&
    dob = other.dob
  end

  def to_s
    "FullName: #{full_name}, Age: #{age}, Email: #{email}"
  end

  def hash
    self.to_s.hash
  end

  def eql?(other)
    self.class == other.class && self == other
  end

  def <=>(other)
    email <=> other.email
  end
end
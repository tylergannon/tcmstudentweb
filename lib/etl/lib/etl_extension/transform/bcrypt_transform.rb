require 'bcrypt'

class ETL::Transform::BcryptTransform < ETL::Transform::Transform
  include BCrypt

  def transform(name, value, row)
    if value
      Password.create(value).to_s
    else
      nil
    end
  end
end


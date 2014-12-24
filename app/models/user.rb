class User < ActiveRecord::Base
  has_one_time_password column_name: :otp_secret_key, length: 4
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

end

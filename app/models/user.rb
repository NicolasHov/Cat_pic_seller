class User < ApplicationRecord
  has_one :cart
  has_many :orders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


    after_create  :welcome_email, :cart_creation

    def welcome_email
      UserMailer.welcome_email(self).deliver
    end

    def cart_creation
      Cart.create(user_id: self.id)
    end
end

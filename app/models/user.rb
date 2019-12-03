class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true
    after_initialize :init

    def init
      self.balance ||= 0.0
    end

    def deposit(amount)
      self.balance += amount
      self.save
    end

    def withdraw(amount)
      if self.balance >= amount
        self.balance -= amount
        self.save
        return true
      else
        return false
      end
    end

end

LOWER = ('a'...'z').to_a
UPPER = ('A'...'Z').to_a
DIGITS = (1...9).to_a.map(&:to_s)
SYMBOLS = (LOWER + UPPER + DIGITS)

def gen_password
  symbols = SYMBOLS.shuffle
  length = rand(3..6)
  symbols.sample(length)
end

def profile_for(name, email, password, admin)
  {
    name: name, 
    email: email, 
    password: password, 
    password_confirmation: password, 
    admin: admin
  }
end

def as_admin(name, email, password)
  profile_for(name, email, password, 1)
end

def as_user(name, email, password)
  profile_for(name, email, password, 0)
end

class Integer
  def users
    self.times.map { |_| as_user(Faker::Name.name, Faker::Internet.email, gen_password) }
  end
end

def admins
  [ as_admin("sacry", "sacry30@gmail.com", "123"),
    as_admin("helmi", "helmi@gmail.com", "123") ]
end

User.create(admins)
User.create(10.users)



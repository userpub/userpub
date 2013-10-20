class User
  include MongoMapper::Document

  key :uid, String, required: true
  key :name, String, required: true
  key :email, String, required: true
  key :admin, Boolean, default: false
  key :staff, Boolean, default: false
  key :title, String
  key :pic, String
  
  timestamps!
  
  belongs_to :account
  
  validates_uniqueness_of :email, :uid, scope: :account_id
  
  def self.from_jwt(jwt, account)
    user = account.users.find_by_uid(jwt.id)
    user ||= User.new(uid: jwt.id, account: account)
    
    user.name = jwt.name
    user.email = jwt.email
    user.pic = jwt.pic
    user.title = jwt.title
    user.admin = jwt.admin
    user.staff = jwt.staff
    
    user.staff = true if !jwt.key?(:staff) && account.staff_email?(jwt.email)
    
    user.save!
    
    user
  end
  
  def avatar
    pic || Gravatar.new(email).image_url
  end
  
  def firebase_token
    JWT.encode({iat: Time.now.to_i, v: 0, d: as_json}, ENV['FIREBASE_SECRET'])
  end
  
  def jwt_token
    JWT.encode({id: id.to_s, name: name, email: email, staff: staff, admin: admin, title: title, pic: pic}, account.secret)
  end
end

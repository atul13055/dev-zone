class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable, authentication_keys: [:login]

  has_many :work_experiences, dependent: :destroy 
  has_many :connections, dependent: :destroy

  validates :first_name, :last_name, :profile_title, presence: true
  validates :username, presence: true, uniqueness: true
  has_one_attached :image
  has_many :posts, dependent: :destroy

   PROFILE_TITLE = [
  # Ruby on Rails
    "Senior Ruby on Rails Developer",
    "Lead Ruby on Rails Engineer",
    "Ruby on Rails Developer",
    "Junior Ruby on Rails Developer",
    "Ruby on Rails Intern",
    
    # React
    "Senior React Developer",
    "Lead React Engineer",
    "React Developer",
    "Junior React Developer",
    "React Intern",
    
    # Node.js
    "Senior Node.js Developer",
    "Lead Node.js Engineer",
    "Node.js Developer",
    "Junior Node.js Developer",
    "Node.js Intern",
    
    # Angular
    "Senior Angular Developer",
    "Lead Angular Engineer",
    "Angular Developer",
    "Junior Angular Developer",
    "Angular Intern",
    
    # Laravel
    "Senior Laravel Developer",
    "Lead Laravel Engineer",
    "Laravel Developer",
    "Junior Laravel Developer",
    "Laravel Intern",
    
    # Python
    "Senior Python Developer",
    "Lead Python Engineer",
    "Python Developer",
    "Junior Python Developer",
    "Python Intern"
  ].freeze
  

  SKILLS = ["Python", "JavaScript", "Java", "C#", "C++", "PHP", "Ruby", "Swift", "Kotlin", "TypeScript", "Go", "R", "Scala", "Perl", "Rust", "HTML/CSS", "SQL", "Bash", "PowerShell", "x86 Assembly", "Objective-C", "MATLAB", "Lua", "Haskell", "Dart", "Visual Basic", "Groovy", "COBOL", "Fortran", "Lisp", "Scheme", "Ada", "Erlang", "Clojure", "D", "Prolog", "Smalltalk", "F#", "ActionScript", "Scratch", "LabVIEW", "Logo", "Tcl", "Ruby On Rails","Mearn Stack","Gitlab and Github","AWS","Bootstrap","React js","React Native"].freeze;

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if(login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def address
    return nil if city.blank? && state.blank? && country.blank? && pincode.blank?

    "#{city}, #{state}, #{country}, #{pincode}"
  end

  def self.ransackable_attributes(auth_object = nil)
    ['country', 'city']
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def country_flag
    ISO3166::Country&.find_country_by_any_name("#{country}")&.emoji_flag
  end

  def my_connection(user)
    Connection.where("(user_id = ? AND connected_user_id = ?) OR (user_id = ? AND connected_user_id = ?)", user.id, id, id, user.id)
  end

  def check_if_already_connected?(user)
    self != user && !my_connection(user).present?
  end

  def mutually_connected_ids(user)
    self.connected_user_ids.intersection(user.connected_user_ids)
  end

end

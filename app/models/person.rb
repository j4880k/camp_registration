class Person < ActiveRecord::Base
  validates :firstname,  :presence => true
  validates :lastname,  :presence => true
  # validates :middleinit,  :presence => true
  validates :birthdate,  :presence => true
  validates :gender,  :presence => true
  has_many :person_addresses
  has_many :addresses, :through => :person_addresses
  has_many :person_emails
  has_many :emails, :through => :person_emails
  has_many :person_organizations
  has_many :organizations, :through => :person_organizations
  has_many :person_simple_contacts
  has_many :simple_contacts, :through => :person_simple_contacts
  has_many :person_medications
  has_many :person_allergies
  has_many :person_medical_notes
  has_many :reservations
  belongs_to :user
  
  accepts_nested_attributes_for :addresses, :emails, 
    :organizations, 
    :simple_contacts, 
    :person_medications, 
    :person_allergies,
    :person_medical_notes,
    :reservations,
    :allow_destroy => true 
  # accepts_nested_attributes_for :person_medical_notes,
    # :reservations,
    # :allow_destroy => false
    #, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  def fullname
    fn = self.firstname || 'unknown_firstname'
    ln = self.lastname || 'unknown_lastname'
    [fn,ln].join(' ')
  end  
end
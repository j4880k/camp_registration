class Person < ActiveRecord::Base
  validates :firstname,  :presence => true
  validates :lastname,  :presence => true
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
  validates_associated :addresses
  
  accepts_nested_attributes_for :addresses, 
    :emails, 
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
  
  def person_basics_complete?
    # 10% person info firstname, lastname, gender, birthdate & at least one person address
      did_pass = (self.firstname.blank? || self.lastname.blank? || self.gender.blank? || self.birthdate.blank?) ? false : true
  end
  
  def person_has_valid_address?
    @matched_complete=false
    unless self.addresses.empty?
      self.addresses.each do |pa|
        unless (pa.Street1.blank?) || (pa.City.blank?) || (pa.State.blank?) || (pa.zipcode.blank?)
          @matched_complete=true
        end
      end
      # @progress_number = @matched_complete==true ? @progress_number + 10 : @progress_number
    end
    @matched_complete
  end

  def person_has_organization?
    @matched_complete=false
    unless self.organizations.empty?
      self.organizations.each do |org|
        unless(org.name.blank?)
          @matched_complete=true end
      end
      # @progress_number = @matched_complete==true ? @progress_number + 10 : @progress_number
    end
    @matched_complete
  end  
  
  def requirement_progress
    puts "****************** progress for #{self.fullname} ********************"
    @progress_number=0
    #this method is used to make sure all of the necessary requirements for a person are met before reservations take place. 
    #It probably should keep invoices from being paid for if the information is incorrect.
      @progress_number = person_basics_complete? ? @progress_number + 10 : @progress_number
      #one valid address
      @progress_number = person_has_valid_address? ? @progress_number + 10 : @progress_number
      # unless self.addresses.empty?
      #   @matched_complete=false
      #   self.addresses.each do |pa|
      #     unless (pa.Street1.blank?) || (pa.City.blank?) || (pa.State.blank?) || (pa.zipcode.blank?)
      #       @matched_complete=true
      #     end
      #   end
      #   @progress_number = @matched_complete==true ? @progress_number + 10 : @progress_number
      # end
     
    # 10% at least one person organization
    @progress_number = person_has_organization? ? @progress_number + 10 : @progress_number
    # unless self.organizations.empty?
    #   @matched_complete=false
    #   self.organizations.each do |org|
    #     unless(org.name.blank?)
    #       @matched_complete=true end
    #   end
    #   @progress_number = @matched_complete==true ? @progress_number + 10 : @progress_number
    # end
    
    # 10% at least one person email
    unless self.emails.empty?
      @matched_complete=false
      self.emails.each do |org|
        unless org.emailAddress.blank? then @matched_complete=true end
      end
      @progress_number = @matched_complete==true ? @progress_number + 10 : @progress_number
    end
    
    # 10% at least one parent/guardian contact
    unless self.simple_contacts.empty?
      @matched_complete=false
      self.simple_contacts.each do |sc|
        if sc.contacttype=="parent" || sc.contacttype=="guardian"
          unless sc.firstname.blank? || sc.lastname.blank? || sc.relationship.blank? then @matched_complete=true end
        end
      end
      @progress_number = @matched_complete==true ? @progress_number + 10 : @progress_number
    end    
    
    # 10% at least one emergency contact (in case parent can't be reached)
    unless self.simple_contacts.empty?
      @matched_complete=false
      self.simple_contacts.each do |sc|
        if sc.contacttype=="emergency"
          unless sc.firstname.blank? || sc.lastname.blank? || sc.relationship.blank? then @matched_complete=true end
        end
      end
      @progress_number = @matched_complete==true ? @progress_number + 10 : @progress_number
    end    
    
    # 10% at least one contact must have insurance information, this is the emergency room contact
    unless self.simple_contacts.empty?
      @matched_complete=false
      self.simple_contacts.each do |sc|
        unless sc.simple_contact_insurances.empty?
          sc.simple_contact_insurances.each do |sci|
            if sci.is_primary==true
              @matched_complete=true 
            end
          end
        end
      end
      @progress_number = @matched_complete==true ? @progress_number + 10 : @progress_number
    end    
    
      # 10% at least one email for each parent/guardian/emergency contact
    unless self.simple_contacts.empty?
      @checked_count=0
      @valid_count=0
      self.simple_contacts.each do |sc|
        if sc.contacttype=="parent" || sc.contacttype=="guardian" || sc.contacttype=="emergency"
          @found_emails=false
          @found_email_value=false
          @checked_count=@checked_count+1
          @found_emails = sc.simple_contact_emails.empty? ? false : true
          if @found_emails
            #we have email so now we need to see if one has a value
            sc.simple_contact_emails.each do |sce|
              unless sce.emailaddress.blank?
                @found_email_value=true 
              end
            end
            @valid_count = @found_email_value==true ? @valid_count + 1 : @valid_count
          end
        end
      end
      @progress_number = @checked_count==@valid_count ? @progress_number + 10 : @progress_number
    end  
         
      # 20% at least 2 phone numbers on every contact
      @progress_number = @progress_number + 10
      
    # 10% at least one pickup person
    @progress_number = @progress_number + 10
    puts"#{@progress_number}"
    @progress_number
  end
end
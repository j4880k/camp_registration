class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      puts "#{user.email} is logged in as a #{user.role}"
      if user.role? :admin
        can :manage, :all
      else
        # can :read, :all
        can :read, Person do |pers|
                pers.try(:user) == user
              end
        can :create, Person
        can :update, Person do |pers|
                pers.try(:user) == user
              end

        can :read, Reservation do |reg|
                reg.try(:person).try(:user) == user
              end
        can :update, Reservation do |reg|
                (reg.try(:person).try(:user) == user) and (reg.try(:locked) != true)
              end
        can :create, Reservation
        can :add_to_cart, Reservation
        can :mark_as_removed, Reservation
              
        can :read, ReservationCart do |rc| 
            (rc.try(:reservation).try(:person).try(:user) == user)
        end
        # can [:edit, :update, :save], ReservationCart do |rc| 
        #     (rc.try(:reservation).try(:person).try(:user) == user)
        # end      
        can :destroy, ReservationCart do |rc| 
            (rc.try(:reservation).try(:person).try(:user) == user)
        end
        can :proceed_to_checkout, ReservationCart
        
        can [:read, :update], Invoice do |inv|
          (inv.try(:user)== user)
        end
        can :apply_coupon_code, Invoice
        can :cancel_invoice, Invoice
        can :submit_transaction_to_firstdata, Invoice
        
      end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

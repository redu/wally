require 'cancan'
require 'permit'

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      permit = Permit::Mechanism.new(:subject_id => user.subject_permit,
                                     :service_name => "wally")
      can do |action, resource_class, resource|
        permit.able_to?(action, resource)
      end
    end
  end
end

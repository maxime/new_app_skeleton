class User < ActiveRecord::Base
  acts_as_authentic

  # Class accessor to store the current_user
  #  (set in before_filter of application controller)
  cattr_accessor :current_user

  # Accessors
  attr_accessor :current_password
  attr_accessor :lost_password

  # Protect those attributes from mass-assignment
  attr_protected :email, :active, :user_type

  # Send an email with instructions to active the account after create
  after_create :deliver_activation_instructions!

  # Default user_type is 0, which is standard
  TYPES = [:standard, :team_leader, :admin]

  # Those helpers define the following methods:
  #
  #   standard?, team_leader? and admin?
  #   become_standard, become_team_leader and become_admin
  #
  TYPES.each do |user_type|
    define_method "#{user_type}?" do
      self.user_type == TYPES.index(user_type)
    end

    define_method "become_#{user_type}" do
      self.user_type = TYPES.index(user_type)
    end
  end

  # Returns the user type as a symbol.
  #
  # Example:
  #  @user.human_user_type
  #  => :team_leader
  #
  def human_user_type
    TYPES[self.user_type]
  end

  # Returns if the user is active or not as a boolean
  def active?
    active
  end

  # Activate the user and sends an email about it
  def activate!
    self.update_attribute(:active, true)
    Notifier.deliver_activation_confirmation(self)
  end

  # Custom validation
  # Validations
  def validate
    # Changing the password of an existing user requires the input of the current password
    if !self.new_record? and
       !self.lost_password and
        self.changes.keys.include?("crypted_password") and
       !self.valid_password?(self.current_password)
      errors.add(:current_password, I18n.t("user.error.is_incorrect"))
    end

    # User type can't be changed by the user himself
    if self.changes.keys.include?("user_type") and User.current_user == self
      errors.add(:user_type, I18n.t("user.error.cant_be_changed_by_you"))
    end
  end

  # Users can't destroy themselves
  def before_destroy
    return false if User.current_user == self
  end

  # Sends an email how on to reset its password
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  private

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end
end

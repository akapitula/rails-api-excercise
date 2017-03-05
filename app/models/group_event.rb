class GroupEvent < ActiveRecord::Base

  ATTRIBUTES = %i(name description location starts_on ends_on duration)

  belongs_to :user

  before_validation :format_attributes

  validate :any_attribute_present
  validates :user_id, presence: true
  validates :duration, allow_blank: true, numericality: { only_integer: true, greater_than: 0 }
  validates_date :starts_on, allow_blank: true, on_or_after: Date.today
  validates_date :ends_on, allow_blank: true, after: :starts_on


  def published?
    all_attributes_present?
  end

  def mark_as_deleted
    self.deleted = true
    self.save
  end

  private
    def format_attributes
      self.starts_on = self.ends_on - self.duration if duration? && ends_on? && !starts_on?
      self.duration = (self.ends_on - self.starts_on).to_i if starts_on? && ends_on? && !duration?
      self.ends_on = self.starts_on + self.duration if starts_on? && duration? && !ends_on?
    end

    def any_attribute_present
      unless ATTRIBUTES.any? { |attribute| self.send("#{attribute}?")}
        errors.add :base, "specify at least one base attribute"
      end
    end

    def all_attributes_present?
      ATTRIBUTES.all? { |attribute| self.send("#{attribute}?") }
    end
end

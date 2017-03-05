class GroupEventSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :description, :location, :starts_on, :ends_on, :duration, :published, :deleted

  def published
    object.published?
  end
end
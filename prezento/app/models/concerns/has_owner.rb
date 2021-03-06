require 'active_support/concern'

module HasOwner
  extend ActiveSupport::Concern

  class_methods do
    def latest(count = 1)
      all.sort { |one, another| another.id <=> one.id }.select { |entity|
        attributes = entity.attributes
        attributes && attributes.public
      }.first(count)
    end
  
    def public_or_owned_by_user(user = nil)
      class_name = name+"Attributes"
      collection = class_name.constantize.where(public: true)
      collection += class_name.constantize.where(user_id: user.id, public: false) if user

      collection.map do |item|
        begin
          self.find(item.send(name.underscore+"_id"))
        rescue Likeno::Errors::RecordNotFound
          nil
        end
      end.compact
    end
  end
end

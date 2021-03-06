module Toy
  module Dirty
    extend ActiveSupport::Concern
    include ActiveModel::Dirty
    include Attributes
    include Cloneable

    def initialize_copy(*)
      super.tap do
        @previously_changed = {}
        @changed_attributes = {}
      end
    end

    def write_attribute(name, value)
      @attributes ||= {}
      name    = name.to_s
      current = read_attribute(name)
      attribute_will_change!(name) if current != value
      super
    end
  end
end

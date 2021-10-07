class ScopeLimitation < ApplicationRecord
  has_many :proceeding_type_scope_limitations, dependent: :destroy
  has_many :proceeding_types, through: :proceeding_type_scope_limitations
end

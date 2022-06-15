class Approval < ApplicationRecord
  belongs_to :approvalable, polymorphic: true
end

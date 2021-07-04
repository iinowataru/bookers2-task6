class BookComment < ApplicationRecord
    validates :comment, presence: true
end

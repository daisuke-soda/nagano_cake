class Genre < ApplicationRecord
    has_many :items,dependent: :destroy
enum valid_flag:{
        有効: true,
        無効: false,
    }

end

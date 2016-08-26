class Product < ActiveRecord::Base
    validates :title, :description, :image_url, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
    validates :title, uniqueness: true
    # validates :image_url, allow_blank: true, format: {
    # with: %r{\ .(gif|jpg|png)$}i,
    # message: 'はGIF、JPG、PNG画 像 のURLで な け れ ば な り ま せ ん'}
end

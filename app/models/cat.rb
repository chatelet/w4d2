class Cat < ActiveRecord::Base
  validates :name, presence: true
  validates :sex, inclusion: { in: %w(M F),
    message: "select a sex"}
  validates :color, inclusion: { in: %w(black white grey ginger blue tabby) }

  has_many(
    :cat_rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id
  )

  def age
    now = Time.now.utc.to_date
    now.year - self.birth_date.year -
      (birth_date.to_date.change(:year => now.year) > now ? 1 : 0 )
  end

end

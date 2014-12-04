class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :status, presence: true
  validates :status, inclusion: { in: ["PENDING", "APPROVED", "DENIED"],
    message: "check value of status" }
  validate :overlapping_approved_requests
  after_initialize :init_status

  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )

  private

  def init_status
    self[:status] ||= "PENDING"
  end

  def overlapping_requests
    CatRentalRequest.all
      .where.not("end_date < #{self.start_date} || start_date > #{self.end_date}")
      .where.not(:cat_id)
  end

  def overlapping_approved_requests
    #one who does not have overlap
    return true unless :status == "APPROVED"
    results = overlapping_requests
      .where(:status => "APPROVED")
    !results.empty?
  end

  def overlapping_pending_requests
    overlapping_requests
      .where(:status => "PENDING")
  end

end

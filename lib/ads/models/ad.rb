# frozen_string_literal: true

class Ad < Sequel::Model
  RECORDS_PER_PAGE = 5

  Ad.plugin :timestamps, update_on_create: true
  Ad.plugin :validation_helpers

  def validate
    super
    validate_presence %i[title description city]
  end

  def self.page(page: nil)
    return Ad.reverse_order(:updated_at).limit(RECORDS_PER_PAGE).all if page <= 0 || page.blank?

    Ad.reverse_order(:updated_at).offset(page * RECORDS_PER_PAGE).limit(RECORDS_PER_PAGE).all
  end

  def self.total_pages
    Ad.reverse_order(:updated_at).count / RECORDS_PER_PAGE + 1
  end
end

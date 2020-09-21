# frozen_string_literal: true

Fabricator(:ad) do
  title { sequence { |n| "title_#{n}" } }
  description { sequence { |n| "description_#{n}" } }
  city { sequence { |n| "city_#{n}" } }
  user_id { sequence { |n| "user_id_#{n}" } }
end

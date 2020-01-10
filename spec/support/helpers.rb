# frozen_string_literal: true

def parse_json(json)
  JSON.parse(json)
end

def sign_in_admin
  admin = create(:admin)
  sign_in admin
end

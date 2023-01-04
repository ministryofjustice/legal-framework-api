class MatterType < ApplicationRecord
  def self.domestic_abuse
    find_by(name: "Domestic Abuse")
  end

  def self.section8
    find_by(name: "Section 8 orders")
  end
end

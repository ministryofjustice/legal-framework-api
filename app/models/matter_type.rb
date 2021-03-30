class MatterType < ApplicationRecord
  def self.domestic_abuse
    find_by(name: 'Domestic abuse')
  end

  def self.section8
    find_by(name: 'Children - section 8')
  end
end

class RenameMatterTypes < ActiveRecord::Migration[7.0]
  def up
    MatterType.where(name: "Domestic abuse").update_all(name: "Domestic Abuse")
    MatterType.where(name: "Children - section 8").update_all(name: "Section 8 orders")
  end

  def down
    MatterType.where(name: "Domestic Abuse").update_all(name: "Domestic abuse")
    MatterType.where(name: "Section 8 orders").update_all(name: "Children - section 8")
  end
end

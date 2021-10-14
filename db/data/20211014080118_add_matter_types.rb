# frozen_string_literal: true

class AddMatterTypes < ActiveRecord::Migration[6.1]
  def up
    MatterTypePopulator.call
  end

  def down
    MatterType.destroy_all
  end
end

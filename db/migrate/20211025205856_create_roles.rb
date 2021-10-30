class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name
      #t.datetime :created_at
      #t.datetime :update_at

      #t.timestamps
    end
  end
end

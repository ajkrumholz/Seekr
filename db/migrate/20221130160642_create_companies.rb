class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :description
      t.string :hiring_link
      t.string :roles_hiring_for
      t.string :locations_hiring_in
      t.string :one_nice_thing
      t.string :comments
    end
  end
end

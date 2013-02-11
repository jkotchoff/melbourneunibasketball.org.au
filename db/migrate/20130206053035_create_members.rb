class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :eligibility_clause
      t.string :eligibility_justification
      t.string :payment_method
      t.string :paypal_payer_id
      t.string :paypal_token
      t.boolean :representative_player, default: false
      t.integer :year
      t.string :given_name
      t.string :family_name
      t.string :postal_address
      t.integer :postcode
      t.string :phone_number_mobile
      t.string :phone_number_other
      t.string :email
      t.date :date_of_birth
      t.string :gender
      t.boolean :new_member, default: true
      t.string :your_existing_mubc_singlet_numbers
      t.text :how_did_you_hear_about_the_club
      t.integer :amount_paid
      t.boolean :payment_confirmed, default: false
      t.timestamps
    end
  end
end

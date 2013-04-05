class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.string :full_name
      t.string :display_name
      t.string :email
      t.string :category
      t.string :profession
      t.string :occupation
      t.string :enterprise
      t.string :cnpj
      t.string :cep
      t.string :address
      t.string :complement
      t.string :number
      t.string :neighbourhood
      t.string :city
      t.string :state
      t.string :phone
      t.string :receipt_person
      t.boolean :active_cte_client
      t.string :how_did_you_knew_us
      t.boolean :want_to_receive_newsletter
      t.string :entity

      t.timestamps
    end
  end
end

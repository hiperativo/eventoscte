class AddItauCryptoToEnrollment < ActiveRecord::Migration
  def change
    add_column :enrollments, :itau_crypto, :string
  end
end

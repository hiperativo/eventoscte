class ChangeColumnItauCryptoToTextFromEnrollments < ActiveRecord::Migration
  def up
  	change_column :enrollments, :itau_crypto, :text
  end

  def down
  end
end

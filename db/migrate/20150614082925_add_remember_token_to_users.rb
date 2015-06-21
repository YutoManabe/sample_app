class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_token, :string
    add_index :users, :remember_token # よく使うものにはインデックスをかけて高速化する(find_by)
  end
end

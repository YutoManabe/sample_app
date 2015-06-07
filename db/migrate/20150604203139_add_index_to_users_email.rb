class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true # メールアドレスの一意性を担保
  end
end

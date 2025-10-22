class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :age_f
      t.integer :age_h
      t.string :cheveux_f
      t.string :cheveux_h
      t.text :description
      t.string :fumeur_f
      t.string :fumeur_h
      t.string :origine_f
      t.string :origine_h
      t.string :pilosite_f
      t.string :pilosite_h
      t.integer :poids_f
      t.integer :poids_h
      t.string :prep_f
      t.string :prep_h
      t.string :profession_f
      t.string :profession_h
      t.string :signe_f
      t.string :signe_h
      t.string :silouhette_f
      t.string :silouhette_h
      t.integer :taille_f
      t.integer :taille_h
      t.string :tendance_f
      t.string :tendance_h
      t.string :type_user
      t.string :yeux_f
      t.string :yeux_h

      t.timestamps
    end
  end
end

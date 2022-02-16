class Etudiant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :formations

  enum statut_arrivant_L3: { MIAGE: 'MIAGE', DSPEG: 'DSPEG' }

  def name_with_initial
    "#{nom.upcase} #{prenom}"
  end

  def transfert(formation)
    self.formations << formation
    self.save
  end
end

class FicheStagesController < ApplicationController
  def index
    @fichestage = FicheStage.all
    @fichestage_todo = FicheStage.where(statut: "EN_ATTENTE_DE_VALIDATION")
    @fichestage_draft = FicheStage.where(statut: "BROUILLON")
  end

  def show
    @fichestage = FicheStage.find(params[:id])
  end

  def new
    @fichestage = FicheStage.new
  end

  def create
    @fichestage = FicheStage.new(fiche_stage_params)
    @fichestage.statut = "BROUILLON"
    @fichestage.etudiant_id = current_etudiant.id

    if @fichestage.save
      redirect_to @fichestage
    else
      render :new
    end
  end

  def csend
    @fichestage = FicheStage.new(fiche_stage_params)
    @fichestage.statut = "EN_ATTENTE_DE_VALIDATION"
    @fichestage.etudiant_id = current_etudiant.id

    if @fichestage.save
      redirect_to @fichestage
    else
      render :new
    end
  end

  def edit
    @fichestage = FicheStage.find(params[:id])
  end

  def update
    @fichestage = FicheStage.find(params[:id])
    if @fichestage.statut == "REFUSEE"
      @fichestage.statut = "BROUILLON"
    end

    if @fichestage.update(fiche_stage_params)
      redirect_to @fichestage
    else
      render :show
    end
  end

  def usend
    @fichestage = FicheStage.find(params[:id])

    if @fichestage.update(statut: "EN_ATTENTE_DE_VALIDATION")
      redirect_to @fichestage
    else
      render :show
    end
  end

  def validate
    @fichestage = FicheStage.find(params[:id])
  end

  def vyes
    @fichestage = FicheStage.find(params[:id])
    @fichestage.statut = "VALIDEE"

    if @fichestage.update(fiche_stage_params)
      redirect_to @fichestage
    else
      render :validate
    end
  end

  def vno
    @fichestage = FicheStage.find(params[:id])
    @fichestage.statut = "REFUSEE"

    if @fichestage.update(fiche_stage_params)
      redirect_to @fichestage
    else
      render :validate
    end
  end

  private
  def fiche_stage_params
    params.require(:fiche_stage).permit(
      :titre, :type_stage, :mention, :date_debut, :date_fin,
      :poste, :taches, :technologies, :contact_nom, :contact_prenom, :contact_poste,
      :tuteur_nom, :tuteur_prenom, :tuteur_fonction, :tuteur_telephone, :tuteur_email,
      :entreprise_nom, :entreprise_siren, :entreprise_cp, :entreprise_ville, :entreprise_pays, :commentaire_validation)
  end

  def destroy
    #@fichestage = fiche_stages.all
  end
end

class JqueryFileUploadsController < ApplicationController
  #TODO usuario autenticado es decir hay peos de seguridad
  # after_action :check_mask_solicitud, only: [:destroy,:destroy_no_paginado,:create]
  before_action :authenticate_user!
  authorize_resource class:  :jquery_file_uploads
  def index
    @documentos = Documento.find_documentos(modelo_id_params,modelo_type_params, documentos_requisito_por_vista_params)
    render :json => @documentos.collect { |p| p.to_jq_upload }.to_json
  end

  def create
    p_attr = params[:documento]
    p_attr[:file] = params[:documento][:file].first if params[:documento][:file].class == Array

    @documento = Documento.new(doc: p_attr[:file],
                               documentos_requisitos_por_vista_id: documentos_requisito_por_vista_params,
                               modelo_id: modelo_id_params,
                               modelo_type:modelo_type_params)


    if @documento.save
      respond_to do |format|
        format.html {
          render :json => [@documento.to_jq_upload].to_json,
                 :content_type => 'text/html',
                 :layout => false
        }
        format.json {
          render :json => { :files => [@documento.to_jq_upload] }
        }
      end
    else
      @documento.errors.each do |error, message|
        puts message
      end
      render :json => [{:error => "No se pudo cargar el documento"}], :status => 304
    end
  end

  def destroy
    @documento = Documento.find_by(id: params_id)
    @documento.destroy
    render :json => true
  end

  def wf_destroy_no_paginado
    @documento = Documento.includes(documentos_requisitos_por_vista: [:documento_requisito]).find_by(id: params_id)
    @documento.destroy
  end

  def self.permission
    :jquery_file_uploads
  end

  private
  def modelo_id_params
    ActionController::Parameters.new(modelo_id: params[:modelo_id]).permit(:modelo_id)[:modelo_id]
  end

  def modelo_type_params
    ActionController::Parameters.new(modelo_type: params[:modelo_type]).permit(:modelo_type)[:modelo_type]
  end

  def documentos_requisito_por_vista_params
    ActionController::Parameters.new(
        documentos_requisitos_por_vista_id:
                     params[:documentos_requisitos_por_vista_id]
    ).permit(:documentos_requisitos_por_vista_id)[:documentos_requisitos_por_vista_id]
  end
end
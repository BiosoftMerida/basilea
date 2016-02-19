module ModeloGeneral
  module GuardarDocumentos
    extend ActiveSupport::Concern

    def save_documentos(attributes)
      attributes.each do |document_albums|
        document_albums[1].each do |album|
          document_album_db = self.document_albums.find_by(id: album[1][:id])
          album[1].each do |documentos|
            documentos.each do |documento|
              puts documento
              document_album_db.documentos.find_by(id: documento[1])
            end
          end
        end

        document_album[:documentos_attributes].each do |documento|
          if documento[:id].present?
              documento = album.documentos.find_by(id: documento[:id])
              documento.update(documento)
          else
            album.documentos.create!(documento)
          end
        end
      end
    end
  end
end
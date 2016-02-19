json.array!(@contactos) do |contacto|
  json.extract! contacto, :id, :nombres, :apellidos, :doc_identidad, :email, :telefono, :iglesia, :estado_id, :profesion_id, :ministerio_id, :empresa_id
  json.url contacto_url(contacto, format: :json)
end

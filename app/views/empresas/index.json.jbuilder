json.array!(@empresas) do |empresa|
  json.extract! empresa, :id, :nombre, :abreviado, :rif, :direccion_fiscal, :telefono, :pais_id
  json.url empresa_url(empresa, format: :json)
end

json.array!(@eventos) do |evento|
  json.extract! evento, :id, :nombre, :descripcion, :fecha_inicio, :fecha_fin, :tlf_contacto, :email_contacto, :cupos, :lugar, :horario, :precio, :servicios, :mensaje_invitacion, :empresa_id
  json.url evento_url(evento, format: :json)
end

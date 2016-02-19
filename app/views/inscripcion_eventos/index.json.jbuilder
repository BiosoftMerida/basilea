json.array!(@inscripcion_eventos) do |inscripcion_evento|
  json.extract! inscripcion_evento, :id, :fecha, :nro_asiento, :fecha_pago, :nro_pago, :monto, :aceptado, :fecha_aceptado, :contacto_id, :evento_id
  json.url inscripcion_evento_url(inscripcion_evento, format: :json)
end

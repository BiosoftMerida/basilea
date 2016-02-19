json.array!(@unidad_manejo) do |unidad_manejo|
  json.extract! unidad_manejo, :nombre, :id
end
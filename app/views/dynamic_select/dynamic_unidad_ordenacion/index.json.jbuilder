json.array!(@unidad_ordenacion) do |unidad_ordenacion|
  json.extract! unidad_ordenacion, :codigo, :id
end
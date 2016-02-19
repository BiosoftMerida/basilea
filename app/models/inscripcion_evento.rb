class InscripcionEvento < ActiveRecord::Base
  belongs_to :contacto
  belongs_to :evento
end

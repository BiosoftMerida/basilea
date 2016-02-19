# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  # inflect.acronym 'RESTful'
  inflect.clear

  inflect.plural(/$/, 's')
  inflect.plural(/([^aeéiou])$/i, '\1es')
  inflect.plural(/([aeiou]s)$/i, '\1')
  inflect.plural(/z$/i, 'ces')
  inflect.plural(/á([sn])$/i, 'a\1es')
  inflect.plural(/é([sn])$/i, 'e\1es')
  inflect.plural(/í([sn])$/i, 'i\1es')
  inflect.plural(/ó([sn])$/i, 'o\1es')
  inflect.plural(/ú([sn])$/i, 'u\1es')

  inflect.singular(/s$/, '')
  inflect.singular(/es$/, '')

  inflect.irregular('el', 'los')
end

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'pais', 'paises'
  inflect.plural  'paises', 'pais'

  inflect.irregular 'permission', 'permissions'
  inflect.plural  'permissions', 'permission'

  inflect.irregular 'bloque_ordenacion', 'bloque_ordenacions'
  inflect.plural  'bloque_ordenacions', 'bloque_ordenacion'

  inflect.irregular 'user', 'users'
  inflect.plural  'users', 'user'

  inflect.irregular 'EmpresaForestal', 'EmpresasForestales'
  inflect.plural 'EmpresasForestales', 'EmpresaForestal'
  inflect.irregular 'empresa_forestal', 'empresas_forestales'
  inflect.plural  'empresas_forestales', 'empresa_forestal'
  
  inflect.irregular 'ZonaOrdenamiento', 'ZonasOrdenamiento'
  inflect.plural 'ZonasOrdenamiento', 'ZonaOrdenamiento'
  inflect.irregular 'zona_ordenamiento', 'zonas_ordenamiento'
  inflect.plural  'zonas_ordenamiento', 'zona_ordenamiento'

  inflect.irregular 'role', 'roles'
  inflect.plural  'roles', 'role'

  inflect.irregular 'especie', 'especies'
  inflect.plural  'especies', 'especie'
  inflect.irregular 'Especie', 'Especies'
  inflect.plural  'Especies', 'Especie'

  inflect.irregular 'GranPaisaje', 'GranPaisajes'
  inflect.plural  'GranPaisajes', 'GranPaisaje'

  inflect.irregular 'Paisaje', 'Paisajes'
  inflect.plural  'Paisajes', 'Paisaje'

  inflect.irregular 'SubPaisaje', 'SubPaisajes'
  inflect.plural  'SubPaisajes', 'SubPaisaje'

  inflect.irregular 'ArbolCenso', 'ArbolCensos'
  inflect.plural  'ArbolCensos', 'ArbolCenso'


end



# CREANDO IDIOMAS
es = Idioma.create!(nombre: 'Español')
en = Idioma.create!(nombre: 'Inglés')
port = Idioma.create!(nombre: 'Portugués')
puts '#---- Idiomas  SEEDED ----#'

# CREANDO PAISES
Pais.create!(nombre: 'Venezuela', idioma: es)
Pais.create!(nombre: 'Colombia', idioma: en)
Pais.create!(nombre: 'Brasil',idioma: port)
Pais.create!(nombre: 'Ecuador',idioma: es)
Pais.create!(nombre: 'Perú',idioma: es)
Pais.create!(nombre: 'Bolivia',idioma: es)
Pais.create!(nombre: 'Chile',idioma: es)
Pais.create!(nombre: 'Argentina',idioma: es)
Pais.create!(nombre: 'Uruguay',idioma: es)
Pais.create!(nombre: 'Paraguay',idioma: es)
Pais.create!(nombre: 'Panamá',idioma: es)
Pais.create!(nombre: 'Guatemala',idioma: es)
Pais.create!(nombre: 'El Salvador',idioma: es)
Pais.create!(nombre: 'Estados Unidos',idioma: en)
Pais.create!(nombre: 'Costa Rica',idioma: es)
Pais.create!(nombre: 'México',idioma: es)
puts '#---- Paises  SEEDED ----#'

# CREANDO LA EMPRESA
Empresa.create!(nombre: 'Universidad Basilea',abreviado: "Basilea",rif: "J-31665498-1",direccion_fiscal: "Merida",
                telefono: "0416-7674654",pais: Pais.where(nombre: 'Venezuela').first )
puts '#---- Empresa  SEEDED  FINALIZADA----#'

# CREANDO LOS ROLES
admin_sistema = Role.create!(name: 'Super Usuario',
                             permissions: Permission.where(name: 'manage', subject_class: [:Static,
                                                                                           :User,
                                                                                           :Pais,
                                                                                           :Empresa,
                                                                                           :jquery_file_uploads,
                                                                                           :Role]),
                             role_type: Role.role_types[:administrador_sistema])

admin_cliente = Role.create!(name: 'Administrador en la Empresa',
                             permissions: Permission.where(name: 'manage', subject_class: [:client_users,
                                                                                           :Evento,
                                                                                           :Contacto,
                                                                                           :Static,
                                                                                           :jquery_file_uploads,
                             ]),
                             role_type: Role.role_types[:administrador_cliente])

administrador = Role.create!(name: 'Gerente de Eventos',
                             permissions: Permission.where(name: 'manage'),
                             role_type: Role.role_types[:cliente])


puts '#---- Roles  SEEDED  FINALIZADA----#'

# CREANDO EL SUPER USUARIO DEL SISTEMA y USUARIO DE EMPRESA
User.create!(email: 'surf.airwaves@hotmail.com',
             username: 'super_user',
             password: '12345678',
             name: 'Super Usuario',
             cellphone: '0414-7163143',
             role: Role.where(name: 'Super Usuario').first,
             avatar: '')
User.create!(email: 'gomezfernan@hotmail.com',
             username: 'fgomez',
             password: '12345678',
             name: 'Fernan Gómez',
             cellphone: '0416-7163143',
             role: Role.where(name: 'Administrador en la Empresa').first,
             empresa: Empresa.where(abreviado: "Basilea").first,
             avatar: '')
puts '#---- Usurio  SEEDED  FINALIZADA----#'

# CREANDO LOS MINISTERIOS
Ministerio.create!(nombre: 'Apostol' )
Ministerio.create!(nombre: 'Pastor' )
Ministerio.create!(nombre: 'Profeta' )
Ministerio.create!(nombre: 'Evangelista' )
Ministerio.create!(nombre: 'Maestro' )
Ministerio.create!(nombre: 'Diácono' )
Ministerio.create!(nombre: 'Adorador' )
Ministerio.create!(nombre: 'Ninguno' )
puts '#---- Ministerio  SEEDED  FINALIZADA----#'

# CREANDO LAS PROFESIONES
Profesion.create!(nombre: 'Administrador' )
Profesion.create!(nombre: 'Contador' )
Profesion.create!(nombre: 'Maestro' )
Profesion.create!(nombre: 'Profesor' )
Profesion.create!(nombre: 'Músico' )
Profesion.create!(nombre: 'Economista' )
Profesion.create!(nombre: 'Ingeniero' )
Profesion.create!(nombre: 'Científico' )
Profesion.create!(nombre: 'Militar' )
Profesion.create!(nombre: 'Político' )
Profesion.create!(nombre: 'Abogado' )
Profesion.create!(nombre: 'Técnico Superior Universitario' )
Profesion.create!(nombre: 'Técnico Medio (Albañil-Mecánico-Carpintero-Otro' )
Profesion.create!(nombre: 'Médico' )
Profesion.create!(nombre: 'Enfermero(a)' )
Profesion.create!(nombre: 'Bionanálista' )
Profesion.create!(nombre: 'Farmacéutico' )
Profesion.create!(nombre: 'Comerciante' )
Profesion.create!(nombre: 'Constructor' )
Profesion.create!(nombre: 'Arquitecto' )
Profesion.create!(nombre: 'Informático' )
Profesion.create!(nombre: 'Deportista' )
Profesion.create!(nombre: 'Piloto' )
Profesion.create!(nombre: 'Agricultor' )
Profesion.create!(nombre: 'Ganadero' )
Profesion.create!(nombre: 'Empresario' )
Profesion.create!(nombre: 'Transportista' )
Profesion.create!(nombre: 'Policía' )
Profesion.create!(nombre: 'Chef de cocina' )
Profesion.create!(nombre: 'Inversionista' )
Profesion.create!(nombre: 'Estudiante' )
Profesion.create!(nombre: 'Ama de casa' )
Profesion.create!(nombre: 'Ninguna' )

puts '#---- Profesión  SEEDED  FINALIZADA----#'

# CREANDO LOS ESTADOS
Estado.create!(nombre: 'Aragua',codificacion: "AG",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Amazonas',codificacion: "AS",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Anzoategui',codificacion: "AT",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Apure',codificacion: "AP",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Barinas',codificacion: "BS",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Bolivar',codificacion: "BR",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Carabobo',codificacion: "CB",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Cojedes',codificacion: "CS",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Delta Amacuro',codificacion: "CB",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Distrito Capital',codificacion: "DC",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Falcon',codificacion: "FN",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Guarico',codificacion: "GC",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Lara',codificacion: "LR",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Mérida',codificacion: "MD",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Mirando',codificacion: "MI",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Monagas',codificacion: "MG",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Nueva Esparta',codificacion: "MG",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Portuguesa',codificacion: "PS",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Sucre',codificacion: "SR",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Táchira',codificacion: "TR",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Trujillo',codificacion: "TL",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Vargas',codificacion: "VA",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Yaracuy',codificacion: "YY",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Zulia',codificacion: "ZL",pais: Pais.where(nombre: 'Venezuela').first )

puts '#---- Estados  SEEDED  FINALIZADA----#'



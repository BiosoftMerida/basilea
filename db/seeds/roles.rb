puts '#---- Roles  SEEDED ----#'
admin_sistema = Role.create!(name: 'Administrador Global del Sistema',
                          permissions: Permission.where(name: 'manage', subject_class: [:Static,
                                                                                        :User,
                                                                                        :Pais,
                                                                                        :Empresa,
                                                                                        :jquery_file_uploads,
                                                                                        :Role]),
                          role_type: Role.role_types[:administrador_sistema])

admin_cliente = Role.create!(name: 'Administrador de la Empresa',
                          permissions: Permission.where(name: 'manage', subject_class: [:client_users,
                                                                                        :Static,
                                                                                        :jquery_file_uploads,
                                                                                         ]),
                          role_type: Role.role_types[:administrador_cliente])

administrador = Role.create!(name: 'Gerente de Eventos',
                          permissions: Permission.where(name: 'manage'),
                          role_type: Role.role_types[:cliente])


puts '#---- Roles  SEEDED  FINALIZADA----#'

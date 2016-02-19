module RegexHelper
  #RIF
  RIF_REGEX_COMPLETE  = /\A[VEJPG]-(([0-9]{1,2}?[0-9]{1,3}[0-9]{3})|([0-9]{1,3}?[0-9]{3})|([0-9]{3}))\d\z/i
  RIF_REGEX_SIGN_UP =
      /\A[VE](([0-9]{1,2}?[0-9]{1,3}[0-9]{3})|([0-9]{1,3}?[0-9]{3})|([0-9]{3}))\d\z/i

  #rif fraccionado
  RIF_PREFIX =/\A[VEJPG]\z/i
  RIF_AFIX = /\A([0-9]{1,8})\z/
  RIF_SUFIX =/\A\d\z/

  #Fields comunes
  SOLO_CARACTERES_REGEX = /\A([a-zA-Z ñáéíóúÑÁÉÍÓÚ]{2,})\z/i
  CEDULA_REGEX  = /\A(([0-9]{1,2}?[0-9]{1,3}[0-9]{3})|([0-9]{1,3}?[0-9]{3})|([0-9]{3}))\z/
  NACIONALIDAD_REGEX= /\A[VE]\z/
  TELEFONO_LOCAL_REGEX = /\A\d{11}\z/
  MOVIL_REGEX = /\A(426|416|412|414|424)\d{7}\z/
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-zA-Z0-9]+\.)+[a-zA-Z]{2,})\z/i
  ALFANUMERICO_REGEX = /\A([a-zA-Z ñáéíóú\d])+\z/i
  DIGITOS_REGEX = /\A\d+\Z/
  DIRECCION_REGEX = /\A([0-9a-zñáéíóú\x20\x2C\x2D\x2E\x5F])+\z/i

  #Recursos web y/o multimedia
  URL_REGEX = /\A(https?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})\z/
  IMG_REGEX = /.(gif|jpeg|jpg|png|pdf)\z/
  DOC_REGEX = /.(pdf|doc|docx|odt|ods|odp)\z/
  IMG_DOC_REGEX = /.(gif|jpeg|jpg|png|pdf|pdf)\z/

end


local ls = require 'luasnip'
local t = ls.text_node
local i = ls.insert_node
local s = ls.snippet
local c = ls.choice_node
local fmt = require('luasnip.extras.fmt').fmt

return {

  -- !Preguntas snippet
  s(
    'preg',
    fmt(
      [[
!Preguntas
  previos: {}
  tareas: []
  conocimientos_previos: []
  conocimientos_extra: []
  proposito: {}
  enunciado: |
    {}
  preguntas:
  - {}
]],
      {
        i(1, '[]'),
        i(2, 'Propósito del bloque'),
        i(3, 'Texto del enunciado general...'),
        i(4, 'Elemento 1'),
      }
    )
  ),

  -- !Recordemos snippet
  s(
    'rec',
    fmt(
      [[
!Recordemos
  previos: []
  tareas: []
  conocimientos_previos: []
  conocimientos_extra: []
  proposito: {}
  contenido: |
    {}
]],
      {
        i(1, 'Propósito del bloque'),
        i(2, 'Texto del contenido...'),
      }
    )
  ),

  -- !Numerica only (for adding inside preguntas)
  s(
    'num',
    fmt(
      [[
- !Numerica
  enunciado: |
    {}
  clave: {}
]],
      {
        i(1, 'Texto de la pregunta numérica...'),
        i(2, '580'),
      }
    )
  ),

  -- !Abierta only (for adding inside preguntas)
  s(
    'ab',
    fmt(
      [[
- !Abierta
  enunciado: |
    {}
  clave: |
      {}
]],
      {
        i(1, 'Texto de la pregunta abierta...'),
        i(2, 'Respuesta modelo...'),
      }
    )
  ),
}

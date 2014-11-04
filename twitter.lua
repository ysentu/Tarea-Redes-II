---- TWITTER CONNECTION --
---- Utiliza las funciones de tcp.lua que implementa el modulo tcp propio de lua
require 'tcp'
--

--VARIABLES LOCALES
local TEXT = ''
local HOST   = 'www2.elo.utfsm.cl' -- Host a conectarse
local url    = '~elo323/tweet/settweet.php?search=%40kblog43%20' -- Consulta
local result = ''                  -- Resultado html de la busqueda
local answer = ''


-- 	OBTENCION PARAMETRO BUSQUEDA
local function handler (evt)
  if evt.class ~= 'ncl' then return end
  
  -- Identifica el evento correcto
  if evt.type == 'attribution' then
    if evt.name == 'text' then
      if evt.action == 'start' then
        TEXT = evt.value -- Toma el valor de campo busqueda NCL
        url = url..TEXT
        
        --evt.action = 'stop' -- Avisa que lo leyo cambiando el parametro action
        --event.post(evt)     -- Entre la clase evt modificado a NCL
        
      end
    end
  end
end

event.register(handler)

--background
--canvas:attrColor('navy')
--canvas:clear()

--canvas:attrFont("Tiresias", 20, "normal") -- Se asignan sitintos tipos de letras con disitntos tamaños
--canvas:attrColor('blue') -- Se define el color de todo lo que se dibuje/escriba

-- Implementa dentro de las funciones que tiene tcp.lua


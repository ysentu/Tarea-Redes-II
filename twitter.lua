---- TWITTER CONNECTION --
---- Utiliza las funciones de tcp.lua que implementa el modulo tcp propio de lua
require 'tcp'


--PAR�METROS
local TEXT   = ''
local HOST   = 'www2.elo.utfsm.cl' -- Host a conectarse
local url    = '~elo323/tweet/settweet.php?search=%40kblog43+car' -- Consulta
local result = ''                  -- Resultado html de la busqueda
local answer = ''

local function write_text(text)
  canvas:attrFont("Tiresias", 20, "normal")
  canvas:attrColor('green') 
  canvas:drawText(5,5,text)
  canvas:flush()
end

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
        
        -- Implementa dentro de las funciones que tiene tcp.lua
        tcp.execute(
            function ()
           tcp.connect(HOST, 80)
           tcp.send('GET http://www2.elo.utfsm.cl/~elo323/tweet/settweet.php?search=%40MonsterEnergy+'..TEXT)
           tcp.send('\r\n')
      
           result = tcp.receive()
      
           if result then
               _,_,answer = string.find(result, "<tweet>(.*)</tweet>")       
            else
              result = 'error: '
           end
      
           write_text('Tweet: '..answer)
           tcp.disconnect()
      
           end
          )
        
      end
    end
  end
end

event.register(handler)






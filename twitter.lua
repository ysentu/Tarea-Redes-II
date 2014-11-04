---- TWITTER CONNECTION --
---- Utiliza las funciones de tcp.lua que implementa el modulo tcp propio de lua
require 'tcp'
--

--VARIABLES LOCALES
local TEXT = ''
local HOST   = 'www2.elo.utfsm.cl' -- Host a conectarse
local url    = '~elo323/tweet/settweet.php?search=%40kblog43+' -- Consulta
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

local function write_text(text)
	canvas:attrFont("Tiresias", 20, "normal")
	canvas:attrColor('green') 
	canvas:drawText(0,0,text)
	canvas:flush()
end


-- Implementa dentro de las funciones que tiene tcp.lua
 tcp.execute(
        function ()
			tcp.connect(HOST, 80)
			tcp.send('GET '..url..' HTTP/1.1\r\n')
			tcp.send('Host: '..HOST..'\r\n')		-- Es necesario 'Host: HTTP://'.. ???
			tcp.send('\r\n')
			
			result = tcp.receive()
			
			if result then
				answer = string.find(result, "Server")
				
				write_text('Pregunta:'..answer)
				
		    else
			    result = 'error: '
		    end
		    
			tcp.disconnect()
		end
)

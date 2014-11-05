---- TWITTER CONNECTION --
---- Utiliza las funciones de tcp.lua que implementa el modulo tcp propio de lua
require 'tcp'


--PARAMETROS
local TEXT   = ''                  -- Texto de busqueda
local HOST   = 'www2.elo.utfsm.cl' -- Host a conectarse
local result = ''                  -- Respuesta de petición HTTP
local answer = ''                  -- Resultado html de la busqueda
local url    = '~elo323/tweet/settweet.php?search=%40kblog43+car' -- Consulta al host


-- FUNCIÓN PARA ESCRIBIR TEXTO EN PANTALLA
local function write_text(text)
  canvas:attrFont("Tiresias", 20, "normal")
  canvas:attrColor('green') 
  canvas:drawText(5,5,text)
  canvas:flush()
end

-- FUNCION PARA ESCRIBIR EL RESULTADO EN EL PANEL
local dx, dy = canvas:attrSize()
function redraw (text)
	canvas:attrColor('black')
	canvas:drawRect('fill', 0,0, 1000,120)
	
	write_text(text)
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
        
        -- Consulta HTTP a host
        tcp.execute(
            function ()
	           tcp.connect(HOST, 80)
	           tcp.send('GET http://www2.elo.utfsm.cl/~elo323/tweet/settweet.php?search=%40MonsterEnergy+'..TEXT)
	           tcp.send('\r\n')
	      
	           result = tcp.receive()
	      
	           if result then
	           		-- Obtención de texto twitteado
	               	_,_,answer = string.find(result, "<tweet>(.*)</tweet>")       
	            else
	              	answer = 'error, intente de nuevo.'
	           end
	           
	           canvas:clear()	-- limpear pantalla de textos anteriores (varias consultas) 
	           write_text('Tweet: '..answer)
	           
	           tcp.disconnect()
	      
	           end
          )
        
      end
    end
  end
end

event.register(handler)

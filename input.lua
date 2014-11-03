-- INPUT PART
text = nil
local TEXT = '' -- ESTE ES EL PARAMETRO QUE SE TRANSMITEN ENTRE APLICACIONES LUA, ES EL CONTENIDO DE LO ESCRITO
local CHAR = '' -- PARAMETRO PARA REPRESENTAR EL CARACTER

local KEY, IDX = nil, -1

-- VARIABLE TIPO MAP PARA INTERPRETAR NUMEROS CON LETRAS (ES LIBRE DE MODIFICARLO EN LA APLICACION)
-- KEY=llave -> se asocia a los numeros
-- IDX=index -> se asocia al index de cada llave
-- Ej: KEY '4', index 1, es el caracter 'h' (index 0 es 'g')
local MAP = {
	  ['1'] = { '1', '.', ',' }
	, ['2'] = { 'a', 'b', 'c', '2' }
	, ['3'] = { 'd', 'e', 'f', '3' }
	, ['4'] = { 'g', 'h', 'i', '4' }
	, ['5'] = { 'j', 'k', 'l', '5' }
	, ['6'] = { 'm', 'n', 'o', '6' }
	, ['7'] = { 'p', 'q', 'r', 's', '7' }
	, ['8'] = { 't', 'u', 'v', '8' }
	, ['9'] = { 'w', 'x', 'y', 'z', '9' }
	, ['0'] = { '0' }
}

-- PARA UTILIZACION DE MAYUSCULAS
local UPPER = false
local case = function (c)
	return (UPPER and string.upper(c)) or c
end

-- FUNCION PARA ESCRIBIR EL RESULTADO EN EL PANEL
local dx, dy = canvas:attrSize()
canvas:attrFont('vera', 3*dy/4)
function redraw ()
	canvas:attrColor('white')
	canvas:drawRect('fill', 0,0, dx,dy)

	canvas:attrColor('white')
	canvas:drawText(0,0, TEXT..case(CHAR)..'|')

	canvas:flush()
end

-- SE CREA ESTRUCTURA evt PARA TRASPASO DE PAREMTROS EN NCL
local evt = {
    class = 'ncl',
    type  = 'attribution',
    name  = 'text',
}

-- FUNCION PARA VALIDA AL TECLEAR SELECT(ENTER)
local function setText (new, outside)
	TEXT = new or TEXT..case(CHAR)
	text = TEXT
	CHAR, UPPER = '', false
	KEY, IDX = nil, -1

	-- Para valida a NCL, se cambia el estado de evt.
	if not outside then
		evt.value = TEXT
		evt.action = 'start'; event.post(evt)
		evt.action = 'stop';  event.post(evt)
	end
end

-- TEMPO PARA VALIDAR TECLA
-- Ejemplo: si apreta 1 vez 1 el caracter es 'a', 
-- ahora, si apreta dos veces 1 en menos de 1000 ms se considera como caracter 'b' y 3 veces 'c'
local TIMER = nil
local function timeout ()
	return event.timer(1000,
		function()
			if KEY then
				setText()
			end
		end)
end

-- FUNCION PRINCIPAL
local function nclHandler (evt)
	if evt.class ~= 'ncl' then return end

	if evt.type == 'attribution' then -- Cuando se apreta una tecla
		if evt.name == 'text' then
			setText(evt.value, true) -- Funcion para interpretar el uso de botones
		end
	end

	redraw()
	return true
end
event.register(nclHandler)

local sel = {
    class = 'ncl',
    type  = 'presentation',
    label = 'select',
}

-- FUNCION PARA INTERPRETAR EL USO DE TECLAS.
local function keyHandler (evt)
	if evt.class ~= 'key' then return end
	if evt.type ~= 'press' then return true end
	local key = evt.key

	-- SELECT
	if (key == 'ENTER') then
		setText()
		sel.action = 'start'; event.post(sel)
		sel.action = 'stop';  event.post(sel)

	-- BACKSPACE (borrar con flecha derecha)
	elseif (key == 'CURSOR_LEFT') then
		setText( (KEY and TEXT) or string.sub(TEXT, 1, -2) )

	-- UPPER (mayuscula con flecha arriba)
	elseif (key == 'CURSOR_UP') then
		UPPER = not UPPER

	-- SPACE  (Espacio con flecha derecha)
	elseif (key == 'CURSOR_RIGHT') then
		setText( (not KEY) and (TEXT..' ') )

	-- NUMBER (Interpretador de numeros)
	elseif _G.tonumber(key) then
		if KEY and (KEY ~= key) then -- si la tecla no se repite (ej: 2 veces tecla 1)
			setText() -- se escribe el caracter en el texto
		end
		-- Caso en que la tecla de repita
		IDX = (IDX + 1) % #MAP[key] --aumenta el index de la llave utilizada
		CHAR = MAP[key][IDX+1] -- se cambia el caracter a interpretar
		KEY = key  --Se guarda la ultima key para verificar posteriores repeticiones
	end

	-- Tiempo para considerar repeticiones de teclas
	if TIMER then TIMER() end
	TIMER = timeout()
	
	-- Escritura del texto
	redraw()
	return true
end
event.register(keyHandler)

-- TWEETER CONNECTION --

-- Utiliza las funciones de tcp.lua que implementa el modulo tcp propio de lua
require 'tcp'

local HOST = 'www2.elo.utfsm.cl' --Host a conectarse
local url = '~elo323/tweet/settweet.php?search=%40kblog43%20' --Pagina solicitada(Pag ejemplo tarea 2013)
local result = ''  --Resultado html de la busqueda
local question = ''

--background
canvas:attrColor('navy')
canvas:clear()

canvas:attrFont("Tiresias", 20, "normal") -- Se asignan sitintos tipos de letras con disitntos tamaños
canvas:attrColor('white') -- Se define el color de todo lo que se dibuje/escriba

-- Implementa dentro de las funciones que tiene tcp.lua
 tcp.execute(
        function ()
			tcp.connect(HOST, 80)
			tcp.send('GET '..url..' HTTP/1.1\r\n')
			tcp.send('Host: '..HOST..'\r\n')
			tcp.send('\r\n')
			
			result = tcp.receive()
			
			-- En caso de existir resultado
			if result then
				_,_,question = string.find(result, "<tweet>(.*)</tweet>") -- Busca resultado entre backets
	        else
		        result = 'error: '
	        end
			-- La asignacion de estos parametros solo tiene valor dentro de la funcion
			--canvas:drawText(30,200,'resultado: '..result)
			canvas:drawText(30,380,'Pregunta: '..question)
			canvas:flush() 
			tcp.disconnect()
		end
)

-- Escritura adicional
canvas:drawText(30,80,'HOST: '..HOST)
canvas:drawText(30,120,'url: '..url)

-- flush
canvas:flush()

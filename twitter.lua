local TEXT = '' --Variable a compartir

-- MOSTRANDO EL CONTENIDO
local dx, dy = canvas:attrSize()
canvas:attrFont('vera', 3*dy/4)
function redraw ()
	canvas:attrColor('black')
	canvas:drawRect('fill', 0,0, dx,dy)

	canvas:attrColor('white')
	canvas:drawText(0,0, TEXT)

	canvas:flush()
end

-- 	FUNCION PRINCIPAL
local function handler (evt)
	if evt.class ~= 'ncl' then return end
	
	-- Identifica el evento correcto
	if evt.type == 'attribution' then
		if evt.name == 'text' then
			if evt.action == 'start' then
				TEXT = evt.value -- Toma el valor de NCL
				evt.action = 'stop' -- Avisa que lo leyo cambiando el parametro action
				event.post(evt) -- Entre la clase evt modificado a NCL
			end
		end
	end

	redraw()
end

event.register(handler)

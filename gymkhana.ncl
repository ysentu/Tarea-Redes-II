<ncl id="myNCLDocID" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<connectorBase id="connBaseId">
			
			<importBase alias="conn" documentURI="defaultConnBase.ncl">
			</importBase>
			
			<!-- INGRESO DE TEXTO -->
			<causalConnector id="onBeginStart">
				<simpleCondition role="onBegin"/>
				<simpleAction role="start" max="unbounded"/>
			</causalConnector>
			
			<!-- PARA EL TRASPASO POR CADA ESCRITURA -->
			<causalConnector id="onEndAttributionSet">
				<connectorParam name="var"/>
				<simpleCondition role="onEndAttribution"/>
				<simpleAction role="set" value="$var"/>
			</causalConnector>	
			
			<!-- ANIMACION -->
			<causalConnector id="onKeySelectionSet">
				<connectorParam name="keyCode"/>
				<connectorParam name="var"/>
				<simpleCondition role="onSelection" key="$keyCode"/>
				<simpleAction role="set" value="$var"/>
			</causalConnector>	
	
		</connectorBase>
		
		<!--REGIONES-->
		<regionBase id="regionBase0">
			<region height="100.00%" id="screen" left="0.00%" top="0.00%" width="100.00%" zIndex="1">
				<region height="66.46%" id="video" left="0.00%" top="0.00%" width="71.66%" zIndex="2">
				</region>
				<region height="66.46%" id="r_instrucciones" left="71.55%" top="0.00%" width="28.45%" zIndex="3">
					<region height="17.55%" id="instruccion_1" left="6.58%" top="10.03%" width="87.24%" zIndex="6">
					</region>
					<region height="14.11%" id="red_button" left="36.63%" top="30.09%" width="19.75%" zIndex="7">
					</region>
					<region height="25.39%" id="instruccion_2" left="6.58%" top="47.65%" width="86.83%" zIndex="8">
					</region>
					<region height="14.73%" id="ok_button" left="37.04%" top="76.80%" width="21.40%" zIndex="9">
					</region>
				</region>
				<region height="11.67%" id="r_busqueda" left="0.00%" top="65.83%" width="100.00%" zIndex="4">
					<region id="rgInput" top="5%" height="90%" left="12%" width="81%" zIndex="10">						
					</region>
					<region height="100.00%" id="regLua" left="93%" top="0.00%" width="7%" zIndex="11">
					</region>
				</region>
				<region height="22.71%" id="r_resultados" left="0.00%" top="77.29%" width="100.00%" zIndex="5">
				</region>
			</region>
		</regionBase>
		
		<!--DESCRIPTORES-->
		<descriptorBase id="descriptorBase1">
			<descriptor id="region_video" region="video">
			</descriptor>
			<descriptor id="fondo" region="r_instrucciones">
			</descriptor>
			<descriptor id="instruc_1" region="instruccion_1">
				<descriptorParam name="fontFamily" value="Tiresias"/>
				<descriptorParam name="fontSize" value="18"/>
				<descriptorParam name="fontWeight" value="normal"/>
				<descriptorParam name="fontColor" value="red"/>
			</descriptor>
			<descriptor id="instruc_2" region="instruccion_2">
				<descriptorParam name="fontFamily" value="Tiresias"/>
				<descriptorParam name="fontSize" value="18"/>
				<descriptorParam name="fontWeight" value="normal"/>
				<descriptorParam name="fontColor" value="red"/>
			</descriptor>
			<descriptor id="boton_rojo" region="red_button">
			</descriptor>
			<descriptor id="boton_ok" region="ok_button">
			</descriptor>
			<descriptor id="fondo_busqueda" region="r_busqueda">
			</descriptor>
			<descriptor id="fondo_resultados" region="r_resultados">
			</descriptor>
			<descriptor id="audio">				
			</descriptor>
			<descriptor id="dsInput"   region="rgInput" focusIndex="inputIdx"/>
			<descriptor id="cargando" region="regLua" />
			<descriptor id="descTwitter" region="r_resultados"/>
		</descriptorBase>
		
	</head>
	
	<body id="myBodyID">
		
		
		<!--CONTENIDOS-->
		<media descriptor="region_video" id="gymkhana" src="media/gymkhana.mp4">
		</media>
		<media descriptor="audio" id="gymkhana_audio" src="media/gymkhana_audio.mp3">
		</media>
		<media descriptor="fondo" id="background" src="media/background.jpg">
		</media>
		<media descriptor="instruc_1" id="instruccion1" src="media/instruccion1.txt">
		</media>
		<media descriptor="instruc_2" id="instruccion2" src="media/instruccion2.txt">
		</media>
		<media descriptor="boton_ok" id="ok" src="media/ok.png">
		</media>
		<media descriptor="boton_rojo" id="red" src="media/red.png">
		</media>
		<media descriptor="fondo_busqueda" id="cuadro_busqueda" src="media/cuadro_busqueda.png">
		</media>
		<media descriptor="fondo_resultados" id="cuadro_resultado" src="media/cuadro_resultado.png">
		</media>
		
		
		<!-- PARA HABILITAR EL USO DEL TECLADO EN GINGA -->
		<media type="application/x-ginga-settings" id="programSettings">
  	      <property name="service.currentKeyMaster" value="inputIdx"/>
		</media>


		<!-- CODIGOS LUA -->
		<media id="input" src="input.lua"  descriptor="dsInput">
			<area id="select"/>
    	    <property name="text"/>
		</media>
		
		<media id="twitter" src="twitter.lua" descriptor="descTwitter">
			<property name="text"/>
		</media>
		
		<media id="loading" src="loading.lua" descriptor="cargando" >
			<property name="state"/>
		</media>
		
		
		<!-- PARA INICIALIZAR LOS PANELES -->
    	<link xconnector="onBeginStart">
			<bind role="onBegin" component="input"/>
			<bind role="start"   component="twitter"/>
	    </link>
	    
	    
	    <!-- CASO EN QUE SE ESCRIBA ALGUN CARACTE SE COPIA EL TEXTO -->
		<link xconnector="onBeginSet">
			<!-- Cada vez que se sete select(ENTER), el codigo LUA de input lo hablita como start para la interpretacion de "onBegin" en NCL -->
			<bind role="onBegin" component="input" interface="select"/> 
			<bind role="set" component="twitter" interface="text">  <!-- Se setea un parametro de otro codigo ($get) -->
				<bindParam name="var" value="$get"/>
			</bind>
			<bind role="get" component="input" interface="text"/> <!-- Ese parametro corresponde al atributo text contenido en input -->
		</link>
	    
	    <!-- CASO BOTON VERDE -->
			<link xconnector="onKeySelectionSet">
				<linkParam name="keyCode" value="RED"/>
				<bind role="onSelection" component="gymkhana"  />
				<bind role="onBegin" component="input"/>
				<bind role="set" component="loading" interface="state" >
					<bindParam name="var" value="start"/>
				</bind>
			</link>
 
		<!-- CASO BOTON ROJO -->
			<link xconnector="onKeySelectionSet">
				<linkParam name="keyCode" value="GREEN"/>
				<bind role="onSelection" component="gymkhana"  />
				<bind role="set" component="loading" interface="state" >
					<bindParam name="var" value="stop"/>
				</bind>
			</link> 
		
		
		<!--START-->
		<port id="START" component="gymkhana"/>
		<port id="entryPoint" component="input"/>
		<port id="p0" component="loading"/>
		
		
		<!--RELACIONES ENTRE CONTENIDOS-->
		<link id="start_audio" xconnector="conn#onBeginStart">
			<bind component="gymkhana" role="onBegin">
			</bind>
			<bind component="gymkhana_audio" role="start">
			</bind>
		</link>
		<link id="end_audio" xconnector="conn#onEndStop">
			<bind component="gymkhana" role="onEnd">
			</bind>
			<bind component="gymkhana_audio" role="stop">
			</bind>
		</link>

		<link id="mostrar_red" xconnector="conn#onBeginStart">
			<bind component="background" role="onBegin">
			</bind>
			<bind component="red" role="start">
			</bind>
		</link>
		<link id="mostrar_ins1" xconnector="conn#onBeginStart">
			<bind component="background" role="onBegin">
			</bind>
			<bind component="instruccion1" role="start">
			</bind>
		</link>
		<link id="mostrar_ok" xconnector="conn#onBeginStart">
			<bind component="background" role="onBegin">
			</bind>
			<bind component="ok" role="start">
			</bind>
		</link>
		<link id="mostrar_ins2" xconnector="conn#onBeginStart">
			<bind component="background" role="onBegin">
			</bind>
			<bind component="instruccion2" role="start">
			</bind>
		</link>
		<link id="mostrar_instrucciones" xconnector="conn#onBeginStart">
			<bind component="gymkhana" role="onBegin">
			</bind>
			<bind component="background" role="start">
			</bind>
		</link>
		<link id="mostrar_cuadro_resultados" xconnector="conn#onBeginStart">
			<bind component="gymkhana" role="onBegin">
			</bind>
			<bind component="cuadro_resultado" role="start">
			</bind>
		</link>
		<link id="mostrar_cuadro_busqueda" xconnector="conn#onBeginStart">
			<bind component="gymkhana" role="onBegin">
			</bind>
			<bind component="cuadro_busqueda" role="start">
			</bind>
		</link>
	</body>
</ncl>

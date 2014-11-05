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
			
			<!-- PARA EL TRASPASO APRETANDO TECLA ENTER -->
			<causalConnector id="onBeginSet">
				<connectorParam name="var"/>
				<simpleCondition role="onBegin"/>
				<simpleAction role="set" value="$var"/>
			</causalConnector>
			
		</connectorBase>
		
		<!--REGIONES-->
		<regionBase id="regionBase0">
			<region height="100.00%" id="screen" left="0.00%" top="0.00%" width="100.00%" zIndex="1">
				<region height="66%" id="video" left="0.00%" top="0.00%" width="72%" zIndex="2">
				</region>
				<region height="66%" id="r_instrucciones" left="72%" top="0.00%" width="28%" zIndex="2">
					<region height="30%" id="r_banner" left="5%" top="0%" width="90%" zIndex="3">
					</region>
					<region height="17.55%" id="instruccion_1" left="6.58%" top="32.03%" width="87.24%" zIndex="4">
					</region>
					<region height="12%" id="red_button" left="36.63%" top="50.09%" width="15%" zIndex="3">
					</region>
					<region height="25.39%" id="instruccion_2" left="6.58%" top="62.65%" width="86.83%" zIndex="4">
					</region>
					<region height="12%" id="ok_button" left="37.04%" top="85.80%" width="19%" zIndex="3">
					</region>
				</region>
				<region height="12%" id="r_busqueda" left="0.00%" top="66%" width="100.00%" zIndex="2">
					<region id="rgInput" top="5%" height="90%" left="12%" width="81%" zIndex="3">						
					</region>
					<region height="50.00%" id="regLoading" left="94%" top="25.00%" width="6%" zIndex="3">
					</region>
				</region>
				<region height="22%" id="r_resultados" left="0.00%" top="78%" width="100.00%" zIndex="2">
					<region height="76.00%" id="respuesta" left="2%" top="13.00%" width="96%" zIndex="3">
					</region>
				</region>
			</region>
		</regionBase>
		
		<!--DESCRIPTORES-->
		<descriptorBase id="descriptorBase1">
			<descriptor id="region_video" region="video">
			</descriptor>
			<descriptor id="fondo" region="r_instrucciones">
			</descriptor>
			<descriptor id="d_banner" region="r_banner">
			</descriptor>
			<descriptor id="instruc_1" region="instruccion_1">
				<descriptorParam name="fontFamily" value="Tiresias"/>
				<descriptorParam name="fontSize" value="18"/>
				<descriptorParam name="fontWeight" value="normal"/>
				<descriptorParam name="fontColor" value="green"/>
			</descriptor>
			<descriptor id="instruc_2" region="instruccion_2">
				<descriptorParam name="fontFamily" value="Tiresias"/>
				<descriptorParam name="fontSize" value="18"/>
				<descriptorParam name="fontWeight" value="normal"/>
				<descriptorParam name="fontColor" value="green"/>
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
			<descriptor id="cargando" region="regLoading" />
			<descriptor id="descTwitter" region="respuesta"/>
		</descriptorBase>
		
	</head>
	
	<body id="myBodyID">
		
		<!--CONTENIDOS-->
		<media descriptor="region_video" id="gymkhana" src="media/gymkhana.mp4">
		</media>
		<media descriptor="audio" id="gymkhana_audio" src="media/gymkhana_audio.mp3">
		</media>
		<media descriptor="fondo" id="background" src="media/fondo.jpg">
		</media>
		<media descriptor="d_banner" id="m_banner" src="media/banner.jpg">
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
		<media descriptor="fondo_resultados" id="cuadro_resultado" src="media/fondo.jpg">
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
		
		
		<!-- PARA INICIALIZAR PANEL ESCRITURA Y TWITTER -->
    	<link xconnector="onBeginStart">
			<bind role="onBegin" component="input"/>
			<bind role="start"   component="twitter"/>
	    </link>
	    
	    <!-- CASO EN QUE SE ESCRIBA ALGUN CARACTER SE COPIA EL TEXTO -->
		<link xconnector="onBeginSet">
			<!-- Cada vez que se sete select(ENTER), el codigo LUA de input lo hablita como start para la interpretacion de "onBegin" en NCL -->
			<bind role="onBegin" component="input" interface="select"/> 
			<bind role="set" component="twitter" interface="text">  <!-- Se setea un parametro de otro codigo ($get) -->
				<bindParam name="var" value="$get"/>
			</bind>
			<bind role="get" component="input" interface="text"/> <!-- Ese parametro corresponde al atributo text contenido en input -->
		</link>
	    
	    <!-- INICIAR ANIMACION AL INGRESAR BUSQUEDA -->
	    <link xconnector="onBeginSet">
	    	<bind role="onBegin" component="input" interface="select"/>
				<bind role="set" component="loading" interface="state" >
					<bindParam name="var" value="start"/>
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
		<link id="mostrar_banner" xconnector="conn#onBeginStart">
			<bind component="background" role="onBegin">
			</bind>
			<bind component="m_banner" role="start">
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

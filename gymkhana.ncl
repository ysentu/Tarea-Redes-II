<ncl id="myNCLDocID" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<connectorBase id="connBaseId">
			<importBase alias="conn" documentURI="defaultConnBase.ncl">
			</importBase>
		</connectorBase>
		<regionBase id="regionBase0">
			<region height="100.00%" id="screen" left="0.00%" top="0.00%" width="100.00%" zIndex="1">
				<region height="66.46%" id="video" left="0.00%" top="0.00%" width="71.66%" zIndex="2">
				</region>
				<region height="66.46%" id="r_instrucciones" left="71.55%" top="0.00%" width="28.45%" zIndex="3">
					<region height="25.39%" id="banner" left="6.58%" top="0%" width="90%" zIndex="8">
					</region>
					<region height="17.55%" id="instruccion_1" left="6.58%" top="30%" width="87.24%" zIndex="6">
					</region>
					<region height="15%" id="red_button" left="20%" top="70%" width="20%" zIndex="7">
					</region>
					<region height="15%" id="ok_button" left="60%" top="70%" width="20%" zIndex="9">
					</region>
				</region>
				<region height="8.54%" id="r_busqueda" left="0.00%" top="65.83%" width="100.00%" zIndex="4">
					<region height="100.00%" id="r_espera" left="92.97%" top="0.00%" width="7.03%" zIndex="10">
					</region>
				</region>
				<region height="25%" id="r_resultados" left="0.00%" top="77.29%" width="100.00%" zIndex="5">
				</region>
			</region>
		</regionBase>
		<descriptorBase id="descriptorBase1">
			<descriptor id="region_video" region="video">
			</descriptor>
			<descriptor id="fondo" region="r_instrucciones">
			</descriptor>
			<descriptor id="instruc_1" region="instruccion_1">
			</descriptor>
			<descriptor id="d_banner" region="banner">
			</descriptor>
			<descriptor id="boton_rojo" region="red_button">
			</descriptor>
			<descriptor id="boton_ok" region="ok_button">
			</descriptor>
			<descriptor id="fondo_busqueda" region="r_busqueda">
			</descriptor>
			<descriptor id="fondo_resultados" region="r_resultados">
			</descriptor>
		</descriptorBase>
	</head>
	<body id="myBodyID">
		<media descriptor="region_video" id="gymkhana" src="media/gymkhana.mp4">
		</media>
		<media id="gymkhana_audio" src="media/gymkhana_audio.mp3">
		</media>
		
		<port component="gymkhana" id="START">
		</port>
		
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
		
		<media descriptor="fondo" id="background" src="media/fondo.jpg">
		</media>
		<media descriptor="instruc_1" id="instruccion1" src="media/instruccion1.txt">
		</media>
		<media descriptor="d_banner" id="m_banner" src="media/banner.jpg">
		</media>
		<media descriptor="boton_ok" id="ok" src="media/ok.png">
		</media>
		<media descriptor="boton_rojo" id="red" src="media/red.png">
		</media>
		
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
		<link id="mostrar_banner" xconnector="conn#onBeginStart">
			<bind component="background" role="onBegin">
			</bind>
			<bind component="m_banner" role="start">
			</bind>
		</link>
		<link id="mostrar_instrucciones" xconnector="conn#onBeginStart">
			<bind component="gymkhana" role="onBegin">
			</bind>
			<bind component="background" role="start">
			</bind>
		</link>
		
		<media descriptor="fondo_busqueda" id="cuadro_busqueda" src="media/cuadro_busqueda.png">
		</media>
		<media descriptor="fondo_resultados" id="cuadro_resultado" src="media/fondo.jpg">
		</media>
		
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

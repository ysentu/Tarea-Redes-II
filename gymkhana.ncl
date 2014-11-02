<ncl id="myNCLDocID">
	<head>
		<connectorBase id="connBaseId">
			<importBase alias="conn" documentURI="defaultConnBase.ncl">
			</importBase>
		</connectorBase>
		<regionBase id="regionBase0">
			<region height="100.00%" id="screen" left="0.00%" top="0.00%" width="100.00%" zIndex="1">
				<region bottom="33.54%" height="66.46%" id="video" left="0.00%" right="28.34%" top="0.00%" width="71.66%" zIndex="2">
				</region>
				<region bottom="33.54%" height="66.46%" id="r_instrucciones" left="71.55%" right="0.00%" top="0.00%" width="28.45%" zIndex="3">
				</region>
				<region bottom="22.50%" height="11.67%" id="r_busqueda" left="0.00%" right="0.00%" top="65.83%" width="100.00%" zIndex="4">
				</region>
				<region bottom="0.00%" height="22.71%" id="r_resultados" left="0.00%" right="0.00%" top="77.29%" width="100.00%" zIndex="5">
				</region>
			</region>
		</regionBase>
		<descriptorBase id="descriptorBase1">
			<descriptor id="region_video" region="video">
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
	</body>
</ncl>

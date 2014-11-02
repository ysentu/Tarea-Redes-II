<ncl id="myNCLDocID" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<connectorBase id="connBaseId">
			<importBase alias="conn" documentURI="defaultConnBase.ncl">
			</importBase>
		</connectorBase>
		<regionBase id="regionBase0">
			<region height="100.00%" id="screen" left="0.00%" top="0.00%" width="100.00%" zIndex="1">
				<region bottom="31.67%" height="68.33%" id="video" left="0.00%" right="20.14%" top="0.00%" width="79.86%" zIndex="2">
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
		<port component="gymkhana" id="p0">
		</port>
		<link id="link0" xconnector="conn#onBeginStart">
			<bind component="gymkhana" role="onBegin">
			</bind>
			<bind component="gymkhana_audio" role="start">
			</bind>
		</link>
	</body>
</ncl>

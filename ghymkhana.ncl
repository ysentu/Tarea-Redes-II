<ncl id="myNCLDocID" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<connectorBase id="connBaseId">
			<importBase alias="conn" documentURI="defaultConnBase.ncl">
			</importBase>
		</connectorBase>
		<regionBase id="regionBase0">
			<region height="100.00%" id="screen" left="0.00%" top="0.00%" width="100.00%" zIndex="1">
			</region>
			<region bottom="24.58%" height="75.21%" id="video" left="0.12%" right="21.90%" top="0.21%" width="77.99%" zIndex="2">
			</region>
		</regionBase>
		<descriptorBase id="descriptorBase1">
			<descriptor id="region_video" region="video">
			</descriptor>
		</descriptorBase>
	</head>
	<body id="myBodyID">
		<media descriptor="region_video" id="GYMKHANA" src="media/KEN BLOCK'S GYMKHANA FIVE.mp4">
		</media>
		<port component="GYMKHANA" id="p0">
		</port>
	</body>
</ncl>

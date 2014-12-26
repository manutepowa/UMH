<?xml version="1.0"?>
<xsl:stylesheet version = "1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Aplicar la plantilla a la raiz -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Aplicar la plantilla de cuestionario
	Es decir todo lo que hay por debajo del nodo cuestionario -->
	<xsl:template match="cuestionario">
		<html>
			<head>
				<title>Cuestionario</title>
				<link rel="stylesheet" href="cuestionario.css" media="screen" /> 
			</head>
				<body>
					<h1>Cuestionario de TW </h1>
					<xsl:apply-templates/>
				</body>
		</html>
	</xsl:template>	

	<!-- Aqui selecciona un unico tema y
	 aplicando todo lo que tiene por debajo dicho elemento -->
	<xsl:template match="tema">

		<xsl:choose>
			<xsl:when test='@nombre="programacion"'>
					<h2>Cuestionario de <xsl:value-of select='@nombre'/></h2>
					<xsl:apply-templates/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>  


	<xsl:template match="cuestion">
			<div class="pregunta">
			<xsl:apply-templates/>
			</div>
		<xsl:choose>
			<!-- tipo es un atributo de cuestion -->
			<xsl:when test='( @varias="si" ) and (@tipo="Codificada")'>

						<xsl:for-each select="respuesta">
							<div class="respuesta">
							<p><input type="checkbox" name="check" value="check"/><xsl:apply-templates/></p>
							</div>
						</xsl:for-each>
			</xsl:when>
			
			<xsl:when test='( @varias="no" ) and ( @tipo="Codificada" )'>
				<xsl:for-each select="respuesta">
					<div class="respuesta">
					<p><input type="radio" name="radios" value="radios"/><xsl:apply-templates/></p>
					</div>
				</xsl:for-each>
			</xsl:when>
		
			<!-- Minimo y Maximo en el tipo Numerico se tiene que cojer
			del XML por lo tanto nos tenemos que crear dos variables y asignarselas
			a los valores que estan el XML -->
			<xsl:when test='@tipo="Numerica"'>
				<xsl:variable name="mini" select="@minimo"/>
				<xsl:variable name="maxi" select="@maximo"/>
				<div id="numerica">
				<input type="number" name="numero" min="{$mini}" max="{$maxi}"/>
				</div>
			</xsl:when>


			<xsl:when test='@tipo="Logica"'>
				<xsl:for-each select="respuesta">
					<div class="respuesta">
					<p><input type="radio" name="radioL" value="radioL"/><xsl:apply-templates/></p>
					</div>
				</xsl:for-each>
			</xsl:when>

			<!-- El text area tiene el mismo concepto que numerica donde los
			valores de columnas y filas los tiene que tomar del XML creando 
			dos variables que se le asignan los atributos del elemento TextoArea-->
			<xsl:when test='@tipo="TextoLibre"'>
				<xsl:variable name="fila" select="@filas"/>
				<xsl:variable name="columna" select="@columnas"/>
				<textarea class="text" name="areaTexto" rows="{$fila}" cols="{$columna}"></textarea>
			</xsl:when>			
		</xsl:choose>
	</xsl:template>

			<xsl:template match="enunciado">
				<!-- Se utiliza para los nodos hojas 
				es decir para las ultimas etiquetas que contienen texto-->
				<h3><xsl:value-of select="."/></h3> 
			</xsl:template>

			<xsl:template match="respuesta">
				<!-- -->
			</xsl:template>

</xsl:stylesheet>
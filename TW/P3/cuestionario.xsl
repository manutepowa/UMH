<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="cuestionario">
		<html>
			<head>
				<title>Cuestionario Manuel Tercero</title>
				<link rel="stylesheet" href="cuestionario.css"/>
			</head>
			<body>
				<h1>Cuestionario de Manuel</h1>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>

	<!-- Empieza la definicion de la página -->

	<xsl:template match="tema">
		<xsl:choose>
			<xsl:when test="@nombre='linux'">
				<div class="tema">
					<h2><xsl:value-of select="@nombre"/></h2>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
		</xsl:choose>		
	</xsl:template>

	<xsl:template match="cuestion">
		<div class="cuestion">
			<!-- Para que meta la fecha, autor... -->
			<xsl:apply-templates/>
			<xsl:choose>
				<xsl:when test="@tipo='codificada'">
					<xsl:choose>
						<xsl:when test="@varias='si'">
							<xsl:for-each select="respuesta">
								<p><input type="checkbox" name="respuesta" /><xsl:value-of select="."/></p>
							</xsl:for-each>
						</xsl:when>

						<xsl:when test="@varias='no'">
							<xsl:for-each select="respuesta">
								<p><input type="radio" name="respuesta" /><xsl:value-of select="."/></p>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="@tipo='numerica'">
					<xsl:variable name="min" select="@minimo"/>
					<xsl:variable name="max" select="@maximo"/>

					<p><input type="number" min="{$min}" max="{$max}"/></p>
				</xsl:when>
				<xsl:when test="@tipo='logica'">
					<xsl:for-each select="respuesta">
						<p><input type="radio" name="trueorfalse"/><xsl:value-of select="."/></p>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="@tipo='texto'">
					<xsl:variable name="filas" select="@filas"/>
					<xsl:variable name="columnas" select="@columnas"/>
					<textarea name="text" cols="{$columnas}" rows="{$filas}" scroll="no"></textarea>
				</xsl:when>
			</xsl:choose>
		</div>
	</xsl:template>

	<xsl:template match="enunciado">
		<p class="enunciado">
			<xsl:value-of select="."/>
		</p>
	</xsl:template>
	<xsl:template match="fecha">
		<p class="fecha">
			<xsl:value-of select="."/>
		</p>
	</xsl:template>
	<xsl:template match="autor">
		<p class="autor">
			<xsl:value-of select="."/>
		</p>
	</xsl:template>
	<xsl:template match="respuesta">
		<!-- <xsl:apply-templates/> -->
	</xsl:template>
</xsl:stylesheet>


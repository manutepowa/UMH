<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">

	   <xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="cuestionario">
		<html>
			<head>
				<link rel="stylesheet" href="miestilo.css"/>
				<title>Cuestionario | Angel</title>
			</head>
			<body>
				<h1>Cuestionario de Angel</h1>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="tema">
		<xsl:choose>
			<xsl:when test="@nombre='informatica'">
				<div class="tema">
					<h2><xsl:value-of select="@nombre"/></h2>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="cuestion">
		<div class="cuestion">
			<xsl:apply-templates/>
			<xsl:choose>
				<xsl:when test="@tipo = 'codificada'">
					<xsl:choose>
						<xsl:when test="@varias = 'si'">
							<xsl:for-each select="respuesta">
								<p><input type="checkbox" name="respuesta"/><xsl:value-of select="."/></p>
							</xsl:for-each>

						</xsl:when>
						<xsl:when test="@varias = 'no'">
							<xsl:for-each select="respuesta">
								<p><input type="radio" name="respuesta"/><xsl:value-of select="."/></p>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="@tipo = 'numerica'">
					<xsl:variable name="min" select="@min"/>
					<xsl:variable name="max" select="@max"/>
					<xsl:for-each select="respuesta">
						<p><input type="number" min="{$min}" max="{$max}"/></p>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="@tipo = 'logica'">
					<xsl:for-each select="respuesta">
						<p><input type="radio" name="vof" value="radio"/><xsl:value-of select="."/></p>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="@tipo = 'texto'">
					<xsl:variable name="filas" select="@filas"/>
					<xsl:variable name="columnas" select="@columnas"/>
					<textarea name="text" cols="{$columnas}" rows="{@filas}" scroll="yes"></textarea>
				</xsl:when>
		</xsl:choose>
		</div>
	</xsl:template>

	<xsl:template match="fecha">
		<p>
			<xsl:value-of select="."/>
		</p>
	</xsl:template>

	<xsl:template match="autor">
		<p>
			<xsl:value-of select="."/>
		</p>
	</xsl:template>

	<xsl:template match="enunciado">
		<p class="enunciado">
			<xsl:value-of select="."/>
		</p>
	</xsl:template>

	<xsl:template match="respuesta">
		<!-- <xsl:apply-templates/> -->
	</xsl:template>
	
</xsl:stylesheet>
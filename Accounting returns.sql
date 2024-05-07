--PARA ANÁLISIS DE RENDICIONES (filtrando cuenta contable peruana según GAAP Perú)

SELECT A.DEX_ROW_ID AS Linea
		, A.ORDOCNUM AS Numero_Doc
		,D.Grupo_1
		,D.Grupo_2
		,D.Grupo_3
		, B.ACTNUMBR_1 Cuenta
		,B.ACTDESCR AS Desc_cuenta
		,A.ORMSTRID AS RUC
		, A.ORMSTRNM AS Nombre_Prov
		,JRNENTRY AS Asiento
		,ORPSTDDT AS Fecha_rendición
		,TRXDATE AS Fecha_Transacción
		,REFRENCE AS Glosa1
		,dscriptn Glosa2
		,CRDTAMNT-debitamt AS Monto_PEN
		, ORDBTAMT AS DEB_ORIGINAL
		, ORCRDAMT AS CRED_ORIGINAL
		,CURNCYID AS MONEDA 
		,A.PERIODID AS MES
		,YEAR(TRXDATE) AS AÑO
		,year(trxdate)*100+month(trxdate) IdTiempo
FROM dbo.GL30000 AS A, dbo.GL00100 AS B, dbo.GL00105 AS C
,(select grupo_1,grupo_2,grupo_3,id_cuenta from gestion.[dbo].[agrupacion_cuentas_contables] union all
select grupo_1,grupo_2,grupo_4,id_cuenta from [dbo].[agrupacion_cuentas_balance]) D
	WHERE  A.ACTINDX = B.ACTINDX
	AND A.ACTINDX = C.ACTINDX
	AND B.ACTNUMBR_1=D.ID_CUENTA COLLATE Latin1_General_CI_AS
	AND year(trxdate)=2019
	AND A.JRNENTRY 
	IN (SELECT  JRNENTRY FROM [tango\gp2016].gplpp.dbo.gl30000 GL
	INNER JOIN [tango\gp2016].gplpp.dbo.GL00100 Z ON GL.ACTINDX=Z.ACTINDX
	WHERE ACTNUMBR_1 IN ('0469900')
	and hstyear='2019' and month(trxdate)>=11
	--and ORMSTRID in ('77777777') --filtrar DNIs
	)
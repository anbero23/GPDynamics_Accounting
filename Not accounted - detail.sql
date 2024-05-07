--REPORTE DETALLADO POR EMPRESA DE TODAS SUS TRANSACC NO CONTABILIZADAS

Select 'Línea P' Empresa,a.* from (
Select 'Lotes Financieros no contabilizados' Referencia,bachnumb Lote,year(trxdate)*100+month(trxdate) IDTiempo,uswhpstd Usuario_1,lastuser Usuario_modif,trxdate Fecha,ortrxsrc Transaccion_1,DTAControlNum Documento_2
from dbo.gl10000
UNION ALL
select 'Facturas no contabilizadas' Referencia,Bachnumb Lote,year(docdate)*100+month(docdate) IDTiempo,user2ent Usuario_1,NULL,Docdate,Sopnumbe Factura,orignumb Guía
from dbo.SOP10100  WHERE SOPTYPE IN (3,4)
UNION ALL
select 'Inventario en trabajo' Referencia,Bachnumb Lote,year(docdate)*100+month(docdate) IDTiempo,ptdusrid Usuario_1,mdfusrid Usuario_modif,docdate,ivdocnbr Documento,srcrfrncnmbr OrdenProd
from dbo.IV10000
UNION ALL
Select 'Recepciones en trabajo' Referencia,Bachnumb Lote,year(receiptdate)*100+month(receiptdate) IDTiempo,user2ent Usuario_1,ptdusrid Usuario_2,posteddt Fecha_Contabilización
,poprctnm Recepción,Vnddocnm Factura
from dbo.pop10300
UNION ALL
Select 'CXC pendientes' Referencia,Bachnumb Lote,year(docdate)*100+month(docdate) IDTiempo,ptdusrid Usuario_1,lstusred Usuario_modif,docdate Fecha,docnumbr Documento,custnmbr RUC
from dbo.rm10301
UNION ALL
SELECT * FROM (
select 'CXP pendientes' Referencia,Bachnumb Lote,year(docdate)*100+month(docdate) IDTiempo,ptdusrid Usuario_1,mdfusrid Usuario_modif,docdate Fecha,docnumbr Documento,pmntnmbr Doc2
from dbo.pm10300
UNION ALL
select 'CXP No contabilizados' Referencia,Bachnumb Lote,year(docdate)*100+month(docdate) IDTiempo,ptdusrid Usuario_1,mdfusrid Usuario_modif,docdate Fecha,docnumbr Documento,pmntnmbr Doc2
from dbo.pm10400 ) A
UNION ALL
select 'Stock negativo' Referencia,null Lote,year(getdate())*100+month(getdate()) IDTiempo,null,null,getdate(),itemnmbr codigo,cast(qtyonhnd as varchar)
from dbo.iv00102 where qtyonhnd<0
) A
ORDER BY IDTIEMPO

-- CON DETALLE DE CADA LOTE SIN CONTABILIZAR POR MÓDULO
USE BD

select bachnumb Lote,year(trxdate)*100+month(trxdate) IDTiempo,uswhpstd Usuario_1,lastuser Usuario_modif,jrnentry Asiento,Sourcdoc Fuente,refrence Referencia
,trxdate Fecha,ortrxsrc Transaccion
,DTAControlNum,curncyid Moneda
from dbo.gl10000

select Bachnumb Lote,year(docdate)*100+month(docdate) IDTiempo,user2ent Usuario_1,Sopnumbe Factura,orignumb Guía,DocId,Docdate Fecha,pymtrmid CondicionPago
,Locncode Almacén,custnmbr RUC,custname Cliente,Cstponbr Pedido,slprsnid Vendedor
from dbo.SOP10100  WHERE SOPTYPE IN (3,4)

select Bachnumb Lote,year(docdate)*100+month(docdate) IDTiempo,ptdusrid Usuario_1,mdfusrid Usuario_modif,ivdocnbr Documento,docdate,srcrfrncnmbr OrdenProd
from dbo.IV10000

Select Bachnumb Lote,year(receiptdate)*100+month(receiptdate) IDTiempo,user2ent Usuario_1,ptdusrid Usuario_2,receiptdate Fecha_Documento,posteddt Fecha_Contabilización
,poprctnm Recepción,Vnddocnm Factura,vendorid RUC,Vendname Proveedor,SubTotal,Taxamnt,pymtrmid Condición_Pago
from dbo.pop10300

Select Bachnumb Lote,year(docdate)*100+month(docdate) IDTiempo,ptdusrid Usuario_1,lstusred Usuario_modif,docnumbr Documento,docdate Fecha,custnmbr RUC
,custname Cliente,slprsnid Vendedor
from dbo.rm10301

SELECT * FROM (
select Bachnumb Lote,year(docdate)*100+month(docdate) IDTiempo,ptdusrid Usuario_1,mdfusrid Usuario_modif,docnumbr Documento,docdate Fecha,pmntnmbr Doc2
,chekbkid,vendorid Vendedor
from dbo.pm10300
UNION ALL
select Bachnumb Lote,year(docdate)*100+month(docdate) IDTiempo,ptdusrid Usuario_1,mdfusrid Usuario_modif,docnumbr Documento,docdate Fecha,pmntnmbr Doc2
,chekbkid,vendorid Vendedor
from dbo.pm10400 ) A

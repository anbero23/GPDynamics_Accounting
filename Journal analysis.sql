--Análisis por asiento contable

select month(trxdate) mes,b.actnumbr_1,crdtamnt-debitamt monto,* 
from dbo.gl20000 a
left join dbo.gl00100 b
on a.actindx=b.actindx
--where jrnentry in (147863,149702)
where jrnentry in (42916,43512)

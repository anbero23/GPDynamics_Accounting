--PARA VER RESULTADO CONTABLE POR AÑO DE TODAS LAS EMPRESAS

select a.id_empresa_corp,emp.nombre empresa,year(trxdate) año,sum(crdtamnt-debitamt) monto
from CORP.view_ag_dbo_gl30000 a
left join CORP.view_ag_dbo_gl00100 b
on a.actindx=b.actindx and a.id_empresa_corp=b.id_empresa_corp
left join ska.app_smu.dbo.empresa emp on a.id_empresa_corp=emp.id_empresa
where year(trxdate)=2022 and left(b.actnumbr_1,1) in (6,7,8)
group by a.id_empresa_corp,year(trxdate),emp.nombre
order by a.id_empresa_corp

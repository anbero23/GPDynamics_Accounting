--SALDOS RENDICIONES POR DNI LPP

with bd1 as (
	select año*100+mes IdTiempo from (select distinct año,mes from dbo.dim_fecha) a
	where año*100+mes between 201601 and year(getdate())*100+month(getdate())
)

,Rendiciones as (
--CTA 4699000 (reembolsos por pagar) POR DNI

select year(trxdate)*100+month(trxdate) IdTiempo,a.ormstrid DNI
,CASE when a.ormstrid in ('e0015','2583610420101') then 'ANDRES SOBALVARRO-LIQ RENDICIONES' else a.ormstrnm end Nombre
,b.actnumbr_1,b.actdescr,sum(crdtamnt-debitamt) Saldo,jrnentry Asiento,refrence,dscriptn
from dbo.gl20000 a
left join dbo.gl00100 b
on a.actindx=b.actindx
where /*a.hstyear='2019' and month(trxdate)>=11 and*/ actnumbr_1 in ('4699000','1411000')
--and ormstrid in ('E0015',)
group by b.actnumbr_1,b.actdescr,a.ormstrid,a.ormstrnm,refrence,dscriptn,year(trxdate)*100+month(trxdate),Jrnentry

UNION ALL

select year(trxdate)*100+month(trxdate) IdTiempo,a.ormstrid DNI
,CASE when a.ormstrid in ('e0015','2583610420101') then 'ANDRES SOBALVARRO-LIQ RENDICIONES' else a.ormstrnm end Nombre
,b.actnumbr_1,b.actdescr,sum(crdtamnt-debitamt) Saldo,jrnentry Asiento,refrence,dscriptn
from dbo.gl30000 a
left join dbo.gl00100 b
on a.actindx=b.actindx
where a.hstyear*100+month(trxdate)>=201911 and actnumbr_1 in ('4699000','1411000')
--and ormstrid in ('E0015',)
group by b.actnumbr_1,b.actdescr,a.ormstrid,a.ormstrnm,refrence,dscriptn,year(trxdate)*100+month(trxdate),Jrnentry

UNION ALL

select year(trxdate)*100+month(trxdate) IdTiempo,a.ormstrid COLLATE Latin1_General_CI_AS DNI
,CASE when a.ormstrid COLLATE Latin1_General_CI_AS in ('e0015','2583610420101') then 'ANDRES SOBALVARRO-LIQ RENDICIONES' else a.ormstrnm COLLATE Latin1_General_CI_AS end Nombre
,b.actnumbr_1 COLLATE Latin1_General_CI_AS,b.actdescr COLLATE Latin1_General_CI_AS,sum(crdtamnt-debitamt) Saldo,jrnentry Asiento,refrence COLLATE Latin1_General_CI_AS,dscriptn COLLATE Latin1_General_CI_AS
from dbo.gl20000 a
left join dbo.gl00100 b
on a.actindx=b.actindx
where a.openyear*100+month(trxdate)<201911 and actnumbr_1 in ('4699000','1411000')
--and ormstrid in ('E0015',)
group by b.actnumbr_1,b.actdescr,a.ormstrid,a.ormstrnm,refrence,dscriptn,year(trxdate)*100+month(trxdate),Jrnentry

UNION ALL

select year(trxdate)*100+month(trxdate) IdTiempo,a.ormstrid COLLATE Latin1_General_CI_AS DNI
,CASE when a.ormstrid COLLATE Latin1_General_CI_AS in ('e0015','2583610420101') then 'ANDRES SOBALVARRO-LIQ RENDICIONES' else a.ormstrnm COLLATE Latin1_General_CI_AS end Nombre
,b.actnumbr_1 COLLATE Latin1_General_CI_AS,b.actdescr COLLATE Latin1_General_CI_AS,sum(crdtamnt-debitamt) Saldo,jrnentry Asiento,refrence COLLATE Latin1_General_CI_AS,dscriptn COLLATE Latin1_General_CI_AS
from dbo.gl30000 a
left join dbo.gl00100 b
on a.actindx=b.actindx
where /*a.openyear='2019' and month(trxdate)<=10 and*/ actnumbr_1 in ('4699000','1411000')
--and ormstrid in ('E0015',)
group by b.actnumbr_1,b.actdescr,a.ormstrid,a.ormstrnm,refrence,dscriptn,year(trxdate)*100+month(trxdate),Jrnentry
)

,bd3 as (
	select * from bd1, (select distinct actnumbr_1,DNI,nombre,actdescr from Rendiciones where (dni is not null and dni<>'')) a
)

,Saldo as (
select a.idtiempo,a.dni,a.nombre,a.actnumbr_1,a.actdescr,sum(saldo) Saldo
from Rendiciones a
group by a.idtiempo,a.dni,a.actnumbr_1,a.nombre,a.actdescr
)

--Select * from saldo where dni='43198227'


,base as (
select a.idtiempo,a.dni,a.nombre,a.actnumbr_1,a.actdescr,coalesce(b.saldo,0) Saldo
from bd3 a
left join Saldo b
on a.DNI=b.DNI and a.IdTiempo=b.IDTiempo and a.actnumbr_1=b.actnumbr_1 and a.nombre=b.nombre and a.actdescr=b.actdescr
)

--Select * from base where dni='43198227'

,resumen as (
select	IdTiempo
		,DNI
		,Nombre
		,Actnumbr_1 Cuenta
		,Actdescr Desc_cuenta
		,a.Saldo
		,sum(a.Saldo) over(partition by a.DNI,a.Actnumbr_1,a.Nombre,a.Actdescr order by IdTiempo asc rows between unbounded preceding and current row) as SaldoAcumulado
from base a
)

Select *
from Rendiciones
where refrence not like 'Saldo resumido%'
--where (dni is not null and dni<>'')
--where dni='77777777'

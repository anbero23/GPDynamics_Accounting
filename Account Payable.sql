--QUERY CXP (Cuenta por pagar)


select	a.openyear Año
		,month(a.trxdate) Mes
		,a.openyear*100+month(a.trxdate) IdTiempo
		,b.actnumbr_1
		,null asiento
		,null refrence
		,null dscriptn
		,ormstrid RUC
		,ormstrnm Nombre_Prov
		,orctrnum DocCliente
		,sum(crdtamnt-debitamt) Saldo_PEN
		,curncyid Moneda_Origen
		,sum(orcrdamt-ordbtamt) Saldo_MonedaOrigen
from dbo.gl20000 a
left join dbo.gl00100 b
on a.actindx=b.actindx
where (left(actnumbr_1,2) in ('42','43','04','45','46','47'))
 and ormstrnm is not null and ormstrnm not in ('')
 and orgntsrc<>'cerrar'
group by b.actnumbr_1,ormstrid,ormstrnm,curncyid,orctrnum,a.openyear,month(a.trxdate)

union all

select	a.openyear
		,month(a.trxdate) Mes
		,a.openyear*100+month(a.trxdate) IdTiempo
		,b.actnumbr_1
		,a.jrnentry asiento
		,refrence
		,dscriptn
		,ormstrid RUC
		,ormstrnm Nombre_Prov
		,orctrnum DocCliente
		,sum(crdtamnt-debitamt) Saldo_PEN
		,curncyid Moneda_Origen
		,sum(orcrdamt-ordbtamt) Saldo_MonedaOrigen
from dbo.gl20000 a
left join dbo.gl00100 b
on a.actindx=b.actindx
where (left(actnumbr_1,2) in ('42','43','04','45','46','47'))
 --and ormstrid in ('',null,'s','usd') 
 and ormstrnm in (null,'') 
 --and uswhpstd in ('dmartines','vmanrique')
 and orgntsrc<>'cerrar'
group by b.actnumbr_1,a.jrnentry,refrence,dscriptn,ormstrid,ormstrnm,curncyid,orctrnum,a.openyear,month(a.trxdate)

UNION ALL
----------------------------------------AÑOS ANTERIORES---------------------------------

select	a.hstyear
		,month(a.trxdate) Mes
		,a.hstyear*100+month(a.trxdate) IdTiempo
		,b.actnumbr_1
		,null asiento
		,null refrence
		,null dscriptn
		,ormstrid RUC
		,ormstrnm Nombre_Prov
		,orctrnum DocCliente
		,sum(crdtamnt-debitamt) Saldo_PEN
		,curncyid Moneda_Origen
		,sum(orcrdamt-ordbtamt) Saldo_MonedaOrigen
from dbo.gl30000 a
left join dbo.gl00100 b
on a.actindx=b.actindx
where (left(actnumbr_1,2) in ('42','43','04','45','46','47'))
 and ormstrnm is not null and ormstrnm not in ('')
 and orgntsrc<>'cerrar'
group by b.actnumbr_1,ormstrid,ormstrnm,curncyid,orctrnum,a.hstyear,month(a.trxdate)

union all

select	a.hstyear
		,month(a.trxdate) Mes
		,a.hstyear*100+month(a.trxdate) IdTiempo
		,b.actnumbr_1
		,a.jrnentry asiento
		,refrence
		,dscriptn
		,ormstrid RUC
		,ormstrnm Nombre_Prov
		,orctrnum DocCliente
		,sum(crdtamnt-debitamt) Saldo_PEN
		,curncyid Moneda_Origen
		,sum(orcrdamt-ordbtamt) Saldo_MonedaOrigen
from dbo.gl30000 a
left join dbo.gl00100 b
on a.actindx=b.actindx
where (left(actnumbr_1,2) in ('42','43','04','45','46','47'))
 --and ormstrid in ('',null,'s','usd') 
 and ormstrnm in (null,'') 
 --and uswhpstd in ('dmartines','vmanrique')
 and orgntsrc<>'cerrar'
group by b.actnumbr_1,a.jrnentry,refrence,dscriptn,ormstrid,ormstrnm,curncyid,orctrnum,a.hstyear,month(a.trxdate)

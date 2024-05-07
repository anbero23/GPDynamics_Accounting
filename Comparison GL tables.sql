--Para validar analítica – para ver los diarios que no están en la analítica

--Cuando reviso el resultado de LPP con la GL20000 a julio, obtengo: 69,284.57
-- Query: 

 select jrnentry asiento,sum(crdtamnt-debitamt) saldo
 from dbo.gl20000 a
 left join dbo.gl00100 b
 on a.actindx=b.actindx
 where month(trxdate)<=7 and left(b.actnumbr_1,1) in ('6','7','8')
 and jrnentry not in (

 --Pero cuando reviso el resultado con la analítica: GGGPPIN.dbo.negltbconsolidaciondt, obtengo de resultado: 69,250.76
 --Query:
 select asiento
 --,sum(acreditofuncional-adebitofuncional) saldo
 from gpin.dbo.negltbconsolidaciondt
 where empresaid='gpper' and left(cuentacontablenumero,1) in ('6','7','8') and ejercicio=2019 and periodo<=7
 --group by asiento
 )
  group by jrnentry


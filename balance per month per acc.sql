--Query de saldo resumen por cuenta contable por mes en la GL20000

select b.actnumbr_1,sum(crdtamnt-debitamt) as saldo
from dbo.gl20000 a
left join dbo.gl00100 b
on a.actindx=b.actindx
where openyear='2019' and month(trxdate)=1 and actnumbr_1 in ('7021100')
group by b.actnumbr_1

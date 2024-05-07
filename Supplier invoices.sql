--Facturas por proveedor

select pordnmbr,b.vendname,a.*
from dbo.pm20000_pm30200 a
left join dbo.pm00200 b
on a.vendorid=b.vendorid
where 
--b.vendorid='20518334906'
b.vendname like 'dentons%' 
and docnumbr like 'f%'
and a.docnumbr like '%14183%'
order by docdate DESC,DOCNUMBR desc

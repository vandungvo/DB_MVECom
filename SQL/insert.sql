bulk insert e_commerce.dbo.users
from 'C:\Users\admin\Documents\hcsdl\DB_MVECom\data\users.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);

bulk insert e_commerce.dbo.customer 
from 'C:\Users\admin\Documents\hcsdl\DB_MVECom\data\customer.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	)

bulk insert e_commerce.dbo.shop
from 'C:\Users\admin\Documents\hcsdl\DB_MVECom\data\shop.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);


bulk insert e_commerce.dbo.shipping_company
from 'C:\Users\admin\Documents\hcsdl\DB_MVECom\data\shipping_company.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);

bulk insert e_commerce.dbo.category
from 'C:\Users\admin\Documents\hcsdl\DB_MVECom\data\category.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);

bulk insert e_commerce.dbo.shipper
from 'C:\Users\admin\Documents\hcsdl\DB_MVECom\data\shipper.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);

bulk insert e_commerce.dbo.shipper
from 'C:\Users\admin\Documents\hcsdl\DB_MVECom\data\shipper.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);


bulk insert e_commerce.dbo.product
from 'C:\Users\admin\Documents\hcsdl\DB_MVECom\data\product.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);

bulk insert e_commerce.dbo.orders
from 'C:\Users\admin\Documents\hcsdl\DB_MVECom\data\orders.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);

bulk insert e_commerce.dbo.bill
from 'C:\Users\admin\Documents\hcsdl\DB_MVECom\data\bill.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);

bulk insert e_commerce.dbo.bill_product
from 'C:\Users\admin\Documents\hcsdl\DB_MVECom\data\bill_product.csv'
with (
	format = 'csv',
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);

select * from e_commerce.dbo.bill
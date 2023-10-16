insert into public.products (product_name, price, date_price_start)
values ('Испорченный телефон', 1000, '2023-04-01'),
	   ('Сарафанное радио', 99999.99 , '2023-04-01'),
	   ('Патефон', 5500, '2023-04-01');

insert into public.shop (shop_name, address)
values ('DNS', 'у. разбитых фонарей'),
       ('mvideo', 'там где находится мвидео'),
       ('sitilink' ,'место ситилинка');
      
insert into public.plan (shop_id, product_id, plan_cnt, plan_date_start, plan_date_end)
values (1, 1, 30, '2023-04-15', '2023-05-15'),
       (1, 2, 20, '2023-04-15', '2023-05-15'),
       (1, 3, 10, '2023-04-15', '2023-05-15'),
       (2, 1, 35, '2023-04-15', '2023-05-15'),
       (2, 2, 25, '2023-04-15', '2023-05-15'),
       (2, 3, 15, '2023-04-15', '2023-05-15'),
       (3, 1, 40, '2023-04-15', '2023-05-15'),
       (3, 2, 45, '2023-04-15', '2023-05-15'),
       (3, 3, 50, '2023-04-15', '2023-05-15');

insert into public.shop_dns (shop_id, product_id, date_sale, sales_cnt)
values (1, 1, '2023-04-20', 8),
	   (1, 1, '2023-04-25', 9),
	   (1, 1, '2023-05-20', 3),
	   (1, 2, '2023-04-20', 1),
	   (1, 2, '2023-04-25', 2),
	   (1, 2, '2023-05-20', 4),
	   (1, 3, '2023-04-20', 4),
	   (1, 3, '2023-04-25', 3),
	   (1, 3, '2023-05-20', 2);

insert into public.shop_mvideo (shop_id, product_id, date_sale, sales_cnt)
values (2, 1, '2023-04-20', 8),
	   (2, 1, '2023-04-25', 9),
	   (2, 1, '2023-05-20', 3),
	   (2, 2, '2023-04-20', 1),
	   (2, 2, '2023-04-25', 2),
	   (2, 2, '2023-05-20', 4),
	   (2, 3, '2023-04-20', 4),
	   (2, 3, '2023-04-25', 3),
	   (2, 3, '2023-05-20', 2);	

insert into public.shop_sitilink (shop_id, product_id, date_sale, sales_cnt)
values (3, 1, '2023-04-20', 8),
	   (3, 1, '2023-04-25', 9),
	   (3, 1, '2023-05-20', 3),
	   (3, 2, '2023-04-20', 1),
	   (3, 2, '2023-04-25', 2),
	   (3, 2, '2023-05-20', 4),
	   (3, 3, '2023-04-20', 4),
	   (3, 3, '2023-04-25', 3),
	   (3, 3, '2023-05-20', 2);
---Создаем календарь для выведеня дат по 2024 году
drop table if exists calendar;
create temp table calendar as
select 
opened_date2,
cast((extract(dow from opened_date2) + 2) as integer) % 7 as day_number,  -- порядковый номер дня недели с началом недели в пятницу
extract(week from (opened_date2 - interval '4 day')) as week_number
from(select generate_series(
	(date '2024-01-01'),
    (date '2024-05-23'),
    interval '1 day')::date as opened_date2) as qwe
;

/*--- Чеки, содержащие акционные отделы 
drop table if exists receipts;
create temp table receipts as
select receipt_surrogate_id as receipt_surrogate_id2
from dds.v_receipt_lines_public
where rms_department::int not in (2) 
and opened_date between '2023-01-01' and '2024-12-31'
group by receipt_surrogate_id
;*/

--- Чеки, содержащие акционные товары с учетом недель акции
drop table if exists receipts_sale;
create temp table receipts_sale as
select receipt_surrogate_id as receipt_surrogate_id3
from dds.v_receipt_lines_public
where
		(line_item_id = '85539218' AND coalesce(receiver_storeid, store_id)  IN (10, 11, 41, 42, 134, 135, 136, 137, 138, 140, 141) AND opened_date BETWEEN '2024-04-19' AND '2024-04-25') OR
        (line_item_id = '89353945' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 20, 22, 26, 28, 32, 35, 40, 43, 49, 51, 56, 65, 86, 114, 117, 118, 122, 126, 143, 153, 169) AND opened_date BETWEEN '2024-04-19' AND '2024-04-25') OR
        (line_item_id = '89179009' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-19' AND '2024-04-25') OR
        (line_item_id = '89358703' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 10, 11, 20, 22, 26, 28, 32, 35, 40, 41, 42, 43, 49, 51, 56, 65, 86, 114, 117, 118, 122, 126, 134, 135, 136, 137, 138, 140, 141, 143, 153, 169) AND opened_date BETWEEN '2024-04-19' AND '2024-04-25') OR
        (line_item_id = '89353951' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-19' AND '2024-04-25') OR
        (line_item_id = '89365954' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-19' AND '2024-04-25') OR
        (line_item_id = '85106534' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-19' AND '2024-04-25') OR
        (line_item_id = '89364106' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 10, 11, 20, 22, 26, 28, 32, 35, 40, 41, 42, 43, 49, 51, 56, 65, 86, 114, 117, 118, 122, 126, 134, 135, 136, 137, 138, 140, 141, 143, 153, 169) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '18864501' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '89025368' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '89025370' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '89025369' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '89025371' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '89025372' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '89025373' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '89025374' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '89025375' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '89025376' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '89025377' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '14147003' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '84841832' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-04-26' AND '2024-05-02') OR
        (line_item_id = '89359491' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-03' AND '2024-05-09') OR
        (line_item_id = '82327005' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-03' AND '2024-05-09') OR
        (line_item_id = '85544111' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-03' AND '2024-05-09') OR
        (line_item_id = '85544116' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-03' AND '2024-05-09') OR
        (line_item_id = '18722589' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 10, 11, 20, 22, 26, 28, 32, 35, 40, 41, 42, 43, 49, 51, 56, 65, 86, 114, 117, 118, 122, 126, 134, 135, 136, 137, 138, 140, 141, 143, 153, 169) AND opened_date BETWEEN '2024-05-03' AND '2024-05-09') OR
        (line_item_id = '81968251' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-03' AND '2024-05-09') OR
        (line_item_id = '81968249' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-03' AND '2024-05-09') OR
        (line_item_id = '14348374' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 22, 28, 35, 40, 43, 49, 65, 86, 114, 118, 126, 143, 153) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '89358024' AND coalesce(receiver_storeid, store_id)  IN (12, 16, 23, 30, 36, 37, 52, 55, 58, 59, 67, 68, 75, 81, 82, 87, 88, 89, 91, 93, 123, 124, 128, 129) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '89368731' AND coalesce(receiver_storeid, store_id)  IN (6, 9, 10, 11, 13, 17, 18, 19, 20, 25, 26, 31, 32, 33, 34, 38, 41, 42, 47, 48, 51, 53, 56, 57, 71, 74, 78, 79, 80, 83, 110, 117, 122, 127, 134, 135, 136, 137, 138, 140, 141, 142, 156, 169, 181) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '11725779' AND coalesce(receiver_storeid, store_id)  IN (7, 8, 14, 21, 24, 27, 39, 46, 69, 70, 73, 77, 92, 94, 109, 111, 115, 119, 147, 150, 155, 163, 165) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '84375946' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '87815383' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '87815384' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '87815382' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '87815385' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '17983824' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '84659727' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '84659728' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '17983841' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '81992740' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-10' AND '2024-05-16') OR
        (line_item_id = '83422542' AND coalesce(receiver_storeid, store_id)  IN (10, 11, 41, 42, 134, 135, 136, 137, 138, 140, 141, 2, 3, 4, 5, 20, 22, 26, 28, 32, 35, 40, 43, 49, 51, 56, 65, 86, 114, 117, 118, 122, 126, 142, 143, 153, 169) AND opened_date BETWEEN '2024-05-17' AND '2024-05-23') OR
        (line_item_id = '89367194' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 10, 11, 20, 22, 26, 28, 32, 35, 40, 41, 42, 43, 49, 51, 56, 65, 86, 114, 117, 118, 122, 126, 134, 135, 136, 137, 138, 140, 141, 143, 153, 169) AND opened_date BETWEEN '2024-05-17' AND '2024-05-23') OR
        (line_item_id = '89353949' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-17' AND '2024-05-23') OR
        (line_item_id = '89364938' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-17' AND '2024-05-23') OR
        (line_item_id = '89366396' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-17' AND '2024-05-23') OR
        (line_item_id = '82260136' AND coalesce(receiver_storeid, store_id)  IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181) AND opened_date BETWEEN '2024-05-17' AND '2024-05-23')
	and ((opened_date between '2023-04-01' and '2023-05-31')
        or 
        (opened_date between '2024-04-01' and '2024-05-31'))
group by receipt_surrogate_id
;

--- Считаем Артикул на чек, Маржу на чек, GMV на чек за 2023 и 2024
drop table if exists metrics;
create temp table metrics as
select
	opened_date2,
    cast((extract(dow from opened_date) + 2) as integer) % 7 as day_number,  -- порядковый номер дня недели с началом недели в пятницу
    extract(week from (opened_date - interval '4 day')) as week_number, 
    coalesce(receiver_storeid, store_id) as store,
    sum(
    	case 
	    	when extract(year from opened_date) = 2023 and line_type != 'Returns' then line_quantity else 0 
    	end) / nullif(count(distinct case when extract(year from opened_date) = 2023 and line_type != 'Returns'  then receipt_surrogate_id end), 0) as "art_per_receipt 2023",
    sum(case 
	    	when extract(year from opened_date) = 2024 and line_type != 'Returns'  then line_quantity else 0 
	    end) / nullif(count(distinct case when extract(year from opened_date) = 2024 and line_type != 'Returns' then receipt_surrogate_id end), 0) as "art_per_receipt 2024",
	sum(
    	case 
	    	when extract(year from opened_date) = 2023 then line_margin else 0 
    	end) / nullif(count(distinct case when extract(year from opened_date) = 2023 then receipt_surrogate_id end), 0) as "margin_per_receipt 2023",
    sum(case 
	    	when extract(year from opened_date) = 2024 then line_margin else 0 
	    end) / nullif(count(distinct case when extract(year from opened_date) = 2024 then receipt_surrogate_id end), 0) as "margin_per_receipt 2024",    
	sum(
    	case 
	    	when extract(year from opened_date) = 2023 then line_turnover else 0 
    	end) / nullif(count(distinct case when extract(year from opened_date) = 2023 then receipt_surrogate_id end), 0) as "gmv_per_receipt 2023",
    sum(case 
	    	when extract(year from opened_date) = 2024 then line_turnover else 0 
	    end) / nullif(count(distinct case when extract(year from opened_date) = 2024 then receipt_surrogate_id end), 0) as "gmv_per_receipt 2024"
from dds.v_receipt_lines_public rl
join dds.v_dict_stores ds on store = coalesce(receiver_storeid, store_id) 
join calendar c on c.day_number = cast((extract(dow from opened_date) + 2) as integer) % 7 and c.week_number = extract(week from (opened_date - interval '4 day'))
where
    line_item_type = 'Normal'  -- только товары
    and line_type in ('Sales', 'Returns', 'pickedUp orders') -- только продажи, возвраты и заказы, которые были забраны (без авансов)
    and COALESCE(line_order_channel_calculated, 'OFFLINE') = 'OFFLINE'
    and client_subtype in ('Service Card', 'Corporate Card', 'Undefined') -- исключили профиков
    and ((opened_date between '2023-04-01' and '2023-05-31')
        or 
        (opened_date between '2024-04-01' and '2024-05-31'))
    and extract(week from (opened_date - interval '4 day')) <= 20 
    and store_type = 'store'
    and coalesce(receiver_storeid, store_id) in (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181)
group by
	opened_date2,
    cast((extract(dow from opened_date) + 2) as integer) % 7,
    extract(week from (opened_date - interval '4 day')),
    coalesce(receiver_storeid, store_id)
   ;

--- Считаем Артикул на чек, Маржу на чек, GMV на чек по акционным чекам
drop table if exists metrics_sale;
create temp table metrics_sale as   
select
	opened_date2,
    cast((extract(dow from opened_date) + 2) as integer) % 7 as day_number,  -- порядковый номер дня недели с началом недели в пятницу
    extract(week from (opened_date - interval '4 day')) as week_number, 
    coalesce(receiver_storeid, store_id) as store,
    sum(
    	case 
	    	when extract(year from opened_date) = 2024 and line_type != 'Returns' then line_quantity else 0 
    	end) / nullif(count(distinct case when extract(year from opened_date) = 2024 and line_type != 'Returns' then receipt_surrogate_id end), 0) as "art_per_receipt sale",
    sum(case 
	    	when extract(year from opened_date) = 2024 then line_margin else 0 
	    end) / nullif(count(distinct case when extract(year from opened_date) = 2024 then receipt_surrogate_id end), 0) as "margin_per_receipt sale",    
    sum(case 
	    	when extract(year from opened_date) = 2024 then line_turnover else 0 
	    end) / nullif(count(distinct case when extract(year from opened_date) = 2024 then receipt_surrogate_id end), 0) as "gmv_per_receipt sale"
from dds.v_receipt_lines_public rl
join dds.v_dict_stores ds on store = store_id
join calendar c on c.day_number = cast((extract(dow from opened_date) + 2) as integer) % 7 and c.week_number = extract(week from (opened_date - interval '4 day'))
where
    line_item_type = 'Normal'  -- только товары
    and line_type in ('Sales', 'Returns', 'pickedUp orders') -- только продажи, возвраты и заказы, которые были забраны (без авансов)
    and COALESCE(line_order_channel_calculated, 'OFFLINE') = 'OFFLINE'
    and client_subtype in ('Service Card', 'Corporate Card')
  and ((opened_date between '2023-04-01' and '2023-05-31')
        or 
        (opened_date between '2024-04-01' and '2024-05-31'))
    and extract(week from (opened_date - interval '4 day')) <= 20
    and store_type = 'store'
    and coalesce(receiver_storeid, store_id) in (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181)
group by
	opened_date2,
    cast((extract(dow from opened_date) + 2) as integer) % 7,
    extract(week from (opened_date - interval '4 day')),
    coalesce(receiver_storeid, store_id)  
;
    
--- Считаем Количество уникальных артикулов на чек 2023 и 2024  
drop table if exists receipts_count;
create temp table receipts_count as
select
	opened_date2	
	, store
	, cast((extract(dow from opened_date) + 2) as integer) % 7 as day_number  -- порядковый номер дня недели с началом недели в пятницу
    , extract(week from (opened_date - interval '4 day')) as week_number 
	, sum(
    	case 
	    	when extract(year from opened_date) = 2023 then art else 0 
    	end) / nullif(count(case when extract(year from opened_date) = 2023 then receipt_surrogate_id end), 0) as "uni_art_per_receipt 2023"
    , sum(
    	case 
	    	when extract(year from opened_date) = 2024 then art else 0 
    	end) / nullif(count(case when extract(year from opened_date) = 2024 then receipt_surrogate_id end), 0) as "uni_art_per_receipt 2024"	
from 
	(select
		opened_date::date
		, coalesce(receiver_storeid, store_id) as store
		, receipt_surrogate_id
		, count (distinct line_article_id) as art
	from dds.v_receipt_lines_public rl
	join dds.v_dict_stores ds on store = store_id
	where
    line_item_type = 'Normal'  -- только товары
    and line_type in ('Sales', 'pickedUp orders') -- только продажи, и заказы, которые были забраны (без авансов и возвратов)
    and COALESCE(line_order_channel_calculated, 'OFFLINE') = 'OFFLINE'
    and client_subtype in ('Service Card', 'Corporate Card', 'Undefined')
  and ((opened_date between '2023-04-01' and '2023-05-31')
        or 
        (opened_date between '2024-04-01' and '2024-05-31'))
    and store_type = 'store'
    and coalesce(receiver_storeid, store_id) in (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181)
    group by 1, 2, 3
	) as qwe
join calendar c on c.day_number = cast((extract(dow from opened_date) + 2) as integer) % 7 and c.week_number = extract(week from (opened_date - interval '4 day'))
	where 
	extract(week from (opened_date - interval '4 day')) <= 20
group by 1,2,3, 4
;

--- Считаем Количество уникальных артикулов на чек по акционным чекам
drop table if exists receipts_count_sale;
create temp table receipts_count_sale as
select
	opened_date2	
	, store
	, cast((extract(dow from opened_date) + 2) as integer) % 7 as day_number  -- порядковый номер дня недели с началом недели в пятницу
    , extract(week from (opened_date - interval '4 day')) as week_number 
    , sum(
    	case 
	    	when extract(year from opened_date) = 2024 then art else 0 
    	end) / nullif(count(case when extract(year from opened_date) = 2024 then receipt_surrogate_id end), 0) as "uni_art_per_receipt sale"
from 
	(select
		opened_date::date
		, coalesce(receiver_storeid, store_id) as store
		, receipt_surrogate_id
		, count (distinct line_article_id) as art
	from dds.v_receipt_lines_public rl
	join dds.v_dict_stores ds on store = store_id
	join receipts_sale rs on rs.receipt_surrogate_id3 = rl.receipt_surrogate_id 
	where
    line_item_type = 'Normal'  -- только товары
    and line_type in ('Sales', 'pickedUp orders') -- только продажи, и заказы, которые были забраны (без авансов и возвратов)
    and COALESCE(line_order_channel_calculated, 'OFFLINE') = 'OFFLINE'
    and client_subtype in ('Service Card', 'Corporate Card')
  and ((opened_date between '2023-04-01' and '2023-05-31')
        or 
        (opened_date between '2024-04-01' and '2024-05-31'))
    and store_type = 'store'
    and coalesce(receiver_storeid, store_id) in (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49, 51, 52, 53, 55, 56, 57, 58, 59, 65, 67, 68, 69, 70, 71, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 86, 87, 88, 89, 91, 92, 93, 94, 109, 110, 111, 114, 115, 117, 118, 119, 122, 123, 124, 126, 127, 128, 129, 134, 135, 136, 137, 138, 140, 141, 142, 143, 147, 150, 153, 155, 156, 163, 165, 169, 181)
    group by 1, 2, 3
	) as qwe
join calendar c on c.day_number = cast((extract(dow from opened_date) + 2) as integer) % 7 and c.week_number = extract(week from (opened_date - interval '4 day'))
	where 
	extract(week from (opened_date - interval '4 day')) <= 20
group by 1,2,3,4
;

select
	  m.opened_date2
	, m.day_number
	, m.week_number
	, m.store
	, round ("art_per_receipt 2023", 0)
	, round ("art_per_receipt 2024", 0)
	, round ("margin_per_receipt 2023", 0)
	, round ("margin_per_receipt 2024", 0)
	, round ("gmv_per_receipt 2023", 0)
	, round ("gmv_per_receipt 2024", 0)
	, round ("art_per_receipt sale", 0)
	, round ("margin_per_receipt sale", 0)
	, round ("gmv_per_receipt sale", 0)
	, round ("uni_art_per_receipt 2023", 0)
	, round ("uni_art_per_receipt 2024", 0)
	, round ("uni_art_per_receipt sale", 0)
from metrics m 
join metrics_sale ms on m.opened_date2 = ms.opened_date2 and m.store = ms.store and m.day_number = ms.day_number and m.week_number = ms.week_number 
join receipts_count rc on m.opened_date2 = rc.opened_date2 and m.store = rc.store and m.day_number = rc.day_number and m.week_number = rc.week_number 
join receipts_count_sale rcs on m.opened_date2 = rcs.opened_date2 and m.store = rcs.store and m.day_number = rcs.day_number and m.week_number = rcs.week_number 
;

drop table if exists calendar;
drop table if exists receipts_sale;
drop table if exists metrics;
drop table if exists metrics_sale;
drop table if exists receipts_count;
drop table if exists receipts_count_sale;
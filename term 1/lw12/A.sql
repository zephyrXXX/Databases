create table Transactions
(
	Counter int identity(1,1),
	Info nvarchar(20)
)
insert Transactions values ('������ 1'),('������ 2'),('������ 3'),('������ 4')

---------------------------- Task 4 A ----------------------------

--��������� ������� @@SPID ���������� ��������� ������������� ��������, ����������� �������� �������� �����������
--���������������� ������, ��������������� ������, ��������� ������
-- uncomitted - ������������ ���������������� ������, �.�. ������� �/� t1 � t2 ����������� ���� ��� commit � B ����-��
set transaction isolation level read uncommitted
begin tran
select * from Transactions
select count(*) from Transactions
--t1
select count(*) from Transactions
select * from Transactions
commit
--t2

---------------------------- Task 5 A ----------------------------
-- commited - ������� �/� t1 � t2 �� ����� �������� ���� �� �� ���������� commit � ����-� B
set transaction isolation level read committed
begin tran
select * from Transactions
select count(*) from Transactions
--t1
select * from Transactions
select count(*) from Transactions
commit
--t2
update Transactions set Info = '������ 4' where Counter = 4
delete from Transactions where Info = '������ 5'

---------------------------- Task 6 A ----------------------------
-- repeatable �� ��������� ������ � ���������������� ������ (���� �� 
--�������� ������ �/� ����� ���������� ������, �� ���-� ����� ������)
set transaction isolation level repeatable read
begin tran
select * from Transactions
select count(*) from Transactions
--t1
select * from Transactions
select count(*) from Transactions
commit
--
delete from Transactions where Info = '������ 5'
--t2

---------------------------- Task 7 A ----------------------------
-- serializable �� ��������� ��������� ��-�, �.�. ������ ��� ���������� ������ ���� ����� ���� B, ��� �� ����� ���-�� 
set transaction isolation level serializable
begin tran
select * from Transactions
select count(*) from Transactions
--t1
select * from Transactions
select count(*) from Transactions
commit
--t2
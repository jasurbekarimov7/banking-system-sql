create database BankingSystem1
go
use BankingSystem1


-- 1 Customers – Stores bank customer information.

create table Customers(
CustomerID Int primary key identity,
FullName Varchar(100) not null,
DOB Date,
Email Varchar(100) unique,
PhoneNumber Varchar(20),
Address Varchar(500),
NationalID Varchar(30) unique,
TaxID Varchar(100) unique,
EmploymentStatus Varchar(100),
AnnualIncome Decimal(15,2),
CreatedAt Datetime default getdate(),
UpdatedAt Datetime default getdate()
)



-- 2 Accounts – Stores customer bank accounts.

create table Accounts(
AccountID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
AccountType Varchar(100),
Balance Decimal(15,2) CHECK (Balance >= 0),
Currency Varchar(10),
Status Varchar(20),
BranchID Int,
CreatedDate Datetime default getdate()
)


-- 3️ Transactions – Logs all banking transactions.
-- •	TransactionID (PK), AccountID (FK)
-- •	TransactionType (Deposit, Withdrawal, Transfer, Payment)
-- •	Amount, Currency, Date, Status, ReferenceNo

create table Transactions(
TransactionID Int primary key identity,
AccountID Int foreign key references Accounts(AccountID),
TransactionType Varchar(100),
Amount Decimal(15,2) CHECK (Amount > 0),
Currency Varchar(10),
TransactionDate Datetime default getdate(),
Status Varchar(100),
ReferenceNo Varchar(100) UNIQUE
)

-- 4️ Branches – Bank branch details.
-- •	BranchID (PK)
-- •	BranchName, Address, City, State, Country
-- •	ManagerID (FK), ContactNumber

create table Branches(
BranchID Int primary key identity,
BranchName Varchar(100),
Address Varchar(250),
City Varchar(100),
State Varchar(100),
Country Varchar(100),
ManagerID Int,
ContactNumber Varchar(20)
)

-- 5️ Employees – Stores bank staff details.
-- •	EmployeeID (PK), BranchID (FK)
-- •	FullName, Position, Department
-- •	Salary, HireDate, Status

create table Employees(
EmployeeID Int primary key identity,
BranchID Int foreign key references Branches(BranchID),
FullName Varchar(100),
Position Varchar(100),
Department Varchar(100),
Salary Decimal(15,2),
HireDate Date,
Status Varchar(20)
)

-- 💳 Digital Banking & Payments
-- 
-- 6️ CreditCards – Customer credit card details.
-- •	CardID (PK), CustomerID (FK)
-- •	CardNumber, CardType, CVV, ExpiryDate, Limit, Status

create table CreditCards(
CardID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
CardNumber Varchar(20) UNIQUE,
CardType Varchar(20),
CVV Varchar(5),
ExpiryDate Date,
CardLimit Decimal(15,2),
Status Varchar(20)
)


-- 7️ CreditCardTransactions – Logs credit card transactions.
-- •	TransactionID (PK), CardID (FK)
-- •	Merchant, Amount, Currency, Date, Status

create table CreditCardTransactions(
TransactionID Int primary key identity,
CardID Int foreign key references CreditCards(CardID),
Merchant Varchar(100),
Amount Decimal(15,2),
Currency  Varchar(10),
[Date] Datetime default getdate(),
Status Varchar(20)
)

-- 8️ OnlineBankingUsers – Customers registered for internet banking.
-- •	UserID (PK), CustomerID (FK)
-- •	Username, PasswordHash, LastLogin

create table OnlineBankingUsers(
UserID Int primary key identity,
CustomerID Int UNIQUE
    foreign key references Customers(CustomerID),
Username Varchar(100) UNIQUE,
PasswordHash Varchar(255),
LastLogin Datetime
)

-- 9️ BillPayments – Tracks utility bill payments.
-- •	PaymentID (PK), CustomerID (FK)
-- •	BillerName, Amount, Date, Status

create table BillPayments(
PaymentID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
BillerName Varchar(100),
Amount Decimal(15,2),
PaymentDate Datetime default getdate(),
Status Varchar(20)
)

-- 10 MobileBankingTransactions – Tracks mobile banking activity.
-- •	TransactionID (PK), CustomerID (FK)
-- •	DeviceID, AppVersion, TransactionType, Amount, Date

create table MobileBankingTransactions(
TransactionID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
DeviceID Varchar(100),
AppVersion Varchar(50),
TransactionType Varchar(50),
Amount Decimal(15,2), 
[Date] Datetime default getdate()
)

-- 🏦 Loans & Credit
-- 1️1️ Loans – Stores loan details.
-- •	LoanID (PK), CustomerID (FK)
-- •	LoanType (Mortgage, Personal, Auto, Business)
-- •	Amount, InterestRate, StartDate, EndDate, Status

create table Loans(
LoanID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
LoanType Varchar(100),
Amount Decimal(15,2),
InterestRate Decimal(5,2) CHECK (InterestRate >= 0),
StartDate Date,
EndDate Date,
Status Varchar(20)
)

-- 1️2️ LoanPayments – Tracks loan repayments.
-- •	PaymentID (PK), LoanID (FK)
-- •	AmountPaid, PaymentDate, RemainingBalance

create table LoanPayments(
PaymentID Int primary key identity, 
LoanID Int foreign key references Loans(LoanID),
AmountPaid Decimal(15,2), 
PaymentDate Datetime default getdate(), 
RemainingBalance Decimal(15,2)
)



-- 13 CreditScores – Customer credit scores.

create table CreditScores(
CustomerID Int primary key
    foreign key references Customers(CustomerID),
CreditScore Int,
UpdatedAt Datetime default getdate()
)



-- 14 DebtCollection – Tracks overdue loans.

create table DebtCollection(
DebtID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
AmountDue Decimal(15,2),
DueDate Date,
CollectorAssigned Varchar(100)
)



-- 15 KYC – Stores customer verification info.

create table KYC(
KYCID Int primary key identity,
CustomerID Int UNIQUE
    foreign key references Customers(CustomerID),
DocumentType Varchar(100),
DocumentNumber Varchar(100) UNIQUE,
VerifiedBy Varchar(100)
)



-- 16 FraudDetection – Flags suspicious transactions.

create table FraudDetection(
FraudID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
TransactionID Int,
RiskLevel Varchar(50),
ReportedDate Datetime default getdate()
)



-- 17 AMLCases – Investigates financial crimes.

create table AMLCases(
CaseID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
CaseType Varchar(100),
Status Varchar(20),
InvestigatorID Int
)



-- 18 RegulatoryReports – Stores financial reports.

create table RegulatoryReports(
ReportID Int primary key identity,
ReportType Varchar(100),
SubmissionDate Datetime default getdate()
)



-- 19 Departments – Stores company departments.

create table Departments(
DepartmentID Int primary key identity,
DepartmentName Varchar(100),
ManagerID Int
)



-- 20 Salaries – Employee payroll data.

create table Salaries(
SalaryID Int primary key identity,
EmployeeID Int foreign key references Employees(EmployeeID),
BaseSalary Decimal(15,2),
Bonus Decimal(15,2),
Deductions Decimal(15,2),
PaymentDate Datetime default getdate()
)


-- 21 EmployeeAttendance – Tracks work hours.

create table EmployeeAttendance(
AttendanceID Int primary key identity,
EmployeeID Int foreign key references Employees(EmployeeID),
CheckInTime Datetime,
CheckOutTime Datetime,
TotalHours Decimal(5,2)
)



-- 22 Investments – Stores customer investment details.

create table Investments(
InvestmentID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
InvestmentType Varchar(100),
Amount Decimal(15,2),
ROI Decimal(5,2),
MaturityDate Date
)



-- 23 StockTradingAccounts – Customers trading stocks via bank.

create table StockTradingAccounts(
AccountID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
BrokerageFirm Varchar(100),
TotalInvested Decimal(15,2),
CurrentValue Decimal(15,2)
)



-- 24 ForeignExchange – Tracks forex transactions.

create table ForeignExchange(
FXID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
CurrencyPair Varchar(20),
ExchangeRate Decimal(10,4),
AmountExchanged Decimal(15,2)
)



-- 25 InsurancePolicies – Customer insurance plans.

create table InsurancePolicies(
PolicyID Int primary key identity,
CustomerID Int foreign key references Customers(CustomerID),
InsuranceType Varchar(100),
PremiumAmount Decimal(15,2),
CoverageAmount Decimal(15,2)
)



-- 26 Claims – Tracks insurance claims.

create table Claims(
ClaimID Int primary key identity,
PolicyID Int foreign key references InsurancePolicies(PolicyID),
ClaimAmount Decimal(15,2),
Status Varchar(20),
FiledDate Datetime default getdate()
)



-- 27 UserAccessLogs – Security logs for banking system users.

create table UserAccessLogs(
LogID Int primary key identity,
UserID Int foreign key references OnlineBankingUsers(UserID),
ActionType Varchar(100),
TimeStamp Datetime default getdate()
)



-- 28 CyberSecurityIncidents – Stores cyber attack cases.

create table CyberSecurityIncidents(
IncidentID Int primary key identity,
AffectedSystem Varchar(100),
ReportedDate Datetime default getdate(),
ResolutionStatus Varchar(50)
)



-- 29 Merchants – Stores merchant details.

create table Merchants(
MerchantID Int primary key identity,
MerchantName Varchar(100),
Industry Varchar(100),
Location Varchar(200),
CustomerID Int foreign key references Customers(CustomerID)
)



-- 30 MerchantTransactions – Logs merchant banking transactions.

create table MerchantTransactions(
TransactionID Int primary key identity,
MerchantID Int foreign key references Merchants(MerchantID),
Amount Decimal(15,2),
PaymentMethod Varchar(50),
[Date] Datetime default getdate()
)


go


-- Accounts -> Branches

ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);


-- Branches -> Employees (Manager)

ALTER TABLE Branches
ADD CONSTRAINT FK_Branches_Manager
FOREIGN KEY (ManagerID)
REFERENCES Employees(EmployeeID);


-- FraudDetection -> Transactions

ALTER TABLE FraudDetection
ADD CONSTRAINT FK_FraudDetection_Transactions
FOREIGN KEY (TransactionID)
REFERENCES Transactions(TransactionID);


-- AMLCases -> Employees (Investigator)

ALTER TABLE AMLCases
ADD CONSTRAINT FK_AMLCases_Employees
FOREIGN KEY (InvestigatorID)
REFERENCES Employees(EmployeeID);

-- Departments -> Employees (Manager)

ALTER TABLE Departments
ADD CONSTRAINT FK_Departments_Manager
FOREIGN KEY (ManagerID)
REFERENCES Employees(EmployeeID);

go


-- ==========================================
-- INSERT DATA INTO Customers (1000 Rows)
-- ==========================================

DECLARE @i INT = 1;

WHILE @i <= 1000
BEGIN

INSERT INTO Customers
(
    FullName,
    DOB,
    Email,
    PhoneNumber,
    Address,
    NationalID,
    TaxID,
    EmploymentStatus,
    AnnualIncome
)

VALUES
(
    CONCAT('Customer ',@i),

    DATEADD(DAY,-ABS(CHECKSUM(NEWID()))%15000,GETDATE()),

    CONCAT('customer',@i,'@gmail.com'),

    CONCAT
    (
        '9989',
        RIGHT('0000000'+CAST(@i AS VARCHAR(7)),7)
    ),

    CONCAT
    (
        'Street ',
        ABS(CHECKSUM(NEWID()))%500+1,
        ', Tashkent'
    ),

    CONCAT
    (
        'NID',
        RIGHT('0000000000'+CAST(@i AS VARCHAR(10)),10)
    ),

    CONCAT
    (
        'TAX',
        RIGHT('0000000000'+CAST(@i AS VARCHAR(10)),10)
    ),

    CASE ABS(CHECKSUM(NEWID()))%5
        WHEN 0 THEN 'Employed'
        WHEN 1 THEN 'Self-Employed'
        WHEN 2 THEN 'Student'
        WHEN 3 THEN 'Retired'
        ELSE 'Unemployed'
    END,

    CAST(1000 + ABS(CHECKSUM(NEWID()))%200000 AS DECIMAL(15,2))
);

SET @i=@i+1;

END

go

-- ==========================================
-- INSERT INTO Branches (20 Rows)
-- ==========================================

INSERT INTO Branches
(BranchName, Address, City, State, Country, ContactNumber)
VALUES
('Tashkent Main Branch','1 Amir Temur Street','Tashkent','Tashkent','Uzbekistan','+998711000001'),

('Chilonzor Branch','15 Chilonzor Street','Tashkent','Tashkent','Uzbekistan','+998711000002'),

('Yunusabad Branch','20 Yunusabad Street','Tashkent','Tashkent','Uzbekistan','+998711000003'),

('Sergeli Branch','45 Sergeli Street','Tashkent','Tashkent','Uzbekistan','+998711000004'),

('Samarkand Branch','10 Registan Street','Samarkand','Samarkand','Uzbekistan','+998662000005'),

('Bukhara Branch','7 Bukhara Center','Bukhara','Bukhara','Uzbekistan','+998652000006'),

('Navoi Branch','18 Navoi Avenue','Navoi','Navoi','Uzbekistan','+998792000007'),

('Andijan Branch','25 Bobur Street','Andijan','Andijan','Uzbekistan','+998742000008'),

('Namangan Branch','30 Namangan Road','Namangan','Namangan','Uzbekistan','+998692000009'),

('Fergana Branch','17 Fergana Avenue','Fergana','Fergana','Uzbekistan','+998732000010'),

('Jizzakh Branch','9 Mustaqillik Street','Jizzakh','Jizzakh','Uzbekistan','+998722000011'),

('Khorezm Branch','12 Urgench Street','Urgench','Khorezm','Uzbekistan','+998622000012'),

('Karakalpakstan Branch','22 Nukus Center','Nukus','Karakalpakstan','Uzbekistan','+998612000013'),

('Kashkadarya Branch','5 Qarshi Road','Qarshi','Kashkadarya','Uzbekistan','+998752000014'),

('Surkhandarya Branch','11 Termiz Street','Termiz','Surkhandarya','Uzbekistan','+998762000015'),

('Sirdarya Branch','6 Guliston Avenue','Guliston','Sirdarya','Uzbekistan','+998672000016'),

('Tashkent Region Branch','88 Nurafshon Road','Nurafshon','Tashkent Region','Uzbekistan','+998702000017'),

('Navoiy Industrial Branch','50 Industrial Zone','Navoi','Navoi','Uzbekistan','+998792000018'),

('International Banking Branch','100 International Street','Tashkent','Tashkent','Uzbekistan','+998711000019'),

('VIP Banking Branch','200 Business Center','Tashkent','Tashkent','Uzbekistan','+998711000020');

go
-- ==========================================
-- INSERT DATA INTO Employees (300 Rows)
-- ==========================================

DECLARE @i INT = 1;

WHILE @i <= 300
BEGIN

INSERT INTO Employees
(
    BranchID,
    FullName,
    Position,
    Department,
    Salary,
    HireDate,
    Status
)

VALUES
(
    ((@i-1)%20)+1,

    CONCAT('Employee ',@i),

    CASE ABS(CHECKSUM(NEWID()))%8
        WHEN 0 THEN 'Manager'
        WHEN 1 THEN 'Officer'
        WHEN 2 THEN 'Analyst'
        WHEN 3 THEN 'Cashier'
        WHEN 4 THEN 'Supervisor'
        WHEN 5 THEN 'Specialist'
        WHEN 6 THEN 'Consultant'
        ELSE 'Executive'
    END,

    CASE ABS(CHECKSUM(NEWID()))%8
        WHEN 0 THEN 'Finance'
        WHEN 1 THEN 'IT'
        WHEN 2 THEN 'Loans'
        WHEN 3 THEN 'HR'
        WHEN 4 THEN 'Customer Service'
        WHEN 5 THEN 'Operations'
        WHEN 6 THEN 'Security'
        ELSE 'Compliance'
    END,

    CAST(5000000 + ABS(CHECKSUM(NEWID()))%25000000 AS DECIMAL(15,2)),

    DATEADD(DAY,-ABS(CHECKSUM(NEWID()))%5000,GETDATE()),

    CASE ABS(CHECKSUM(NEWID()))%3
        WHEN 0 THEN 'Active'
        WHEN 1 THEN 'On Leave'
        ELSE 'Resigned'
    END
);

SET @i=@i+1;

END


go

-- ==========================================
-- INSERT INTO Departments (8 Rows)
-- ==========================================

INSERT INTO Departments
(
    DepartmentName,
    ManagerID
)

VALUES
('Finance',NULL),
('Information Technology',NULL),
('Human Resources',NULL),
('Loans',NULL),
('Operations',NULL),
('Customer Service',NULL),
('Compliance',NULL),
('Security',NULL);


go
-- ==========================================
-- INSERT DATA INTO Accounts (2500 Rows)
-- ==========================================

DECLARE @i INT = 1;

WHILE @i <= 2500
BEGIN

    DECLARE @CustomerID INT;
    DECLARE @BranchID INT;
    DECLARE @Balance DECIMAL(15,2);

    -- 1000 ta customer orasidan random tanlash
    SET @CustomerID = (ABS(CHECKSUM(NEWID())) % 1000) + 1;

    -- 20 ta branch orasidan random tanlash
    SET @BranchID = (ABS(CHECKSUM(NEWID())) % 20) + 1;

    -- KPI uchun ayrim accountlarda juda katta balance
    IF @i <= 15
        SET @Balance = 1000000 + ABS(CHECKSUM(NEWID())) % 5000000;
    ELSE
        SET @Balance = 500 + ABS(CHECKSUM(NEWID())) % 500000;

    INSERT INTO Accounts
    (
        CustomerID,
        BranchID,
        AccountType,
        Balance,
        Currency,
        CreatedDate,
        Status
    )
    VALUES
    (
        @CustomerID,

        @BranchID,

        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Savings'
            WHEN 1 THEN 'Current'
            WHEN 2 THEN 'Business'
            ELSE 'Fixed Deposit'
        END,

        @Balance,

        CASE ABS(CHECKSUM(NEWID())) % 3
            WHEN 0 THEN 'UZS'
            WHEN 1 THEN 'USD'
            ELSE 'EUR'
        END,

        DATEADD(DAY,-ABS(CHECKSUM(NEWID()))%3650,GETDATE()),

        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Active'
            WHEN 1 THEN 'Active'
            WHEN 2 THEN 'Active'
            ELSE 'Closed'
        END
    );

    SET @i = @i + 1;

END;



-- ==========================================
-- INSERT DATA INTO CreditCards (900 Rows)
-- ==========================================

DECLARE @i INT=1;

WHILE @i<=900
BEGIN

INSERT INTO CreditCards
(
CustomerID,
CardNumber,
CardType,
CVV,
ExpiryDate,
CardLimit,
Status
)

VALUES
(
@i,

CONCAT('8600',RIGHT('000000000000'+CAST(@i AS VARCHAR(12)),12)),

CASE ABS(CHECKSUM(NEWID()))%3
WHEN 0 THEN 'VISA'
WHEN 1 THEN 'MasterCard'
ELSE 'HUMO'
END,

RIGHT(100+ABS(CHECKSUM(NEWID()))%900,3),

DATEADD(YEAR,3,GETDATE()),

1000+ABS(CHECKSUM(NEWID()))%100000,

'Active'
);

SET @i=@i+1;

END


go


-- ==========================================
-- INSERT DATA INTO CreditCardTransactions (5000 Rows)
-- ==========================================

DECLARE @i INT = 1;

WHILE @i <= 5000
BEGIN

INSERT INTO CreditCardTransactions
(
    CardID,
    Merchant,
    Amount,
    Currency,
    [Date],
    Status
)

VALUES
(
    (ABS(CHECKSUM(NEWID())) % 900) + 1,

    CASE ABS(CHECKSUM(NEWID())) % 8
        WHEN 0 THEN 'Amazon'
        WHEN 1 THEN 'Uzum Market'
        WHEN 2 THEN 'Korzinka'
        WHEN 3 THEN 'Makro'
        WHEN 4 THEN 'Wildberries'
        WHEN 5 THEN 'Yandex Go'
        WHEN 6 THEN 'Shell'
        ELSE 'Apple Store'
    END,

    20 + ABS(CHECKSUM(NEWID())) % 30000,

    CASE ABS(CHECKSUM(NEWID())) % 3
        WHEN 0 THEN 'UZS'
        WHEN 1 THEN 'USD'
        ELSE 'EUR'
    END,

    DATEADD(DAY,-ABS(CHECKSUM(NEWID())) % 365,GETDATE()),

    CASE ABS(CHECKSUM(NEWID())) % 4
        WHEN 0 THEN 'Completed'
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Failed'
        ELSE 'Completed'
    END
);

SET @i = @i + 1;

END


go



-- ==========================================
-- INSERT DATA INTO OnlineBankingUsers
-- ==========================================

DECLARE @i INT=1;

WHILE @i<=800
BEGIN

INSERT INTO OnlineBankingUsers
(
CustomerID,
Username,
PasswordHash,
LastLogin
)

VALUES
(
@i,

CONCAT('user',@i),

CONVERT(VARCHAR(64),HASHBYTES('SHA2_256',CONCAT('password',@i)),2),

DATEADD(DAY,-ABS(CHECKSUM(NEWID()))%30,GETDATE())
);

SET @i=@i+1;

END


go

-- ==========================================
-- INSERT DATA INTO CreditScores
-- ==========================================

DECLARE @i INT=1;

WHILE @i<=1000
BEGIN

INSERT INTO CreditScores
(
CustomerID,
CreditScore,
UpdatedAt
)

VALUES
(
@i,

550+ABS(CHECKSUM(NEWID()))%301,

GETDATE()
);

SET @i=@i+1;

END

go


-- ==========================================
-- INSERT DATA INTO Transactions (15000 Rows)
-- ==========================================

DECLARE @i INT=1;

WHILE @i<=15000
BEGIN

INSERT INTO Transactions
(
    AccountID,
    TransactionType,
    Amount,
    Currency,
    TransactionDate,
    Status,
    ReferenceNo
)

VALUES
(
    (ABS(CHECKSUM(NEWID()))%2500)+1,

    CASE ABS(CHECKSUM(NEWID()))%6
        WHEN 0 THEN 'Deposit'
        WHEN 1 THEN 'Withdrawal'
        WHEN 2 THEN 'Transfer'
        WHEN 3 THEN 'Payment'
        WHEN 4 THEN 'Online Purchase'
        ELSE 'ATM Withdrawal'
    END,

    CASE
        WHEN @i<=50
        THEN 100000+ABS(CHECKSUM(NEWID()))%500000
        ELSE 10+ABS(CHECKSUM(NEWID()))%50000
    END,

    CASE ABS(CHECKSUM(NEWID()))%3
        WHEN 0 THEN 'UZS'
        WHEN 1 THEN 'USD'
        ELSE 'EUR'
    END,

    DATEADD(MINUTE,-ABS(CHECKSUM(NEWID()))%500000,GETDATE()),

    CASE ABS(CHECKSUM(NEWID()))%10
        WHEN 0 THEN 'Failed'
        WHEN 1 THEN 'Pending'
        ELSE 'Completed'
    END,

    CONCAT('REF',FORMAT(@i,'00000000'))
);

SET @i=@i+1;

END


go

 
 
-- ==========================================
-- BillPayments (3000 Rows)
-- CREATE TABLE: CustomerID, BillerName, Amount, PaymentDate, Status
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 3000
BEGIN
    INSERT INTO BillPayments (CustomerID, BillerName, Amount, PaymentDate, Status)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 1000) + 1,
        CASE ABS(CHECKSUM(NEWID())) % 6
            WHEN 0 THEN 'Electricity'
            WHEN 1 THEN 'Gas'
            WHEN 2 THEN 'Water'
            WHEN 3 THEN 'Internet'
            WHEN 4 THEN 'Mobile'
            ELSE 'Tax'
        END,
        20 + ABS(CHECKSUM(NEWID())) % 10000,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE()),
        'Paid'
    );
    SET @i = @i + 1;
END
 
 
go

-- ==========================================
-- MobileBankingTransactions (4000 Rows)
-- CREATE TABLE: CustomerID, DeviceID, AppVersion, TransactionType, Amount, [Date]
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 4000
BEGIN
    INSERT INTO MobileBankingTransactions (CustomerID, DeviceID, AppVersion, TransactionType, Amount, [Date])
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 1000) + 1,
        CONCAT('DEV-', ABS(CHECKSUM(NEWID())) % 999999),
        CASE ABS(CHECKSUM(NEWID())) % 3
            WHEN 0 THEN '3.1.0'
            WHEN 1 THEN '3.2.5'
            ELSE '4.0.1'
        END,
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Transfer'
            WHEN 1 THEN 'Payment'
            WHEN 2 THEN 'Deposit'
            ELSE 'Withdrawal'
        END,
        100 + ABS(CHECKSUM(NEWID())) % 50000,
        DATEADD(MINUTE, -ABS(CHECKSUM(NEWID())) % 200000, GETDATE())
    );
    SET @i = @i + 1;
END
 
 go

-- ==========================================
-- Loans (700 Rows)
-- CREATE TABLE: CustomerID, LoanType, Amount, InterestRate, StartDate, EndDate, Status
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 700
BEGIN
    INSERT INTO Loans (CustomerID, LoanType, Amount, InterestRate, StartDate, EndDate, Status)
    VALUES (
        @i,
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Home Loan'
            WHEN 1 THEN 'Car Loan'
            WHEN 2 THEN 'Business Loan'
            ELSE 'Personal Loan'
        END,
        5000 + ABS(CHECKSUM(NEWID())) % 500000,
        5 + ABS(CHECKSUM(NEWID())) % 20,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 1500, GETDATE()),
        DATEADD(YEAR, 5, GETDATE()),
        CASE
            WHEN @i <= 120 THEN 'Active'
            WHEN @i <= 200 THEN 'Defaulted'
            ELSE 'Closed'
        END
    );
    SET @i = @i + 1;
END
 
 go

-- ==========================================
-- LoanPayments (3500 Rows)
-- CREATE TABLE: LoanID, AmountPaid, PaymentDate, RemainingBalance
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 3500
BEGIN
    INSERT INTO LoanPayments (LoanID, AmountPaid, PaymentDate, RemainingBalance)
    VALUES (
        ((@i - 1) % 700) + 1,
        500 + ABS(CHECKSUM(NEWID())) % 15000,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 1200, GETDATE()),
        ABS(CHECKSUM(NEWID())) % 490000
    );
    SET @i = @i + 1;
END

go

-- ==========================================
-- DebtCollection (120 Rows)
-- CREATE TABLE: CustomerID, AmountDue, DueDate, CollectorAssigned
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 120
BEGIN
    INSERT INTO DebtCollection (CustomerID, AmountDue, DueDate, CollectorAssigned)
    VALUES (
        @i,
        10000 + ABS(CHECKSUM(NEWID())) % 500000,
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 180, GETDATE()),
        CONCAT('Collector ', (ABS(CHECKSUM(NEWID())) % 30) + 1)
    );
    SET @i = @i + 1;
END

go


-- ==========================================
-- INSERT DATA INTO KYC (1000 Rows)
-- ==========================================

DECLARE @i INT=1;

WHILE @i<=1000
BEGIN

INSERT INTO KYC
(
    CustomerID,
    DocumentType,
    DocumentNumber,
    VerifiedBy
)

VALUES
(
    @i,

    CASE ABS(CHECKSUM(NEWID()))%4
        WHEN 0 THEN 'Passport'
        WHEN 1 THEN 'National ID'
        WHEN 2 THEN 'Driving License'
        ELSE 'Residence Permit'
    END,

    CONCAT('DOC',FORMAT(@i,'0000000')),

    CONCAT('Employee ',((@i-1)%300)+1)
);

SET @i=@i+1;

END


go



-- ==========================================
--  FraudDetection (180 Rows)
-- CREATE TABLE: CustomerID, TransactionID, RiskLevel, ReportedDate
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 180
BEGIN
    INSERT INTO FraudDetection (CustomerID, TransactionID, RiskLevel, ReportedDate)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 1000) + 1,
        (ABS(CHECKSUM(NEWID())) % 15000) + 1,
        CASE ABS(CHECKSUM(NEWID())) % 3
            WHEN 0 THEN 'High'
            WHEN 1 THEN 'Medium'
            ELSE 'Low'
        END,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE())
    );
    SET @i = @i + 1;
END
 
 go
 
-- ==========================================
-- AMLCases (60 Rows)
-- CREATE TABLE: CustomerID, CaseType, Status, InvestigatorID
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 60
BEGIN
    INSERT INTO AMLCases (CustomerID, CaseType, Status, InvestigatorID)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 1000) + 1,
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Money Laundering'
            WHEN 1 THEN 'Terrorist Financing'
            WHEN 2 THEN 'Fraud'
            ELSE 'Suspicious Activity'
        END,
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Open'
            WHEN 1 THEN 'Under Review'
            WHEN 2 THEN 'Closed'
            ELSE 'Escalated'
        END,
        (ABS(CHECKSUM(NEWID())) % 300) + 1
    );
    SET @i = @i + 1;
END
 
 go
 
-- ==========================================
-- 8. RegulatoryReports (50 Rows)
-- CREATE TABLE: ReportType, SubmissionDate
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO RegulatoryReports (ReportType, SubmissionDate)
    VALUES (
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'AML Report'
            WHEN 1 THEN 'Fraud Report'
            WHEN 2 THEN 'Compliance Report'
            ELSE 'Audit Report'
        END,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE())
    );
    SET @i = @i + 1;
END
 
 go
 
-- ==========================================
-- 9. Salaries (300 Rows)
-- CREATE TABLE: EmployeeID, BaseSalary, Bonus, Deductions, PaymentDate
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 300
BEGIN
    INSERT INTO Salaries (EmployeeID, BaseSalary, Bonus, Deductions, PaymentDate)
    VALUES (
        @i,
        5000000 + ABS(CHECKSUM(NEWID())) % 25000000,
        ABS(CHECKSUM(NEWID())) % 5000000,
        ABS(CHECKSUM(NEWID())) % 2000000,
        DATEADD(MONTH, -ABS(CHECKSUM(NEWID())) % 12, GETDATE())
    );
    SET @i = @i + 1;
END
 
 go
 
-- ==========================================
-- 10. EmployeeAttendance (9000 Rows)
-- CREATE TABLE: EmployeeID, CheckInTime, CheckOutTime, TotalHours
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 9000
BEGIN
    DECLARE @CheckIn DATETIME = DATEADD(MINUTE, -ABS(CHECKSUM(NEWID())) % 43200, GETDATE());
    DECLARE @CheckOut DATETIME = DATEADD(HOUR, 8 + ABS(CHECKSUM(NEWID())) % 3, @CheckIn);
 
    INSERT INTO EmployeeAttendance (EmployeeID, CheckInTime, CheckOutTime, TotalHours)
    VALUES (
        ((@i - 1) % 300) + 1,
        @CheckIn,
        @CheckOut,
        CAST(DATEDIFF(MINUTE, @CheckIn, @CheckOut) / 60.0 AS DECIMAL(5,2))
    );
    SET @i = @i + 1;
END
 
 go

-- ==========================================
-- 11. Investments (450 Rows)
-- CREATE TABLE: CustomerID, InvestmentType, Amount, ROI, MaturityDate
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 450
BEGIN
    INSERT INTO Investments (CustomerID, InvestmentType, Amount, ROI, MaturityDate)
    VALUES (
        @i,
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Mutual Fund'
            WHEN 1 THEN 'Government Bond'
            WHEN 2 THEN 'Corporate Bond'
            ELSE 'Fixed Investment'
        END,
        1000 + ABS(CHECKSUM(NEWID())) % 500000,
        CAST(3 + ABS(CHECKSUM(NEWID())) % 22 AS DECIMAL(5,2)),
        DATEADD(YEAR, 5, GETDATE())
    );
    SET @i = @i + 1;
END
 
 go
 
-- ==========================================
-- 12. StockTradingAccounts (250 Rows)
-- CREATE TABLE: CustomerID, BrokerageFirm, TotalInvested, CurrentValue
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 250
BEGIN
    DECLARE @Invested DECIMAL(15,2) = 5000 + ABS(CHECKSUM(NEWID())) % 1000000;
 
    INSERT INTO StockTradingAccounts (CustomerID, BrokerageFirm, TotalInvested, CurrentValue)
    VALUES (
        @i,
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Freedom Broker'
            WHEN 1 THEN 'Interactive Brokers'
            WHEN 2 THEN 'TBC Invest'
            ELSE 'Capital Markets'
        END,
        @Invested,
        @Invested * (0.8 + (ABS(CHECKSUM(NEWID())) % 40) / 100.0)
    );
    SET @i = @i + 1;
END
 
 go
 
-- ==========================================
-- 13. ForeignExchange (700 Rows)
-- CREATE TABLE: CustomerID, CurrencyPair, ExchangeRate, AmountExchanged
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 700
BEGIN
    INSERT INTO ForeignExchange (CustomerID, CurrencyPair, ExchangeRate, AmountExchanged)
    VALUES (
        @i,
        CASE ABS(CHECKSUM(NEWID())) % 3
            WHEN 0 THEN 'USD/UZS'
            WHEN 1 THEN 'USD/EUR'
            ELSE 'USD/GBP'
        END,
        CASE ABS(CHECKSUM(NEWID())) % 3
            WHEN 0 THEN 12650.0000
            WHEN 1 THEN 0.9200
            ELSE 0.7900
        END,
        100 + ABS(CHECKSUM(NEWID())) % 10000
    );
    SET @i = @i + 1;
END
 
 go

-- ==========================================
-- 14. InsurancePolicies (500 Rows)
-- CREATE TABLE: CustomerID, InsuranceType, PremiumAmount, CoverageAmount
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 500
BEGIN
    DECLARE @Premium DECIMAL(15,2) = 500 + ABS(CHECKSUM(NEWID())) % 50000;
 
    INSERT INTO InsurancePolicies (CustomerID, InsuranceType, PremiumAmount, CoverageAmount)
    VALUES (
        @i,
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Life'
            WHEN 1 THEN 'Vehicle'
            WHEN 2 THEN 'Health'
            ELSE 'Property'
        END,
        @Premium,
        @Premium * (10 + ABS(CHECKSUM(NEWID())) % 40)
    );
    SET @i = @i + 1;
END
 
 go

-- ==========================================
-- 15. Claims (180 Rows)
-- CREATE TABLE: PolicyID, ClaimAmount, Status, FiledDate
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 180
BEGIN
    INSERT INTO Claims (PolicyID, ClaimAmount, Status, FiledDate)
    VALUES (
        @i,
        1000 + ABS(CHECKSUM(NEWID())) % 100000,
        CASE ABS(CHECKSUM(NEWID())) % 3
            WHEN 0 THEN 'Approved'
            WHEN 1 THEN 'Rejected'
            ELSE 'Pending'
        END,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE())
    );
    SET @i = @i + 1;
END
 
 go
 
-- ==========================================
-- 16. UserAccessLogs (12000 Rows)
-- CREATE TABLE: UserID, ActionType, TimeStamp
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 12000
BEGIN
    INSERT INTO UserAccessLogs (UserID, ActionType, TimeStamp)
    VALUES (
        ((@i - 1) % 800) + 1,
        CASE ABS(CHECKSUM(NEWID())) % 5
            WHEN 0 THEN 'Login'
            WHEN 1 THEN 'Logout'
            WHEN 2 THEN 'Transfer'
            WHEN 3 THEN 'View Balance'
            ELSE 'Password Change'
        END,
        DATEADD(MINUTE, -ABS(CHECKSUM(NEWID())) % 500000, GETDATE())
    );
    SET @i = @i + 1;
END
 
 go
 
-- ==========================================
-- 17. CyberSecurityIncidents (40 Rows)
-- CREATE TABLE: AffectedSystem, ReportedDate, ResolutionStatus
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 40
BEGIN
    INSERT INTO CyberSecurityIncidents (AffectedSystem, ReportedDate, ResolutionStatus)
    VALUES (
        CASE ABS(CHECKSUM(NEWID())) % 5
            WHEN 0 THEN 'Online Banking Portal'
            WHEN 1 THEN 'Mobile App'
            WHEN 2 THEN 'Core Banking System'
            WHEN 3 THEN 'ATM Network'
            ELSE 'Internal Network'
        END,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE()),
        'Resolved'
    );
    SET @i = @i + 1;
END
 
 go

-- ==========================================
-- 18. Merchants (180 Rows)
-- CREATE TABLE: MerchantName, Industry, Location, CustomerID
-- ==========================================
 
DECLARE @i INT = 1;
WHILE @i <= 180
BEGIN
    INSERT INTO Merchants (MerchantName, Industry, Location, CustomerID)
    VALUES (
        CONCAT('Merchant ', @i),
        CASE ABS(CHECKSUM(NEWID())) % 8
            WHEN 0 THEN 'Supermarket'
            WHEN 1 THEN 'Restaurant'
            WHEN 2 THEN 'Electronics'
            WHEN 3 THEN 'Clothing'
            WHEN 4 THEN 'Hotel'
            WHEN 5 THEN 'Fuel Station'
            WHEN 6 THEN 'Hospital'
            ELSE 'Pharmacy'
        END,
        CASE ABS(CHECKSUM(NEWID())) % 8
            WHEN 0 THEN 'Tashkent, Uzbekistan'
            WHEN 1 THEN 'Samarkand, Uzbekistan'
            WHEN 2 THEN 'Bukhara, Uzbekistan'
            WHEN 3 THEN 'Andijan, Uzbekistan'
            WHEN 4 THEN 'Namangan, Uzbekistan'
            WHEN 5 THEN 'Fergana, Uzbekistan'
            WHEN 6 THEN 'Nukus, Uzbekistan'
            ELSE 'Navoi, Uzbekistan'
        END,
        (ABS(CHECKSUM(NEWID())) % 1000) + 1
    );
    SET @i = @i + 1;
END

go

-- ==========================================
-- INSERT DATA INTO MerchantTransactions (4000 Rows)
-- ==========================================

DECLARE @i INT = 1;

WHILE @i <= 4000
BEGIN

INSERT INTO MerchantTransactions
(
    MerchantID,
    Amount,
    PaymentMethod,
    [Date]
)

VALUES
(
    (ABS(CHECKSUM(NEWID())) % 180) + 1,

    100 + ABS(CHECKSUM(NEWID())) % 100000,

    CASE ABS(CHECKSUM(NEWID())) % 5
        WHEN 0 THEN 'Cash'
        WHEN 1 THEN 'Debit Card'
        WHEN 2 THEN 'Credit Card'
        WHEN 3 THEN 'Mobile Banking'
        ELSE 'Bank Transfer'
    END,

    DATEADD(DAY,-ABS(CHECKSUM(NEWID())) % 365,GETDATE())
);

SET @i = @i + 1;

END


go



-- 1. Top 3 Customers with the Highest Total Balance Across All Accounts 


SELECT TOP 3
    c.CustomerID,
    c.FullName,
    SUM(a.Balance) AS TotalBalance
FROM Customers c
JOIN Accounts a
ON c.CustomerID = a.CustomerID
GROUP BY
    c.CustomerID,
    c.FullName
ORDER BY TotalBalance DESC;

select * from customers
select * from accounts

-- 2. Customers Who Have More Than One Active Loan


SELECT
    c.CustomerID,
    c.FullName,
    COUNT(l.LoanID) AS ActiveLoans
FROM Customers c
JOIN Loans l
ON c.CustomerID = l.CustomerID
WHERE l.Status='Active'
GROUP BY
    c.CustomerID,
    c.FullName
HAVING COUNT(l.LoanID) > 1;

select * from customers
select * from loans

-- 3. Transactions That Were Flagged as Fraudulent


SELECT
    t.TransactionID,
    c.CustomerID,
    c.FullName,
    t.TransactionType,
    t.Amount,
    t.Currency,
    f.RiskLevel,
    f.ReportedDate
FROM FraudDetection f
JOIN Transactions t
ON f.TransactionID=t.TransactionID
JOIN Customers c
ON f.CustomerID=c.CustomerID
ORDER BY f.ReportedDate DESC;


select * from customers
select * from Transactions
select * from FraudDetection

-- 4. Total Loan Amount Issued Per Branch


SELECT
    b.BranchID,
    b.BranchName,
    SUM(l.Amount) AS TotalLoanAmount
FROM Loans l
JOIN Customers c
    ON l.CustomerID = c.CustomerID
JOIN (
    SELECT CustomerID, MIN(BranchID) AS BranchID
    FROM Accounts
    GROUP BY CustomerID
) a
    ON c.CustomerID = a.CustomerID
JOIN Branches b
    ON a.BranchID = b.BranchID
GROUP BY
    b.BranchID,
    b.BranchName
ORDER BY TotalLoanAmount DESC;


select * from customers
select * from Loans
select * from Accounts
select * from Branches

-- 5. Customers who made multiple large transactions (above $10,000) within a short time frame (less than 1 hour apart)



ALTER TABLE Transactions
ADD Country VARCHAR(100);

go

UPDATE Transactions
SET Country =
CASE ABS(CHECKSUM(NEWID())) % 6
    WHEN 0 THEN 'Uzbekistan'
    WHEN 1 THEN 'Kazakhstan'
    WHEN 2 THEN 'Turkey'
    WHEN 3 THEN 'UAE'
    WHEN 4 THEN 'Germany'
    ELSE 'USA'
END;


SELECT
    c.CustomerID,
    c.FullName,

    t1.TransactionID AS Transaction1,
    t2.TransactionID AS Transaction2,

    t1.Amount AS Amount1,
    t2.Amount AS Amount2,

    t1.TransactionDate AS FirstTransaction,
    t2.TransactionDate AS SecondTransaction,

    DATEDIFF(MINUTE,
             t1.TransactionDate,
             t2.TransactionDate) AS MinutesApart

FROM Transactions t1

JOIN Transactions t2
ON t1.AccountID=t2.AccountID
AND t1.TransactionID<t2.TransactionID

JOIN Accounts a
ON t1.AccountID=a.AccountID

JOIN Customers c
ON a.CustomerID=c.CustomerID

WHERE
    t1.Amount>10000
    AND t2.Amount>10000
    AND ABS(DATEDIFF(MINUTE,
                     t1.TransactionDate,
                     t2.TransactionDate))<=60

ORDER BY
    c.CustomerID,
    MinutesApart;


select * from Transactions
select * from Accounts
select * from Customers


-- 6	Customers who have made transactions from different countries within 10 minutes, a common red flag for fraud.


SELECT DISTINCT
    c.CustomerID,
    c.FullName,

    t1.TransactionID AS Transaction1,
    t2.TransactionID AS Transaction2,

    t1.Country AS Country1,
    t2.Country AS Country2,

    t1.TransactionDate AS Time1,
    t2.TransactionDate AS Time2,

    DATEDIFF(MINUTE,
             t1.TransactionDate,
             t2.TransactionDate) AS MinutesApart

FROM Transactions t1

JOIN Transactions t2
ON t1.AccountID = t2.AccountID
AND t1.TransactionID < t2.TransactionID

JOIN Accounts a
ON t1.AccountID = a.AccountID

JOIN Customers c
ON a.CustomerID = c.CustomerID

WHERE
    t1.Country <> t2.Country
    AND ABS(DATEDIFF(MINUTE,
                     t1.TransactionDate,
                     t2.TransactionDate)) <= 10

ORDER BY
    c.CustomerID;
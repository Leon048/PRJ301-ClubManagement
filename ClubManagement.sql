CREATE DATABASE ClubManagement;
GO

USE ClubManagement;
GO

CREATE TABLE Clubs (
    ClubID INT PRIMARY KEY IDENTITY(1,1),
    ClubName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    EstablishedDate DATE NULL
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL CHECK (Role IN ('Admin', 'Chairman', 'ViceChairman', 'TeamLeader', 'Member')),
    ClubID INT NULL,
    FOREIGN KEY (ClubID) REFERENCES Clubs(ClubID)
);

CREATE TABLE Events (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    EventName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    EventDate DATETIME NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    ClubID INT NULL,
    FOREIGN KEY (ClubID) REFERENCES Clubs(ClubID)
);

CREATE TABLE EventParticipants (
    EventParticipantID INT PRIMARY KEY IDENTITY(1,1),
    EventID INT NOT NULL,
    UserID INT NOT NULL,
    Status NVARCHAR(20) NOT NULL CHECK (Status IN ('Registered', 'Attended', 'Absent')),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Reports (
    ReportID INT PRIMARY KEY IDENTITY(1,1),
    ClubID INT NOT NULL,
    Semester NVARCHAR(20) NOT NULL,
    MemberChanges NVARCHAR(MAX) NULL,
    EventSummary NVARCHAR(MAX) NULL,
    ParticipationStats NVARCHAR(MAX) NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ClubID) REFERENCES Clubs(ClubID)
);

CREATE TABLE EventRegistrations (
    RegistrationID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    EventID INT NOT NULL,
    RegistrationDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Registration_User FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    CONSTRAINT FK_Registration_Event FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE,
    CONSTRAINT UQ_User_Event UNIQUE (UserID, EventID) -- Đảm bảo một người chỉ đăng ký một lần
);

INSERT INTO Users (FullName, Email, Password, Role, ClubID) VALUES
('Admin User', 'admin@example.com', '123456', 'Admin', NULL),
('Nguyễn Văn A', 'chairman@example.com', '123456', 'Chairman', 1),
('Trần Thị B', 'vicechairman@example.com', '123456', 'ViceChairman', 1),
('Lê Văn C', 'member1@example.com', '123456', 'Member', 1),
('Hoàng Minh D', 'member2@example.com', '123456', 'Member', 2);

INSERT INTO Clubs (ClubName, Description, EstablishedDate) VALUES
('CLB Công Nghệ', 'Nơi giao lưu học hỏi về lập trình', '2015-06-15'),
('CLB Kinh Doanh', 'Mạng lưới kết nối doanh nhân trẻ', '2018-09-20');

INSERT INTO Events (EventName, Description, EventDate, Location, ClubID) VALUES
('Hội Thảo AI', 'Tìm hiểu về trí tuệ nhân tạo', '2024-04-10', 'Hội trường A', 1),
('Workshop Khởi Nghiệp', 'Chia sẻ kinh nghiệm khởi nghiệp', '2024-05-05', 'Phòng họp 102', 2);

INSERT INTO EventRegistrations (UserID, EventID) VALUES
(4, 1), -- Lê Văn C tham gia "Hội Thảo AI"
(5, 2); -- Hoàng Minh D tham gia "Workshop Khởi Nghiệp"

--Xem danh sách sự kiện và số người tham gia
SELECT e.EventID, e.EventName, e.EventDate, e.Location, c.ClubName, 
       COUNT(er.UserID) AS TotalParticipants
FROM Events e
LEFT JOIN Clubs c ON e.ClubID = c.ClubID
LEFT JOIN EventRegistrations er ON e.EventID = er.EventID
GROUP BY e.EventID, e.EventName, e.EventDate, e.Location, c.ClubName;

--Xem danh sách thành viên và CLB
SELECT u.UserID, u.FullName, u.Email, u.Role, 
       ISNULL(c.ClubName, 'Không có CLB') AS ClubName
FROM Users u
LEFT JOIN Clubs c ON u.ClubID = c.ClubID;

--Xem danh sách thành viên đã tham gia sự kiện
SELECT u.FullName, u.Email, e.EventName, e.EventDate, e.Location
FROM EventRegistrations er
JOIN Users u ON er.UserID = u.UserID
JOIN Events e ON er.EventID = e.EventID;

select * from Users
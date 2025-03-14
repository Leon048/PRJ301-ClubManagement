package dao;

import model.User;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public User validateUser(String email, String password) {
        String sql = "SELECT UserID, FullName, Email, Role, ClubID FROM Users WHERE Email = ? AND Password = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("UserID"),
                            rs.getString("FullName"),
                            rs.getString("Email"),
                            rs.getString("Role"),
                            rs.getInt("ClubID")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT UserID, FullName, Email, Password, Role, ClubID FROM Users WHERE Email = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User(rs.getInt("UserID"), rs.getString("FullName"),
                        rs.getString("Email"), rs.getString("Password"),
                        rs.getString("Role"), rs.getInt("ClubID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                users.add(new User(rs.getInt("UserID"), rs.getString("FullName"),
                        rs.getString("Email"), rs.getString("Password"),
                        rs.getString("Role"), rs.getInt("ClubID")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean addUser(User user) {
        String sql = "INSERT INTO Users (FullName, Email, Password, Role, ClubID) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // TODO: Hash mật khẩu trước khi lưu
            ps.setString(4, user.getRole());
            ps.setInt(5, user.getClubId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserById(int userId) {
        User user = null;
        String sql = "SELECT * FROM Users WHERE UserID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ClubID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean updateUser(User user) {
        String updateSQL;
        boolean updatePassword = (user.getPassword() != null && !user.getPassword().trim().isEmpty());

        if (updatePassword) {
            updateSQL = "UPDATE Users SET FullName = ?, Password = ?, Role = ?, ClubID = ? WHERE UserID = ?";
        } else {
            updateSQL = "UPDATE Users SET FullName = ?, Role = ?, ClubID = ? WHERE UserID = ?";
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(updateSQL)) {

            ps.setString(1, user.getFullName());

            if (updatePassword) {
                ps.setString(2, user.getPassword());
                ps.setString(3, user.getRole());
                ps.setInt(4, user.getClubId());
                ps.setInt(5, user.getUserId());
            } else {
                ps.setString(2, user.getRole());
                ps.setInt(3, user.getClubId());
                ps.setInt(4, user.getUserId());
            }

            return ps.executeUpdate() > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM Users WHERE UserID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            return ps.executeUpdate() > 0; // Trả về true nếu xóa thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Trả về false nếu có lỗi
    }

    // Lấy danh sách tất cả thành viên (trừ Admin)
    public List<User> getAllMembers() {
        List<User> members = new ArrayList<>();
        String sql = "SELECT u.UserID, u.FullName, u.Email, u.Role, c.ClubID, c.ClubName "
                + "FROM Users u LEFT JOIN Clubs c ON u.ClubID = c.ClubID "
                + "WHERE u.Role <> 'Admin'";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int clubId = rs.getInt("ClubID"); // Lấy ID của CLB (nếu có)
                String clubName = rs.getString("ClubName"); // Lấy tên CLB

                User member = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Role"),
                        clubId, // Truyền ClubID dạng int
                        clubName // Truyền ClubName dạng String
                );
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }

    public boolean addMember(User user) {
        String checkEmailSQL = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        String insertSQL = "INSERT INTO Users (FullName, Email, Password, Role, ClubID) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement checkStmt = conn.prepareStatement(checkEmailSQL); PreparedStatement insertStmt = conn.prepareStatement(insertSQL)) {

            // Kiểm tra xem email đã tồn tại chưa
            checkStmt.setString(1, user.getEmail());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false; // Email đã tồn tại
            }

            // Thêm thành viên mới vào database
            insertStmt.setString(1, user.getFullName());
            insertStmt.setString(2, user.getEmail());
            insertStmt.setString(3, user.getPassword());
            insertStmt.setString(4, user.getRole());
            insertStmt.setInt(5, user.getClubId()); // ClubID có thể là 0 nếu không có CLB

            return insertStmt.executeUpdate() > 0; // Trả về true nếu thêm thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateMember(User user) {
        String updateSQL;
        boolean updatePassword = (user.getPassword() != null && !user.getPassword().trim().isEmpty());

        if (updatePassword) {
            updateSQL = "UPDATE Users SET FullName = ?, Password = ?, Role = ?, ClubID = ? WHERE UserID = ?";
        } else {
            updateSQL = "UPDATE Users SET FullName = ?, Role = ?, ClubID = ? WHERE UserID = ?";
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(updateSQL)) {

            ps.setString(1, user.getFullName());

            if (updatePassword) {
                ps.setString(2, user.getPassword());
                ps.setString(3, user.getRole());
                ps.setInt(4, user.getClubId());
                ps.setInt(5, user.getUserId());
            } else {
                ps.setString(2, user.getRole());
                ps.setInt(3, user.getClubId());
                ps.setInt(4, user.getUserId());
            }

            return ps.executeUpdate() > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteMember(int userId) {
        String checkRoleSQL = "SELECT Role FROM Users WHERE UserID = ?";
        String deleteRegistrationsSQL = "DELETE FROM EventRegistrations WHERE UserID = ?";
        String deleteUserSQL = "DELETE FROM Users WHERE UserID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement checkStmt = conn.prepareStatement(checkRoleSQL); PreparedStatement deleteRegStmt = conn.prepareStatement(deleteRegistrationsSQL); PreparedStatement deleteStmt = conn.prepareStatement(deleteUserSQL)) {

            // Kiểm tra vai trò của thành viên
            checkStmt.setInt(1, userId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && "Admin".equals(rs.getString("Role"))) {
                return false; // Không cho phép xóa Admin
            }

            // Xóa tất cả đăng ký sự kiện của thành viên trước
            deleteRegStmt.setInt(1, userId);
            deleteRegStmt.executeUpdate();

            // Xóa thành viên khỏi bảng Users
            deleteStmt.setInt(1, userId);
            return deleteStmt.executeUpdate() > 0; // Trả về true nếu xóa thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUserProfile(String email, String fullName) {
        String sql = "UPDATE Users SET FullName = ? WHERE Email = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ps.setString(2, email);

            return ps.executeUpdate() > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}

package dao;

import model.Event;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
public class EventDAO {

    // Lấy danh sách tất cả sự kiện
    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.EventID, e.EventName, e.Description, e.EventDate, e.Location, c.ClubName "
                + "FROM Events e JOIN Clubs c ON e.ClubID = c.ClubID";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                events.add(new Event(
                        rs.getInt("EventID"),
                        rs.getString("EventName"),
                        rs.getString("Description"),
                        rs.getDate("EventDate"),
                        rs.getString("Location"),
                        rs.getString("ClubName")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    // Lấy thông tin một sự kiện theo ID
    public Event getEventById(int eventId) {
        String sql = "SELECT e.EventID, e.EventName, e.Description, e.EventDate, e.Location, c.ClubName "
                + "FROM Events e JOIN Clubs c ON e.ClubID = c.ClubID WHERE e.EventID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Event(
                        rs.getInt("EventID"),
                        rs.getString("EventName"),
                        rs.getString("Description"),
                        rs.getDate("EventDate"),
                        rs.getString("Location"),
                        rs.getString("ClubName")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm một sự kiện mới
    public boolean addEvent(Event event) {
        String sql = "INSERT INTO Events (EventName, Description, EventDate, Location, ClubID) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, event.getEventName());
            ps.setString(2, event.getDescription());
            ps.setDate(3, new java.sql.Date(event.getEventDate().getTime()));
            ps.setString(4, event.getLocation());
            ps.setInt(5, event.getClubId());

            return ps.executeUpdate() > 0; // Trả về true nếu thêm thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin một sự kiện
    public boolean updateEvent(Event event) {
        String sql = "UPDATE Events SET EventName = ?, Description = ?, EventDate = ?, Location = ?, ClubID = ? WHERE EventID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, event.getEventName());
            ps.setString(2, event.getDescription());
            ps.setDate(3, new java.sql.Date(event.getEventDate().getTime()));
            ps.setString(4, event.getLocation());
            ps.setInt(5, event.getClubId());
            ps.setInt(6, event.getEventId());

            return ps.executeUpdate() > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa một sự kiện
    public boolean deleteEvent(int eventId) {
        String deleteRegistrationsSQL = "DELETE FROM EventRegistrations WHERE EventID = ?";
        String deleteEventSQL = "DELETE FROM Events WHERE EventID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps1 = conn.prepareStatement(deleteRegistrationsSQL); PreparedStatement ps2 = conn.prepareStatement(deleteEventSQL)) {

            // Xóa tất cả đăng ký trước
            ps1.setInt(1, eventId);
            ps1.executeUpdate();

            // Xóa sự kiện
            ps2.setInt(1, eventId);
            return ps2.executeUpdate() > 0; // Trả về true nếu xóa thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy danh sách người tham gia một sự kiện
    public List<User> getParticipantsByEvent(int eventId) {
        List<User> participants = new ArrayList<>();
        String sql = "SELECT u.UserID, u.FullName, u.Email, u.Role "
                + "FROM EventRegistrations er "
                + "JOIN Users u ON er.UserID = u.UserID "
                + "WHERE er.EventID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                participants.add(new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Role") // Constructor mới chỉ cần userId, fullName, email, role
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return participants;
    }

    public boolean removeParticipant(int eventId, int userId) {
        String sql = "DELETE FROM EventRegistrations WHERE EventID = ? AND UserID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0; // Trả về true nếu xóa thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}

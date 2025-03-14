/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Event;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
public class EventRegistrationDAO {

    public boolean registerUserForEvent(int userId, int eventId) {
        String sql = "INSERT INTO EventRegistrations (UserID, EventID) VALUES (?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, eventId);

            return ps.executeUpdate() > 0; // Trả về true nếu đăng ký thành công
        } catch (SQLException e) {
            return false; // Nếu trùng lặp, trả về false
        }
    }

    public List<String> getParticipants(int eventId) {
        List<String> participants = new ArrayList<>();
        String sql = "SELECT u.FullName FROM EventRegistrations er JOIN Users u ON er.UserID = u.UserID WHERE er.EventID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                participants.add(rs.getString("FullName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return participants;
    }

    public boolean isUserRegistered(int userId, int eventId) {
        String sql = "SELECT COUNT(*) FROM EventRegistrations WHERE UserID = ? AND EventID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu có bản ghi, trả về true
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean unregisterUserFromEvent(int userId, int eventId) {
        String sql = "DELETE FROM EventRegistrations WHERE UserID = ? AND EventID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            return ps.executeUpdate() > 0; // Trả về true nếu xóa thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

     // Lấy danh sách sự kiện mà một người dùng đã tham gia
    public List<Event> getEventsByUser(int userId) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.EventID, e.EventName, e.EventDate, e.Location " +
                     "FROM EventRegistrations er " +
                     "JOIN Events e ON er.EventID = e.EventID " +
                     "WHERE er.UserID = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                events.add(new Event(
                        rs.getInt("EventID"),
                        rs.getString("EventName"),
                        null,
                        rs.getDate("EventDate"),
                        rs.getString("Location"),
                        null
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    // Lấy lịch sử đăng ký của tất cả thành viên (Admin/Chủ nhiệm)
    public List<Event> getAllEventHistory() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.EventID, e.EventName, e.EventDate, e.Location, u.FullName " +
                     "FROM EventRegistrations er " +
                     "JOIN Events e ON er.EventID = e.EventID " +
                     "JOIN Users u ON er.UserID = u.UserID";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("EventID"),
                        rs.getString("EventName"),
                        null,
                        rs.getDate("EventDate"),
                        rs.getString("Location"),
                        null
                );
                event.setRegisteredUserName(rs.getString("FullName"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
}

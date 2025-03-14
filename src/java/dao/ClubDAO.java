/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Club;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
/**
 *
 * @author admin
 */
public class ClubDAO {
    
    public Club getClubById(int clubId) {
        String sql = "SELECT * FROM Clubs WHERE ClubID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Club(
                    rs.getInt("ClubID"),
                    rs.getString("ClubName"),
                    rs.getDate("EstablishedDate")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy CLB
    }

    public List<Club> getAllClubs() {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT * FROM Clubs";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                clubs.add(new Club(rs.getInt("ClubID"), rs.getString("ClubName"),
                        rs.getString("Description"), rs.getDate("EstablishedDate")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }

    public boolean addClub(Club club) {
        String sql = "INSERT INTO Clubs (ClubName, Description, EstablishedDate) VALUES (?, ?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, club.getClubName());
            ps.setString(2, club.getDescription());
            ps.setDate(3, new java.sql.Date(club.getEstablishedDate().getTime()));

            return ps.executeUpdate() > 0; // Trả về true nếu thêm thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Trả về false nếu có lỗi
    }

    public boolean updateClub(Club club) {
        String sql = "UPDATE Clubs SET ClubName = ?, Description = ?, EstablishedDate = ? WHERE ClubID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, club.getClubName());
            ps.setString(2, club.getDescription());
            ps.setDate(3, new java.sql.Date(club.getEstablishedDate().getTime()));
            ps.setInt(4, club.getClubId());

            return ps.executeUpdate() > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteClub(int clubId) {
        String sql = "DELETE FROM Clubs WHERE ClubID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, clubId);
            return ps.executeUpdate() > 0; // Trả về true nếu xóa thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Trả về false nếu có lỗi
    }
}

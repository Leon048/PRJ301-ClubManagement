/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Report;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
public class ReportDAO {

    public List<Report> getAllReports() {
        List<Report> reports = new ArrayList<>();
        String sql = "SELECT * FROM Reports";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                reports.add(new Report(
                        rs.getInt("ReportID"),
                        rs.getInt("ClubID"),
                        rs.getString("Semester"),
                        rs.getString("MemberChanges"),
                        rs.getString("EventSummary"),
                        rs.getString("ParticipationStats"),
                        rs.getTimestamp("CreatedDate")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    public Report getReportById(int reportId) {
        Report report = null;
        String sql = "SELECT * FROM Reports WHERE ReportID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, reportId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Timestamp createdDate = rs.getTimestamp("CreatedDate");
                if (createdDate == null) {
                    createdDate = new Timestamp(System.currentTimeMillis()); // Gán thời gian hiện tại nếu NULL
                }

                report = new Report(
                        rs.getInt("ReportID"),
                        rs.getInt("ClubID"),
                        rs.getString("Semester"),
                        rs.getString("MemberChanges"),
                        rs.getString("EventSummary"),
                        rs.getString("ParticipationStats"),
                        createdDate
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return report;
    }
}

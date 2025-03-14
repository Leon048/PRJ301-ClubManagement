/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

public class Report {

    private int reportId;
    private int clubId;
    private String semester;
    private String memberChanges;
    private String eventSummary;
    private String participationStats;
    private Timestamp createdDate;

    public Report() {
    }

    public Report(int reportId, int clubId, String semester, String memberChanges, String eventSummary, String participationStats, Timestamp createdDate) {
        this.reportId = reportId;
        this.clubId = clubId;
        this.semester = semester;
        this.memberChanges = memberChanges;
        this.eventSummary = eventSummary;
        this.participationStats = participationStats;
        this.createdDate = createdDate;
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getClubId() {
        return clubId;
    }

    public void setClubId(int clubId) {
        this.clubId = clubId;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getMemberChanges() {
        return memberChanges;
    }

    public void setMemberChanges(String memberChanges) {
        this.memberChanges = memberChanges;
    }

    public String getEventSummary() {
        return eventSummary;
    }

    public void setEventSummary(String eventSummary) {
        this.eventSummary = eventSummary;
    }

    public String getParticipationStats() {
        return participationStats;
    }

    public void setParticipationStats(String participationStats) {
        this.participationStats = participationStats;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "Report{" + "reportId=" + reportId + ", clubId=" + clubId + ", semester=" + semester + ", memberChanges=" + memberChanges + ", eventSummary=" + eventSummary + ", participationStats=" + participationStats + ", createdDate=" + createdDate + '}';
    }

}

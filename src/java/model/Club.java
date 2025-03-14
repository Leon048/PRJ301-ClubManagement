/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author admin
 */
public class Club {

    private int clubId;
    private String clubName;
    private String description;
    private Date establishedDate;

    public Club() {
    }

    public Club(int clubId, String clubName, Date establishedDate) {
        this.clubId = clubId;
        this.clubName = clubName;
        this.establishedDate = establishedDate;
    }

    public Club(int clubId, String clubName, String description, Date establishedDate) {
        this.clubId = clubId;
        this.clubName = clubName;
        this.description = description;
        this.establishedDate = establishedDate;
    }

    public int getClubId() {
        return clubId;
    }

    public void setClubId(int clubId) {
        this.clubId = clubId;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getEstablishedDate() {
        return establishedDate;
    }

    public void setEstablishedDate(Date establishedDate) {
        this.establishedDate = establishedDate;
    }

    @Override
    public String toString() {
        return "Club{" + "clubId=" + clubId + ", clubName=" + clubName + ", description=" + description + ", establishedDate=" + establishedDate + '}';
    }

}

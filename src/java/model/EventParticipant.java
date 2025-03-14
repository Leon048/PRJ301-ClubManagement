/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class EventParticipant {

    private int eventParticipantId;
    private int eventId;
    private int userId;
    private String status;  // ('Registered', 'Attended', 'Absent')

    public EventParticipant() {
    }

    public EventParticipant(int eventParticipantId, int eventId, int userId, String status) {
        this.eventParticipantId = eventParticipantId;
        this.eventId = eventId;
        this.userId = userId;
        this.status = status;
    }

    public int getEventParticipantId() {
        return eventParticipantId;
    }

    public void setEventParticipantId(int eventParticipantId) {
        this.eventParticipantId = eventParticipantId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "EventParticipant{" + "eventParticipantId=" + eventParticipantId + ", eventId=" + eventId + ", userId=" + userId + ", status=" + status + '}';
    }

}

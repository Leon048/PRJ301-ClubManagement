/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class User {

    private int userId;
    private String fullName;
    private String email;
    private String password;
    private String role;
    private int clubId;
    private String clubName;

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public User(int userId, String fullName, String email, String password, String role, int clubId, String clubName) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.clubId = clubId;
        this.clubName = clubName;
    }

    public User(int userId, String fullName, String password, String role, int clubId) {
        this.userId = userId;
        this.fullName = fullName;
        this.password = password;
        this.role = role;
        this.clubId = clubId;
    }

    public User(int userId, String fullName, String email, String role) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.role = role;
    }

    public User() {
    }

    public User(String fullName, String email, String password, String role, int clubId) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.clubId = clubId;
    }

    public User(int userId, String fullName, String email, String role, int clubId, String clubName) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.role = role;
        this.clubId = clubId;
        this.clubName = clubName;
    }

    public User(int userId, String fullName, String email, String password, String role, int clubId) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.clubId = clubId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getClubId() {
        return clubId;
    }

    public void setClubId(int clubId) {
        this.clubId = clubId;
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", fullName=" + fullName + ", email=" + email + ", password=" + password + ", role=" + role + ", clubId=" + clubId + ", clubName=" + clubName + '}';
    }

}

package model;

import java.io.Serializable;

public class SignUpData implements Serializable {
    private String email;
    private String password;
    private String nickname;
    private String birthdate;
    private String gender;
    private String genre; // ✅ 추가된 필드 (좋아하는 음악 장르)

    // Getter & Setter
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getBirthdate() { return birthdate; }
    public void setBirthdate(String birthdate) { this.birthdate = birthdate; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getGenre() { return genre; } // ✅ 추가된 Getter
    public void setGenre(String genre) { this.genre = genre; } // ✅ 추가된 Setter
}

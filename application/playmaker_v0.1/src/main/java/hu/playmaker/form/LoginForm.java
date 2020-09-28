
package hu.playmaker.form;

public class LoginForm {

    private String username;
    private String password;
    private String _csrf;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String get_csrf() {
        return _csrf;
    }

    public void set_csrf(String _csrf) {
        this._csrf = _csrf;
    }
}

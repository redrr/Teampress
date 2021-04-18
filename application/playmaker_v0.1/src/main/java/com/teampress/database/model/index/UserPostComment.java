package com.teampress.database.model.index;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.User;
import org.json.JSONObject;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name="USERPOSTCOMMENT", schema="teampress")
@NamedQueries({
        @NamedQuery(name="UserPostComment.findAll", query="SELECT u FROM UserPostComment u"),
        @NamedQuery(name="UserPostComment.countAll", query="SELECT COUNT(u) FROM UserPostComment u"),
        @NamedQuery(name="UserPostComment.findById", query="SELECT u FROM UserPostComment u WHERE u.id = :pid"),
        @NamedQuery(name="UserPostComment.findByUser", query="SELECT u FROM UserPostComment u WHERE u.user = :pu"),
        @NamedQuery(name="UserPostComment.findByOrgAndUser", query="SELECT u FROM UserPostComment u WHERE u.userPost = :porg AND u.user = :pu"),
        @NamedQuery(name="UserPostComment.findByOrg", query="SELECT u FROM UserPostComment u WHERE u.userPost = :porg AND u.deleted = false"),
        @NamedQuery(name="UserPostComment.findByOrgOrdered", query="SELECT u FROM UserPostComment u WHERE u.userPost = :porg ORDER BY u.creationDate ASC")
})
@Cacheable(false)
public class UserPostComment extends BaseModel {

    private static final long serialVersionUID = 1L;

    //bi-directional many-to-one association to Organization
    @ManyToOne
    @JoinColumn(name="POST_ID", nullable=false)
    private UserPost userPost;

    //bi-directional many-to-one association to User
    @ManyToOne
    @JoinColumn(name="USER_ID", nullable=false)
    private User user;

    @Column(name="COMMENT", length=255)
    private String comment;

    @Column(name = "DELETED", length = 1)
    private Boolean deleted = false;

    public UserPostComment() {
    }

    public UserPost getUserPost() {
        return userPost;
    }

    public void setUserPost(UserPost userPost) {
        this.userPost = userPost;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public JSONObject getJSONObject() {
        JSONObject json = new JSONObject();
        try {
            json.put("id", Objects.toString(getId(), ""));
            json.put("name", Objects.toString(getUser().getName(), ""));
            json.put("profileImg", Objects.toString(getUser().getProfilImg(), ""));
            json.put("text", Objects.toString(getComment(), ""));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }
}

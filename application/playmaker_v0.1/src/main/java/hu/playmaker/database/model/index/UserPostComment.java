package hu.playmaker.database.model.index;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.system.User;

import javax.persistence.*;

@Entity
@Table(name="USER_POST_COMMENTS", schema="probe")
@NamedQueries({
        @NamedQuery(name="UserPostComment.findAll", query="SELECT u FROM UserPostComment u"),
        @NamedQuery(name="UserPostComment.countAll", query="SELECT COUNT(u) FROM UserPostComment u"),
        @NamedQuery(name="UserPostComment.findById", query="SELECT u FROM UserPostComment u WHERE u.id = :pid"),
        @NamedQuery(name="UserPostComment.findByUser", query="SELECT u FROM UserPostComment u WHERE u.user = :pu"),
        @NamedQuery(name="UserPostComment.findByOrgAndUser", query="SELECT u FROM UserPostComment u WHERE u.userPost = :porg AND u.user = :pu"),
        @NamedQuery(name="UserPostComment.findByOrg", query="SELECT u FROM UserPostComment u WHERE u.userPost = :porg"),
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
}

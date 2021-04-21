package com.teampress.database.model.index;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.json.JSONObject;

import javax.annotation.Detainted;
import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Objects;

import static java.util.Objects.isNull;

@Entity
@Table(name="USERPOST", schema="teampress")
@NamedQueries({
        @NamedQuery(name="UserPost.findAll", query="SELECT u FROM UserPost u"),
        @NamedQuery(name="UserPost.findById", query="SELECT u FROM UserPost u WHERE u.id = :pid"),
        @NamedQuery(name="UserPost.findByUser", query="SELECT u FROM UserPost u WHERE u.user = :pu"),
        @NamedQuery(name="UserPost.findByOrgAndUser", query="SELECT u FROM UserPost u WHERE u.organization = :porg AND u.user = :pu"),
        @NamedQuery(name="UserPost.findByOrgOrdered", query="SELECT u FROM UserPost u WHERE u.organization = :porg AND u.deleted = false ORDER BY u.id DESC")
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class UserPost extends BaseModel {
    private static final long serialVersionUID = 1L;

    //bi-directional many-to-one association to Organization
    @ManyToOne
    @JoinColumn(name="ORGANIZATION_ID", nullable=false)
    private Organization organization;

    //bi-directional many-to-one association to User
    @ManyToOne
    @JoinColumn(name="USER_ID", nullable=false)
    private User user;

    @Column(name="IMAGE_URL", length=255)
    private String imageUrl;

    @Column(name="POST", length=255)
    private String post;

    @Column(name = "DELETED", length = 1)
    private Boolean deleted = false;

    public String getFormattedCreationDate(){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        return (isNull(getCreationDate())) ? "" : dateFormat.format(getCreationDate());
    }

    public JSONObject getJSONObject() {
        JSONObject json = new JSONObject();
        try {
            json.put("id", Objects.toString(getId(), ""));
            json.put("profileImg", Objects.toString(getUser().getProfilImg(), ""));
            json.put("name", Objects.toString(getUser().getName(), ""));
            json.put("postDate", Objects.toString(getFormattedCreationDate(), ""));
            json.put("text", Objects.toString(getPost(), ""));
            json.put("content", Objects.toString(getImageUrl(), ""));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }
}

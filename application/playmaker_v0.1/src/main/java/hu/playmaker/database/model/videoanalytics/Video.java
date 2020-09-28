package hu.playmaker.database.model.videoanalytics;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.databank.Sorsolas;
import hu.playmaker.database.model.gameplan.CustomGame;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;

import javax.persistence.*;

@Entity
@Table(name="VIDEO", schema="probe")
@NamedQueries({
        @NamedQuery(name="Video.findAll", query="SELECT p FROM Video p"),
        @NamedQuery(name="Video.countAll", query="SELECT COUNT(p) FROM Video p"),
        @NamedQuery(name="Video.findById", query="SELECT p FROM Video p WHERE p.id = :pid"),
        @NamedQuery(name="Video.findByName", query="SELECT p FROM Video p WHERE p.name=:pname"),
})
@Cacheable(false)
public class Video extends BaseModel {
    private static final long serialVersionUID = 1L;

    @Column(name="NAME", length=255)
    private String name;

    public Video() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

package hu.playmaker.controller.system;

import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.Parameter;
import hu.playmaker.database.model.system.TrainerRating;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.service.system.OrganizationService;
import hu.playmaker.database.service.system.ParameterService;
import hu.playmaker.database.service.system.TrainerRatingService;
import hu.playmaker.database.service.system.UserOrganizationService;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Controller
@EnableScheduling
public class TrainerRatingController {

    private final String GROUP = "TRAINER_RATING";

    private ParameterService parameterService;
    private UserOrganizationService userOrganizationService;
    private OrganizationService organizationService;
    private TrainerRatingService trainerRatingService;

    public TrainerRatingController(ParameterService parameterService, UserOrganizationService userOrganizationService, OrganizationService organizationService, TrainerRatingService trainerRatingService) {
        this.parameterService = parameterService;
        this.userOrganizationService = userOrganizationService;
        this.organizationService = organizationService;
        this.trainerRatingService = trainerRatingService;
    }

    //@Scheduled(fixedDelay = 1000000)
    public void create(){
        List<Parameter> parameters = parameterService.findParameterByGroup(GROUP);
        Calendar calendar = Calendar.getInstance();
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
        List<Organization> organizations = new ArrayList<>();
        for(Parameter parameter : parameters) {
            if(Integer.parseInt(parameter.getValue()) == dayOfWeek){
                organizations.add(organizationService.findOrganizationByName(parameter.getCode()));
            }
        }
        List<UserOrganization> userOrganizations = new ArrayList<>();
        for(Organization organization : organizations) {
            for(TrainerRating trainerRating : trainerRatingService.findByNull(organization)){
                trainerRating.setDone(false);
                trainerRatingService.mergeFlush(trainerRating);
            }
            userOrganizations.addAll(userOrganizationService.getOrgListByOrg(organization));
        }
        for(UserOrganization userOrganization : userOrganizations) {
            if(userOrganization.getUser().isPlayer()) {
                System.out.println("Rating: " + userOrganization.getUser().getName());
                TrainerRating rating = new TrainerRating();
                rating.setOrganization(userOrganization.getOrganization());
                rating.setTeam(userOrganization.getType());
                rating.setUser(userOrganization.getUser());
                trainerRatingService.mergeFlush(rating);
            }
        }
    }
}

package com.teampress.controller.system;

import com.teampress.database.model.financial.AnnualPayment;
import com.teampress.database.model.financial.PaymentRequest;
import com.teampress.database.model.system.*;
import com.teampress.database.service.financial.AnnualPaymentService;
import com.teampress.database.service.financial.PaymentRequestService;
import com.teampress.database.service.system.OrganizationService;
import com.teampress.database.service.system.ParameterService;
import com.teampress.database.service.system.TrainerRatingService;
import com.teampress.database.service.system.UserOrganizationService;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@EnableScheduling
public class SchedulingController {

    private static final String GROUP = "TRAINER_RATING";

    private ParameterService parameterService;
    private UserOrganizationService userOrganizationService;
    private OrganizationService organizationService;
    private TrainerRatingService trainerRatingService;
    private AnnualPaymentService annualPaymentService;
    private PaymentRequestService paymentRequestService;

    public SchedulingController(ParameterService parameterService, UserOrganizationService userOrganizationService, OrganizationService organizationService, TrainerRatingService trainerRatingService, AnnualPaymentService annualPaymentService, PaymentRequestService paymentRequestService) {
        this.parameterService = parameterService;
        this.userOrganizationService = userOrganizationService;
        this.organizationService = organizationService;
        this.trainerRatingService = trainerRatingService;
        this.annualPaymentService = annualPaymentService;
        this.paymentRequestService = paymentRequestService;
    }

    @Scheduled(cron = "0 0 4 * * MON")
    public void createTrainerRatings(){
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

    @Scheduled(cron = "0 0 1 * * ?")
    public void createAnnualPayments() {
        List<AnnualPayment> newPayments = annualPaymentService.findByDay(LocalDate.now().getDayOfMonth());
        for (AnnualPayment payment : newPayments) {
            List<User> players = userOrganizationService.getOrgListByTeam(payment.getOrganization(), payment.getTeam()).stream().map(UserOrganization::getUser).collect(Collectors.toList());
            for (User p : players) {
                if (p.isPlayer()) {
                    PaymentRequest paymentRequest = new PaymentRequest();
                    paymentRequest.setName(payment.getName());
                    paymentRequest.setAmount(payment.getAmount());
                    paymentRequest.setGroup(payment.getGroup());
                    paymentRequest.setOrganization(payment.getOrganization());
                    paymentRequest.setUser(p);
                    paymentRequestService.mergeFlush(paymentRequest);
                }
            }
        }
    }
}

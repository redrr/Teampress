package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.common.factory.ChartBuilder;
import hu.playmaker.common.factory.ChartData;
import hu.playmaker.common.factory.ExcelBuilder;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.financial.Income;
import hu.playmaker.database.model.financial.IncomeGroup;
import hu.playmaker.database.model.financial.IncomeGroupConnection;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.financial.IncomeGroupConnectionService;
import hu.playmaker.database.service.financial.IncomeGroupService;
import hu.playmaker.database.service.financial.IncomeService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/financial/statement")
public class FinancialStatementController extends BaseController {

    private IncomeService incomeService;
    private IncomeGroupConnectionService incomeGroupConnectionService;
    private UserOrganizationService userOrganizationService;
    private UserService userService;

    public FinancialStatementController(IncomeService incomeService, IncomeGroupConnectionService incomeGroupConnectionService, UserOrganizationService userOrganizationService, UserService userService) {
        this.incomeService = incomeService;
        this.incomeGroupConnectionService = incomeGroupConnectionService;
        this.userOrganizationService = userOrganizationService;
        this.userService = userService;
    }

    @RequestMapping("")
    public ModelAndView showStatement() {
        if(hasPermission(Permissions.LOGGED_IN)) {
            ModelAndView view = new ModelAndView("play/FinancialStatement");
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
            view.addObject("monthIncome", getIncomes(organization));
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(value = "/yeardata", method = RequestMethod.POST)
    @ResponseBody
    public String asd() {
        Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
        String[] monthNames = {"Január", "Február", "Március", "Április", "Május", "Június", "Július", "Augusztus", "Szeptember", "Október", "November", "December"};
        String[] month = {"01","02","03","04","05","06","07","08","09","10","11","12"};
        ChartBuilder chartBuilder = new ChartBuilder();
        try {
            chartBuilder.setType("line");
            LocalDate now = LocalDate.now();
            String[] s = now.toString().split("-");
            ChartData income = new ChartData()
                    .setFill(true);
            income.setLabel("Bevétel");
            income.addBorderColor("rgba(75, 192, 192, 1)");
            income.addPointBackgroundColor("rgba(75, 192, 192, 1)");
            income.addBackgroundColor("rgba(75, 192, 192, 0.5)");
            ChartData expanse = new ChartData()
                    .setFill(true);
            expanse.setLabel("Kiadás");
            expanse.addBorderColor("rgba(255, 99, 132, 1)");
            expanse.addPointBackgroundColor("rgba(255, 99, 132, 1)");
            expanse.addBackgroundColor("rgba(255, 99, 132, 0.5)");
            for(int i = 0; i < now.getMonthValue()-1; i++){
                LocalDate from = LocalDate.parse(s[0]+"-"+month[i]+"-01");
                LocalDate to = from.plusMonths(1);
                Date fromDate = new SimpleDateFormat("yyyy-MM-dd").parse(from.toString());
                Date toDate = new SimpleDateFormat("yyyy-MM-dd").parse(to.toString());
                chartBuilder.addLabel(monthNames[i]);
                Object incomeValue = incomeService.getValueBetweenDates(organization, true, fromDate, toDate);
                Object expanseValue = incomeService.getValueBetweenDates(organization, false, fromDate, toDate);
                income.addData(Objects.nonNull(incomeValue) ? Integer.parseInt(incomeValue+"") : 0);
                expanse.addData(Objects.nonNull(expanseValue) ? Integer.parseInt(expanseValue+"") : 0);
            }
            chartBuilder.addData(income);
            chartBuilder.addData(expanse);
        } catch (Exception e){
            e.printStackTrace();
        }
        return chartBuilder.build();
    }

    private List<IncomeGroupConnection> getIncomes(Organization organization) {
        List<IncomeGroupConnection> result = new ArrayList<>();
        try {
            LocalDate now = LocalDate.now();
            String[] s = now.toString().split("-");
            LocalDate from = LocalDate.parse(s[0]+"-"+s[1]+"-01");
            LocalDate to = from.plusMonths(1);
            Date fromDate = new SimpleDateFormat("yyyy-MM-dd").parse(from.toString());
            Date toDate = new SimpleDateFormat("yyyy-MM-dd").parse(to.toString());
            result = incomeGroupConnectionService.findByOrg(organization, fromDate, toDate);
        } catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping(value = "/export/{id1}/{id2}")
    @ResponseBody
    public String exportStatement(HttpServletResponse response, @PathVariable String id1, @PathVariable String id2) throws IOException, ParseException {
        if(hasPermission(Permissions.LOGGED_IN)) {
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
            Date fromDate = new SimpleDateFormat("yyyy-MM-dd").parse(id1);
            Date toDate = new SimpleDateFormat("yyyy-MM-dd").parse(id2);
            List<Income> incomes = incomeService.findByOrgAcceptedDate(organization, fromDate, toDate);
            ExcelBuilder excel = new ExcelBuilder()
                    .setFileName("Teampress_"+organization.getName().replace(" ", "_")+"_financial_export.xls")
                    .setSheetName("Statement")
                    .addTitle("Megnevezés", "Csoport", "Típus", "Érték", "Létrehozás ideje", "Létrehozó");
            for(Income income : incomes) {
                String type = (income.isIncome()) ? "Bevétel" : "Kiadás";
                String group = (incomeGroupConnectionService.exist(income)) ? incomeGroupConnectionService.find(income).getGroup().getName() : "";
                excel.addData(income.getName(), group, type, income.getPrize().toString(), income.getCreationDateAsString(), income.getCreatedBy());
            }
            File data = excel.build();
            response.setContentType("application/force-download");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + data.getName() + "\"");
            BufferedInputStream inStream = new BufferedInputStream(new FileInputStream(data));
            BufferedOutputStream outStream = new BufferedOutputStream(response.getOutputStream());

            byte[] buffer = new byte[1024];
            int bytesRead = 0;
            while ((bytesRead = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }
            outStream.flush();
            inStream.close();
            return data.toString();
        }
        return null;
    }
}

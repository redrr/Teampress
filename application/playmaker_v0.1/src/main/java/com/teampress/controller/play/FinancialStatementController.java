package com.teampress.controller.play;

import com.teampress.common.enums.Permissions;
import com.teampress.common.factory.chartjs.Color;
import com.teampress.common.factory.chartjs.Data;
import com.teampress.common.factory.chartjs.LineChartBuilder;
import com.teampress.common.factory.chartjs.LineDataSet;
import com.teampress.common.factory.chartjs.common.enums.BorderCapStyle;
import com.teampress.common.factory.excel.ExcelBuilder;
import com.teampress.controller.BaseController;
import com.teampress.database.model.financial.Income;
import com.teampress.database.model.financial.IncomeGroupConnection;
import com.teampress.database.model.system.Organization;
import com.teampress.database.service.financial.IncomeGroupConnectionService;
import com.teampress.database.service.financial.IncomeService;
import com.teampress.database.service.system.UserOrganizationService;
import com.teampress.database.service.system.UserService;
import com.teampress.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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

@Controller
@RequestMapping("/financial/statement")
public class FinancialStatementController extends BaseController {

    private IncomeService incomeService;
    private IncomeGroupConnectionService incomeGroupConnectionService;
    private UserOrganizationService userOrganizationService;
    private UserService userService;

    private final static String[] MONTH_NAMES = {"Január", "Február", "Március", "Április", "Május", "Június", "Július", "Augusztus", "Szeptember", "Október", "November", "December"};
    private final static String[] MONTH = {"01","02","03","04","05","06","07","08","09","10","11","12"};

    public FinancialStatementController(IncomeService incomeService, IncomeGroupConnectionService incomeGroupConnectionService, UserOrganizationService userOrganizationService, UserService userService) {
        this.incomeService = incomeService;
        this.incomeGroupConnectionService = incomeGroupConnectionService;
        this.userOrganizationService = userOrganizationService;
        this.userService = userService;
    }

    @RequestMapping("")
    public ModelAndView showStatement() {
        if(hasPermission(Permissions.STATEMENT)) {
            ModelAndView view = new ModelAndView("play/FinancialStatement");
            LocalDate d = LocalDate.now();
            view.addObject("monthIncome", getIncomes(d));
            view.addObject("nextMonth", d.plusMonths(1));
            view.addObject("prevMonth", d.minusMonths(1));
            view.addObject("year", d.getYear());
            view.addObject("month", MONTH_NAMES[d.getMonthValue()-1]);
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping("/{date}")
    public ModelAndView showStatement(@PathVariable String date) {
        if(hasPermission(Permissions.STATEMENT)) {
            ModelAndView view = new ModelAndView("play/FinancialStatement");
            LocalDate d = LocalDate.parse(date);
            view.addObject("monthIncome", getIncomes(d));
            view.addObject("nextMonth", d.plusMonths(1));
            view.addObject("prevMonth", d.minusMonths(1));
            view.addObject("year", d.getYear());
            view.addObject("month", MONTH_NAMES[d.getMonthValue()-1]);
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(value = "/yeardata", method = RequestMethod.POST)
    @ResponseBody
    public String yearChart() {
        Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
        try {
            LocalDate now = LocalDate.now();
            String[] s = now.toString().split("-");
            LineChartBuilder chartBuilder = new LineChartBuilder();
            //Dataset template
            LineDataSet template = new LineDataSet();
            template.setBorderCapStyle(BorderCapStyle.ROUND);
            template.setBorderWidth(4);
            template.setFill(true);
            template.setPointRadius(2);
            template.setPointHoverRadius(4);
            template.setPointHitRadius(12);
            template.setPointHoverBorderWidth(8);
            //Create Datasets
            Data<LineDataSet> data = new Data<>();
            LineDataSet incomeDataSet = new LineDataSet(template);
            Color incomeColor = new Color(75, 192, 192, 0.2);
            Color incomeHoverColor = new Color(75, 192, 192, 0.8);
            incomeDataSet.setLabel("Bevétel");
            incomeDataSet.setBackgroundColor(incomeColor);
            incomeDataSet.setHoverBackgroundColor(incomeHoverColor);
            incomeDataSet.setBorderColor(incomeHoverColor);
            incomeDataSet.setHoverBorderColor(incomeHoverColor);
            incomeDataSet.setPointBackgroundColor(incomeColor);
            incomeDataSet.setPointHoverBackgroundColor(incomeColor);
            LineDataSet expanseDataSet = new LineDataSet(template);
            Color expanseColor = new Color(255, 99, 132, 0.2);
            Color expanseHoverColor = new Color(255, 99, 132, 0.8);
            expanseDataSet.setLabel("Kiadás");
            expanseDataSet.setBackgroundColor(expanseColor);
            expanseDataSet.setHoverBackgroundColor(expanseHoverColor);
            expanseDataSet.setBorderColor(expanseHoverColor);
            expanseDataSet.setHoverBorderColor(expanseHoverColor);
            expanseDataSet.setPointBackgroundColor(expanseColor);
            expanseDataSet.setPointHoverBackgroundColor(expanseColor);
            List<Object> incomes = new ArrayList<>();
            List<Object> expanses = new ArrayList<>();
            for(int i = 0; i < now.getMonthValue()-1; i++) {
                LocalDate from = LocalDate.parse(s[0]+"-"+ MONTH[i]+"-01");
                LocalDate to = from.plusMonths(1);
                Date fromDate = new SimpleDateFormat("yyyy-MM-dd").parse(from.toString());
                Date toDate = new SimpleDateFormat("yyyy-MM-dd").parse(to.toString());
                data.addLabel(MONTH_NAMES[i]);
                Object incomeValue = incomeService.getValueBetweenDates(organization, true, fromDate, toDate);
                Object expanseValue = incomeService.getValueBetweenDates(organization, false, fromDate, toDate);
                incomes.add(Objects.nonNull(incomeValue) ? Integer.parseInt(incomeValue+"") : 0);
                expanses.add(Objects.nonNull(expanseValue) ? Integer.parseInt(expanseValue+"") : 0);
            }
            incomeDataSet.setData(incomes.toArray());
            expanseDataSet.setData(expanses.toArray());
            data.addDataset(incomeDataSet);
            data.addDataset(expanseDataSet);
            chartBuilder.setData(data);
            return chartBuilder.build();
        } catch (Exception e){
            e.printStackTrace();
        }
        return "error";
    }

    private List<IncomeGroupConnection> getIncomes(LocalDate date) {
        Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
        List<IncomeGroupConnection> result = new ArrayList<>();
        try {
            String[] s = date.toString().split("-");
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
        if(hasPermission(Permissions.STATEMENT)) {
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
            Date fromDate = new SimpleDateFormat("yyyy-MM-dd").parse(id1);
            Date toDate = new SimpleDateFormat("yyyy-MM-dd").parse(id2);
            List<Income> incomes = incomeService.findByOrgAcceptedDate(organization, fromDate, toDate);
            if(incomes.size() > 0) {
                ExcelBuilder excel = new ExcelBuilder()
                        .setFileName("Teampress_"+organization.getName().replace(" ", "_")+"_financial_export.xls")
                        .setSheetName("Statement")
                        .addTitle("Megnevezés", "Csoport", "Típus", "Érték", "Létrehozás ideje", "Létrehozó");
                for(Income income : incomes) {
                    String type = (income.isIncome()) ? "Bevétel" : "Kiadás";
                    String group = (incomeGroupConnectionService.exist(income)) ? incomeGroupConnectionService.find(income).getGroup().getName() : "";
                    excel.addData(income.getName(), group, type, income.getPrize().toString(), income.getCreationDateAsString(), userService.findEnabledUserByUsername(income.getCreatedBy()).getName());
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
        }
        return null;
    }
}

package hu.playmaker.controller.admin;

import hu.playmaker.common.enums.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.index.UserPostCommentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/event/comment")
public class ACommentController extends BaseController {

    private UserPostCommentService userPostCommentService;

    public ACommentController(UserPostCommentService userPostCommentService) {
        this.userPostCommentService = userPostCommentService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Comment");
            view.addObject("datas", userPostCommentService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}

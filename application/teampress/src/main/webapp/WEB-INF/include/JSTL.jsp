<%--
  Created by IntelliJ IDEA.
  User: Matyi
  Date: 2020. 08. 09.
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<jsp:useBean id="sessionHandler" class="com.teampress.handler.SessionHandler" scope="session"/>
<c:set value="true" var="sidebar"/>
<!DOCTYPE html>

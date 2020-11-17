<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myshop.contact.ContactDAO" %>
<%
int num=Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

ContactDAO cdao = ContactDAO.getInstance();
cdao.deleteContact(num);
response.sendRedirect("contactList.jsp?pageNum="+pageNum);
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myshop.contact.ContactDAO" %>
<%
int num=Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

ContactDAO cdao = ContactDAO.getInstance();
cdao.deleteContact(num);
response.sendRedirect("contactList.jsp?pageNum="+pageNum);
>>>>>>> c7a58eec9e8a56dafeba827447702772f3ed57ed
%>
<%@page import="myshop.community.CommunityDAO"%>
<%@page import="myshop.community.CommunityDTO"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="commu" scope="page" class="myshop.community.CommunityDTO">
   <jsp:setProperty name="commu" property="*"/>
</jsp:useBean>
<%
	int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");

	CommunityDAO dao = CommunityDAO.getInstance();
    int check = dao.updateCommu(commu);

    if(check==1){
%>	      <script language="JavaScript">         
        alert("수정되었습니다.");
     </script>
	  <meta http-equiv="Refresh" content="0;url=community.jsp?num=<%=commu.getNum()%>&pageNum=<%=pageNum%>" >
<% }else{%>
      <script language="JavaScript">      
      <!--      
        alert("비밀번호가 맞지 않습니다");
        history.go(-1);
      -->
     </script>
<%
    }
 %>  

 
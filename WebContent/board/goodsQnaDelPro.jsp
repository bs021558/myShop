<%@page import="myshop.qnaboard.QnaDAO"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "java.sql.Timestamp" %>


<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  String passwd = request.getParameter("passwd");

  QnaDAO dao = QnaDAO.getInstance();
  int check = dao.deleteQna(num, passwd);

  if(check==1){
%>
	  <meta http-equiv="Refresh" content="0;url=goodsQnaList.jsp?pageNum=<%=pageNum%>" >
<% }else{%>
       <script language="JavaScript">      
       <!--      
         alert("��й�ȣ�� ���� �ʽ��ϴ�");
         history.go(-1);
       -->
      </script>
<%
    }
 %>
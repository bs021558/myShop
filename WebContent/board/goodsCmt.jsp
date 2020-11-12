<%@page import="myshop.goodscmt.CmtDTO"%>
<%@page import="myshop.goodscmt.CmtDAO"%>
<%@page import="myshop.goods.MyShopDTO"%>
<%@page import="myshop.goods.MyShopDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.sql.Timestamp" %>
<%

   String sessionId = (String)session.getAttribute("sessionId");
   String goods_code = request.getParameter("goods_code");
   int code =0;
   code = Integer.parseInt(goods_code);
   
      MyShopDAO dao = MyShopDAO.getInstance();
      MyShopDTO dto = dao.detailGoods(code);
      
      if(dto != null)
      {
%>

<%   
	int pageSize = 4;
	
	String cmtPageNum = request.getParameter("cmtPageNum");
	if(cmtPageNum == null) {
		cmtPageNum = "1";  
	}
	
	
	int currentPage = Integer.parseInt(cmtPageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
 	int endRow = currentPage * pageSize;
 	int count = 0;
 	int number= 0;
 	
 	List <CmtDTO> cmtList = null;
 	CmtDAO cmt = CmtDAO.getInstance();
 	
 	cmtList = cmt.getList(code);
 	count = cmtList.size(); 

    if (count > 0) { 
    	cmtList = cmt.getList(code, startRow, endRow);    
    }

   	number=count-(currentPage-1)*pageSize; 
%>	
	

	<%--goodsCmt 추가--%>
<center>상품에 대한 <%=count%> 개의 의견이 있어요!
<form method="post" action="goodsCmtPro.jsp">
    <table align="center" border="1" width="500">
        <tr>
			<td><input type="text" name="writer" value="<%= sessionId%>"></td>
           	<input type="hidden" name="goods_code" value = "<%= code %>"/>
        </tr>
        <tr>
            <td colspan=4><textarea name="content" cols=60 rows=5></textarea></td>
        </tr>
        <tr>
            <td colspan=4 align=right><input type="submit" VALUE=" 확인 "></td>
        </tr>
    </table>  
</form>
<br>

	<%----%>
    <% if(cmtList != null){
        for(CmtDTO cmtt : cmtList){ %>
        <table align="center" width="750" border="1">
            <tr>
                <td><%= cmtt.getNum() %></td>
                <td><%= cmtt.getReg_date() %></td>
            </tr>
            <tr>
            	<td><%= cmtt.getWriter() %></td>
                <th><%= cmtt.getContent() %></th>
                            
   <%
                	
        if( sessionId != null && sessionId.equals(cmtt.getWriter()) )
                	{
                		
  	%>
           	<td><a href="goodsCmtDel.jsp?num=<%= cmtt.getNum() %>&goods_code=<%=goods_code%>">삭제</a></td>
	            <%
                	}
	            %>
            </tr>
        </table>
        <br>
        <% }
        }%>
  
<%  	
    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
       
        int startPage = (int)(currentPage/10)*10+1;
      int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="goodsDetail.jsp?cmtPageNum=<%= startPage - 10 %>&goods_code=<%=goods_code%>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        <a href="goodsDetail.jsp?cmtPageNum=<%= i %>&goods_code=<%=goods_code%>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) {  %>
        <a href="=goodsDetail.jsp?cmtPageNum=<%= startPage + 10 %>&goods_code=<%=goods_code%>">[다음]</a>        
        
<%
        }
    }
      }
%>
<%@page import="myshop.order.OrderDTO"%>
<%@page import="myshop.goods.ProductDAO"%>
<%@page import="myshop.order.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<h1>myOrders 페이지입니다.</h1>

<%
	//세션 획득
    String userId = (String)session.getAttribute("sessionId");
    //로그인되어 있지 않으면 loginForm.jsp파일로 리디렉트합니다.
    if(userId==null)
  	{
		response.sendRedirect("loginForm.jsp");
	}
    //현재 페이지 확인
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
	//필요한 변수 선언
	List orderList = null;
    OrderDAO orderPro = OrderDAO.getInstance();
  	
    //MyShopDAO: 상품DB DAO 클래스 이름
    ProductDAO dao = ProductDAO.getInstance();
    
    int pageSize=10;
    int currentPage = Integer.parseInt(pageNum);//현재페이지
    int startRow = (currentPage - 1) * pageSize + 1;//첫번째열
    int endRow = currentPage * pageSize; //마지막열
    int count = 0;//주문 수
    int goods_code=0;
	
    count = orderPro.getOrderCount(userId);
    if (count > 0) 
    {
        orderList = orderPro.getOrderList(userId, startRow, endRow);
    }
    else
    {
%>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" bgcolor="white">
		<td align="center" width="100">주문번호</td>
		<td align="center" width="250">상품</td>
		<td align="center" width="100">판매자</td>
		<td align="center" width="50">수량</td>
		<td align="center" width="100">금액</td>
		<td align="center" width="100">주문일자</td>
		<td align="center" width="100">운송장번호</td>
	</tr>
	<%  
		for (int i = 0 ; i < orderList.size() ; i++) 
		{
			OrderDTO order = (OrderDTO)orderList.get(i);
        	goods_code = order.getGoods_code(); 
%>
	<tr height="30">
		<td align="center" width="100"><%=order.getOrder_number()%>주문번호</td>
		<td width="250">
		<a href="content.jsp?num=<%=order.getGoods_code()%>& pageNum=<%=currentPage%>dao.getCodeName(goods_code)%>">상품이름</a> 
				<%//getCode2Name(int goods_code) : return type = String 굿즈 코드 받아서 검색한다음 굿즈네임 리턴해주는 메소드%>
		</td>
		<td align="center" width="100"><%=order.getSeller() %>판매자</td>
		<td align="center" width="50"><%= order.getAmount()%>수량</td>
		<td align="center" width="50"><%= order.getTotal_price()%>금액</td>
		<td align="center" width="100"><%=order.getOrder_date()%></td>
		<td align="center" width="100">
		<a href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=<%=order.getTrack() %>">
				<%=order.getTrack() %></a>
	</tr>
	<%
		}
%>
</table>
<%
}
%>
<%
    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		 
        int startPage = (int)(currentPage/10)*10+1;
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
<a href="myOrders.jsp?pageNum=+<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
<a href="myOrders.jsp?pageNum=<%= i %>">[<%= i %>]
</a>
<%
        }
        if (endPage < pageCount) {  %>
<a href="list.jsp?pageNum="+<%= startPage + 10 %>>[다음]</a>
<%
        }
    }
%>
</body>
</html>
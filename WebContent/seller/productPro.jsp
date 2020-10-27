%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="myShop.mvc.seller.productDAO"%>
<%@page import="myShop.mvc.seller.productDTO"%>
<%@ page import = "java.sql.*" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<h1>writePro page</h1>
   <% request.setCharacterEncoding("UTF-8");  %>

   
   <%
      String save = request.getRealPath("save");
      int size = 1024*1024*100;
      String enc = "UTF-8";
      DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
      MultipartRequest mr = new MultipartRequest(request,save,size,enc,dp);
      
      //String code = mr.getParameter("goods_code");
      String brand = mr.getParameter("goods_brand");
      String title = mr.getParameter("goods_name");
      String price = mr.getParameter("goods_price");
      String delivery = mr.getParameter("goods_delivery");
      String option = mr.getParameter("goods_option");
      String count = mr.getParameter("goods_count");
      String msg = mr.getParameter("goods_msg");
      
      String systemFileName = mr.getFilesystemName("file1");

      productDTO product = new productDTO();
      
      product.setGoods_name(title);
      product.setGoods_brand(brand);
      //무조건 숫자만 들어온다는 가정, 숫자 이외 다른게 들어오면 현재는 오류남
      product.setGoods_price(Integer.parseInt(price));
      product.setGoods_delivery(delivery);
      product.setGoods_option(option);
      product.setGoods_count(Integer.parseInt(count));
      product.setGoods_msg(msg);
      
     // 기본이미지 값
      if(systemFileName == null)
        systemFileName = "default.jpg";
      product.setGoods_img(systemFileName);
      
      productDAO dbPro = productDAO.getInstance();
      //myshopDAO dbPro = new myshopDAO();
      dbPro.insertProduct(product);
       
       response.sendRedirect("productForm.jsp");
%>

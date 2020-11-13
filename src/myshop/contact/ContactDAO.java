package myshop.contact;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import myshop.alldb.DBCon;

public class ContactDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
 	private static ContactDAO instance = new ContactDAO();
    
    public static ContactDAO getInstance() {return instance;}
    
    private ContactDAO() {}
    
    public void insertContact(ContactDTO dto) {
    	
    	int num=dto.getNum();
		int ref=dto.getRef();
		int re_step=dto.getRe_step();
		int re_level=dto.getRe_level();
		int number=0;
		
        String sql2 = "insert into contact(num,goods_code,writer,email,goods_brand,subject,content,filename,";
	    	   sql2+= "ref,re_step,re_level,reg_date) values(contact_seq.nextval,?,?,?,?,?,?,?,?,?,?,sysdate)";

        try {
        	conn = DBCon.getConnection();
            pstmt = conn.prepareStatement("select max(num) from contact");
			rs = pstmt.executeQuery();
			
			if (rs.next()) {//그룹생성
		      number=rs.getInt(1)+1;
			}else {
		      number=1; 
		    }
		    if (num!=0){//답글
		    	//같은 그룹의 순서가 더 큰 답글의 순서를 1씩 더함
		        String sql1 = "update contact set re_step=re_step+1 where ref= ? and re_step> ?";
		    	pstmt = conn.prepareStatement(sql1);
		    	pstmt.setInt(1, ref);//원래 그룹
		    	pstmt.setInt(2, re_step);
		    	pstmt.executeUpdate();
		    	re_step=re_step+1;
		    	re_level=re_level+1;
		    	pstmt = conn.prepareStatement(sql2);
		        pstmt.setInt(1, dto.getGoods_code());
		        pstmt.setString(2, dto.getWriter());
		        pstmt.setString(3, dto.getEmail());
		        pstmt.setString(4, dto.getGoods_brand());
		        pstmt.setString(5, dto.getSubject());
		        pstmt.setString(6, dto.getContent());
		        pstmt.setString(7, dto.getFilename());
		        pstmt.setInt(8, ref);
		        pstmt.setInt(9, re_step);
		        pstmt.setInt(10, re_level);
		            		 
		     }else{//새글
		    	 ref=number;//새로 생성한 그룹
		    	 re_step=0;
		    	 re_level=0;
		    	 
		    	 pstmt = conn.prepareStatement(sql2);
		         pstmt.setInt(1, dto.getGoods_code());
		         pstmt.setString(2, dto.getWriter());
		         pstmt.setString(3, dto.getEmail());
		         pstmt.setString(4, dto.getGoods_brand());
		         pstmt.setString(5, dto.getSubject());
		         pstmt.setString(6, dto.getContent());
		         pstmt.setInt(7, ref);
		         pstmt.setInt(8, re_step);
		         pstmt.setInt(9, re_level);
				 pstmt.setTimestamp(10,dto.getReg_date());
		     }	 
		
		pstmt.executeUpdate();  
        
        } catch(Exception ex) {
            ex.printStackTrace();
        }finally {
			closeAll();
		}
    }

	public int getQnaCount1(String user_id) throws Exception {
        
		int x=0;
		ArrayList refList = null;
        try {
        	conn = DBCon.getConnection();
            pstmt = conn.prepareStatement("select ref from contact where writer = ?");
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
            	refList = new ArrayList();
            	do {
            		refList.add(rs.getInt("ref"));
            	}while(rs.next());
			}
            for(int i = 0; i < refList.size() ; i++){
    			int ref = (int)refList.get(i);
    			pstmt = conn.prepareStatement("select count(*) from contact where ref = ?");
    			pstmt.setInt(1, ref);
    			rs = pstmt.executeQuery();
    			if (rs.next()) {
    				do{
    					x = x + rs.getInt(1);
    				}while(rs.next());
    			}
			}
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            closeAll();
        }
		return x;
}
	
	public int getQnaCount2(String user_id) throws Exception {
        
		int x=0;

        try {
        	conn = DBCon.getConnection();
            pstmt = conn.prepareStatement("select count(*) from contact where goods_brand = ?");
            rs = pstmt.executeQuery();

            if (rs.next()) {
               x= rs.getInt(1);
			}
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            closeAll();
        }
		return x;
}
	
	public List getContactList1(String writer, int start, int end)
    throws Exception {
        List contactList=null;
        try {
            conn = conn = DBCon.getConnection();
            ArrayList refList = new ArrayList();
            
            //내가 작성한 글의 그룹 먼저 검색
            pstmt = conn.prepareStatement("select ref where writer = ?");
            pstmt.setString(1, writer);
            rs=pstmt.executeQuery();
            if(rs.next()) {
            	do {
            	refList.add(rs.getInt("ref"));
            	}while(rs.next());
            }
            
            contactList = new ArrayList(end);
            
            //그룹을 통해 내가 쓴 글의 답글까지 같이 검색
            //판매자의 글은 구매자의 아이디로 검색했을 때 보이지 않기 때문
    		for(int i = 0; i < refList.size() ; i++){
    			int ref = (int)refList.get(i);
    			pstmt = conn.prepareStatement(
    				"select * "+
            		"from (select num,goods_code, writer,email,goods_brand,subject,content,filename,ref,re_step,re_level,reg_date,rownum r " +
        			"from (select * from contact where ref=? ) order by ref desc, re_step asc ) where r >= ? and r <= ? "
            		);
    			pstmt.setInt(1, ref);
    			pstmt.setInt(2, start);
    			pstmt.setInt(3, end);
    			rs = pstmt.executeQuery();
    			if (rs.next()) {
    				do{
    					ContactDTO dto= new ContactDTO();
    					dto.setNum(rs.getInt("num"));
    					dto.setWriter(rs.getString("writer"));
    					dto.setEmail(rs.getString("email"));
    					dto.setGoods_brand(rs.getString("goods_brand"));
    					dto.setSubject(rs.getString("subject"));
    					dto.setContent(rs.getString("content"));
    					dto.setFilename(rs.getString("filename"));
    					dto.setRef(rs.getInt("ref"));
    					dto.setRe_step(rs.getInt("re_step"));
    					dto.setRe_level(rs.getInt("re_level"));
    					dto.setReg_date(rs.getTimestamp("reg_date"));
    					
    					contactList.add(dto);
    				}while(rs.next());
    			}
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            closeAll();
        }
		return contactList;
    }
	
	public List getContactList2(String goods_brand, int start, int end) throws Exception{
		List contactList=null;
        try {
            conn = conn = DBCon.getConnection();
            pstmt = conn.prepareStatement(
            		"select * "+
                    "from (select num,goods_code, writer,email,goods_brand,subject,content,filename,ref,re_step,re_level,reg_date,rownum r " +
                	"from (select * from contact where goods_brand=? ) order by ref desc, re_step asc ) where r >= ? and r <= ? ");
            pstmt.setString(1, goods_brand);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                contactList = new ArrayList(end);
                do{
                  ContactDTO dto= new ContactDTO();
				  dto.setNum(rs.getInt("num"));
				  dto.setGoods_code(rs.getInt("goods_code"));
				  dto.setWriter(rs.getString("writer"));
				  dto.setEmail(rs.getString("email"));
				  dto.setGoods_brand(rs.getString("goods_brand"));
				  dto.setSubject(rs.getString("subject"));
				  dto.setContent(rs.getString("content"));
				  dto.setFilename(rs.getString("filename"));
				  dto.setRef(rs.getInt("ref"));
				  dto.setRe_step(rs.getInt("re_step"));
				  dto.setRe_level(rs.getInt("re_level"));
				  dto.setReg_date(rs.getTimestamp("reg_date"));
                  contactList.add(dto);
			    }while(rs.next());
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            closeAll();
        }
		return contactList;
    }
 
    public ContactDTO getContact(int num)
    throws Exception {
        ContactDTO dto=null;
        try {
        	conn = DBCon.getConnection();
            pstmt = conn.prepareStatement("select * from contact where num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	dto = new ContactDTO();
            	dto.setNum(rs.getInt("num"));
            	dto.setGoods_code(rs.getInt("goods_code"));
            	dto.setWriter(rs.getString("writer"));
            	dto.setEmail(rs.getString("email"));
            	dto.setGoods_brand(rs.getString("goods_brand"));
            	dto.setSubject(rs.getString("subject"));
            	dto.setContent(rs.getString("content"));
            	dto.setFilename(rs.getString("filename"));
            	dto.setRef(rs.getInt("ref"));
                dto.setRe_step(rs.getInt("re_step"));
                dto.setRe_level(rs.getInt("re_level"));
            	dto.setReg_date(rs.getTimestamp("reg_date"));
				
			}
        }catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return dto;
    }

    public void updateContact(ContactDTO dto)
    throws Exception {
        String sql="";
        try {
        	conn = DBCon.getConnection();
            sql="update contact set subject=?,content=? where num=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getSubject());
            pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
            pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
    }
    
    public void deleteContact(int num)
    throws Exception {
        try {
        	conn = DBCon.getConnection();

            pstmt = conn.prepareStatement("delete from board where num=?");
            pstmt.setInt(1, num);
            pstmt.executeUpdate();
        }catch(Exception e) {
        	e.printStackTrace();
        }finally {
        	closeAll();
        }
    }
    
    private void closeAll() {
	if(rs != null) { try {rs.close(); }catch(SQLException s) {}}
	if(pstmt != null) {try {pstmt.close(); } catch(SQLException s) {}}
	if(conn != null) {try {conn.close(); } catch(SQLException s) {}}
    }
}

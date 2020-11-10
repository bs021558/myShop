package myshop.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import myshop.alldb.DBCon;

public class CmtDAO {
    
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
 	private static CmtDAO instance = new CmtDAO();
    
    public static CmtDAO getInstance() {
    	return instance;
    	}
    
    private CmtDAO() {}
    
    public void insertCmt(CmtDTO dto) { // writePro! �벑濡� 硫붿꽌�뱶
    	
        try {
            conn = DBCon.getConnection();
            
            String sql = "insert into goodscmt values (goodscmt_seq.nextval,?,?,?,?,sysdate)";
            
		    pstmt = conn.prepareStatement(sql);
		    pstmt.setInt(1, dto.getGoods_code());
		    pstmt.setString(2, dto.getWriter());
            pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getContent());
            
			pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }finally {
			closeAll();
		}
    }

	public List<CmtDTO> getList(){
    	List<CmtDTO> list = new ArrayList<CmtDTO>();
	
        try {
        	conn = DBCon.getConnection();
            
        	String sql = "SELECT num, goods_code, writer, passwd, content, reg_date" +
                    " FROM goodscmt" +
                    " ORDER BY num desc";
        	 pstmt = conn.prepareStatement(sql);
             rs = pstmt.executeQuery();
             
             while(rs.next()) {
                 CmtDTO dto = new CmtDTO();
                 dto.setNum(rs.getInt(1));
                 dto.setGoods_code(rs.getInt(2));
                 dto.setWriter(rs.getString(3));
                 dto.setPasswd(rs.getString(4));
                 dto.setContent(rs.getString(5));
                 dto.setReg_date(rs.getTimestamp(6));
               
                 list.add(dto);
             }
       
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            closeAll();
        }
		return list;
}

	public List<CmtDTO> getList(int goodscode){
    	List<CmtDTO> list = new ArrayList<CmtDTO>();
	
        try {
        	conn = DBCon.getConnection();
            
        	String sql = "select * from goodscmt where goods_code = ?";
        	 pstmt = conn.prepareStatement(sql);
        	 pstmt.setInt(1, goodscode);
             rs = pstmt.executeQuery();
             
             while(rs.next()) {
                 CmtDTO dto = new CmtDTO();
                 dto.setNum(rs.getInt(1));
                 dto.setGoods_code(rs.getInt(2));
                 dto.setWriter(rs.getString(3));
                 dto.setPasswd(rs.getString(4));
                 dto.setContent(rs.getString(5));
                 dto.setReg_date(rs.getTimestamp(6));
                 
                 list.add(dto);
             }
       
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            closeAll();
        }
		return list;
}
	
    public int deleteCmt(int num, String passwd) // <deletePro>
    throws Exception {
        String dbpasswd="";
        int x=-1;
        try {
        	conn = DBCon.getConnection();

            pstmt = conn.prepareStatement(
            	"select passwd from goodscmt where num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();
            
			if(rs.next()){
				dbpasswd= rs.getString("passwd"); 
				if(dbpasswd.equals(passwd)){
					pstmt = conn.prepareStatement(
            	      "delete from goodscmt where num=?");
                    pstmt.setInt(1, num);
                    pstmt.executeUpdate();
					x= 1;
				}else
					x= 0; 
			}
        }catch(Exception e) {
        	e.printStackTrace();
        }finally {
        	closeAll();
	}
		return x;
     }
    private void closeAll() {
	if(rs != null) { try {rs.close(); }catch(SQLException s) {}}
	if(pstmt != null) {try {pstmt.close(); } catch(SQLException s) {}}
	if(conn != null) {try {conn.close(); } catch(SQLException s) {}}
}
}

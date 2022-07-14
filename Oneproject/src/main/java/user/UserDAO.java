package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	//서버 접속
	public UserDAO(){
		try {
			String dbURL = "jdbc:mariadb://127.0.0.1:3306/test";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//로그인
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userID = ?";
		try {
			ps = con.prepareStatement(sql); 
			ps.setString(1, userID); 
			rs = ps.executeQuery(); 
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}else
					return 0; //비밀번호 틀림
			}
			return -1; //아이디 없음
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //오류
	}
	
	//회원가입
	public int join(User user) {
		  String sql = "insert into user values(?, ?, ?, ?)";
		  try {
		    ps = con.prepareStatement(sql);
		    ps.setString(1, user.getUserID());
		    ps.setString(2, user.getUserPassword());
		    ps.setString(3, user.getUserName());
		    ps.setString(4, user.getUserEmail());
		    return ps.executeUpdate();
		  }catch (Exception e) {
		 	e.printStackTrace();
		  }
		  return -1;
	}
	
	
}
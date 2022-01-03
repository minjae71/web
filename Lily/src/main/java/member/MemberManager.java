package member;

import java.sql.*;
import java.util.ArrayList;

import board.NoticeBean;
import member.MemberBean;

public class MemberManager {
	
	// dao : �����ͺ��̽� ���� ��ü�� ���ڷμ�
	// ���������� db���� ȸ������ �ҷ����ų� db�� ȸ������ ������

	private Connection conn; // connection:db�������ϰ� ���ִ� ��ü
	private PreparedStatement pstmt;
	private ResultSet rs;

	// mysql�� ������ �ִ� �κ�
	public MemberManager() { // ������ ����ɶ����� �ڵ����� db������ �̷�� �� �� �ֵ�����
		try {
			String dbURL = "jdbc:mysql://localhost:3306/lilyDB?characterEncoding=UTF-8&serverTimezone=Asia/Seoul"; // localhost:3306 ��Ʈ�� ��ǻ�ͼ�ġ�� mysql�ּ�
			String dbID = "root";
			String dbPWD = "multi2020";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPWD);
		} catch (Exception e) {
			e.printStackTrace(); // ������ �������� ���
		}
	}

	// �α����� �õ��ϴ� �Լ�****
	public int login(String id, String pwd) {
		String sql = "select * from member where id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString("pwd").equals(pwd)) {
					return 1; // ����
				} else {
					return 0; // ��й�ȣ ����ġ
				}
			}
			return -1; // ���̵� ���� ����
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ����
	}
	
	public boolean checkId(String id)
	{
		String sql = "select * from member where id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// ȸ������
	public int join(String id, String pwd, String name, String birthYear, String birthMonth, String birthDay, String email, String postcode, String address, String detailAddress, String extraAddress, String phone1, String phone2, String phone3) {
		String sql = "insert into member(id, pwd, name, birthYear, birthMonth, birthDay, email, postcode, address, detailAddress, extraAddress, phone1, phone2, phone3) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setString(4, birthYear);
			pstmt.setString(5, birthMonth);
			pstmt.setString(6, birthDay);
			pstmt.setString(7, email);
			pstmt.setString(8, postcode);
			pstmt.setString(9, address);
			pstmt.setString(10, detailAddress);
			pstmt.setString(11, extraAddress);
			pstmt.setString(12, phone1);
			pstmt.setString(13, phone2);
			pstmt.setString(14, phone3);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}
	
	public String findId(String name, String email)
	{
		String sql = "select * from member where name=? AND email=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString("id");
			} else {
				return "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "Err"; // DB ����
	}
	
	public ArrayList<String> findIds(String name, String email)
	{
		String sql = "select * from member where name=?";
		ArrayList<String> list = new ArrayList<String>();
		
		String u_email = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				u_email = rs.getString("email");
				if(u_email.equals(email))
				{
					list.add(rs.getString("id"));
				}	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public String findPwd(String id, String email)
	{
		String sql = "select * from member where id=? AND email=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString("pwd");
			} else {
				return "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "Err"; // DB ����
	}
	
	// ��������
	public int update(String id, String pwd, String name, String birthYear, String birthMonth, String birthDay, String email, String postcode, String address, String detailAddress, String extraAddress, String phone1, String phone2, String phone3) {
		String sql = "update member set pwd=?, name=?, birthYear=?, birthMonth=?, birthDay=?, email=?, postcode=?, address=?, detailAddress=?, extraAddress=?, phone1=?, phone2=?, phone3=? where id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, name);
			pstmt.setString(3, birthYear);
			pstmt.setString(4, birthMonth);
			pstmt.setString(5, birthDay);
			pstmt.setString(6, email);
			pstmt.setString(7, postcode);
			pstmt.setString(8, address);
			pstmt.setString(9, detailAddress);
			pstmt.setString(10, extraAddress);
			pstmt.setString(11, phone1);
			pstmt.setString(12, phone2);
			pstmt.setString(13, phone3);
			pstmt.setString(14, id);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}
	
	//�� ���� ȸ�� ����
	public MemberBean getOneUser(String id) {
		String sql = "select * from member where id=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				MemberBean member = new MemberBean();
				member.setId(rs.getString(1));
				member.setPwd(rs.getString(2));
				member.setName(rs.getString(3));
				member.setBirthYear(rs.getString(4));
				member.setBirthMonth(rs.getString(5));
				member.setBirthDay(rs.getString(6));
				member.setEmail(rs.getString(7));
				member.setPostcode(rs.getString(8));
				member.setAddress(rs.getString(9));
				member.setDetailAddress(rs.getString(10));
				member.setExtraAddress(rs.getString(11));
				member.setPhone1(rs.getString(12));
				member.setPhone2(rs.getString(13));
				member.setPhone3(rs.getString(14));
				member.setReserves(rs.getInt(15));
				
				return member;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int countMember() {
		String sql = "select count(*) from member";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getReserves(int reserves, String id) {
		String sql = "update member set reserves=? where id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reserves);
			pstmt.setString(2, id);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//�Խñ� ��� �ҷ�����
		public ArrayList<MemberBean> getList(int start, int end){ 
		String sql = "select * from member limit ?, ?";
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean member = new MemberBean();
				member.setId(rs.getString(1));
				member.setPwd(rs.getString(2));
				member.setName(rs.getString(3));
				member.setBirthYear(rs.getString(4));
				member.setBirthMonth(rs.getString(5));
				member.setBirthDay(rs.getString(6));
				member.setEmail(rs.getString(7));
				member.setPostcode(rs.getString(8));
				member.setAddress(rs.getString(9));
				member.setDetailAddress(rs.getString(10));
				member.setExtraAddress(rs.getString(11));
				member.setPhone1(rs.getString(12));
				member.setPhone2(rs.getString(13));
				member.setPhone3(rs.getString(14));
				member.setReserves(rs.getInt(15));
				
				list.add(member);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}

	public int delete(String id)
	{
		String sql = "delete from member where id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
/*	
	public int login_admin(String id, String pwd) {
		String sql = "select * from admin_test where admin_id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString("admin_pwd").equals(pwd)) {
					return 1; // ����
				} else {
					return 0; // ��й�ȣ ����ġ
				}
			}
			return -1; // ���̵� ���� ����
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ����
	}
	
	public ArrayList<MemberBean> getUserAll(int start, int end){
		String sql = "select * from member limit ?,?";
		ArrayList<MemberBean> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberBean member = new MemberBean();
				member.setId(rs.getString("id"));
				member.setName(rs.getString("name"));
				member.setBirthYear(rs.getString("birthYear"));
				member.setBirthMonth(rs.getString("birthMonth"));
				member.setBirthDay(rs.getString("birthDay"));
				member.setEmail(rs.getString("email"));
				member.setPostcode(rs.getString("postcode"));
				member.setAddress(rs.getString("address"));
				member.setDetailAddress(rs.getString("detailAddress"));
				member.setExtraAddress(rs.getString("extraAddress"));
				member.setPhone1(rs.getString("phone1"));
				member.setPhone2(rs.getString("phone2"));
				member.setPhone3(rs.getString("phone3"));
				
				list.add(member);                
			}
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e2) {
                // TODO: handle exception
            }    
        }
        return list;
	}
	
	//�Խñ� ��ȣ ��������
	public int getCount() { 
		String sql = "select count(*) from member";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				return rs.getInt(1);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}*/
}
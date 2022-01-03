package order;

import java.sql.*;
import java.util.ArrayList;
public class OrderManager {
	
	private Connection conn; // connection:db�������ϰ� ���ִ� ��ü
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public OrderManager() {
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
	public int getNext() { 
		String sql = "select max(no) from orderlist";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 0;//ù ��° �Խù��� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	public void insertOrder(int product_no, int quantity, String id, String name, String tel1, String tel2, String tel3, String postcode, String address, String detailAddress, String extraAddress, String message) {
		String sql = "insert into orderlist values(?,?,?,now(),?,?,?,?,?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, product_no);
			pstmt.setInt(3, quantity);
			pstmt.setString(4, "1");
			pstmt.setString(5, id);
			pstmt.setString(6, name);
			pstmt.setString(7, tel1);
			pstmt.setString(8, tel2);
			pstmt.setString(9, tel3);
			pstmt.setString(10, postcode);
			pstmt.setString(11, address);
			pstmt.setString(12, detailAddress);
			pstmt.setString(13, extraAddress);
			pstmt.setString(14, message);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	public ArrayList<OrderBean> getOrder(String id){
		String sql = "select * from orderlist where id=? order by no desc";
		ArrayList<OrderBean> list = new ArrayList<OrderBean>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()){
				OrderBean bean = new OrderBean();
				bean.setNo(rs.getInt(1));
				bean.setProduct_no(rs.getInt(2));
				bean.setQuantity(rs.getInt(3));
				bean.setSdate(rs.getString(4));
				bean.setState(rs.getString(5));
				bean.setId(rs.getString(6));
				bean.setName(rs.getString(7));
				bean.setTel1(rs.getString(8));
				bean.setTel2(rs.getString(9));
				bean.setTel3(rs.getString(10));
				bean.setPostcode(rs.getString(11));
				bean.setAddress(rs.getString(12));
				bean.setDetailAddress(rs.getString(13));
				bean.setExtraAddress(rs.getString(14));
				bean.setMessage(rs.getString(15));
				list.add(bean);
			}
			
		} catch (Exception e) {
			System.out.println("getOrder err : " + e);
		}
		return list;
	}
	
	public OrderBean getOneOrder(int no){
		String sql = "select * from orderlist where no=?";
		OrderBean bean = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			while(rs.next()){
				bean = new OrderBean();
				bean.setNo(rs.getInt(1));
				bean.setProduct_no(rs.getInt(2));
				bean.setQuantity(rs.getInt(3));
				bean.setSdate(rs.getString(4));
				bean.setState(rs.getString(5));
				bean.setId(rs.getString(6));
				bean.setName(rs.getString(7));
				bean.setTel1(rs.getString(8));
				bean.setTel2(rs.getString(9));
				bean.setTel3(rs.getString(10));
				bean.setPostcode(rs.getString(11));
				bean.setAddress(rs.getString(12));
				bean.setDetailAddress(rs.getString(13));
				bean.setExtraAddress(rs.getString(14));
				bean.setMessage(rs.getString(15));
				return bean;
			}
			
		} catch (Exception e) {
			System.out.println("getOrder err : " + e);
		}
		return null;
	}
	
	public ArrayList<OrderBean> getOrderAll(int start, int end) {
		ArrayList<OrderBean> list = new ArrayList<OrderBean>();
		String sql = "select * from orderlist limit ?,?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean bean = new OrderBean();
				bean.setNo(rs.getInt("no"));
				bean.setProduct_no(rs.getInt("product_no"));
				bean.setQuantity(rs.getInt("quantity"));
				bean.setSdate(rs.getString("sdate"));
				bean.setState(rs.getString("state"));
				bean.setId(rs.getString("id"));
				list.add(bean);
			}
		} catch (Exception e) {
			System.out.println("getOrderAll err : " + e);
		}
		return list;
	}
	
	//�Խñ� ��ȣ ��������
	public int getCount() { 
		String sql = "select count(*) from orderlist";
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
	}
	
	public int updateOrder(int no, int state) {
		String sql = "update orderlist set state = ? where no = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, state);
			pstmt.setInt(2, no);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateOrder err : " + e);
		} 
		return -1;
	}
	
	public int deleteOrder(int no) {
		String sql = "delete from orderlist where no=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("deleteOrder err : " + e);
		}
		return -1;
	}
	
	public int restorationStock(int product_no, int stock) {
		String sql = "update product_test set stock=stock+? where no=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, stock);
			pstmt.setInt(2, product_no);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("restorationStock err : " + e);
		}
		return -1;
	}
}

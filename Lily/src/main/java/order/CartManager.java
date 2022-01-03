package order;
import java.sql.*;
import java.util.ArrayList;

import order.CartBean;

public class CartManager {
	// dao : �����ͺ��̽� ���� ��ü�� ���ڷμ�
	// ���������� db���� ȸ������ �ҷ����ų� db�� ȸ������ ������

	private Connection conn; // connection:db�������ϰ� ���ִ� ��ü
	private PreparedStatement pstmt;
	private ResultSet rs;

	// mysql�� ������ �ִ� �κ�
	public CartManager() { // ������ ����ɶ����� �ڵ����� db������ �̷�� �� �� �ֵ�����
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
	
	//�Խñ� ��� �ҷ�����
		public ArrayList<CartBean> getList(String id){ 
			String sql = "select * from cart where id=?";
			ArrayList<CartBean> list = new ArrayList<CartBean>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					CartBean cart = new CartBean();
					cart.setNo(rs.getInt(1));
					cart.setProduct_no(rs.getInt(2));
					cart.setQuantity(rs.getInt(3));
					cart.setId(rs.getString(4));		
					cart.setIsOrder(rs.getInt(5));
					
					list.add(cart);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list; 
		}
		
		public int getNext() { 
			String sql = "select max(no) from cart";
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
	
	//īƮ�� ���� ��ǰ�� �ִ��� Ȯ��
	public int checkCart(String id, int no) {
		String sql = "select * from cart where id=? and product_no=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setInt(2, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return 1;
			} else {
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 		
	}
	
	public int getCartNo(String id, int no)
	{
		String sql = "select no from cart where id=? and product_no=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setInt(2, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			} else {
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 		
	}
	
	public int addCart(int product_no, int quantity, String id) {
		String sql = "insert into cart values(?, ?, ?, ?, 0)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, product_no);
			pstmt.setInt(3, quantity);
			pstmt.setString(4, id);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int plusCart(int no, int quantity) {
		String sql = "update cart set quantity = quantity + ? where no = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, quantity);
			pstmt.setInt(2, no);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int addCartDirect(int product_no, int quantity, String id) {
		String sql = "insert into cart values(?, ?, ?, ?, 1)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, product_no);
			pstmt.setInt(3, quantity);
			pstmt.setString(4, id);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int plusCartDirect(int no, int quantity) {
		String sql = "update cart set quantity = quantity + ? and isOrder=1 where no = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, quantity);
			pstmt.setInt(2, no);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public boolean updateCart(int no, int quantity) {
		String sql = "update cart set quantity = ? where no = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, quantity);
			pstmt.setInt(2, no);
			pstmt.executeUpdate();
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean deleteCart(int no) {
		String sql = "delete from cart where no = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean cartToOrder(int no)
	{
		String sql = "update cart set isOrder = 1 where no = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean orderCancel(int no)
	{
		String sql = "update cart set isOrder = 0 where no = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean orderClear(int no)
	{
		String sql = "update cart set isOrder = 0 where no = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean deleteCartAll(String id) {
		String sql = "delete from cart where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}

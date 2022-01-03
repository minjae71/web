package product;
import java.sql.*;
import java.util.ArrayList;

import java.io.File;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ProductManager {
	// dao : �����ͺ��̽� ���� ��ü�� ���ڷμ�
	// ���������� db���� ȸ������ �ҷ����ų� db�� ȸ������ ������

	private Connection conn; // connection:db�������ϰ� ���ִ� ��ü
	private PreparedStatement pstmt;
	private ResultSet rs;

	// mysql�� ������ �ִ� �κ�
	public ProductManager() { // ������ ����ɶ����� �ڵ����� db������ �̷�� �� �� �ֵ�����
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
	
	public int countProduct() {
		String sql = "select count(*) from product";
		try {
			pstmt = conn.prepareStatement(sql);
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
	
	public int countProductType(int type) {
		String sql = "select count(*) from product where type=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, type);
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
	
	public ArrayList<ProductBean> getProductAll(int start, int end){
		String sql = "select * from product order by no desc limit ?,?";
		ArrayList<ProductBean> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean product = new ProductBean();
				product.setNo(rs.getInt("no"));
				product.setType(rs.getInt("type"));
				product.setName(rs.getString("name"));
				product.setPrice(rs.getInt("price"));
				product.setDetail(rs.getString("detail"));
				product.setSdate(rs.getString("sdate"));
				product.setReserves(rs.getInt("reserves"));
				product.setImage1(rs.getString("image1"));
				product.setImage2(rs.getString("image2"));
				product.setImage3(rs.getString("image3"));
				product.setImage4(rs.getString("image4"));
				product.setImage5(rs.getString("image5"));
				list.add(product);                
			}
		} catch (Exception e) {
            e.printStackTrace();
        } 
        return list;
	}
	
	public ArrayList<ProductBean> getProductType(int start, int end, int type){
		String sql = "select * from product where type=? order by no desc limit ?,?";
		ArrayList<ProductBean> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, type);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean product = new ProductBean();
				product.setNo(rs.getInt("no"));
				product.setType(rs.getInt("type"));
				product.setName(rs.getString("name"));
				product.setPrice(rs.getInt("price"));
				product.setDetail(rs.getString("detail"));
				product.setSdate(rs.getString("sdate"));
				product.setReserves(rs.getInt("reserves"));
				product.setImage1(rs.getString("image1"));
				product.setImage2(rs.getString("image2"));
				product.setImage3(rs.getString("image3"));
				product.setImage4(rs.getString("image4"));
				product.setImage5(rs.getString("image5"));
				list.add(product);                
			}
		} catch (Exception e) {
            e.printStackTrace();
        }
        return list;
	}
	
	//�Խñ� �ҷ�����
	public ProductBean getProduct(int no) {
		ProductBean product = null;
		String sql = "select * from product where no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				product = new ProductBean();
				product.setNo(rs.getInt(1));
				product.setType(rs.getInt(2));
				product.setName(rs.getString(3));
				product.setPrice(rs.getInt(4));
				product.setDetail(rs.getString(5));
				product.setSdate(rs.getString(6));
				product.setReserves(rs.getInt(7));
				product.setImage1(rs.getString(8));
				product.setImage2(rs.getString(9));
				product.setImage3(rs.getString(10));
				product.setImage4(rs.getString(11));
				product.setImage5(rs.getString(12));
				
				return product;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//�̸����� ���� ����
	public String insertPreviewImg(HttpServletRequest request){
		String imageName = "noImage.jsp";
		try {
			//���� ���� ���
			ServletContext context = request.getSession().getServletContext();
			String fileDir = context.getRealPath("/img/product/");
			//���� ����
			MultipartRequest multi = new MultipartRequest(
					request,  //��ü
					fileDir,  //������ 
					5 * 1024 * 1024,  //���� �ִ� ũ��
					"UTF-8"   //���� ���ڵ�
			);
			//�̹����� ���� ���, ���ϰ� ����
			if(multi.getFilesystemName("image")!=null)
				//����� �̸����� ���ϸ� ���
				imageName = multi.getFilesystemName("image");
			
		} catch (Exception e) {
			System.out.println("previewImage err : " + e);
		} 
		return imageName;
	}
	
	//�̸����� ���� ����
	public void deletePreviewImg(HttpServletRequest request){
		//���� ���
		ServletContext context = request.getSession().getServletContext();
		String fileDir = context.getRealPath("/img/preview/");

		//preview ���� ������ ������ �ʿ䰡 ���� ������ ��÷� �����
		File file = new File(fileDir);
		if(file.isDirectory()){
			for(File f:file.listFiles()){
				f.delete();
			}
		}
	}
	
	//��ǰ �߰�
	public boolean insertProduct(HttpServletRequest request){
		boolean b = false;
		try {
			//���� ��Ʈ���
			ServletContext context = request.getSession().getServletContext();
			String uploadDir = context.getRealPath("/img/product/");
			//���� ����
			MultipartRequest multi = new MultipartRequest(
					request,  //��ü
					uploadDir,  //������ 
					5 * 1024 * 1024,  //���� �ִ� ũ��
					"UTF-8",   //���� ���ڵ�
					new DefaultFileRenamePolicy() //�ߺ� ���� ó�� �������̽�
			);
			//�����ͺ��̽� ó��
			String sql = "insert into product(type,name,price,detail,sdate,reserves,image1,image5) values (?,?,?,?,now(),?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(multi.getParameter("type")));
			pstmt.setString(2, multi.getParameter("name"));
			pstmt.setInt(3, Integer.parseInt(multi.getParameter("price")));
			pstmt.setString(4, multi.getParameter("detail"));
			pstmt.setInt(5, Integer.parseInt(multi.getParameter("reserves")));
			//�̹����� ���� ���, �غ��� �̹����� ��ü
			if(multi.getFilesystemName("image1")==null){
				pstmt.setString(6, "noImage.png");
			} else {
				pstmt.setString(6, multi.getFilesystemName("image1"));
			}
			if(multi.getFilesystemName("image5")==null){
				pstmt.setString(7, "noImage.png");
			} else {
				pstmt.setString(7, multi.getFilesystemName("image5"));
			}
			if(pstmt.executeUpdate()>0)b=true;
		} catch (Exception e) {
			System.out.println("insertProduct err : " + e);
		} finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return b;
	}
	//��ǰ ����
	public boolean updateProduct(HttpServletRequest request){
		boolean b=false;
		try {
			//���� ��Ʈ���
			ServletContext context = request.getSession().getServletContext();
			String uploadDir = context.getRealPath("/img/product/");

			//���� ����
			MultipartRequest multi = new MultipartRequest(
					request,  //��ü
					uploadDir,  //������ 
					5 * 1024 * 1024,  //���� �ִ� ũ��
					"UTF-8",   //���� ���ڵ�
					new DefaultFileRenamePolicy() //�ߺ� ���� ó�� �������̽�
			);
			System.out.println(multi.getParameter("imageType"));
			//�̹����� �������� �ʾ��� ���
			if(multi.getParameter("imageType").equals("3")) {
				String sql = "update product set name=?, price=?, detail=?, reserves=? where no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setInt(2, Integer.parseInt(multi.getParameter("price")));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setInt(4, Integer.parseInt(multi.getParameter("reserves")));
				pstmt.setInt(5, Integer.parseInt(multi.getParameter("no")));
			} else if(multi.getParameter("imageType").equals("2")) {
				String sql = "update product set name=?, price=?, detail=?, reserves=?, image1=? where no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setInt(2, Integer.parseInt(multi.getParameter("price")));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setInt(4, Integer.parseInt(multi.getParameter("reserves")));
				pstmt.setString(5, multi.getFilesystemName("image1"));
				pstmt.setInt(6, Integer.parseInt(multi.getParameter("no")));
			} else if(multi.getParameter("imageType").equals("1")) {
				String sql = "update product set name=?, price=?, detail=?, reserves=?, image5=? where no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setInt(2, Integer.parseInt(multi.getParameter("price")));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setInt(4, Integer.parseInt(multi.getParameter("reserves")));
				pstmt.setString(5, multi.getFilesystemName("image5"));
				pstmt.setInt(6, Integer.parseInt(multi.getParameter("no")));
			} else {
				String sql = "update product set name=?, price=?, detail=?, reserves=?, image1=?, image5=? where no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setInt(2, Integer.parseInt(multi.getParameter("price")));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setInt(4, Integer.parseInt(multi.getParameter("reserves")));
				pstmt.setString(5, multi.getFilesystemName("image1"));
				pstmt.setString(6, multi.getFilesystemName("image5"));
				pstmt.setInt(7, Integer.parseInt(multi.getParameter("no")));
			}
			if(pstmt.executeUpdate()>0)b=true;
		} catch (Exception e) {
			System.out.println("updateProduct err : " + e);
		}
		return b;
	}
	//��ǰ ����
	public boolean deleteProduct(int no){
		boolean b=false;
		try {
			String sql = "delete from product where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			if(pstmt.executeUpdate()>0)b=true;
		} catch (Exception e) {
			System.out.println("deleteProduct err : " +e);
		}
		return b;
	}
}

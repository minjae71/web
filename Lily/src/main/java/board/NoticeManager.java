package board;

import java.sql.*;
import java.util.ArrayList;

import java.io.File;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class NoticeManager {
	private Connection conn;
	private ResultSet rs;

	//DB ����
	public NoticeManager() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/lilyDB?characterEncoding=UTF-8&serverTimezone=Asia/Seoul"; // localhost:3306 ��Ʈ�� ��ǻ�ͼ�ġ�� mysql�ּ�
			String dbwriter = "root";
			String dbPWD = "multi2020";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbwriter, dbPWD);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//���� �ð� ��������
	public String getDate() { 
		String sql = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //�����ͺ��̽� ����
	}
	
	//�Խñ� ��ȣ ��������
	public int getNext() { 
		String sql = "select no from notice order by no desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;//ù ��° �Խù��� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	public int countNotice() {
		String sql = "select count(*) from notice";
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
		
	//�Խñ� �ۼ�
	/*public int write(String subject, String writer, String content) { 
		String sql = "insert into notice VALUES(?, ?, ?, ?, ?, ?)";
		try {					
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, writer);
			pstmt.setString(3, subject);
			pstmt.setString(4, getDate());
			pstmt.setInt(5, 0);
			pstmt.setString(6, content);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}*/
	
	//�̸����� ���� ����
		public String insertPreviewImg(HttpServletRequest request){
			String imageName = null;
			try {
				//���� ���� ���
				ServletContext context = request.getSession().getServletContext();
				String fileDir = context.getRealPath("/img/preview/");
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
		
	public boolean insertNotice(HttpServletRequest request)
	{
		boolean b = false;
		try {
			//���� ��Ʈ���
			ServletContext context = request.getSession().getServletContext();
			String uploadDir = context.getRealPath("/img/notice/");
			//���� ����
			MultipartRequest multi = new MultipartRequest(
					request,  //��ü
					uploadDir,  //������ 
					5 * 1024 * 1024,  //���� �ִ� ũ��
					"UTF-8",   //���� ���ڵ�
					new DefaultFileRenamePolicy() //�ߺ� ���� ó�� �������̽�
			);
			//�����ͺ��̽� ó��
			String sql = "insert into notice values (?, ?, ?, ?, ?, ?, ?)";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, multi.getParameter("writer"));
			pstmt.setString(3, multi.getParameter("subject"));
			pstmt.setString(4, getDate());
			pstmt.setInt(5, 0);
			pstmt.setString(6, multi.getParameter("content"));
			if(multi.getFilesystemName("image")==null){
				pstmt.setString(7, null);
			} else {
				pstmt.setString(7, multi.getFilesystemName("image"));
			}
			
			if(pstmt.executeUpdate()>0)b=true;
		} catch (Exception e) {
			System.out.println("insertProduct err : " + e);
		}
		return b;
	}
		
	//�Խñ� ��� �ҷ�����
	public ArrayList<NoticeBean> getList(int start, int end){ 
		String sql = "select * from notice order by no desc limit ?, ?";
		ArrayList<NoticeBean> list = new ArrayList<NoticeBean>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NoticeBean notice = new NoticeBean();
				notice.setNum(rs.getInt(1));
				notice.setWriter(rs.getString(2));
				notice.setSubject(rs.getString(3));
				notice.setWritedate(rs.getString(4));
				notice.setReadcount(rs.getInt(5));
				notice.setContent(rs.getString(6));
				notice.setImage(rs.getString(7));
				
				list.add(notice);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}

	//10 ���� ����¡ ó���� ���� �Լ�
	public boolean nextPage (int pageNumber) {
		String sql = "select * from notice where no < ? order by no desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; 		
	}
		
	//��ȸ�� ���� �޼ҵ�
	public int viewUpdate(int no) {
		String sql = "update notice set readcount = readcount+1 where no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
		
	//�Խñ� �ҷ�����
	public NoticeBean getNotice(int no) {
		String sql = "select * from notice where no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				NoticeBean notice = new NoticeBean();
				notice.setNum(rs.getInt(1));
				notice.setWriter(rs.getString(2));
				notice.setSubject(rs.getString(3));
				notice.setWritedate(rs.getString(4));
				notice.setReadcount(rs.getInt(5));
				notice.setContent(rs.getString(6));
				notice.setImage(rs.getString(7));
				
				return notice;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean existNotice(int no)
	{
		String sql = "select * from notice where no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			return rs.next();
		} catch(Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}
		
	//�Խñ� ����
	public int update(int no, String subject, String content) {
		String sql = "update notice set subject = ?, content = ? where no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setInt(3, no);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	public String updateImage(int no)
	{
		String sql = "select image from notice where no=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				return rs.getString(1);
			}
			return null;
		} catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean updateNotice(HttpServletRequest request)
	{
		boolean b = false;
		try {
			//���� ��Ʈ���
			ServletContext context = request.getSession().getServletContext();
			String uploadDir = context.getRealPath("/img/notice/");
			//���� ����
			MultipartRequest multi = new MultipartRequest(
					request,  //��ü
					uploadDir,  //������ 
					5 * 1024 * 1024,  //���� �ִ� ũ��
					"UTF-8",   //���� ���ڵ�
					new DefaultFileRenamePolicy() //�ߺ� ���� ó�� �������̽�
			);
			//�����ͺ��̽� ó��
			String sql = "update notice set subject = ?, content = ?, image = ? where no = ?";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("subject"));
			pstmt.setString(2, multi.getParameter("content"));
			if(multi.getFilesystemName("image")==null){
				pstmt.setString(3, updateImage(Integer.parseInt(multi.getParameter("no"))));
			} else {
				pstmt.setString(3, multi.getFilesystemName("image"));
			}
			pstmt.setInt(4, Integer.parseInt(multi.getParameter("no")));
			
			if(pstmt.executeUpdate()>0)b=true;
		} catch (Exception e) {
			System.out.println("insertProduct err : " + e);
		}
		return b;
	}
	
	//�Խñ� ����
	public int delete(int no) {
		String sql = "delete from notice where no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}

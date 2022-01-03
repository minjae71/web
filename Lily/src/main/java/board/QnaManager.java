package board;

import java.sql.*;
import java.util.ArrayList;

import java.io.File;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class QnaManager {
	private Connection conn;
	private ResultSet rs;

	//DB ����
	public QnaManager() {
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
		String sql = "select no from qna order by no desc";
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
	
	public int countQna() {
		String sql = "select count(*) from qna";
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
	
	//�亯 �׷� ��������
	public int getRef() { 
		String sql = "select max(ref) from qna";
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
		
	//�Խñ� �ۼ�
	/*public int write(String subject, String writer, String content, String writeType) { 
		String sql = "insert into qna VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		int re_step = 1;
		int re_level = 1;
		try {					
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, writer);
			pstmt.setString(3, subject);
			pstmt.setString(4, getDate());
			pstmt.setInt(5, 0);
			pstmt.setString(6, content);
			if(writeType==null) {
				pstmt.setInt(7, 1);
			} else {
				pstmt.setInt(7, 2);
			}
			pstmt.setInt(8, getRef());
			pstmt.setInt(9, re_step);
			pstmt.setInt(10, re_level);

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
	
	public boolean insertQna(HttpServletRequest request)
	{
		boolean b = false;
		try {
			//���� ��Ʈ���
			ServletContext context = request.getSession().getServletContext();
			String uploadDir = context.getRealPath("/img/qna/");
			//���� ����
			MultipartRequest multi = new MultipartRequest(
					request,  //��ü
					uploadDir,  //������ 
					5 * 1024 * 1024,  //���� �ִ� ũ��
					"UTF-8",   //���� ���ڵ�
					new DefaultFileRenamePolicy() //�ߺ� ���� ó�� �������̽�
			);
			int re_step = 1;
			int re_level = 1;
			//�����ͺ��̽� ó��
			String sql = "insert into qna values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
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
			if(multi.getParameter("writeType")==null) {
				pstmt.setInt(8, 1);
			} else {
				pstmt.setInt(8, 2);
			}
			pstmt.setInt(9, getRef());
			pstmt.setInt(10, re_step);
			pstmt.setInt(11, re_level);
			
			if(pstmt.executeUpdate()>0)b=true;
		} catch (Exception e) {
			System.out.println("insertProduct err : " + e);
		}
		return b;
	}
		
	//�Խñ� ��� �ҷ�����
	public ArrayList<QnaBean> getList(int start, int end){ 
		String sql = "select * from qna order by ref desc, re_step asc limit ?, ?";
		ArrayList<QnaBean> list = new ArrayList<QnaBean>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				QnaBean QnaBean = new QnaBean();
				QnaBean.setNum(rs.getInt(1));
				QnaBean.setWriter(rs.getString(2));
				QnaBean.setSubject(rs.getString(3));
				QnaBean.setWritedate(rs.getString(4));
				QnaBean.setReadcount(rs.getInt(5));
				QnaBean.setContent(rs.getString(6));
				QnaBean.setImage(rs.getString(7));
				QnaBean.setWriteType(rs.getInt(8));
				QnaBean.setRef(rs.getInt(9));
				QnaBean.setRe_step(rs.getInt(10));
				QnaBean.setRe_level(rs.getInt(11));
				
				list.add(QnaBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	public ArrayList<QnaBean> getReply(int ref){ 
		String sql = "select * from qna where ref = ? order by ref desc, re_step asc";
		ArrayList<QnaBean> list = new ArrayList<QnaBean>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				QnaBean QnaBean = new QnaBean();
				QnaBean.setNum(rs.getInt(1));
				QnaBean.setWriter(rs.getString(2));
				QnaBean.setSubject(rs.getString(3));
				QnaBean.setWritedate(rs.getString(4));
				QnaBean.setReadcount(rs.getInt(5));
				QnaBean.setContent(rs.getString(6));
				QnaBean.setImage(rs.getString(7));
				QnaBean.setWriteType(rs.getInt(8));
				QnaBean.setRef(rs.getInt(9));
				QnaBean.setRe_step(rs.getInt(10));
				QnaBean.setRe_level(rs.getInt(11));
				
				list.add(QnaBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}

	//10 ���� ����¡ ó���� ���� �Լ�
	public boolean nextPage (int pageNumber) {
		String sql = "select * from qna where no < ? order by ref desc, re_step asc";
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
		String sql = "update qna set readcount = readcount+1 where no = ?";
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
	public QnaBean getQna(int no) {
		String sql = "select * from qna where no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				QnaBean qnaBean = new QnaBean();
				qnaBean.setNum(rs.getInt(1));
				qnaBean.setWriter(rs.getString(2));
				qnaBean.setSubject(rs.getString(3));
				qnaBean.setWritedate(rs.getString(4));
				qnaBean.setReadcount(rs.getInt(5));
				qnaBean.setContent(rs.getString(6));
				qnaBean.setImage(rs.getString(7));
				qnaBean.setWriteType(rs.getInt(8));
				qnaBean.setRef(rs.getInt(9));
				qnaBean.setRe_step(rs.getInt(10));
				qnaBean.setRe_level(rs.getInt(11));
				
				return qnaBean;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int existQna(int ref)
	{
		String sql = "select no from qna where ref = ? and re_step=1 and re_level=1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				return rs.getInt(1);
			}
			return 0;
		} catch(Exception e)
		{
			e.printStackTrace();
		}
		return -1;
	}
	
	public boolean existReply(int ref)
	{
		String sql = "select no from qna where ref = ? order by ref desc, re_step asc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				return true;
			}
			return false;
		} catch(Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}
		
	//�Խñ� ����
	public int update(int no, String subject, String content) {
		String sql = "update qna set subject = ?, content = ? where no = ?";
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
		String sql = "select image from qna where no=?";
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
	
	public boolean updateQna(HttpServletRequest request)
	{
		boolean b = false;
		try {
			//���� ��Ʈ���
			ServletContext context = request.getSession().getServletContext();
			String uploadDir = context.getRealPath("/img/qna/");
			//���� ����
			MultipartRequest multi = new MultipartRequest(
					request,  //��ü
					uploadDir,  //������ 
					5 * 1024 * 1024,  //���� �ִ� ũ��
					"UTF-8",   //���� ���ڵ�
					new DefaultFileRenamePolicy() //�ߺ� ���� ó�� �������̽�
			);
			//�����ͺ��̽� ó��
			String sql = "update qna set subject = ?, content = ?, image = ? where no = ?";
			
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
	
	//�亯�� ����
	public int reWriteUpdate(int ref, int re_level) {
		try {
			String levelsql = "update qna set re_level=re_level+1 where ref=? and re_level > ?";
			PreparedStatement pstmt = conn.prepareStatement(levelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public boolean reInsertQna(HttpServletRequest request, int ref, int re_step, int re_level)
	{
		boolean b = false;
		try {
			//���� ��Ʈ���
			ServletContext context = request.getSession().getServletContext();
			String uploadDir = context.getRealPath("/img/qna/");
			//���� ����
			MultipartRequest multi = new MultipartRequest(
					request,  //��ü
					uploadDir,  //������ 
					5 * 1024 * 1024,  //���� �ִ� ũ��
					"UTF-8",   //���� ���ڵ�
					new DefaultFileRenamePolicy() //�ߺ� ���� ó�� �������̽�
			);
			//�����ͺ��̽� ó��
			String sql = "insert into qna values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
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
			if(multi.getParameter("writeType")==null) {
				pstmt.setInt(8, 1);
			} else {
				pstmt.setInt(8, 2);
			}
			pstmt.setInt(9, Integer.parseInt(multi.getParameter("ref")));
			pstmt.setInt(10, re_step + 1);
			pstmt.setInt(11, re_level + 1);
			
			if(pstmt.executeUpdate()>0)b=true;
		} catch (Exception e) {
			System.out.println("insertProduct err : " + e);
		}
		return b;
	}
	
	/*public int reWrite(String subject, String writer, String content, String writeType, int ref, int re_step, int re_level) {
		String sql = "insert into qna VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {					
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, writer);
			pstmt.setString(3, subject);
			pstmt.setString(4, getDate());
			pstmt.setInt(5, 0);
			pstmt.setString(6, content);
			if(writeType==null) {
				pstmt.setInt(7, 1);
			} else {
				pstmt.setInt(7, 2);
			}
			pstmt.setInt(8, ref);
			pstmt.setInt(9, re_step + 1);
			pstmt.setInt(10, re_level + 1);
				return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}*/
	
	//�Խñ� �� �� ����(���)
	public int deleteOne(int no) {
		String sql = "delete from qna where no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	//�Խñ� ��ü ����(������ �������� ��� ����)
	public int deleteAll(int ref) {
		String sql = "delete from qna where ref = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}

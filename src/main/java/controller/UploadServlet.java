
package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
	    maxFileSize = 1024 * 1024 * 50,      // 50MB
	    maxRequestSize = 1024 * 1024 * 100   // 100MB
	)
	public class UploadServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;

	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	        
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");

	        try {
	            Part filePart = request.getPart("music-file");
	            String fileName = filePart.getSubmittedFileName();

	            if (filePart == null || fileName == null || fileName.isEmpty()) {
	                response.getWriter().write("{\"success\": false, \"error\": \"파일이 없습니다.\"}");
	                return;
	            }

	            // 파일 저장 경로
	            String uploadPath = "C:\\Users\\Administrator\\Uploads\\" + fileName;
	            filePart.write(uploadPath);

	            // 세션에 업로드된 파일명 저장
	            HttpSession session = request.getSession();
	            session.setAttribute("uploadedFileName", fileName);

	            // ✅ JSON 응답을 안전하게 반환
	            JSONObject jsonResponse = new JSONObject();
	            jsonResponse.put("success", true);
	            jsonResponse.put("fileName", fileName);

	            response.getWriter().write(jsonResponse.toString());

	        } catch (Exception e) {
	            e.printStackTrace();
	            String errorMessage = e.getMessage().replace("\"", "\\\""); // JSON 형식 오류 방지
	            response.getWriter().write("{\"success\": false, \"error\": \"" + errorMessage + "\"}");
	        }
	    }

	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET 메서드는 지원되지 않습니다.");
	    }
	}
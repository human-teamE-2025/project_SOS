package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UploadFinalServlet")
public class UploadFinalServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "C:/uploaded_files/";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String uploadedFileName = (String) session.getAttribute("uploadedFileName");
        String songTitle = (String) session.getAttribute("songTitle");
        String artist = (String) session.getAttribute("artist");
        String genre = (String) session.getAttribute("genre");
        String description = request.getParameter("description");

        // 추가 정보 저장 (txt 파일)
        File metaDataFile = new File(UPLOAD_DIR + songTitle + "_info.txt");
        try (FileOutputStream output = new FileOutputStream(metaDataFile)) {
            String data = "제목: " + songTitle + "\n아티스트: " + artist + "\n장르: " + genre + "\n설명: " + description;
            output.write(data.getBytes());
        }

        response.getWriter().println("✅ 업로드 완료!");
    }
}

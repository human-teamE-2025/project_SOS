package controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class TestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;  // serialVersionUID 추가

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // JSP 페이지로 전달할 데이터를 설정
        request.setAttribute("message", "Hello from TestServlet!");
        
        // JSP 페이지로 포워딩
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/test.jsp");
        dispatcher.forward(request, response);
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.DAOProduct;
import entity.Categories;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name = "SearchControll", urlPatterns = {"/search"})
public class SearchControll extends HttpServlet {
    DAOProduct dao = new DAOProduct();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchControll</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchControll at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txt = request.getParameter("txt");
        if(txt == null || txt.isBlank() ){
        String cate = request.getParameter("cate");
        int cateid = Integer.parseInt(cate);
        dao.getProductbyCateId(cateid);
        List<Product> allpro = dao.getPro();
        dao.getAllCate();
        List<Categories> allcate = dao.getCate();
         request.setAttribute("cate", allcate);
        request.setAttribute("pro", allpro);
         request.getRequestDispatcher("shop.jsp").forward(request, response);
        }else{
            doPost(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txt = request.getParameter("txt");
        dao.searchProductShop(txt);
        
        List<Product> allpro = dao.getPro();
        if(allpro == null || allpro.isEmpty()){
            allpro =   dao.fuzzySearchProducts(txt, 60, 15);
          
        }
        dao.getAllCate();
        List<Categories> allcate = dao.getCate();
        
        
         int page, numberPage = 6;
        int size = allpro.size();
        int num = (size % 6 == 0 ? (size / 6) : ((size / 6) + 1));
        String xpage = request.getParameter("spage");
        if (xpage == null || xpage.equals("")) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start, end;
        start = (page - 1) * numberPage;
        end = Math.min(page * numberPage, size);
        dao.getAllProductPagging(allpro, start, end);
        List<Product> proPagging = dao.getPro();
        dao.getAllCate();
        List<Categories> cate = dao.getCate();
        
        request.setAttribute("txt", txt);
        request.setAttribute("cate", cate);
        request.setAttribute("pro", proPagging);
        request.setAttribute("num1", num);
        request.setAttribute("page1", page);
         request.setAttribute("cate", allcate);
         request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

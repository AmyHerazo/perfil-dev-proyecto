package com.perfildevproyecto.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {

    private static final String ADMIN_USER = "admin";
    private static final String ADMIN_PASS = "admin123";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String usuario = req.getParameter("usuario");
        String clave = req.getParameter("clave");

        if (ADMIN_USER.equals(usuario) && ADMIN_PASS.equals(clave)) {
            HttpSession session = req.getSession();
            session.setAttribute("usuario", usuario);
            resp.sendRedirect("index.jsp");
        } else {
            req.setAttribute("error", "Credenciales inválidas");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("login.jsp");
    }
}

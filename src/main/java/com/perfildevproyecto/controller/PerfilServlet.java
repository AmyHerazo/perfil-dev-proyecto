package com.miapp.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.miapp.dao.PerfilDAOJSON; // ajusta el package si lo tienes distinto
import com.miapp.model.Perfil;      // ajusta el package si lo tienes distinto

@MultipartConfig
@WebServlet(name = "PerfilServlet", urlPatterns = {"/perfil"})
public class PerfilServlet extends HttpServlet {

    private final PerfilDAOJSON perfilDao = new PerfilDAOJSON();
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Devuelve el perfil en JSON (o null si no existe)
        Perfil perfil = perfilDao.cargarPerfil();
        resp.setContentType("application/json; charset=UTF-8");
        if (perfil == null) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            mapper.writeValue(resp.getOutputStream(), null);
            return;
        }
        mapper.writeValue(resp.getOutputStream(), perfil);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Espera multipart/form-data con campos:
        // nombre, bio, email, telefono, experiencia y file campo "foto" (opcional)
        req.setCharacterEncoding("UTF-8");
        String nombre = req.getParameter("nombre");
        String bio = req.getParameter("bio");
        String email = req.getParameter("email");
        String telefono = req.getParameter("telefono");
        String experiencia = req.getParameter("experiencia");

        byte[] fotoBytes = null;
        Part fotoPart = null;
        try {
            fotoPart = req.getPart("foto");
        } catch (IllegalStateException | ServletException ignore) {
            // no multipart o tamaño excedido -> sigue sin foto
        }

        if (fotoPart != null && fotoPart.getSize() > 0) {
            try (InputStream is = fotoPart.getInputStream()) {
                fotoBytes = is.readAllBytes();
            }
        } else {
            // si ya existe perfil y no se envia foto, mantenemos la anterior
            Perfil existente = perfilDao.cargarPerfil();
            if (existente != null) {
                fotoBytes = existente.getFoto();
            }
        }

        // Creamos el objeto Perfil (usa el constructor que)
        Perfil nuevo = new Perfil(
                nombre != null ? nombre : "",
                bio != null ? bio : "",
                email != null ? email : "",
                telefono != null ? telefono : "",
                fotoBytes,
                experiencia != null ? experiencia : ""
        );

        // Si ya existe un perfil, usamos actualizarPerfil (implementation) si existe,
        // sino usamos guardarPerfil. Usamos directamente PerfilDAOJSON para compatibilidad.
        Perfil existente = perfilDao.cargarPerfil();
        if (existente == null) {
            perfilDao.guardarPerfil(nuevo);
        } else {
            // si quieres preservar campos que vengan vacíos, podrías mezclar aqui.
            perfilDao.actualizarPerfil(nuevo);
        }

        resp.setContentType("application/json; charset=UTF-8");
        resp.setStatus(HttpServletResponse.SC_OK);
        mapper.writeValue(resp.getOutputStream(), nuevo);
    }
}

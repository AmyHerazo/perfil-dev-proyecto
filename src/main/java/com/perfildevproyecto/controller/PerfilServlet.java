package com.perfildevproyecto.controller;

import com.perfildevproyecto.dao.PerfilDAO;
import com.perfildevproyecto.dao.impl.PerfilDAOJSON;
import com.perfildevproyecto.model.Perfil;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;

@MultipartConfig
@WebServlet(name = "PerfilServlet", urlPatterns = { "/perfil" })
public class PerfilServlet extends HttpServlet {

    private final PerfilDAO perfilDao = new PerfilDAOJSON();
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
        req.setCharacterEncoding("UTF-8");
        String nombre = req.getParameter("nombre");
        String bio = req.getParameter("bio");
        String email = req.getParameter("email");
        String telefono = req.getParameter("telefono");
        String experiencia = req.getParameter("experiencia");

        String tituloBanner = req.getParameter("tituloBanner");
        String subtituloBanner = req.getParameter("subtituloBanner");

        byte[] fotoBytes = null;
        Part fotoPart = null;
        try {
            fotoPart = req.getPart("foto");
        } catch (IllegalStateException | ServletException ignore) {
        }

        if (fotoPart != null && fotoPart.getSize() > 0) {
            try (InputStream is = fotoPart.getInputStream()) {
                fotoBytes = is.readAllBytes();
            }
        } else {
            Perfil existente = perfilDao.cargarPerfil();
            if (existente != null) {
                fotoBytes = existente.getFoto();
            }
        }

        Perfil nuevo = new Perfil(
                nombre != null ? nombre : "",
                bio != null ? bio : "",
                email != null ? email : "",
                telefono != null ? telefono : "",
                fotoBytes,
                experiencia != null ? experiencia : "",
                tituloBanner != null ? tituloBanner : "Mi Perfil",
                subtituloBanner != null ? subtituloBanner
                        : "Portafolio interactivo de desarrollo y habilidades técnicas");

        Perfil existente = perfilDao.cargarPerfil();
        if (existente == null) {
            perfilDao.guardarPerfil(nuevo);
        } else {
            perfilDao.actualizar(nuevo);
        }

        resp.setContentType("application/json; charset=UTF-8");
        resp.setStatus(HttpServletResponse.SC_OK);
        mapper.writeValue(resp.getOutputStream(), nuevo);
    }
}

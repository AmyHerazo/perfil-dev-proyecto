package com.perfildevproyecto.controller;

import com.perfildevproyecto.dao.ProyectoDAO;
import com.perfildevproyecto.dao.impl.ProyectoDAOJSON;
import com.perfildevproyecto.model.Proyecto;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProyectoServlet", urlPatterns = { "/proyectos/*" })
public class ProyectoServlet extends HttpServlet {

    private final ProyectoDAO proyectoDao = new ProyectoDAOJSON();
    private final ObjectMapper mapper = new ObjectMapper();

    private String pathId(HttpServletRequest req) {
        String pi = req.getPathInfo();
        if (pi == null || pi.equals("/"))
            return null;
        if (pi.startsWith("/"))
            return pi.substring(1);
        return pi;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = pathId(req);
        resp.setContentType("application/json; charset=UTF-8");

        if (id == null) {
            List<Proyecto> lista = proyectoDao.listarTodos();
            mapper.writeValue(resp.getOutputStream(), lista);
        } else {
            Proyecto p = proyectoDao.buscarPorId(id);
            if (p == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                mapper.writeValue(resp.getOutputStream(), null);
            } else {
                mapper.writeValue(resp.getOutputStream(), p);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        Proyecto nuevo = mapper.readValue(req.getReader(), Proyecto.class);
        proyectoDao.agregar(nuevo);

        resp.setContentType("application/json; charset=UTF-8");
        resp.setStatus(HttpServletResponse.SC_CREATED);
        mapper.writeValue(resp.getOutputStream(), nuevo);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Proyecto actualizado = mapper.readValue(req.getReader(), Proyecto.class);

        if (actualizado.getId() == null || actualizado.getId().isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            mapper.writeValue(resp.getOutputStream(), "Debe incluir id para actualizar");
            return;
        }

        Proyecto existente = proyectoDao.buscarPorId(actualizado.getId());
        if (existente == null) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            mapper.writeValue(resp.getOutputStream(), "No existe el proyecto con ese id");
            return;
        }

        proyectoDao.actualizar(actualizado);
        resp.setContentType("application/json; charset=UTF-8");
        mapper.writeValue(resp.getOutputStream(), actualizado);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = pathId(req);
        if (id == null || id.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            mapper.writeValue(resp.getOutputStream(), "Debe proporcionar id en la URL: /proyectos/{id}");
            return;
        }
        Proyecto existente = proyectoDao.buscarPorId(id);
        if (existente == null) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            mapper.writeValue(resp.getOutputStream(), "No existe el proyecto con ese id");
            return;
        }
        proyectoDao.eliminar(id);
        resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }
}

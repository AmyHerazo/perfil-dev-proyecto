package com.miapp.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.miapp.dao.HabilidadDAOJSON; // ajusta package si lo tienes distinto
import com.miapp.model.Habilidad;      // ajusta package si lo tienes distinto

@WebServlet(name = "HabilidadServlet", urlPatterns = {"/habilidades/*"})
public class HabilidadServlet extends HttpServlet {

    private final HabilidadDAOJSON habilidadDao = new HabilidadDAOJSON();
    private final ObjectMapper mapper = new ObjectMapper();

    // Util: extrae id de path /habilidades/{id}
    private String pathId(HttpServletRequest req) {
        String pi = req.getPathInfo(); // null, "/" o "/{id}"
        if (pi == null || pi.equals("/") ) return null;
        if (pi.startsWith("/")) return pi.substring(1);
        return pi;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = pathId(req);
        resp.setContentType("application/json; charset=UTF-8");

        if (id == null) {
            // listar todas
            List<Habilidad> lista = habilidadDao.listarTodas();
            mapper.writeValue(resp.getOutputStream(), lista);
        } else {
            // buscar por id
            Habilidad h = habilidadDao.buscarPorId(id);
            if (h == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                mapper.writeValue(resp.getOutputStream(), null);
            } else {
                mapper.writeValue(resp.getOutputStream(), h);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Crear nueva habilidad desde JSON en cuerpo
        req.setCharacterEncoding("UTF-8");
        Habilidad nueva = mapper.readValue(req.getReader(), Habilidad.class);
        habilidadDao.agregar(nueva);
        resp.setContentType("application/json; charset=UTF-8");
        resp.setStatus(HttpServletResponse.SC_CREATED);
        mapper.writeValue(resp.getOutputStream(), nueva);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Actualizar habilidad (JSON en cuerpo; debe contener id)
        req.setCharacterEncoding("UTF-8");
        Habilidad actualizada = mapper.readValue(req.getReader(), Habilidad.class);
        if (actualizada.getId() == null || actualizada.getId().isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            mapper.writeValue(resp.getOutputStream(), "Debe incluir id para actualizar");
            return;
        }
        Habilidad existente = habilidadDao.buscarPorId(actualizada.getId());
        if (existingNullCheck(existente, resp)) return;

        habilidadDao.actualizar(actualizada);
        resp.setContentType("application/json; charset=UTF-8");
        mapper.writeValue(resp.getOutputStream(), actualizada);
    }

    private boolean existingNullCheck(Habilidad existente, HttpServletResponse resp) throws IOException {
        if (existente == null) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            mapper.writeValue(resp.getOutputStream(), "No existe la habilidad con ese id");
            return true;
        }
        return false;
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = pathId(req);
        if (id == null || id.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            mapper.writeValue(resp.getOutputStream(), "Debe proporcionar id en la URL: /habilidades/{id}");
            return;
        }
        Habilidad existente = habilidadDao.buscarPorId(id);
        if (existente == null) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            mapper.writeValue(resp.getOutputStream(), "No existe la habilidad con ese id");
            return;
        }
        habilidadDao.eliminar(id);
        resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }
}
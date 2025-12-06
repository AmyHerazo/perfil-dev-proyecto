package com.perfildevproyecto.dao.impl;

import com.perfildevproyecto.dao.ProyectoDAO;
import com.perfildevproyecto.model.Proyecto;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ProyectoDAOJSON implements ProyectoDAO {

    private final String archivo = System.getProperty("user.dir") + File.separator + "data" + File.separator
            + "proyectos.json";
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public List<Proyecto> listarTodos() {
        try {
            File file = new File(archivo);
            if (!file.exists()) {
                return new ArrayList<>();
            }
            return objectMapper.readValue(file, new TypeReference<List<Proyecto>>() {
            });
        } catch (IOException e) {
            System.err.println("Error cargando proyectos: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    @Override
    public void agregar(Proyecto proyecto) {
        try {
            List<Proyecto> proyectos = listarTodos();
            proyecto.setId(generarNuevoId());
            proyectos.add(proyecto);
            File file = new File(archivo);
            if (file.getParentFile() != null) {
                file.getParentFile().mkdirs();
            }
            objectMapper.writeValue(file, proyectos);
        } catch (IOException e) {
            System.err.println("Error agregando proyecto: " + e.getMessage());
            throw new RuntimeException("No se pudo agregar el proyecto");
        }
    }

    @Override
    public void actualizar(Proyecto proyectoActualizado) {
        try {
            List<Proyecto> proyectos = listarTodos();
            boolean encontrado = false;
            for (int i = 0; i < proyectos.size(); i++) {
                if (proyectos.get(i).getId().equals(proyectoActualizado.getId())) {
                    proyectos.set(i, proyectoActualizado);
                    encontrado = true;
                    break;
                }
            }
            if (encontrado) {
                objectMapper.writeValue(new File(archivo), proyectos);
            }
        } catch (IOException e) {
            System.err.println("Error actualizando proyecto: " + e.getMessage());
            throw new RuntimeException("No se pudo actualizar el proyecto");
        }
    }

    @Override
    public void eliminar(String id) {
        try {
            List<Proyecto> proyectos = listarTodos();
            proyectos.removeIf(p -> p.getId().equals(id));
            objectMapper.writeValue(new File(archivo), proyectos);
        } catch (IOException e) {
            System.err.println("Error eliminando proyecto: " + e.getMessage());
            throw new RuntimeException("No se pudo eliminar este proyecto");
        }
    }

    @Override
    public Proyecto buscarPorId(String id) {
        List<Proyecto> proyectos = listarTodos();
        return proyectos.stream()
                .filter(p -> p.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    private String generarNuevoId() {
        List<Proyecto> proyectos = listarTodos();
        if (proyectos.isEmpty()) {
            return "1";
        }

        int maxId = proyectos.stream()
                .mapToInt(p -> {
                    try {
                        return Integer.parseInt(p.getId());
                    } catch (NumberFormatException e) {
                        return 0;
                    }
                })
                .max()
                .orElse(0);

        return String.valueOf(maxId + 1);
    }
}

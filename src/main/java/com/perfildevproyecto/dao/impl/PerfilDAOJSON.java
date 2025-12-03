package com.perfildevproyecto.dao.impl;

import com.perfildevproyecto.dao.PerfilDAO;
import com.perfildevproyecto.model.Perfil;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.io.IOException;

public class PerfilDAOJSON implements PerfilDAO {

    private final String archivo = System.getProperty("user.home") + File.separator + "perfil.json";
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void guardarPerfil(Perfil perfil) {
        try {
            objectMapper.writeValue(new File(archivo), perfil);
        } catch (IOException e) {
            System.err.println("Error guardando este perfil: " + e.getMessage());
            throw new RuntimeException("No se pudo guardar el perfil");
        }
    }

    @Override
    public Perfil cargarPerfil() {
        try {
            File file = new File(archivo);
            if (!file.exists()) {
                return null;
            }
            return objectMapper.readValue(file, Perfil.class);
        } catch (IOException e) {
            System.err.println("No se pudo cargar el perfil: " + e.getMessage());
            return null;
        }
    }

    @Override
    public void actualizar(Perfil perfil) {
        guardarPerfil(perfil);
    }
}

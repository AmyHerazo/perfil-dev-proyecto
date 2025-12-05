package com.perfildevproyecto.dao;

import com.perfildevproyecto.model.Perfil;

public interface PerfilDAO {
    void guardarPerfil(Perfil perfil);

    Perfil cargarPerfil();

    void actualizar(Perfil perfil);
}

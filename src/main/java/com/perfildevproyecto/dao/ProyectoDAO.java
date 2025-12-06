package com.perfildevproyecto.dao;

import com.perfildevproyecto.model.Proyecto;
import java.util.List;

public interface ProyectoDAO {
    List<Proyecto> listarTodos();

    void agregar(Proyecto proyecto);

    void actualizar(Proyecto proyecto);

    void eliminar(String id);

    Proyecto buscarPorId(String id);
}

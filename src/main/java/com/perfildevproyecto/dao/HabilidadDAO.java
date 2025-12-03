package com.perfildevproyecto.dao;

import com.perfildevproyecto.model.Habilidad;
import java.util.List;

public interface HabilidadDAO {
    List<Habilidad> listarTodas();

    void agregar(Habilidad habilidad);

    void actualizar(Habilidad habilidad);

    void eliminar(String id);

    Habilidad buscarPorId(String id);
}

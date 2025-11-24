public interface HabilidadDAO{
    
    List<Habilidad>listarTodas();
    void agregar(Habilidad habilidad );
    void actualizar(Habilidad habilidad );
    void eliminar(String id);
    void buscarPorId(String id);
}

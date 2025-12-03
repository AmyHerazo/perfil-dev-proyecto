public class Habilidad {
    private String id;
    private String nombre;
    private String categoria;
    private int nivel;
    private String descripcion;

    public Habilidad(String id, String nombre, String categoria, int nivel, String descripcion) {
        this.id = id;
        this.nombre = nombre;
        this.categoria = categoria;
        this.nivel = nivel;
        this.descripcion = descripcion;

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getNivel() {
        return nivel;
    }

    public void setNivel(int nivel) {
        this.nivel = nivel;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @Override

    public String toString() {
        return "Habilidad{" +
                "id='" + id + '\'' +
                ", nombre='" + nombre + '\'' +
                ", categoria='" + categoria + '\'' +
                ", nivel=" + nivel +
                ", descripcion='" + descripcion + '\'' +
                '}';
    }
}

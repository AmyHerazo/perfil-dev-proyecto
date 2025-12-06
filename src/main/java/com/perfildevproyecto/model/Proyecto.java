package com.perfildevproyecto.model;

public class Proyecto {
    private String id;
    private String titulo;
    private String descripcion;
    private String url;
    private String imagen;

    public Proyecto() {
    }

    public Proyecto(String id, String titulo, String descripcion, String url, String imagen) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.url = url;
        this.imagen = imagen;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    @Override
    public String toString() {
        return "Proyecto{" +
                "id='" + id + '\'' +
                ", titulo='" + titulo + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", url='" + url + '\'' +
                ", imagen='" + imagen + '\'' +
                '}';
    }
}

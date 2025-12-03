public class Perfil {
    private String nombre;
    private String bio;
    private String email;
    private String telefono;
    private byte[] foto;
    private String experiencia;

    public Perfil(String nombre, String bio, String email, String telefono, byte[] foto, String experiencia) {
        this.nombre = nombre;
        this.bio = bio;
        this.email = email;
        this.telefono = telefono;
        this.foto = foto;
        this.experiencia = experiencia;

    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }

    public String getExperiencia() {
        return experiencia;
    }

    public void setExperiencia(String experiencia) {
        this.experiencia = experiencia;
    }

    @Override

    public String toString() {
        return "Perfil{" +
                "nombre='" + nombre + '\'' +
                ", bio='" + bio + '\'' +
                ", email='" + email + '\'' +
                ", telefono='" + telefono + '\'' +
                ", foto=" + (foto != null ? foto.length + " bytes" : "null") +
                ", experiencia='" + experiencia + '\'' +
                '}';
    }

}

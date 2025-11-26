import java.io.File;
import java.io.IOException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class PerfilDAOJSON implements PerfilDAO {
     
    private final String archivo = "perfil.json";
    private ObjectMapper objectMapper = new ObjectMapper();


    @Override
    public void guardarPerfil(Perfil perfil){
     
        try {
            objectMapper.writeValue(new File(archivo), perfil);

         } catch (IOException e) {
            System.err.println("Error guardando  este perfil: " + e.getMessage());
            throw new RuntimeException("no se pudo guardar el perfil");
        }
        
    }

    
    @Override 
    public Perfil cargarPerfil(){
        try { 
            File file = new File(archivo);
            if (!file.exists()){
                return null;
            }
            return objectMapper.readValue(file, Perfil.class);

        } catch (IOException e) {
            System.err.println("no se pudo cargar el perfil: " + e.getMessage());
            return null;
        }
    }

    @Override

    public void actualizarPerfil(Perfil perfil){

        guardarPerfil(perfil);
    }

}

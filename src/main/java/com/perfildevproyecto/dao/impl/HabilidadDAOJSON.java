import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class HabilidadDAOJSON implements HabilidadDAO{

    private final String archivo = "habilidades.json";
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public List<Habilidad> listarTodas(){
        try {
            File file = new File(archivo);
            if (!file.exists()) {
                return new ArrayList<>();
            }
            return objectMapper.readValue(file, new TypeReference<List< Habilidad>>(){});

        } catch (IOException e) {
            System.err.println("error carcagndo habilidades: " + e.getMessage());
            return  new ArrayList<>();
        }
        

    }
    @Override
     public void agregar(Habilidad habilidad) {
        try {
            List<Habilidad> habilidades = listarTodas();
            habilidad.setId(generarNuevoId());
            habilidades.add(habilidad);
            objectMapper.writeValue(new File(archivo), habilidades);

        } catch (IOException e) {
            System.err.println("Error agregando habilidad: " + e.getMessage());
            throw new RuntimeException("No se pudo agregar la habilidad");
        }
    }

    @Override
    public void actualizar(Habilidad habilidadActualizada) {
        try {
            List<Habilidad> habilidades = listarTodas();
            for (int i = 0; i < habilidades.size(); i++) {
                if (habilidades.get(i).getId().equals(habilidadActualizada.getId())) {
                    habilidades.set(i, habilidadActualizada);
                    break;
                }
            }
            objectMapper.writeValue(new File(archivo), habilidades);

        } catch (IOException e) {
            System.err.println("Error actualizando habilidad: " + e.getMessage());
            throw new RuntimeException("No se pudo actualizar la habilidad");
        }
    }

    @Override
    public void eliminar(String id) {
        try {
            List<Habilidad> habilidades = listarTodas();
            habilidades.removeIf(h -> h.getId().equals(id));
            objectMapper.writeValue(new File(archivo), habilidades);
            
        } catch (IOException e) {
            System.err.println("Error eliminando habilidad: " + e.getMessage());
            throw new RuntimeException("No se pudo eliminar esta  habilidad");
        }
    }

    @Override
    public Habilidad buscarPorId(String id) {
        List<Habilidad> habilidades = listarTodas();
        return habilidades.stream()
                .filter(h -> h.getId().equals(id))
                .findFirst()
                .orElse(null);
    }
    private String generarNuevoId() {
        List<Habilidad> habilidades = listarTodas();
        if (habilidades.isEmpty()) {
            return "1";
        }
        
        int maxId = habilidades.stream()
                .mapToInt(h -> {
                    try {
                        return Integer.parseInt(h.getId());
                    } catch (NumberFormatException e) {
                        return 0;
                    }
                })
                .max()
                .orElse(0);
        
        return String.valueOf(maxId + 1);
    }


}
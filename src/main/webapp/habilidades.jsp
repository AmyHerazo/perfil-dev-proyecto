<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mis Habilidades</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="container">
            <header>
                <h1>Mis Habilidades</h1>
                <nav>
                    <a href="index.jsp">Inicio</a> |
                    <a href="perfil.jsp">Perfil</a>
                </nav>
            </header>

            <main>
                <div class="skills-container">
                    <div class="card form-card">
                        <h2>Gestionar Habilidad</h2>
                        <form id="habilidad-form">
                            <input type="hidden" id="id" name="id">

                            <div class="form-group">
                                <label for="nombre">Habilidad:</label>
                                <input type="text" id="nombre" name="nombre" required placeholder="Ej. Java, Python">
                            </div>

                            <div class="form-group">
                                <label for="categoria">Categoría:</label>
                                <select id="categoria" name="categoria">
                                    <option value="Lenguaje">Lenguaje</option>
                                    <option value="Framework">Framework</option>
                                    <option value="Herramienta">Herramienta</option>
                                    <option value="Base de Datos">Base de Datos</option>
                                    <option value="Otro">Otro</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="nivel">Nivel (1-5):</label>
                                <input type="range" id="nivel" name="nivel" min="1" max="5" value="3"
                                    oninput="this.nextElementSibling.value = this.value">
                                <output>3</output>
                            </div>

                            <div class="form-group">
                                <label for="descripcion">Descripción:</label>
                                <textarea id="descripcion" name="descripcion" rows="2"></textarea>
                            </div>

                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary" id="btn-save">Agregar</button>
                                <button type="button" class="btn btn-secondary" id="btn-cancel"
                                    style="display:none;">Cancelar</button>
                            </div>
                        </form>
                        <div id="mensaje" class="message"></div>
                    </div>

                    <div class="card list-card">
                        <h2>Lista de Habilidades</h2>
                        <div id="habilidades-list" class="grid-list">
                            <!-- Habilidades will be loaded here -->
                            <p>Cargando habilidades...</p>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script>
            const API_URL = '${pageContext.request.contextPath}/habilidades';
            let currentHabilidades = [];

            document.addEventListener('DOMContentLoaded', () => {
                loadHabilidades();

                document.getElementById('habilidad-form').addEventListener('submit', handleFormSubmit);
                document.getElementById('btn-cancel').addEventListener('click', resetForm);
            });

            async function loadHabilidades() {
                try {
                    const response = await fetch(API_URL);
                    if (response.ok) {
                        currentHabilidades = await response.json();
                        console.log('DEBUG - Habilidades recibidas:', currentHabilidades);
                        renderHabilidades(currentHabilidades);
                    }
                } catch (error) {
                    console.error('Error:', error);
                    document.getElementById('habilidades-list').innerHTML = '<p>Error cargando habilidades.</p>';
                }
            }

            function renderHabilidades(habilidades) {
                const container = document.getElementById('habilidades-list');
                container.innerHTML = '';

                if (habilidades.length === 0) {
                    container.innerHTML = '<p>No hay habilidades registradas.</p>';
                    return;
                }

                habilidades.forEach(h => {
                    const item = document.createElement('div');
                    item.className = 'skill-item';

                    // Use string concatenation to avoid JSP EL conflict
                    const stars = '★'.repeat(h.nivel) + '☆'.repeat(5 - h.nivel);

                    let html = '<div class="skill-info">';
                    html += '<h3>' + h.nombre + ' <span class="badge">' + h.categoria + '</span></h3>';
                    html += '<div class="skill-level">Nivel: ' + stars + '</div>';
                    html += '<p>' + (h.descripcion || '') + '</p>';
                    html += '</div>';

                    html += '<div class="skill-actions">';
                    html += '<button onclick="editHabilidad(\'' + h.id + '\')" class="btn-icon edit">✎</button>';
                    html += '<button onclick="deleteHabilidad(\'' + h.id + '\')" class="btn-icon delete">🗑</button>';
                    html += '</div>';

                    item.innerHTML = html;
                    container.appendChild(item);
                });
            }

            async function handleFormSubmit(e) {
                e.preventDefault();
                const id = document.getElementById('id').value;
                const data = {
                    id: id || null,
                    nombre: document.getElementById('nombre').value,
                    categoria: document.getElementById('categoria').value,
                    nivel: parseInt(document.getElementById('nivel').value),
                    descripcion: document.getElementById('descripcion').value
                };

                const method = id ? 'PUT' : 'POST';

                try {
                    const response = await fetch(API_URL, {
                        method: method,
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(data)
                    });

                    if (response.ok) {
                        showMessage(id ? 'Habilidad actualizada' : 'Habilidad agregada', 'success');
                        resetForm();
                        loadHabilidades();
                    } else {
                        showMessage('Error al guardar', 'error');
                    }
                } catch (error) {
                    console.error('Error:', error);
                    showMessage('Error de conexión', 'error');
                }
            }

            async function deleteHabilidad(id) {
                if (!confirm('¿Estás seguro de eliminar esta habilidad?')) return;

                try {
                    const response = await fetch(API_URL + '/' + id, { method: 'DELETE' });
                    if (response.ok) {
                        showMessage('Habilidad eliminada', 'success');
                        loadHabilidades();
                    } else {
                        showMessage('Error al eliminar', 'error');
                    }
                } catch (error) {
                    console.error('Error:', error);
                }
            }

            function editHabilidad(id) {
                const h = currentHabilidades.find(skill => skill.id === id);
                if (!h) return;

                document.getElementById('id').value = h.id;
                document.getElementById('nombre').value = h.nombre;
                document.getElementById('categoria').value = h.categoria;
                document.getElementById('nivel').value = h.nivel;
                document.getElementById('nivel').nextElementSibling.value = h.nivel;
                document.getElementById('descripcion').value = h.descripcion;

                document.getElementById('btn-save').textContent = 'Actualizar';
                document.getElementById('btn-cancel').style.display = 'inline-block';
                window.scrollTo(0, 0);
            }

            function resetForm() {
                document.getElementById('habilidad-form').reset();
                document.getElementById('id').value = '';
                document.getElementById('btn-save').textContent = 'Agregar';
                document.getElementById('btn-cancel').style.display = 'none';
                document.getElementById('nivel').nextElementSibling.value = 3;
            }

            function showMessage(msg, type) {
                const el = document.getElementById('mensaje');
                el.textContent = msg;
                el.className = 'message ' + type;
                setTimeout(() => el.textContent = '', 3000);
            }
        </script>
    </body>

    </html>
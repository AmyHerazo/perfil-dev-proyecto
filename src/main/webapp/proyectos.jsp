<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mis Proyectos</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="container">
            <header>
                <h1>Mis Proyectos</h1>
                <nav>
                    <a href="index.jsp">Inicio</a> |
                    <a href="perfil.jsp">Perfil</a> |
                    <a href="habilidades.jsp">Habilidades</a>
                </nav>
            </header>

            <main>
                <div class="skills-container">
                    <div class="card form-card">
                        <h2>Gestionar Proyecto</h2>
                        <form id="proyecto-form">
                            <input type="hidden" id="id" name="id">

                            <div class="form-group">
                                <label for="titulo">Título:</label>
                                <input type="text" id="titulo" name="titulo" required
                                    placeholder="Ej. E-commerce, Blog Personal">
                            </div>

                            <div class="form-group">
                                <label for="url">URL del Proyecto:</label>
                                <input type="url" id="url" name="url" placeholder="https://github.com/usuario/proyecto">
                            </div>

                            <div class="form-group">
                                <label for="imagen">URL de Imagen (Opcional):</label>
                                <input type="url" id="imagen" name="imagen"
                                    placeholder="https://ejemplo.com/imagen.jpg">
                            </div>

                            <div class="form-group">
                                <label for="descripcion">Descripción:</label>
                                <textarea id="descripcion" name="descripcion" rows="3" required></textarea>
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
                        <h2>Lista de Proyectos</h2>
                        <div id="proyectos-list" class="grid-list">
                            <!-- Proyectos will be loaded here -->
                            <p>Cargando proyectos...</p>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script>
            const API_URL = '${pageContext.request.contextPath}/proyectos';
            let currentProyectos = [];

            document.addEventListener('DOMContentLoaded', () => {
                loadProyectos();

                document.getElementById('proyecto-form').addEventListener('submit', handleFormSubmit);
                document.getElementById('btn-cancel').addEventListener('click', resetForm);
            });

            async function loadProyectos() {
                try {
                    const response = await fetch(API_URL);
                    if (response.ok) {
                        currentProyectos = await response.json();
                        renderProyectos(currentProyectos);
                    }
                } catch (error) {
                    console.error('Error:', error);
                    document.getElementById('proyectos-list').innerHTML = '<p>Error cargando proyectos.</p>';
                }
            }

            function renderProyectos(proyectos) {
                const container = document.getElementById('proyectos-list');
                container.innerHTML = '';

                if (proyectos.length === 0) {
                    container.innerHTML = '<p>No hay proyectos registrados.</p>';
                    return;
                }

                proyectos.forEach(p => {
                    const item = document.createElement('div');
                    item.className = 'skill-item'; // Reusing skill-item class for similar styling

                    let html = '<div class="skill-info">';
                    html += '<h3>' + p.titulo + '</h3>';
                    if (p.url) {
                        html += '<p><a href="' + p.url + '" target="_blank" style="color: var(--primary-color);">Ver Proyecto <i class="fas fa-external-link-alt"></i></a></p>';
                    }
                    html += '<p>' + (p.descripcion || '') + '</p>';
                    html += '</div>';

                    html += '<div class="skill-actions">';
                    html += '<button onclick="editProyecto(\'' + p.id + '\')" class="btn-icon edit">✎</button>';
                    html += '<button onclick="deleteProyecto(\'' + p.id + '\')" class="btn-icon delete">🗑</button>';
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
                    titulo: document.getElementById('titulo').value,
                    url: document.getElementById('url').value,
                    imagen: document.getElementById('imagen').value,
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
                        showMessage(id ? 'Proyecto actualizado' : 'Proyecto agregado', 'success');
                        resetForm();
                        loadProyectos();
                    } else {
                        showMessage('Error al guardar', 'error');
                    }
                } catch (error) {
                    console.error('Error:', error);
                    showMessage('Error de conexión', 'error');
                }
            }

            async function deleteProyecto(id) {
                if (!confirm('¿Estás seguro de eliminar este proyecto?')) return;

                try {
                    const response = await fetch(API_URL + '/' + id, { method: 'DELETE' });
                    if (response.ok) {
                        showMessage('Proyecto eliminado', 'success');
                        loadProyectos();
                    } else {
                        showMessage('Error al eliminar', 'error');
                    }
                } catch (error) {
                    console.error('Error:', error);
                }
            }

            function editProyecto(id) {
                const p = currentProyectos.find(proj => proj.id === id);
                if (!p) return;

                document.getElementById('id').value = p.id;
                document.getElementById('titulo').value = p.titulo;
                document.getElementById('url').value = p.url || '';
                document.getElementById('imagen').value = p.imagen || '';
                document.getElementById('descripcion').value = p.descripcion;

                document.getElementById('btn-save').textContent = 'Actualizar';
                document.getElementById('btn-cancel').style.display = 'inline-block';
                window.scrollTo(0, 0);
            }

            function resetForm() {
                document.getElementById('proyecto-form').reset();
                document.getElementById('id').value = '';
                document.getElementById('btn-save').textContent = 'Agregar';
                document.getElementById('btn-cancel').style.display = 'none';
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
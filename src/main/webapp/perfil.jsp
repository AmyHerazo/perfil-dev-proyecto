<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mi Perfil - Editar</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="container">
            <header>
                <h1>Mi Perfil</h1>
                <nav>
                    <a href="index.jsp">Inicio</a> |
                    <a href="habilidades.jsp">Habilidades</a>
                </nav>
            </header>

            <main>
                <div class="profile-card">
                    <div class="profile-header">
                        <img id="foto-preview" src="img/default-avatar.png" alt="Foto de Perfil" class="profile-img">
                        <h2 id="display-nombre">Cargando...</h2>
                        <p id="display-bio" class="bio">...</p>
                    </div>

                    <form id="perfil-form" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="nombre">Nombre:</label>
                            <input type="text" id="nombre" name="nombre" required>
                        </div>

                        <div class="form-group">
                            <label for="bio">Biografía:</label>
                            <textarea id="bio" name="bio" rows="3"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email">
                        </div>

                        <div class="form-group">
                            <label for="telefono">Teléfono:</label>
                            <input type="tel" id="telefono" name="telefono">
                        </div>

                        <div class="form-group">
                            <label for="experiencia">Experiencia:</label>
                            <textarea id="experiencia" name="experiencia" rows="4"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="foto">Foto de Perfil:</label>
                            <input type="file" id="foto" name="foto" accept="image/*">
                        </div>

                        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                        <div id="mensaje" class="message"></div>
                    </form>
                </div>
            </main>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', () => {
                loadPerfil();

                document.getElementById('perfil-form').addEventListener('submit', async (e) => {
                    e.preventDefault();
                    const formData = new FormData(e.target);

                    try {
                        const response = await fetch('perfil', {
                            method: 'POST',
                            body: formData
                        });

                        if (response.ok) {
                            const data = await response.json();
                            updateUI(data);
                            showMessage('Perfil actualizado con éxito', 'success');
                        } else {
                            showMessage('Error al actualizar perfil', 'error');
                        }
                    } catch (error) {
                        console.error('Error:', error);
                        showMessage('Error de conexión', 'error');
                    }
                });
            });

            async function loadPerfil() {
                try {
                    const response = await fetch('perfil');
                    if (response.ok) {
                        const data = await response.json();
                        if (data) updateUI(data);
                    }
                } catch (error) {
                    console.error('Error cargando perfil:', error);
                }
            }

            function updateUI(data) {
                document.getElementById('nombre').value = data.nombre || '';
                document.getElementById('bio').value = data.bio || '';
                document.getElementById('email').value = data.email || '';
                document.getElementById('telefono').value = data.telefono || '';
                document.getElementById('experiencia').value = data.experiencia || '';

                document.getElementById('display-nombre').textContent = data.nombre || 'Sin Nombre';
                document.getElementById('display-bio').textContent = data.bio || '';

                if (data.foto) {
                    // Assuming foto is base64 encoded by the backend or we handle it here
                    // The backend sends byte[], Jackson serializes it as Base64 string by default
                    document.getElementById('foto-preview').src = 'data:image/jpeg;base64,' + data.foto;
                }
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
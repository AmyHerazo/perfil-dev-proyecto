<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mi Perfil Dev</title>
        <link rel="stylesheet" href="css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    </head>

    <body>
        <div class="container landing-container">
            <header class="landing-header">
                <h1>Bienvenido a Mi Perfil Dev</h1>
                <p class="subtitle">Portafolio de Habilidades de Programación</p>
            </header>

            <main class="landing-main">
                <div class="card" style="border-left: 5px solid var(--secondary-color);">
                    <h2>Vista Pública</h2>
                    <p>Así es como los demás verán tu portafolio profesional.</p>
                    <a href="portafolio.jsp" class="btn btn-primary"
                        style="width: 100%; text-align: center; display: block;">Ver Mi Portafolio</a>
                </div>

                <div class="card">
                    <h2>Panel de Administración</h2>
                    <p>Edita tu información personal y gestiona tus habilidades.</p>
                    <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                        <a href="perfil.jsp" class="btn btn-secondary" style="flex: 1; text-align: center;">Editar
                            Perfil</a>
                        <a href="habilidades.jsp" class="btn btn-secondary"
                            style="flex: 1; text-align: center;">Gestionar Habilidades</a>
                    </div>
                </div>
            </main>

            <footer class="landing-footer">
                <p>&copy; 2025 Mi Perfil Dev. Todos los derechos reservados.</p>
            </footer>
        </div>
    </body>

    </html>
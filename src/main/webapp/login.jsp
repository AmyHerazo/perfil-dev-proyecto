<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Iniciar Sesión</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="container" style="display: flex; justify-content: center; align-items: center; height: 100vh;">
            <div class="card" style="width: 100%; max-width: 400px; padding: 2rem;">
                <h2 style="text-align: center; margin-bottom: 1.5rem;">Iniciar Sesión</h2>

                <% if (request.getAttribute("error") !=null) { %>
                    <div class="message error" style="margin-bottom: 1rem;">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>

                        <form action="login" method="post">
                            <div class="form-group">
                                <label for="usuario">Usuario:</label>
                                <input type="text" id="usuario" name="usuario" required>
                            </div>

                            <div class="form-group">
                                <label for="clave">Contraseña:</label>
                                <input type="password" id="clave" name="clave" required>
                            </div>

                            <button type="submit" class="btn btn-primary" style="width: 100%;">Entrar</button>
                        </form>
                        <div style="text-align: center; margin-top: 1rem;">
                            <a href="index.jsp">Volver al Inicio</a>
                        </div>
            </div>
        </div>
    </body>

    </html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil Dev | Portafolio Digital</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>
    <div class="container landing-container">
        <header class="landing-header">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-code"></i>
                    <h1>Mi Perfil<span class="highlight">Dev</span></h1>
                </div>
                <p class="subtitle">Portafolio interactivo de desarrollo y habilidades técnicas</p>
            </div>
            <div class="decoration">
                <div class="circle"></div>
                <div class="circle"></div>
                <div class="circle"></div>
            </div>
        </header>

        <main class="landing-main">
            <div class="card card-featured">
                <div class="card-icon">
                    <i class="fas fa-eye"></i>
                </div>
                <div class="card-content">
                    <h2><i class="fas fa-globe"></i> Vista Pública</h2>
                    <p>Así es como los reclutadores y colegas verán tu portafolio profesional. Incluye tus proyectos, habilidades y experiencia.</p>
                    <div class="card-features">
                        <span><i class="fas fa-check"></i> Diseño responsivo</span>
                        <span><i class="fas fa-check"></i> Optimizado para móviles</span>
                        <span><i class="fas fa-check"></i> Compatible con todos los navegadores</span>
                    </div>
                    <a href="portafolio.jsp" class="btn btn-primary">
                        <i class="fas fa-external-link-alt"></i> Ver Mi Portafolio Público
                    </a>
                </div>
            </div>

            <div class="card card-admin">
                <div class="card-icon">
                    <i class="fas fa-cogs"></i>
                </div>
                <div class="card-content">
                    <h2><i class="fas fa-user-cog"></i> Panel de Administración</h2>
                    <p>Gestiona toda tu información personal, proyectos y habilidades desde un solo lugar.</p>
                    
                    <div class="admin-options">
                        <a href="perfil.jsp" class="admin-option">
                            <div class="option-icon">
                                <i class="fas fa-user-edit"></i>
                            </div>
                            <div class="option-text">
                                <h3>Editar Perfil</h3>
                                <p>Actualiza tu información personal y profesional</p>
                            </div>
                            <div class="option-arrow">
                                <i class="fas fa-chevron-right"></i>
                            </div>
                        </a>
                        
                        <a href="habilidades.jsp" class="admin-option">
                            <div class="option-icon">
                                <i class="fas fa-tools"></i>
                            </div>
                            <div class="option-text">
                                <h3>Gestionar Habilidades</h3>
                                <p>Añade, edita o elimina tus habilidades técnicas</p>
                            </div>
                            <div class="option-arrow">
                                <i class="fas fa-chevron-right"></i>
                            </div>
                        </a>
                        
                        <a href="proyectos.jsp" class="admin-option">
                            <div class="option-icon">
                                <i class="fas fa-folder-open"></i>
                            </div>
                            <div class="option-text">
                                <h3>Mis Proyectos</h3>
                                <p>Administra tu portafolio de proyectos</p>
                            </div>
                            <div class="option-arrow">
                                <i class="fas fa-chevron-right"></i>
                            </div>
                        </a>
                    </div>
                </div>
            </div>

            <div class="stats-container">
                <div class="stat-card">
                    <i class="fas fa-project-diagram"></i>
                    <h3>0</h3>
                    <p>Proyectos Publicados</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-code-branch"></i>
                    <h3>0</h3>
                    <p>Habilidades Registradas</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-calendar-alt"></i>
                    <h3>2025</h3>
                    <p>Año de Creación</p>
                </div>
            </div>
        </main>

        <footer class="landing-footer">
            <div class="footer-content">
                <div class="footer-section">
                    <h4><i class="fas fa-info-circle"></i> Acerca de</h4>
                    <p>Plataforma para desarrolladores que desean mostrar su trabajo de manera profesional.</p>
                </div>
                <div class="footer-section">
                    <h4><i class="fas fa-bolt"></i> Acceso Rápido</h4>
                    <a href="portafolio.jsp">Portafolio</a>
                    <a href="perfil.jsp">Perfil</a>
                    <a href="habilidades.jsp">Habilidades</a>
                </div>
                <div class="footer-section">
                    <h4><i class="fas fa-shield-alt"></i> Seguridad</h4>
                    <p>Sesión activa: <span class="session-status">Usuario</span></p>
                    <a href="logout.jsp" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                    </a>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Mi Perfil Dev. Todos los derechos reservados. | 
                   <i class="fas fa-heart"></i> Hecho con pasión por desarrolladores</p>
            </div>
        </footer>
    </div>

    <script>
        document.querySelectorAll('.card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
                this.style.transition = 'transform 0.3s ease';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });

        document.querySelector('.footer-bottom p').innerHTML = 
            document.querySelector('.footer-bottom p').innerHTML.replace('2025', new Date().getFullYear());
    </script>
</body>

</html>
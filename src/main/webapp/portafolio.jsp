<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mi Portafolio</title>
        <link rel="stylesheet" href="css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <style>
            /* Specific styles for the portfolio view */
            .portfolio-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .profile-summary {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .profile-photo-large {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid var(--primary-color);
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .profile-details {
                text-align: center;
            }

            .profile-details h2 {
                margin-bottom: 0.5rem;
                color: var(--text-color);
            }

            .profile-details .bio {
                font-style: italic;
                color: var(--text-muted);
                margin-bottom: 1rem;
            }

            .contact-info {
                display: flex;
                gap: 1rem;
                justify-content: center;
                flex-wrap: wrap;
                font-size: 0.9rem;
                color: var(--text-muted);
            }

            .section-title {
                border-bottom: 2px solid var(--border-color);
                padding-bottom: 0.5rem;
                margin-bottom: 1.5rem;
                color: var(--primary-color);
            }

            .skills-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 1.5rem;
            }

            .skill-card {
                background-color: var(--card-bg);
                padding: 1.5rem;
                border-radius: 12px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                border: 1px solid var(--border-color);
                transition: transform 0.2s;
            }

            .skill-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            }

            .skill-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 0.5rem;
            }

            .skill-name {
                font-weight: 700;
                font-size: 1.1rem;
                color: var(--text-color);
            }

            .skill-badge {
                background-color: rgba(236, 72, 153, 0.2);
                color: var(--secondary-color);
                padding: 0.2rem 0.6rem;
                border-radius: 20px;
                font-size: 0.8rem;
                border: 1px solid var(--secondary-color);
            }
        </style>
    </head>

    <body>
        <div class="container">
            <header>
                <nav>
                    <a href="index.jsp">← Volver al Inicio</a>
                </nav>
            </header>

            <main>
                <div class="card">
                    <div id="profile-section" class="profile-summary">
                        <!-- Profile data will be loaded here -->
                        <p>Cargando perfil...</p>
                    </div>

                    <div class="experience-section" id="experience-section" style="display:none; margin-top: 2rem;">
                        <h3 class="section-title">Experiencia</h3>
                        <p id="experience-text"></p>
                    </div>
                </div>

                <div class="card" style="margin-top: 2rem;">
                    <h3 class="section-title">Mis Habilidades</h3>
                    <div id="skills-container" class="skills-grid">
                        <!-- Skills will be loaded here -->
                        <p>Cargando habilidades...</p>
                    </div>
                </div>
            </main>

            <footer style="text-align: center; margin-top: 3rem; color: #888;">
                <p>&copy; 2025 Mi Portafolio Profesional</p>
            </footer>
        </div>

        <script>
            const PERFIL_API = '${pageContext.request.contextPath}/perfil';
            const HABILIDADES_API = '${pageContext.request.contextPath}/habilidades';

            document.addEventListener('DOMContentLoaded', () => {
                loadPerfil();
                loadHabilidades();
            });

            async function loadPerfil() {
                try {
                    const response = await fetch(PERFIL_API);
                    if (response.ok) {
                        const perfil = await response.json();
                        renderPerfil(perfil);
                    }
                } catch (error) {
                    console.error('Error loading profile:', error);
                    document.getElementById('profile-section').innerHTML = '<p>Error cargando el perfil.</p>';
                }
            }

            function renderPerfil(perfil) {
                const container = document.getElementById('profile-section');
                const photoUrl = perfil.foto ? 'data:image/jpeg;base64,' + perfil.foto : 'https://via.placeholder.com/150';

                let html = '<img src="' + photoUrl + '" alt="Foto de Perfil" class="profile-photo-large">';
                html += '<div class="profile-details">';
                html += '<h2>' + (perfil.nombre || 'Nombre no definido') + '</h2>';
                html += '<p class="bio">' + (perfil.bio || '') + '</p>';

                html += '<div class="contact-info">';
                if (perfil.email) html += '<span>📧 ' + perfil.email + '</span>';
                if (perfil.telefono) html += '<span>📱 ' + perfil.telefono + '</span>';
                html += '</div>';

                html += '</div>';

                container.innerHTML = html;

                if (perfil.experiencia) {
                    document.getElementById('experience-section').style.display = 'block';
                    document.getElementById('experience-text').textContent = perfil.experiencia;
                }
            }

            async function loadHabilidades() {
                try {
                    const response = await fetch(HABILIDADES_API);
                    if (response.ok) {
                        const habilidades = await response.json();
                        renderHabilidades(habilidades);
                    }
                } catch (error) {
                    console.error('Error loading skills:', error);
                    document.getElementById('skills-container').innerHTML = '<p>Error cargando habilidades.</p>';
                }
            }

            function renderHabilidades(habilidades) {
                const container = document.getElementById('skills-container');
                container.innerHTML = '';

                if (habilidades.length === 0) {
                    container.innerHTML = '<p>No hay habilidades para mostrar aún.</p>';
                    return;
                }

                habilidades.forEach(h => {
                    const stars = '★'.repeat(h.nivel) + '☆'.repeat(5 - h.nivel);

                    const card = document.createElement('div');
                    card.className = 'skill-card';

                    let cardContent = '<div class="skill-header">';
                    cardContent += '<span class="skill-name">' + h.nombre + '</span>';
                    cardContent += '<span class="skill-badge">' + h.categoria + '</span>';
                    cardContent += '</div>';
                    cardContent += '<div class="skill-level" style="color: #f39c12;">' + stars + '</div>';
                    if (h.descripcion) {
                        cardContent += '<p style="margin-top: 0.5rem; font-size: 0.9rem; color: var(--text-muted);">' + h.descripcion + '</p>';
                    }

                    card.innerHTML = cardContent;
                    container.appendChild(card);
                });
            }
        </script>
    </body>

    </html>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Redes Sociales</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f1f1f1;
            display: flex;
        }

        /* Barra superior */
        .top-header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 60px;
            background-color: #4a4a4a;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .top-header .header-title {
            font-size: 20px;
            font-weight: bold;
        }

        .top-header .user-info {
            font-size: 16px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 300px;
            text-align: right;
        }

        /* Barra lateral */
        .sidebar {
            width: 250px;
            background-color: #333;
            color: white;
            height: 100vh;
            position: fixed;
            top: 60px; /* Debajo del header */
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 20px;
        }

        .sidebar nav {
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        .sidebar nav a {
            color: white;
            text-decoration: none;
            padding: 15px;
            font-size: 16px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: background-color 0.3s;
        }

        .sidebar nav a:hover {
            background-color: #4a4a4a;
        }

        .icono-enlace {
            width: 40px;
            height: 40px;
            margin-right: 10px;
        }

        /* Contenido principal */
        .main-content {
            margin-left: 250px;
            margin-top: 60px;
            padding: 20px;
            width: calc(100% - 250px);
        }

        /* Estilo para los botones de redes sociales */
        .social-buttons {
            display: flex;
            justify-content: center;
            gap: 50px;
            margin-top: 50px;
        }

        .social-buttons a {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .social-buttons a:hover {
            transform: scale(1.2);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }

        .social-buttons img {
            width: 60px;
            height: 60px;
        }
    </style>
</head>
<body>
    <div class="top-header">
        <div class="header-title">Sistema de Gestión</div>
        <div class="user-info">
            Usuario: <%= session.getAttribute("usuarioNombre") != null ? session.getAttribute("usuarioNombre") : "Invitado" %>
        </div>
    </div>

    <!-- Barra lateral -->
    <aside class="sidebar">
        <nav>
            <h2>Gestion</h2>
            <a href="productos.jsp"> <img src="https://cdn-icons-gif.flaticon.com/11188/11188746.gif" alt="Agregar Producto" class="icono-enlace">Agregar Productos</a>
            <a href="venta.jsp"> <img src="https://cdn-icons-gif.flaticon.com/6416/6416376.gif" alt="Venta" class="icono-enlace">Realizar Venta</a>
            <br><br>
            
            <h2>Consultas</h2>
            <a href="contenido.jsp"> <img src="https://cdn-icons-gif.flaticon.com/17843/17843183.gif" alt="Agregar Producto" class="icono-enlace">Ver Registros</a>
            <a href="consultarProducto.jsp"> <img src="https://cdn-icons-gif.flaticon.com/10352/10352784.gif" alt="Agregar Producto" class="icono-enlace">Ver Producto</a>
            <a href="verVentas.jsp"> <img src="https://cdn-icons-gif.flaticon.com/12708/12708055.gif" alt="Agregar Producto" class="icono-enlace">Ver Ventas</a>
            <br><br>
            
            <h2>Acciones</h2>
            <a href="redes.jsp"> <img src="https://cdn-icons-gif.flaticon.com/6172/6172532.gif" alt="Agregar Producto" class="icono-enlace">Redes Sociales</a>
            <a href="libro.jsp"> <img src="https://cdn-icons-gif.flaticon.com/6454/6454239.gif" alt="Agregar Producto" class="icono-enlace">Libro Reclamaciones</a>
            <br><br><br>
            <a href="index.jsp"> <img src="https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/v1/attachments/delivery/asset/43ac02a557532c5bb2f7cfe1fd35332e-1601735589/02/send-101-animated-gif-icons.gif" alt="Agregar Producto" class="icono-enlace">Cerrar Sesión</a>
        </nav>
    </aside>

    <!-- Contenido principal -->
    <div class="main-content">
        <h2>Redes Sociales</h2>
        <p>Siguenos en nuestras redes sociales para mas informacion:</p>
        
        <!-- Botones de Redes Sociales -->
        <div class="social-buttons">
            <a href="https://www.youtube.com" target="_blank">
                <img src="https://cdn.pixabay.com/animation/2023/03/24/18/16/18-16-28-807_512.gif" alt="YouTube">
            </a>
            <a href="https://www.facebook.com" target="_blank">
                <img src="https://cliply.co/wp-content/uploads/2019/07/371907490_FACEBOOK_ICON_TRANSPARENT_400.gif" alt="Facebook">
            </a>
            <a href="https://wa.me/1234567890" target="_blank">
                <img src="https://cliply.co/wp-content/uploads/2021/08/372108180_WHATSAPP_ICON_400.gif" alt="WhatsApp">
            </a>
            <a href="https://twitter.com" target="_blank">
                <img src="https://cliply.co/wp-content/uploads/2019/07/371907030_TWITTER_ICON_400px.gif" alt="Twitter">
            </a>
            <a href="https://www.instagram.com" target="_blank">
                <img src="https://cdn.pixabay.com/animation/2022/10/30/18/26/18-26-48-450_512.gif" alt="Instagram">
            </a>
        </div>
    </div>
</body>
</html>

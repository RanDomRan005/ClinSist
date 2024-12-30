<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Producto</title>
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
            white-space: nowrap; /* Evita que el texto se corte */
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 300px; /* Limita el ancho del texto */
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
            margin-left: 250px; /* Espacio para la barra lateral */
            margin-top: 60px;  /* Espacio para el header */
            padding: 20px;
            width: calc(100% - 250px);
        }

        .form-container {
            max-width: 900px;
            margin: 30px auto;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            display: flex;
            flex-wrap: wrap;
        }

        .form-header {
            background: linear-gradient(135deg, #808080, #808080);
            color: white;
            padding: 20px;
            width: 100%;
            text-align: center;
        }

        form {
            padding: 30px;
            width: 100%;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        form div {
    margin-bottom: 15px; /* Agrega un espacio entre cada campo del formulario */
}

label {
    display: block; /* Asegura que las etiquetas ocupen una línea completa */
    font-weight: bold;
    color: #495057;
    margin-bottom: 5px; /* Espacio entre la etiqueta y el campo de entrada */
}

input[type="text"],
input[type="number"],
input[type="date"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    background: #f8f9fa;
    box-sizing: border-box; /* Para que el padding no afecte el tamaño total del campo */
}

input[type="text"]:focus,
input[type="number"]:focus,
input[type="date"]:focus {
    border-color: #007bff;
    outline: none;
    background: #ffffff;
}

button {
    background-color: red;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-top: 20px; /* Espacio entre el botón y el resto de los campos */
}

button:hover {
    background-color: #0056b3;
}


        .floating-button {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #ffffff;
            border: none;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .floating-button img {
            width: 30px;
            height: 30px;
        }

        .floating-button:hover {
            transform: scale(1.2);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
    <div class="top-header">
        <div class="header-title" >Sistema de Gestión</div>
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
    <div class="form-container"><br><br><br>
        <div class="form-header">
            <h2>Agregar Producto</h2>
        </div>
        <form method="POST">
            <div>
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre" required>
            </div>

            <div>
                <label for="marca">Marca:</label>
                <input type="text" id="marca" name="marca" required>
            </div>

            <div>
                <label for="descripcion">Descripción:</label>
                <input type="text" id="descripcion" name="descripcion" required>
            </div>

            <div>
                <label for="fecha">Fecha de Venta:</label>
                <input type="date" id="fecha" name="fecha" required>
            </div>

            <div>
                <label for="cantidad">Cantidad:</label>
                <input type="number" id="cantidad" name="cantidad" required>
            </div>

            <div>
                <label for="precio">Precio de Compra:</label>
                <input type="number" id="precio" name="precio" required step="0.01">
            </div>

            <div class="form-footer">
                <button type="submit">Agregar Producto</button>
            </div>
        </form>
    </div>

    <%-- Código JSP para manejar el formulario (sin cambios) --%>
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String nombre = request.getParameter("nombre");
            String marca = request.getParameter("marca");
            String descripcion = request.getParameter("descripcion");
            String fecha = request.getParameter("fecha");
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            double precio = Double.parseDouble(request.getParameter("precio"));

            String jdbcUrl = "jdbc:mysql://localhost:3306/based";
            String dbUser = "root";
            String dbPassword = "";

            try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
                String sql = "INSERT INTO productos (Nombre, Marca, Descripcion, Fecha_Venta, Cantidad, Precio_compra) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, nombre);
                pstmt.setString(2, marca);
                pstmt.setString(3, descripcion);
                pstmt.setString(4, fecha);
                pstmt.setInt(5, cantidad);
                pstmt.setDouble(6, precio);

                int filasAfectadas = pstmt.executeUpdate();
                if (filasAfectadas > 0) {
                    response.sendRedirect("contenido.jsp");
                }
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error al agregar producto: " + e.getMessage() + "</p>");
            }
        }
    %>

    <a href="entrada.jsp" class="floating-button">
        <img src="https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/v1/attachments/delivery/asset/43ac02a557532c5bb2f7cfe1fd35332e-1601735589/02/send-101-animated-gif-icons.gif" alt="Botón">
    </a>
</body>
</html>

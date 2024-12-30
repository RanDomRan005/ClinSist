<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultar Productos</title>
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

        h1 {
            text-align: center;
            color: #333;
        }

        .form-container {
            width: 90%;
            max-width: 900px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table th, table td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        table th {
            background-color: #4a4a4a;
            color: white;
        }

        table input[type="number"] {
            width: 60px;
            text-align: center;
        }
        .user-info {
            font-size: 14px;
            color: #555;
        }
        .content {
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: red;
        }
        form {
            margin: 20px auto;
            max-width: 400px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: #495057;
        }
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
        button {
            background-color: #ff0000;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #808080;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e9ecef;
        }
        .floating-button {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #FFFFFF;
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
    
    <div class="form-container">
        <br><br>
    <h1>Consultar Productos</h1>
    <form method="GET">
        <label for="campo">Selecciona los campos que deseas mostrar:</label>
        <select id="campo" name="campo" required>
            <option value="Nombre, Marca, Fecha_Venta, Precio_compra">Nombre, Marca, Fecha y Precio</option>
            <option value="Nombre, Marca">Nombre y Marca</option>
            <option value="Nombre, Precio_compra">Nombre y Precio</option>
            <option value="Nombre, Fecha_Venta">Nombre y Fecha</option>
        </select>
        <button type="submit">Consultar</button>
    </form>

    <%
        String camposSeleccionados = request.getParameter("campo");

        if (camposSeleccionados != null) {
            String jdbcUrl = "jdbc:mysql://localhost:3306/based";
            String dbUser = "root";
            String dbPassword = "";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                stmt = conn.createStatement();
                String sql = "SELECT " + camposSeleccionados + " FROM productos";
                rs = stmt.executeQuery(sql);

                // Mostrar los resultados en una tabla
                %>
                <table>
                    <tr>
                        <%
                        for (String campo : camposSeleccionados.split(", ")) {
                            out.print("<th>" + campo + "</th>");
                        }
                        %>
                    </tr>
                    <%
                    while (rs.next()) {
                        out.print("<tr>");
                        for (String campo : camposSeleccionados.split(", ")) {
                            out.print("<td>" + rs.getString(campo) + "</td>");
                        }
                        out.print("</tr>");
                    }
                    %>
                </table>
                <%
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        }
    %>
    
     <a href="entrada.jsp" class="floating-button">
            <img src="https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/v1/attachments/delivery/asset/43ac02a557532c5bb2f7cfe1fd35332e-1601735589/02/send-101-animated-gif-icons.gif" alt="Botón">
        </a>
    </div>
</body>
</html>

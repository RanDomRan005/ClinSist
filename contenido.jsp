<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Productos</title>
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
        .action-buttons button {
            padding: 5px 10px;
            margin: 0 5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-edit {
            background-color: #007bff;
            color: white;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
    </style>
<script>
        // Función para eliminar producto mediante AJAX
        function eliminarProducto(id) {
            if (confirm('¿Seguro que deseas eliminar este producto?')) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "eliminarProducto.jsp?id=" + id, true);
                xhr.onload = function() {
                    if (xhr.status === 200) {
                        // Muestra el mensaje de eliminación en la misma página
                        document.getElementById('mensaje').innerHTML = xhr.responseText;
                        // Opcionalmente, eliminar la fila de la tabla
                        var row = document.getElementById('producto-' + id);
                        row.parentNode.removeChild(row);
                    } else {
                        alert("Hubo un error al intentar eliminar el producto.");
                    }
                };
                xhr.send();
            }
        }
    </script>
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
    <h1>Lista de Productos</h1>

    <!-- Mensaje de confirmación -->
    <div id="mensaje"></div>

    <table>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Marca</th>
            <th>Descripción</th>
            <th>Fecha de Venta</th>
            <th>Cantidad</th>
            <th>Precio de Compra</th>
            <th>Total a Pagar</th>
            <th>Acciones</th>
        </tr>
        <%
            // Conexión a la base de datos
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
                String sql = "SELECT Id, Nombre, Marca, Descripcion, Fecha_Venta, Cantidad, Precio_compra, TotalPagar FROM productos";
                rs = stmt.executeQuery(sql);

                // Procesar y mostrar los resultados
                while (rs.next()) {
                    int id = rs.getInt("Id");
                    String nombre = rs.getString("Nombre");
                    String marca = rs.getString("Marca");
                    String descripcion = rs.getString("Descripcion");
                    Date fechaVenta = rs.getDate("Fecha_Venta");
                    int cantidad = rs.getInt("Cantidad");
                    double precioCompra = rs.getDouble("Precio_compra");
                    double totalPagar = rs.getDouble("TotalPagar");

                    %>
                    <tr id="producto-<%= id %>">
                        <td><%= id %></td>
                        <td><%= nombre %></td>
                        <td><%= marca %></td>
                        <td><%= descripcion %></td>
                        <td><%= fechaVenta %></td>
                        <td><%= cantidad %></td>
                        <td>S/ <%= precioCompra %></td>
                        <td>S/ <%= totalPagar %></td>
                        <td class="action-buttons">
                            <button class="btn-edit" onclick="location.href='editarProducto.jsp?id=<%= id %>'">Editar</button>
                            <button class="btn-delete" onclick="eliminarProducto(<%= id %>)">Eliminar</button>
                        </td>
                    </tr>
                    <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='9'>Error al conectar con la base de datos: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </table>
    </div>
</body>
</html>

<%@ page import="java.sql.*" %>
<%
    // Variables de conexi�n
    String jdbcUrl = "jdbc:mysql://localhost:3306/based";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement stmtVentas = null;
    PreparedStatement stmtDetalle = null;
    ResultSet rsVentas = null;
    ResultSet rsDetalle = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // Consultar todas las ventas
        String sqlVentas = "SELECT id, cliente_nombre, total, fecha FROM ventas ORDER BY fecha DESC";
        stmtVentas = conn.prepareStatement(sqlVentas);
        rsVentas = stmtVentas.executeQuery();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ventas Realizadas</title>
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

        button {
            padding: 12px 25px;
            background-color: #4a4a4a;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #333;
        }

        #total {
            font-weight: bold;
            color: #28a745;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="top-header">
        <div class="header-title" >Sistema de Gesti�n</div>
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
            <a href="index.jsp"> <img src="https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/v1/attachments/delivery/asset/43ac02a557532c5bb2f7cfe1fd35332e-1601735589/02/send-101-animated-gif-icons.gif" alt="Agregar Producto" class="icono-enlace">Cerrar Sesi�n</a>
        </nav>
    </aside>
    
    <div class="form-container">
        <br>
        <br>
        <h1 style="text-align: center;">Ventas Realizadas</h1>
        <table>
            <tr>
                <th>Fecha</th>
                <th>Cliente</th>
                <th>Total</th>
                <th>Productos Vendidos</th>
            </tr>
            <%
                try {
                    while (rsVentas != null && rsVentas.next()) {
                        int ventaId = rsVentas.getInt("id");
                        String clienteNombre = rsVentas.getString("cliente_nombre");
                        double total = rsVentas.getDouble("total");
                        Date fecha = rsVentas.getDate("fecha");

                        // Consultar los productos de esta venta
                        String sqlDetalle = "SELECT p.Nombre, dv.cantidad, dv.subtotal " +
                                            "FROM detalle_venta dv " +
                                            "JOIN productos p ON dv.producto_id = p.Id " +
                                            "WHERE dv.venta_id = ?";
                        stmtDetalle = conn.prepareStatement(sqlDetalle);
                        stmtDetalle.setInt(1, ventaId);
                        rsDetalle = stmtDetalle.executeQuery();
            %>
            <tr>
                <td><%= fecha %></td>
                <td><%= clienteNombre %></td>
                <td>$<%= String.format("%.2f", total) %></td>
                <td>
                    <ul class="venta-detalle">
                        <%
                            while (rsDetalle != null && rsDetalle.next()) {
                                String productoNombre = rsDetalle.getString("Nombre");
                                int cantidad = rsDetalle.getInt("cantidad");
                                double subtotal = rsDetalle.getDouble("subtotal");
                        %>
                        <li>
                            <strong><%= productoNombre %></strong> - 
                            Cantidad: <%= cantidad %>, 
                            Subtotal: $<%= String.format("%.2f", subtotal) %>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='4'>Error al cargar las ventas: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rsDetalle != null) try { rsDetalle.close(); } catch (SQLException ignore) {}
                    if (stmtDetalle != null) try { stmtDetalle.close(); } catch (SQLException ignore) {}
                }
            %>
        </table>
    </div>
</body>
</html>
<%
    if (rsVentas != null) try { rsVentas.close(); } catch (SQLException ignore) {}
    if (stmtVentas != null) try { stmtVentas.close(); } catch (SQLException ignore) {}
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
%>

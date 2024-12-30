<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Producto Agregado</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f1f1f1;
            color: #333;
            padding: 10px 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .header-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }
        .header-nav {
            display: flex;
            gap: 20px;
        }
        .header-nav a {
            color: #555;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease;
        }
        .header-nav a:hover {
            color: #007bff;
        }
        .user-info {
            font-size: 14px;
            color: #555;
        }
        .content {
            padding: 20px;
        }
        h1, .message {
            text-align: center;
        }
        h1 {
            color: #007bff;
        }
        .success {
            color: #28a745;
        }
        .error {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <h1>Resultado</h1>
    <div class="message">
        <%
            String nombre = request.getParameter("nombre");
            String marca = request.getParameter("marca");
            String descripcion = request.getParameter("descripcion");
            String fechaVenta = request.getParameter("fechaVenta");
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            double precioCompra = Double.parseDouble(request.getParameter("precioCompra"));
            double totalPagar = cantidad * precioCompra;

            String jdbcUrl = "jdbc:mysql://localhost:3306/based";
            String dbUser = "root";
            String dbPassword = "";

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                String sql = "INSERT INTO productos (Nombre, Marca, Descripcion, Fecha_Venta, Cantidad, Precio_compra) VALUES (?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, nombre);
                pstmt.setString(2, marca);
                pstmt.setString(3, descripcion);
                pstmt.setString(4, fechaVenta);
                pstmt.setInt(5, cantidad);
                pstmt.setDouble(6, precioCompra);

                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("contenido.jsp");
                } else {
                    %>
                    <p class="error">Error al agregar el producto.</p>
                    <%
                }
            } catch (Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </div>
</body>
</html>

<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    // Variables para almacenar los datos del producto
    String nombre = "";
    String marca = "";
    String descripcion = "";
    Date fechaVenta = null;
    int cantidad = 0;
    double precioCompra = 0.0;
    double totalPagar = 0.0;

    // Conexión a la base de datos
    String jdbcUrl = "jdbc:mysql://localhost:3306/based";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        
        // Consultar los detalles del producto
        String sql = "SELECT Nombre, Marca, Descripcion, Fecha_Venta, Cantidad, Precio_compra, TotalPagar FROM productos WHERE Id=?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(id));
        rs = stmt.executeQuery();

        if (rs.next()) {
            nombre = rs.getString("Nombre");
            marca = rs.getString("Marca");
            descripcion = rs.getString("Descripcion");
            fechaVenta = rs.getDate("Fecha_Venta");
            cantidad = rs.getInt("Cantidad");
            precioCompra = rs.getDouble("Precio_compra");
            totalPagar = rs.getDouble("TotalPagar");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Producto</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
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
        
        h1 {
            text-align: center;
            margin-top: 30px;
            color: #333;
        }
        
        .form-container {
            width: 80%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .form-container input, .form-container select, .form-container textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        .form-container button {
            padding: 12px 25px;
            background-color: #28a745; /* Verde */
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-container button:hover {
            background-color: #218838; /* Verde oscuro */
        }
    </style>
</head>
<header>
    <div class="header-title">Sistema de Gestión</div>
    <nav class="header-nav">
        <a href="productos.jsp">Agregar Productos</a>
        <a href="contenido.jsp">Ver Registros</a>
        <a href="consultarProducto.jsp">Consultar Producto</a>
        <a href="index.jsp">Cerrar Sesión</a>
    </nav>
</header>
<body>
    <h1>Editar Producto</h1>
    <div class="form-container">
        <form action="actualizarProducto.jsp" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" value="<%= nombre %>" required>

            <label for="marca">Marca:</label>
            <input type="text" id="marca" name="marca" value="<%= marca %>" required>

            <label for="descripcion">Descripción:</label>
            <textarea id="descripcion" name="descripcion" rows="4" required><%= descripcion %></textarea>

            <label for="fechaVenta">Fecha de Venta:</label>
            <input type="date" id="fechaVenta" name="fechaVenta" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(fechaVenta) %>" required>

            <label for="cantidad">Cantidad:</label>
            <input type="number" id="cantidad" name="cantidad" value="<%= cantidad %>" required>

            <label for="precioCompra">Precio de Compra:</label>
            <input type="number" id="precioCompra" name="precioCompra" value="<%= precioCompra %>" step="0.01" required>

            <label for="totalPagar">Total a Pagar:</label>
            <input type="number" id="totalPagar" name="totalPagar" value="<%= totalPagar %>" step="0.01" required>

            <button type="submit">Actualizar Producto</button>
            <button type="submit" href="contenido.jsp">Cancelar</button>
        </form>
    </div>
</body>
</html>
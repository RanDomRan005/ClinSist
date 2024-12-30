<%@ page import="java.sql.*" %>
<%
    String cliente = request.getParameter("cliente");
    String[] productos = request.getParameterValues("productoId");

    if (productos == null || productos.length == 0) {
        out.println("<h3>No se seleccionaron productos.</h3>");
        return;
    }

    String jdbcUrl = "jdbc:mysql://localhost:3306/based";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement stmtVenta = null;
    PreparedStatement stmtDetalle = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        conn.setAutoCommit(false);

        // Insertar la venta
        String sqlVenta = "INSERT INTO ventas (cliente_nombre, total) VALUES (?, ?)";
        stmtVenta = conn.prepareStatement(sqlVenta, Statement.RETURN_GENERATED_KEYS);
        stmtVenta.setString(1, cliente);
        stmtVenta.setDouble(2, 0); // Total inicial
        stmtVenta.executeUpdate();
        ResultSet rsVenta = stmtVenta.getGeneratedKeys();
        rsVenta.next();
        int ventaId = rsVenta.getInt(1);

        double totalVenta = 0;

        // Registrar detalles y actualizar productos
        for (String productoId : productos) {
            int idProducto = Integer.parseInt(productoId);
            int cantidad = Integer.parseInt(request.getParameter("cantidad_" + productoId));

            String sqlProducto = "SELECT Precio_compra, Cantidad FROM productos WHERE Id=?";
            PreparedStatement stmtProducto = conn.prepareStatement(sqlProducto);
            stmtProducto.setInt(1, idProducto);
            ResultSet rsProducto = stmtProducto.executeQuery();
            rsProducto.next();

            double precio = rsProducto.getDouble("Precio_compra");
            int cantidadDisponible = rsProducto.getInt("Cantidad");

            if (cantidad > cantidadDisponible) {
                throw new Exception("No hay suficiente stock para el producto con ID: " + idProducto);
            }

            double subtotal = precio * cantidad;
            totalVenta += subtotal;

            String sqlDetalle = "INSERT INTO detalle_venta (venta_id, producto_id, cantidad, subtotal) VALUES (?, ?, ?, ?)";
            stmtDetalle = conn.prepareStatement(sqlDetalle);
            stmtDetalle.setInt(1, ventaId);
            stmtDetalle.setInt(2, idProducto);
            stmtDetalle.setInt(3, cantidad);
            stmtDetalle.setDouble(4, subtotal);
            stmtDetalle.executeUpdate();

            // Actualizar stock
            String sqlActualizar = "UPDATE productos SET Cantidad=Cantidad-? WHERE Id=?";
            PreparedStatement stmtActualizar = conn.prepareStatement(sqlActualizar);
            stmtActualizar.setInt(1, cantidad);
            stmtActualizar.setInt(2, idProducto);
            stmtActualizar.executeUpdate();
        }

        // Actualizar el total de la venta
        String sqlActualizarVenta = "UPDATE ventas SET total=? WHERE id=?";
        PreparedStatement stmtActualizarVenta = conn.prepareStatement(sqlActualizarVenta);
        stmtActualizarVenta.setDouble(1, totalVenta);
        stmtActualizarVenta.setInt(2, ventaId);
        stmtActualizarVenta.executeUpdate();

        conn.commit();
        out.println("<h3>Venta registrada exitosamente.</h3>");
    } catch (Exception e) {
        if (conn != null) conn.rollback();
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        if (stmtDetalle != null) try { stmtDetalle.close(); } catch (SQLException ignore) {}
        if (stmtVenta != null) try { stmtVenta.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

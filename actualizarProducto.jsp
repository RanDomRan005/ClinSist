<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String nombre = request.getParameter("nombre");
    String marca = request.getParameter("marca");
    String descripcion = request.getParameter("descripcion");
    String fechaVenta = request.getParameter("fechaVenta");
    int cantidad = Integer.parseInt(request.getParameter("cantidad"));
    double precioCompra = Double.parseDouble(request.getParameter("precioCompra"));
    double totalPagar = Double.parseDouble(request.getParameter("totalPagar"));

    Connection conn = null;
    PreparedStatement stmt = null;

    String jdbcUrl = "jdbc:mysql://localhost:3306/based";
    String dbUser = "root";
    String dbPassword = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        String sql = "UPDATE productos SET Nombre=?, Marca=?, Descripcion=?, Fecha_Venta=?, Cantidad=?, Precio_compra=?, TotalPagar=? WHERE Id=?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, nombre);
        stmt.setString(2, marca);
        stmt.setString(3, descripcion);
        stmt.setDate(4, java.sql.Date.valueOf(fechaVenta));
        stmt.setInt(5, cantidad);
        stmt.setDouble(6, precioCompra);
        stmt.setDouble(7, totalPagar);
        stmt.setInt(8, Integer.parseInt(id));

        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated > 0) {
            response.sendRedirect("contenido.jsp"); // Redirige a la lista de productos después de actualizar
        } else {
            out.println("Error al actualizar el producto");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
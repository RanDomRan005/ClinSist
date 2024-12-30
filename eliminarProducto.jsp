<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Producto</title>
</head>
<body>
    <%
        // Obtener el id del producto a eliminar
        int id = Integer.parseInt(request.getParameter("id"));
        String jdbcUrl = "jdbc:mysql://localhost:3306/based";
        String dbUser = "root";
        String dbPassword = "";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Eliminar el producto de la base de datos
            String sql = "DELETE FROM productos WHERE Id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            int result = stmt.executeUpdate();
            if (result > 0) {
                out.println("<h3>Producto eliminado correctamente</h3>");
            } else {
                out.println("<h3>No se pudo eliminar el producto</h3>");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>

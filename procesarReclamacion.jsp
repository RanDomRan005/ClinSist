<%@ page import="java.sql.*" %>
<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/based";
    String dbUser = "root";
    String dbPassword = "";

    String nombre = request.getParameter("nombre"); // Ahora estamos recibiendo "nombre"
    String descripcion = request.getParameter("descripcion");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Establecer conexión con la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // Consulta SQL para insertar la reclamación
        String sql = "INSERT INTO reclamaciones (Nombre, Descripcion) VALUES (?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, nombre);
        stmt.setString(2, descripcion);

        // Ejecutar la inserción
        int filasInsertadas = stmt.executeUpdate();

        if (filasInsertadas > 0) {
        out.println("<h2>Reclamación registrada con éxito.</h2>");
        response.sendRedirect("libro.jsp");
            
        } else {
            out.println("<h2>Error al registrar la reclamación. Intenta nuevamente.</h2>");
        }
    } catch (Exception e) {
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        // Cerrar los recursos de la base de datos
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<h2>Error al cerrar la conexión: " + e.getMessage() + "</h2>");
        }
    }
%>

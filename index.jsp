<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #2e2e2e, #1a1a1a);
            color: #ffffff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #333333;
            color: #f0f0f0;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.4);
            width: 100%;
            max-width: 450px;
        }
        .login-header {
            background-color: #444444;
            color: #f9c802;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
            border-radius: 10px 10px 0 0;
        }
        .login-header img {
            height: 40px;
            margin-right: 15px;
        }
        .login-header h1 {
            font-size: 24px;
            margin: 0;
        }
        .form-group {
            margin-top: 20px;
        }
        .form-group label {
            font-size: 14px;
            margin-bottom: 5px;
            display: block;
            color: #f0f0f0;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #555555;
            border-radius: 6px;
            font-size: 16px;
            background-color: #222222;
            color: #f0f0f0;
        }
        .btn {
            background-color: #f9c802;
            color: #333333;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #e0af02;
        }
        .footer {
            margin-top: 20px;
            text-align: center;
            font-size: 12px;
            color: #868e96;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <img src="https://img.icons8.com/external-outline-juicy-fish/64/f9c802/external-building-business-outline-outline-juicy-fish.png" alt="Logo Empresa">
            <h1>Nombre Empresarial</h1>
        </div>
        <form method="POST">
            <div class="form-group">
                <label for="usuario">Usuario</label>
                <input type="text" id="usuario" name="usuario" required placeholder="Ingrese su usuario">
            </div>
            <div class="form-group">
                <label for="clave">Clave</label>
                <input type="password" id="clave" name="clave" required placeholder="Ingrese su clave">
            </div>
            <button type="submit" class="btn">Iniciar Sesión</button>
        </form>
        <div class="footer">
            © 2024 Nombre Empresarial. Todos los derechos reservados.
        </div>
    </div>
    <script>
        // Mostrar alerta de error si las credenciales son incorrectas
        <% if ("POST".equalsIgnoreCase(request.getMethod())) {
            String usuario = request.getParameter("usuario");
            String clave = request.getParameter("clave");

            String jdbcUrl = "jdbc:mysql://localhost:3306/based";
            String dbUser = "root";
            String dbPassword = "";

            boolean esValido = false;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                String sql = "SELECT * FROM usuarios WHERE usuario = ? AND clave = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, usuario);
                stmt.setString(2, clave);

                ResultSet rs = stmt.executeQuery();
                esValido = rs.next(); // Si hay resultado, las credenciales son válidas

                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                esValido = false;
            }

            if (!esValido) { %>
                alert('Usuario o clave incorrectos. Por favor, intente de nuevo.');
            <% } else { %>
                window.location.href = 'entrada.jsp';
            <% } 
        } %>
    </script>
</body>
</html>

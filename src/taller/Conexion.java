
package taller;

import java.sql.Connection;
import java.sql.DriverManager;


public class Conexion {
    
    static String user = "postgres";
    static String password ="1";
    Connection connection ;
    public Conexion(){
    this.connection=null;
    }
    public void Conexion1(){
        String url = "";
        try {
            // We register the PostgreSQL driver
            // Registramos el driver de PostgresSQL
            try {
                Class.forName("org.postgresql.Driver");
            } catch (ClassNotFoundException ex) {
                System.out.println("Error al registrar el driver de PostgreSQL: " + ex);
            }

            url = "jdbc:postgresql://localhost:5432/TestPOO";
            // Database connect
            // Conectamos con la base de datos
            this.connection = DriverManager.getConnection(url,user, password);           
            
            boolean valid = connection.isValid(50000);
            
            //System.out.println(valid ? "TEST OK" : "TEST FAIL");
            
        } catch (java.sql.SQLException sqle) { 
            System.out.println("Error al conectar con la base de datos de PostgreSQL (" + url + "): " + sqle);
        }
       
    }
    public Connection getConnection(){
        return connection;
    }

    public void desconectar(){
        try{
            //System.out.println("Cerrando conexion");
            connection.close();
        }catch(Exception ex){}
    }    
}

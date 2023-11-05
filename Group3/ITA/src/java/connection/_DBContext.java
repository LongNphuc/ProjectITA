package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.Helper;

public class _DBContext {

    protected Connection connection;


    private final Properties properties = Helper.getPropertiesByFileName("utils/const.properties");
    private String hostname, port, dbName, username, password;

    public _DBContext() {


        hostname = properties.getProperty("database.hostname");
        port = properties.getProperty("database.port");
        dbName = properties.getProperty("database.name");
        username = properties.getProperty("database.username");
        password = properties.getProperty("database.password");

        try {
            String url = "jdbc:mysql://"+hostname+":"+port+"/"+dbName;
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(_DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Connection getConnection() {
        return connection;
    }
    
    public static void main(String[] args) {
        System.out.println(new _DBContext().getConnection());
    }

}

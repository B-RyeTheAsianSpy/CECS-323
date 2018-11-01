package cecs.pkg323.java.project;

import java.sql.*;
import java.util.InputMismatchException;
import java.util.Scanner;

/**
 *
 * @author Brian Nguyen, Randy Thiem
 * @since 10/23/18
 *
 */
public class CECS323JavaProject {

    /**
     * @param args the command line arguments
     */
    //  Database credentials
    static String USER;
    static String PASS;
    static String DBNAME;
    //This is the specification for the printout that I'm doing:
    //each % denotes the start of a new field.
    //The - denotes left justification.
    //The number indicates how wide to make the field.
 
// JDBC driver name and database URL
    static final String JDBC_DRIVER = "org.apache.derby.jdbc.ClientDriver";
    static String DB_URL = "jdbc:derby://localhost:1527/";
//            + "testdb;user=";

    /**
     * Takes the input string and outputs "N/A" if the string is empty or null.
     *
     * @param input The string to be mapped.
     * @return Either the input string or "N/A" as appropriate.
     */
    public static String dispNull(String input) {
        //because of short circuiting, if it's null, it never checks the length.
        if (input == null || input.length() == 0) {
            return "N/A";
        } else {
            return input;
        }
    }

    /**
     * Displays user interface
     */
    public static void menu() {
        System.out.println("-------------------------------------------\n"
                + "1.\tDisplay writing groups\n"
                + "2.\tDisplay all data for a group\n"
                + "3.\tList all publishers\n"
                + "4.\tList all data for a publisher\n"
                + "5.\tList all book titles\n"
                + "6.\tList all data for a book\n"
                + "7.\tInsert new book\n"
                + "8.\tInsert a new publisher and update all books published by \n"
                + "\t\tone publisher to be published by the new publisher\n"
                + "9.\tRemove book\n"
                + "10.\tExit program\n"
                + "-------------------------------------------");

        System.out.print("Enter a menu option: ");
    }

    /**
     * Method for inserting a new book
     *
     * @throws SQLException
     */
    public static void displayWritingGroups() throws SQLException {
       
    }

    /**
     * displays all publishers in the database
     *
     * @throws SQLException
     */
    public static void displayPublishers() throws SQLException {
        

    }

    /**
     * inserts a book into the database
     *
     * @throws SQLException
     */
    public static void insertBook() throws SQLException {
        
    }

    /**
     * Deletes a book from the database. The user specifies the book title and
     * the group name
     *
     * @throws SQLException
     */
    public static void deleteBook() {
      

    }

    /**
     * displays data related to books
     *
     * @throws SQLException
     */
    public static void displayGroupData() throws SQLException {
       

    }

    /**
     * displays data related to specified publisher
     * 
     * @throws SQLException 
     */
    public static void displayPublisherData() throws SQLException {
    }

    /**
     * displays data related to specified book
     * 
     * @throws SQLException 
     */
    public static void displayBookData() throws SQLException {

        

    }

    /**
     * Allows user to enter a new publisher and use that to replace older ones
     * specified
     *
     * @throws SQLException
     */
    public static void updatePublisher() throws SQLException {

    }

    /**
     * displays book titles
     */
    public static void displayBookTitles() {
       
       
    }

    /**
     * method used to allow the user to press any key to continue
     */
    public static void pressAnyKeyToContinue() {
      
    }

    public static void main(String[] args) {
        //Prompt the user for the database name, and the credentials.   
        Scanner in = new Scanner(System.in);
        System.out.print("Name of the database (not the user account): ");
        DBNAME = in.nextLine();

        System.out.print("Database user name: ");
        USER = in.nextLine();

        System.out.print("Database password: ");
        PASS = in.nextLine();

        //Constructing the database URL connection string
        DB_URL = DB_URL + DBNAME + ";user=" + USER + ";password=" + PASS;
        Connection conn = null; //initialize the connection
        Statement stmt = null;  //initialize the statement that we're using

        try {
            // register JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // open a connection
            System.out.println("Connecting to database...");
            conn = DriverManager.getConnection(DB_URL);

            //STEP 4: Execute a query
            System.out.println("Creating statement...");
            System.out.println();
            stmt = conn.createStatement();

            try {

                Scanner sc = new Scanner(System.in);
                menu();
                String choice = sc.nextLine();
                loop:
                while (true) {
                    switch (choice) {

                        case "1":
                            displayWritingGroups();
                            break;
                        case "2":
                            displayGroupData();
                            break;

                        case "3":
                            displayPublishers();
                            break;

                        case "4":
                            displayPublisherData();
                            break;

                        case "5":
                            displayBookTitles();

                            break;

                        case "6":
                            displayBookData();
                            break;

                        case "7":
                            insertBook();
                            break;

                        case "8":
                            updatePublisher();
                            break;

                        case "9":
                            deleteBook();
                            break;

                        case "10":
                            break loop;

                        default:
                            System.out.println("\n**INVALID SELECTION**");
                            pressAnyKeyToContinue();
                            break;
                    }
                    menu();
                    choice = sc.nextLine();
                }
                //Clean-up environment
                stmt.close();
                conn.close();
            } catch (InputMismatchException se) {
                System.out.println("You've entered a string.");
            }

        } catch (SQLNonTransientConnectionException se) {
            System.out.println("CONNECTION REFUSED. One or more credentials was invalid");
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            //finally block used to close resources
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException se2) {
            }// nothing we can do
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
        System.out.println("Goodbye!");
    }//end main
}// end CECS323JavaProject

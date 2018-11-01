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
        Connection conn = DriverManager.getConnection(DB_URL);
        Statement stmt = conn.createStatement();
        String sql = "SELECT GroupName FROM WritingGroup";
        ResultSet rs = stmt.executeQuery(sql);

        System.out.println("\nWriting groups\n---------------------");
        while (rs.next()) {
            String groupName = rs.getString("GroupName");
            System.out.println(groupName);
        }
        rs.close();
        System.out.println();
        pressAnyKeyToContinue();
    }

    /**
     * displays all publishers in the database
     *
     * @throws SQLException
     */
    public static void displayPublishers() throws SQLException {
        Connection conn = DriverManager.getConnection(DB_URL);
        Statement stmt = conn.createStatement();
        String sql = "SELECT PublisherName FROM Publishers";
        ResultSet rs = stmt.executeQuery(sql);

        System.out.println("\nPublishers\n---------------------");
        while (rs.next()) {
            String publisherName = rs.getString("PublisherName");
            System.out.println(publisherName);
        }
        System.out.println();
        rs.close();
        pressAnyKeyToContinue();

    }

    /**
     * inserts a book into the database
     *
     * @throws SQLException
     */
    public static void insertBook() throws SQLException {
        try {
            Scanner in = new Scanner(System.in);
            Connection conn = DriverManager.getConnection(DB_URL);

            String s = "INSERT INTO Books(GroupName, BookTitle, PublisherName, YearPublished, NumberOfPages) VALUES(?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(s);

            // Group name
            System.out.print("Enter group name: ");
            String a = in.nextLine();

            // Book title
            System.out.print("Enter book title: ");
            String b = in.nextLine();

            // Publisher name
            System.out.print("Enter publisher name: ");
            String c = in.nextLine();

            // Year published
            System.out.print("Enter year published: ");
            int d = in.nextInt();

            // Number of pages
            System.out.print("Enter number of pages: ");
            int e = in.nextInt();

            ps.setString(1, a);                  // Group Name
            ps.setString(2, b);                  // Book title
            ps.setString(3, c);                // Publisher Name
            ps.setInt(4, d);                      // Year Published
            ps.setInt(5, e);                     // Number of pages

            ps.executeUpdate();
            System.out.println("Book added! ^_^");
            ps.close();
            pressAnyKeyToContinue();

            // if the user enters invalid data in any of the prompts
        } catch (SQLIntegrityConstraintViolationException e) {
            System.out.print("\n**YOU HAVE ENTERED ONE OR MORE INVALID DATA**\n");
            pressAnyKeyToContinue();
        } catch (SQLDataException s) {
            System.out.print("\n**YOU HAVE ENTERED DATA THAT IS TOO LARGE FOR THE DATABASE**\n");
            pressAnyKeyToContinue();
        } catch (InputMismatchException se) {
            System.out.println("**YOU HAVE ENTERED MISMATCHED INFORMATION**\n");
            pressAnyKeyToContinue();
        }
    }

    /**
     * Deletes a book from the database. The user specifies the book title and
     * the group name
     *
     * @throws SQLException
     */
    public static void deleteBook() {
        try {
            Connection conn = null;
            conn = DriverManager.getConnection(DB_URL);

            Scanner in = new Scanner(System.in);
            System.out.print("What book would you like to remove? ");
            String bookremove = in.nextLine();

            String s = "DELETE FROM Books WHERE BookTitle = ? AND GroupName = ?";
            String check = "SELECT * FROM Books WHERE BookTitle = ?";
            PreparedStatement p = conn.prepareStatement(s);
            PreparedStatement p2 = conn.prepareStatement(check);

            p2.setString(1, bookremove);
            ResultSet rs = p2.executeQuery();
            int count = 0;
            while (rs.next()) {
                count++;
            }

            // if there are no books from the result set / if book doesn't exist
            if (count == 0) {
                System.out.println("**BOOK ENTERED DOES NOT EXIST**\n");
                p.close();
                p2.close();
                pressAnyKeyToContinue();
            } else {

                check = "SELECT * FROM Books WHERE GroupName = ?";
                System.out.print("Please specify group name: ");
                String b = in.nextLine();
                p2 = conn.prepareStatement(check);
                p2.setString(1, b);
                rs = p2.executeQuery();
                count = 0;
                while (rs.next()) {
                    count++;

                }
                if (count == 0) {
                    System.out.println("**GROUPNAME ENTERED DOES NOT EXIST**\n");
                    p.close();
                    p2.close();
                    pressAnyKeyToContinue();
                } else {
                    p.setString(1, bookremove);
                    p.setString(2, b);
                    p.executeUpdate();

                    System.out.println("\nBook removed!!\n");
                    s = "SELECT BookTitle FROM Books";
                    Statement stmt = conn.createStatement();
                    rs = stmt.executeQuery(s);

                    System.out.println("Books\n-----------------");
                    while (rs.next()) {
                        String bTitle = rs.getString("BookTitle");
                        System.out.println(bTitle);
                    }
                    System.out.println();
                    rs.close();
                    p.close();
                    p2.close();
                    pressAnyKeyToContinue();
                }

            }

        } catch (SQLException se) {
            System.out.println("\n**YOU HAVE ENTERED INVALID DATA**");
            pressAnyKeyToContinue();
        }

    }

    /**
     * displays data related to books
     *
     * @throws SQLException
     */
    public static void displayGroupData() throws SQLException {
        Scanner in = new Scanner(System.in);
        Connection conn = DriverManager.getConnection(DB_URL);
        String s = "SELECT * from WritingGroup NATURAL JOIN Publishers NATURAL JOIN Books where GroupName = ?";

        System.out.print("Enter the group name: ");
        String writingGroup = in.nextLine();

        PreparedStatement ps = conn.prepareStatement(s);
        ps.setString(1, writingGroup);
        ResultSet rs = ps.executeQuery();

        System.out.println();
        while (rs.next()) {
            String groupName = rs.getString("GroupName");
            String headWriter = rs.getString("HeadWriter");
            String yearFormed = rs.getString("YearFormed");
            String subject = rs.getString("Subject");
            String bookTitle = rs.getString("BookTitle");
            String yearPublished = rs.getString("YearPublished");
            String numberPages = rs.getString("NumberOfPages");
            String publisherName = rs.getString("PublisherName");
            String publisherAddress = rs.getString("PublisherAddress");
            String publisherPhone = rs.getString("PublisherPhone");
            String publisherEmail = rs.getString("PublisherEmail");

            System.out.printf("Group Name %-5s\n", dispNull(groupName));
            System.out.printf("Head Writer: %-5s\n", dispNull(headWriter));
            System.out.printf("Year Formed: %-5s\n", yearFormed);
            System.out.printf("Subject: %-5s\n", dispNull(subject));
            System.out.printf("Book Title: %-5s\n", dispNull(bookTitle));
            System.out.printf("Year Published: %-5s\n", yearPublished);
            System.out.printf("Number of Pages: %-5s\n", numberPages);
            System.out.printf("Publisher Name: %-5s\n", dispNull(publisherName));
            System.out.printf("Publisher Address: %-5s\n", dispNull(publisherAddress));
            System.out.printf("Publisher Phone: %-5s\n", dispNull(publisherPhone));
            System.out.printf("Publisher Email: %-5s\n", dispNull(publisherEmail));
            System.out.println();
        }
        System.out.println();
        rs.close();
        ps.close();
        pressAnyKeyToContinue();

    }

    /**
     * displays data related to specified publisher
     * 
     * @throws SQLException 
     */
    public static void displayPublisherData() throws SQLException {
        Scanner in = new Scanner(System.in);
        Connection conn = DriverManager.getConnection(DB_URL);
        String s = "SELECT * from Publishers NATURAL JOIN WritingGroup NATURAL JOIN Books where PublisherName = ?";
        System.out.print("Enter the publisher name: ");
        String pubname = in.nextLine();

        PreparedStatement ps = conn.prepareStatement(s);
        ps.setString(1, pubname);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            String pName = rs.getString("PublisherName");
            String groupName = rs.getString("GroupName");
            String pAddress = rs.getString("PublisherAddress");
            String pPhone = rs.getString("PublisherPhone");
            String pEmail = rs.getString("PublisherEmail");
            String headWriter = rs.getString("HeadWriter");
            String yearFormed = rs.getString("YearFormed");
            String subject = rs.getString("Subject");
            String bookTitle = rs.getString("BookTitle");
            String yearPublished = rs.getString("YearPublished");
            String numOfPages = rs.getString("NumberOfPages");
            
            System.out.printf("Publisher name: %-5s\n", dispNull(pName));
            System.out.printf("Publisher address: %-5s\n", dispNull(pAddress));
            System.out.printf("Publisher phone: %-5s\n", dispNull(pPhone));
            System.out.printf("Publisher email: %-5s\n", dispNull(pEmail));
            System.out.printf("Headwriter name: %-5s\n", dispNull(headWriter));
            System.out.printf("Group name: %-5s\n", dispNull(groupName));
            System.out.printf("Year formed: %-5s\n", dispNull(yearFormed));
            System.out.printf("Subject: %-5s\n", dispNull(subject));
            System.out.printf("Book title: %-5s\n", dispNull(bookTitle));
            System.out.printf("Year published: %-5s\n", dispNull(yearPublished));
            System.out.printf("Number of pages: %-5s\n", dispNull(numOfPages));
            System.out.println();
        }
        System.out.println();
        rs.close();
        ps.close();
        pressAnyKeyToContinue();
    }

    /**
     * displays data related to specified book
     * 
     * @throws SQLException 
     */
    public static void displayBookData() throws SQLException {

        Scanner in = new Scanner(System.in);
        Connection conn = DriverManager.getConnection(DB_URL);
        String s = "SELECT * FROM Books Natural Join WritingGroup NATURAL JOIN Publishers where BookTitle = ? AND GroupName = ?";
        System.out.print("Enter the name of the book: ");
        String book = in.nextLine();
        System.out.print("Enter the group name: ");
        String gname = in.nextLine();
        
        PreparedStatement ps = conn.prepareStatement(s);
        ps.setString(1, book);
        ps.setString(2, gname);
        ResultSet rs = ps.executeQuery();
        System.out.println();
        while(rs.next()){
            String pName = rs.getString("PublisherName");
            String groupName = rs.getString("GroupName");
            String bookTitle = rs.getString("BookTitle");
            String yearPublished = rs.getString("YearPublished");
            String numOfPages = rs.getString("NumberOfPages");
            String headWriter = rs.getString("HeadWriter");
            String yearFormed = rs.getString("YearFormed");
            String subject = rs.getString("Subject");
            String pAddress = rs.getString("PublisherAddress");
            String pPhone = rs.getString("PublisherPhone");
            String pEmail = rs.getString("PublisherEmail");
            
            
            System.out.printf("Group name: %-5s\n", dispNull(groupName));
            System.out.printf("Book title: %-5s\n", dispNull(bookTitle));
            System.out.printf("Number of pages: %-5s\n", dispNull(numOfPages));
            System.out.printf("Year published: %-5s\n", dispNull(yearPublished));
            System.out.printf("Publisher name: %-5s\n", dispNull(pName));
            System.out.printf("Headwriter name: %-5s\n", dispNull(headWriter));
            System.out.printf("Year formed: %-5s\n", dispNull(yearFormed));
            System.out.printf("Subject: %-5s\n", dispNull(subject));
            System.out.printf("Publisher address: %-5s\n", dispNull(pAddress));
            System.out.printf("Publisher phone: %-5s\n", dispNull(pPhone));
            System.out.printf("Publisher email: %-5s\n", dispNull(pEmail));
            
        }
        System.out.println();
        ps.close();
        rs.close();
        pressAnyKeyToContinue();

    }

    /**
     * Allows user to enter a new publisher and use that to replace older ones
     * specified
     *
     * @throws SQLException
     */
    public static void updatePublisher() throws SQLException {

        try {
            Scanner in = new Scanner(System.in);
            Connection conn = DriverManager.getConnection(DB_URL);

            String s1 = "SELECT * FROM Publishers WHERE PublisherName = ?";
            System.out.print("Enter old publisher: ");
            String oldpub = in.nextLine();

            System.out.print("Enter new publisher: ");
            String newpub = in.nextLine();

            PreparedStatement p1 = conn.prepareStatement(s1);

            p1.setString(1, oldpub);
            // p1.setString(2, oldpub);

            ResultSet rs = p1.executeQuery();
            int count = 0;
            while (rs.next()) {
                count++;
            }
            if (count == 0) {
                System.out.println("\n**OLD PUBLISHER SPECIFIED DOES NOT EXIST**\n");
                rs.close();
                p1.close();
                pressAnyKeyToContinue();
            } else {
                p1.setString(1, newpub);
                rs = p1.executeQuery();
                count = 0;
                while (rs.next()) {
                    count++;
                }
                if (count == 0) {
                    System.out.println("\n**NEW PUBLISHER SPECIFIED DOES NOT EXIST**\n");
                    p1.close();
                    rs.close();
                    pressAnyKeyToContinue();
                } else {

                    String s = "UPDATE Books SET PublisherName = ? WHERE PublisherName = ?";
                    PreparedStatement p = conn.prepareStatement(s);

                    p.setString(1, newpub);
                    p.setString(2, oldpub);
                    p.executeUpdate();

                    System.out.println("Publishers updated!\n");
                    p.close();
                    rs.close();
                    pressAnyKeyToContinue();
                }
            }

        } catch (SQLException se) {
            System.out.println("ERROR");
        }
    }

    /**
     * displays book titles
     */
    public static void displayBookTitles() {
        try {
            Connection conn = DriverManager.getConnection(DB_URL);
            Statement stmt = conn.createStatement();
            String sql = "SELECT BookTitle FROM Books";
            ResultSet rs = stmt.executeQuery(sql);
            System.out.println("\nBooks\n---------------------");
            while (rs.next()) {
                String btitle = rs.getString("BookTitle");
                System.out.println(btitle);
            }
            System.out.println();
            rs.close();
            pressAnyKeyToContinue();
        } catch (SQLException se) {

        }
    }

    /**
     * method used to allow the user to press any key to continue
     */
    public static void pressAnyKeyToContinue() {
        System.out.println("Press Enter to continue...");
        try {
            System.in.read();
        } catch (Exception e) {
        }
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

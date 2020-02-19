package control;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.DataSource;

import model.GameBean;
import model.GameDS;
import model.UserDS;

@WebServlet("/upload")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
maxFileSize=1024*1024*10,      // 10MB
maxRequestSize=1024*1024*50)
public class UploadGame extends HttpServlet {
	
	private static final String SAVE_DIR="AppImages";
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//PrintWriter out = response.getWriter();
		
		String savePath = "C:\\Users\\giuse\\OneDrive\\Desktop\\AppImages";
		
	    String title = request.getParameter("title");
	    String desc = request.getParameter("descGioco");
	    String selectedCategory = "";
	    
	  //Upload della cover
	    Part filePart = request.getPart("cover"); // Retrieves <input type="file" name="cover">
	    String coverFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); 
	    //InputStream fileContent = filePart.getInputStream();
	    filePart.write(savePath + File.separator + coverFileName);
	    
	  //Upload dell'icon
	    Part filePart1 = request.getPart("icon"); // Retrieves <input type="file" name="icon">
	    String iconFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); 
	    //InputStream fileContent1 = filePart.getInputStream();
	    filePart1.write(savePath + File.separator + iconFileName);
	    
	    double price = Double.parseDouble(request.getParameter("price"));
	    int selectedItem = Integer.parseInt(request.getParameter("Categories"));
	    
	    switch(selectedItem) {
	    	case 1: selectedCategory = "Action";
	    		break;
	    	case 2: selectedCategory = "FPS";
	    		break;
	    	case 3: selectedCategory = "Adventure";
    			break;
	    	case 4: selectedCategory = "Puzzle";
    			break;
	    	case 5: selectedCategory = "Arcade";
    			break;
	    }
	    
	    GameBean gb = new GameBean(title, desc, price, coverFileName, iconFileName, selectedCategory);
	    DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		GameDS gameDS = new GameDS(ds);
		
		try {
			gameDS.doSave(gb);
		} catch(SQLException e) {
			System.out.println("Error:" + e.getMessage());
			response.sendError(500);
		}
	}
}

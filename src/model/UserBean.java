package model;

import java.util.HashMap;

public class UserBean {
	public int userID;
	public String username;
	public String email;
	public String password;
	public static enum tipoUtente {User, Developer, Admin}
	tipoUtente userType;
	
	public UserBean() {
		super();
	}
	
	public UserBean(HashMap<String, String> userData) { // Costruttore chiamato dopo aver effettuato la validazione dei dati dal form di registrazione. Crea l'userBean e lo carica nel database.

		setUsername(userData.get("username"));
		setEmail(userData.get("email"));
		setPassword(userData.get("password"));
		String userTypeID = userData.get("developer");
		if(userTypeID != null) {
			if(!userTypeID.equals("1")) { // Solo User o Developer sono ammessi come valore nel costruttore, per evitare che una richiesta forgiata ad-hoc permetta ad un utente di registrarsi come Admin.
				userTypeID = "0";
			}
			setUserTypeID(userTypeID);
		}
		// TODO il resto dei campi
	}
	/**
	 * @return the userID
	 */
	public int getUserID() {
		return userID;
	}
	/**
	 * @param userID the userID to set
	 */
	public void setUserID(int userID) {
		this.userID = userID;
	}
	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}
	/**
	 * @param username the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	
	
	// User Type ID: Stringhe contenenti un numero, l'ordine conta (minimo: utente normale, massimo: admin). Castate a integer nel filter auth
	/**
	 * @return the userType ID (string)
	 */
	public String getUserTypeID() {
		switch(userType) {
			case User:
				return "0";
			case Developer:
				return "1";
			case Admin:
				return "2";
			default:
				return "0";
		}
	}
	
	static public String getUserTypeValue(tipoUtente t) {
		switch(t) {
			case User:
				return "0";
			case Developer:
				return "1";
			case Admin:
				return "2";
			default:
				return "0";
	}
	}
	/**
	 * @param userTypeID the userTypeID associated to the enum value to set
	 */
	public void setUserTypeID(String userTypeID) {
		switch(userTypeID) {
			case "0":
				this.userType = tipoUtente.User;
				break;
			case "1":
				this.userType = tipoUtente.Developer;
				break;
			case "2":
				this.userType = tipoUtente.Admin;
				break;
			default:
				this.userType = tipoUtente.User;
				break;
		}
	}
	
	public tipoUtente getUserType() {
		return this.userType;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	
	/**
	 *  @param HashMap contenente i parametri dell'utente che hanno bisogno di validazione prima di essere settati
	 */
	public static UserBean validate(HashMap<String, String> userData) { // Attenzione: il validatore ritorna true anche se una key di userData non ha una rispettiva regex! Si assume che tale parametro non viene usato o non richiede validazione.
		boolean pass = true;
		for(String i : userData.keySet()) {
			System.out.println("checking "+i+ " with value "+userData.get(i));
			if(!Validator.matches(i, userData.get(i))) {
				pass = false;
				break;
			}
		}
		if(pass) {
			return new UserBean(userData);
		} else {
			return null;
		}
	}
	@Override
	public String toString() {
		return "UserBean [userID=" + userID + ", username=" + username + ", email=" + email + ", password=" + password
				+ ", userType=" + userType + "]";
	}
}

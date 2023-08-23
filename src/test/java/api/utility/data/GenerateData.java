package api.utility.data;

public class GenerateData {
	
	
	public static String getEmail() {
		String prefix = "tundra_email";
		String provider = "@Ocean.com";		
		int random = (int) (Math.random() * 10000);
		String email = prefix + random + provider; 
		return email;
	}
	/*
	 * Generate Random phone number 10 digit
	 * @return String random phone number
	 */
	public static String getPhoneNumber() {
		String phoneNumber = "2";
		for(int i = 0; i < 9; i++) {
			phoneNumber += (int) (Math.random() * 10);
		}
		return phoneNumber;
	}
	public static void main(String[]args) {
		String number = getPhoneNumber();
		System.out.println(number);
		System.out.println(number.length());
	}
	public static String getUserName() {
		String prefix = "auto_name";
		int random = (int)(Math.random()*10000);
		return prefix.concat(String.valueOf(random));
	}
}
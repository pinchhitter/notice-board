package cdac.in.soochna;

import java.security.MessageDigest;
import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;

public class SHA256Helper {

	private static final int MD5_PASSWORD_LENGTH = 16;

	public static String hashPassword(String password) {

		String hashword = null;
		try {
			MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
			sha256.update( password.getBytes() );

			BigInteger hash = new BigInteger(1, sha256.digest());
			hashword = hash.toString(MD5_PASSWORD_LENGTH);

		} catch (NoSuchAlgorithmException nsae) {
			nsae.printStackTrace();
		}
		return hashword;
	}

	public static void main(String[] args){
		System.out.println( SHA256Helper.hashPassword( args[0].trim() ) );
	}
}

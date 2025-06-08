/**
 * @description This class implements the ULID spec in Apex.
 * You can find that standard here: https://github.com/ulid/spec
 * ULID === Universally Unique Lexicographically Sortable Identifier
 * Think of them as a UUIDv4, but sortable. Similar to UUIDv7.
 * These are, effectively a universally unique identifier
 * but one that is *sortable*.
 *
 * This class is a port of the Javascript ULID
 * reference implementation.
 */
public with sharing class ULID {
	/**
	 * @description This character set is the complete list of allowed characters in
	 * a ULID string. It intentionally does not include characters that
	 * may be ambiguously read, such as i, l, o, and u characters.
	 */
	private static final List<String> CHARACTER_SET = new List<String>{
		'0',
		'1',
		'2',
		'3',
		'4',
		'5',
		'6',
		'7',
		'8',
		'9',
		'A',
		'B',
		'C',
		'D',
		'E',
		'F',
		'G',
		'H',
		'J',
		'K',
		'M',
		'N',
		'P',
		'Q',
		'R',
		'S',
		'T',
		'V',
		'W',
		'X',
		'Y',
		'Z'
	};
	// Calculate this once per transaction to avoid unnecessary math
	private static final Long CHARACTER_SET_SIZE = CHARACTER_SET.size();
	// This is equal to 2^48-1 and represents the max timestamp allowed in a ULID string
	// private static final Long MAXTIME = 281474976710655L;
	// This is the number of digits to encode the timestamp into.
	private static final Long TIME_LENGTH = 10;
	// This is the number of digits of random character to generate
	private static final Integer RANDOM_LENGTH = 16;

	/**
	 * @description Generates a ULID string according to spec.
	 * https://github.com/ulid/spec
	 * @return  `String`
	 */
	public static String generate() {
		return encodeTimestamp(Datetime.now().getTime(), TIME_LENGTH) +
			generateRandomString(RANDOM_LENGTH);
	}

	/**
	 * @description Encodes a given timestamp into characters from
	 * the acceptable character set above.
	 * @param dtSeed long form of Timestamp to encode
	 * @param timeLength how many characters of the timestamp to encode
	 * @return  `String`
	 */
	@SuppressWarnings('PMD.UnusedLocalVariable')
	private static String encodeTimestamp(Long dtSeed, Long timeLength) {
		Long modulo;
		String retString = '';
		for (Long l = timeLength; timeLength > 0; timeLength--) {
			modulo = Math.mod(dtSeed, CHARACTER_SET_SIZE);
			retString = CHARACTER_SET[modulo.intValue()] + retString;
			dtSeed = (dtSeed - modulo) / CHARACTER_SET_SIZE;
		}
		return retString;
	}

	/**
	 * @description generates a random string from the character set
	 * of a given length.
	 *
	 * @param length Integer length of the string to generate
	 *
	 * @return `String`
	 */
	private static String generateRandomString(Integer length) {
		Integer[] retString = new List<Integer>(length);
		for (Integer l = 0; l < length; l++) {
			retString[l] = fetchRandomCharacterFromCharacterSet().charAt(0);
		}
		return String.fromCharArray(retString);
	}

	/**
	 * @description pulls a random character from the character set.
	 * @return  `String`
	 */
	private static String fetchRandomCharacterFromCharacterSet() {
		Long rand = Math.mod(Math.abs(Crypto.getRandomLong()), CHARACTER_SET_SIZE);
		return CHARACTER_SET[rand.intValue()];
	}
}

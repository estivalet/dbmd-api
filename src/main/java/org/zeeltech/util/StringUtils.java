package org.zeeltech.util;

/*
 * General Tools - Digital Howler Entertainment
 * Copyright (C) 2008 L.F.Estivalet <luizfernando_estivalet@yahoo.com>
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>
 *
 */

/*
 * Created on Jul 22, 2009 at 11:29:11 PM by luisoft
 */

/**
 * @author luisoft
 * 
 */
public abstract class StringUtils {

	/**
	 * Counts number of occurrences of the char in the string.
	 * 
	 * @param s
	 *            String to be processed.
	 * @param c
	 *            Char to be count.
	 * @return Number of occurrences of char <i>c</i> in string <i>s</i>.
	 */
	public static int countChars(String s, char c) {
		int count = 0;
		for (int i = 0; i < s.length(); i++) {
			if (s.charAt(i) == c) {
				count++;
			}
		}
		return count;
	}

	/**
	 * Create a string by repeating a specific char n times. An optional delimiter
	 * can be used.
	 * 
	 * @param c
	 *            Char to repeat.
	 * @param ntimes
	 *            Number of times char will appear in the final string.
	 * @param delimiter
	 *            Optional delimiter to place between chars.
	 * @return String with char repeated n times.
	 */
	public static String repeatChar(char c, int ntimes, String delimiter) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < ntimes; i++) {
			sb.append((delimiter != null && i > 0) ? delimiter + c : c);
		}
		return sb.toString();
	}

	/**
	 * Capitalizes a string.
	 * 
	 * @param s
	 *            String to be capitalized.
	 * @return Capitalized string.
	 */
	public static String capitalize(String s) {
		return s.substring(0, 1).toUpperCase() + s.substring(1);
	}

	/**
	 * Convert a string to camel case pattern. The string will be split using "_"
	 * character.
	 * 
	 * @param s
	 *            The string to be converted.
	 * @return String in camel case format.
	 */
	public static String toCamelCase(String s) {
		return toCamelCase(s, false);
	}

	/**
	 * Check if a string represent a "true" value.
	 * 
	 * @param s
	 *            The string to test.
	 * @return boolean if string is "Y" or "YES" or "TRUE".
	 */
	public static Boolean isTrue(String s) {
		if (s == null || "".equals(s)) {
			return false;
		}
		return "YES".equals(s.toUpperCase()) || "Y".equals(s.toUpperCase()) || "TRUE".equals(s.toUpperCase());
	}

	/**
	 * Convert a string to camel case pattern. The string will be split using "_"
	 * character.
	 * 
	 * @param s
	 *            The string to be converted.
	 * @param capitalize
	 *            If <code>true</code> then the first character will be in upper
	 *            case, otherwise will be in lower case (camel case default).
	 * @return String in camel case format.
	 */
	public static String toCamelCase(String s, boolean capitalize) {
		StringBuffer sb = new StringBuffer();
		String[] str = s.split("_");
		boolean firstTime = true;
		for (String temp : str) {
			if (firstTime) {
				if (capitalize) {
					sb.append(Character.toUpperCase(temp.charAt(0)));
					sb.append(temp.substring(1).toLowerCase());
				} else {
					sb.append(temp.toLowerCase());
				}
				firstTime = false;
			} else {
				sb.append(Character.toUpperCase(temp.charAt(0)));
				sb.append(temp.substring(1).toLowerCase());
			}
		}
		return sb.toString();
	}

	/**
	 * Convert a string to a more human readable format. The string will be split
	 * using "_" character. Basically it removes the "_" character and capitalize
	 * all words.
	 * 
	 * @param s
	 *            The string to be converted.
	 * @return String in human readble format
	 */
	public static String toHumanReadble(String s) {
		StringBuffer sb = new StringBuffer();
		String[] str = s.split("_");
		for (String temp : str) {
			sb.append(Character.toUpperCase(temp.charAt(0)));
			sb.append(temp.substring(1).toLowerCase());
			sb.append(" ");
		}
		return sb.toString().trim();
	}

	public static String uncapitalize(String str) {
		int strLen = str.length();
		if (str == null || strLen == 0) {
			return str;
		}
		return new StringBuffer(strLen).append(Character.toLowerCase(str.charAt(0))).append(str.substring(1))
				.toString();
	}
}
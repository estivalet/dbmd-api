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
 * Created on 03/08/2009 at 10:35:59 by 88758559000
 */
package org.zeeltech.util;

import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author 88758559000
 * 
 */
public class IOUtil {

    private static final Logger LOGGER = Logger.getLogger(IOUtil.class.getName());

    /**
     * Reads the stream fully, and returns a byte array of data.
     * 
     * @param stream
     *            Stream to read.
     * @return Byte array
     */
    public static String readFully(final InputStream stream) {
        if (stream == null) {
            LOGGER.log(Level.WARNING, "Cannot read null input stream", new IOException("Cannot read null input stream"));
            return "";
        }

        final StringBuilder out = new StringBuilder();

        try {
            final char[] buffer = new char[0x10000];
            final Reader reader = new InputStreamReader(stream, "UTF-8");
            int read;
            do {
                read = reader.read(buffer, 0, buffer.length);
                if (read > 0) {
                    out.append(buffer, 0, read);
                }
            } while (read >= 0);
        } catch (final UnsupportedEncodingException e) {
            LOGGER.log(Level.WARNING, e.getMessage(), e);
        } catch (final IOException e) {
            LOGGER.log(Level.WARNING, "Could not read stream", e);
        }

        return out.toString();
    }

    public static boolean createDir(String dir) {
        return createDir(dir, false);
    }

    public static boolean createDir(String dir, boolean deleteContents) {
        File f = new File(dir);
        if (deleteContents) {
            deleteDir(f);
        }
        return f.mkdirs();
    }

    // Deletes all files and subdirectories under dir.
    // Returns true if all deletions were successful.
    // If a deletion fails, the method stops attempting to delete and returns
    // false.
    public static boolean deleteDir(File dir) {
        if (dir.isDirectory()) {
            String[] children = dir.list();
            for (int i = 0; i < children.length; i++) {
                boolean success = deleteDir(new File(dir, children[i]));
                if (!success) {
                    return false;
                }
            }
        }

        // The directory is now empty so delete it
        return dir.delete();
    }

    public static void write(String fullPath, String contents) {
        // Extract base path and file name.
        String basePath = fullPath.substring(0, fullPath.lastIndexOf("/"));
        String fileName = fullPath.substring(fullPath.lastIndexOf("/") + 1);
        write(basePath, fileName, contents);
    }

    public static void write(String basePath, String fileName, String contents) {
        BufferedWriter bw = null;
        try {
            createDir(basePath);
            File f = new File(basePath + "/" + fileName);
            f.createNewFile();
            bw = new BufferedWriter(new FileWriter(basePath + "/" + fileName));
            bw.write(contents);
            bw.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                bw.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    /**
     * This function will copy files or directories from one location to another. note that the source and the destination must be mutually exclusive. This function can not be used to copy a directory
     * to a sub directory of itself. The function will also have problems if the destination files already exist.
     * 
     * Got from http://www.dreamincode.net/code/snippet1443.htm
     * 
     * @param src
     *            A File object that represents the source for the copy
     * @param dest
     *            A File object that represents the destination for the copy.
     * @throws IOException
     *             if unable to copy.
     */
    public static void copyFiles(File src, File dest, boolean hiddenFiles) throws IOException {
        // Check to ensure that the source is valid...
        if (!src.exists()) {
            throw new IOException("copyFiles: Can not find source: " + src.getAbsolutePath() + ".");
        } else if (!src.canRead()) { // check to ensure we have rights to the
            // source...
            throw new IOException("copyFiles: No right to source: " + src.getAbsolutePath() + ".");
        }
        // is this a directory copy?
        if (src.isDirectory()) {
            if (!src.isHidden() && !hiddenFiles) {
                if (!dest.exists()) { // does the destination already exist?
                    // if not we need to make it exist if possible (note this is
                    // mkdirs not mkdir)
                    if (!dest.mkdirs()) {
                        throw new IOException("copyFiles: Could not create direcotry: " + dest.getAbsolutePath() + ".");
                    }
                }
                // get a listing of files...
                String list[] = src.list();
                // copy all the files in the list.
                for (int i = 0; i < list.length; i++) {
                    File dest1 = new File(dest, list[i]);
                    File src1 = new File(src, list[i]);
                    copyFiles(src1, dest1, hiddenFiles);
                }
            }
        } else {
            // This was not a directory, so lets just copy the file
            FileInputStream fin = null;
            FileOutputStream fout = null;
            // Buffer 4K at a time (you can change this).
            byte[] buffer = new byte[4096];
            int bytesRead;
            try {
                // open the files for input and output
                fin = new FileInputStream(src);
                fout = new FileOutputStream(dest);
                while ((bytesRead = fin.read(buffer)) >= 0) {
                    fout.write(buffer, 0, bytesRead);
                }
            } catch (IOException e) { // Error copying file...
                IOException wrapper = new IOException("copyFiles: Unable to copy file: " + src.getAbsolutePath() + "to" + dest.getAbsolutePath() + ".");
                wrapper.initCause(e);
                wrapper.setStackTrace(e.getStackTrace());
                throw wrapper;
            } finally { // Ensure that the files are closed (if they were
                // open).
                if (fin != null) {
                    fin.close();
                }
                if (fout != null) {
                    fout.close();
                }
            }
        }
    }

    public static void write(byte[] aInput, String aOutputFileName) {
        try {
            OutputStream output = null;
            try {
                output = new BufferedOutputStream(new FileOutputStream(aOutputFileName));
                output.write(aInput);
            } finally {
                output.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}

package com.example.cinequest.util;

public class FileUtil {
    private FileUtil() {}

    public static String getFileExtension(String filename) {
        int lastIndexOfDot = filename.lastIndexOf(".");
        if (lastIndexOfDot == -1) {
            return "";
        }
        return filename.substring(lastIndexOfDot);
    }
}

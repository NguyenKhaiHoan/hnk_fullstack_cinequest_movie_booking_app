package com.example.cinequest.util;

import java.io.ByteArrayOutputStream;
import java.util.zip.Deflater;
import java.util.zip.Inflater;

import com.example.cinequest.exception.CinequestApiException;
import com.example.cinequest.exception.ApiResponseCode;

public class ImageUtil {

    public static byte[] compressImage(byte[] data) throws CinequestApiException {
        Deflater deflater = new Deflater();
        deflater.setLevel(Deflater.BEST_COMPRESSION);
        deflater.setInput(data);
        deflater.finish();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream(data.length);
        byte[] tmp = new byte[4 * 1024];
        while (!deflater.finished()) {
            int size = deflater.deflate(tmp);
            outputStream.write(tmp, 0, size);
        }
        try {
            outputStream.close();
        } catch (Exception e) {
            throw new CinequestApiException(false, ApiResponseCode.IMAGE_COMPRESSION_ERROR.getStatusCode(),
                    ApiResponseCode.IMAGE_COMPRESSION_ERROR.getHttpStatusCode(),
                    ApiResponseCode.IMAGE_COMPRESSION_ERROR.getStatusMessage());
        }
        return outputStream.toByteArray();
    }

    public static byte[] decompressImage(byte[] data) throws CinequestApiException {
        Inflater inflater = new Inflater();
        inflater.setInput(data);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream(data.length);
        byte[] tmp = new byte[4 * 1024];

        try {
            while (!inflater.finished()) {
                int count = inflater.inflate(tmp);
                outputStream.write(tmp, 0, count);
            }
            outputStream.close();
        } catch (Exception exception) {
            throw new CinequestApiException(false, ApiResponseCode.IMAGE_DECOMPRESSION_ERROR.getStatusCode(),
                    ApiResponseCode.IMAGE_DECOMPRESSION_ERROR.getHttpStatusCode(),
                    ApiResponseCode.IMAGE_DECOMPRESSION_ERROR.getStatusMessage());
        }

        return outputStream.toByteArray();
    }
}

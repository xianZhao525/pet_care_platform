package com.petplatform.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class FileUploadUtil {

    private static final String UPLOAD_DIR = "uploads/";
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
    private static final String[] ALLOWED_EXTENSIONS = {
            "jpg", "jpeg", "png", "gif", "bmp", "webp"
    };

    /**
     * 上传文件
     */
    public static String uploadFile(MultipartFile file, String subDir) throws IOException {
        // 验证文件
        validateFile(file);

        // 创建上传目录
        String uploadPath = UPLOAD_DIR + subDir + "/";
        File dir = new File(uploadPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 生成文件名
        String originalFilename = file.getOriginalFilename();
        String fileExtension = getFileExtension(originalFilename);
        String newFilename = generateFilename(fileExtension);

        // 保存文件
        File dest = new File(uploadPath + newFilename);
        file.transferTo(dest);

        return "/" + uploadPath + newFilename;
    }

    /**
     * 删除文件
     */
    public static boolean deleteFile(String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return false;
        }

        // 移除URL前缀
        if (filePath.startsWith("/")) {
            filePath = filePath.substring(1);
        }

        File file = new File(filePath);
        if (file.exists()) {
            return file.delete();
        }
        return false;
    }

    /**
     * 验证文件
     */
    private static void validateFile(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            throw new IOException("文件不能为空");
        }

        if (file.getSize() > MAX_FILE_SIZE) {
            throw new IOException("文件大小不能超过10MB");
        }

        String originalFilename = file.getOriginalFilename();
        String fileExtension = getFileExtension(originalFilename);

        boolean allowed = false;
        for (String ext : ALLOWED_EXTENSIONS) {
            if (ext.equalsIgnoreCase(fileExtension)) {
                allowed = true;
                break;
            }
        }

        if (!allowed) {
            throw new IOException("不支持的文件类型: " + fileExtension);
        }
    }

    /**
     * 获取文件扩展名
     */
    private static String getFileExtension(String filename) {
        if (filename == null || filename.lastIndexOf(".") == -1) {
            return "";
        }
        return filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
    }

    /**
     * 生成唯一文件名
     */
    private static String generateFilename(String extension) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String timestamp = sdf.format(new Date());
        String random = UUID.randomUUID().toString().substring(0, 8);
        return timestamp + "_" + random + "." + extension;
    }

    /**
     * 获取文件大小（格式化）
     */
    public static String formatFileSize(long size) {
        if (size < 1024) {
            return size + " B";
        } else if (size < 1024 * 1024) {
            return String.format("%.2f KB", size / 1024.0);
        } else if (size < 1024 * 1024 * 1024) {
            return String.format("%.2f MB", size / (1024.0 * 1024.0));
        } else {
            return String.format("%.2f GB", size / (1024.0 * 1024.0 * 1024.0));
        }
    }
}